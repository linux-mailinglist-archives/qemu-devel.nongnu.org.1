Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CE81907E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWu-0001te-7n; Tue, 19 Dec 2023 14:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWq-0001po-W0
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:21 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWn-0001mF-Q5
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:20 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3365d38dce2so3784423f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013194; x=1703617994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tLIB590q5UqcoLo+DPfnNLtYefVrfy0YSOc9bChAWWk=;
 b=XdvbYTXC/8KYuM086+vLJHbCMDcyqXNuYVf1rmQ9QQW87RN14FJFICe7+Rw4Yuu1Hs
 1a5WEOMKm5fxBerX5sOlVWYOset2o6U9UNMoOYAvqN9oHBKP4Ii2LbOoa95GBHW/E5BO
 fa/2B/yFGZAkQvFV9KCYvZNAKumP4ap7WD49q9oprVbJuchQiwXVUm/GNnz9tYtcvJKu
 wI84EHn2ps394MzUY5jrxOuDe3dde/fgI8LsSqPDEHXSP7C4jnK51DTeQEvCMYWmwKUE
 kb64oDCNLCs/qgVxMQtRTdDwt1ADCAXn3a+G5lLRrLnzJoEQvPLwOWaq8xWiDrndYS/3
 lxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013194; x=1703617994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLIB590q5UqcoLo+DPfnNLtYefVrfy0YSOc9bChAWWk=;
 b=ftjqmvVE0EwSbZlH8Qtd6ZwCukIKSBfoWvfTyAoShvhQhbTyay4jo9bS7vTkVhN1kX
 XKlZO67SRZN+X2MR7iOJpzzrFCoXmpjYRSqgskU6o7GZ9UI9AIcOKYdGWAW9f2yChYlh
 7YNEVBwSZ1p9XKoMPET3UZJK9jGxxYMKlgHvuHF1ptal0WZKhzWRK5Z6EbbE3WQZPLrZ
 ckjJvzKNzuIYh96/JJrPYaYBODBChhQYmM/0jkTWt0Fsbm40ZZa/ZE1W4Hp7q5tmqWyx
 FjTovpeTH2YeVUgy9LfF7O4JzS139gzw/V6Ob7aR1lK4X+ESHr8GuNIAdH8EDhn7xHX9
 83+g==
X-Gm-Message-State: AOJu0YwhuwVE+ObAaPV6m7G3FdDvADN/hSMLrdCUnwnA2VyjMNampRk9
 njQv/A/x711n8z6RxsV9UwmEYviwExYLu0Hdt9I=
X-Google-Smtp-Source: AGHT+IEvk2Gvr+sPfiZ+BNADUE/GYKC5WzkSmvqM104OdZvSLwJZyvMydzqRSh7JJUV9u/Z8LQfxXw==
X-Received: by 2002:a5d:5551:0:b0:336:6f1f:1b8d with SMTP id
 g17-20020a5d5551000000b003366f1f1b8dmr917615wrw.65.1703013194264; 
 Tue, 19 Dec 2023 11:13:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/43] target/arm/kvm: Move kvm_arm_get_host_cpu_features and
 unexport
Date: Tue, 19 Dec 2023 19:12:34 +0000
Message-Id: <20231219191307.2895919-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h |  22 ----
 target/arm/kvm.c     | 265 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm64.c   | 254 -----------------------------------------
 3 files changed, 265 insertions(+), 276 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 58c087207f5..e59d713973c 100644
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
index 84f300c602b..ffe0db42933 100644
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
index fca4864b739..504526b24c9 100644
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


