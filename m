Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80581AD29
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:19:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9aM-0002l1-6n; Wed, 20 Dec 2023 22:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aJ-0002Vv-4f
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:55 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aG-0003z5-Dd
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:54 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f02843e91so1936536d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128731; x=1703733531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldnBIx+uht+xPIjG2OMwkuesvmvICbT7ollHd1Fw++k=;
 b=ziK4Hth/0NgKVhdy7MDVFWbwwQ9RRnXVYKMtrXlLkKsDW7g7+YgJgJjLDV96iGjTeN
 BJ+uZLumgm9NYfaPgI7yOAlqBuD+4bZibwpXh3NzFt3p1Vk1ouy+oe1g8JhaQ2CUxddc
 TzjQL1/xt6GnCwmjPxL3TBRILk5V7REjsOs5AIrKiyA/JasAvEavCiJq9nDDwXyFSZhl
 9LK1A50wCtkCbywSg1fvCpg0oKpULg3tZla2lJOwNmT6PTOEiURm0CjHAD8D0dI7j0Ye
 S9g6STKfIXA+ZhBRS0gvUfD1T/XxMFbcvDW5e7VcmUG4+LD9jnR4DYMWWeVIylh8OMUx
 Iq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128731; x=1703733531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldnBIx+uht+xPIjG2OMwkuesvmvICbT7ollHd1Fw++k=;
 b=cZqatonjkN9GCgZXi15AFbQafYTsv2q8Rq7qsOUlJC6I2F/QrjN4R0f6medfJzFeEB
 k8EJO10EkJayPAds2YhG2hKHeVqpZXGTTkpoV0+6z4rGncLpOZV9Q1dTldx5FCZWJLcV
 zNoxAAWWuHiGcOHGp818DmSFnSb3KRpAJy/3yJxfnIjFmMFkTBP9hTOyOpslX1LTFscT
 4ZkhhVupZNB3RC/cmWuGmRfSax2sCv7BqRuoHagI3Qp+t1ec1lp/niww1ksh32jFRn8E
 Ybbur4I50Bp2gy6ZlgASTErVeYbay4pOryTbL7xSbk9hyE7E5CAmhRAkrlGa2FQiW8Yj
 wAzA==
X-Gm-Message-State: AOJu0YwwhyjKNeGdyTtFLpRLj0xUFr/zZeIH4REy28rG9iuk+IHcYmDb
 Xd2RCy7S7e7QNJm4zUQ873c/BdhRFfhUc9gdCVkzxSp7
X-Google-Smtp-Source: AGHT+IGxdhQkYyvZNedt6Z/JiJ9mJkniuX1xPJL4gTYG217kxJYHaXsYyP9MzlRBIPSNGzWIy3Va6A==
X-Received: by 2002:a05:6214:1c4d:b0:67f:78e9:4698 with SMTP id
 if13-20020a0562141c4d00b0067f78e94698mr1771199qvb.64.1703128731267; 
 Wed, 20 Dec 2023 19:18:51 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/71] hw/display: Constify VMState
