Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96711872365
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Mar 2024 16:59:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXBm-0007Nb-R3; Tue, 05 Mar 2024 10:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhXBM-0005zL-0V
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:58:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhXBF-0000bF-Pd
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709654292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYTwneF75WNvn4PJRf+Og7nZzZIlJCAnRwcLgKRW6y4=;
 b=JoODcrGDZL1vO6AG57LFpzxRYHZbEqyaL2JG+gmRRzmfEUsbEvLmSi/P7x5zbHoFL2nh8o
 fqW2v48/vyX6hq1XCMH29VeRFOFbAAMZ8OwYo7usiSGEFaejn1iLQRsnYVNcSIngc9c3cL
 7OyC+Wi/wTbqoQ6/7tFYu03mqhqWUM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-GLTTAxh0M4Ci0U0WOqvFkw-1; Tue, 05 Mar 2024 10:58:08 -0500
X-MC-Unique: GLTTAxh0M4Ci0U0WOqvFkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A372101CF86;
 Tue,  5 Mar 2024 15:58:07 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAB1717A9B;
 Tue,  5 Mar 2024 15:58:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@linaro.org, wangyanan55@huawei.com, eblake@redhat.com,
 armbru@redhat.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 f.ebner@proxmox.com
Subject: [PATCH v2 13/20] smbios: get rid of global smbios_ep_type
Date: Tue,  5 Mar 2024 16:57:17 +0100
Message-Id: <20240305155724.2047069-14-imammedo@redhat.com>
In-Reply-To: <20240305155724.2047069-1-imammedo@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/i386/fw_cfg.h             |  3 ++-
 include/hw/firmware/smbios.h |  5 +++--
 hw/arm/virt.c                |  4 ++--
 hw/i386/fw_cfg.c             |  8 ++++----
 hw/i386/pc.c                 |  2 +-
 hw/loongarch/virt.c          |  7 ++++---
 hw/riscv/virt.c              |  6 +++---
 hw/smbios/smbios.c           | 27 +++++++++++++++------------
 hw/smbios/smbios_legacy.c    |  2 +-
 9 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 1e1de6b4a3..92e310f5fd 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -23,7 +23,8 @@
 FWCfgState *fw_cfg_arch_create(MachineState *ms,
                                uint16_t boot_cpus,
                                uint16_t apic_id_limit);
-void fw_cfg_build_smbios(PCMachineState *ms, FWCfgState *fw_cfg);
+void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
+                         SmbiosEntryPointType ep_type);
 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
 
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 89bb10510a..d128aef31d 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -309,16 +309,17 @@ struct smbios_type_127 {
     struct smbios_structure_header header;
 } QEMU_PACKED;
 
-bool smbios_validate_table(Error **errp);
+bool smbios_validate_table(SmbiosEntryPointType ep_type, Error **errp);
 void smbios_add_usr_blob_size(size_t size);
 void smbios_entry_add(QemuOpts *opts, Error **errp);
 void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version,
-                         bool uuid_encoded, SmbiosEntryPointType ep_type);
+                         bool uuid_encoded);
 void smbios_set_default_processor_family(uint16_t processor_family);
 uint8_t *smbios_get_table_legacy(size_t *length, Error **errp);
 void smbios_get_tables(MachineState *ms,
+                       SmbiosEntryPointType ep_type,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
                        uint8_t **tables, size_t *tables_len,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8588681f27..780224ee5b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1634,13 +1634,13 @@ static void virt_build_smbios(VirtMachineState *vms)
 
     smbios_set_defaults("QEMU", product,
                         vmc->smbios_old_sys_ver ? "1.0" : mc->name,
-                        true, SMBIOS_ENTRY_POINT_TYPE_64);
+                        true);
 
     /* build the array of physical mem area from base_memmap */
     mem_array.address = vms->memmap[VIRT_MEM].base;
     mem_array.length = ms->ram_size;
 
-    smbios_get_tables(ms, &mem_array, 1,
+    smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64, &mem_array, 1,
                       &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len,
                       &error_fatal);
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index e387bf50d0..d802d2787f 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -48,7 +48,8 @@ const char *fw_cfg_arch_key_name(uint16_t key)
     return NULL;
 }
 
-void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
+void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
+                         SmbiosEntryPointType ep_type)
 {
 #ifdef CONFIG_SMBIOS
     uint8_t *smbios_tables, *smbios_anchor;
@@ -63,8 +64,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc, mc->name,
-                            pcmc->smbios_uuid_encoded,
-                            pcms->smbios_entry_point_type);
+                            pcmc->smbios_uuid_encoded);
     }
 
     /* tell smbios about cpuid version and features */
@@ -89,7 +89,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
             array_count++;
         }
     }
-    smbios_get_tables(ms, mem_array, array_count,
+    smbios_get_tables(ms, ep_type, mem_array, array_count,
                       &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len,
                       &error_fatal);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f5ff970acf..a8e8aa2ac8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -691,7 +691,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     acpi_setup();
     if (x86ms->fw_cfg) {
-        fw_cfg_build_smbios(pcms, x86ms->fw_cfg);
+        fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_type);
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 8c7601ef91..05f616682a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -355,10 +355,11 @@ static void virt_build_smbios(LoongArchMachineState *lams)
         return;
     }
 
-    smbios_set_defaults("QEMU", product, mc->name,
-                        true, SMBIOS_ENTRY_POINT_TYPE_64);
+    smbios_set_defaults("QEMU", product, mc->name, true);
 
