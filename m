Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B287D7B988E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 01:09:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoAzX-0002FV-DV; Wed, 04 Oct 2023 19:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qoAzV-0002FN-6t
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 19:09:17 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qoAzS-0003gX-Hf
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 19:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696460954; x=1727996954;
 h=subject:from:to:cc:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JirY2Bdn8JuUO/u42w284pidYgz9P2BCOP348Whj8RY=;
 b=cXUW+v+J8Nu94VWk9Ba/x4PAQykOLuNAtuYFI5Fby9X1/LttZvWyTFLM
 Uds0/stkHc65S7darIaPlX3t1ubEsW/5GI/IVvz8MNod74xWun2Gxqhgm
 D0TjaaiEHdff7tVi4lIFX3aDnPQDSsjjOWbqhYmy3hj9onoVbZ2PUZm7u
 4U+aKvHFpmc286y8fDWFRZPTODbRbKFHEkxIoV2nn6V/yvoZv9d5rBRvx
 zAYFuaYxqdqv624YuUbJUYEznq0ip2Qrzq6BQ5oUVqSP9YoEI1s1rakx0
 QW1+KxToUMHypLi+hJRzAzZyAxW3b748m0d13jJtyZxGUsbv23Cjst3BJ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="449821146"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; d="scan'208";a="449821146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2023 16:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="728202753"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; d="scan'208";a="728202753"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177])
 ([10.213.170.46])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2023 16:09:08 -0700
Subject: [PATCH v3] hw/cxl: Add QTG _DSM support for ACPI0017 device
From: Dave Jiang <dave.jiang@intel.com>
To: mst@redhat.com
Cc: thuth@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Jonathan.Cameron@huawei.com, imammedo@redhat.com, anisinha@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Date: Wed, 04 Oct 2023 16:09:07 -0700
Message-ID: <169646094762.643966.16021192876985391476.stgit@djiang5-mobl3>
In-Reply-To: <20231004180529-mutt-send-email-mst@kernel.org>
References: <20231004180529-mutt-send-email-mst@kernel.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=dave.jiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
ID value of 0 in all cases. The enabling is for _DSM plumbing testing
from the OS.

Following edited for readbility only

Device (CXLM)
{
    Name (_HID, "ACPI0017")  // _HID: Hardware ID
...
    Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
    {
        If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
        {
            If ((Arg2 == Zero))
            {
                Return (Buffer (One) { 0x01 })
            }

            If ((Arg2 == One))
            {
                Return (Package (0x02)
                {
                    Buffer (0x02)
                    { 0x01, 0x00 },
                    Package (0x01)
                    {
                        Buffer (0x02)
                        { 0x00, 0x00 }
                    }
                })
            }
        }
    }

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
v3: Fix output assignment to be BE host friendly. Fix typo in comment.
According to the CXL spec, the DSM output should be 1 WORD to indicate
the max suppoted QTG ID and a package of 0 or more WORDs for the QTG IDs.
In this dummy impementation, we have first WORD with a 1 to indcate max
supprted QTG ID of 1. And second WORD in a package to indicate the QTG
ID of 0.

v2: Minor edit to drop reference to switches in patch description.
Message-Id: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/cxl.c         |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |    1 +
 include/hw/acpi/cxl.h |    1 +
 3 files changed, 57 insertions(+)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 92b46bc9323b..cce12d5bc81c 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -30,6 +30,61 @@
 #include "qapi/error.h"
 #include "qemu/uuid.h"
 
+void build_cxl_dsm_method(Aml *dev)
+{
+    Aml *method, *ifctx, *ifctx2;
+
+    method = aml_method("_DSM", 4, AML_SERIALIZED);
+    {
+        Aml *function, *uuid;
+
+        uuid = aml_arg(0);
+        function = aml_arg(2);
+        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
+        ifctx = aml_if(aml_equal(
+            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
+
+        /* Function 0, standard DSM query function */
+        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
+        {
+            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
+
+            aml_append(ifctx2,
+                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
+        }
+        aml_append(ifctx, ifctx2);
+
+        /*
+         * Function 1
+         * A return value of {1, {0}} indicates that
+         * max supported QTG ID of 1 and recommended QTG is 0.
+         * The values here are faked to simplify emulation.
+         */
+        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
+        {
+            uint16_t word_list = cpu_to_le16(1);
+            uint16_t word_list2 = 0;
+            Aml *pak, *pak1;
+
+            /*
+             * The return package is a package of a WORD and another package.
+             * The embedded package contains 0 or more WORDs for the
+             * recommended QTG IDs.
+             */
+            pak1 = aml_package(1);
+            aml_append(pak1, aml_buffer(sizeof(uint16_t), word_list2));
+            pak = aml_package(2);
+            aml_append(pak, aml_buffer(sizeof(uint16_t), word_list));
+            aml_append(pak, pak1);
+
+            aml_append(ifctx2, aml_return(pak));
+        }
+        aml_append(ifctx, ifctx2);
+    }
+    aml_append(method, ifctx);
+    aml_append(dev, method);
+}
+
 static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
 {
     PXBDev *pxb = PXB_DEV(cxl);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 95199c89008a..692af40b1a75 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
     method = aml_method("_STA", 0, AML_NOTSERIALIZED);
     aml_append(method, aml_return(aml_int(0x01)));
     aml_append(dev, method);
+    build_cxl_dsm_method(dev);
 
     aml_append(scope, dev);
     aml_append(table, scope);
diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index acf441888683..8f22c71530d8 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state);
 void build_cxl_osc_method(Aml *dev);
+void build_cxl_dsm_method(Aml *dev);
 
 #endif



