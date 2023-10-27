Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 910907D9BF6
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:46:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0w-00015l-MP; Fri, 27 Oct 2023 10:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0P-0007Ol-Kh
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0J-0008Du-H4
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32da4ffd7e5so1293110f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417601; x=1699022401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=69Xdi2XBUCVbdo4LLU2JuEwOaiPWz+F25ncB1rn8HfE=;
 b=qc/69B+0JAn5Ula0SQkclyFagw8a4JWokWGtJoH3qxOhYUXywpm6DhUmpKRiRXDlFc
 HiMxF7OP1XOgV/y29ovEK/87f3TMBMPf9B8gvTLILsn+iMvqFTQGdfB+3+DB53i2+SbJ
 ozRBketF+c/YgbEQTu1jBWDzU28bLT4F1vLZ+ilXQPkdSkVTI54bhz5nEjF3BtE86z0h
 KfcuJTWMgnVJBiwsZYsl+H5C2Lh9lzDvCC6G25kF9tu2Rqdss5TjKZjm40fQj8L9CkDN
 YGVOZrdRCKx3wgv1SfAyq5CtJnZtToOZqVvxdXlYdxQwwukp6EXrlm8MMGl8BKAMisvu
 MdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417601; x=1699022401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69Xdi2XBUCVbdo4LLU2JuEwOaiPWz+F25ncB1rn8HfE=;
 b=IyCUJojGYkBdHh2NQL3zpZS7OipuBJJRxJ6KJGp3zCKWQrHNd9xOQ/1E12AX8Cj3K2
 ETNPgx45XtFukRiEkhCMI7vHIJ15Ah0p+TUe1eOhZanw/gbzHC5kL3ABo7xUfAYBLGMJ
 GJWXd9Z12LjYZRpDSVCoMRHkoPdN4eIaabiMNHAQrUZeWXn2Alhv+lgIgSGZpUt3I3Il
 4jGltktlSWGm6hJ+JSiY/gWplgXl98vDAHohsDoagBc56GG9Y7Z2xBNpUdMg7QH4uBSt
 VJ3HiBV8Pfuw5b1rWIgvAmjlD2f0LVlKM20tD5KnMDyeRjLkyc5JOZVhMbmDditPUPDe
 cvig==
X-Gm-Message-State: AOJu0Yx0lufzUnREmVMWGSV8N5YMvfdfu7DxvlLi5CThHbpn5BF4bDi4
 u+4ChnqT7l2GiyxpEvd/EfDIYVlA0hQzSo4khCY=
X-Google-Smtp-Source: AGHT+IHH+fLCUx/YQxQr489nOPtaoKGpeZdGxjY6EbxtNmk5FNTAHW4FW2RCMXFX/BiOdGsn9uy6GQ==
X-Received: by 2002:a5d:5850:0:b0:32f:7341:96bb with SMTP id
 i16-20020a5d5850000000b0032f734196bbmr1711857wrf.19.1698417601373; 
 Fri, 27 Oct 2023 07:40:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] hw/net/cadence_gem: use FIELD to describe DMACFG
 register fields
Date: Fri, 27 Oct 2023 15:39:36 +0100
Message-Id: <20231027143942.3413881-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Luc Michel <luc.michel@amd.com>

Use de FIELD macro to describe the DMACFG register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-6-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 48 ++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index cf8b1261ed5..e3724b84471 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -110,7 +110,27 @@ REG32(NWCFG, 0x4) /* Network Config reg */
 
 REG32(NWSTATUS, 0x8) /* Network Status reg */
 REG32(USERIO, 0xc) /* User IO reg */
+
 REG32(DMACFG, 0x10) /* DMA Control reg */
