Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8935076C8A0
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:48:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR7WK-0007VI-3f; Wed, 02 Aug 2023 04:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR7WG-00077S-CL
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:47:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR7WD-0005fm-KU
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:47:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-686ba97e4feso6385273b3a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690966064; x=1691570864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8f63ib9JJpmtDwfqHTeNpttYdeUJZ0jujL0l8UUZXLo=;
 b=fwoQv2RMvfk/GQV42KIJXb0OMDfgcuvgl+TrjN+4fOZPAnjb3FJCcHTMmKLR7VaNcm
 lr6UADOmQNcli+7z5accaCSH4O3M0QjsKze9GkZqiKZ50V7jFsMk0LMg9tJDPjljDtNt
 Gr/x5BAGdJJa51Druk4VSNRQkK/J1TIi96IZ+M0HVKWl4S9I1eQMDMOFqzCcwaN7W6FI
 c6ivkIZ7DPUy0ZmDcmt6BTXiFiVKQwQ+GGQ91EJ9YGI7850jBKkn+fCoUG/L8LuM58Z3
 8TkPIKIU3YjFYuyhpSS8GBZFmIIQD6R77/A2qgF30Kjl18C1MSUpjvdvSfRUfDj2iQ7b
 TUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690966064; x=1691570864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8f63ib9JJpmtDwfqHTeNpttYdeUJZ0jujL0l8UUZXLo=;
 b=hi7Iw3bTr0TzH080WxxKRwpZhfmVS32tv212s726x5PGULMTu3FBsF0ODMWlRVGqaG
 0oOege/UvqoMpFloEWoI0FfJLr6A/42gqhX3byVPI6pPH7Rnb9r5udbh7f4YA5HMrg3f
 PQVGkYEdtDsR0smCQ1AWE4br9CFBNRr6d1R58pWzOl+CNtcPcjBNliJlsM4Fc8UTMpey
 /jTKjqHktuwzhKSx2wt9y+wsmKGUH6+pN8z4mM9xMRJEJv+KiSaYqlKzbaFcgk6yohgi
 enLqA9Q2PCICiegwsYqytl6binjc43gEINs7eiAEHSphFRePBAmHNNXljBSh8gDPdbMT
 A9KA==
X-Gm-Message-State: ABy/qLYrgXDqWC7hu14ZXYIIMxcHAJt84dUugxRC0+8ag8225c2M2eCb
 MndAwjfgln5AIX5egTs1DT2L2g==
X-Google-Smtp-Source: APBJJlETkxoDxTZWrkkmY0/jiqqcRhfmqaYPfzCc5RZvPIQTt3cmhJeyRz44IIEHMQKP53rxK0r6Lg==
X-Received: by 2002:a05:6a21:329f:b0:131:47f7:e811 with SMTP id
 yt31-20020a056a21329f00b0013147f7e811mr19660432pzb.22.1690966064021; 
 Wed, 02 Aug 2023 01:47:44 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 j22-20020aa79296000000b00659b8313d08sm10592860pfa.78.2023.08.02.01.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 01:47:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 07/24] target/arm: Use GDBFeature for dynamic XML
