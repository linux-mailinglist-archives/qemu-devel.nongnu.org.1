Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B618D87BFDA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Mar 2024 16:24:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmvV-0007Il-CT; Thu, 14 Mar 2024 11:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvQ-0007HS-Mo
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvO-0003lD-Ou
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TOGYzj9QNMH9aiiCLO1kK5prIlGB3WSc1dt3h5FLqqw=;
 b=QZ1WkeomJnMll6YAvEaaPugFe8Okc3IRjEPVxJ48NA1fMtzhw3gy6fBue+HtjMTusUBgQE
 QX+GNIHbwdL6FZNGMyhkMHqRBfnnquWNSdCPzcvNGjXkNhu5qR2DkBOXuuzWTixcW4iow/
 3qlo2topVPowkaXGjB4IRn/G8UUC/JU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-fFNWTYUcPZKK1m9-cRkhNw-1; Thu,
 14 Mar 2024 11:23:12 -0400
X-MC-Unique: fFNWTYUcPZKK1m9-cRkhNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6330B3C025AC;
 Thu, 14 Mar 2024 15:23:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 845C8111E5;
 Thu, 14 Mar 2024 15:23:11 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Fiona Ebner <f.ebner@proxmox.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 07/21] smbios: avoid mangling user provided tables
Date: Thu, 14 Mar 2024 16:22:48 +0100
Message-Id: <20240314152302.2324164-8-imammedo@redhat.com>
In-Reply-To: <20240314152302.2324164-1-imammedo@redhat.com>
References: <20240314152302.2324164-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

currently smbios_entry_add() preserves internally '-smbios type='
options but tables provided with '-smbios file=' are stored directly
into blob that eventually will be exposed to VM. And then later
QEMU adds default/'-smbios type' entries on top into the same blob.

It makes impossible to generate tables more than once, hence
'immutable' guard was used.
Make it possible to regenerate final blob by storing user provided
blobs into a dedicated area (usr_blobs) and then copy it when
composing final blob. Which also makes handling of -smbios
options consistent.

As side effect of this and previous commits there is no need to
generate legacy smbios_entries at the time options are parsed.
Instead compose smbios_entries on demand from  usr_blobs like
it is done for non-legacy SMBIOS tables.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
v4:
   fix conflicts when rebasing on top of:
     04f143d828 Implement SMBIOS type 9 v2.6
     735eee07d1 Implement base of SMBIOS type 9 descriptor
---
 hw/smbios/smbios.c | 181 +++++++++++++++++++++++----------------------
 1 file changed, 93 insertions(+), 88 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 1bae36a6e0..db422f4fb0 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -57,6 +57,14 @@ static size_t smbios_entries_len;
 static bool smbios_uuid_encoded = true;
 /* end: legacy structures & constants for <= 2.0 machines */
 
+/*
+ * SMBIOS tables provided by user with '-smbios file=<foo>' option
+ */
+uint8_t *usr_blobs;
+size_t usr_blobs_len;
+static GArray *usr_blobs_sizes;
+static unsigned usr_table_max;
+static unsigned usr_table_cnt;
 
 uint8_t *smbios_tables;
 size_t smbios_tables_len;
@@ -67,7 +75,6 @@ static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 static SmbiosEntryPoint ep;
 
 static int smbios_type4_count = 0;
-static bool smbios_immutable;
 static bool smbios_have_defaults;
 static uint32_t smbios_cpuid_version, smbios_cpuid_features;
 
