Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F73A7D9BDD
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0N-0007J8-2O; Fri, 27 Oct 2023 10:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0B-0007FR-CE
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:55 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO06-00087B-6q
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:55 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c5087d19a6so30502021fa.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417586; x=1699022386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ulfdcFLrZf0yu0McYAZ/Hmd9QAnC/yaQGAKgjQxTyBc=;
 b=nmjz+bmQt6myxFQCvtHCfvYtdmZ9hUpM9WYaMnvN90fZRH1iOtsy4gUetxvcMsXEHG
 x8s66kq9iq18bkcrR6moEektn7Vccb0McbS4Ws2+pJa5HHBkwDp5VJIYZ1PNB6haeZe8
 mjAmVYNJs2/8Hnosz2Jq+zOOwRgiE+Rf1u4Jx4gdlQ2N+6F4cm0JJPZmsDvRECx8mnIa
 GfMdYQ+KBGdK/Dxclxu2d0DOuH25G5usozZrZeI6Bka58BnQzKiw/mSwBOqnmhoQHUSR
 TyzrkHVSLvy+qcd9RYtnbM47sg1ecJoLxlmGQmKYR1wAjJAitTcC2RwUQ5dXNXkq6hTZ
 VLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417586; x=1699022386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulfdcFLrZf0yu0McYAZ/Hmd9QAnC/yaQGAKgjQxTyBc=;
 b=KUZR2oWT/PxVcta3nIKi4hIsVu+gM3a0CZ0M8o25tTHc3StXX21oLSVsAztal4NphA
 Bfzr4JWzIXYtNwCouOLxF5AQmxg/Ntgnu0Q7Pcr3VzQjwv8U1PaLSZYB452BN8TAz8or
 72/Mp7i++uC8mN7hR9dA4VMx7ldYZoOqoMhEBavXg8CGPfz+fqhB7L6hkfno18kPIPde
 Dg1+LJNQR4NXYoRYQt+vNDhpsLVArZMqhEAtFGIfdl/RKIiazyn98OxoiIoPiGYtVJAe
 QKgxLURX4CbHmWRo1gTyLnDJ+fHWd3VrDCA3vTzxCokgpqvWf5r+fPVbI66CNLWFFchL
 /Dyw==
X-Gm-Message-State: AOJu0Yy8XFEo/cAbNZjbabCzbwvJXV4hFfDiLlhqhQak8vC0+nDP+ad7
 wv6DWGWAXTyZThoGmXEw1h/F8Qb1go+udjRBkjQ=
X-Google-Smtp-Source: AGHT+IEoSEobZXgfGR8/o752+UDSZqhS08HrcHjAm136EWk88zaUG6D4KleiSfFiW9exsCcE8htjwg==
X-Received: by 2002:a2e:8798:0:b0:2c5:be8:68b1 with SMTP id
 n24-20020a2e8798000000b002c50be868b1mr2758635lji.9.1698417585550; 
 Fri, 27 Oct 2023 07:39:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/41] target/arm: Move feature test functions to their own
 header
Date: Fri, 27 Oct 2023 15:39:04 +0100
Message-Id: <20231027143942.3413881-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The feature test functions isar_feature_*() now take up nearly
a thousand lines in target/arm/cpu.h. This header file is included
by a lot of source files, most of which don't need these functions.
Move the feature test functions to their own header file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231024163510.2972081-2-peter.maydell@linaro.org
---
 bsd-user/arm/target_arch.h        |   1 +
 linux-user/aarch64/target_prctl.h |   2 +
 target/arm/cpu-features.h         | 994 ++++++++++++++++++++++++++++++
 target/arm/cpu.h                  | 971 -----------------------------
 target/arm/internals.h            |   1 +
 target/arm/tcg/translate.h        |   2 +-
 hw/arm/armv7m.c                   |   1 +
 hw/intc/armv7m_nvic.c             |   1 +
 linux-user/aarch64/cpu_loop.c     |   1 +
 linux-user/aarch64/signal.c       |   1 +
 linux-user/arm/signal.c           |   1 +
 linux-user/elfload.c              |   4 +
 linux-user/mmap.c                 |   4 +
 target/arm/arch_dump.c            |   1 +
 target/arm/cpu.c                  |   1 +
 target/arm/cpu64.c                |   1 +
 target/arm/debug_helper.c         |   1 +
 target/arm/gdbstub.c              |   1 +
 target/arm/helper.c               |   1 +
 target/arm/kvm64.c                |   1 +
 target/arm/machine.c              |   1 +
 target/arm/ptw.c                  |   1 +
 target/arm/tcg/cpu64.c            |   1 +
 target/arm/tcg/hflags.c           |   1 +
 target/arm/tcg/m_helper.c         |   1 +
 target/arm/tcg/op_helper.c        |   1 +
 target/arm/tcg/pauth_helper.c     |   1 +
 target/arm/tcg/tlb_helper.c       |   1 +
 target/arm/vfp_helper.c           |   1 +
 29 files changed, 1028 insertions(+), 972 deletions(-)
 create mode 100644 target/arm/cpu-features.h

diff --git a/bsd-user/arm/target_arch.h b/bsd-user/arm/target_arch.h
index 561934bbd25..d80cb85c647 100644
--- a/bsd-user/arm/target_arch.h
+++ b/bsd-user/arm/target_arch.h
@@ -21,6 +21,7 @@
 #define TARGET_ARCH_H
 
 #include "qemu.h"
+#include "target/arm/cpu-features.h"
 
 void target_cpu_set_tls(CPUARMState *env, target_ulong newtls);
 target_ulong target_cpu_get_tls(CPUARMState *env);
diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index 907c3141466..5067e7d7310 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -6,6 +6,8 @@
 #ifndef AARCH64_TARGET_PRCTL_H
 #define AARCH64_TARGET_PRCTL_H
 
