Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D31477D9BE9
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0v-0000um-Cj; Fri, 27 Oct 2023 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0O-0007Om-Lb
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:10 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0I-0008Bv-KE
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:06 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so32161731fa.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417600; x=1699022400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UhQdqpPsRMi/KxT1FG7O3kYanbKLB1YPwGXVOLY1nYo=;
 b=a6jWOqTmiAiaWHcJEnPjnA2sZAJyj6ANGLujgoDsx9C/MlY9MFUl73joZEKTZ5S93x
 2bRMIDTtUmA0n+goQ3Wfi6AL5vbiq0f1TR1JTzNEYUjH0yZzSoQpIkbDNOHMifKA2ky0
 OvDtP26uB8EYcoWFPYLd8fsQXmGEEo8nsYA12EA3d1LEUXSCV0D/cpQxkA6idfLO7WAe
 ++IUOebMOaXumCivnwPM0X3pd0kUcs2YEWMS6jgFnVSjSepmEF84OLOGuMcsfeK1KxGY
 chqOR5juCv5mZQGohUxoyNSiXUqAS5Z9BTnPEgbKwxKuZfsalkuN4ylL+pkw3Sfq3L3V
 uMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417600; x=1699022400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhQdqpPsRMi/KxT1FG7O3kYanbKLB1YPwGXVOLY1nYo=;
 b=kJ/jsgEO1jnbv1VK2e5o7vqvYXOSuiAlTDe34kXgj4qGA4h4v5qJwTNQo1A6PO93Gw
 4rpGzYQGBbLmf96ogfLuNEAWxMBRj7wfCVjLzMruHhUeYyrrOVZenmLPcjZwHTDgjgLa
 0W1xTs+R3W+2CUeBusNQAeUBH6AFEdRDvOvKe2+zdWbCCX1lVnu1UgLX5ZE07ERTMtKo
 VUCOtNjPrKeGeStmuIhm48kwH7Vwa6OLDRYI6avQVBC8eDb/LMZhBq6aFvPrcefOsIb2
 99Fi/h0kj2O3fAcwi6c32puKIfggJEscssaKeZy10k0Ru2de7mM6bKcryAJ6BUqOkYwI
 /3mg==
X-Gm-Message-State: AOJu0YzUdrnnP4DJxlLaBD3Jc1rXVH1Qvlqv6CK65e/jSeI9wZLyitfJ
 qAnpazD33yr3rMEu4h4PEMy3K5r8/Upo5hV32Pg=
X-Google-Smtp-Source: AGHT+IHkKDDmN7khxK8PDGNoOpJE3aLonHD4YOGw8UE3oS0cqJcqaqybMjqRwnZI/ChgETq3dhPhWw==
X-Received: by 2002:a2e:b52c:0:b0:2bc:f78a:e5e0 with SMTP id
 z12-20020a2eb52c000000b002bcf78ae5e0mr2118595ljm.43.1698417600443; 
 Fri, 27 Oct 2023 07:40:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] hw/net/cadence_gem: use FIELD to describe NWCTRL
 register fields
Date: Fri, 27 Oct 2023 15:39:34 +0100
Message-Id: <20231027143942.3413881-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

Use the FIELD macro to describe the NWCTRL register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-4-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 53 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index dd005562329..1bcc9b6811b 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -46,6 +46,38 @@
 } while (0)
 
 REG32(NWCTRL, 0x0) /* Network Control reg */