+    FIELD(DMACFG, SEND_BCAST_TO_ALL_QS, 31, 1)
+    FIELD(DMACFG, DMA_ADDR_BUS_WIDTH, 30, 1)
+    FIELD(DMACFG, TX_BD_EXT_MODE_EN , 29, 1)
+    FIELD(DMACFG, RX_BD_EXT_MODE_EN , 28, 1)
+    FIELD(DMACFG, FORCE_MAX_AMBA_BURST_TX, 26, 1)
+    FIELD(DMACFG, FORCE_MAX_AMBA_BURST_RX, 25, 1)
+    FIELD(DMACFG, FORCE_DISCARD_ON_ERR, 24, 1)
+    FIELD(DMACFG, RX_BUF_SIZE, 16, 8)
+    FIELD(DMACFG, CRC_ERROR_REPORT, 13, 1)
+    FIELD(DMACFG, INF_LAST_DBUF_SIZE_EN, 12, 1)
+    FIELD(DMACFG, TX_PBUF_CSUM_OFFLOAD, 11, 1)
+    FIELD(DMACFG, TX_PBUF_SIZE, 10, 1)
+    FIELD(DMACFG, RX_PBUF_SIZE, 8, 2)
+    FIELD(DMACFG, ENDIAN_SWAP_PACKET, 7, 1)
+    FIELD(DMACFG, ENDIAN_SWAP_MGNT, 6, 1)
+    FIELD(DMACFG, HDR_DATA_SPLIT_EN, 5, 1)
+    FIELD(DMACFG, AMBA_BURST_LEN , 0, 5)
+#define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplier */
+
 REG32(TXSTATUS, 0x14) /* TX Status reg */
 REG32(RXQBASE, 0x18) /* RX Q Base address reg */
 REG32(TXQBASE, 0x1c) /* TX Q Base address reg */
@@ -265,13 +285,6 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
-#define GEM_DMACFG_ADDR_64B    (1U << 30)
-#define GEM_DMACFG_TX_BD_EXT   (1U << 29)
-#define GEM_DMACFG_RX_BD_EXT   (1U << 28)
-#define GEM_DMACFG_RBUFSZ_M    0x00FF0000 /* DMA RX Buffer Size mask */
-#define GEM_DMACFG_RBUFSZ_S    16         /* DMA RX Buffer Size shift */
-#define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplier */
-#define GEM_DMACFG_TXCSUM_OFFL 0x00000800 /* Transmit checksum offload */
 
 #define GEM_TXSTATUS_TXCMPL    0x00000020 /* Transmit Complete */
 #define GEM_TXSTATUS_USED      0x00000001 /* sw owned descriptor encountered */
@@ -369,7 +382,7 @@ static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0];
 
-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
         ret |= (uint64_t)desc[2] << 32;
     }
     return ret;
@@ -414,7 +427,7 @@ static inline uint64_t rx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0] & ~0x3UL;
 
-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
         ret |= (uint64_t)desc[2] << 32;
     }
     return ret;
@@ -424,11 +437,11 @@ static inline int gem_get_desc_len(CadenceGEMState *s, bool rx_n_tx)
 {
     int ret = 2;
 
-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
         ret += 2;
     }
-    if (s->regs[R_DMACFG] & (rx_n_tx ? GEM_DMACFG_RX_BD_EXT
-                                       : GEM_DMACFG_TX_BD_EXT)) {
+    if (s->regs[R_DMACFG] & (rx_n_tx ? R_DMACFG_RX_BD_EXT_MODE_EN_MASK
+                                     : R_DMACFG_TX_BD_EXT_MODE_EN_MASK)) {
         ret += 2;
     }
 
@@ -942,7 +955,7 @@ static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
 {
     hwaddr desc_addr = 0;
 
-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
         desc_addr = s->regs[tx ? R_TBQPH : R_RBQPH];
     }
     desc_addr <<= 32;
@@ -1024,8 +1037,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* The configure size of each receive buffer.  Determines how many
      * buffers needed to hold this packet.
      */
-    rxbufsize = ((s->regs[R_DMACFG] & GEM_DMACFG_RBUFSZ_M) >>
-                 GEM_DMACFG_RBUFSZ_S) * GEM_DMACFG_RBUFSZ_MUL;
+    rxbufsize = FIELD_EX32(s->regs[R_DMACFG], DMACFG, RX_BUF_SIZE);
+    rxbufsize *= GEM_DMACFG_RBUFSZ_MUL;
+
     bytes_to_copy = size;
 
     /* Hardware allows a zero value here but warns against it. To avoid QEMU
@@ -1308,7 +1322,7 @@ static void gem_transmit(CadenceGEMState *s)
                 gem_update_int_status(s);
 
                 /* Is checksum offload enabled? */
-                if (s->regs[R_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
+                if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, TX_PBUF_CSUM_OFFLOAD)) {
                     net_checksum_calculate(s->tx_packet, total_bytes, CSUM_ALL);
                 }
 
@@ -1332,7 +1346,7 @@ static void gem_transmit(CadenceGEMState *s)
 
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
-                if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+                if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
                     packet_desc_addr = s->regs[R_TBQPH];
                     packet_desc_addr <<= 32;
                 } else {
-- 
2.34.1