+#include "target/arm/cpu-features.h"
+
 static abi_long do_prctl_sve_get_vl(CPUArchState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
new file mode 100644
index 00000000000..bfc9bfafe70
--- /dev/null
+++ b/target/arm/cpu-features.h
@@ -0,0 +1,994 @@
+/*
+ * QEMU Arm CPU -- feature test functions
+ *
+ *  Copyright (c) 2023 Linaro Ltd
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARM_FEATURES_H
+#define TARGET_ARM_FEATURES_H
+
+/*
+ * Naming convention for isar_feature functions:
+ * Functions which test 32-bit ID registers should have _aa32_ in
+ * their name. Functions which test 64-bit ID registers should have
+ * _aa64_ in their name. These must only be used in code where we
+ * know for certain that the CPU has AArch32 or AArch64 respectively
+ * or where the correct answer for a CPU which doesn't implement that
+ * CPU state is "false" (eg when generating A32 or A64 code, if adding
+ * system registers that are specific to that CPU state, for "should
+ * we let this system register bit be set" tests where the 32-bit
+ * flavour of the register doesn't have the bit, and so on).
+ * Functions which simply ask "does this feature exist at all" have
+ * _any_ in their name, and always return the logical OR of the _aa64_
+ * and the _aa32_ function.
+ */
+
+/*
+ * 32-bit feature tests via id registers.
+ */
+static inline bool isar_feature_aa32_thumb_div(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
+}
+
+static inline bool isar_feature_aa32_arm_div(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) > 1;
+}
+
+static inline bool isar_feature_aa32_lob(const ARMISARegisters *id)
+{
+    /* (M-profile) low-overhead loops and branch future */
+    return FIELD_EX32(id->id_isar0, ID_ISAR0, CMPBRANCH) >= 3;
+}
+
+static inline bool isar_feature_aa32_jazelle(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar1, ID_ISAR1, JAZELLE) != 0;
+}
+
+static inline bool isar_feature_aa32_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) != 0;
+}
+
+static inline bool isar_feature_aa32_pmull(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) > 1;
+}
+
+static inline bool isar_feature_aa32_sha1(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA1) != 0;
+}
+
+static inline bool isar_feature_aa32_sha2(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA2) != 0;
+}
+
+static inline bool isar_feature_aa32_crc32(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, CRC32) != 0;
+}
+
+static inline bool isar_feature_aa32_rdm(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, RDM) != 0;
+}
+
+static inline bool isar_feature_aa32_vcma(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, VCMA) != 0;
+}
+
+static inline bool isar_feature_aa32_jscvt(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, JSCVT) != 0;
+}
+
+static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
+}
+
+static inline bool isar_feature_aa32_fhm(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, FHM) != 0;
+}
+
+static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, SB) != 0;
+}
+
+static inline bool isar_feature_aa32_predinv(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, SPECRES) != 0;
+}
+
+static inline bool isar_feature_aa32_bf16(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, BF16) != 0;
+}
+
+static inline bool isar_feature_aa32_i8mm(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, I8MM) != 0;
+}
+
+static inline bool isar_feature_aa32_ras(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_pfr0, ID_PFR0, RAS) != 0;
+}
+
+static inline bool isar_feature_aa32_mprofile(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_pfr1, ID_PFR1, MPROGMOD) != 0;
+}
+
+static inline bool isar_feature_aa32_m_sec_state(const ARMISARegisters *id)
+{
+    /*
+     * Return true if M-profile state handling insns
+     * (VSCCLRM, CLRM, FPCTX access insns) are implemented
+     */
+    return FIELD_EX32(id->id_pfr1, ID_PFR1, SECURITY) >= 3;
+}
+
+static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
+{
+    /* Sadly this is encoded differently for A-profile and M-profile */
+    if (isar_feature_aa32_mprofile(id)) {
+        return FIELD_EX32(id->mvfr1, MVFR1, FP16) > 0;
+    } else {
+        return FIELD_EX32(id->mvfr1, MVFR1, FPHP) >= 3;
+    }
+}
+
+static inline bool isar_feature_aa32_mve(const ARMISARegisters *id)
+{
+    /*
+     * Return true if MVE is supported (either integer or floating point).
+     * We must check for M-profile as the MVFR1 field means something
+     * else for A-profile.
+     */
+    return isar_feature_aa32_mprofile(id) &&
+        FIELD_EX32(id->mvfr1, MVFR1, MVE) > 0;
+}
+
+static inline bool isar_feature_aa32_mve_fp(const ARMISARegisters *id)
+{
+    /*
+     * Return true if MVE is supported (either integer or floating point).
+     * We must check for M-profile as the MVFR1 field means something
+     * else for A-profile.
+     */
+    return isar_feature_aa32_mprofile(id) &&
+        FIELD_EX32(id->mvfr1, MVFR1, MVE) >= 2;
+}
+
+static inline bool isar_feature_aa32_vfp_simd(const ARMISARegisters *id)
+{
+    /*
+     * Return true if either VFP or SIMD is implemented.
+     * In this case, a minimum of VFP w/ D0-D15.
+     */
+    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) > 0;
+}
+
+static inline bool isar_feature_aa32_simd_r32(const ARMISARegisters *id)
+{
+    /* Return true if D16-D31 are implemented */
+    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) >= 2;
+}
+
+static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
+}
+
+static inline bool isar_feature_aa32_fpsp_v2(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports single precision floating point, VFPv2 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) > 0;
+}
+
+static inline bool isar_feature_aa32_fpsp_v3(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports single precision floating point, VFPv3 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) >= 2;
+}
+
+static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports double precision floating point, VFPv2 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
+}
+
+static inline bool isar_feature_aa32_fpdp_v3(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports double precision floating point, VFPv3 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) >= 2;
+}
+
+static inline bool isar_feature_aa32_vfp(const ARMISARegisters *id)
+{
+    return isar_feature_aa32_fpsp_v2(id) || isar_feature_aa32_fpdp_v2(id);
+}
+
+/*
+ * We always set the FP and SIMD FP16 fields to indicate identical
+ * levels of support (assuming SIMD is implemented at all), so
+ * we only need one set of accessors.
+ */
+static inline bool isar_feature_aa32_fp16_spconv(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 0;
+}
+
+static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
+}
+
+/*
+ * Note that this ID register field covers both VFP and Neon FMAC,
+ * so should usually be tested in combination with some other
+ * check that confirms the presence of whichever of VFP or Neon is
+ * relevant, to avoid accidentally enabling a Neon feature on
+ * a VFP-no-Neon core or vice-versa.
+ */
+static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
+}
+
+static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 1;
+}
+
+static inline bool isar_feature_aa32_vcvt_dr(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 2;
+}
+
+static inline bool isar_feature_aa32_vrint(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 3;
+}
+
+static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 4;
+}
+
+static inline bool isar_feature_aa32_pxn(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr0, ID_MMFR0, VMSA) >= 4;
+}
+
+static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) != 0;
+}
+
+static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) >= 2;
+}
+
+static inline bool isar_feature_aa32_pmuv3p1(const ARMISARegisters *id)
+{
+    /* 0xf means "non-standard IMPDEF PMU" */
+    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
+        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+}
+
+static inline bool isar_feature_aa32_pmuv3p4(const ARMISARegisters *id)
+{
+    /* 0xf means "non-standard IMPDEF PMU" */
+    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 5 &&
+        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+}
+
+static inline bool isar_feature_aa32_pmuv3p5(const ARMISARegisters *id)
+{
+    /* 0xf means "non-standard IMPDEF PMU" */
+    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 6 &&
+        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+}
+
+static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, HPDS) != 0;
+}
+
+static inline bool isar_feature_aa32_ac2(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, AC2) != 0;
+}
+
+static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
+}
+
+static inline bool isar_feature_aa32_tts2uxn(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, XNX) != 0;
+}
+
+static inline bool isar_feature_aa32_half_evt(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, EVT) >= 1;
+}
+
+static inline bool isar_feature_aa32_evt(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, EVT) >= 2;
+}
+
+static inline bool isar_feature_aa32_dit(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_pfr0, ID_PFR0, DIT) != 0;
+}
+
+static inline bool isar_feature_aa32_ssbs(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_pfr2, ID_PFR2, SSBS) != 0;
+}
+
+static inline bool isar_feature_aa32_debugv7p1(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_dfr0, ID_DFR0, COPDBG) >= 5;
+}
+
+static inline bool isar_feature_aa32_debugv8p2(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_dfr0, ID_DFR0, COPDBG) >= 8;
+}
+
+static inline bool isar_feature_aa32_doublelock(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->dbgdevid, DBGDEVID, DOUBLELOCK) > 0;
+}
+
+/*
+ * 64-bit feature tests via id registers.
+ */
+static inline bool isar_feature_aa64_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) != 0;
+}
+
+static inline bool isar_feature_aa64_pmull(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) > 1;
+}
+
+static inline bool isar_feature_aa64_sha1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA1) != 0;
+}
+
+static inline bool isar_feature_aa64_sha256(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) != 0;
+}
+
+static inline bool isar_feature_aa64_sha512(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) > 1;
+}
+
+static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, CRC32) != 0;
+}
+
+static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, ATOMIC) != 0;
+}
+
+static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RDM) != 0;
+}
+
+static inline bool isar_feature_aa64_sha3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA3) != 0;
+}
+
+static inline bool isar_feature_aa64_sm3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM3) != 0;
+}
+
+static inline bool isar_feature_aa64_sm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM4) != 0;
+}
+
+static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
+}
+
+static inline bool isar_feature_aa64_fhm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, FHM) != 0;
+}
+
+static inline bool isar_feature_aa64_condm_4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) != 0;
+}
+
+static inline bool isar_feature_aa64_condm_5(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) >= 2;
+}
+
+static inline bool isar_feature_aa64_rndr(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RNDR) != 0;
+}
+
+static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
+}
+
+static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
+}
+
+/*
+ * These are the values from APA/API/APA3.
+ * In general these must be compared '>=', per the normal Arm ARM
+ * treatment of fields in ID registers.
+ */
+typedef enum {
+    PauthFeat_None         = 0,
+    PauthFeat_1            = 1,
+    PauthFeat_EPAC         = 2,
+    PauthFeat_2            = 3,
+    PauthFeat_FPAC         = 4,
+    PauthFeat_FPACCOMBINED = 5,
+} ARMPauthFeature;
+
+static inline ARMPauthFeature
+isar_feature_pauth_feature(const ARMISARegisters *id)
+{
+    /*
+     * Architecturally, only one of {APA,API,APA3} may be active (non-zero)
+     * and the other two must be zero.  Thus we may avoid conditionals.
+     */
+    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) |
+            FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API) |
+            FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3));
+}
+
+static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
+{
+    /*
+     * Return true if any form of pauth is enabled, as this
+     * predicate controls migration of the 128-bit keys.
+     */
+    return isar_feature_pauth_feature(id) != PauthFeat_None;
+}
+
+static inline bool isar_feature_aa64_pauth_qarma5(const ARMISARegisters *id)
+{
+    /*
+     * Return true if pauth is enabled with the architected QARMA5 algorithm.
+     * QEMU will always enable or disable both APA and GPA.
+     */
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) != 0;
+}
+
+static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
+{
+    /*
+     * Return true if pauth is enabled with the architected QARMA3 algorithm.
+     * QEMU will always enable or disable both APA3 and GPA3.
+     */
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
+}
+
+static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
+}
+
+static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) != 0;
+}
+
+static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
+}
+
+static inline bool isar_feature_aa64_predinv(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SPECRES) != 0;
+}
+
+static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
+}
+
+static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
+}
+
+static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
+}
+
+static inline bool isar_feature_aa64_bf16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) != 0;
+}
+
+static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
+{
+    /* We always set the AdvSIMD and FP fields identically.  */
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) != 0xf;
+}
+
+static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
+{
+    /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
+}
+
+static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >= 2;
+}
+
+static inline bool isar_feature_aa64_aa32_el1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL1) >= 2;
+}
+
+static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL2) >= 2;
+}
+
+static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RAS) != 0;
+}
+
+static inline bool isar_feature_aa64_doublefault(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RAS) >= 2;
+}
+
+static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
+}
+
+static inline bool isar_feature_aa64_sel2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SEL2) != 0;
+}
+
+static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RME) != 0;
+}
+
+static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+}
+
+static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
+}
+
+static inline bool isar_feature_aa64_pan(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) != 0;
+}
+
+static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
+}
+
+static inline bool isar_feature_aa64_pan3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 3;
+}
+
+static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HCX) != 0;
+}
+
+static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR1, TIDCP1) != 0;
+}
+
+static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
+}
+
+static inline bool isar_feature_aa64_st(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, ST) != 0;
+}
+
+static inline bool isar_feature_aa64_lse2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, AT) != 0;
+}
+
+static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, FWB) != 0;
+}
+
+static inline bool isar_feature_aa64_ids(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, IDS) != 0;
+}
+
+static inline bool isar_feature_aa64_half_evt(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 1;
+}
+
+static inline bool isar_feature_aa64_evt(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 2;
+}
+
+static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
+}
+
+static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+}
+
+static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+}
+
+static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
+}
+
+static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
+        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+}
+
+static inline bool isar_feature_aa64_pmuv3p4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 5 &&
+        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+}
+
+static inline bool isar_feature_aa64_pmuv3p5(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 6 &&
+        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+}
+
+static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
+}
+
+static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
+}
+
+static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
+}
+
+static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
+}
+
+static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
+}
+
+static inline bool isar_feature_aa64_tgran4_2_lpa2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
+    return t >= 3 || (t == 0 && isar_feature_aa64_tgran4_lpa2(id));
+}
+
+static inline bool isar_feature_aa64_tgran16_lpa2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 2;
+}
+
+static inline bool isar_feature_aa64_tgran16_2_lpa2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
+    return t >= 3 || (t == 0 && isar_feature_aa64_tgran16_lpa2(id));
+}
+
+static inline bool isar_feature_aa64_tgran4(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 0;
+}
+
+static inline bool isar_feature_aa64_tgran16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 1;
+}
+
+static inline bool isar_feature_aa64_tgran64(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64) >= 0;
+}
+
+static inline bool isar_feature_aa64_tgran4_2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
+    return t >= 2 || (t == 0 && isar_feature_aa64_tgran4(id));
+}
+
+static inline bool isar_feature_aa64_tgran16_2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
+    return t >= 2 || (t == 0 && isar_feature_aa64_tgran16(id));
+}
+
+static inline bool isar_feature_aa64_tgran64_2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64_2);
+    return t >= 2 || (t == 0 && isar_feature_aa64_tgran64(id));
+}
+
+static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
+}
+
+static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
+}
+
+static inline bool isar_feature_aa64_lva(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, VARANGE) != 0;
+}
+
+static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
+}
+
+static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
+}
+
+static inline bool isar_feature_aa64_hdbs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) >= 2;
+}
+
+static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
+}
+
+static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
+}
+
+static inline bool isar_feature_aa64_scxtnum(const ARMISARegisters *id)
+{
+    int key = FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, CSV2);
+    if (key >= 2) {
+        return true;      /* FEAT_CSV2_2 */
+    }
+    if (key == 1) {
+        key = FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, CSV2_FRAC);
+        return key >= 2;  /* FEAT_CSV2_1p2 */
+    }
+    return false;
+}
+
+static inline bool isar_feature_aa64_ssbs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SSBS) != 0;
+}
+
+static inline bool isar_feature_aa64_debugv8p2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, DEBUGVER) >= 8;
+}
+
+static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) >= 2;
+}
+
+static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
+}
+
+static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BFLOAT16) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_sha3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SHA3) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SM4) != 0;
+}
+
+static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, I8MM) != 0;
+}
+
+static inline bool isar_feature_aa64_sve_f32mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
+}
+
+static inline bool isar_feature_aa64_sve_f64mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
+}
+
+static inline bool isar_feature_aa64_sme_f64f64(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F64F64);
+}
+
+static inline bool isar_feature_aa64_sme_i16i64(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, I16I64) == 0xf;
+}
+
+static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, FA64);
+}
+
+static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
+}
+
+static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
+}
+
+/*
+ * Feature tests for "does this exist in either 32-bit or 64-bit?"
+ */
+static inline bool isar_feature_any_fp16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_fp16(id) || isar_feature_aa32_fp16_arith(id);
+}
+
+static inline bool isar_feature_any_predinv(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_predinv(id) || isar_feature_aa32_predinv(id);
+}
+
+static inline bool isar_feature_any_pmuv3p1(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_pmuv3p1(id) || isar_feature_aa32_pmuv3p1(id);
+}
+
+static inline bool isar_feature_any_pmuv3p4(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_pmuv3p4(id) || isar_feature_aa32_pmuv3p4(id);
+}
+
+static inline bool isar_feature_any_pmuv3p5(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_pmuv3p5(id) || isar_feature_aa32_pmuv3p5(id);
+}
+
+static inline bool isar_feature_any_ccidx(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_ccidx(id) || isar_feature_aa32_ccidx(id);
+}
+
+static inline bool isar_feature_any_tts2uxn(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_tts2uxn(id) || isar_feature_aa32_tts2uxn(id);
+}
+
+static inline bool isar_feature_any_debugv8p2(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_debugv8p2(id) || isar_feature_aa32_debugv8p2(id);
+}
+
+static inline bool isar_feature_any_ras(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_ras(id) || isar_feature_aa32_ras(id);
+}
+
+static inline bool isar_feature_any_half_evt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_half_evt(id) || isar_feature_aa32_half_evt(id);
+}
+
+static inline bool isar_feature_any_evt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
+}
+
+/*
+ * Forward to the above feature tests given an ARMCPU pointer.
+ */
+#define cpu_isar_feature(name, cpu) \
+    ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
+
+#endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 76d4cef9e3a..d51dfe48db0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3402,975 +3402,4 @@ static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
 }
 #endif
 
