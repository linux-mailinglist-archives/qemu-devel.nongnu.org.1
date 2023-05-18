Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A911707836
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 04:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzTew-0005Dq-JQ; Wed, 17 May 2023 22:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTeb-0005Ag-I0
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:09 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTeY-0008FP-8I
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684377966; x=1715913966;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=fgYFIBYZiC7VkXbsH0IZVBAWLK9AVSYJozqW9Xe6I5s=;
 b=Rf5cvFu8arEAdIccKHrfuuEIjN5qQjLkSJbD/coj2LM4pRkO2N53WwGN
 ojd93k/SKLlXkivuWIBVyGt4Do26uKhkVgbO/p7Vw1vp3/s3eeurS5enI
 rDASgNfOsvYKvsjN9SOtkUYWHbGV1f41qsMZsAlIu3Xa38yiVYtfJ8mYE
 nsn1T8VYEZ5uS7zu9mPmss/QpEOtPvocS3jTswCSXAJrAFDgQTGLgs+qj
 KuemfgfhnQCy6bYfDCr/IHDcQxsPluwJLPan/jBgN7l8QpDLQCDnPeSVq
 FrUA0YUYTw31YD19zh6FM0498/Xn+kwW5UDlWvz1ts+APWXuDypK5GP5u g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147102"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="380147102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466723"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="652466723"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost)
 ([10.209.143.168])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:46:01 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 17 May 2023 19:45:55 -0700
Subject: [PATCH RFC 2/5] hw/cxl: Refactor component register initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-rfc-type2-dev-v1-2-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=7352;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=fgYFIBYZiC7VkXbsH0IZVBAWLK9AVSYJozqW9Xe6I5s=;
 b=SW7kGCKggTN6hR3Zz1KBGJtDWJ6DutD7NzX+M9yuDiSMekVRqQFSqEyQRFrh93NOuHDLpOJLX
 8aDLH5TsRMlCHn9+7wyp1Yo19PYUS2SHVYntsoWDtPqMIL13cQzaoBs
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

CXL 3.0 8.2.4 Table 8-22 defines which capabilities are mandatory, not
permitted, or optional for each type of device.

cxl_component_register_init_common() uses a rather odd 'fall through'
mechanism to define each component register set.  This assumes that any
device or capability being added builds on the previous devices
capabilities.  This is not true as there are mutually exclusive
capabilities defined.  For example, downstream ports can not have snoop
but it can have Back Invalidate capable decoders.

Refactor this code to make it easier to add individual capabilities as
defined by a device type.  Any capability which is not specified by the
type is left NULL'ed out which complies with the packed nature of the
register array.

Update all spec references to 3.0.

