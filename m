Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C89D7C63F2
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4m-0006fl-QG; Thu, 12 Oct 2023 00:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4i-0006Tz-Ld
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:29 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4g-0002hm-Fh
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:28 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5859b1c92a0so426062a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084004; x=1697688804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+SVeuJDU73Mhx2ICBj7Pvm9Vz0EkZFqrjLXREeYNGk=;
 b=GSLxj++KpgRNQPTNpOpVZlUHlRIs6xJpLfHUh61YoClxnRkVD6gLJCv/VCEM2/JnBN
 EHhPgS94reLa8mb5IkO7tLGKiXjEBueOIEh1cErCbLm3qmbLYH/52+ekRN3cm1beaEuE
 +7S0nJDDzSPsgtwJrhkosnVu/2SC3FjEX1Qf4sM/g078o7MOeOPrZjJW/vze+7Rh4FjV
 en5tvsubVwm2twlXiq/KBNhQMOIpnmJeJiomm8UnpMIydHofQdu6wnJ+CRpSdCBCa/me
 W9XPq2kSHaf8Zgxu9NiT9yDGHSFkpviJ8k6CySIXDuugYU2dCrEe5rjxj/0ZhsDZmZ7n
 taDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084004; x=1697688804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+SVeuJDU73Mhx2ICBj7Pvm9Vz0EkZFqrjLXREeYNGk=;
 b=JIrfj1xmcRYCThEU8Cuft2oGptI2/+app+syeVFVMQNANdkrHsrUsnc+zEqjA8xp+8
 Shf0Y93x7lnvWVtuX0ZWn9cn9Y4U3gMLDwC5Odaghn8TtYnnMe5bYjyXxaazdh6ak/OG
 0HLwlICgrMvPhssk+6Wc6Kd+b6E37AhglXoCeii8RYyQr8uQiYvRmMaLDyfflDaCSv2f
 bwyXqrPycSVstv8l/avlynr1L+l3TqPAQzpwOAYiuEGF+QfmMCLyg//2f7wR65+apcu0
 KmheJs5OK3rClKmfgvfBSk0lWD+obnDxMlfR+0sHQEM/iQbJ/SU5UN7K7sN9q4WbxYsO
 cd0w==
X-Gm-Message-State: AOJu0YytwR/+7jJ1GdONBfDESAUKPYwCOkYaV2F5JEL1Ijhv5tCK0pFv
 PWh74NO99PnrfdM86F3xmiaf6juwl6YssA==
X-Google-Smtp-Source: AGHT+IGugfHvitBDVcdwWdWA4Y+5gbFlke4dCYRxruvjA7epmdkpM2HIhULrpuLmRxA8U/zGqG0GMw==
X-Received: by 2002:a05:6a20:9188:b0:14c:d494:77c5 with SMTP id
 v8-20020a056a20918800b0014cd49477c5mr28001298pzd.13.1697084004600; 
 Wed, 11 Oct 2023 21:13:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:23 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/54] target/riscv/cpu.c: export isa_edata_arr[]
Date: Thu, 12 Oct 2023 14:10:37 +1000
Message-ID: <20231012041051.2572507-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This array will be read by the TCG accel class, allowing it to handle
priv spec verifications on its own. The array will remain here in cpu.c
because it's also used by the riscv,isa string function.

To export it we'll finish it with an empty element since ARRAY_SIZE()
won't work outside of cpu.c. Get rid of its ARRAY_SIZE() usage now to
alleviate the changes for the next patch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-19-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  7 +++++++
 target/riscv/cpu.c | 47 +++++++++++++++++++++-------------------------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 089c7e6d95..6eef1f697e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -726,6 +726,13 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern Property riscv_cpu_options[];
 
+typedef struct isa_ext_data {
+    const char *name;
+    int min_version;
+    int ext_enable_offset;
+} RISCVIsaExtData;
+extern const RISCVIsaExtData isa_edata_arr[];
+
 void riscv_add_satp_mode_properties(Object *obj);
 
 /* CSR function table */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d758d61ff8..989610ff90 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -41,15 +41,6 @@ static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
 const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
                               RVC, RVS, RVU, RVH, RVJ, RVG, 0};
 
-struct isa_ext_data {
-    const char *name;
-    int min_version;
-    int ext_enable_offset;
-};
-
-#define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
-    {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
-
 /*
  * From vector_helper.c
  * Note that vector data is stored in host-endian 64-bit chunks,
@@ -61,6 +52,9 @@ struct isa_ext_data {
 #define BYTE(x)   (x)
 #endif
 
+#define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
+    {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+
 /*
  * Here are the ordering rules of extension naming defined by RISC-V
  * specification :
@@ -81,7 +75,7 @@ struct isa_ext_data {
  * Single letter extensions are checked in riscv_cpu_validate_misa_priv()
  * instead.
  */
-static const struct isa_ext_data isa_edata_arr[] = {
+const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_icbom),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_icboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
@@ -160,6 +154,8 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempair),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
+
+    DEFINE_PROP_END_OF_LIST(),
 };
 
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
@@ -178,14 +174,14 @@ void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en)
 
 int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
 {
-    int i;
+    const RISCVIsaExtData *edata;
 
-    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_edata_arr[i].ext_enable_offset != ext_offset) {
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->ext_enable_offset != ext_offset) {
             continue;
         }
 
-        return isa_edata_arr[i].min_version;
+        return edata->min_version;
     }
 
     g_assert_not_reached();
@@ -932,22 +928,21 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
-    int i;
+    const RISCVIsaExtData *edata;
 
     /* Force disable extensions if priv spec version does not match */
-    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, isa_edata_arr[i].ext_enable_offset) &&
-            (env->priv_ver < isa_edata_arr[i].min_version)) {
-            isa_ext_update_enabled(cpu, isa_edata_arr[i].ext_enable_offset,
-                                   false);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
+            (env->priv_ver < edata->min_version)) {
+            isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
                         " because privilege spec version does not match",
-                        isa_edata_arr[i].name, env->mhartid);
+                        edata->name, env->mhartid);
 #else
             warn_report("disabling %s extension because "
                         "privilege spec version does not match",
-                        isa_edata_arr[i].name);
+                        edata->name);
 #endif
         }
     }
@@ -1615,13 +1610,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
                                  int max_str_len)
 {
+    const RISCVIsaExtData *edata;
     char *old = *isa_str;
     char *new = *isa_str;
-    int i;
 
-    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, isa_edata_arr[i].ext_enable_offset)) {
-            new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
+            new = g_strconcat(old, "_", edata->name, NULL);
             g_free(old);
             old = new;
         }
-- 
2.41.0


