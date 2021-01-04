#include "llvm/Target/TargetMachine.h"


namespace llvm {



    class ZZTTTargetMachine : public LLVMTargetMachine {
    public:

        ZZTTTargetMachine(const Target &T, const Triple &TT, StringRef CPU,
                          StringRef FS, const TargetOptions &Options,
                          Reloc::Model, CodeModel::Model CM,
                          CodeGenOpt::Level OL);

        TargetTransformInfo getTargetTransformInfo(const Function &F) override;
        TargetPassConfig *createPassConfig(PassManagerBase &PM) override;
    }


}
