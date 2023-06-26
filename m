Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B873EA87
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrJ4-0004W4-Dn; Mon, 26 Jun 2023 14:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJ0-0004Sw-GQ; Mon, 26 Jun 2023 14:51:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIy-0004vP-RP; Mon, 26 Jun 2023 14:51:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B5A0EF21;
 Mon, 26 Jun 2023 21:50:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 96EC2F7B3;
 Mon, 26 Jun 2023 21:50:18 +0300 (MSK)
Received: (nullmailer pid 1573997 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Tommy Wu <tommy.wu@sifive.com>, "Edgar E . Iglesias" <edgar@zeroasic.com>,
 Frank Chang <frank.chang@sifive.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 13/54] hw/dma/xilinx_axidma: Check DMASR.HALTED to
 prevent infinite loop.
Date: Mon, 26 Jun 2023 21:49:20 +0300
Message-Id: <20230626185002.1573836-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Tommy Wu <tommy.wu@sifive.com>

When we receive a packet from the xilinx_axienet and then try to s2mem
through the xilinx_axidma, if the descriptor ring buffer is full in the
xilinx axidma driver, we’ll assert the DMASR.HALTED in the
function : stream_process_s2mem and return 0. In the end, we’ll be stuck in
an infinite loop in axienet_eth_rx_notify.

This patch checks the DMASR.HALTED state when we try to push data
from xilinx axi-enet to xilinx axi-dma. When the DMASR.HALTED is asserted,
we will not keep pushing the data and then prevent the infinte loop.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Message-id: 20230519062137.1251741-1-tommy.wu@sifive.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 31afe04586efeccb80cc36ffafcd0e32a3245ffb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 6030c76435..12c90267df 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -168,6 +168,11 @@ static inline int stream_idle(struct Stream *s)
     return !!(s->regs[R_DMASR] & DMASR_IDLE);
 }
 
+static inline int stream_halted(struct Stream *s)
+{
+    return !!(s->regs[R_DMASR] & DMASR_HALTED);
+}
+
 static void stream_reset(struct Stream *s)
 {
     s->regs[R_DMASR] = DMASR_HALTED;  /* starts up halted.  */
@@ -269,7 +274,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
     uint64_t addr;
     bool eop;
 
-    if (!stream_running(s) || stream_idle(s)) {
+    if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
         return;
     }
 
@@ -326,7 +331,7 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
     unsigned int rxlen;
     size_t pos = 0;
 
-    if (!stream_running(s) || stream_idle(s)) {
+    if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
         return 0;
     }
 
@@ -407,7 +412,7 @@ xilinx_axidma_data_stream_can_push(StreamSink *obj,
     XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
     struct Stream *s = &ds->dma->streams[1];
 
-    if (!stream_running(s) || stream_idle(s)) {
+    if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
         ds->dma->notify = notify;
         ds->dma->notify_opaque = notify_opaque;
         return false;
-- 
2.39.2


