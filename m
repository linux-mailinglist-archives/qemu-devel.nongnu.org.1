Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B888991249D
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jun 2024 14:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcw9-0004Wv-Pf; Fri, 21 Jun 2024 08:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcvu-0004NR-Pl
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:00:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcvs-0003Db-0K
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 07:59:58 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f9885d5c04so17217355ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718971194; x=1719575994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyCbvdO0NvGDukWKoDCcg2PDF5fSv3YSiVkjYJYlJTc=;
 b=XhQRtR3iDmXIgA5HmANESYQvBYF2LWrYnhc5BGm04gHJKucpIbc4SW6qyfkbDeIFQ+
 xlOtxQd4Fg1IUqMYo6aqGb/gT1SR20MAVCuBp0GRT5wjg4uhmbF/P3tjDdwG4y9tbGFR
 MpRMvQ0WTF0cyjqsCsXa/teggyJTcXFNP1OPKuP/1+0LqB6u9y/RQ3hw/rCUNd3YeKA0
 a83AjV4rZ1xyyY7vyO333Cw/QBK8TszHQ3oFkzEEGX4EtCBw8j5CKogHLI1N37k08vSs
 CfOF5b47yPW0ITrtE1IETOBQXiLCk12vNZWTlCr1sX6nB0ZkLRQc6J1kExgzvPgLL9Mg
 DctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718971194; x=1719575994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SyCbvdO0NvGDukWKoDCcg2PDF5fSv3YSiVkjYJYlJTc=;
 b=b+fJ+f8oFBSMq9ppcIFxz09iW2og5ZfvglcOK2foUZuPr+i++rMC+PGMIebSdCYci5
 GiWGKtR1x6hU4WL1pVVhjJ+lTclm50YWTJBpfDPDp8my4bWpETYJ4Imj4mbI71mrafy4
 lgqYNMGXzX+J+haaWchQU4gUu+i1aBBBJk1EiZsoX26Qw+JfCanN9RsrYQkrZcxV0CH1
 La1+ncTBsLf1ZzxojxsnX8ntSNZ3YH47YQK3YJvuaXNxoqFqtw0qvF4rypwJnshmXSvv
 sp1iEyR8aDaeONgoCCM8THN8XC08sMq+C9IJcubJCeDOxRD8pXIAPUgcUO4ETey1iCy8
 YErg==
X-Gm-Message-State: AOJu0Yysp4IE1h7qA402HReOSBONaoJVWICGx9iHpbtCYvJe1T6JuTks
 aoGn0hRJCBYm+gJ3A1HIHApYX5dhrfniNiIWJA6ohLbyTSXDOIAUJuOeHjeOXwKZDt1fi01HVLZ
 Q
X-Google-Smtp-Source: AGHT+IFf58KkwLKqh+qGPVhAHwrcgPglTYuFMYf5nkl/H3HJ9wb3Wo++bau2lVoq2mA0OcIt9gs91A==
X-Received: by 2002:a17:902:e742:b0:1f9:fca9:742d with SMTP id
 d9443c01a7336-1f9fca977e3mr3868115ad.37.1718971194098; 
 Fri, 21 Jun 2024 04:59:54 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbb606dsm12422995ad.270.2024.06.21.04.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 04:59:53 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 07/15] tests/qtest/bios-tables-test.c: Set "arch" for x86
 tests
Date: Fri, 21 Jun 2024 17:28:58 +0530
Message-Id: <20240621115906.1049832-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To search for expected AML files under ${arch}/${machine} path, set this
field for X86 related test cases.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/qtest/bios-tables-test.c | 77 ++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 007c281c9a..f4c4704bab 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -933,6 +933,7 @@ static void test_acpi_piix4_tcg(void)
      * This is to make guest actually run.
      */
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
     test_acpi_one(NULL, &data);