Date: Thu, 21 Dec 2023 14:16:07 +1100
Message-Id: <20231221031652.119827-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/display/artist.c           |  2 +-
 hw/display/bcm2835_fb.c       |  2 +-
 hw/display/bochs-display.c    |  2 +-
 hw/display/cg3.c              |  2 +-
 hw/display/cirrus_vga.c       |  4 ++--
 hw/display/dpcd.c             |  2 +-
 hw/display/exynos4210_fimd.c  |  4 ++--
 hw/display/g364fb.c           |  4 ++--
 hw/display/i2c-ddc.c          |  2 +-
 hw/display/jazz_led.c         |  2 +-
 hw/display/macfb.c            |  6 +++---
 hw/display/pl110.c            |  2 +-
 hw/display/pxa2xx_lcd.c       |  4 ++--
 hw/display/qxl.c              | 10 +++++-----
 hw/display/ramfb-standalone.c |  2 +-
 hw/display/ramfb.c            |  2 +-
 hw/display/sii9022.c          |  2 +-
 hw/display/sm501.c            |  6 +++---
 hw/display/ssd0303.c          |  2 +-
 hw/display/ssd0323.c          |  2 +-
 hw/display/tcx.c              |  2 +-
 hw/display/vga-pci.c          |  2 +-
 hw/display/vga.c              |  6 +++---
 hw/display/virtio-gpu.c       |  8 ++++----
 hw/display/virtio-vga.c       |  2 +-
 hw/display/vmware_vga.c       |  4 ++--
 hw/display/xlnx_dp.c          |  2 +-
 27 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index fde050c882..d9134532fb 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1435,7 +1435,7 @@ static const VMStateDescription vmstate_artist = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = vmstate_artist_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(height, ARTISTState),
         VMSTATE_UINT16(width, ARTISTState),
         VMSTATE_UINT16(depth, ARTISTState),
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index a05277674f..e40ed2d2e1 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -355,7 +355,7 @@ static const VMStateDescription vmstate_bcm2835_fb = {
     .name = TYPE_BCM2835_FB,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(lock, BCM2835FBState),
         VMSTATE_BOOL(invalidate, BCM2835FBState),
         VMSTATE_BOOL(pending, BCM2835FBState),
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 9138e98c3b..3b1d922b6e 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -61,7 +61,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(BochsDisplayState, BOCHS_DISPLAY)
 
 static const VMStateDescription vmstate_bochs_display = {
     .name = "bochs-display",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(pci, BochsDisplayState),
         VMSTATE_UINT16_ARRAY(vbe_regs, BochsDisplayState, VBE_DISPI_INDEX_NB),
         VMSTATE_BOOL(big_endian_fb, BochsDisplayState),
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 2e9656ae1c..b271faaa48 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -334,7 +334,7 @@ static const VMStateDescription vmstate_cg3 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = vmstate_cg3_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(height, CG3State),
         VMSTATE_UINT16(width, CG3State),
         VMSTATE_UINT16(depth, CG3State),
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index b80f98b6c4..5dd5136a0c 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2739,7 +2739,7 @@ const VMStateDescription vmstate_cirrus_vga = {
     .version_id = 2,
     .minimum_version_id = 1,
     .post_load = cirrus_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(vga.latch, CirrusVGAState),
         VMSTATE_UINT8(vga.sr_index, CirrusVGAState),
         VMSTATE_BUFFER(vga.sr, CirrusVGAState),
@@ -2777,7 +2777,7 @@ static const VMStateDescription vmstate_pci_cirrus_vga = {
     .name = "cirrus_vga",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCICirrusVGAState),
         VMSTATE_STRUCT(cirrus_vga, PCICirrusVGAState, 0,
                        vmstate_cirrus_vga, CirrusVGAState),
diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index 64463654a1..aab1b1a2d7 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -135,7 +135,7 @@ static const VMStateDescription vmstate_dpcd = {
     .name = TYPE_DPCD,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY_V(dpcd_info, DPCDState, DPCD_READABLE_AREA, 0),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 34a960a976..84687527d5 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1865,7 +1865,7 @@ static const VMStateDescription exynos4210_fimd_window_vmstate = {
     .name = "exynos4210.fimd_window",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(wincon, Exynos4210fimdWindow),
         VMSTATE_UINT32_ARRAY(buf_start, Exynos4210fimdWindow, 3),
         VMSTATE_UINT32_ARRAY(buf_end, Exynos4210fimdWindow, 3),
@@ -1895,7 +1895,7 @@ static const VMStateDescription exynos4210_fimd_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = exynos4210_fimd_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(vidcon, Exynos4210fimdState, 4),
         VMSTATE_UINT32_ARRAY(vidtcon, Exynos4210fimdState, 4),
         VMSTATE_UINT32(shadowcon, Exynos4210fimdState),
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 2903cab82d..e08ec3f8de 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -455,7 +455,7 @@ static const VMStateDescription vmstate_g364fb = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = g364fb_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER_UNSAFE(color_palette, G364State, 0, 256 * 3),
         VMSTATE_BUFFER_UNSAFE(cursor_palette, G364State, 0, 9),
         VMSTATE_UINT16_ARRAY(cursor, G364State, 512),
@@ -521,7 +521,7 @@ static const VMStateDescription vmstate_g364fb_sysbus = {
     .name = "g364fb-sysbus",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(g364, G364SysBusState, 2, vmstate_g364fb, G364State),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index 146489518c..3f9d1e1f6f 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -88,7 +88,7 @@ static void i2c_ddc_init(Object *obj)
 static const VMStateDescription vmstate_i2c_ddc = {
     .name = TYPE_I2CDDC,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(firstbyte, I2CDDCState),
         VMSTATE_UINT8(reg, I2CDDCState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index dd5f4696c4..534f15dcfd 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -257,7 +257,7 @@ static const VMStateDescription vmstate_jazz_led = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = jazz_led_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(segments, LedState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index d61541ccb5..418e99c8e1 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -627,7 +627,7 @@ static const VMStateDescription vmstate_macfb = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = macfb_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(type, MacfbState),
         VMSTATE_UINT8_ARRAY(color_palette, MacfbState, 256 * 3),
         VMSTATE_UINT32(palette_current, MacfbState),
@@ -770,7 +770,7 @@ static const VMStateDescription vmstate_macfb_sysbus = {
     .name = "macfb-sysbus",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(macfb, MacfbSysBusState, 1, vmstate_macfb, MacfbState),
         VMSTATE_END_OF_LIST()
     }
@@ -789,7 +789,7 @@ static const VMStateDescription vmstate_macfb_nubus = {
     .name = "macfb-nubus",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(macfb, MacfbNubusState, 1, vmstate_macfb, MacfbState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 4bf15c1da5..4b83db9322 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -83,7 +83,7 @@ static const VMStateDescription vmstate_pl110 = {
     .version_id = 2,
     .minimum_version_id = 1,
     .post_load = vmstate_pl110_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(version, PL110State),
         VMSTATE_UINT32_ARRAY(timing, PL110State, 4),
         VMSTATE_UINT32(cr, PL110State),
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index eb83d88222..a9d0d981a0 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -1371,7 +1371,7 @@ static const VMStateDescription vmstate_dma_channel = {
     .name = "dma_channel",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(branch, struct DMAChannel),
         VMSTATE_UINT8(up, struct DMAChannel),
         VMSTATE_BUFFER(pbuffer, struct DMAChannel),
@@ -1398,7 +1398,7 @@ static const VMStateDescription vmstate_pxa2xx_lcdc = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = pxa2xx_lcdc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(irqlevel, PXA2xxLCDState),
         VMSTATE_INT32(transp, PXA2xxLCDState),
         VMSTATE_UINT32_ARRAY(control, PXA2xxLCDState, 6),
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 7bb00d68f5..7178dec85d 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2388,7 +2388,7 @@ static const VMStateDescription qxl_memslot = {
     .name               = "qxl-memslot",
     .version_id         = QXL_SAVE_VERSION,
     .minimum_version_id = QXL_SAVE_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(slot.mem_start, struct guest_slots),
         VMSTATE_UINT64(slot.mem_end,   struct guest_slots),
         VMSTATE_UINT32(active,         struct guest_slots),
@@ -2400,7 +2400,7 @@ static const VMStateDescription qxl_surface = {
     .name               = "qxl-surface",
     .version_id         = QXL_SAVE_VERSION,
     .minimum_version_id = QXL_SAVE_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(width,      QXLSurfaceCreate),
         VMSTATE_UINT32(height,     QXLSurfaceCreate),
         VMSTATE_INT32(stride,      QXLSurfaceCreate),
@@ -2419,7 +2419,7 @@ static const VMStateDescription qxl_vmstate_monitors_config = {
     .version_id         = 1,
     .minimum_version_id = 1,
     .needed = qxl_monitors_config_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(guest_monitors_config, PCIQXLDevice),
         VMSTATE_END_OF_LIST()
     },
@@ -2432,7 +2432,7 @@ static const VMStateDescription qxl_vmstate = {
     .pre_save           = qxl_pre_save,
     .pre_load           = qxl_pre_load,
     .post_load          = qxl_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(pci, PCIQXLDevice),
         VMSTATE_STRUCT(vga, PCIQXLDevice, 0, vmstate_vga_common, VGACommonState),
         VMSTATE_UINT32(shadow_rom.mode, PCIQXLDevice),
@@ -2452,7 +2452,7 @@ static const VMStateDescription qxl_vmstate = {
         VMSTATE_UINT64(guest_cursor, PCIQXLDevice),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &qxl_vmstate_monitors_config,
         NULL
     }
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index a96e7ebcd9..20eab34ff4 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -54,7 +54,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = migrate_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_POINTER(state, RAMFBStandaloneState, ramfb_vmstate, RAMFBState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 477ef7272a..6086baf7a9 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -129,7 +129,7 @@ const VMStateDescription ramfb_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ramfb_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER_UNSAFE(cfg, RAMFBState, 0, sizeof(RAMFBCfg)),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index 664fd4046d..60c3f78549 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -51,7 +51,7 @@ static const VMStateDescription vmstate_sii9022 = {
     .name = "sii9022",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_I2C_SLAVE(parent_obj, sii9022_state),
         VMSTATE_UINT8(ptr, sii9022_state),
         VMSTATE_BOOL(addr_byte, sii9022_state),
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 5b4e4509e1..26dc8170d8 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1940,7 +1940,7 @@ static const VMStateDescription vmstate_sm501_state = {
     .name = "sm501-state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(local_mem_size_index, SM501State),
         VMSTATE_UINT32(system_control, SM501State),
         VMSTATE_UINT32(misc_control, SM501State),
@@ -2071,7 +2071,7 @@ static const VMStateDescription vmstate_sm501_sysbus = {
     .name = TYPE_SYSBUS_SM501,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(state, SM501SysBusState, 1,
                        vmstate_sm501_state, SM501State),
         VMSTATE_END_OF_LIST()
@@ -2161,7 +2161,7 @@ static const VMStateDescription vmstate_sm501_pci = {
     .name = TYPE_PCI_SM501,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, SM501PCIState),
         VMSTATE_STRUCT(state, SM501PCIState, 1,
                        vmstate_sm501_state, SM501State),
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index 32b32a3044..e292cff44e 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -281,7 +281,7 @@ static const VMStateDescription vmstate_ssd0303 = {
     .name = "ssd0303_oled",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(row, ssd0303_state),
         VMSTATE_INT32(col, ssd0303_state),
         VMSTATE_INT32(start_line, ssd0303_state),
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index 09b1bbed0a..96cf0dc662 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -324,7 +324,7 @@ static const VMStateDescription vmstate_ssd0323 = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = ssd0323_post_load,
-    .fields      = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT32(cmd_len, ssd0323_state),
         VMSTATE_INT32(cmd, ssd0323_state),
         VMSTATE_INT32_ARRAY(cmd_data, ssd0323_state, 8),
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 1b27b64f6d..99507e7638 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -344,7 +344,7 @@ static const VMStateDescription vmstate_tcx = {
     .version_id = 4,
     .minimum_version_id = 4,
     .post_load = vmstate_tcx_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(height, TCXState),
         VMSTATE_UINT16(width, TCXState),
         VMSTATE_UINT16(depth, TCXState),
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index e4f45b4476..2d8adce5da 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -61,7 +61,7 @@ static const VMStateDescription vmstate_vga_pci = {
     .name = "vga",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIVGAState),
         VMSTATE_STRUCT(vga, PCIVGAState, 0, vmstate_vga_common, VGACommonState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 37557c3442..886a4020e5 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2106,7 +2106,7 @@ static const VMStateDescription vmstate_vga_endian = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vga_endian_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(big_endian_fb, VGACommonState),
         VMSTATE_END_OF_LIST()
     }
@@ -2117,7 +2117,7 @@ const VMStateDescription vmstate_vga_common = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = vga_common_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(latch, VGACommonState),
         VMSTATE_UINT8(sr_index, VGACommonState),
         VMSTATE_PARTIAL_BUFFER(sr, VGACommonState, 8),
@@ -2149,7 +2149,7 @@ const VMStateDescription vmstate_vga_common = {
         VMSTATE_UINT32(vbe_bank_mask, VGACommonState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_vga_endian,
         NULL
     }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b016d3bac8..bae1c2a803 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1164,7 +1164,7 @@ static void virtio_gpu_cursor_bh(void *opaque)
 static const VMStateDescription vmstate_virtio_gpu_scanout = {
     .name = "virtio-gpu-one-scanout",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(resource_id, struct virtio_gpu_scanout),
         VMSTATE_UINT32(width, struct virtio_gpu_scanout),
         VMSTATE_UINT32(height, struct virtio_gpu_scanout),
@@ -1182,7 +1182,7 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
 static const VMStateDescription vmstate_virtio_gpu_scanouts = {
     .name = "virtio-gpu-scanouts",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(parent_obj.enable, struct VirtIOGPU),
         VMSTATE_UINT32_EQUAL(parent_obj.conf.max_outputs,
                              struct VirtIOGPU, NULL),
@@ -1592,7 +1592,7 @@ static const VMStateDescription vmstate_virtio_gpu = {
     .name = "virtio-gpu",
     .minimum_version_id = VIRTIO_GPU_VM_VERSION,
     .version_id = VIRTIO_GPU_VM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE /* core */,
         {
             .name = "virtio-gpu",
@@ -1605,7 +1605,7 @@ static const VMStateDescription vmstate_virtio_gpu = {
         } /* device */,
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_gpu_blob_state,
         NULL
     },
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index c8552ff760..94d3353f54 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -88,7 +88,7 @@ static const VMStateDescription vmstate_virtio_vga_base = {
     .name = "virtio-vga",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* no pci stuff here, saving the virtio device will handle that */
         VMSTATE_STRUCT(vga, VirtIOVGABase, 0,
                        vmstate_vga_common, VGACommonState),
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 3f26bea190..1c0f9d9a99 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1210,7 +1210,7 @@ static const VMStateDescription vmstate_vmware_vga_internal = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = vmsvga_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_EQUAL(new_depth, struct vmsvga_state_s, NULL),
         VMSTATE_INT32(enable, struct vmsvga_state_s),
         VMSTATE_INT32(config, struct vmsvga_state_s),
@@ -1235,7 +1235,7 @@ static const VMStateDescription vmstate_vmware_vga = {
     .name = "vmware_vga",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, struct pci_vmsvga_state_s),
         VMSTATE_STRUCT(chip, struct pci_vmsvga_state_s, 0,
                        vmstate_vmware_vga_internal, struct vmsvga_state_s),
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index eee8f33a58..c42fc388dc 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -262,7 +262,7 @@ typedef enum DPVideoFmt DPVideoFmt;
 static const VMStateDescription vmstate_dp = {
     .name = TYPE_XLNX_DP,
     .version_id = 2,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT32_ARRAY(core_registers, XlnxDPState,
                              DP_CORE_REG_ARRAY_SIZE),
         VMSTATE_UINT32_ARRAY(avbufm_registers, XlnxDPState,
-- 
2.34.1