No functional changes should be seen with this patch.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-component-utils.c   | 73 ++++++++++++++++--------------------------
 include/hw/cxl/cxl_component.h | 36 ++++++++++++++-------
 2 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 0e23e132ed3a..7949d12b7351 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -198,43 +198,19 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
 {
     int caps = 0;
 
-    /*
-     * In CXL 2.0 the capabilities required for each CXL component are such that,
-     * with the ordering chosen here, a single number can be used to define
-     * which capabilities should be provided.
-     */
-    switch (type) {
-    case CXL2_DOWNSTREAM_PORT:
-    case CXL2_DEVICE:
-        /* RAS, Link */
-        caps = 2;
-        break;
-    case CXL2_UPSTREAM_PORT:
-    case CXL2_TYPE3_DEVICE:
-    case CXL2_LOGICAL_DEVICE:
-        /* + HDM */
-        caps = 3;
-        break;
-    case CXL2_ROOT_PORT:
-        /* + Extended Security, + Snoop */
-        caps = 5;
-        break;
-    default:
-        abort();
-    }
-
     memset(reg_state, 0, CXL2_COMPONENT_CM_REGION_SIZE);
 
     /* CXL Capability Header Register */
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ID, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
-    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 
 #define init_cap_reg(reg, id, version)                                        \
-    QEMU_BUILD_BUG_ON(CXL_##reg##_REGISTERS_OFFSET == 0);                     \
+    QEMU_BUILD_BUG_ON(CXL_##reg##_CAP_HDR_IDX == 0);                          \
     do {                                                                      \
-        int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
+        int which = CXL_##reg##_CAP_HDR_IDX;                                  \
+        if (CXL_##reg##_CAP_HDR_IDX > caps)                                   \
+            caps = CXL_##reg##_CAP_HDR_IDX;                                   \
         reg_state[which] = FIELD_DP32(reg_state[which],                       \
                                       CXL_##reg##_CAPABILITY_HEADER, ID, id); \
         reg_state[which] =                                                    \
@@ -245,25 +221,32 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
-    init_cap_reg(RAS, 2, 2);
-    ras_init_common(reg_state, write_msk);
-
-    init_cap_reg(LINK, 4, 2);
-
-    if (caps < 3) {
-        return;
-    }
-
-    init_cap_reg(HDM, 5, 1);
-    hdm_init_common(reg_state, write_msk, type);
-
-    if (caps < 5) {
-        return;
+    /* CXL 3.0 8.2.4 Table 8-22 */
+    switch (type) {
+    case CXL2_ROOT_PORT:
+        /* + Extended Security, + Snoop */
+        init_cap_reg(EXTSEC, 6, 1);
+        init_cap_reg(SNOOP, 8, 1);
+        /* FALL THROUGH */
+    case CXL2_UPSTREAM_PORT:
+    case CXL2_TYPE3_DEVICE:
+    case CXL2_LOGICAL_DEVICE:
+        /* + HDM */
+        init_cap_reg(HDM, 5, 1);
+        hdm_init_common(reg_state, write_msk, type);
+        /* FALL THROUGH */
+    case CXL2_DOWNSTREAM_PORT:
+    case CXL2_DEVICE:
+        /* RAS, Link */
+        init_cap_reg(RAS, 2, 2);
+        ras_init_common(reg_state, write_msk);
+        init_cap_reg(LINK, 4, 2);
+        break;
+    default:
+        abort();
     }
 
-    init_cap_reg(EXTSEC, 6, 1);
-    init_cap_reg(SNOOP, 8, 1);
-
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 #undef init_cap_reg
 }
 
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index bca2b756c202..7c08c02c5e9d 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -31,29 +31,41 @@ enum reg_type {
 };
 
 /*
- * Capability registers are defined at the top of the CXL.cache/mem region and
- * are packed. For our purposes we will always define the caps in the same
- * order.
- * CXL 2.0 - 8.2.5 Table 142 for details.
+ * CXL 3.0 - 8.2.4 Table 8-22 and 8-23
+ *
+ * Capability registers are defined at the top of the CXL.cache/mem region.
+ * They are defined to be packed and at variable offsets.  However, NULL
+ * capabilities can be added to the packed array.  To facilitate easier access
+ * within the QEMU code, define these at specified offsets.  Then NULL out any
+ * capabilities for devices which don't (or can't) have a particular capability
+ * (see cxl_component_register_init_common).  NULL capabilities are to be
+ * ignored by software.
+ *
+ * 'offsets' are based on index's which can then be used to report the array
+ * size in CXL Capability Header Register (index/offset 0).
+ *
+ * See CXL 3.0 Table 8-25 for an example of allowing a 'NULL' header.
  */
 
-/* CXL 2.0 - 8.2.5.1 */
+/* CXL 3.0 - 8.2.4.1 */
 REG32(CXL_CAPABILITY_HEADER, 0)
     FIELD(CXL_CAPABILITY_HEADER, ID, 0, 16)
     FIELD(CXL_CAPABILITY_HEADER, VERSION, 16, 4)
     FIELD(CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 20, 4)
     FIELD(CXL_CAPABILITY_HEADER, ARRAY_SIZE, 24, 8)
 
-#define CXLx_CAPABILITY_HEADER(type, offset)                  \
-    REG32(CXL_##type##_CAPABILITY_HEADER, offset)             \
+/* CXL 3.0 - 8.2.4.2 on... */
+#define CXLx_CAPABILITY_HEADER(type, idx)                     \
+    enum { CXL_##type##_CAP_HDR_IDX = idx };                  \
+    REG32(CXL_##type##_CAPABILITY_HEADER, (idx * 0x4))        \
         FIELD(CXL_##type##_CAPABILITY_HEADER, ID, 0, 16)      \
         FIELD(CXL_##type##_CAPABILITY_HEADER, VERSION, 16, 4) \
         FIELD(CXL_##type##_CAPABILITY_HEADER, PTR, 20, 12)
-CXLx_CAPABILITY_HEADER(RAS, 0x4)
-CXLx_CAPABILITY_HEADER(LINK, 0x8)
-CXLx_CAPABILITY_HEADER(HDM, 0xc)
-CXLx_CAPABILITY_HEADER(EXTSEC, 0x10)
-CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
+CXLx_CAPABILITY_HEADER(RAS, 1)
+CXLx_CAPABILITY_HEADER(LINK, 2)
+CXLx_CAPABILITY_HEADER(HDM, 3)
+CXLx_CAPABILITY_HEADER(EXTSEC, 4)
+CXLx_CAPABILITY_HEADER(SNOOP, 5)
 
 /*
  * Capability structures contain the actual registers that the CXL component

-- 
2.40.0


