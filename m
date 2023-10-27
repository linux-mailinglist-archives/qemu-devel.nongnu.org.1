Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D162F7D9C17
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0v-0000uo-Lc; Fri, 27 Oct 2023 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0O-0007Op-VU
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:10 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0K-0008F5-H3
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:08 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so28499281fa.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417602; x=1699022402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vK0k6KfB8EoPx36PVM/3nfj6ufISuLpuOo8hIV8R6+I=;
 b=LyuZKN9zLVntBR+rXUq9bMYggzuywJ5101qKkC5nCrbNyFn/SGy5DP+7PPLacs82te
 xZk4R331Y4Ft2Y23yLM1R5Qbq6cf5bCG88VqhO39hylmuEpGKwjja1Yg+lhQEaLUIc6k
 rrx1xRMKsMUoEcF7+p3Os/oPh4MvMlJew2zW8prdJF44ADilrXiURnYfRi24+hamsaza
 0yuujz5SFxxQ4wONrwIYGUGKws8hNeuGXkNIz+ftVy5Hilf4M+P/ODDAbd56F6KLm+0/
 W95U0EGilqngf59kYTTsmgwXfI3c8h5NQHShAwy9+Sc1+OVYXIdZ2DeYP1fsCQu/AaHw
 YxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417602; x=1699022402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vK0k6KfB8EoPx36PVM/3nfj6ufISuLpuOo8hIV8R6+I=;
 b=l5730dvVOddD5VhKtYNo31xWbSO5/Bf5zEELuxyqrhBisxpwUIpn+rpls6z7/cC3RZ
 Uq8YIi7wZ1QtqCwe87HJajR8fXPfgIBYfn9DoXm47w7peC0L66er9qqvcaGOiyL6ops+
 8u0+uL9Yj4EmIb6a2IIVmbdRjRUGqEomitq8GqS6x/bRZk48/Yf5s70weEju7XM9tOFz
 6DO1gtWPRGRjGqg6ONZynynjhnMsH3whIFmiu+NpvJmKlhP+9ruTAh67pwg3MSLhPj5G
 y3E9ak7cHwyP+LYGFaYSNWTY3HBdDE3B1tkLs3ULXhvyyIAh2d3MuHqTRjk7hAFSOSQ7
 toJg==
X-Gm-Message-State: AOJu0YzPnZiOtW29BL8A3VwyU0fzVr5Ix0cudArx8a8C76KKcTYMwHj2
 qZioxrMXy/ed5UMQJ4cquNvFLL6ih6sD3zoQomk=
X-Google-Smtp-Source: AGHT+IEYvmlDgrCOPWWh3+lZos5bhVPPdag1dUBhngUEDPcxWo1J4OGinCb49g2EVPsXguouqnJe9A==
X-Received: by 2002:a2e:b748:0:b0:2c5:1ca8:d433 with SMTP id
 k8-20020a2eb748000000b002c51ca8d433mr2092370ljo.36.1698417602326; 
 Fri, 27 Oct 2023 07:40:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/41] hw/net/cadence_gem: use FIELD to describe IRQ register
 fields
Date: Fri, 27 Oct 2023 15:39:38 +0100
Message-Id: <20231027143942.3413881-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

Use de FIELD macro to describe the IRQ related register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-8-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 51 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d7fdc775146..7e6cab71071 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -157,9 +157,42 @@ REG32(RXSTATUS, 0x20) /* RX Status reg */
     FIELD(RXSTATUS, BUF_NOT_AVAILABLE, 0, 1)
 
 REG32(ISR, 0x24) /* Interrupt Status reg */
