Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887B18798B1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 17:13:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4in-000641-4m; Tue, 12 Mar 2024 12:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iX-0005xz-A8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iV-0007By-3J
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSsOcNW5C4Sfk8owtfk708TMLJwGV5ZqPTaDuS5v5F4=;
 b=XTDIk8rWOSZzmVDJd+C7o1D+Xm6be9X3v126aai2s0D1UwZmmMg2znn6UkrKtEpdn3eaKr
 jfDDMHTqXCrugyhjijDEu6JgafevsNgEpnBU4Kk06hXcSLjFJ0BLyCb709qG+BjMoUiS5J
 DXyze3Bez09UkVSNPH4v7h9XV832qSY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-mS3t-OtgMEGvUl-ry0YuoA-1; Tue,
 12 Mar 2024 12:10:59 -0400
X-MC-Unique: mS3t-OtgMEGvUl-ry0YuoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ACA41C068CB;
 Tue, 12 Mar 2024 16:10:59 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F2FB3C22;
 Tue, 12 Mar 2024 16:10:57 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v3 05/20] smbios: get rid of smbios_smp_sockets global
Date: Tue, 12 Mar 2024 17:10:35 +0100
Message-Id: <20240312161050.2248814-6-imammedo@redhat.com>
In-Reply-To: <20240312161050.2248814-1-imammedo@redhat.com>
References: <20240312161050.2248814-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

it makes smbios_validate_table() independent from
smbios_smp_sockets global, which in turn lets
smbios_get_tables() avoid using not related legacy code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
goal here is to isolate legacy handling from generic smbios_get_tables()
---
 include/hw/firmware/smbios.h |  2 +-
 hw/i386/fw_cfg.c             |  2 +-
 hw/smbios/smbios.c           | 22 +++++++++-------------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 6e514982d4..a187fbbd3d 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -296,7 +296,7 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
 void smbios_set_default_processor_family(uint16_t processor_family);
-uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length);
+uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length);
 void smbios_get_tables(MachineState *ms,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index a635234e68..fcb4fb0769 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -70,7 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
-    smbios_tables = smbios_get_table_legacy(ms, &smbios_tables_len);
+    smbios_tables = smbios_get_table_legacy(ms->smp.cpus, &smbios_tables_len);
     if (smbios_tables) {
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 8e86c62184..15339d8dbe 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -70,7 +70,7 @@ static SmbiosEntryPoint ep;
 static int smbios_type4_count = 0;
 static bool smbios_immutable;
 static bool smbios_have_defaults;
-static uint32_t smbios_cpuid_version, smbios_cpuid_features, smbios_smp_sockets;
+static uint32_t smbios_cpuid_version, smbios_cpuid_features;
 
 static DECLARE_BITMAP(have_binfile_bitmap, SMBIOS_MAX_TYPE+1);
 static DECLARE_BITMAP(have_fields_bitmap, SMBIOS_MAX_TYPE+1);
@@ -476,14 +476,11 @@ opts_init(smbios_register_config);
  */
 #define SMBIOS_21_MAX_TABLES_LEN 0xffff
 
-static void smbios_validate_table(MachineState *ms)
+static void smbios_validate_table(uint32_t expected_t4_count)
 {
-    uint32_t expect_t4_count = smbios_legacy ?
-                                        ms->smp.cpus : smbios_smp_sockets;
-
-    if (smbios_type4_count && smbios_type4_count != expect_t4_count) {
+    if (smbios_type4_count && smbios_type4_count != expected_t4_count) {
         error_report("Expected %d SMBIOS Type 4 tables, got %d instead",
-                     expect_t4_count, smbios_type4_count);
+                     expected_t4_count, smbios_type4_count);
         exit(1);
     }
 
@@ -571,7 +568,7 @@ static void smbios_build_type_1_fields(void)
     }
 }
 
-uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length)
+uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
 {
     if (!smbios_legacy) {
         *length = 0;
@@ -581,7 +578,7 @@ uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length)
     if (!smbios_immutable) {
         smbios_build_type_0_fields();
         smbios_build_type_1_fields();
-        smbios_validate_table(ms);
+        smbios_validate_table(expected_t4_count);
         smbios_immutable = true;
     }
     *length = smbios_entries_len;
@@ -1112,10 +1109,9 @@ void smbios_get_tables(MachineState *ms,
         smbios_build_type_2_table();
         smbios_build_type_3_table();
 
-        smbios_smp_sockets = ms->smp.sockets;
-        assert(smbios_smp_sockets >= 1);
+        assert(ms->smp.sockets >= 1);
 
-        for (i = 0; i < smbios_smp_sockets; i++) {
+        for (i = 0; i < ms->smp.sockets; i++) {
             smbios_build_type_4_table(ms, i);
         }
 
@@ -1160,7 +1156,7 @@ void smbios_get_tables(MachineState *ms,
         smbios_build_type_41_table(errp);
         smbios_build_type_127_table();
 
-        smbios_validate_table(ms);
+        smbios_validate_table(ms->smp.sockets);
         smbios_entry_point_setup();
         smbios_immutable = true;
     }
-- 
2.39.3


