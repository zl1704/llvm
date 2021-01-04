//
// Created by zl on 2020/7/24.
//

#include "ZZTTTargetMachine.h"

using namespace llvm;


static std::string computeDataLayout(const Triple &TT) {
    // X86 is little endian
    std::string Ret = "e";

    Ret += DataLayout::getManglingComponent(TT);
    // X86 and x32 have 32 bit pointers.
    if ((TT.isArch64Bit() &&
         (TT.getEnvironment() == Triple::GNUX32 || TT.isOSNaCl())) ||
        !TT.isArch64Bit())
        Ret += "-p:32:32";

    // Some ABIs align 64 bit integers and doubles to 64 bits, others to 32.
    if (TT.isArch64Bit() || TT.isOSWindows() || TT.isOSNaCl())
        Ret += "-i64:64";
    else if (TT.isOSIAMCU())
        Ret += "-i64:32-f64:32";
    else
        Ret += "-f64:32:64";

    // Some ABIs align long double to 128 bits, others to 32.
    if (TT.isOSNaCl() || TT.isOSIAMCU()); // No f80
    else if (TT.isArch64Bit() || TT.isOSDarwin())
        Ret += "-f80:128";
    else
        Ret += "-f80:32";

    if (TT.isOSIAMCU())
        Ret += "-f128:32";

    // The registers can hold 8, 16, 32 or, in x86-64, 64 bits.
    if (TT.isArch64Bit())
        Ret += "-n8:16:32:64";
    else
        Ret += "-n8:16:32";

    // The stack is aligned to 32 bits on some ABIs and 128 bits on others.
    if ((!TT.isArch64Bit() && TT.isOSWindows()) || TT.isOSIAMCU())
        Ret += "-a:0:32-S32";
    else
        Ret += "-S128";

    return Ret;
}


ZZTTTargetMachine::ZZTTTargetMachine(const Target &T, const Triple &TT, StringRef CPU,
                                     StringRef FS, const TargetOptions &Options,
                                     Reloc::Model, CodeModel::Model CM,
                                     CodeGenOpt::Level OL)
        : LLVMTargetMachine(T, computeDataLayout(TT), TT, CPU, FS, Options, RM, OL) {
    initAsmInfo();

}

TargetTransformInfo ZZTTTargetMachine::getTargetTransformInfo(const Function &F) {
    return TargetTransformInfo();
}

TargetPassConfig *ZZTTTargetMachine::createPassConfig(PassManagerBase &PM) {
    return nullptr;
}
