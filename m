Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF047FA7AC
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:10:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f66-0007TA-31; Mon, 27 Nov 2023 12:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f60-0007Qq-Pz
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:33 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5y-0004cl-Uf
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:32 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50aabfa1b75so6351785e87.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104908; x=1701709708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bsA0OtH+nvL+ZJuEfjGQayseVaIvl0J9HnDPUu7e/SA=;
 b=JbaZBEVwPVwcAfyL3Wwpi8+zvf5jzbn4wWOPe3pIRoI57URoEGKfzMoM4LzvfYuIK1
 Lqq87gVDbFDt+VEj2ULdxGgMY9kwOvRkoNNHz0QTHNZA5Rxg+YFhq0exAdJiSHFpIeaW
 Lp1u+ZrxK+xnJQPoHBMXtJ2dPwMeSoS1GLNvrNh9BmyBm1Mlz41D35QMerMdio2lhGTk
 7GK8vXAqguKlGIoJrT5BmlIuI3ilH5Ilt3UNDIrB+HrXvz9jEVT34jzcjsHL7P4gnLyl
 7MusMcrRdKyTusALGr97YzOl0E0mqSN6MQag14Z55bvHb6R9VtK17+OEGK9piNosezfE
 ZZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104908; x=1701709708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsA0OtH+nvL+ZJuEfjGQayseVaIvl0J9HnDPUu7e/SA=;
 b=Kfx2yRXkMLmDgAtK/1oRmyKu/6CsbEGgePjb89r9fcfxZhjK47xOTFUjZcF9J+yBp9
 IDlhIEXkpkONWjMYDyLUAahwa5a73+DSHT8C5pcoiu9ID+1AdhQ4XSyH5FYygVdMjz91
 jIDVwWxKzTJksIfmdJlafF/6eS3lcOgEKjA6v9S2JbVy5VC5yx172LoaKIl8aektA9Bg
 kwdl1YIHsjZcBAvwC1HG+xBjk4T2CHyvMul63KX3UgdiPYlaH0qmP/b7PMT/7B7WThTM
 YtecLvXZ016DncsKEB8x91fh2Q1tQz/6kaEIT7qM4iiafxpNAgNsZdMyJVlVgrP6ic23
 NtXw==
X-Gm-Message-State: AOJu0YxRayeeKKd+C0MOdgTwjUCb0mFXreo9TA0iPCYzC/5FILoj/6H5
 lOTd/oPC72Ux++K2OpWXTxQ5Oc6P4gQt7rxDwXQ=
X-Google-Smtp-Source: AGHT+IG57jo7iLObOVs4nv/pJMk8FN4rg7HQoVcdhy1wt+3TOspm0ClkfL69vMJYj5VkcyRL8KBzhg==
X-Received: by 2002:a2e:a7d3:0:b0:2c9:a088:aa19 with SMTP id
 x19-20020a2ea7d3000000b002c9a088aa19mr3924661ljp.34.1701104907335; 
 Mon, 27 Nov 2023 09:08:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] hw/net/can/xlnx-zynqmp: Avoid underflow while popping RX
 FIFO
Date: Mon, 27 Nov 2023 17:08:14 +0000
Message-Id: <20231127170823.589863-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Per https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Message-Format

  Message Format

  The same message format is used for RXFIFO, TXFIFO, and TXHPB.
  Each message includes four words (16 bytes). Software must read
  and write all four words regardless of the actual number of data
  bytes and valid fields in the message.

There is no mention in this reference manual about what the
hardware does when not all four words are read. To fix the
reported underflow behavior, I choose to fill the 4 frame data
registers when the first register (ID) is accessed, which is how
I expect hardware would do.

Reported-by: Qiang Liu <cyruscyliu@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>
Message-id: 20231124183325.95392-3-philmd@linaro.org
Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1427
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-zynqmp-can.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index 1f1c686479c..f60e480c3ab 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -778,14 +778,18 @@ static void update_rx_fifo(XlnxZynqMPCANState *s, const qemu_can_frame *frame)
     }
 }
 
-static uint64_t can_rxfifo_pre_read(RegisterInfo *reg, uint64_t val)
+static uint64_t can_rxfifo_post_read_id(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
+    unsigned used = fifo32_num_used(&s->rx_fifo);
 
-    if (!fifo32_is_empty(&s->rx_fifo)) {
-        val = fifo32_pop(&s->rx_fifo);
-    } else {
+    if (used < CAN_FRAME_SIZE) {
         ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, RXUFLW, 1);
+    } else {
+        val = s->regs[R_RXFIFO_ID] = fifo32_pop(&s->rx_fifo);
+        s->regs[R_RXFIFO_DLC] = fifo32_pop(&s->rx_fifo);
+        s->regs[R_RXFIFO_DATA1] = fifo32_pop(&s->rx_fifo);
+        s->regs[R_RXFIFO_DATA2] = fifo32_pop(&s->rx_fifo);
     }
 
     can_update_irq(s);
@@ -946,14 +950,11 @@ static const RegisterAccessInfo can_regs_info[] = {
         .post_write = can_tx_post_write,
     },{ .name = "RXFIFO_ID",  .addr = A_RXFIFO_ID,
         .ro = 0xffffffff,
-        .post_read = can_rxfifo_pre_read,
+        .post_read = can_rxfifo_post_read_id,
     },{ .name = "RXFIFO_DLC",  .addr = A_RXFIFO_DLC,
         .rsvd = 0xfff0000,
-        .post_read = can_rxfifo_pre_read,
     },{ .name = "RXFIFO_DATA1",  .addr = A_RXFIFO_DATA1,
-        .post_read = can_rxfifo_pre_read,
     },{ .name = "RXFIFO_DATA2",  .addr = A_RXFIFO_DATA2,
-        .post_read = can_rxfifo_pre_read,
     },{ .name = "AFR",  .addr = A_AFR,
         .rsvd = 0xfffffff0,
         .post_write = can_filter_enable_post_write,
-- 
2.34.1


