Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A977F5779
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:44:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YI-0006ZG-Kh; Wed, 22 Nov 2023 23:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xx-0006Ns-01
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:38 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xt-0006AI-DT
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:36 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b52360cdf0so282937b6e.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714552; x=1701319352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QBUYGi1dCGuCWeKJkTo8B8CyzeEK53NkIvMTOE0ZEA=;
 b=WvYHzCuDyGqhGq40wOLVix4Sv8b+hK7I2sqaWcJAvVgsQURg0N2LLnQXaKax2ogRqK
 5P234hj6bbr/LsXdpvw9fWZ9XLLzJ9BTonqcUMrH8GGyy/wnZ/+smBWv6vgCPuDfGKMv
 43EbvDK/3ZFykJajb6Syo+kkVkzga8tUPQeLxmBdeWUIfB36pYW6xvNW7RrqgaEGZ80k
 3MR11LeYM6cHI4weAY/5wOQwX68JU/supEke+YoyI4Nak4fk9e25B7MKRh32KMTxPcDI
 JH4NxMHXkGaawQOdLokj/hEi6VCCqbhasAfdKEYh52sHJGKX7WCfmklkb3RZJhUCADtF
 cmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714552; x=1701319352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QBUYGi1dCGuCWeKJkTo8B8CyzeEK53NkIvMTOE0ZEA=;
 b=VjH2rXRc1l76ELhs+0jFY4TkYzH8o+xzNl+fBKn6y/m+9Lc2sZfbuHY+/H566XRlAh
 2AjKBJuRIJsgzWQ11xllciUTG+5G9J645ctsf91jOT4yOzWNMF++ydZqPnvOOqoVQShL
 LWfqF9GscfSnAxeDaeiuYTCRFigC78adtn19RwiMEBhD7OYIQ4A6Str7AEBpFLznM24u
 Lvq+UxiI8TTBby2A9jG+P+j2FptvvRSkiQCxjcHO6bCRAl05d2FzEA8EZag7j8UgscKS
 iDDSUu8+o/npRY8ApOhn5VZEaK6ZKFVIf/eAAxork6On3kTWPNvFi+WWeZzNaPQkt0Iw
 uc/A==
X-Gm-Message-State: AOJu0YyT0GEHi4Em33gVgqRHY8mBbXl7fx6gX9ET1iawLPufdd0LygP8
 FB/zSywDHF7ZPaboHsciSaWoSpHNr2/PAeSFPFHyDg/C
X-Google-Smtp-Source: AGHT+IEn/xj0wJoxiDUKzCxFN13KmiQLwU8/QOhQB01TGgIOM/MQQx7WXhktSRgb924YQ5kIHajInQ==
X-Received: by 2002:a05:6808:1383:b0:3ab:83fe:e182 with SMTP id
 c3-20020a056808138300b003ab83fee182mr5257542oiw.1.1700714551802; 
 Wed, 22 Nov 2023 20:42:31 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/21] target/arm/kvm: Move kvm_arm_get_host_cpu_features and
 unexport
Date: Wed, 22 Nov 2023 22:42:08 -0600
Message-Id: <20231123044219.896776-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h |  22 ----
 target/arm/kvm.c     | 265 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm64.c   | 254 -----------------------------------------
 3 files changed, 265 insertions(+), 276 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 58c087207f..e59d713973 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -214,28 +214,6 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
  */
 void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
 
-/**
- * ARMHostCPUFeatures: information about the host CPU (identified
- * by asking the host kernel)
- */
-typedef struct ARMHostCPUFeatures {
-    ARMISARegisters isar;
-    uint64_t features;
-    uint32_t target;
-    const char *dtb_compatible;
-} ARMHostCPUFeatures;
-
-/**
- * kvm_arm_get_host_cpu_features:
- * @ahcf: ARMHostCPUClass to fill in
- *
- * Probe the capabilities of the host kernel's preferred CPU and fill
- * in the ARMHostCPUClass struct accordingly.
- *
- * Returns true on success and false otherwise.
- */
-bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
-
 /**
  * kvm_arm_sve_get_vls:
  * @cs: CPUState
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 84f300c602..ffe0db4293 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -41,6 +41,17 @@ static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
 static bool cap_has_inject_ext_dabt;
 
+/**
+ * ARMHostCPUFeatures: information about the host CPU (identified
+ * by asking the host kernel)
+ */
+typedef struct ARMHostCPUFeatures {
+    ARMISARegisters isar;
+    uint64_t features;
+    uint32_t target;
+    const char *dtb_compatible;
+} ARMHostCPUFeatures;
+
 static ARMHostCPUFeatures arm_host_cpu_features;
 
 int kvm_arm_vcpu_init(CPUState *cs)