Date: Wed,  2 Aug 2023 17:45:55 +0900
Message-ID: <20230802084614.23619-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802084614.23619-1-akihiko.odaki@daynix.com>
References: <20230802084614.23619-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In preparation for a change to use GDBFeature as a parameter of
gdb_register_coprocessor(), convert the internal representation of
dynamic feature from plain XML to GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h       | 20 +++++------
 target/arm/internals.h |  2 +-
 target/arm/gdbstub.c   | 80 +++++++++++++++++++++++-------------------
 target/arm/gdbstub64.c | 11 +++---
 4 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88e5accda6..d6c2378d05 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -136,23 +136,21 @@ enum {
  */
 
 /**
- * DynamicGDBXMLInfo:
- * @desc: Contains the XML descriptions.
- * @num: Number of the registers in this XML seen by GDB.
+ * DynamicGDBFeatureInfo:
+ * @desc: Contains the feature descriptions.
  * @data: A union with data specific to the set of registers
  *    @cpregs_keys: Array that contains the corresponding Key of
  *                  a given cpreg with the same order of the cpreg
  *                  in the XML description.
  */
-typedef struct DynamicGDBXMLInfo {
-    char *desc;
-    int num;
+typedef struct DynamicGDBFeatureInfo {
+    GDBFeature desc;
     union {
         struct {
             uint32_t *keys;
         } cpregs;
     } data;
-} DynamicGDBXMLInfo;
+} DynamicGDBFeatureInfo;
 
 /* CPU state for each instance of a generic timer (in cp15 c14) */
 typedef struct ARMGenericTimer {
@@ -881,10 +879,10 @@ struct ArchCPU {
     uint64_t *cpreg_vmstate_values;
     int32_t cpreg_vmstate_array_len;
 
-    DynamicGDBXMLInfo dyn_sysreg_xml;
-    DynamicGDBXMLInfo dyn_svereg_xml;
-    DynamicGDBXMLInfo dyn_m_systemreg_xml;
-    DynamicGDBXMLInfo dyn_m_secextreg_xml;
+    DynamicGDBFeatureInfo dyn_sysreg_feature;
+    DynamicGDBFeatureInfo dyn_svereg_feature;
+    DynamicGDBFeatureInfo dyn_m_systemreg_feature;
+    DynamicGDBFeatureInfo dyn_m_secextreg_feature;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0f01bc32a8..8421a755af 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1388,7 +1388,7 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
 }
 
 #ifdef TARGET_AARCH64
-int arm_gen_dynamic_svereg_xml(CPUState *cpu, int base_reg);
+GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUARMState *env, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUARMState *env, uint8_t *buf, int reg);
 int aarch64_gdb_get_fpu_reg(CPUARMState *env, GByteArray *buf, int reg);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index f421c5d041..cd35bac013 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -25,11 +25,11 @@
 #include "internals.h"
 #include "cpregs.h"
 
-typedef struct RegisterSysregXmlParam {
+typedef struct RegisterSysregFeatureParam {
     CPUState *cs;
     GString *s;
     int n;
-} RegisterSysregXmlParam;
+} RegisterSysregFeatureParam;
 
 /* Old gdb always expect FPA registers.  Newer (xml-aware) gdb only expect
    whatever the target description contains.  Due to a historical mishap
@@ -243,7 +243,7 @@ static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
     const ARMCPRegInfo *ri;
     uint32_t key;
 
-    key = cpu->dyn_sysreg_xml.data.cpregs.keys[reg];
+    key = cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
         if (cpreg_field_is_64bit(ri)) {
@@ -260,7 +260,8 @@ static int arm_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
-static void arm_gen_one_xml_sysreg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
+static void arm_gen_one_feature_sysreg(GString *s,
+                                       DynamicGDBFeatureInfo *dyn_feature,
                                        ARMCPRegInfo *ri, uint32_t ri_key,
                                        int bitsize, int regnum)
 {
@@ -268,25 +269,25 @@ static void arm_gen_one_xml_sysreg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
     g_string_append_printf(s, " bitsize=\"%d\"", bitsize);
     g_string_append_printf(s, " regnum=\"%d\"", regnum);
     g_string_append_printf(s, " group=\"cp_regs\"/>");
-    dyn_xml->data.cpregs.keys[dyn_xml->num] = ri_key;
-    dyn_xml->num++;
+    dyn_feature->data.cpregs.keys[dyn_feature->desc.num_regs] = ri_key;
+    dyn_feature->desc.num_regs++;
 }
 
-static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
-                                        gpointer p)
+static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
+                                            gpointer p)
 {
     uint32_t ri_key = (uintptr_t)key;
     ARMCPRegInfo *ri = value;
-    RegisterSysregXmlParam *param = (RegisterSysregXmlParam *)p;
+    RegisterSysregFeatureParam *param = (RegisterSysregFeatureParam *)p;
     GString *s = param->s;
     ARMCPU *cpu = ARM_CPU(param->cs);
     CPUARMState *env = &cpu->env;
-    DynamicGDBXMLInfo *dyn_xml = &cpu->dyn_sysreg_xml;
+    DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
-                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64,
+                arm_gen_one_feature_sysreg(s , dyn_feature, ri, ri_key, 64,
                                            param->n++);
             }
         } else {
@@ -296,10 +297,10 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
                     return;
                 }
                 if (ri->type & ARM_CP_64BIT) {
-                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64,
+                    arm_gen_one_feature_sysreg(s , dyn_feature, ri, ri_key, 64,
                                                param->n++);
                 } else {
-                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32,
+                    arm_gen_one_feature_sysreg(s , dyn_feature, ri, ri_key, 32,
                                                param->n++);
                 }
             }
@@ -307,21 +308,24 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
     }
 }
 
-static int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
+static GDBFeature *arm_gen_dynamic_sysreg_feature(CPUState *cs, int base_reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GString *s = g_string_new(NULL);
-    RegisterSysregXmlParam param = {cs, s, base_reg};
+    RegisterSysregFeatureParam param = {cs, s, base_reg};
+    DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
+    gsize num_regs = g_hash_table_size(cpu->cp_regs);
 
-    cpu->dyn_sysreg_xml.num = 0;
-    cpu->dyn_sysreg_xml.data.cpregs.keys = g_new(uint32_t, g_hash_table_size(cpu->cp_regs));
+    dyn_feature->desc.num_regs = 0;
+    dyn_feature->data.cpregs.keys = g_new(uint32_t, num_regs);
     g_string_printf(s, "<?xml version=\"1.0\"?>");
     g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
     g_string_append_printf(s, "<feature name=\"org.qemu.gdb.arm.sys.regs\">");
-    g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_xml, &param);
+    g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_feature, &param);
     g_string_append_printf(s, "</feature>");
-    cpu->dyn_sysreg_xml.desc = g_string_free(s, false);
-    return cpu->dyn_sysreg_xml.num;
+    dyn_feature->desc.xmlname = "system-registers.xml";
+    dyn_feature->desc.xml = g_string_free(s, false);
+    return &dyn_feature->desc;
 }
 
 #ifdef CONFIG_TCG
@@ -413,7 +417,8 @@ static int arm_gdb_set_m_systemreg(CPUARMState *env, uint8_t *buf, int reg)
     return 0; /* TODO */
 }
 
