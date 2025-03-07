Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A00A57174
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Mar 2025 20:20:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdDK-0002Mr-HI; Fri, 07 Mar 2025 14:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqdA0-0004nW-PI; Fri, 07 Mar 2025 14:15:06 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqd9w-0007mn-Bh; Fri, 07 Mar 2025 14:15:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8EA70A45138;
 Fri,  7 Mar 2025 19:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC9DC4CEE2;
 Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741374897;
 bh=1rCl2eTVfeSjBvMZGH7cPpYPqJpYpdPaYN4Yf5cB6OE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xv16ruFL4PDfP7zvxLRhCRw0kAbdigMnig+yfJ1uNkGhWwcGu3R3oZU3OLTQrkSbA
 0Xag8iRQw65UOtMcJAmMkCyGMyUOKShjE1IRJ2hJU7mq7MWBPt3Ru7BzX+LllEK/zX
 xQb24gNq9deNWgsK2LFN2TBzC1Cv9TgiACjSzih2J8Svu2coj7fmdDGxzbncfUkZ30
 aEFKnp5qU6htABQT3jtdLvuiYWJAQt+fnvGM2GZVdJwMaW5O/IOjlwS6piyFiAb3de
 /JP2HYnyvmXslfNeVL7ODx7T2Cjan4qaUfMsaPmiNS27s2uZ2wkf5TC2bNfWpEGbIn
 9RSM2nKePY3xA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqd9r-0000000BQmf-3J00; Fri, 07 Mar 2025 20:14:55 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Gavin Shan" <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/20] acpi/ghes: prepare to change the way HEST offsets
 are calculated
Date: Fri,  7 Mar 2025 20:14:35 +0100
Message-ID: <f0509ad177b055a08ec18e700e813e8be3e76938.1741374594.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741374594.git.mchehab+huawei@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a new ags flag to change the way HEST offsets are calculated.
Currently, offsets needed to store ACPI HEST offsets and read ack
are calculated based on a previous knowledge from the logic
which creates the HEST table.

Such logic is not generic, not allowing to easily add more HEST
entries nor replicates what OSPM does.

As the next patches will be adding a more generic logic, add a
new use_hest_addr, set to false, in preparation for such changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c           | 39 ++++++++++++++++++++++++---------------
 hw/arm/virt-acpi-build.c | 13 ++++++++++---
 include/hw/acpi/ghes.h   | 12 +++++++++++-
 3 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 84b891fd3dcf..9243b5ad4acb 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -206,7 +206,8 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
+static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
+                                   BIOSLinker *linker)
 {
     int i, error_status_block_offset;
 
@@ -251,13 +252,15 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
                                        i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
     }
 
-    /*
-     * tell firmware to write hardware_errors GPA into
-     * hardware_errors_addr fw_cfg, once the former has been initialized.
-     */
-    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
-                                     sizeof(uint64_t),
-                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
+    if (!ags->use_hest_addr) {
+        /*
+         * Tell firmware to write hardware_errors GPA into
+         * hardware_errors_addr fw_cfg, once the former has been initialized.
+         */
+        bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE,
+                                         0, sizeof(uint64_t),
+                                         ACPI_HW_ERROR_FW_CFG_FILE, 0);
+    }
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
@@ -331,14 +334,15 @@ static void build_ghes_v2(GArray *table_data,
 }
 
 /* Build Hardware Error Source Table */
-void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
+                     GArray *hardware_errors,
                      BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
-    build_ghes_error_table(hardware_errors, linker);
+    build_ghes_error_table(ags, hardware_errors, linker);
 
     acpi_table_begin(&table, table_data);
 
@@ -357,9 +361,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
-    /* Create a read-write fw_cfg file for Address */
-    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
+    if (!ags->use_hest_addr) {
+        /* Create a read-write fw_cfg file for Address */
+        fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
+            NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
+    }
 }
 
 static void get_hw_error_offsets(uint64_t ghes_addr,
@@ -395,8 +401,11 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     }
 
     assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
-    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
-                         &cper_addr, &read_ack_register_addr);
+
+    if (!ags->use_hest_addr) {
+        get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
+                             &cper_addr, &read_ack_register_addr);
+    }
 
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e17861..040d875d4e83 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -946,9 +946,16 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_dbg2(tables_blob, tables->linker, vms);
 
     if (vms->ras) {
-        acpi_add_table(table_offsets, tables_blob);
-        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
-                        vms->oem_id, vms->oem_table_id);
+        AcpiGedState *acpi_ged_state;
+        AcpiGhesState *ags;
+
+        acpi_ged_state = ACPI_GED(vms->acpi_dev);
+        ags = &acpi_ged_state->ghes_state;
+        if (ags) {
+            acpi_add_table(table_offsets, tables_blob);
+            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
+                            tables->linker, vms->oem_id, vms->oem_table_id);
+        }
     }
 
     if (ms->numa_state->num_nodes > 0) {
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index f96ac3e85ca2..411f592662af 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -64,11 +64,21 @@ enum {
     ACPI_GHES_ERROR_SOURCE_COUNT
 };
 
+/*
+ * AcpiGhesState stores GPA values that will be used to fill HEST entries.
+ *
+ * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
+ * is stored at hw_error_le. This is the default on QEMU 9.x.
+ *
+ * An GPA value equal to zero means that GHES is not present.
+ */
 typedef struct AcpiGhesState {
     uint64_t hw_error_le;
+    bool use_hest_addr;         /* Currently, always false */
 } AcpiGhesState;
 
-void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
+                     GArray *hardware_errors,
                      BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
-- 
2.48.1


