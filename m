Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C227F7EAA
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 19:34:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6azr-00027S-Rt; Fri, 24 Nov 2023 13:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6azm-00026y-Gt
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:33:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6azk-0003Zl-L9
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:33:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b394f13b1so9760965e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700850819; x=1701455619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKUVprOOGD3OuG3+WfNy/MdCtQb19fWqkaa6eHfcY38=;
 b=wSYMoQAGw2pu+uJ+LXSZ7Lxb29Y3lOY5FmSg7NoIQ1uQOL0UnDiZzneltRsTa7Fgzx
 7zcdUAO9G28fzibJDgpU3MrXwAZ/0cU1vrs9zbQxFXbDqhrnn9Dr7FMV7L3KTdzngTt3
 dJI7kR5O63JxfT6KHA/9W3hmY0dz2Mj3fHxlrYL0DIs4MkKek+tJQYYhDR40cRlGZbwF
 En3sLJ/zfZ+RVjCYy45M/6RlWfK2w5PCkwQz30Rrp6SLob69QBtTpCErOyTwz5iuZEKn
 WcYZm5gfJXhW1D7OzCGBshwZ5nsvb6wGW7hqsQewZCZIXECUL7iF9aq1zZUmBp+e/afQ
 7xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700850819; x=1701455619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKUVprOOGD3OuG3+WfNy/MdCtQb19fWqkaa6eHfcY38=;
 b=N7EbCmQDGcPDy4uVj0aVtgvHDdtkQkF9vY7prt+awAUcmp6M8UMzLnQB2erh4ew+9K
 Oggf3ta3Mib74wQG4E0tY8tGZMNiRs/TgGqAKnbx5mesAI/IQ0eQjCEj4es5ETJrTXH2
 ZGCT1kv0CBHFyCMZWJpdtL230EjBlMR/+xmefhHC38OBxV3BMXcyxJbkLaXnwq+y3bIM
 KIijTIikvFQj+al+HqNImOtFMV9ivmsILE1Cz4F6h/aD8zTzUYR8CQs5jwlR8NeBD0Wj
 5IEKvAtm3+XoYp05lq7FXqwXkcG3iDBpH5CsUGZEUz2uZCOga88l4fOeKFO7/trJ7Xvf
 5ccw==
X-Gm-Message-State: AOJu0YwPCxnjATKRX/fPPBicF1EviFLopugOCFfWbGI7o77+UpDMLqQl
 TPGRrRPlUrlFkwtwEwPCB+Mg482RD/s8jPBrMRo=
X-Google-Smtp-Source: AGHT+IES1O7f4m66k9SLIVVtDu1EJzl++eAcoMC2tvfmqYXB2Us9gANVX/HJ5yqKTIyBc/uFb0Kw1Q==
X-Received: by 2002:a05:600c:524d:b0:40a:55a6:793a with SMTP id
 fc13-20020a05600c524d00b0040a55a6793amr3359109wmb.21.1700850818833; 
 Fri, 24 Nov 2023 10:33:38 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a05600c4e0500b003feae747ff2sm6548322wmq.35.2023.11.24.10.33.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Nov 2023 10:33:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Vikram Garhwal <vikram.garhwal@amd.com>,
 Anton Kochkov <anton.kochkov@proton.me>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Qiang Liu <cyruscyliu@gmail.com>
Subject: [PATCH-for-8.2? v3 2/2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping RX FIFO
Date: Fri, 24 Nov 2023 19:33:25 +0100
Message-ID: <20231124183325.95392-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124183325.95392-1-philmd@linaro.org>
References: <20231124183325.95392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1427
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 hw/net/can/xlnx-zynqmp-can.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index 1f1c686479..f60e480c3a 100644
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
2.41.0


