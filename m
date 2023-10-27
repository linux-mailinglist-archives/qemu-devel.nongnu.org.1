Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D089A7D9BD1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0r-0000Ck-N8; Fri, 27 Oct 2023 10:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0P-0007Oj-4u
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0J-0008C3-GY
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so17644225e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417601; x=1699022401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3AEUIB8yn0hixPrf1HubNO1SABrmzlE4AhxVnHqSdzA=;
 b=oeYkMsYcSRkSCiNr75VpbX5o9IOlecyULt4XEUMx3Rs3Cs1zMDHYdE6bp6475U5Qme
 YcOZsMop9pN4kI5qmBd8+upixkcXdsnpYQZ2flUbAkujjNUgx8BDvbX55mMBZA47Lz9L
 5fX6gJlqQtejgwm9REdPjMfIdb/aiGu6q/F9ooRIpB6LAHbL0p3eTwHJkTvzsjT35NQZ
 H1wb2/1oGaSw+gklJKIapGlB1tejdpXyK/JOTENhPWEu+uNl7M9y/i2PltR6HpRsU9z8
 tn5QWgI9eom0BRmgMvGjBwFjOE0rgAZ+g7RvOpaWULP58Zif6dPLTrOK+wu/jLalvZCC
 hMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417601; x=1699022401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AEUIB8yn0hixPrf1HubNO1SABrmzlE4AhxVnHqSdzA=;
 b=dhAr1QSCjEfRfUQEY+eJZyiqRlmFMGxoaMxC6Pz+wIJ93iSlRHW7mWs6l0EGoXwUT7
 mL8K0ReFWQWIiX/sws+OdobfVdON/YZeJO7cbDIxaAReLDeOz40+MNG+Ynte9g0hzbKu
 JsiG0XSMZ9KPikT1WMOlCh+pwiM8Iv5Edf+x+7iY1uNhz9CTuwsS8KU/lO4nWKCzYQ0t
 H+8YbdsqIl3fPypRttJdCCgWFInVT3JQOcA3vb1kRhF3JnFjk9nO0QsRnK1k760unGGD
 ZL92U1U1y//BxY7nx1t9Z8mqWn7LXvbU44+lD/1xmm2lFrydNTUS32MPkE53x9AR+/KL
 k5Mg==
X-Gm-Message-State: AOJu0YxZTif2d2nuWuzAAqK9oU0rHs2VxW9DhMJ+MAF/oM6M2bINwDRy
 5BXrmGhxNrNTtPa3Oc7Wph3xMjNrL10yrG7XNLc=
X-Google-Smtp-Source: AGHT+IH5+HEG7Ay2nl7WChonzrXypyoKifojsERvSpyu5SrX4WGLtVDi+ut2nL+Rv8C/tkqBIGNThQ==
X-Received: by 2002:a05:600c:1390:b0:404:7659:ba39 with SMTP id
 u16-20020a05600c139000b004047659ba39mr2466818wmf.16.1698417600958; 
 Fri, 27 Oct 2023 07:40:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] hw/net/cadence_gem: use FIELD to describe NWCFG register
 fields
Date: Fri, 27 Oct 2023 15:39:35 +0100
Message-Id: <20231027143942.3413881-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Use de FIELD macro to describe the NWCFG register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-5-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 60 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 1bcc9b6811b..cf8b1261ed5 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -79,6 +79,35 @@ REG32(NWCTRL, 0x0) /* Network Control reg */
     FIELD(NWCTRL, IFG_EATS_QAV_CREDIT, 30, 1)
 
 REG32(NWCFG, 0x4) /* Network Config reg */
+    FIELD(NWCFG, SPEED, 0, 1)
+    FIELD(NWCFG, FULL_DUPLEX, 1, 1)
+    FIELD(NWCFG, DISCARD_NON_VLAN_FRAMES, 2, 1)
+    FIELD(NWCFG, JUMBO_FRAMES, 3, 1)
+    FIELD(NWCFG, PROMISC, 4, 1)
+    FIELD(NWCFG, NO_BROADCAST, 5, 1)
+    FIELD(NWCFG, MULTICAST_HASH_EN, 6, 1)
+    FIELD(NWCFG, UNICAST_HASH_EN, 7, 1)
+    FIELD(NWCFG, RECV_1536_BYTE_FRAMES, 8, 1)
+    FIELD(NWCFG, EXTERNAL_ADDR_MATCH_EN, 9, 1)
+    FIELD(NWCFG, GIGABIT_MODE_ENABLE, 10, 1)
+    FIELD(NWCFG, PCS_SELECT, 11, 1)
+    FIELD(NWCFG, RETRY_TEST, 12, 1)
+    FIELD(NWCFG, PAUSE_ENABLE, 13, 1)
+    FIELD(NWCFG, RECV_BUF_OFFSET, 14, 2)
+    FIELD(NWCFG, LEN_ERR_DISCARD, 16, 1)
+    FIELD(NWCFG, FCS_REMOVE, 17, 1)
+    FIELD(NWCFG, MDC_CLOCK_DIV, 18, 3)
+    FIELD(NWCFG, DATA_BUS_WIDTH, 21, 2)
+    FIELD(NWCFG, DISABLE_COPY_PAUSE_FRAMES, 23, 1)
+    FIELD(NWCFG, RECV_CSUM_OFFLOAD_EN, 24, 1)
+    FIELD(NWCFG, EN_HALF_DUPLEX_RX, 25, 1)
+    FIELD(NWCFG, IGNORE_RX_FCS, 26, 1)
+    FIELD(NWCFG, SGMII_MODE_ENABLE, 27, 1)
+    FIELD(NWCFG, IPG_STRETCH_ENABLE, 28, 1)
+    FIELD(NWCFG, NSP_ACCEPT, 29, 1)
+    FIELD(NWCFG, IGNORE_IPG_RX_ER, 30, 1)
+    FIELD(NWCFG, UNI_DIRECTION_ENABLE, 31, 1)
+
 REG32(NWSTATUS, 0x8) /* Network Status reg */
 REG32(USERIO, 0xc) /* User IO reg */
 REG32(DMACFG, 0x10) /* DMA Control reg */