@@ -167,6 +178,260 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray)
     }
 }
 
+static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
+{
+    uint64_t ret;
+    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)&ret };
+    int err;
+
+    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
+    err = ioctl(fd, KVM_GET_ONE_REG, &idreg);
+    if (err < 0) {
+        return -1;
+    }
+    *pret = ret;
+    return 0;
+}
+
+static int read_sys_reg64(int fd, uint64_t *pret, uint64_t id)
+{
+    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)pret };
+
+    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
+    return ioctl(fd, KVM_GET_ONE_REG, &idreg);
+}
+
+static bool kvm_arm_pauth_supported(void)
+{
+    return (kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
+            kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
+}
+
+static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+{
+    /* Identify the feature bits corresponding to the host CPU, and
+     * fill out the ARMHostCPUClass fields accordingly. To do this
+     * we have to create a scratch VM, create a single CPU inside it,
+     * and then query that CPU for the relevant ID registers.
+     */
+    int fdarray[3];
+    bool sve_supported;
+    bool pmu_supported = false;
+    uint64_t features = 0;
+    int err;
+
+    /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
+     * we know these will only support creating one kind of guest CPU,
+     * which is its preferred CPU type. Fortunately these old kernels
+     * support only a very limited number of CPUs.
+     */
+    static const uint32_t cpus_to_try[] = {
+        KVM_ARM_TARGET_AEM_V8,
+        KVM_ARM_TARGET_FOUNDATION_V8,
+        KVM_ARM_TARGET_CORTEX_A57,
+        QEMU_KVM_ARM_TARGET_NONE
+    };
+    /*
+     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
+     * to use the preferred target
+     */
+    struct kvm_vcpu_init init = { .target = -1, };
+
+    /*
+     * Ask for SVE if supported, so that we can query ID_AA64ZFR0,
+     * which is otherwise RAZ.
+     */
+    sve_supported = kvm_arm_sve_supported();
+    if (sve_supported) {
+        init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
+    }
+
+    /*
+     * Ask for Pointer Authentication if supported, so that we get
+     * the unsanitized field values for AA64ISAR1_EL1.
+     */
+    if (kvm_arm_pauth_supported()) {
+        init.features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
+                             1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
+    }
+
+    if (kvm_arm_pmu_supported()) {
+        init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
+        pmu_supported = true;
+    }
+
+    if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
+        return false;
+    }
+
+    ahcf->target = init.target;
+    ahcf->dtb_compatible = "arm,arm-v8";
+
+    err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
+                         ARM64_SYS_REG(3, 0, 0, 4, 0));
+    if (unlikely(err < 0)) {
+        /*
+         * Before v4.15, the kernel only exposed a limited number of system
+         * registers, not including any of the interesting AArch64 ID regs.
+         * For the most part we could leave these fields as zero with minimal
+         * effect, since this does not affect the values seen by the guest.
+         *
+         * However, it could cause problems down the line for QEMU,
+         * so provide a minimal v8.0 default.
+         *
+         * ??? Could read MIDR and use knowledge from cpu64.c.
+         * ??? Could map a page of memory into our temp guest and
+         *     run the tiniest of hand-crafted kernels to extract
+         *     the values seen by the guest.
+         * ??? Either of these sounds like too much effort just
+         *     to work around running a modern host kernel.
+         */
+        ahcf->isar.id_aa64pfr0 = 0x00000011; /* EL1&0, AArch64 only */
+        err = 0;
+    } else {
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
+                              ARM64_SYS_REG(3, 0, 0, 4, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
+                              ARM64_SYS_REG(3, 0, 0, 4, 5));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
+                              ARM64_SYS_REG(3, 0, 0, 5, 0));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
+                              ARM64_SYS_REG(3, 0, 0, 5, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar0,
+                              ARM64_SYS_REG(3, 0, 0, 6, 0));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
+                              ARM64_SYS_REG(3, 0, 0, 6, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar2,
+                              ARM64_SYS_REG(3, 0, 0, 6, 2));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
+                              ARM64_SYS_REG(3, 0, 0, 7, 0));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
+                              ARM64_SYS_REG(3, 0, 0, 7, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
+                              ARM64_SYS_REG(3, 0, 0, 7, 2));
+
+        /*
+         * Note that if AArch32 support is not present in the host,
+         * the AArch32 sysregs are present to be read, but will
+         * return UNKNOWN values.  This is neither better nor worse
+         * than skipping the reads and leaving 0, as we must avoid
+         * considering the values in every case.
+         */
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr0,
+                              ARM64_SYS_REG(3, 0, 0, 1, 0));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr1,
+                              ARM64_SYS_REG(3, 0, 0, 1, 1));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
+                              ARM64_SYS_REG(3, 0, 0, 1, 2));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
+                              ARM64_SYS_REG(3, 0, 0, 1, 4));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
+                              ARM64_SYS_REG(3, 0, 0, 1, 5));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr2,
+                              ARM64_SYS_REG(3, 0, 0, 1, 6));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
+                              ARM64_SYS_REG(3, 0, 0, 1, 7));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
+                              ARM64_SYS_REG(3, 0, 0, 2, 0));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
+                              ARM64_SYS_REG(3, 0, 0, 2, 1));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar2,
+                              ARM64_SYS_REG(3, 0, 0, 2, 2));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar3,
+                              ARM64_SYS_REG(3, 0, 0, 2, 3));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar4,
+                              ARM64_SYS_REG(3, 0, 0, 2, 4));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
+                              ARM64_SYS_REG(3, 0, 0, 2, 5));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
+                              ARM64_SYS_REG(3, 0, 0, 2, 6));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
+                              ARM64_SYS_REG(3, 0, 0, 2, 7));
+
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
+                              ARM64_SYS_REG(3, 0, 0, 3, 0));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
+                              ARM64_SYS_REG(3, 0, 0, 3, 1));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
+                              ARM64_SYS_REG(3, 0, 0, 3, 2));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr2,
+                              ARM64_SYS_REG(3, 0, 0, 3, 4));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr1,
+                              ARM64_SYS_REG(3, 0, 0, 3, 5));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr5,
+                              ARM64_SYS_REG(3, 0, 0, 3, 6));
+
+        /*
+         * DBGDIDR is a bit complicated because the kernel doesn't
+         * provide an accessor for it in 64-bit mode, which is what this
+         * scratch VM is in, and there's no architected "64-bit sysreg
+         * which reads the same as the 32-bit register" the way there is
+         * for other ID registers. Instead we synthesize a value from the
+         * AArch64 ID_AA64DFR0, the same way the kernel code in
+         * arch/arm64/kvm/sys_regs.c:trap_dbgidr() does.
+         * We only do this if the CPU supports AArch32 at EL1.
+         */
+        if (FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL1) >= 2) {
+            int wrps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, WRPS);
+            int brps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, BRPS);
+            int ctx_cmps =
+                FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS);
+            int version = 6; /* ARMv8 debug architecture */
+            bool has_el3 =
+                !!FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL3);
+            uint32_t dbgdidr = 0;
+
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, WRPS, wrps);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, BRPS, brps);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, CTX_CMPS, ctx_cmps);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, VERSION, version);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, NSUHD_IMP, has_el3);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, SE_IMP, has_el3);
+            dbgdidr |= (1 << 15); /* RES1 bit */
+            ahcf->isar.dbgdidr = dbgdidr;
+        }
+
+        if (pmu_supported) {
+            /* PMCR_EL0 is only accessible if the vCPU has feature PMU_V3 */
+            err |= read_sys_reg64(fdarray[2], &ahcf->isar.reset_pmcr_el0,
+                                  ARM64_SYS_REG(3, 3, 9, 12, 0));
+        }
+
+        if (sve_supported) {
+            /*
+             * There is a range of kernels between kernel commit 73433762fcae
+             * and f81cb2c3ad41 which have a bug where the kernel doesn't
+             * expose SYS_ID_AA64ZFR0_EL1 via the ONE_REG API unless the VM has
+             * enabled SVE support, which resulted in an error rather than RAZ.
+             * So only read the register if we set KVM_ARM_VCPU_SVE above.
+             */
+            err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64zfr0,
+                                  ARM64_SYS_REG(3, 0, 0, 4, 4));
+        }
+    }
+
+    kvm_arm_destroy_scratch_host_vcpu(fdarray);
+
+    if (err < 0) {
+        return false;
+    }
+
+    /*
+     * We can assume any KVM supporting CPU is at least a v8
+     * with VFPv4+Neon; this in turn implies most of the other
+     * feature bits.
+     */
+    features |= 1ULL << ARM_FEATURE_V8;
+    features |= 1ULL << ARM_FEATURE_NEON;
+    features |= 1ULL << ARM_FEATURE_AARCH64;
+    features |= 1ULL << ARM_FEATURE_PMU;
+    features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
+
+    ahcf->features = features;
+
+    return true;
+}
+
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index fca4864b73..504526b24c 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -143,260 +143,6 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
     }
 }
 
