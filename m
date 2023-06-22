Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5507973A483
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLyp-0006la-Kr; Thu, 22 Jun 2023 11:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLyn-0006kn-15
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:12:13 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLyl-0000HW-5R
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:12:12 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b47742de92so73350861fa.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687446729; x=1690038729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TccvH+qpCGtNsDlIDGjbT6JxihYcWpoZghsjPC3N3M=;
 b=K/GQfdbnhevSVCFKwc9gSTJ14WkcvQbsUzsoUKbwohkXnuJBABCceoGjiqXgd2+0M9
 ghL5RP566+mUry9jKXs767YiqAUTn1NZCGryPR9HElEh5CgTbk+O8R7oiENoCE+qZaPc
 HGQQ6rT8uxEbtEHXdEyEsXD15lc6CfP6xFuyv3ZopAjywxnmo6dq/LptGEEcBH7Hwqh9
 t1nROplahVet7hGhg2Mc+tJYoN3OJCmbSf/kb/khr7sqcbRAIKJIOsLjXB3MXuGjpuox
 G1ER+1AlsL0gs6upmI2/5OWJ3q+JzHByd8J1mpSFI/JIShFyW0cC+Z5z3gHeIXLH1WBc
 hAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687446729; x=1690038729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TccvH+qpCGtNsDlIDGjbT6JxihYcWpoZghsjPC3N3M=;
 b=EuvaKDTRF3aEz2gpgkHc3lXV0a82bPcTwJ6KZ/MRre7BukswHZa/pbknF9yzItFAPP
 /tu2cc5Tr0NtWzsR3ZN1jJjE5MCnLVZ1sdcGPoCsJP9sZVv0oZhTGOe2oS8eZLQZQUz3
 EcvUPIy0GvMKXVrNHkrsoB2OxOQJMS5W6/Ncxj+Pz+gTRgmnnglaYV83+GuUXZLIOIu0
 8gelvvCB9TbxcWeA+7LlV4MbctudYXE73cAcWAtjMVe2hoYQu2UHZulLFwjWj54OI/kp
 ZqYMH+IeCRwBGfnZj7o+xtzHoBPss0kuObKkQlJe1RxXab0RtyfxQKsldyb1kaDsJfDu
 xNew==
X-Gm-Message-State: AC+VfDzqD9RJyiRV9xtHsjcfJSPr0kHux12SyO+ZI9Tp2k5QtLJ4mUBG
 BhSo63/rWPi8YJn39SkTtpqtvCVMgcxLUPl+tdTnegKW
X-Google-Smtp-Source: ACHHUZ6cY91N81B0HBDL6OVMcQ1WWGoC0Logz0hwQ3wx6qaerxNS78YptZOEoWatB8dYuYHPbo1tLQ==
X-Received: by 2002:a2e:8241:0:b0:2b5:84fb:5939 with SMTP id
 j1-20020a2e8241000000b002b584fb5939mr3641223ljh.30.1687446729573; 
 Thu, 22 Jun 2023 08:12:09 -0700 (PDT)
Received: from stoup.. ([91.223.100.38]) by smtp.gmail.com with ESMTPSA id
 v3-20020a2e9f43000000b002b47fc5219dsm1320276ljk.67.2023.06.22.08.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:12:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 3/4] target/arm: Support reading ZA[] from gdbstub
Date: Thu, 22 Jun 2023 17:12:00 +0200
Message-Id: <20230622151201.1578522-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622151201.1578522-1-richard.henderson@linaro.org>
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22d.google.com
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

Mirror the existing support for SVE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |  1 +
 target/arm/internals.h |  3 ++
 target/arm/gdbstub.c   |  8 ++++
 target/arm/gdbstub64.c | 88 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index af0119addf..082617cfc6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -877,6 +877,7 @@ struct ArchCPU {
 
     DynamicGDBXMLInfo dyn_sysreg_xml;
     DynamicGDBXMLInfo dyn_svereg_xml;
+    DynamicGDBXMLInfo dyn_zareg_xml;
     DynamicGDBXMLInfo dyn_m_systemreg_xml;
     DynamicGDBXMLInfo dyn_m_secextreg_xml;
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e3029bdc37..54d1f28992 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1362,12 +1362,15 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
 
 #ifdef TARGET_AARCH64
 int arm_gen_dynamic_svereg_xml(CPUState *cpu, int base_reg);
+int arm_gen_dynamic_zareg_xml(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUARMState *env, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUARMState *env, uint8_t *buf, int reg);
 int aarch64_gdb_get_fpu_reg(CPUARMState *env, GByteArray *buf, int reg);
 int aarch64_gdb_set_fpu_reg(CPUARMState *env, uint8_t *buf, int reg);
 int aarch64_gdb_get_pauth_reg(CPUARMState *env, GByteArray *buf, int reg);
 int aarch64_gdb_set_pauth_reg(CPUARMState *env, uint8_t *buf, int reg);
+int aarch64_gdb_get_za_reg(CPUARMState *env, GByteArray *buf, int reg);
+int aarch64_gdb_set_za_reg(CPUARMState *env, uint8_t *buf, int reg);
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 03b17c814f..1204eb40d7 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -490,6 +490,8 @@ const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
         return cpu->dyn_sysreg_xml.desc;
     } else if (strcmp(xmlname, "sve-registers.xml") == 0) {
         return cpu->dyn_svereg_xml.desc;
+    } else if (strcmp(xmlname, "za-registers.xml") == 0) {
+        return cpu->dyn_zareg_xml.desc;
     } else if (strcmp(xmlname, "arm-m-system.xml") == 0) {
         return cpu->dyn_m_systemreg_xml.desc;
 #ifndef CONFIG_USER_ONLY
@@ -532,6 +534,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      aarch64_gdb_set_pauth_reg,
                                      4, "aarch64-pauth.xml", 0);
         }
