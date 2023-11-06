Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D2E7E1AB8
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:07:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztaC-0005ag-7f; Mon, 06 Nov 2023 01:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZY-0004Y0-F3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZW-0001Qt-BN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso29646335ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253932; x=1699858732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m53YqcNay6DKtZWpyzeFBitBWrEFsuDLerLGkVtaxDo=;
 b=hUQYCr/DqzrZuezXBV2BJDl5zd4YckHhAnsWNqtBjZcz0dK/G8r+BsE/9w+x1nOHYh
 5DkXLIherPvO2DopjiUfsEgEYFusl1KRQpSiaqSIsZySRbwcrXcfMMbVxXUi+62Zy13F
 NmviYCMGxhJn8TxuVJ8UIZlujVmI/M1a10CJHKCiStwHglRM6EW+AlBDSVy/o26kG0Wy
 A3YBpJRiBAB9kkPE4pexZe+DooksoOZo2SgYpc68AMPABw3Qtlw8Alxpa1mZTOyoto6j
 7Mjqaus5M7SupHzNArB4+8rgfZUbcsFAzCc5bHvMYdGoRcnTNewypKXumBKk8ET4V4F+
 hhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253932; x=1699858732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m53YqcNay6DKtZWpyzeFBitBWrEFsuDLerLGkVtaxDo=;
 b=hAM3xUXXUR8CZwmS6QAxeiprGG0wgMImO3R2vWPYLNCE2/pNHraSym5ZOeJuHu+4qy
 pqD3Dw1Jx4eeD6H646eiAiFetKsHklANqBagKorODvW5yhlZpTbekYLy+CFPhU1IGLWd
 HOxr6MdK+fFv2zZp/QW9+37TGIrBL3iUJD1WiLoX51QpIXqo7jk9OA6oUegU27xVG2XF
 KILONKwkcgNbYQ8cpARVaDkqLR9XX4/cBOl6GwXMs8pvL9gs+p1fSw+CwgUx8Q6w/XKp
 itUpNwNjrNUG1uEa6uEqJuQ1HZ5JpRCqbp4tiQFblGNKWlxv1IkBL5ANBT8dokrfmNcC
 Tfng==
X-Gm-Message-State: AOJu0YwLCV1IOeiilzVH/jAnSo/4lUJMd2HW5a0tGmjCODLp5pfjR+5/
 quk85SMv/Msrm7xAeYo+fDBXqMRruPwpzXKdWoA=
X-Google-Smtp-Source: AGHT+IGnxWYCfChuxkJkLZaJFPJvfdPtX7mtGTqwdDPIcYPiC0C2yb2JqWZIdA2NiSXmN6O0EESx8A==
X-Received: by 2002:a17:903:1103:b0:1cc:e76d:e7b2 with SMTP id
 n3-20020a170903110300b001cce76de7b2mr30670plh.22.1699253932554; 
 Sun, 05 Nov 2023 22:58:52 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 27/71] hw/dma: Constify VMState
Date: Sun,  5 Nov 2023 22:57:43 -0800
Message-Id: <20231106065827.543129-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 hw/dma/bcm2835_dma.c      |  4 ++--
 hw/dma/i82374.c           |  2 +-
 hw/dma/i8257.c            |  4 ++--
 hw/dma/pl080.c            |  4 ++--
 hw/dma/pl330.c            | 10 +++++-----
 hw/dma/pxa2xx_dma.c       |  4 ++--
 hw/dma/rc4030.c           |  2 +-
 hw/dma/sparc32_dma.c      |  2 +-
 hw/dma/xlnx-zdma.c        |  2 +-
 hw/dma/xlnx-zynq-devcfg.c |  4 ++--
 hw/dma/xlnx_csu_dma.c     |  2 +-
 hw/dma/xlnx_dpdma.c       |  2 +-
 12 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 5e9306110d..9bda45072b 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -311,7 +311,7 @@ static const VMStateDescription vmstate_bcm2835_dma_chan = {
     .name = TYPE_BCM2835_DMA "-chan",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cs, BCM2835DMAChan),
         VMSTATE_UINT32(conblk_ad, BCM2835DMAChan),
         VMSTATE_UINT32(ti, BCM2835DMAChan),
