Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 941619D5F9D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Nov 2024 14:15:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tETUZ-0004cq-BG; Fri, 22 Nov 2024 08:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tETUT-0004WX-2a; Fri, 22 Nov 2024 08:14:29 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tETUP-0006Km-RE; Fri, 22 Nov 2024 08:14:28 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 74B78A40F63;
 Fri, 22 Nov 2024 13:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A95C4CED1;
 Fri, 22 Nov 2024 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732281264;
 bh=zWs77Bv9LDN+nj6UdLSrqXLaTY2BokIUNOhx+BmRi3M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RULDHQugjhg1S651NaI61CtQEwH+bmUw18TRsb3q1niDZBeNzPHgUpUgOXhCX2VAO
 +r0X0I1Yjj3Z4JHyMbJT3O4BWuoSmBStAZULNzCI0GeXD4/eabbqLmcMo9w1xM4Ac/
 mpRjde36Wx8XC4GDHP4KVgeI0SncEVDQ2KkGt7Qgb0DWtNcZf7VgiDCeknu/2oPu9p
 DSJWT6YI1KkWnBJJO+CeDPj1DK5bot/8dGwnoDmfY4CWo9gzPqwVo4lW3xctaCuSz0
 so2Xgcc0+F8DPP89HkfB5H9/79g0LX33K4VTOJDXONrnul0O69EdGT1jctZ9ZAi9df
 Ojg68K+tO3cng==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tETUM-00000006v9i-06zm; Fri, 22 Nov 2024 14:14:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] acpi/ghes: Prepare to support multiple sources on ghes
Date: Fri, 22 Nov 2024 14:14:11 +0100
Message-ID: <f9a37001a95bed9d04602613a92d29d156f62295.1732281080.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732281080.git.mchehab+huawei@kernel.org>
References: <cover.1732281080.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The current code is actually dependent on having just one error
structure with a single source.

As the number of sources should be arch-dependent, as it will depend on
what kind of synchronous/assynchronous notifications will exist, change
the logic to dynamically build the table.

Yet, for a proper support, we need to get the number of sources by
reading the number from the HEST table. However, bios currently doesn't
store a pointer to it.

For now just change the logic at table build time, while enforcing that
it will behave like before with a single source ID.

A future patch will add a HEST table bios pointer and change the logic
at acpi_ghes_record_errors() to dynamically use the new size.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c           | 43 ++++++++++++++++++++++++++--------------
 hw/arm/virt-acpi-build.c |  5 +++++
 include/hw/acpi/ghes.h   | 21 +++++++++++++-------
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b0b1865dc8d3..8c7d0d5cdb0c 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -206,17 +206,26 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
+static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
+                                   int num_sources)
 {
     int i, error_status_block_offset;
 
+    /*
+     * TODO: Current version supports only one source.
+     * A further patch will drop this check, after adding a proper migration
+     * code, as, for the code to work, we need to store a bios pointer to the
+     * HEST table.
+     */
+    assert(num_sources == 1);
+
     /* Build error_block_address */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
     }
 
     /* Build read_ack_register */
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         /*
          * Initialize the value of read_ack_register to 1, so GHES can be
          * writable after (re)boot.
@@ -231,13 +240,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 
     /* Reserve space for Error Status Data Block */
     acpi_data_push(hardware_errors,
-        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
+        ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
 
     /* Tell guest firmware to place hardware_errors blob into RAM */
     bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
                              hardware_errors, sizeof(uint64_t), false);
 
-    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+    for (i = 0; i < num_sources; i++) {
         /*
          * Tell firmware to patch error_block_address entries to point to
          * corresponding "Generic Error Status Block"
@@ -263,10 +272,12 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
 static void build_ghes_v2(GArray *table_data,
                           BIOSLinker *linker,
-                          enum AcpiGhesNotifyType notify,
-                          uint16_t source_id)
+                          const AcpiNotificationSourceId *notif_src,
+                          uint16_t index, int num_sources)
 {
     uint64_t address_offset;
+    const uint16_t notify = notif_src->notify;
+    const uint16_t source_id = notif_src->source_id;
 
     /*
      * Type:
@@ -297,7 +308,7 @@ static void build_ghes_v2(GArray *table_data,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
                                    ACPI_HW_ERROR_FW_CFG_FILE,
-                                   source_id * sizeof(uint64_t));
+                                   index * sizeof(uint64_t));
 
     /* Notification Structure */
     build_ghes_hw_error_notification(table_data, notify);
@@ -317,8 +328,7 @@ static void build_ghes_v2(GArray *table_data,
                                    address_offset + GAS_ADDR_OFFSET,
                                    sizeof(uint64_t),
                                    ACPI_HW_ERROR_FW_CFG_FILE,
-                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
-                                   * sizeof(uint64_t));
+                                   (num_sources + index) * sizeof(uint64_t));
 
     /*
      * Read Ack Preserve field
@@ -333,19 +343,23 @@ static void build_ghes_v2(GArray *table_data,
 /* Build Hardware Error Source Table */
 void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId * const notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
+    int i;
 
-    build_ghes_error_table(hardware_errors, linker);
+    build_ghes_error_table(hardware_errors, linker, num_sources);
 
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
-    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, linker,
-                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
+    build_append_int_noprefix(table_data, num_sources, 4);
+    for (i = 0; i < num_sources; i++) {
+        build_ghes_v2(table_data, linker, &notif_source[i], i, num_sources);
+    }
 
     acpi_table_end(linker, &table);
 }
@@ -410,7 +424,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
     get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                          &cper_addr, &read_ack_register_addr);
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e059317b002e..bd5582bc75f8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -889,6 +889,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
     g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -944,6 +948,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (vms->ras) {
         acpi_add_table(table_offsets, tables_blob);
         acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
+                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
                         vms->oem_id, vms->oem_table_id);
     }
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 39619a2457cb..9f0120d0d596 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -57,20 +57,27 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
-enum {
-    ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
-
-    ACPI_GHES_ERROR_SOURCE_COUNT
-};
-
 typedef struct AcpiGhesState {
     uint64_t hw_error_le;
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
+/*
+ * ID numbers used to fill HEST source ID field
+ */
+enum AcpiGhesSourceID {
+    ACPI_HEST_SRC_ID_SYNC,
+};
+
+typedef struct AcpiNotificationSourceId {
+    enum AcpiGhesSourceID source_id;
+    enum AcpiGhesNotifyType notify;
+} AcpiNotificationSourceId;
+
 void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      BIOSLinker *linker,
+                     const AcpiNotificationSourceId * const notif_source,
+                     int num_sources,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-- 
2.47.0