-/*
- * Naming convention for isar_feature functions:
- * Functions which test 32-bit ID registers should have _aa32_ in
- * their name. Functions which test 64-bit ID registers should have
- * _aa64_ in their name. These must only be used in code where we
- * know for certain that the CPU has AArch32 or AArch64 respectively
- * or where the correct answer for a CPU which doesn't implement that
- * CPU state is "false" (eg when generating A32 or A64 code, if adding
- * system registers that are specific to that CPU state, for "should
- * we let this system register bit be set" tests where the 32-bit
- * flavour of the register doesn't have the bit, and so on).
- * Functions which simply ask "does this feature exist at all" have
- * _any_ in their name, and always return the logical OR of the _aa64_
- * and the _aa32_ function.
- */
-
-/*
- * 32-bit feature tests via id registers.
- */
-static inline bool isar_feature_aa32_thumb_div(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
-}
-
-static inline bool isar_feature_aa32_arm_div(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) > 1;
-}
-
-static inline bool isar_feature_aa32_lob(const ARMISARegisters *id)
-{
-    /* (M-profile) low-overhead loops and branch future */
-    return FIELD_EX32(id->id_isar0, ID_ISAR0, CMPBRANCH) >= 3;
-}
-
-static inline bool isar_feature_aa32_jazelle(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar1, ID_ISAR1, JAZELLE) != 0;
-}
-
-static inline bool isar_feature_aa32_aes(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) != 0;
-}
-
-static inline bool isar_feature_aa32_pmull(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) > 1;
-}
-
-static inline bool isar_feature_aa32_sha1(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA1) != 0;
-}
-
-static inline bool isar_feature_aa32_sha2(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA2) != 0;
-}
-
-static inline bool isar_feature_aa32_crc32(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, CRC32) != 0;
-}
-
-static inline bool isar_feature_aa32_rdm(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, RDM) != 0;
-}
-
-static inline bool isar_feature_aa32_vcma(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, VCMA) != 0;
-}
-
-static inline bool isar_feature_aa32_jscvt(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, JSCVT) != 0;
-}
-
-static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
-}
-
-static inline bool isar_feature_aa32_fhm(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, FHM) != 0;
-}
-
-static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, SB) != 0;
-}
-
-static inline bool isar_feature_aa32_predinv(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, SPECRES) != 0;
-}
-
-static inline bool isar_feature_aa32_bf16(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, BF16) != 0;
-}
-
-static inline bool isar_feature_aa32_i8mm(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, I8MM) != 0;
-}
-
-static inline bool isar_feature_aa32_ras(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_pfr0, ID_PFR0, RAS) != 0;
-}
-
-static inline bool isar_feature_aa32_mprofile(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_pfr1, ID_PFR1, MPROGMOD) != 0;
-}
-
-static inline bool isar_feature_aa32_m_sec_state(const ARMISARegisters *id)
-{
-    /*
-     * Return true if M-profile state handling insns
-     * (VSCCLRM, CLRM, FPCTX access insns) are implemented
-     */
-    return FIELD_EX32(id->id_pfr1, ID_PFR1, SECURITY) >= 3;
-}
-
-static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
-{
-    /* Sadly this is encoded differently for A-profile and M-profile */
-    if (isar_feature_aa32_mprofile(id)) {
-        return FIELD_EX32(id->mvfr1, MVFR1, FP16) > 0;
-    } else {
-        return FIELD_EX32(id->mvfr1, MVFR1, FPHP) >= 3;
-    }
-}
-
-static inline bool isar_feature_aa32_mve(const ARMISARegisters *id)
-{
-    /*
-     * Return true if MVE is supported (either integer or floating point).
-     * We must check for M-profile as the MVFR1 field means something
-     * else for A-profile.
-     */
-    return isar_feature_aa32_mprofile(id) &&
-        FIELD_EX32(id->mvfr1, MVFR1, MVE) > 0;
-}
-
-static inline bool isar_feature_aa32_mve_fp(const ARMISARegisters *id)
-{
-    /*
-     * Return true if MVE is supported (either integer or floating point).
-     * We must check for M-profile as the MVFR1 field means something
-     * else for A-profile.
-     */
-    return isar_feature_aa32_mprofile(id) &&
-        FIELD_EX32(id->mvfr1, MVFR1, MVE) >= 2;
-}
-
-static inline bool isar_feature_aa32_vfp_simd(const ARMISARegisters *id)
-{
-    /*
-     * Return true if either VFP or SIMD is implemented.
-     * In this case, a minimum of VFP w/ D0-D15.
-     */
-    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) > 0;
-}
-
-static inline bool isar_feature_aa32_simd_r32(const ARMISARegisters *id)
-{
-    /* Return true if D16-D31 are implemented */
-    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) >= 2;
-}
-
-static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
-}
-
-static inline bool isar_feature_aa32_fpsp_v2(const ARMISARegisters *id)
-{
-    /* Return true if CPU supports single precision floating point, VFPv2 */
-    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) > 0;
-}
-
-static inline bool isar_feature_aa32_fpsp_v3(const ARMISARegisters *id)
-{
-    /* Return true if CPU supports single precision floating point, VFPv3 */
-    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) >= 2;
-}
-
-static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
-{
-    /* Return true if CPU supports double precision floating point, VFPv2 */
-    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
-}
-
-static inline bool isar_feature_aa32_fpdp_v3(const ARMISARegisters *id)
-{
-    /* Return true if CPU supports double precision floating point, VFPv3 */
-    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) >= 2;
-}
-
-static inline bool isar_feature_aa32_vfp(const ARMISARegisters *id)
-{
-    return isar_feature_aa32_fpsp_v2(id) || isar_feature_aa32_fpdp_v2(id);
-}
-
-/*
- * We always set the FP and SIMD FP16 fields to indicate identical
- * levels of support (assuming SIMD is implemented at all), so
- * we only need one set of accessors.
- */
-static inline bool isar_feature_aa32_fp16_spconv(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 0;
-}
-
-static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
-}
-
-/*
- * Note that this ID register field covers both VFP and Neon FMAC,
- * so should usually be tested in combination with some other
- * check that confirms the presence of whichever of VFP or Neon is
- * relevant, to avoid accidentally enabling a Neon feature on
- * a VFP-no-Neon core or vice-versa.
- */
-static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
-}
-
-static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 1;
-}
-
-static inline bool isar_feature_aa32_vcvt_dr(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 2;
-}
-
-static inline bool isar_feature_aa32_vrint(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 3;
-}
-
-static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 4;
-}
-
-static inline bool isar_feature_aa32_pxn(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr0, ID_MMFR0, VMSA) >= 4;
-}
-
-static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) != 0;
-}
-
-static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) >= 2;
-}
-
-static inline bool isar_feature_aa32_pmuv3p1(const ARMISARegisters *id)
-{
-    /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
-}
-
-static inline bool isar_feature_aa32_pmuv3p4(const ARMISARegisters *id)
-{
-    /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 5 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
-}
-
-static inline bool isar_feature_aa32_pmuv3p5(const ARMISARegisters *id)
-{
-    /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 6 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
-}
-
-static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, HPDS) != 0;
-}
-
-static inline bool isar_feature_aa32_ac2(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, AC2) != 0;
-}
-
-static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
-}
-
-static inline bool isar_feature_aa32_tts2uxn(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, XNX) != 0;
-}
-
-static inline bool isar_feature_aa32_half_evt(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, EVT) >= 1;
-}
-
-static inline bool isar_feature_aa32_evt(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, EVT) >= 2;
-}
-
-static inline bool isar_feature_aa32_dit(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_pfr0, ID_PFR0, DIT) != 0;
-}
-
-static inline bool isar_feature_aa32_ssbs(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_pfr2, ID_PFR2, SSBS) != 0;
-}
-
-static inline bool isar_feature_aa32_debugv7p1(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, COPDBG) >= 5;
-}
-
-static inline bool isar_feature_aa32_debugv8p2(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, COPDBG) >= 8;
-}
-
-static inline bool isar_feature_aa32_doublelock(const ARMISARegisters *id)
-{
-    return FIELD_EX32(id->dbgdevid, DBGDEVID, DOUBLELOCK) > 0;
-}
-
-/*
- * 64-bit feature tests via id registers.
- */
-static inline bool isar_feature_aa64_aes(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) != 0;
-}
-
-static inline bool isar_feature_aa64_pmull(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) > 1;
-}
-
-static inline bool isar_feature_aa64_sha1(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA1) != 0;
-}
-
-static inline bool isar_feature_aa64_sha256(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) != 0;
-}
-
-static inline bool isar_feature_aa64_sha512(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) > 1;
-}
-
-static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, CRC32) != 0;
-}
-
-static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, ATOMIC) != 0;
-}
-
-static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RDM) != 0;
-}
-
-static inline bool isar_feature_aa64_sha3(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA3) != 0;
-}
-
-static inline bool isar_feature_aa64_sm3(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM3) != 0;
-}
-
-static inline bool isar_feature_aa64_sm4(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM4) != 0;
-}
-
-static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
-}
-
-static inline bool isar_feature_aa64_fhm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, FHM) != 0;
-}
-
-static inline bool isar_feature_aa64_condm_4(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) != 0;
-}
-
-static inline bool isar_feature_aa64_condm_5(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) >= 2;
-}
-
-static inline bool isar_feature_aa64_rndr(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RNDR) != 0;
-}
-
-static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
-}
-
-static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
-}
-
-/*
- * These are the values from APA/API/APA3.
- * In general these must be compared '>=', per the normal Arm ARM
- * treatment of fields in ID registers.
- */
-typedef enum {
-    PauthFeat_None         = 0,
-    PauthFeat_1            = 1,
-    PauthFeat_EPAC         = 2,
-    PauthFeat_2            = 3,
-    PauthFeat_FPAC         = 4,
-    PauthFeat_FPACCOMBINED = 5,
-} ARMPauthFeature;
-
-static inline ARMPauthFeature
-isar_feature_pauth_feature(const ARMISARegisters *id)
-{
-    /*
-     * Architecturally, only one of {APA,API,APA3} may be active (non-zero)
-     * and the other two must be zero.  Thus we may avoid conditionals.
-     */
-    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) |
-            FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API) |
-            FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3));
-}
-
-static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
-{
-    /*
-     * Return true if any form of pauth is enabled, as this
-     * predicate controls migration of the 128-bit keys.
-     */
-    return isar_feature_pauth_feature(id) != PauthFeat_None;
-}
-
-static inline bool isar_feature_aa64_pauth_qarma5(const ARMISARegisters *id)
-{
-    /*
-     * Return true if pauth is enabled with the architected QARMA5 algorithm.
-     * QEMU will always enable or disable both APA and GPA.
-     */
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) != 0;
-}
-
-static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
-{
-    /*
-     * Return true if pauth is enabled with the architected QARMA3 algorithm.
-     * QEMU will always enable or disable both APA3 and GPA3.
-     */
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
-}
-
-static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
-}
-
-static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) != 0;
-}
-
-static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
-}
-
-static inline bool isar_feature_aa64_predinv(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SPECRES) != 0;
-}
-
-static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
-}
-
-static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
-}
-
-static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
-}
-
-static inline bool isar_feature_aa64_bf16(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) != 0;
-}
-
-static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
-{
-    /* We always set the AdvSIMD and FP fields identically.  */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) != 0xf;
-}
-
-static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
-{
-    /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
-}
-
-static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >= 2;
-}
-
-static inline bool isar_feature_aa64_aa32_el1(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL1) >= 2;
-}
-
-static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL2) >= 2;
-}
-
-static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RAS) != 0;
-}
-
-static inline bool isar_feature_aa64_doublefault(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RAS) >= 2;
-}
-
-static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
-}
-
-static inline bool isar_feature_aa64_sel2(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SEL2) != 0;
-}
-
-static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RME) != 0;
-}
-
-static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
-}
-
-static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
-}
-
-static inline bool isar_feature_aa64_pan(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) != 0;
-}
-
-static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
-}
-
-static inline bool isar_feature_aa64_pan3(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 3;
-}
-
-static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HCX) != 0;
-}
-
-static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR1, TIDCP1) != 0;
-}
-
-static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
-}
-
-static inline bool isar_feature_aa64_st(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, ST) != 0;
-}
-
-static inline bool isar_feature_aa64_lse2(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, AT) != 0;
-}
-
-static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, FWB) != 0;
-}
-
-static inline bool isar_feature_aa64_ids(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, IDS) != 0;
-}
-
-static inline bool isar_feature_aa64_half_evt(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 1;
-}
-
-static inline bool isar_feature_aa64_evt(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, EVT) >= 2;
-}
-
-static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
-}
-
-static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
-}
-
-static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
-}
-
-static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
-}
-
-static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
-}
-
-static inline bool isar_feature_aa64_pmuv3p4(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 5 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
-}
-
-static inline bool isar_feature_aa64_pmuv3p5(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 6 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
-}
-
-static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
-}
-
-static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
-}
-
-static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
-}
-
-static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
-}
-
-static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
-{
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
-}
-
-static inline bool isar_feature_aa64_tgran4_2_lpa2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
-    return t >= 3 || (t == 0 && isar_feature_aa64_tgran4_lpa2(id));
-}
-
-static inline bool isar_feature_aa64_tgran16_lpa2(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 2;
-}
-
-static inline bool isar_feature_aa64_tgran16_2_lpa2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
-    return t >= 3 || (t == 0 && isar_feature_aa64_tgran16_lpa2(id));
-}
-
-static inline bool isar_feature_aa64_tgran4(const ARMISARegisters *id)
-{
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 0;
-}
-
-static inline bool isar_feature_aa64_tgran16(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 1;
-}
-
-static inline bool isar_feature_aa64_tgran64(const ARMISARegisters *id)
-{
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64) >= 0;
-}
-
-static inline bool isar_feature_aa64_tgran4_2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
-    return t >= 2 || (t == 0 && isar_feature_aa64_tgran4(id));
-}
-
-static inline bool isar_feature_aa64_tgran16_2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
-    return t >= 2 || (t == 0 && isar_feature_aa64_tgran16(id));
-}
-
-static inline bool isar_feature_aa64_tgran64_2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64_2);
-    return t >= 2 || (t == 0 && isar_feature_aa64_tgran64(id));
-}
-
-static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
-}
-
-static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
-}
-
-static inline bool isar_feature_aa64_lva(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, VARANGE) != 0;
-}
-
-static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
-}
-
-static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
-}
-
-static inline bool isar_feature_aa64_hdbs(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) >= 2;
-}
-
-static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
-}
-
-static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
-}
-
-static inline bool isar_feature_aa64_scxtnum(const ARMISARegisters *id)
-{
-    int key = FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, CSV2);
-    if (key >= 2) {
-        return true;      /* FEAT_CSV2_2 */
-    }
-    if (key == 1) {
-        key = FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, CSV2_FRAC);
-        return key >= 2;  /* FEAT_CSV2_1p2 */
-    }
-    return false;
-}
-
-static inline bool isar_feature_aa64_ssbs(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SSBS) != 0;
-}
-
-static inline bool isar_feature_aa64_debugv8p2(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, DEBUGVER) >= 8;
-}
-
-static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
-}
-
-static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) != 0;
-}
-
-static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) >= 2;
-}
-
-static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
-}
-
-static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BFLOAT16) != 0;
-}
-
-static inline bool isar_feature_aa64_sve2_sha3(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SHA3) != 0;
-}
-
-static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SM4) != 0;
-}
-
-static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, I8MM) != 0;
-}
-
-static inline bool isar_feature_aa64_sve_f32mm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
-}
-
-static inline bool isar_feature_aa64_sve_f64mm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
-}
-
-static inline bool isar_feature_aa64_sme_f64f64(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F64F64);
-}
-
-static inline bool isar_feature_aa64_sme_i16i64(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, I16I64) == 0xf;
-}
-
-static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, FA64);
-}
-
-static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
-{
-    return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
-}
-
-static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
-}
-
-/*
- * Feature tests for "does this exist in either 32-bit or 64-bit?"
- */
-static inline bool isar_feature_any_fp16(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_fp16(id) || isar_feature_aa32_fp16_arith(id);
-}
-
-static inline bool isar_feature_any_predinv(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_predinv(id) || isar_feature_aa32_predinv(id);
-}
-
-static inline bool isar_feature_any_pmuv3p1(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_pmuv3p1(id) || isar_feature_aa32_pmuv3p1(id);
-}
-
-static inline bool isar_feature_any_pmuv3p4(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_pmuv3p4(id) || isar_feature_aa32_pmuv3p4(id);
-}
-
-static inline bool isar_feature_any_pmuv3p5(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_pmuv3p5(id) || isar_feature_aa32_pmuv3p5(id);
-}
-
-static inline bool isar_feature_any_ccidx(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_ccidx(id) || isar_feature_aa32_ccidx(id);
-}
-
-static inline bool isar_feature_any_tts2uxn(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_tts2uxn(id) || isar_feature_aa32_tts2uxn(id);
-}
-
-static inline bool isar_feature_any_debugv8p2(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_debugv8p2(id) || isar_feature_aa32_debugv8p2(id);
-}
-
-static inline bool isar_feature_any_ras(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_ras(id) || isar_feature_aa32_ras(id);
-}
-
-static inline bool isar_feature_any_half_evt(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_half_evt(id) || isar_feature_aa32_half_evt(id);
-}
-
-static inline bool isar_feature_any_evt(const ARMISARegisters *id)
-{
-    return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
-}
-
-/*
- * Forward to the above feature tests given an ARMCPU pointer.
- */
-#define cpu_isar_feature(name, cpu) \
-    ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
-
 #endif
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1dd9182a54a..f7224e6f4d9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -28,6 +28,7 @@
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "syndrome.h"
+#include "cpu-features.h"
 
 /* register banks for CPU modes */
 #define BANK_USRSYS 0
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b4046611f53..9efe00cf6ca 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -8,7 +8,7 @@
 #include "exec/translator.h"
 #include "exec/helper-gen.h"
 #include "internals.h"
