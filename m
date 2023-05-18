Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2007B707838
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 04:47:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzTf2-0005NH-LS; Wed, 17 May 2023 22:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTef-0005EM-U4
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:26 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTea-0008F5-6S
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684377972; x=1715913972;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Zvl4Us5nFwXM+K5uC8NSDV+qsek+5uIPfbxF6GEL2Jw=;
 b=G5Ay7GXO/Yl9KIwtxa0ynVuJrTHQxAgFWRvNvpCk3dMKaGqPZTjF77oM
 QYhdjoIrfUmyScEwzBo3EuVgDzaRvjbj/zjLvik1H+W/ReV3OpwZIinOH
 +vbBvbFCi6UmG3/mODOsP0Rk/fay4yNlpRf9C/oNANGk+dicgp8T8TT3u
 V0r4aIGoTELy8bqRbzMoozYqnP7ytfRX1dJ9vd74KRqVfw2GcMrU5Miec
 aRKmdMOZIWe5td011BZ2W1EFxjeU0DdDAAOKKmOT3Hp/6jasxIbpHAEoL
 rEWKT5VJes4HffwBafwxfrjnPUXe/dx3vTkjRFl1DtV3pBmbS7ZduezAN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147107"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="380147107"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466733"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="652466733"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost)
 ([10.209.143.168])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:46:03 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 17 May 2023 19:45:56 -0700
Subject: [PATCH RFC 3/5] hw/cxl: Derive a CXL accelerator device from
 Type-3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-rfc-type2-dev-v1-3-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=4453;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Zvl4Us5nFwXM+K5uC8NSDV+qsek+5uIPfbxF6GEL2Jw=;
 b=t6ps/6MKxcDQEG2REfSRjLaEhVncO5i5rhmh8QiXSfeH4Z7SDLmaKDpZXI5Xv19k8ydbyl7uA
 GyZTLf0eDebDoXj3C3zJZIv+0RLg919zQo6QcqKHakcGW/zC8UkERx6
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Received-SPF: pass client-ip=192.55.52.88; envelope-from=ira.weiny@intel.com;
 helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is desirable to have a test accelerator device to present various
accelerator features such as Back-Invalidate (BI) registers to OS
software for testing.

BI accelerator devices require memory that can be easily modeled as a
sub-class of Type-3 device.

Derive 'cxl-accel' from cxl-type3.  Add documentation for such a device.

Follow on patches will add BI registers and other simulation of the
accelerator device.

Adding devices qemu can be done with the following example:

...
  -device cxl-accel,bus=sw0p0,volatile-memdev=cxl-ac-mem5,id=cxl-dev5,sn=0xCAFE0005
...

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
The device ID and class code are completely made up by me.  As discussed
in the last community call perhaps these could be declared in some more
official capacity?
---
 docs/system/devices/cxl.rst | 11 +++++++++++
 hw/mem/cxl_type3.c          | 28 ++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 16 ++++++++++++++++
 include/hw/pci/pci_ids.h    |  1 +
 4 files changed, 56 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 95900252c56a..5bc931be44b3 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -321,6 +321,17 @@ A very simple setup with just one directly attached CXL Type 3 Volatile Memory d
   -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
+A very simple setup with just one directly attached CXL Type 2 Volatile Memory
+Accelerator device::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-accel,bus=root_port13,volatile-memdev=vmem0,id=cxl-accel0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
 The same volatile setup may optionally include an LSA region::
 
   qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3e63dbd83551..c7eafd76d1ea 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1691,3 +1691,31 @@ static void ct3d_registers(void)
 }
 
 type_init(ct3d_registers);
+
+static void cxl_accel_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->class_id = PCI_CLASS_CXL_QEMU_ACCEL;
+    pc->vendor_id = PCI_VENDOR_ID_INTEL;
+    pc->device_id = 0xd94; /* LVF for now */
+    pc->revision = 1;
+
+    dc->desc = "CXL Accelerator Device (Type 2)";
+}
+
+static const TypeInfo cxl_accel_dev_info = {
+    .name = TYPE_CXL_ACCEL,
+    .parent = TYPE_CXL_TYPE3,
+    .class_size = sizeof(struct CXLAccelClass),
+    .class_init = cxl_accel_class_init,
+    .instance_size = sizeof(CXLAccelDev),
+};
+
+static void cxl_accel_dev_registers(void)
+{
+    type_register_static(&cxl_accel_dev_info);
+}
+
+type_init(cxl_accel_dev_registers);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cd7f28dba884..f7f6688ee6e2 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -432,6 +432,22 @@ struct CXLType3Class {
     bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
 };
 
+/*
+ * Accel devices are a type3 device but with additional functionality.
+ */
+struct CXLAccelDev {
+    /* Private: Must be first */
+    CXLType3Dev parent_obj;
+};
+
+struct CXLAccelClass {
+    /* Private: Must be first */
+    CXLType3Class parent_class;
+};
+
+#define TYPE_CXL_ACCEL "cxl-accel"
+OBJECT_DECLARE_TYPE(CXLAccelDev, CXLAccelClass, CXL_ACCEL)
+
 struct CSWMBCCIDev {
     PCIDevice parent_obj;
     CXLComponentState cxl_cstate;
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index e4386ebb2038..2dbf350ebba4 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -54,6 +54,7 @@
 #define PCI_CLASS_MEMORY_RAM             0x0500
 #define PCI_CLASS_MEMORY_FLASH           0x0501
 #define PCI_CLASS_MEMORY_CXL             0x0502
+#define PCI_CLASS_CXL_QEMU_ACCEL         0x0503
 #define PCI_CLASS_MEMORY_OTHER           0x0580
 
 #define PCI_BASE_CLASS_BRIDGE            0x06

-- 
2.40.0