@@ -632,9 +639,8 @@ static void smbios_build_type_1_fields(void)
 
 uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
 {
-    /* drop unwanted version of command-line file blob(s) */
-    g_free(smbios_tables);
-    smbios_tables = NULL;
+    int i;
+    size_t usr_offset;
 
     /* also complain if fields were given for types > 1 */
     if (find_next_bit(have_fields_bitmap,
@@ -644,12 +650,33 @@ uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
         exit(1);
     }
 
-    if (!smbios_immutable) {
-        smbios_build_type_0_fields();
-        smbios_build_type_1_fields();
-        smbios_validate_table(expected_t4_count);
-        smbios_immutable = true;
+    g_free(smbios_entries);
+    smbios_entries_len = sizeof(uint16_t);
+    smbios_entries = g_malloc0(smbios_entries_len);
+
+    for (i = 0, usr_offset = 0; usr_blobs_sizes && i < usr_blobs_sizes->len;
+         i++)
+    {
+        struct smbios_table *table;
+        struct smbios_structure_header *header;
+        size_t size = g_array_index(usr_blobs_sizes, size_t, i);
+
+        header = (struct smbios_structure_header *)(usr_blobs + usr_offset);
+        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
+                                                   size + sizeof(*table));
+        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
+        table->header.type = SMBIOS_TABLE_ENTRY;
+        table->header.length = cpu_to_le16(sizeof(*table) + size);
+        memcpy(table->data, header, size);
+        smbios_entries_len += sizeof(*table) + size;
+        (*(uint16_t *)smbios_entries) =
+            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
+        usr_offset += size;
     }
+
+    smbios_build_type_0_fields();
+    smbios_build_type_1_fields();
+    smbios_validate_table(expected_t4_count);
     *length = smbios_entries_len;
     return smbios_entries;
 }
@@ -1217,68 +1244,68 @@ void smbios_get_tables(MachineState *ms,
 {
     unsigned i, dimm_cnt, offset;
 
-    /* drop unwanted (legacy) version of command-line file blob(s) */
-    g_free(smbios_entries);
-    smbios_entries = NULL;
+    g_free(smbios_tables);
+    smbios_tables = g_memdup2(usr_blobs, usr_blobs_len);
+    smbios_tables_len = usr_blobs_len;
+    smbios_table_max = usr_table_max;
+    smbios_table_cnt = usr_table_cnt;
 
-    if (!smbios_immutable) {
-        smbios_build_type_0_table();
-        smbios_build_type_1_table();
-        smbios_build_type_2_table();
-        smbios_build_type_3_table();
+    smbios_build_type_0_table();
+    smbios_build_type_1_table();
+    smbios_build_type_2_table();
+    smbios_build_type_3_table();
 
-        assert(ms->smp.sockets >= 1);
+    assert(ms->smp.sockets >= 1);
 
-        for (i = 0; i < ms->smp.sockets; i++) {
-            smbios_build_type_4_table(ms, i);
-        }
+    for (i = 0; i < ms->smp.sockets; i++) {
+        smbios_build_type_4_table(ms, i);
+    }
 
-        smbios_build_type_8_table();
-        smbios_build_type_9_table(errp);
-        smbios_build_type_11_table();
+    smbios_build_type_8_table();
+    smbios_build_type_9_table(errp);
+    smbios_build_type_11_table();
 
 #define MAX_DIMM_SZ (16 * GiB)
 #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
                                         : ((current_machine->ram_size - 1) % MAX_DIMM_SZ) + 1)
 
-        dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) / MAX_DIMM_SZ;
+    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) /
+               MAX_DIMM_SZ;
 
-        /*
-         * The offset determines if we need to keep additional space between
-         * table 17 and table 19 header handle numbers so that they do
-         * not overlap. For example, for a VM with larger than 8 TB guest
-         * memory and DIMM like chunks of 16 GiB, the default space between
-         * the two tables (T19_BASE - T17_BASE = 512) is not enough.
-         */
-        offset = (dimm_cnt > (T19_BASE - T17_BASE)) ? \
-                 dimm_cnt - (T19_BASE - T17_BASE) : 0;
+    /*
+     * The offset determines if we need to keep additional space between
+     * table 17 and table 19 header handle numbers so that they do
+     * not overlap. For example, for a VM with larger than 8 TB guest
+     * memory and DIMM like chunks of 16 GiB, the default space between
+     * the two tables (T19_BASE - T17_BASE = 512) is not enough.
+     */
+    offset = (dimm_cnt > (T19_BASE - T17_BASE)) ? \
+             dimm_cnt - (T19_BASE - T17_BASE) : 0;
 
-        smbios_build_type_16_table(dimm_cnt);
+    smbios_build_type_16_table(dimm_cnt);
 
-        for (i = 0; i < dimm_cnt; i++) {
-            smbios_build_type_17_table(i, GET_DIMM_SZ);
-        }
+    for (i = 0; i < dimm_cnt; i++) {
+        smbios_build_type_17_table(i, GET_DIMM_SZ);
+    }
 
-        for (i = 0; i < mem_array_size; i++) {
-            smbios_build_type_19_table(i, offset, mem_array[i].address,
-                                       mem_array[i].length);
-        }
+    for (i = 0; i < mem_array_size; i++) {
+        smbios_build_type_19_table(i, offset, mem_array[i].address,
+                                   mem_array[i].length);
+    }
 
-        /*
-         * make sure 16 bit handle numbers in the headers of tables 19
-         * and 32 do not overlap.
-         */
-        assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
+    /*
+     * make sure 16 bit handle numbers in the headers of tables 19
+     * and 32 do not overlap.
+     */
+    assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
 
-        smbios_build_type_32_table();
-        smbios_build_type_38_table();
-        smbios_build_type_41_table(errp);
-        smbios_build_type_127_table();
+    smbios_build_type_32_table();
+    smbios_build_type_38_table();
+    smbios_build_type_41_table(errp);
+    smbios_build_type_127_table();
 
-        smbios_validate_table(ms->smp.sockets);
-        smbios_entry_point_setup();
-        smbios_immutable = true;
-    }
+    smbios_validate_table(ms->smp.sockets);
+    smbios_entry_point_setup();
 
     /* return tables blob and entry point (anchor), and their sizes */
     *tables = smbios_tables;
