Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D1707835
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 04:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzTf2-0005LU-BT; Wed, 17 May 2023 22:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTeg-0005EO-IM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:26 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1pzTee-0008FG-Ln
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684377972; x=1715913972;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=46y0FaBxziwuSbTAR4YOkMaktxaMBddzA2VrCi6VZS8=;
 b=VNpv8Akb3diDsKpX0e6kuYE7BDprO7avY8MHT4BdRK/PCRcwBbg9ajrE
 Iqppyk1zRaqus2yYHmoNBrW+LSAFiKtYyOaYkZ4+JjyDvrt//L/1wpglo
 402EaTQgY91aNaUT3CEtg0qmYs2HjUBUGmThlxjolP+2SpF0ChTx5iZmQ
 JvKyqqb8WDjvn0U/6HyV1ndMk5dOLhhaAvJEGdcNyEtIHwbDHNnbuYByl
 rgbVa10TuqXw3AYIaWUNFds19TERzr/kpnpdB0UTmxu69yJjsQnG+cm/F
 OHX0X1aoIARERhdXxZcmuQe0ketg26PvzK18eWHoIgFr1cVC84Fexr84f w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147110"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="380147110"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466741"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="652466741"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost)
 ([10.209.143.168])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 19:46:05 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 17 May 2023 19:45:57 -0700
Subject: [PATCH RFC 4/5] hw/cxl/accel: Add Back-Invalidate decoder
 capbility structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-rfc-type2-dev-v1-4-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=3758;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=46y0FaBxziwuSbTAR4YOkMaktxaMBddzA2VrCi6VZS8=;
 b=Tkagk9parcBDGYn7JPISiNLaEp7zYK69R4NQPXePCpSdSOpb2z/s+4AHvAKQ/quxnhs3APqae
 lCSEEGALSI9D2QWgJyqJl/rTjUs087YuKIgDiLdsbb2DJ8AVIAj1DyX
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

The presence of the Back-Invalidate (BI) decoder capability structure
indicates a CXL downstream port, root port, or device supports the BI
messages.

Add the BI capability structure to the accelerator device.

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-component-utils.c   |  5 +++++
 hw/mem/cxl_type3.c             | 11 +++++++++++
 include/hw/cxl/cxl_component.h | 11 +++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 7949d12b7351..a9efa252b4ae 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -228,6 +228,7 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
         init_cap_reg(EXTSEC, 6, 1);
         init_cap_reg(SNOOP, 8, 1);
         /* FALL THROUGH */
+    case CXL3_TYPE2_DEVICE:
     case CXL2_UPSTREAM_PORT:
     case CXL2_TYPE3_DEVICE:
     case CXL2_LOGICAL_DEVICE:
@@ -246,6 +247,10 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
         abort();
     }
 
+    if (type == CXL3_TYPE2_DEVICE) {
+        init_cap_reg(BI_DECODER, 12, 1);
+    }
+
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 #undef init_cap_reg
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c7eafd76d1ea..95fdaaa18f37 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1692,6 +1692,16 @@ static void ct3d_registers(void)
 
 type_init(ct3d_registers);
 
+static void accel_reset(DeviceState *dev)
+{
+    CXLAccelDev *acceld = CXL_ACCEL(dev);
+    uint32_t *reg_state = acceld->parent_obj.cxl_cstate.crb.cache_mem_registers;
+    uint32_t *write_msk = acceld->parent_obj.cxl_cstate.crb.cache_mem_regs_write_mask;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL3_TYPE2_DEVICE);
+    cxl_device_register_init_common(&acceld->parent_obj.cxl_dstate);
+}
+
 static void cxl_accel_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -1703,6 +1713,7 @@ static void cxl_accel_class_init(ObjectClass *oc, void *data)
     pc->revision = 1;
 
     dc->desc = "CXL Accelerator Device (Type 2)";
+    dc->reset = accel_reset;
 }
 
 static const TypeInfo cxl_accel_dev_info = {
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 7c08c02c5e9d..a5b5512aed94 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -28,6 +28,7 @@ enum reg_type {
     CXL2_UPSTREAM_PORT,
     CXL2_DOWNSTREAM_PORT,
     CXL3_SWITCH_MAILBOX_CCI,
+    CXL3_TYPE2_DEVICE,
 };
 
 /*
@@ -66,6 +67,7 @@ CXLx_CAPABILITY_HEADER(LINK, 2)
 CXLx_CAPABILITY_HEADER(HDM, 3)
 CXLx_CAPABILITY_HEADER(EXTSEC, 4)
 CXLx_CAPABILITY_HEADER(SNOOP, 5)
+CXLx_CAPABILITY_HEADER(BI_DECODER, 6)
 
 /*
  * Capability structures contain the actual registers that the CXL component
@@ -185,9 +187,14 @@ HDM_DECODER_INIT(3);
     (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
 #define CXL_SNOOP_REGISTERS_SIZE   0x8
 
+/* CXL 3.0 8.2.4.26 - CXL BI Decoder Capability Structure */
+#define CXL_BI_DECODER_REGISTERS_OFFSET \
+    (CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE)
+#define CXL_BI_DECODER_REGISTERS_SIZE   0xC
+
 /* CXL 3.0 8.2.3 Table 8-21 */
-QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
-                    CXL_SNOOP_REGISTERS_SIZE) >= CXL2_COMPONENT_CM_REGION_SIZE,
+QEMU_BUILD_BUG_MSG((CXL_BI_DECODER_REGISTERS_OFFSET +
+                    CXL_BI_DECODER_REGISTERS_SIZE) >= CXL2_COMPONENT_CM_REGION_SIZE,
                    "No space for registers");
 
 typedef struct component_registers {

-- 
2.40.0