@@ -329,7 +329,7 @@ static const VMStateDescription vmstate_bcm2835_dma = {
     .name = TYPE_BCM2835_DMA,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(chan, BCM2835DMAState, BCM2835_DMA_NCHANS, 1,
                              vmstate_bcm2835_dma_chan, BCM2835DMAChan),
         VMSTATE_UINT32(int_status, BCM2835DMAState),
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 63734c22c9..f6ddfc51c5 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -58,7 +58,7 @@ static const VMStateDescription vmstate_i82374 = {
     .name = "i82374",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(commands, I82374State, 8),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index de5f696919..de1d5b110c 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -517,7 +517,7 @@ static const VMStateDescription vmstate_i8257_regs = {
     .name = "dma_regs",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_ARRAY(now, I8257Regs, 2),
         VMSTATE_UINT16_ARRAY(base, I8257Regs, 2),
         VMSTATE_UINT8(mode, I8257Regs),
@@ -542,7 +542,7 @@ static const VMStateDescription vmstate_i8257 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = i8257_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(command, I8257State),
         VMSTATE_UINT8(mask, I8257State),
         VMSTATE_UINT8(flip_flop, I8257State),
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 2627307cc8..1e49c22e93 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -39,7 +39,7 @@ static const VMStateDescription vmstate_pl080_channel = {
     .name = "pl080_channel",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(src, pl080_channel),
         VMSTATE_UINT32(dest, pl080_channel),
         VMSTATE_UINT32(lli, pl080_channel),
@@ -53,7 +53,7 @@ static const VMStateDescription vmstate_pl080 = {
     .name = "pl080",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(tc_int, PL080State),
         VMSTATE_UINT8(tc_mask, PL080State),
         VMSTATE_UINT8(err_int, PL080State),
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index e7e67dd8b6..70a502d245 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -139,7 +139,7 @@ static const VMStateDescription vmstate_pl330_chan = {
     .name = "pl330_chan",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(src, PL330Chan),
         VMSTATE_UINT32(dst, PL330Chan),
         VMSTATE_UINT32(pc, PL330Chan),
@@ -170,7 +170,7 @@ static const VMStateDescription vmstate_pl330_fifo = {
     .name = "pl330_chan",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VBUFFER_UINT32(buf, PL330Fifo, 1, NULL, buf_size),
         VMSTATE_VBUFFER_UINT32(tag, PL330Fifo, 1, NULL, buf_size),
         VMSTATE_UINT32(head, PL330Fifo),
@@ -194,7 +194,7 @@ static const VMStateDescription vmstate_pl330_queue_entry = {
     .name = "pl330_queue_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(addr, PL330QueueEntry),
         VMSTATE_UINT32(len, PL330QueueEntry),
         VMSTATE_UINT8(n, PL330QueueEntry),
@@ -216,7 +216,7 @@ static const VMStateDescription vmstate_pl330_queue = {
     .name = "pl330_queue",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(queue, PL330Queue, queue_size,
                                              vmstate_pl330_queue_entry,
                                              PL330QueueEntry),
@@ -280,7 +280,7 @@ static const VMStateDescription vmstate_pl330 = {
     .name = "pl330",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(manager, PL330State, 0, vmstate_pl330_chan, PL330Chan),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(chan, PL330State, num_chnls,
                                              vmstate_pl330_chan, PL330Chan),
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index fa896f7edf..9f62f0b633 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -529,7 +529,7 @@ static const VMStateDescription vmstate_pxa2xx_dma_chan = {
     .name = "pxa2xx_dma_chan",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(descr, PXA2xxDMAChannel),
         VMSTATE_UINT32(src, PXA2xxDMAChannel),
         VMSTATE_UINT32(dest, PXA2xxDMAChannel),
@@ -544,7 +544,7 @@ static const VMStateDescription vmstate_pxa2xx_dma = {
     .name = "pxa2xx_dma",
     .version_id = 1,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UNUSED_TEST(is_version_0, 4),
         VMSTATE_UINT32(stopintr, PXA2xxDMAState),
         VMSTATE_UINT32(eorintr, PXA2xxDMAState),
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index aa1d323a36..915284194f 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -568,7 +568,7 @@ static const VMStateDescription vmstate_rc4030 = {
     .name = "rc4030",
     .version_id = 3,
     .post_load = rc4030_post_load,
-    .fields = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT32(config, rc4030State),
         VMSTATE_UINT32(invalid_address_register, rc4030State),
         VMSTATE_UINT32_2DARRAY(dma_regs, rc4030State, 8, 4),
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 0ef13c5e9a..8019641942 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -249,7 +249,7 @@ static const VMStateDescription vmstate_sparc32_dma_device = {
     .name ="sparc32_dma",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(dmaregs, DMADeviceState, DMA_REGS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 84c0083013..670c956866 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -801,7 +801,7 @@ static const VMStateDescription vmstate_zdma = {
     .name = TYPE_XLNX_ZDMA,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxZDMA, ZDMA_R_MAX),
         VMSTATE_UINT32(state, XlnxZDMA),
         VMSTATE_UINT32_ARRAY(dsc_src.words, XlnxZDMA, 4),
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index f5ad1a0d22..e901f68ff3 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -333,7 +333,7 @@ static const VMStateDescription vmstate_xlnx_zynq_devcfg_dma_cmd = {
     .name = "xlnx_zynq_devcfg_dma_cmd",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(src_addr, XlnxZynqDevcfgDMACmd),
         VMSTATE_UINT32(dest_addr, XlnxZynqDevcfgDMACmd),
         VMSTATE_UINT32(src_len, XlnxZynqDevcfgDMACmd),
@@ -346,7 +346,7 @@ static const VMStateDescription vmstate_xlnx_zynq_devcfg = {
     .name = "xlnx_zynq_devcfg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(dma_cmd_fifo, XlnxZynqDevcfg,
                              XLNX_ZYNQ_DEVCFG_DMA_CMD_FIFO_LEN, 0,
                              vmstate_xlnx_zynq_devcfg_dma_cmd,
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index e89089821a..3a38fc8330 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -677,7 +677,7 @@ static const VMStateDescription vmstate_xlnx_csu_dma = {
     .name = TYPE_XLNX_CSU_DMA,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(src_timer, XlnxCSUDMA),
         VMSTATE_UINT16(width, XlnxCSUDMA),
         VMSTATE_BOOL(is_dst, XlnxCSUDMA),
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index dd66be5265..1f5cd64ed1 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -277,7 +277,7 @@ static inline bool xlnx_dpdma_desc_ignore_done_bit(DPDMADescriptor *desc)
 static const VMStateDescription vmstate_xlnx_dpdma = {
     .name = TYPE_XLNX_DPDMA,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(registers, XlnxDPDMAState,
                              XLNX_DPDMA_REG_ARRAY_SIZE),
         VMSTATE_BOOL_ARRAY(operation_finished, XlnxDPDMAState, 6),
-- 
2.34.1


