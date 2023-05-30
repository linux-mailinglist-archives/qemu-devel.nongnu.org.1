Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1F27161EC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNN-0006k9-DB; Tue, 30 May 2023 09:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005hj-Ae
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMq-0001Q6-SK
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6e68cc738so31199665e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453187; x=1688045187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A1BzkyhjkfAk5+6QncofdiSD1aROdKYpR7qbv2MfVY0=;
 b=qdx/wheEHnSn7lo3Uqo8scPqoGw9bHZDQfnDZ9951+q8Gn2g4ldlItdqnt4/hNvNIi
 sag8pnlFWYL4cQdb5u0IdSw7rr7WJsXBkt92Ong9pujD2zO9VTmhYbVfw7TpRaJP+VUt
 4GStoLskVO0f9MkyCofaph1efaqNrPUcWBowOH8P3EvZAU4MzKcwERUOm+vf8Zi/Wcm0
 unKsEtu9is2E15/QiOdquTDn+5CwlW1usWEISbyUMyki+JrOcyf1efXCtLHWTMiROfAq
 tL0G3w2l1l83UF+nMlwu1nNnMDHgHU9G0r0RJhwD2ch40AJSzjkCAx64/lbpi4MfQdcy
 ObHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453187; x=1688045187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1BzkyhjkfAk5+6QncofdiSD1aROdKYpR7qbv2MfVY0=;
 b=OvUOdbcAP1jymyzXwO34TwULopqx8nC+rW8b5cCVx0BsPLyz4oaqwq/tN5U+d04w4U
 eI9J7jb2fzEmRBtN+7CB7XW/hxDcqeIws2NN+NPAmjYe6cXM+RF6MaYU8ni1813U1yBq
 Cs0B66/wxMcQS9CKsx22Y44dq2y693Vq1LD0rMOJNUsZ/oi1tPw0DDaOm7HvOgO4E1yy
 zlfAXDpdxqstopvUAThIreuC+x5VVMqffPNJb9uJISmWayPDbHdJUCwFCOXfhGHaSBqi
 c5DvlNN4mOB7QkOtjElaAZnbSRoaJ0uebKMuERrKCVWVCGXis2h4W8FdaPq/7YYWVUJT
 r9zg==
X-Gm-Message-State: AC+VfDxhJJKJZDAX8B54crTN5dqxKk8BgHn6vlQvGSvkNtCC2fDn8zhw
 Oge/qg9WYKM5iAOs5EoKsQiB3HycKMTfVjlOr38=
X-Google-Smtp-Source: ACHHUZ5+iTYHDHPEuxVEAp2snB5NwENhl0ktBT29zgyZrkNMiEoTAsXq5fOpcTG+c0JOaHeRTWQIAg==
X-Received: by 2002:a1c:6a11:0:b0:3f6:4f1:cfbf with SMTP id
 f17-20020a1c6a11000000b003f604f1cfbfmr1735002wmc.20.1685453187504; 
 Tue, 30 May 2023 06:26:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/21] hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent
 infinite loop.
Date: Tue, 30 May 2023 14:26:11 +0100
Message-Id: <20230530132620.1583658-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
---
 hw/dma/xilinx_axidma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 6030c764352..12c90267df6 100644
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
2.34.1