@@ -236,17 +265,6 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
-#define GEM_NWCFG_STRIP_FCS    0x00020000 /* Strip FCS field */
-#define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with len err */
-#define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer offset mask */
-#define GEM_NWCFG_BUFF_OFST_S  14         /* Receive buffer offset shift */
-#define GEM_NWCFG_RCV_1538     0x00000100 /* Receive 1538 bytes frame */
-#define GEM_NWCFG_UCAST_HASH   0x00000080 /* accept unicast if hash match */
-#define GEM_NWCFG_MCAST_HASH   0x00000040 /* accept multicast if hash match */
-#define GEM_NWCFG_BCAST_REJ    0x00000020 /* Reject broadcast packets */
-#define GEM_NWCFG_PROMISC      0x00000010 /* Accept all packets */
-#define GEM_NWCFG_JUMBO_FRAME  0x00000008 /* Jumbo Frames enable */
-
 #define GEM_DMACFG_ADDR_64B    (1U << 30)
 #define GEM_DMACFG_TX_BD_EXT   (1U << 29)
 #define GEM_DMACFG_RX_BD_EXT   (1U << 28)
@@ -482,7 +500,7 @@ static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
 {
     uint32_t size;
-    if (s->regs[R_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, JUMBO_FRAMES)) {
         size = s->regs[R_JUMBO_MAX_LEN];
         if (size > s->jumbo_max_len) {
             size = s->jumbo_max_len;
@@ -492,7 +510,8 @@ static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
     } else if (tx) {
         size = 1518;
     } else {
-        size = s->regs[R_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
+        size = FIELD_EX32(s->regs[R_NWCFG],
+                          NWCFG, RECV_1536_BYTE_FRAMES) ? 1538 : 1518;
     }
     return size;
 }
@@ -732,13 +751,13 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
     int i, is_mc;
 
     /* Promiscuous mode? */
-    if (s->regs[R_NWCFG] & GEM_NWCFG_PROMISC) {
+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, PROMISC)) {
         return GEM_RX_PROMISCUOUS_ACCEPT;
     }
 
     if (!memcmp(packet, broadcast_addr, 6)) {
         /* Reject broadcast packets? */
-        if (s->regs[R_NWCFG] & GEM_NWCFG_BCAST_REJ) {
+        if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, NO_BROADCAST)) {
             return GEM_RX_REJECT;
         }
         return GEM_RX_BROADCAST_ACCEPT;
@@ -746,8 +765,8 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 
     /* Accept packets -w- hash match? */
     is_mc = is_multicast_ether_addr(packet);
-    if ((is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
-        (!is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
+    if ((is_mc && (FIELD_EX32(s->regs[R_NWCFG], NWCFG, MULTICAST_HASH_EN))) ||
+        (!is_mc && FIELD_EX32(s->regs[R_NWCFG], NWCFG, UNICAST_HASH_EN))) {
         uint64_t buckets;
         unsigned hash_index;
 
@@ -983,7 +1002,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* Discard packets with receive length error enabled ? */
-    if (s->regs[R_NWCFG] & GEM_NWCFG_LERR_DISC) {
+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, LEN_ERR_DISCARD)) {
         unsigned type_len;
 
         /* Fish the ethertype / length field out of the RX packet */
@@ -1000,8 +1019,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /*
      * Determine configured receive buffer offset (probably 0)
      */
-    rxbuf_offset = (s->regs[R_NWCFG] & GEM_NWCFG_BUFF_OFST_M) >>
-                   GEM_NWCFG_BUFF_OFST_S;
+    rxbuf_offset = FIELD_EX32(s->regs[R_NWCFG], NWCFG, RECV_BUF_OFFSET);
 
     /* The configure size of each receive buffer.  Determines how many
      * buffers needed to hold this packet.
@@ -1026,7 +1044,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* Strip of FCS field ? (usually yes) */
-    if (s->regs[R_NWCFG] & GEM_NWCFG_STRIP_FCS) {
+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, FCS_REMOVE)) {
         rxbuf_ptr = (void *)buf;
     } else {
         unsigned crc_val;
-- 
2.34.1