-    smbios_get_tables(ms, NULL, 0, &smbios_tables, &smbios_tables_len,
+    smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
+                      NULL, 0,
+                      &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len, &error_fatal);
 
     if (smbios_anchor) {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e2c9529df2..b730ff2030 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1235,8 +1235,7 @@ static void virt_build_smbios(RISCVVirtState *s)
         product = "KVM Virtual Machine";
     }
 
-    smbios_set_defaults("QEMU", product, mc->name,
-                        true, SMBIOS_ENTRY_POINT_TYPE_64);
+    smbios_set_defaults("QEMU", product, mc->name, true);
 
     if (riscv_is_32bit(&s->soc[0])) {
         smbios_set_default_processor_family(0x200);
@@ -1248,7 +1247,8 @@ static void virt_build_smbios(RISCVVirtState *s)
     mem_array.address = s->memmap[VIRT_DRAM].base;
     mem_array.length = ms->ram_size;
 
-    smbios_get_tables(ms, &mem_array, 1,
+    smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
+                      &mem_array, 1,
                       &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len,
                       &error_fatal);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d9ba2072b1..5a791fd9eb 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -43,7 +43,6 @@ uint8_t *smbios_tables;
 size_t smbios_tables_len;
 unsigned smbios_table_max;
 unsigned smbios_table_cnt;
-static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 
 static SmbiosEntryPoint ep;
 
@@ -457,9 +456,9 @@ static bool smbios_check_type4_count(uint32_t expected_t4_count, Error **errp)
     return true;
 }
 
-bool smbios_validate_table(Error **errp)
+bool smbios_validate_table(SmbiosEntryPointType ep_type, Error **errp)
 {
-    if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_32 &&
+    if (ep_type == SMBIOS_ENTRY_POINT_TYPE_32 &&
         smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
         error_setg(errp, "SMBIOS 2.1 table length %zu exceeds %d",
                    smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
@@ -605,14 +604,15 @@ static void smbios_build_type_3_table(void)
     SMBIOS_BUILD_TABLE_POST;
 }
 
-static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
+static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
+                                      SmbiosEntryPointType ep_type)
 {
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
     unsigned threads_per_socket;
     unsigned cores_per_socket;
 
-    if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
+    if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
     }
 
@@ -888,11 +888,10 @@ void smbios_set_default_processor_family(uint16_t processor_family)
 
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version,
-                         bool uuid_encoded, SmbiosEntryPointType ep_type)
+                         bool uuid_encoded)
 {
     smbios_have_defaults = true;
     smbios_uuid_encoded = uuid_encoded;
-    smbios_ep_type = ep_type;
 
     SMBIOS_SET_DEFAULT(smbios_type1.manufacturer, manufacturer);
     SMBIOS_SET_DEFAULT(smbios_type1.product, product);
@@ -909,9 +908,9 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
     SMBIOS_SET_DEFAULT(type17.manufacturer, manufacturer);
 }
 
-static void smbios_entry_point_setup(void)
+static void smbios_entry_point_setup(SmbiosEntryPointType ep_type)
 {
-    switch (smbios_ep_type) {
+    switch (ep_type) {
     case SMBIOS_ENTRY_POINT_TYPE_32:
         memcpy(ep.ep21.anchor_string, "_SM_", 4);
         memcpy(ep.ep21.intermediate_anchor_string, "_DMI_", 5);
@@ -961,6 +960,7 @@ static void smbios_entry_point_setup(void)
 }
 
 void smbios_get_tables(MachineState *ms,
+                       SmbiosEntryPointType ep_type,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
                        uint8_t **tables, size_t *tables_len,
@@ -969,6 +969,9 @@ void smbios_get_tables(MachineState *ms,
 {
     unsigned i, dimm_cnt, offset;
 
+    assert(ep_type == SMBIOS_ENTRY_POINT_TYPE_32 ||
+           ep_type == SMBIOS_ENTRY_POINT_TYPE_64);
+
     g_free(smbios_tables);
     smbios_tables = g_memdup2(usr_blobs, usr_blobs_len);
     smbios_tables_len = usr_blobs_len;
@@ -983,7 +986,7 @@ void smbios_get_tables(MachineState *ms,
     assert(ms->smp.sockets >= 1);
 
     for (i = 0; i < ms->smp.sockets; i++) {
-        smbios_build_type_4_table(ms, i);
+        smbios_build_type_4_table(ms, i, ep_type);
     }
 
     smbios_build_type_8_table();
@@ -1031,10 +1034,10 @@ void smbios_get_tables(MachineState *ms,
     if (!smbios_check_type4_count(ms->smp.sockets, errp)) {
         goto err_exit;
     }
-    if (!smbios_validate_table(errp)) {
+    if (!smbios_validate_table(ep_type, errp)) {
         goto err_exit;
     }
-    smbios_entry_point_setup();
+    smbios_entry_point_setup(ep_type);
 
     /* return tables blob and entry point (anchor), and their sizes */
     *tables = smbios_tables;
diff --git a/hw/smbios/smbios_legacy.c b/hw/smbios/smbios_legacy.c
index a6544bf55a..06907cd16c 100644
--- a/hw/smbios/smbios_legacy.c
+++ b/hw/smbios/smbios_legacy.c
@@ -173,7 +173,7 @@ uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
 
     smbios_build_type_0_fields();
     smbios_build_type_1_fields();
-    if (!smbios_validate_table(errp)) {
+    if (!smbios_validate_table(SMBIOS_ENTRY_POINT_TYPE_32, errp)) {
         goto err_exit;
     }
 
-- 
2.39.3


