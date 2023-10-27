Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB29E7D9C1E
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0x-0001Cj-QI; Fri, 27 Oct 2023 10:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0O-0007Ok-7e
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0J-0008Eq-H1
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so17644295e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417602; x=1699022402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gBpbMgx0c2MAw8YGawXL3AambNIZsBraLqNnstbmnvw=;
 b=uuNOck1icS+M+n6KF3AEZJbCLKPsbTauHof1K+dkB6RO7cmXPvZtN1qgJjdbbnWYZf
 nAQHa42bIqPtEB3T9YyyA+3TF4k2I2wECsrwNnnTJz/DE1nN4e+ej+puw2a5ZoRhy6J8
 YkSqpNC5S1B0oZCC2bIlllrUiNU031WajvqT9Jnp/AsH62dW6mrCKDk8rR8nZN42MT66
 iF3Gbc2ansEU60Hq4Ru/2zIuL3077LjVUihWA5z87KThaXZa2YhpdB6CEg2TBkV+Cvf1
 OHTgU4WPfpxXmVbupXNiEfzrWdly/btgw6lpH2FxS68oXqOZfxigUX5s5hch7xR0X3B9
 KG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417602; x=1699022402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBpbMgx0c2MAw8YGawXL3AambNIZsBraLqNnstbmnvw=;
 b=siM7Ovbsstu/uXb003eSotf9nGzfzT6JAGlIUvFVv7xZF/XBt7w6VCPu1nrCJzPLXY
 dnW7qh91cux7HvVKvZ7QM7C76mT8+Fl58RCO0bQv3A4LQLvkHS3kCsVOKzW3JdhGyynQ
 knDFrCOb11lk0RyvMDIl+edztrWG61lBfM65exvZL6dbo/ynDKWh7Ji2UVkB+EjvPjqg
 oPUmK/P3Y51e0gp8waZ9z+JrxtIy8JMAFtIXnPHOdJ/BfxbzwJj0pcxeyU55C92+YrBf
 w1/EtxMo9wQfM4huy5v9Jo/Ckl3CiCcW9t4PcZ8gsjAR1v2IVNhbuPUbRugFFrOW+t55
 KYIA==
X-Gm-Message-State: AOJu0YweBDfFZdbJDWv33kDi5PdoX0LWTi3yXgiIbCIauszfNvRfqMro
 OUyj9JR12XBh+j/PWaex7NZFdaWw8mEy48vffAY=
X-Google-Smtp-Source: AGHT+IGeDQDIDFyGevgwB2wT4yqqJnOw/pMKBo9ARkrOgiNtJJFK4DrS+WZZQ/nZ0ISrdODQ2vF7jg==
X-Received: by 2002:a05:600c:19d1:b0:401:be5a:989 with SMTP id
 u17-20020a05600c19d100b00401be5a0989mr2212382wmq.23.1698417601798; 
 Fri, 27 Oct 2023 07:40:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/41] hw/net/cadence_gem: use FIELD to describe [TX|RX]STATUS
 register fields
Date: Fri, 27 Oct 2023 15:39:37 +0100
Message-Id: <20231027143942.3413881-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Use de FIELD macro to describe the TXSTATUS and RXSTATUS register
fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-7-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index e3724b84471..d7fdc775146 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -132,9 +132,30 @@ REG32(DMACFG, 0x10) /* DMA Control reg */
 #define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplier */
 
 REG32(TXSTATUS, 0x14) /* TX Status reg */
+    FIELD(TXSTATUS, TX_USED_BIT_READ_MIDFRAME, 12, 1)
+    FIELD(TXSTATUS, TX_FRAME_TOO_LARGE, 11, 1)
+    FIELD(TXSTATUS, TX_DMA_LOCKUP, 10, 1)
+    FIELD(TXSTATUS, TX_MAC_LOCKUP, 9, 1)
+    FIELD(TXSTATUS, RESP_NOT_OK, 8, 1)
+    FIELD(TXSTATUS, LATE_COLLISION, 7, 1)
+    FIELD(TXSTATUS, TRANSMIT_UNDER_RUN, 6, 1)
+    FIELD(TXSTATUS, TRANSMIT_COMPLETE, 5, 1)
+    FIELD(TXSTATUS, AMBA_ERROR, 4, 1)
+    FIELD(TXSTATUS, TRANSMIT_GO, 3, 1)
+    FIELD(TXSTATUS, RETRY_LIMIT, 2, 1)
+    FIELD(TXSTATUS, COLLISION, 1, 1)
+    FIELD(TXSTATUS, USED_BIT_READ, 0, 1)
+
 REG32(RXQBASE, 0x18) /* RX Q Base address reg */
 REG32(TXQBASE, 0x1c) /* TX Q Base address reg */
 REG32(RXSTATUS, 0x20) /* RX Status reg */
+    FIELD(RXSTATUS, RX_DMA_LOCKUP, 5, 1)
+    FIELD(RXSTATUS, RX_MAC_LOCKUP, 4, 1)
+    FIELD(RXSTATUS, RESP_NOT_OK, 3, 1)
+    FIELD(RXSTATUS, RECEIVE_OVERRUN, 2, 1)
+    FIELD(RXSTATUS, FRAME_RECEIVED, 1, 1)
+    FIELD(RXSTATUS, BUF_NOT_AVAILABLE, 0, 1)
+
 REG32(ISR, 0x24) /* Interrupt Status reg */
 REG32(IER, 0x28) /* Interrupt Enable reg */
 REG32(IDR, 0x2c) /* Interrupt Disable reg */
@@ -286,11 +307,6 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
 
 /*****************************************/
 
-#define GEM_TXSTATUS_TXCMPL    0x00000020 /* Transmit Complete */
-#define GEM_TXSTATUS_USED      0x00000001 /* sw owned descriptor encountered */
-
-#define GEM_RXSTATUS_FRMRCVD   0x00000002 /* Frame received */
-#define GEM_RXSTATUS_NOBUF     0x00000001 /* Buffer unavailable */
 
 /* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
 #define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
@@ -987,7 +1003,7 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
-        s->regs[R_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
+        s->regs[R_RXSTATUS] |= R_RXSTATUS_BUF_NOT_AVAILABLE_MASK;
         gem_set_isr(s, q, GEM_INT_RXUSED);
         /* Handle interrupt consequences */
         gem_update_int_status(s);
@@ -1164,7 +1180,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Count it */
     gem_receive_updatestats(s, buf, size);
 
-    s->regs[R_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
+    s->regs[R_RXSTATUS] |= R_RXSTATUS_FRAME_RECEIVED_MASK;
     gem_set_isr(s, q, GEM_INT_RXCMPL);
 
     /* Handle interrupt consequences */
@@ -1315,7 +1331,7 @@ static void gem_transmit(CadenceGEMState *s)
                 }
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
-                s->regs[R_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
+                s->regs[R_TXSTATUS] |= R_TXSTATUS_TRANSMIT_COMPLETE_MASK;
                 gem_set_isr(s, q, GEM_INT_TXCMPL);
 
                 /* Handle interrupt consequences */
@@ -1363,7 +1379,7 @@ static void gem_transmit(CadenceGEMState *s)
         }
 
         if (tx_desc_get_used(desc)) {
-            s->regs[R_TXSTATUS] |= GEM_TXSTATUS_USED;
+            s->regs[R_TXSTATUS] |= R_TXSTATUS_USED_BIT_READ_MASK;
             /* IRQ TXUSED is defined only for queue 0 */
             if (q == 0) {
                 gem_set_isr(s, 0, GEM_INT_TXUSED);
-- 
2.34.1