-
+#include "cpu-features.h"
 
 /* internal defines */
 
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 1f78e18872f..d10abb36a8e 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -21,6 +21,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "target/arm/idau.h"
+#include "target/arm/cpu-features.h"
 #include "migration/vmstate.h"
 
 /* Bitbanded IO.  Each word corresponds to a single bit.  */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 03b6b8c986e..942be7bd112 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -21,6 +21,7 @@
 #include "sysemu/tcg.h"
 #include "sysemu/runstate.h"
 #include "target/arm/cpu.h"
+#include "target/arm/cpu-features.h"
 #include "exec/exec-all.h"
 #include "exec/memop.h"
 #include "qemu/log.h"
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 2e2f7cf2188..8c20dc8a39a 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -25,6 +25,7 @@
 #include "qemu/guest-random.h"
 #include "semihosting/common-semi.h"
 #include "target/arm/syndrome.h"
+#include "target/arm/cpu-features.h"
 
 #define get_user_code_u32(x, gaddr, env)                \
     ({ abi_long __r = get_user_u32((x), (gaddr));       \
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b265cfd4706..a1e22d526d8 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target/arm/cpu-features.h"
 
 struct target_sigcontext {
     uint64_t fault_address;
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index cf99fd7b8a6..4020601c544 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target/arm/cpu-features.h"
 
 struct target_sigcontext {
     abi_ulong trap_no;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2e3809f03c4..baa69e55352 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -23,6 +23,10 @@
 #include "target_signal.h"
 #include "accel/tcg/debuginfo.h"
 
+#ifdef TARGET_ARM
+#include "target/arm/cpu-features.h"
+#endif
+
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
 #undef ELF_PLATFORM
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 7b44b9ff49b..96c9433e271 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -26,6 +26,10 @@
 #include "target_mman.h"
 #include "qemu/interval-tree.h"
 
+#ifdef TARGET_ARM
+#include "target/arm/cpu-features.h"
+#endif
+
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
 
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 2d8e41ab8a3..06cdf4ba281 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "elf.h"
 #include "sysemu/dump.h"
+#include "cpu-features.h"
 
 /* struct user_pt_regs from arch/arm64/include/uapi/asm/ptrace.h */
 struct aarch64_user_regs {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index aa4e006f21a..954328d72a0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -31,6 +31,7 @@
 #include "hw/core/tcg-cpu-ops.h"
 #endif /* CONFIG_TCG */
 #include "internals.h"
+#include "cpu-features.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1cb9d5b81aa..1e9c6c85aec 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "cpregs.h"
 
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index abe72e35ae6..79a3659c0ce 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -9,6 +9,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "cpregs.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index b7ace24bfc2..28f546a5ff9 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -23,6 +23,7 @@
 #include "gdbstub/helpers.h"
 #include "sysemu/tcg.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "cpregs.h"
 
 typedef struct RegisterSysregXmlParam {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b29edb26af8..5dc0d20a84e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11,6 +11,7 @@
 #include "trace.h"
 #include "cpu.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "exec/helper-proto.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 4bb68646e43..3c175c93a7a 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -28,6 +28,7 @@
 #include "sysemu/kvm_int.h"
 #include "kvm_arm.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index fc4a4a40644..9e20b411895 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -5,6 +5,7 @@
 #include "sysemu/tcg.h"
 #include "kvm_arm.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "migration/cpu.h"
 
 static bool vfp_needed(void *opaque)
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 95db9ec4c3b..53713e03006 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -13,6 +13,7 @@
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "idau.h"
 #ifdef CONFIG_TCG
 # include "tcg/oversized-guest.h"
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a9a8c0a0592..08db1dbcc74 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/units.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "cpregs.h"
 
 static uint64_t make_ccsidr64(unsigned assoc, unsigned linesize,
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index cea1adb7b62..3d7fdce5c3c 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "exec/helper-proto.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 0045c18f80f..a26adb75aa2 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "qemu/main-loop.h"
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 403f8b09d36..ea08936a852 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "cpregs.h"
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 4da2962ad5b..c4b143024f3 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 59bff8b4527..4fdd85359e1 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
+#include "cpu-features.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 789bba36ccb..3e5e37abbe8 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "internals.h"
+#include "cpu-features.h"
 #ifdef CONFIG_TCG
 #include "qemu/log.h"
 #include "fpu/softfloat.h"
-- 
2.34.1