@@ -1378,13 +1405,10 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
     const char *val;
 
-    assert(!smbios_immutable);
-
     val = qemu_opt_get(opts, "file");
     if (val) {
         struct smbios_structure_header *header;
-        int size;
-        struct smbios_table *table; /* legacy mode only */
+        size_t size;
 
         if (!qemu_opts_validate(opts, qemu_smbios_file_opts, errp)) {
             return;
@@ -1401,9 +1425,9 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
          * (except in legacy mode, where the second '\0' is implicit and
          *  will be inserted by the BIOS).
          */
-        smbios_tables = g_realloc(smbios_tables, smbios_tables_len + size);
-        header = (struct smbios_structure_header *)(smbios_tables +
-                                                    smbios_tables_len);
+        usr_blobs = g_realloc(usr_blobs, usr_blobs_len + size);
+        header = (struct smbios_structure_header *)(usr_blobs +
+                                                    usr_blobs_len);
 
         if (load_image_size(val, (uint8_t *)header, size) != size) {
             error_setg(errp, "Failed to load SMBIOS file %s", val);
@@ -1424,34 +1448,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             smbios_type4_count++;
         }
 
-        smbios_tables_len += size;
-        if (size > smbios_table_max) {
-            smbios_table_max = size;
+        if (!usr_blobs_sizes) {
+            usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
         }
-        smbios_table_cnt++;
-
-        /* add a copy of the newly loaded blob to legacy smbios_entries */
-        /* NOTE: This code runs before smbios_set_defaults(), so we don't
-         *       yet know which mode (legacy vs. aggregate-table) will be
-         *       required. We therefore add the binary blob to both legacy
-         *       (smbios_entries) and aggregate (smbios_tables) tables, and
-         *       delete the one we don't need from smbios_set_defaults(),
-         *       once we know which machine version has been requested.
-         */
-        if (!smbios_entries) {
-            smbios_entries_len = sizeof(uint16_t);
-            smbios_entries = g_malloc0(smbios_entries_len);
+        g_array_append_val(usr_blobs_sizes, size);
+        usr_blobs_len += size;
+        if (size > usr_table_max) {
+            usr_table_max = size;
         }
-        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
-                                                   size + sizeof(*table));
-        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
-        table->header.type = SMBIOS_TABLE_ENTRY;
-        table->header.length = cpu_to_le16(sizeof(*table) + size);
-        memcpy(table->data, header, size);
-        smbios_entries_len += sizeof(*table) + size;
-        (*(uint16_t *)smbios_entries) =
-                cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
-        /* end: add a copy of the newly loaded blob to legacy smbios_entries */
+        usr_table_cnt++;
 
         return;
     }
-- 
2.39.3


