Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81F9F4DBA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Dec 2024 15:29:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYZl-00017V-2X; Tue, 17 Dec 2024 09:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNYZM-0000vj-M1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:29:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNYZJ-0004w2-Ka
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734445740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvzZP7QmtJuluCF9JaneWnfZ4YDe/Y5SkuUa8w/tnME=;
 b=HW7Bt8ssnaiCushdg30QMvO0BXEe6pHIPy/o1wC+FMAn+VRTlYwJihBsfKUtgA2gpRd+th
 6aXEJJOg31Zr6ZBbq9Gzk5/2+f1DUHR6FK0SvHAk1cvxLPpYj+TBpvzacTklkyarHYzJS/
 YAjvywsN1fB28aY98HFgvyRRC64JI/g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-_zaxj_DqOSawzgr3-0zgrw-1; Tue,
 17 Dec 2024 09:28:58 -0500
X-MC-Unique: _zaxj_DqOSawzgr3-0zgrw-1
X-Mimecast-MFC-AGG-ID: _zaxj_DqOSawzgr3-0zgrw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D851719560BE; Tue, 17 Dec 2024 14:28:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D8121955F57; Tue, 17 Dec 2024 14:28:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1074321E6609; Tue, 17 Dec 2024 15:28:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Subject: [PATCH 3/6] qdev: Rename PropertyInfo member @name to @type
Date: Tue, 17 Dec 2024 15:28:51 +0100
Message-ID: <20241217142855.3805068-4-armbru@redhat.com>
In-Reply-To: <20241217142855.3805068-1-armbru@redhat.com>
References: <20241217142855.3805068-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PropertyInfo member @name becomes ObjectProperty member @type, while
Property member @name becomes ObjectProperty member @name.  Rename the
former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-properties.h     |  2 +-
 backends/tpm/tpm_util.c          |  2 +-
 hw/block/xen-block.c             |  2 +-
 hw/core/qdev-properties-system.c | 48 ++++++++++++++++----------------
 hw/core/qdev-properties.c        | 36 ++++++++++++------------
 hw/misc/xlnx-versal-trng.c       |  2 +-
 hw/nvme/nguid.c                  |  2 +-
 hw/nvram/xlnx-bbram.c            |  2 +-
 hw/nvram/xlnx-efuse.c            |  2 +-
 hw/pci/pci.c                     |  2 +-
 hw/s390x/ccw-device.c            |  2 +-
 hw/s390x/css.c                   |  4 +--
 hw/s390x/s390-pci-bus.c          |  2 +-
 hw/vfio/pci-quirks.c             |  2 +-
 target/riscv/cpu.c               | 28 +++++++++----------
 target/sparc/cpu.c               |  2 +-
 16 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 1e7ae2e01a..1a2d34691a 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -30,7 +30,7 @@ struct Property {
 };
 
 struct PropertyInfo {
-    const char *name;
+    const char *type;
     const char *description;
     const QEnumLookup *enum_table;
     bool realized_set_allowed; /* allow setting property on realized device */
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index cf138551df..07db518f77 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -75,7 +75,7 @@ static void release_tpm(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_tpm = {
-    .name  = "str",
+    .type  = "str",
     .description = "ID of a tpm to use as a backend",
     .get   = get_tpm,
     .set   = set_tpm,
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aed1d5c330..1303c9dcc9 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -660,7 +660,7 @@ invalid:
  * https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
  */
 const PropertyInfo xen_block_prop_vdev = {
-    .name  = "str",
+    .type  = "str",
     .description = "Virtual Disk specifier: d*p*/xvd*/hd*/sd*",
     .get = xen_block_get_vdev,
     .set = xen_block_set_vdev,
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 3177678861..b66e6f5c96 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -235,7 +235,7 @@ static void release_drive(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_drive = {
-    .name  = "str",
+    .type  = "str",
     .description = "Node name or ID of a block device to use as a backend",
     .realized_set_allowed = true,
     .get   = get_drive,
@@ -244,7 +244,7 @@ const PropertyInfo qdev_prop_drive = {
 };
 
 const PropertyInfo qdev_prop_drive_iothread = {
-    .name  = "str",
+    .type  = "str",
     .description = "Node name or ID of a block device to use as a backend",
     .realized_set_allowed = true,
     .get   = get_drive,
@@ -312,7 +312,7 @@ static void release_chr(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_chr = {
-    .name  = "str",
+    .type  = "str",
     .description = "ID of a chardev to use as a backend",
     .get   = get_chr,
     .set   = set_chr,
@@ -386,7 +386,7 @@ inval:
 }
 
 const PropertyInfo qdev_prop_macaddr = {
-    .name  = "str",
+    .type  = "str",
     .description = "Ethernet 6-byte MAC Address, example: 52:54:00:12:34:56",
     .get   = get_mac,
     .set   = set_mac,
@@ -474,7 +474,7 @@ out:
 }
 
 const PropertyInfo qdev_prop_netdev = {
-    .name  = "str",
+    .type  = "str",
     .description = "ID of a netdev to use as a backend",
     .get   = get_netdev,
     .set   = set_netdev,
@@ -512,7 +512,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
 }
 
 const PropertyInfo qdev_prop_audiodev = {
-    .name = "str",
+    .type = "str",
     .description = "ID of an audiodev to use as a backend",
     /* release done on shutdown */
     .get = get_audiodev,
@@ -602,7 +602,7 @@ static void qdev_propinfo_set_losttickpolicy(Object *obj, Visitor *v,
 QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
 
 const PropertyInfo qdev_prop_losttickpolicy = {
-    .name  = "LostTickPolicy",
+    .type  = "LostTickPolicy",
     .enum_table  = &LostTickPolicy_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_losttickpolicy,
@@ -628,7 +628,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_blocksize = {
-    .name  = "size",
+    .type  = "size",
     .description = "A power of two between " MIN_BLOCK_SIZE_STR
                    " and " MAX_BLOCK_SIZE_STR,
     .get   = qdev_propinfo_get_size32,
@@ -641,7 +641,7 @@ const PropertyInfo qdev_prop_blocksize = {
 QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) != sizeof(int));
 
 const PropertyInfo qdev_prop_blockdev_on_error = {
-    .name = "BlockdevOnError",
+    .type = "BlockdevOnError",
     .description = "Error handling policy, "
                    "report/ignore/enospc/stop/auto",
     .enum_table = &BlockdevOnError_lookup,
@@ -655,7 +655,7 @@ const PropertyInfo qdev_prop_blockdev_on_error = {
 QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) != sizeof(int));
 
 const PropertyInfo qdev_prop_bios_chs_trans = {
-    .name = "BiosAtaTranslation",
+    .type = "BiosAtaTranslation",
     .description = "Logical CHS translation algorithm, "
                    "auto/none/lba/large/rechs",
     .enum_table = &BiosAtaTranslation_lookup,
@@ -667,7 +667,7 @@ const PropertyInfo qdev_prop_bios_chs_trans = {
 /* --- FDC default drive types */
 
 const PropertyInfo qdev_prop_fdc_drive_type = {
-    .name = "FdcDriveType",
+    .type = "FdcDriveType",
     .description = "FDC drive type, "
                    "144/288/120/none/auto",
     .enum_table = &FloppyDriveType_lookup,
@@ -679,7 +679,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 /* --- MultiFDCompression --- */
 
 const PropertyInfo qdev_prop_multifd_compression = {
-    .name = "MultiFDCompression",
+    .type = "MultiFDCompression",
     .description = "multifd_compression values, "
                    "none/zlib/zstd/qpl/uadk/qatzip",
     .enum_table = &MultiFDCompression_lookup,
@@ -693,7 +693,7 @@ const PropertyInfo qdev_prop_multifd_compression = {
 QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_mig_mode = {
-    .name = "MigMode",
+    .type = "MigMode",
     .description = "mig_mode values, "
                    "normal,cpr-reboot",
     .enum_table = &MigMode_lookup,
@@ -707,7 +707,7 @@ const PropertyInfo qdev_prop_mig_mode = {
 QEMU_BUILD_BUG_ON(sizeof(GranuleMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_granule_mode = {
-    .name = "GranuleMode",
+    .type = "GranuleMode",
     .description = "granule_mode values, "
                    "4k, 8k, 16k, 64k, host",
     .enum_table = &GranuleMode_lookup,
@@ -717,7 +717,7 @@ const PropertyInfo qdev_prop_granule_mode = {
 };
 
 const PropertyInfo qdev_prop_zero_page_detection = {
-    .name = "ZeroPageDetection",
+    .type = "ZeroPageDetection",
     .description = "zero_page_detection values, "
                    "none,legacy,multifd",
     .enum_table = &ZeroPageDetection_lookup,
@@ -801,7 +801,7 @@ out:
 }
 
 const PropertyInfo qdev_prop_reserved_region = {
-    .name  = "reserved_region",
+    .type  = "reserved_region",
     .description = "Reserved Region, example: 0xFEE00000:0xFEEFFFFF:0",
     .get   = get_reserved_region,
     .set   = set_reserved_region,
@@ -882,7 +882,7 @@ static int print_pci_devfn(Object *obj, Property *prop, char *dest,
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    .name  = "str",
+    .type  = "str",
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,
@@ -988,7 +988,7 @@ inval:
 }
 
 const PropertyInfo qdev_prop_pci_host_devaddr = {
-    .name = "str",
+    .type = "str",
     .description = "Address (bus/device/function) of "
                    "the host device, example: 04:10.0",
     .get = get_pci_host_devaddr,
@@ -998,7 +998,7 @@ const PropertyInfo qdev_prop_pci_host_devaddr = {
 /* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
 
 const PropertyInfo qdev_prop_off_auto_pcibar = {
-    .name = "OffAutoPCIBAR",
+    .type = "OffAutoPCIBAR",
     .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
     .enum_table = &OffAutoPCIBAR_lookup,
     .get = qdev_propinfo_get_enum,
@@ -1080,7 +1080,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_pcie_link_speed = {
-    .name = "PCIELinkSpeed",
+    .type = "PCIELinkSpeed",
     .description = "2_5/5/8/16/32/64",
     .enum_table = &PCIELinkSpeed_lookup,
     .get = get_prop_pcielinkspeed,
@@ -1168,7 +1168,7 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_pcie_link_width = {
-    .name = "PCIELinkWidth",
+    .type = "PCIELinkWidth",
     .description = "1/2/4/8/12/16/32",
     .enum_table = &PCIELinkWidth_lookup,
     .get = get_prop_pcielinkwidth,
@@ -1218,7 +1218,7 @@ static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_uuid = {
-    .name  = "str",
+    .type  = "str",
     .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
         "\" for random value (default)",
     .get   = get_uuid,
@@ -1231,7 +1231,7 @@ const PropertyInfo qdev_prop_uuid = {
 QEMU_BUILD_BUG_ON(sizeof(S390CpuEntitlement) != sizeof(int));
 
 const PropertyInfo qdev_prop_cpus390entitlement = {
-    .name  = "S390CpuEntitlement",
+    .type  = "S390CpuEntitlement",
     .description = "low/medium (default)/high",
     .enum_table  = &S390CpuEntitlement_lookup,
     .get   = qdev_propinfo_get_enum,
@@ -1276,7 +1276,7 @@ static void release_iothread_vq_mapping_list(Object *obj,
 }
 
 const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
-    .name = "IOThreadVirtQueueMappingList",
+    .type = "IOThreadVirtQueueMappingList",
     .description = "IOThread virtqueue mapping list [{\"iothread\":\"<id>\", "
                    "\"vqs\":[1,2,3,...]},...]",
     .get = get_iothread_vq_mapping_list,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index cfd8abb2f9..67b17848b8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -169,7 +169,7 @@ static void set_default_value_bool(ObjectProperty *op, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_bit = {
-    .name  = "bool",
+    .type  = "bool",
     .description = "on/off",
     .get   = prop_get_bit,
     .set   = prop_set_bit,
@@ -218,7 +218,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_bit64 = {
-    .name  = "bool",
+    .type  = "bool",
     .description = "on/off",
     .get   = prop_get_bit64,
     .set   = prop_set_bit64,
@@ -246,7 +246,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_bool = {
-    .name  = "bool",
+    .type  = "bool",
     .get   = get_bool,
     .set   = set_bool,
     .set_default_value = set_default_value_bool,
@@ -285,7 +285,7 @@ void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
 }
 
 const PropertyInfo qdev_prop_uint8 = {
-    .name  = "uint8",
+    .type  = "uint8",
     .get   = get_uint8,
     .set   = set_uint8,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -312,7 +312,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_uint16 = {
-    .name  = "uint16",
+    .type  = "uint16",
     .get   = get_uint16,
     .set   = set_uint16,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -357,14 +357,14 @@ static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_uint32 = {
-    .name  = "uint32",
+    .type  = "uint32",
     .get   = get_uint32,
     .set   = set_uint32,
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 const PropertyInfo qdev_prop_int32 = {
-    .name  = "int32",
+    .type  = "int32",
     .get   = qdev_propinfo_get_int32,
     .set   = set_int32,
     .set_default_value = qdev_propinfo_set_default_value_int,
@@ -409,14 +409,14 @@ static void set_int64(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_uint64 = {
-    .name  = "uint64",
+    .type  = "uint64",
     .get   = get_uint64,
     .set   = set_uint64,
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 const PropertyInfo qdev_prop_int64 = {
-    .name  = "int64",
+    .type  = "int64",
     .get   = get_int64,
     .set   = set_int64,
     .set_default_value = qdev_propinfo_set_default_value_int,
@@ -436,7 +436,7 @@ static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_uint64_checkmask = {
-    .name  = "uint64",
+    .type  = "uint64",
     .get   = get_uint64,
     .set   = set_uint64_checkmask,
 };
@@ -478,7 +478,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_string = {
-    .name  = "str",
+    .type  = "str",
     .release = release_string,
     .get   = get_string,
     .set   = set_string,
@@ -487,7 +487,7 @@ const PropertyInfo qdev_prop_string = {
 /* --- on/off/auto --- */
 
 const PropertyInfo qdev_prop_on_off_auto = {
-    .name = "OnOffAuto",
+    .type = "OnOffAuto",
     .description = "on/off/auto",
     .enum_table = &OnOffAuto_lookup,
     .get = qdev_propinfo_get_enum,
@@ -530,7 +530,7 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_size32 = {
-    .name  = "size",
+    .type  = "size",
     .get = qdev_propinfo_get_size32,
     .set = set_size32,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -733,7 +733,7 @@ static void default_prop_array(ObjectProperty *op, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_array = {
-    .name = "list",
+    .type = "list",
     .get = get_prop_array,
     .set = set_prop_array,
     .release = release_prop_array,
@@ -940,7 +940,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_size = {
-    .name  = "size",
+    .type  = "size",
     .get = get_size,
     .set = set_size,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -958,7 +958,7 @@ static ObjectProperty *create_link_property(ObjectClass *oc, const char *name,
 }
 
 const PropertyInfo qdev_prop_link = {
-    .name = "link",
+    .type = "link",
     .create = create_link_property,
 };
 
@@ -969,7 +969,7 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
 
     assert(!prop->info->create);
 
-    op = object_property_add(obj, prop->name, prop->info->name,
+    op = object_property_add(obj, prop->name, prop->info->type,
                              field_prop_getter(prop->info),
                              field_prop_setter(prop->info),
                              prop->info->release,
@@ -996,7 +996,7 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
         op = prop->info->create(oc, name, prop);
     } else {
         op = object_class_property_add(oc,
-                                       name, prop->info->name,
+                                       name, prop->info->type,
                                        field_prop_getter(prop->info),
                                        field_prop_setter(prop->info),
                                        prop->info->release,
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 86905479b8..f989afd325 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -652,7 +652,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
 }
 
 static const PropertyInfo trng_prop_fault_events = {
-    .name = "uint32:bits",
+    .type = "uint32:bits",
     .description = "Set to trigger TRNG fault events",
     .set = trng_prop_fault_event_set,
     .realized_set_allowed = true,
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
index 829832bd9f..6097a8b297 100644
--- a/hw/nvme/nguid.c
+++ b/hw/nvme/nguid.c
@@ -179,7 +179,7 @@ static void set_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_nguid = {
-    .name  = "str",
+    .type  = "str",
     .description =
         "NGUID or \"" NGUID_VALUE_AUTO "\" for random value",
     .get   = get_nguid,
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 1bc58e90ad..89013ae05f 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -502,7 +502,7 @@ static void bbram_prop_release_drive(Object *obj, const char *name,
 }
 
 static const PropertyInfo bbram_prop_drive = {
-    .name  = "str",
+    .type  = "str",
     .description = "Node name or ID of a block device to use as BBRAM backend",
     .realized_set_allowed = true,
     .get = bbram_prop_get_drive,
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index f7b849f7de..47be998d59 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -257,7 +257,7 @@ static void efuse_prop_release_drive(Object *obj, const char *name,
 }
 
 static const PropertyInfo efuse_prop_drive = {
-    .name  = "str",
+    .type  = "str",
     .description = "Node name or ID of a block device to use as eFUSE backend",
     .realized_set_allowed = true,
     .get = efuse_prop_get_drive,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1416ae202c..d436376f00 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -76,7 +76,7 @@ static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pci_busnr = {
-    .name = "busnr",
+    .type = "busnr",
     .get = prop_pci_busnr_get,
 };
 
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 30f2fb486f..5e789e6637 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -74,7 +74,7 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
 }
 
 const PropertyInfo ccw_loadparm = {
-    .name  = "ccw_loadparm",
+    .type  = "ccw_loadparm",
     .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
             " to the guest loader/kernel",
     .get = ccw_device_get_loadparm,
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b2d5327dbf..7c6fc4e56f 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2523,7 +2523,7 @@ out:
 }
 
 const PropertyInfo css_devid_propinfo = {
-    .name = "str",
+    .type = "str",
     .description = "Identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
@@ -2531,7 +2531,7 @@ const PropertyInfo css_devid_propinfo = {
 };
 
 const PropertyInfo css_devid_ro_propinfo = {
-    .name = "str",
+    .type = "str",
     .description = "Read-only identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 40b2567aa7..0bf01140b3 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1473,7 +1473,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo s390_pci_fid_propinfo = {
-    .name = "zpci_fid",
+    .type = "zpci_fid",
     .get = s390_pci_get_fid,
     .set = s390_pci_set_fid,
 };
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index d37f722cce..675184648a 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1525,7 +1525,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
 }
 
 const PropertyInfo qdev_prop_nv_gpudirect_clique = {
-    .name = "uint4",
+    .type = "uint4",
     .description = "NVIDIA GPUDirect Clique ID (0 - 15)",
     .get = get_nv_gpudirect_clique_id,
     .set = set_nv_gpudirect_clique_id,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b5..b325fe9ca8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1680,7 +1680,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .name = "pmu-num",
+    .type = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
 };
@@ -1721,7 +1721,7 @@ static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_mask = {
-    .name = "pmu-mask",
+    .type = "pmu-mask",
     .get = prop_pmu_mask_get,
     .set = prop_pmu_mask_set,
 };
@@ -1752,7 +1752,7 @@ static void prop_mmu_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mmu = {
-    .name = "mmu",
+    .type = "mmu",
     .get = prop_mmu_get,
     .set = prop_mmu_set,
 };
@@ -1783,7 +1783,7 @@ static void prop_pmp_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp = {
-    .name = "pmp",
+    .type = "pmp",
     .get = prop_pmp_get,
     .set = prop_pmp_set,
 };
@@ -1857,7 +1857,7 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_priv_spec = {
-    .name = "priv_spec",
+    .type = "priv_spec",
     .get = prop_priv_spec_get,
     .set = prop_priv_spec_set,
 };
@@ -1888,7 +1888,7 @@ static void prop_vext_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vext_spec = {
-    .name = "vext_spec",
+    .type = "vext_spec",
     .get = prop_vext_spec_get,
     .set = prop_vext_spec_set,
 };
@@ -1928,7 +1928,7 @@ static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vlen = {
-    .name = "vlen",
+    .type = "vlen",
     .get = prop_vlen_get,
     .set = prop_vlen_set,
 };
@@ -1968,7 +1968,7 @@ static void prop_elen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_elen = {
-    .name = "elen",
+    .type = "elen",
     .get = prop_elen_get,
     .set = prop_elen_set,
 };
@@ -2003,7 +2003,7 @@ static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbom_blksize = {
-    .name = "cbom_blocksize",
+    .type = "cbom_blocksize",
     .get = prop_cbom_blksize_get,
     .set = prop_cbom_blksize_set,
 };
@@ -2038,7 +2038,7 @@ static void prop_cbop_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbop_blksize = {
-    .name = "cbop_blocksize",
+    .type = "cbop_blocksize",
     .get = prop_cbop_blksize_get,
     .set = prop_cbop_blksize_set,
 };
@@ -2073,7 +2073,7 @@ static void prop_cboz_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cboz_blksize = {
-    .name = "cboz_blocksize",
+    .type = "cboz_blocksize",
     .get = prop_cboz_blksize_get,
     .set = prop_cboz_blksize_set,
 };
@@ -2108,7 +2108,7 @@ static void prop_mvendorid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mvendorid = {
-    .name = "mvendorid",
+    .type = "mvendorid",
     .get = prop_mvendorid_get,
     .set = prop_mvendorid_set,
 };
@@ -2143,7 +2143,7 @@ static void prop_mimpid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mimpid = {
-    .name = "mimpid",
+    .type = "mimpid",
     .get = prop_mimpid_get,
     .set = prop_mimpid_set,
 };
@@ -2199,7 +2199,7 @@ static void prop_marchid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_marchid = {
-    .name = "marchid",
+    .type = "marchid",
     .get = prop_marchid_get,
     .set = prop_marchid_set,
 };
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dd7af86de7..c3572b8a57 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -869,7 +869,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
 }
 
 static PropertyInfo qdev_prop_nwindows = {
-    .name  = "int",
+    .type  = "int",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,
 };
-- 
2.47.0