+    FIELD(NWCTRL, LOOPBACK , 0, 1)
+    FIELD(NWCTRL, LOOPBACK_LOCAL , 1, 1)
+    FIELD(NWCTRL, ENABLE_RECEIVE, 2, 1)
+    FIELD(NWCTRL, ENABLE_TRANSMIT, 3, 1)
+    FIELD(NWCTRL, MAN_PORT_EN , 4, 1)
+    FIELD(NWCTRL, CLEAR_ALL_STATS_REGS , 5, 1)
+    FIELD(NWCTRL, INC_ALL_STATS_REGS, 6, 1)
+    FIELD(NWCTRL, STATS_WRITE_EN, 7, 1)
+    FIELD(NWCTRL, BACK_PRESSURE, 8, 1)
+    FIELD(NWCTRL, TRANSMIT_START , 9, 1)
+    FIELD(NWCTRL, TRANSMIT_HALT, 10, 1)
+    FIELD(NWCTRL, TX_PAUSE_FRAME_RE, 11, 1)
+    FIELD(NWCTRL, TX_PAUSE_FRAME_ZE, 12, 1)
+    FIELD(NWCTRL, STATS_TAKE_SNAP, 13, 1)
+    FIELD(NWCTRL, STATS_READ_SNAP, 14, 1)
+    FIELD(NWCTRL, STORE_RX_TS, 15, 1)
+    FIELD(NWCTRL, PFC_ENABLE, 16, 1)
+    FIELD(NWCTRL, PFC_PRIO_BASED, 17, 1)
+    FIELD(NWCTRL, FLUSH_RX_PKT_PCLK , 18, 1)
+    FIELD(NWCTRL, TX_LPI_EN, 19, 1)
+    FIELD(NWCTRL, PTP_UNICAST_ENA, 20, 1)
+    FIELD(NWCTRL, ALT_SGMII_MODE, 21, 1)
+    FIELD(NWCTRL, STORE_UDP_OFFSET, 22, 1)
+    FIELD(NWCTRL, EXT_TSU_PORT_EN, 23, 1)
+    FIELD(NWCTRL, ONE_STEP_SYNC_MO, 24, 1)
+    FIELD(NWCTRL, PFC_CTRL , 25, 1)
+    FIELD(NWCTRL, EXT_RXQ_SEL_EN , 26, 1)
+    FIELD(NWCTRL, OSS_CORRECTION_FIELD, 27, 1)
+    FIELD(NWCTRL, SEL_MII_ON_RGMII, 28, 1)
+    FIELD(NWCTRL, TWO_PT_FIVE_GIG, 29, 1)
+    FIELD(NWCTRL, IFG_EATS_QAV_CREDIT, 30, 1)
+
 REG32(NWCFG, 0x4) /* Network Config reg */
 REG32(NWSTATUS, 0x8) /* Network Status reg */
 REG32(USERIO, 0xc) /* User IO reg */
@@ -204,11 +236,6 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
-#define GEM_NWCTRL_TXSTART     0x00000200 /* Transmit Enable */
-#define GEM_NWCTRL_TXENA       0x00000008 /* Transmit Enable */
-#define GEM_NWCTRL_RXENA       0x00000004 /* Receive Enable */
-#define GEM_NWCTRL_LOCALLOOP   0x00000002 /* Local Loopback */
-
 #define GEM_NWCFG_STRIP_FCS    0x00020000 /* Strip FCS field */
 #define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with len err */
 #define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer offset mask */
@@ -560,7 +587,7 @@ static bool gem_can_receive(NetClientState *nc)
     s = qemu_get_nic_opaque(nc);
 
     /* Do nothing if receive is not enabled. */
-    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_RXENA)) {
+    if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL, ENABLE_RECEIVE)) {
         if (s->can_rx_state != 1) {
             s->can_rx_state = 1;
             DB_PRINT("can't receive - no enable\n");
@@ -1173,7 +1200,7 @@ static void gem_transmit(CadenceGEMState *s)
     int q = 0;
 
     /* Do nothing if transmit is not enabled. */
-    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
+    if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL, ENABLE_TRANSMIT)) {
         return;
     }
 
@@ -1198,7 +1225,7 @@ static void gem_transmit(CadenceGEMState *s)
         while (tx_desc_get_used(desc) == 0) {
 
             /* Do nothing if transmit is not enabled. */
-            if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
+            if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL, ENABLE_TRANSMIT)) {
                 return;
             }
             print_gem_tx_desc(desc, q);
@@ -1271,8 +1298,8 @@ static void gem_transmit(CadenceGEMState *s)
                 gem_transmit_updatestats(s, s->tx_packet, total_bytes);
 
                 /* Send the packet somewhere */
-                if (s->phy_loop || (s->regs[R_NWCTRL] &
-                                    GEM_NWCTRL_LOCALLOOP)) {
+                if (s->phy_loop || FIELD_EX32(s->regs[R_NWCTRL], NWCTRL,
+                                              LOOPBACK_LOCAL)) {
                     qemu_receive_packet(qemu_get_queue(s->nic), s->tx_packet,
                                         total_bytes);
                 } else {
@@ -1493,15 +1520,15 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
     /* Handle register write side effects */
     switch (offset) {
     case R_NWCTRL:
-        if (val & GEM_NWCTRL_RXENA) {
+        if (FIELD_EX32(val, NWCTRL, ENABLE_RECEIVE)) {
             for (i = 0; i < s->num_priority_queues; ++i) {
                 gem_get_rx_desc(s, i);
             }
         }
-        if (val & GEM_NWCTRL_TXSTART) {
+        if (FIELD_EX32(val, NWCTRL, TRANSMIT_START)) {
             gem_transmit(s);
         }
-        if (!(val & GEM_NWCTRL_TXENA)) {
+        if (!(FIELD_EX32(val, NWCTRL, ENABLE_TRANSMIT))) {
             /* Reset to start of Q when transmit disabled. */
             for (i = 0; i < s->num_priority_queues; i++) {
                 s->tx_desc_addr[i] = gem_get_tx_queue_base_addr(s, i);
-- 
2.34.1