@@ -944,6 +945,7 @@ static void test_acpi_piix4_tcg_bridge(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".bridge";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -981,6 +983,7 @@ static void test_acpi_piix4_no_root_hotplug(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".roothp";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -997,6 +1000,7 @@ static void test_acpi_piix4_no_bridge_hotplug(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".hpbridge";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -1013,6 +1017,7 @@ static void test_acpi_piix4_no_acpi_pci_hotplug(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".hpbrroot";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -1034,6 +1039,7 @@ static void test_acpi_q35_tcg(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch = "x86";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
     test_acpi_one(NULL, &data);
@@ -1049,6 +1055,7 @@ static void test_acpi_q35_kvm_type4_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".type4-count",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1065,6 +1072,7 @@ static void test_acpi_q35_kvm_core_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".core-count",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1082,6 +1090,7 @@ static void test_acpi_q35_kvm_core_count2(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".core-count2",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1099,6 +1108,7 @@ static void test_acpi_q35_kvm_thread_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".thread-count",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1116,6 +1126,7 @@ static void test_acpi_q35_kvm_thread_count2(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".thread-count2",
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
@@ -1134,6 +1145,7 @@ static void test_acpi_q35_tcg_bridge(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".bridge";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -1148,6 +1160,7 @@ static void test_acpi_q35_tcg_no_acpi_hotplug(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".noacpihp";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
@@ -1176,6 +1189,7 @@ static void test_acpi_q35_multif_bridge(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".multi-bridge",
     };
     test_vm_prepare("-S"
@@ -1225,6 +1239,7 @@ static void test_acpi_q35_tcg_mmio64(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".mmio64",
         .tcg_only = true,
         .required_struct_types = base_required_struct_types,
@@ -1245,6 +1260,7 @@ static void test_acpi_piix4_tcg_cphp(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".cphp";
     test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
                   " -object memory-backend-ram,id=ram0,size=64M"
@@ -1260,6 +1276,7 @@ static void test_acpi_q35_tcg_cphp(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".cphp";
     test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
                   " -object memory-backend-ram,id=ram0,size=64M"
@@ -1279,6 +1296,7 @@ static void test_acpi_q35_tcg_ipmi(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".ipmibt";
     data.required_struct_types = ipmi_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
@@ -1293,6 +1311,7 @@ static void test_acpi_q35_tcg_smbus_ipmi(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".ipmismbus";
     data.required_struct_types = ipmi_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
@@ -1310,6 +1329,7 @@ static void test_acpi_piix4_tcg_ipmi(void)
      * This is to make guest actually run.
      */
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".ipmikcs";
     data.required_struct_types = ipmi_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
@@ -1324,6 +1344,7 @@ static void test_acpi_q35_tcg_memhp(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".memhp";
     test_acpi_one(" -m 128,slots=3,maxmem=1G"
                   " -object memory-backend-ram,id=ram0,size=64M"
@@ -1339,6 +1360,7 @@ static void test_acpi_piix4_tcg_memhp(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".memhp";
     test_acpi_one(" -m 128,slots=3,maxmem=1G"
                   " -object memory-backend-ram,id=ram0,size=64M"
@@ -1354,6 +1376,7 @@ static void test_acpi_piix4_tcg_nosmm(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".nosmm";
     test_acpi_one("-machine smm=off", &data);
     free_test_data(&data);
@@ -1364,6 +1387,7 @@ static void test_acpi_piix4_tcg_smm_compat(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".smm-compat";
     test_acpi_one("-global PIIX4_PM.smm-compat=on", &data);
     free_test_data(&data);
@@ -1374,6 +1398,7 @@ static void test_acpi_piix4_tcg_smm_compat_nosmm(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".smm-compat-nosmm";
     test_acpi_one("-global PIIX4_PM.smm-compat=on -machine smm=off", &data);
     free_test_data(&data);
@@ -1384,6 +1409,7 @@ static void test_acpi_piix4_tcg_nohpet(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.machine_param = ",hpet=off";
     data.variant = ".nohpet";
     test_acpi_one(NULL, &data);
@@ -1395,6 +1421,7 @@ static void test_acpi_q35_tcg_numamem(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".numamem";
     test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
                   " -numa node -numa node,memdev=ram0", &data);
@@ -1406,6 +1433,7 @@ static void test_acpi_q35_kvm_xapic(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".xapic";
     test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
                   " -numa node -numa node,memdev=ram0"
@@ -1418,6 +1446,7 @@ static void test_acpi_q35_tcg_nosmm(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".nosmm";
     test_acpi_one("-machine smm=off", &data);
     free_test_data(&data);
@@ -1428,6 +1457,7 @@ static void test_acpi_q35_tcg_smm_compat(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".smm-compat";
     test_acpi_one("-global ICH9-LPC.smm-compat=on", &data);
     free_test_data(&data);
@@ -1438,6 +1468,7 @@ static void test_acpi_q35_tcg_smm_compat_nosmm(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".smm-compat-nosmm";
     test_acpi_one("-global ICH9-LPC.smm-compat=on -machine smm=off", &data);
     free_test_data(&data);
@@ -1448,6 +1479,7 @@ static void test_acpi_q35_tcg_nohpet(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.machine_param = ",hpet=off";
     data.variant = ".nohpet";
     test_acpi_one(NULL, &data);
@@ -1459,6 +1491,7 @@ static void test_acpi_q35_kvm_dmar(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".dmar";
     test_acpi_one("-machine kernel-irqchip=split -accel kvm"
                   " -device intel-iommu,intremap=on,device-iotlb=on", &data);
@@ -1470,6 +1503,7 @@ static void test_acpi_q35_tcg_ivrs(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86",
     data.variant = ".ivrs";
     data.tcg_only = true,
     test_acpi_one(" -device amd-iommu", &data);
@@ -1481,6 +1515,7 @@ static void test_acpi_piix4_tcg_numamem(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.variant = ".numamem";
     test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
                   " -numa node -numa node,memdev=ram0", &data);
@@ -1489,8 +1524,9 @@ static void test_acpi_piix4_tcg_numamem(void)
 
 uint64_t tpm_tis_base_addr;
 
-static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
-                              uint64_t base, enum TPMVersion tpm_version)
+static void test_acpi_tcg_tpm(const char *machine, const char *arch,
+                              const char *tpm_if, uint64_t base,
+                              enum TPMVersion tpm_version)
 {
     gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
                                           machine, tpm_if);
@@ -1517,6 +1553,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
     tpm_emu_test_wait_cond(&test);
 
     data.machine = machine;
+    data.arch = arch;
     data.variant = variant;
 
     args = g_strdup_printf(
@@ -1540,19 +1577,20 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
 
 static void test_acpi_q35_tcg_tpm2_tis(void)
 {
-    test_acpi_tcg_tpm("q35", "tis", 0xFED40000, TPM_VERSION_2_0);
+    test_acpi_tcg_tpm("q35", "x86", "tis", 0xFED40000, TPM_VERSION_2_0);
 }
 
 static void test_acpi_q35_tcg_tpm12_tis(void)
 {
-    test_acpi_tcg_tpm("q35", "tis", 0xFED40000, TPM_VERSION_1_2);
+    test_acpi_tcg_tpm("q35", "x86", "tis", 0xFED40000, TPM_VERSION_1_2);
 }
 
-static void test_acpi_tcg_dimm_pxm(const char *machine)
+static void test_acpi_tcg_dimm_pxm(const char *machine, const char *arch)
 {
     test_data data = {};
 
     data.machine = machine;
+    data.arch    = arch;
     data.variant = ".dimmpxm";
     test_acpi_one(" -machine nvdimm=on,nvdimm-persistence=cpu"
                   " -smp 4,sockets=4"
@@ -1579,12 +1617,12 @@ static void test_acpi_tcg_dimm_pxm(const char *machine)
 
 static void test_acpi_q35_tcg_dimm_pxm(void)
 {
-    test_acpi_tcg_dimm_pxm(MACHINE_Q35);
+    test_acpi_tcg_dimm_pxm(MACHINE_Q35, "x86");
 }
 
 static void test_acpi_piix4_tcg_dimm_pxm(void)
 {
-    test_acpi_tcg_dimm_pxm(MACHINE_PC);
+    test_acpi_tcg_dimm_pxm(MACHINE_PC, "x86");
 }
 
 static void test_acpi_aarch64_virt_tcg_memhp(void)
@@ -1621,6 +1659,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
 static void test_acpi_microvm_prepare(test_data *data)
 {
     data->machine = "microvm";
+    data->arch = "x86";
     data->required_struct_types = NULL; /* no smbios */
     data->required_struct_types_len = 0;
     data->blkdev = "virtio-blk-device";
@@ -1737,11 +1776,12 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
     free_test_data(&data);
 }
 
-static void test_acpi_tcg_acpi_hmat(const char *machine)
+static void test_acpi_tcg_acpi_hmat(const char *machine, const char *arch)
 {
     test_data data = {};
 
     data.machine = machine;
+    data.arch    = arch;
     data.variant = ".acpihmat";
     test_acpi_one(" -machine hmat=on"
                   " -smp 2,sockets=2"
@@ -1770,12 +1810,12 @@ static void test_acpi_tcg_acpi_hmat(const char *machine)
 
 static void test_acpi_q35_tcg_acpi_hmat(void)
 {
-    test_acpi_tcg_acpi_hmat(MACHINE_Q35);
+    test_acpi_tcg_acpi_hmat(MACHINE_Q35, "x86");
 }
 
 static void test_acpi_piix4_tcg_acpi_hmat(void)
 {
-    test_acpi_tcg_acpi_hmat(MACHINE_PC);
+    test_acpi_tcg_acpi_hmat(MACHINE_PC, "x86");
 }
 
 static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
@@ -1841,6 +1881,7 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86";
     data.variant = ".acpihmat-noinitiator";
     test_acpi_one(" -machine hmat=on"
                   " -smp 4,sockets=2"
@@ -1884,13 +1925,14 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
 }
 
 #ifdef CONFIG_POSIX
-static void test_acpi_erst(const char *machine)
+static void test_acpi_erst(const char *machine, const char *arch)
 {
     gchar *tmp_path = g_dir_make_tmp("qemu-test-erst.XXXXXX", NULL);
     gchar *params;
     test_data data = {};
 
     data.machine = machine;
+    data.arch    = arch;
     data.variant = ".acpierst";
     params = g_strdup_printf(
         " -object memory-backend-file,id=erstnvram,"
@@ -1905,12 +1947,12 @@ static void test_acpi_erst(const char *machine)
 
 static void test_acpi_piix4_acpi_erst(void)
 {
-    test_acpi_erst(MACHINE_PC);
+    test_acpi_erst(MACHINE_PC, "x86");
 }
 
 static void test_acpi_q35_acpi_erst(void)
 {
-    test_acpi_erst(MACHINE_Q35);
+    test_acpi_erst(MACHINE_Q35, "x86");
 }
 
 static void test_acpi_microvm_acpi_erst(void)
@@ -1978,6 +2020,7 @@ static void test_acpi_q35_viot(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".viot",
     };
 
@@ -2002,6 +2045,7 @@ static void test_acpi_q35_cxl(void)
 
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".cxl",
     };
     /*
@@ -2067,6 +2111,7 @@ static void test_acpi_q35_slic(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".slic",
     };
 
@@ -2081,6 +2126,7 @@ static void test_acpi_q35_applesmc(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".applesmc",
     };
 
@@ -2094,6 +2140,7 @@ static void test_acpi_q35_pvpanic_isa(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
+        .arch    = "x86",
         .variant = ".pvpanic-isa",
     };
 
@@ -2106,6 +2153,7 @@ static void test_acpi_pc_smbios_options(void)
     uint8_t req_type11[] = { 11 };
     test_data data = {
         .machine = MACHINE_PC,
+        .arch    = "x86",
         .variant = ".pc_smbios_options",
         .required_struct_types = req_type11,
         .required_struct_types_len = ARRAY_SIZE(req_type11),
@@ -2120,6 +2168,7 @@ static void test_acpi_pc_smbios_blob(void)
     uint8_t req_type11[] = { 11 };
     test_data data = {
         .machine = MACHINE_PC,
+        .arch    = "x86",
         .variant = ".pc_smbios_blob",
         .required_struct_types = req_type11,
         .required_struct_types_len = ARRAY_SIZE(req_type11),
@@ -2169,6 +2218,7 @@ static void test_acpi_piix4_oem_fields(void)
     test_data data = {};
 
     data.machine = MACHINE_PC;
+    data.arch    = "x86";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
 
@@ -2187,6 +2237,7 @@ static void test_acpi_q35_oem_fields(void)
     test_data data = {};
 
     data.machine = MACHINE_Q35;
+    data.arch    = "x86";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
 
-- 
2.40.1