+    FIELD(ISR, TX_LOCKUP, 31, 1)
+    FIELD(ISR, RX_LOCKUP, 30, 1)
+    FIELD(ISR, TSU_TIMER, 29, 1)
+    FIELD(ISR, WOL, 28, 1)
+    FIELD(ISR, RECV_LPI, 27, 1)
+    FIELD(ISR, TSU_SEC_INCR, 26, 1)
+    FIELD(ISR, PTP_PDELAY_RESP_XMIT, 25, 1)
+    FIELD(ISR, PTP_PDELAY_REQ_XMIT, 24, 1)
+    FIELD(ISR, PTP_PDELAY_RESP_RECV, 23, 1)
+    FIELD(ISR, PTP_PDELAY_REQ_RECV, 22, 1)
+    FIELD(ISR, PTP_SYNC_XMIT, 21, 1)
+    FIELD(ISR, PTP_DELAY_REQ_XMIT, 20, 1)
+    FIELD(ISR, PTP_SYNC_RECV, 19, 1)
+    FIELD(ISR, PTP_DELAY_REQ_RECV, 18, 1)
+    FIELD(ISR, PCS_LP_PAGE_RECV, 17, 1)
+    FIELD(ISR, PCS_AN_COMPLETE, 16, 1)
+    FIELD(ISR, EXT_IRQ, 15, 1)
+    FIELD(ISR, PAUSE_FRAME_XMIT, 14, 1)
+    FIELD(ISR, PAUSE_TIME_ELAPSED, 13, 1)
+    FIELD(ISR, PAUSE_FRAME_RECV, 12, 1)
+    FIELD(ISR, RESP_NOT_OK, 11, 1)
+    FIELD(ISR, RECV_OVERRUN, 10, 1)
+    FIELD(ISR, LINK_CHANGE, 9, 1)
+    FIELD(ISR, USXGMII_INT, 8, 1)
+    FIELD(ISR, XMIT_COMPLETE, 7, 1)
+    FIELD(ISR, AMBA_ERROR, 6, 1)
+    FIELD(ISR, RETRY_EXCEEDED, 5, 1)
+    FIELD(ISR, XMIT_UNDER_RUN, 4, 1)
+    FIELD(ISR, TX_USED, 3, 1)
+    FIELD(ISR, RX_USED, 2, 1)
+    FIELD(ISR, RECV_COMPLETE, 1, 1)
+    FIELD(ISR, MGNT_FRAME_SENT, 0, 1)
 REG32(IER, 0x28) /* Interrupt Enable reg */
 REG32(IDR, 0x2c) /* Interrupt Disable reg */
 REG32(IMR, 0x30) /* Interrupt Mask reg */
+
 REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
 REG32(RXPAUSE, 0x38) /* RX Pause Time reg */
 REG32(TXPAUSE, 0x3c) /* TX Pause Time reg */
@@ -308,12 +341,6 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
 /*****************************************/
 
 
-/* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
-#define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
-#define GEM_INT_AMBA_ERR      0x00000040
-#define GEM_INT_TXUSED         0x00000008
-#define GEM_INT_RXUSED         0x00000004
-#define GEM_INT_RXCMPL        0x00000002
 
 #define GEM_PHYMNTNC_OP_R      0x20000000 /* read operation */
 #define GEM_PHYMNTNC_OP_W      0x10000000 /* write operation */
@@ -1004,7 +1031,7 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
         s->regs[R_RXSTATUS] |= R_RXSTATUS_BUF_NOT_AVAILABLE_MASK;
-        gem_set_isr(s, q, GEM_INT_RXUSED);
+        gem_set_isr(s, q, R_ISR_RX_USED_MASK);
         /* Handle interrupt consequences */
         gem_update_int_status(s);
     }
@@ -1104,7 +1131,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 
     if (size > gem_get_max_buf_len(s, false)) {
         qemu_log_mask(LOG_GUEST_ERROR, "rx frame too long\n");
-        gem_set_isr(s, q, GEM_INT_AMBA_ERR);
+        gem_set_isr(s, q, R_ISR_AMBA_ERROR_MASK);
         return -1;
     }
 
@@ -1181,7 +1208,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     gem_receive_updatestats(s, buf, size);
 
     s->regs[R_RXSTATUS] |= R_RXSTATUS_FRAME_RECEIVED_MASK;
-    gem_set_isr(s, q, GEM_INT_RXCMPL);
+    gem_set_isr(s, q, R_ISR_RECV_COMPLETE_MASK);
 
     /* Handle interrupt consequences */
     gem_update_int_status(s);
@@ -1294,7 +1321,7 @@ static void gem_transmit(CadenceGEMState *s)
                          HWADDR_PRIx " too large: size 0x%x space 0x%zx\n",
                          packet_desc_addr, tx_desc_get_length(desc),
                          gem_get_max_buf_len(s, true) - (p - s->tx_packet));
-                gem_set_isr(s, q, GEM_INT_AMBA_ERR);
+                gem_set_isr(s, q, R_ISR_AMBA_ERROR_MASK);
                 break;
             }
 
@@ -1332,7 +1359,7 @@ static void gem_transmit(CadenceGEMState *s)
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
                 s->regs[R_TXSTATUS] |= R_TXSTATUS_TRANSMIT_COMPLETE_MASK;
-                gem_set_isr(s, q, GEM_INT_TXCMPL);
+                gem_set_isr(s, q, R_ISR_XMIT_COMPLETE_MASK);
 
                 /* Handle interrupt consequences */
                 gem_update_int_status(s);
@@ -1382,7 +1409,7 @@ static void gem_transmit(CadenceGEMState *s)
             s->regs[R_TXSTATUS] |= R_TXSTATUS_USED_BIT_READ_MASK;
             /* IRQ TXUSED is defined only for queue 0 */
             if (q == 0) {
-                gem_set_isr(s, 0, GEM_INT_TXUSED);
+                gem_set_isr(s, 0, R_ISR_TX_USED_MASK);
             }
             gem_update_int_status(s);
         }
-- 
2.34.1