-static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
-{
-    uint64_t ret;
-    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)&ret };
-    int err;
-
-    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
-    err = ioctl(fd, KVM_GET_ONE_REG, &idreg);
-    if (err < 0) {
-        return -1;
-    }
-    *pret = ret;
-    return 0;
-}
-
-static int read_sys_reg64(int fd, uint64_t *pret, uint64_t id)
-{
-    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)pret };
-
-    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
-    return ioctl(fd, KVM_GET_ONE_REG, &idreg);
-}
-
-static bool kvm_arm_pauth_supported(void)
-{
-    return (kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
-            kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
-}
-
-bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
-{
-    /* Identify the feature bits corresponding to the host CPU, and
-     * fill out the ARMHostCPUClass fields accordingly. To do this
-     * we have to create a scratch VM, create a single CPU inside it,
-     * and then query that CPU for the relevant ID registers.
-     */
-    int fdarray[3];
-    bool sve_supported;
-    bool pmu_supported = false;
-    uint64_t features = 0;
-    int err;
-
-    /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
-     * we know these will only support creating one kind of guest CPU,
-     * which is its preferred CPU type. Fortunately these old kernels
-     * support only a very limited number of CPUs.
-     */
-    static const uint32_t cpus_to_try[] = {
-        KVM_ARM_TARGET_AEM_V8,
-        KVM_ARM_TARGET_FOUNDATION_V8,
-        KVM_ARM_TARGET_CORTEX_A57,
-        QEMU_KVM_ARM_TARGET_NONE
-    };
-    /*
-     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
-     * to use the preferred target
-     */
-    struct kvm_vcpu_init init = { .target = -1, };
-
-    /*
-     * Ask for SVE if supported, so that we can query ID_AA64ZFR0,
-     * which is otherwise RAZ.
-     */
-    sve_supported = kvm_arm_sve_supported();
-    if (sve_supported) {
-        init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
-    }
-
-    /*
-     * Ask for Pointer Authentication if supported, so that we get
-     * the unsanitized field values for AA64ISAR1_EL1.
-     */
-    if (kvm_arm_pauth_supported()) {
-        init.features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
-                             1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
-    }
-
-    if (kvm_arm_pmu_supported()) {
-        init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
-        pmu_supported = true;
-    }
-
-    if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
-        return false;
-    }
-
-    ahcf->target = init.target;
-    ahcf->dtb_compatible = "arm,arm-v8";
-
-    err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
-                         ARM64_SYS_REG(3, 0, 0, 4, 0));
-    if (unlikely(err < 0)) {
-        /*
-         * Before v4.15, the kernel only exposed a limited number of system
-         * registers, not including any of the interesting AArch64 ID regs.
-         * For the most part we could leave these fields as zero with minimal
-         * effect, since this does not affect the values seen by the guest.
-         *
-         * However, it could cause problems down the line for QEMU,
-         * so provide a minimal v8.0 default.
-         *
-         * ??? Could read MIDR and use knowledge from cpu64.c.
-         * ??? Could map a page of memory into our temp guest and
-         *     run the tiniest of hand-crafted kernels to extract
-         *     the values seen by the guest.
-         * ??? Either of these sounds like too much effort just
-         *     to work around running a modern host kernel.
-         */
-        ahcf->isar.id_aa64pfr0 = 0x00000011; /* EL1&0, AArch64 only */
-        err = 0;
-    } else {
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
-                              ARM64_SYS_REG(3, 0, 0, 4, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
-                              ARM64_SYS_REG(3, 0, 0, 4, 5));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
-                              ARM64_SYS_REG(3, 0, 0, 5, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
-                              ARM64_SYS_REG(3, 0, 0, 5, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar0,
-                              ARM64_SYS_REG(3, 0, 0, 6, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
-                              ARM64_SYS_REG(3, 0, 0, 6, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar2,
-                              ARM64_SYS_REG(3, 0, 0, 6, 2));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
-                              ARM64_SYS_REG(3, 0, 0, 7, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
-                              ARM64_SYS_REG(3, 0, 0, 7, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
-                              ARM64_SYS_REG(3, 0, 0, 7, 2));
-
-        /*
-         * Note that if AArch32 support is not present in the host,
-         * the AArch32 sysregs are present to be read, but will
-         * return UNKNOWN values.  This is neither better nor worse
-         * than skipping the reads and leaving 0, as we must avoid
-         * considering the values in every case.
-         */
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr0,
-                              ARM64_SYS_REG(3, 0, 0, 1, 0));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr1,
-                              ARM64_SYS_REG(3, 0, 0, 1, 1));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
-                              ARM64_SYS_REG(3, 0, 0, 1, 2));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
-                              ARM64_SYS_REG(3, 0, 0, 1, 4));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
-                              ARM64_SYS_REG(3, 0, 0, 1, 5));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr2,
-                              ARM64_SYS_REG(3, 0, 0, 1, 6));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
-                              ARM64_SYS_REG(3, 0, 0, 1, 7));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
-                              ARM64_SYS_REG(3, 0, 0, 2, 0));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
-                              ARM64_SYS_REG(3, 0, 0, 2, 1));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar2,
-                              ARM64_SYS_REG(3, 0, 0, 2, 2));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar3,
-                              ARM64_SYS_REG(3, 0, 0, 2, 3));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar4,
-                              ARM64_SYS_REG(3, 0, 0, 2, 4));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
-                              ARM64_SYS_REG(3, 0, 0, 2, 5));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
-                              ARM64_SYS_REG(3, 0, 0, 2, 6));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
-                              ARM64_SYS_REG(3, 0, 0, 2, 7));
-
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
-                              ARM64_SYS_REG(3, 0, 0, 3, 0));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
-                              ARM64_SYS_REG(3, 0, 0, 3, 1));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
-                              ARM64_SYS_REG(3, 0, 0, 3, 2));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr2,
-                              ARM64_SYS_REG(3, 0, 0, 3, 4));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr1,
-                              ARM64_SYS_REG(3, 0, 0, 3, 5));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr5,
-                              ARM64_SYS_REG(3, 0, 0, 3, 6));
-
-        /*
-         * DBGDIDR is a bit complicated because the kernel doesn't
-         * provide an accessor for it in 64-bit mode, which is what this
-         * scratch VM is in, and there's no architected "64-bit sysreg
-         * which reads the same as the 32-bit register" the way there is
-         * for other ID registers. Instead we synthesize a value from the
-         * AArch64 ID_AA64DFR0, the same way the kernel code in
-         * arch/arm64/kvm/sys_regs.c:trap_dbgidr() does.
-         * We only do this if the CPU supports AArch32 at EL1.
-         */
-        if (FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL1) >= 2) {
-            int wrps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, WRPS);
-            int brps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, BRPS);
-            int ctx_cmps =
-                FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS);
-            int version = 6; /* ARMv8 debug architecture */
-            bool has_el3 =
-                !!FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL3);
-            uint32_t dbgdidr = 0;
-
-            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, WRPS, wrps);
-            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, BRPS, brps);
-            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, CTX_CMPS, ctx_cmps);
-            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, VERSION, version);
-            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, NSUHD_IMP, has_el3);
-            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, SE_IMP, has_el3);
-            dbgdidr |= (1 << 15); /* RES1 bit */
-            ahcf->isar.dbgdidr = dbgdidr;
-        }
-
-        if (pmu_supported) {
-            /* PMCR_EL0 is only accessible if the vCPU has feature PMU_V3 */
-            err |= read_sys_reg64(fdarray[2], &ahcf->isar.reset_pmcr_el0,
-                                  ARM64_SYS_REG(3, 3, 9, 12, 0));
-        }
-
-        if (sve_supported) {
-            /*
-             * There is a range of kernels between kernel commit 73433762fcae
-             * and f81cb2c3ad41 which have a bug where the kernel doesn't
-             * expose SYS_ID_AA64ZFR0_EL1 via the ONE_REG API unless the VM has
-             * enabled SVE support, which resulted in an error rather than RAZ.
-             * So only read the register if we set KVM_ARM_VCPU_SVE above.
-             */
-            err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64zfr0,
-                                  ARM64_SYS_REG(3, 0, 0, 4, 4));
-        }
-    }
-
-    kvm_arm_destroy_scratch_host_vcpu(fdarray);
-
-    if (err < 0) {
-        return false;
-    }
-
-    /*
-     * We can assume any KVM supporting CPU is at least a v8
-     * with VFPv4+Neon; this in turn implies most of the other
-     * feature bits.
-     */
-    features |= 1ULL << ARM_FEATURE_V8;
-    features |= 1ULL << ARM_FEATURE_NEON;
-    features |= 1ULL << ARM_FEATURE_AARCH64;
-    features |= 1ULL << ARM_FEATURE_PMU;
-    features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
-
-    ahcf->features = features;
-
-    return true;
-}
-
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
     bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
-- 
2.34.1