-static int arm_gen_dynamic_m_systemreg_xml(CPUState *cs, int orig_base_reg)
+static GDBFeature *arm_gen_dynamic_m_systemreg_feature(CPUState *cs,
+                                                       int orig_base_reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -434,10 +439,11 @@ static int arm_gen_dynamic_m_systemreg_xml(CPUState *cs, int orig_base_reg)
     }
 
     g_string_append_printf(s, "</feature>");
-    cpu->dyn_m_systemreg_xml.desc = g_string_free(s, false);
-    cpu->dyn_m_systemreg_xml.num = base_reg - orig_base_reg;
+    cpu->dyn_m_systemreg_feature.desc.xmlname = "arm-m-system.xml";
+    cpu->dyn_m_systemreg_feature.desc.xml = g_string_free(s, false);
+    cpu->dyn_m_systemreg_feature.desc.num_regs = base_reg - orig_base_reg;
 
-    return cpu->dyn_m_systemreg_xml.num;
+    return &cpu->dyn_m_systemreg_feature.desc;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -455,7 +461,8 @@ static int arm_gdb_set_m_secextreg(CPUARMState *env, uint8_t *buf, int reg)
     return 0; /* TODO */
 }
 
-static int arm_gen_dynamic_m_secextreg_xml(CPUState *cs, int orig_base_reg)
+static GDBFeature *arm_gen_dynamic_m_secextreg_feature(CPUState *cs,
+                                                       int orig_base_reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GString *s = g_string_new(NULL);
@@ -476,10 +483,11 @@ static int arm_gen_dynamic_m_secextreg_xml(CPUState *cs, int orig_base_reg)
     }
 
     g_string_append_printf(s, "</feature>");
