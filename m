Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A121F8201D2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:32:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLn-0007vl-Rh; Fri, 29 Dec 2023 16:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLk-0007hd-Or
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:00 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLi-0007AM-PF
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:00 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d9b51093a0so3529369b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885097; x=1704489897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PP6EKVnGveQh2qDxwNT0eC81BelG1anG2yG8w9GFwNA=;
 b=d7X9uKnPchasoGk5zl4BkC8BqLWeMDjne3eQQ4qANRF3/9Qoo1TGPsuyBb0Hd3dpxr
 d+yJ6dui1bzOQvQNtAyMF5xomSn717wWsz12lXSmm8/+FxapSNbpJ/uK2JN/+sMroIMm
 gywpXJibrtZe9WxACzpXVi7hZ6e/wmH+7MMPyr6zxyaQ9tz/we4Od39pJy1jLnSswEvZ
 NSAcPdisw+K2dsqJdSd9o/C2+sSxCE/TZ8j2OXSwyUA8lhY3O6/3zODE2yl7kZw0Aj5L
 FLXoetpqyZJkbLRACpt5m8n0rvKkJ8nASwqqvtfBScS8Suv6TgfgW+ipjAqLnQNUnEyN
 VawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885097; x=1704489897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PP6EKVnGveQh2qDxwNT0eC81BelG1anG2yG8w9GFwNA=;
 b=HuMBMc6vFlRjpaza69NTVTR9+t0sLc2xGlSeAT5S7qS85a6oborUx6yDQxYgqnd0iA
 Mf7NTXkb1I5e2RCgVm1E+N/ukEp/x/jgTT0ZaH92DFgzMvc+USuVfPh+OvLoKBiLKnnT
 UVQwLAWaooydmv4PBR1LQesyyNzOKCTaCzmu7+bMOGWMMHP65W6x5e3Tnz4dJZbjdZXE
 l86cp0YiG7pv0V8UILRRdjPKjO5XPPcucrTvVyn5s6qTXGR3/GnztkZHxLtStg1FqiEy
 cSsBWhuPSkSj/P34DwD+cS3bBTanOba2IM91KM7F/ab2Zfw0whahCM94a8PQ9lMxgZn+
 OSFA==
X-Gm-Message-State: AOJu0YyUL7T47mQWpbiEBNKvgqNEcoyjYxraGg3UkdL7f1OIWlrIyh3D
 HDsKycuNFaknNsrvvs3q4w0mb/TlgqxPaqhBuUVc0gGSnwairw==
X-Google-Smtp-Source: AGHT+IEmA6QuS9wlwSFLXck2P+zik8/Q7sGuCMFYR9dnK8AMLVT4Pc63HIFtHfysVzLk/O7Pim3kCA==
X-Received: by 2002:a05:6a20:914f:b0:196:9770:2a05 with SMTP id
 x15-20020a056a20914f00b0019697702a05mr991070pzc.58.1703885097251; 
 Fri, 29 Dec 2023 13:24:57 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/71] hw/dma: Constify VMState
Date: Sat, 30 Dec 2023 08:23:02 +1100
Message-Id: <20231229212346.147149-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
Message-Id: <20231221031652.119827-28-richard.henderson@linaro.org>
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
index bc1505aade..ae307482f2 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -681,7 +681,7 @@ static const VMStateDescription vmstate_xlnx_csu_dma = {
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