+        if (cpu_isar_feature(aa64_sme, cpu)) {
+            int nreg = arm_gen_dynamic_zareg_xml(cs, cs->gdb_num_regs);
+            gdb_register_coprocessor(cs, aarch64_gdb_get_za_reg,
+                                     aarch64_gdb_set_za_reg, nreg,
+                                     "za-registers.xml", 0);
+        }
 #endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index d7b79a6589..b76fac9bd0 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -247,6 +247,61 @@ int aarch64_gdb_set_pauth_reg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
+static int max_svq(ARMCPU *cpu)
+{
+    return 32 - clz32(cpu->sme_vq.map);
+}
+
+int aarch64_gdb_get_za_reg(CPUARMState *env, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    int max_vq = max_svq(cpu);
+    int cur_vq = EX_TBFLAG_A64(env->hflags, SVL) + 1;
+    int i;
+
+    if (reg >= max_vq * 16) {
+        return 0;
+    }
+
+    /* If ZA is unset, or reg out of range, the contents are zero. */
+    if (FIELD_EX64(env->svcr, SVCR, ZA) && reg < cur_vq * 16) {
+        for (i = 0; i < cur_vq; i++) {
+            gdb_get_reg128(buf, env->zarray[reg].d[i * 2 + 1],
+                           env->zarray[reg].d[i * 2]);
+        }
+    } else {
+        cur_vq = 0;
+    }
+
+    for (i = cur_vq; i < max_vq; i++) {
+        gdb_get_reg128(buf, 0, 0);
+    }
+
+    return max_vq * 16;
+}
+
+int aarch64_gdb_set_za_reg(CPUARMState *env, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t *p = (uint64_t *) buf;
+    int max_vq = max_svq(cpu);
+    int cur_vq = EX_TBFLAG_A64(env->hflags, SVL) + 1;
+    int i;
+
+    if (reg >= max_vq * 16) {
+        return 0;
+    }
+
+    /* If ZA is unset, or reg out of range, the contents are zero. */
+    if (FIELD_EX64(env->svcr, SVCR, ZA) && reg < cur_vq * 16) {
+        for (i = 0; i < cur_vq; i++) {
+            env->zarray[reg].d[i * 2 + 1] = *p++;
+            env->zarray[reg].d[i * 2 + 0] = *p++;
+        }
+    }
+    return max_vq * 16;
+}
+
 static void output_vector_union_type(GString *s, int reg_width,
                                      const char *name)
 {
@@ -379,3 +434,36 @@ int arm_gen_dynamic_svereg_xml(CPUState *cs, int orig_base_reg)
     info->num = base_reg - orig_base_reg;
     return info->num;
 }
+
+/*
+ * Generate the xml for SME, with matrix size set to the maximum
+ * for the cpu.  Returns the number of registers generated.
+ */
+int arm_gen_dynamic_zareg_xml(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    GString *s = g_string_new(NULL);
+    int vq = max_svq(cpu);
+    int row_count = vq * 16;
+    int row_width = vq * 128;
+    int i;
+
+    g_string_printf(s, "<?xml version=\"1.0\"?>");
+    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
+    g_string_append_printf(s, "<feature name=\"org.qemu.gdb.aarch64.za\">");
+
+    output_vector_union_type(s, row_width, "zav");
+
+    for (i = 0; i < row_count; i++) {
+        g_string_append_printf(s,
+                               "<reg name=\"za%d\" bitsize=\"%d\""
+                               " regnum=\"%d\" type=\"zav\"/>",
+                               i, row_width, base_reg + i);
+    }
+
+    g_string_append_printf(s, "</feature>");
+
+    cpu->dyn_zareg_xml.num = row_count;
+    cpu->dyn_zareg_xml.desc = g_string_free(s, false);
+    return row_count;
+}
-- 
2.34.1


