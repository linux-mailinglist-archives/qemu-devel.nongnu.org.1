Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 450BE7BC227
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 00:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qot7P-0001vb-VC; Fri, 06 Oct 2023 18:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qot7M-0001vR-3x
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 18:16:21 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qot7E-0008OJ-Jx
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 18:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696630572; x=1728166572;
 h=subject:from:to:cc:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y9nBHhI4ICWumE9p5NoZE4vrDlLV5gGjd5+Fhcwg3VY=;
 b=mf6mO+jXhs8dNyPlayNqeFHRDoQ83SVXbnTSC+fO6oXdmehVwKUtcdvD
 WR7Qnq3iLmeRCg4q4meLImdJsWTG/a68nIqSn2q2jVM/YW7ZtwWIy3jA5
 lWhJBBH1u5acAq6I9vtsH0y8yg3U4lvhxrilE0TM9ja5k01QTj+IqkPTc
 A8veMjZIs0snrtK8CK3S3QdQtBnCjEfUhATMIJ7DAuYBVh6n2S7bAPR1e
 T4OH3vCULypcci1HKSATvyYgLeofoww48xZsLTRFKEQCFXNGWllRnBiiC
 DnTYKI/zhLqn+fW5gBHYLtvv9rg3TD74WaFihsQI/q01JAmhKJwcjzjJn w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5399353"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="5399353"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2023 15:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="896030824"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; d="scan'208";a="896030824"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177])
 ([10.212.13.39])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2023 15:14:24 -0700
Subject: [PATCH v4] hw/cxl: Add QTG _DSM support for ACPI0017 device
From: Dave Jiang <dave.jiang@intel.com>
To: mst@redhat.com
Cc: thuth@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Jonathan.Cameron@huawei.com, imammedo@redhat.com, anisinha@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
Date: Fri, 06 Oct 2023 15:15:56 -0700
Message-ID: <169663055629.1214042.8019806314058171125.stgit@djiang5-mobl3>
In-Reply-To: <652048e465c8d_ae7e7294e9@dwillia2-xfh.jf.intel.com.notmuch>
References: <652048e465c8d_ae7e7294e9@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a simple _DSM call support for the ACPI0017 device to return fake QTG
ID values of 0 and 1 in all cases. This for _DSM plumbing testing from the OS.

Following edited for readability

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
                    One,
                    Package (0x02)
                    {
                        Zero,
                        One
                    }
                })
            }
        }
    }

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
v4: Change to package of ints rather than buffers. Also moved to 2 QTG IDs
to improve kernel side testing. Tested on x86 qemu guest against kernel
QTG ID _DSM parsing code to be upstreamed.

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
 hw/acpi/cxl.c         |   69 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |    1 +
 include/hw/acpi/cxl.h |    1 +
 3 files changed, 71 insertions(+)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 92b46bc9323b..9cd7905ea25a 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -30,6 +30,75 @@
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
+        /* CXL spec v3.0 9.17.3.1 _DSM Function for Retrieving QTG ID */
+        ifctx = aml_if(aml_equal(
+            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
+
+        /* Function 0, standard DSM query function */
+        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
+        {
+            uint8_t byte_list[1] = { 0x01 }; /* function 1 only */
+
+            aml_append(ifctx2,
+                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
+        }
+        aml_append(ifctx, ifctx2);
+
+        /*
+         * Function 1
+         * Creating a package with static values. The max supported QTG ID will
+         * be 1 and recommended QTG IDs are 0 and then 1.
+         * The values here are statically created to simplify emulation. Values
+         * from a real BIOS would be determined by the performance of all the
+         * present CXL memory and then assigned.
+         */
+        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
+        {
+            Aml *pak, *pak1;
+
+            /*
+             * Return: A package containing two elements - a WORD that returns
+             * the maximum throttling group that the platform supports, and a
+             * package containing the QTG ID(s) that the platform recommends.
+             * Package {
+             *     Max Supported QTG ID
+             *     Package {QTG Recommendations}
+             * }
+             *
+             * While the SPEC specified WORD that hints at the value being
+             * 16bit, the ACPI dump of BIOS DSDT table showed that the values
+             * are integers with no specific size specification. aml_int() will
+             * be used for the values.
+             */
+            pak1 = aml_package(2);
+            /* Set QTG ID of 0 */
+            aml_append(pak1, aml_int(0));
+            /* Set QTG ID of 1 */
+            aml_append(pak1, aml_int(1));
+
+            pak = aml_package(2);
+            /* Set Max QTG 1 */
+            aml_append(pak, aml_int(1));
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