-    cpu->dyn_m_secextreg_xml.desc = g_string_free(s, false);
-    cpu->dyn_m_secextreg_xml.num = base_reg - orig_base_reg;
+    cpu->dyn_m_secextreg_feature.desc.xmlname = "arm-m-secext.xml";
+    cpu->dyn_m_secextreg_feature.desc.xml = g_string_free(s, false);
+    cpu->dyn_m_secextreg_feature.desc.num_regs = base_reg - orig_base_reg;
 
-    return cpu->dyn_m_secextreg_xml.num;
+    return &cpu->dyn_m_secextreg_feature.desc;
 }
 #endif
 #endif /* CONFIG_TCG */
@@ -489,14 +497,14 @@ const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
     ARMCPU *cpu = ARM_CPU(cs);
 
     if (strcmp(xmlname, "system-registers.xml") == 0) {
-        return cpu->dyn_sysreg_xml.desc;
+        return cpu->dyn_sysreg_feature.desc.xml;
     } else if (strcmp(xmlname, "sve-registers.xml") == 0) {
-        return cpu->dyn_svereg_xml.desc;
+        return cpu->dyn_svereg_feature.desc.xml;
     } else if (strcmp(xmlname, "arm-m-system.xml") == 0) {
-        return cpu->dyn_m_systemreg_xml.desc;
+        return cpu->dyn_m_systemreg_feature.desc.xml;
 #ifndef CONFIG_USER_ONLY
     } else if (strcmp(xmlname, "arm-m-secext.xml") == 0) {
-        return cpu->dyn_m_secextreg_xml.desc;
+        return cpu->dyn_m_secextreg_feature.desc.xml;
 #endif
     }
     return NULL;
@@ -514,7 +522,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
          */
 #ifdef TARGET_AARCH64
         if (isar_feature_aa64_sve(&cpu->isar)) {
-            int nreg = arm_gen_dynamic_svereg_xml(cs, cs->gdb_num_regs);
+            int nreg = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs)->num_regs;
             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
                                      aarch64_gdb_set_sve_reg, nreg,
                                      "sve-registers.xml", 0);
@@ -560,20 +568,20 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  1, "arm-m-profile-mve.xml", 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
+                             arm_gen_dynamic_sysreg_feature(cs, cs->gdb_num_regs)->num_regs,
                              "system-registers.xml", 0);
 
 #ifdef CONFIG_TCG
     if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) {
         gdb_register_coprocessor(cs,
             arm_gdb_get_m_systemreg, arm_gdb_set_m_systemreg,
-            arm_gen_dynamic_m_systemreg_xml(cs, cs->gdb_num_regs),
+            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_num_regs)->num_regs,
             "arm-m-system.xml", 0);
 #ifndef CONFIG_USER_ONLY
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             gdb_register_coprocessor(cs,
                 arm_gdb_get_m_secextreg, arm_gdb_set_m_secextreg,
-                arm_gen_dynamic_m_secextreg_xml(cs, cs->gdb_num_regs),
+                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_num_regs)->num_regs,
                 "arm-m-secext.xml", 0);
         }
 #endif
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index d7b79a6589..20483ef9bc 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -316,11 +316,11 @@ static void output_vector_union_type(GString *s, int reg_width,
     g_string_append(s, "</union>");
 }
 
-int arm_gen_dynamic_svereg_xml(CPUState *cs, int orig_base_reg)
+GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int orig_base_reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GString *s = g_string_new(NULL);
-    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
+    DynamicGDBFeatureInfo *info = &cpu->dyn_svereg_feature;
     int reg_width = cpu->sve_max_vq * 128;
     int pred_width = cpu->sve_max_vq * 16;
     int base_reg = orig_base_reg;
@@ -375,7 +375,8 @@ int arm_gen_dynamic_svereg_xml(CPUState *cs, int orig_base_reg)
 
     g_string_append_printf(s, "</feature>");
 
-    info->desc = g_string_free(s, false);
-    info->num = base_reg - orig_base_reg;
-    return info->num;
+    info->desc.xmlname = "sve-registers.xml";
+    info->desc.xml = g_string_free(s, false);
+    info->desc.num_regs = base_reg - orig_base_reg;
+    return &info->desc;
 }
-- 
2.41.0


