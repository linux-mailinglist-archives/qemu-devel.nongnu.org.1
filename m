Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA5BAAEFE5
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 02:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyI-0005wS-Nf; Wed, 07 May 2025 20:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyE-0005wH-7k
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyC-0006uN-BF
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so368948b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663515; x=1747268315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7+mohXqrdEbWb/P26+vE06tjBRbP4oy3sTl3Q0AKe8=;
 b=hvPOwYbPXZXh/47GLBcog8kxo9ZX5pHnir7DVE9YbcrZWuwf8GBNU950hwASHmfIYq
 flI2mT4uTnAaTNL0ks7qldLvJmVqsY0uHgu+la5/bVI3tOrMqh9QFtpLZfaovqE3Qry9
 sCVeRTFi7MCmH8vrLopnU7WucJXSRWZqQC6sNF0CeLP8dnrtQRicOhLxkZVE4cr4UJ5f
 nDSHsgQTK2GqS/wbWsOUv9aZ24ehpAlOgfDoeJnCcv3AHKKFNOrrWr8iYWbK/jcD3zwv
 bjTyZeBm2fXIw0TLzr5dpDwuaU0Bz1d79KQfv9MwnRpUUCbWwBGeJwLWuaockk/FF+6V
 uGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663515; x=1747268315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7+mohXqrdEbWb/P26+vE06tjBRbP4oy3sTl3Q0AKe8=;
 b=aGp2f7qHu7SsYjhto8vD5OBfa+Urv5zi7emxyL+ZOUuwmDeoMqUjfurrP+rdhmlyY7
 pXuWuUr5IzpmafS4T4/8IFfRsxQhI0ZKU4znUPa4GbCZvm599X/S2kr7GD6ToSFtPTFK
 a6V0UuFez6gk50nu3apBdxIp+YXGAfiWZriACpJPQRCAP0lc+h14wmAAEuRMKLOkDQVy
 MDtUylB3QzwV3B8s65JcpNnEL2GtkF+F0jvdtf9ZLrZUz8CUYwmhq9LXvVYAIfWzkDYZ
 8+LYnb2xqHpGyghXB/T45Y1PBm/M5nHMkTfBwQ4Q4OE1k2Dg6YxgwAAYTL6clBW3+oXR
 EMAg==
X-Gm-Message-State: AOJu0YznN0nUGLw9RkUohRFjaAwrprXpR0Y6pzIFbtIS0XIIsiK6y4m9
 aDVWKfIogTx8Ip5/yXrDtn1YhkOqVDQYI9tmqx9b613txF2QNQlKJHqJ2g==
X-Gm-Gg: ASbGncuFSn49wk0EgoC0fZAm441imK0CVvQAlzmeKg74doDf7qXc4GqLJVPt+3fYb9m
 mX3i7yxtOpmv72Xd0bHiyzgjBVffIDPYPMXJunLzF3+0Kl2MBkJvohi+GgpMg+yjq1tHzmMEoiU
 BO298bbqNiBIrG9icyWWTlhOmbOpexiMWnVYDPdPqJoOE5VKIpaEpOUP0dED5UyV9Lp+3yxRiKu
 pYDzaLxs/ZvkIlD3weurpQUFDbIPo1YWHh2lMcgA8g4RAYKa/sWfmScAXWlZ0wrxYr6kuZeqoHy
 nkrPQ/YXQFyXhiQuVl3fFzqhdrIJRbxLoxq3l30e20uiulQPYr0IF00pHJMgwQ==
X-Google-Smtp-Source: AGHT+IHibVqj8jZcLyVDhgi+myiefRMZk3bIo6OqeV4F51rIZRhUJ3r6wDFKZ2ARLgO9wOaFTfcN3w==
X-Received: by 2002:a05:6a00:ac86:b0:736:32d2:aa8e with SMTP id
 d2e1a72fcca58-7409cef5bd4mr7444822b3a.6.1746663514799; 
 Wed, 07 May 2025 17:18:34 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:34 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 02/10] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Date: Thu,  8 May 2025 00:00:58 +0000
Message-ID: <20250508001754.122180-3-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 56 ++++++++++++++++++++++++++++++++++++
 hw/cxl/i2c_mctp_cxl.c        |  6 ++--
 hw/mem/cxl_type3.c           |  4 +++
 include/hw/cxl/cxl_device.h  |  1 +
 include/hw/cxl/cxl_opcodes.h |  3 ++
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ed3294530f..d3c69233b8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3280,6 +3280,52 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h) */
+static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct {
+        uint8_t num_hosts;
+        uint8_t num_regions_supported;
+        uint8_t rsvd1[2];
+        uint16_t add_select_policy_bitmask;
+        uint8_t rsvd2[2];
+        uint16_t release_select_policy_bitmask;
+        uint8_t sanitize_on_release_bitmask;
+        uint8_t rsvd3;
+        uint64_t total_dynamic_capacity;
+        uint64_t region_blk_size_bitmasks[8];
+    } QEMU_PACKED *out = (void *)payload_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCRegion *region;
+    int i;
+
+    out->num_hosts = 1;
+    out->num_regions_supported = ct3d->dc.num_regions;
+    stw_le_p(&out->add_select_policy_bitmask,
+             BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE));
+    stw_le_p(&out->release_select_policy_bitmask,
+             BIT(CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE));
+    out->sanitize_on_release_bitmask = 0;
+
+    stq_le_p(&out->total_dynamic_capacity,
+             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        memcpy(&out->region_blk_size_bitmasks[i],
+               &region->supported_blk_size_bitmask,
+               sizeof(out->region_blk_size_bitmasks[i]));
+    }
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3401,6 +3447,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
+    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
+        cmd_fm_get_dcd_info, 0, 0 },
+};
+
 /*
  * While the command is executing in the background, the device should
  * update the percentage complete in the Background Command Status Register
@@ -3703,7 +3754,12 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+
     cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
+    }
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
index 7d2cbc3b75..dd5fc4f393 100644
--- a/hw/cxl/i2c_mctp_cxl.c
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
+#include "hw/cxl/cxl_opcodes.h"
 
 #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
 
@@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
          */
 
         if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
-              msg->command_set < 0x51) &&
+              msg->command_set < PHYSICAL_SWITCH) &&
             !(msg->message_type == MCTP_MT_CXL_FMAPI &&
-              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
+              msg->command_set >= PHYSICAL_SWITCH &&
+              msg->command_set < GLOBAL_MEMORY_ACCESS_EP_MGMT)) {
             buf->rc = CXL_MBOX_UNSUPPORTED;
             st24_le_p(buf->pl_length, len_out);
             s->len = s->pos;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 11c38a9292..7129da0940 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,6 +8,7 @@
  *
  * SPDX-License-Identifier: GPL-v2-only
  */
+#include <math.h>
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
@@ -766,6 +767,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     uint64_t region_len;
     uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
+    /* Only 1 block size is supported for now. */
+    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
     CXLDCRegion *region;
     MemoryRegion *mr;
     uint64_t dc_size;
@@ -811,6 +814,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .block_size = blk_size,
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
+            .supported_blk_size_bitmask = supported_blk_size_bitmask,
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..bebed04085 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
     uint32_t dsmadhandle;
     uint8_t flags;
     unsigned long *blk_bitmap;
+    uint64_t supported_blk_size_bitmask;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index 26d3a99e8a..c4c233665e 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -61,4 +61,7 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
         #define GET_MHD_INFO 0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO 0x0
+    GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2


