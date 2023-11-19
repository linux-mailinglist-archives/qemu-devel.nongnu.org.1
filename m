Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE07F097C
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 23:52:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4qdJ-0004ui-EC; Sun, 19 Nov 2023 17:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4qdH-0004sx-Vv
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 17:51:16 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4qdG-0002CN-3p
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 17:51:15 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5484ef5e3d2so3162830a12.3
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 14:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700434272; x=1701039072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4OQ2JZwpVK0ANfHSLEyOk1u/diKUfR9mXGb8Hv9bX8=;
 b=QSuoeG0T1X9eWDSn/tteZrUv6rDp3+k8Vu6nsTuFDa+4tNDxdHoCyfOC/xPzU/7hEJ
 P7PB0pUv4SgjSX7My1zYNaQdGcvkPp2eRdtGDj8fJ2ryP2nKsVocP9fXc9cOOBR9zonK
 KvD3aFulhtMIw4wYke39fNMaRboyySNtJFnjqQ+jCRDDjVXFWHoU0tY/FXjzi8Wqyxlc
 f4PQIYXvKiqqlAka6Rzj62nXHYntAv4DouZ0tJPkZHfRA+P1lAOw7b7P1R1znOdHdjZM
 9hZmsn80rGJBBbUOel0K8D5vahtTUva8czs91WYbLU2gmUOY7fE/4AeThvHRNaB1humZ
 TT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700434272; x=1701039072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4OQ2JZwpVK0ANfHSLEyOk1u/diKUfR9mXGb8Hv9bX8=;
 b=ZPFUvMcfMRabI/0izazEWUItEQr9cDLyq7L4FHTDDcRfc1CMuNGOOtiEhtrK1DX6Cg
 2NGZ7h/7F1sixOxGyOAYIcDzt6SHs7ggpcc6C2MY64liaWyKuULlT+uWIlL08SSO/Z+N
 /vmzjxJ70C0eWdX0zuD2f+7aZ9S2ljMQG/meDFe8pP4yZwqop/N/oPCHeRi9nLYwHJqM
 +Mra14AR0hSVbcng14TB1s2GS1FaNw4v9tg0PVjN2A9BhUi2oS4E1NsXkoG/lP7CGjXj
 O7YNglCk3x6UL+d+VxT4ACUp3deZjQFUxIZtzcdlUQ/JsXimWjjdVXHX8oNAeYUDB4Qz
 Wnsg==
X-Gm-Message-State: AOJu0Yy2iUowAtHZrExRlDFNH8bfLm1ruz3RinG8soQAf0FyKBPVUeul
 vvSeepr4smkl50K9h28YESiCNluPSlUkxS/t2do=
X-Google-Smtp-Source: AGHT+IGkw2qVKPSiPjIY5AjfLPJzyreHedFK+rH53i21GvYeiS+47WcwY1YZjYNPnsgx6h9EKI3syg==
X-Received: by 2002:aa7:d648:0:b0:543:5364:33b4 with SMTP id
 v8-20020aa7d648000000b00543536433b4mr4292607edr.11.1700434272299; 
 Sun, 19 Nov 2023 14:51:12 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.133])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a056402044900b0054868b36118sm2058684edw.32.2023.11.19.14.51.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Nov 2023 14:51:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Kochkov <anton.kochkov@proton.me>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@amd.com>, Jason Wang <jasowang@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Qiang Liu <cyruscyliu@gmail.com>
Subject: [PATCH-for-8.2 v2 1/2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping TX FIFOs
Date: Sun, 19 Nov 2023 23:51:01 +0100
Message-ID: <20231119225102.49227-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119225102.49227-1-philmd@linaro.org>
References: <20231119225102.49227-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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
hardware does when not all four words are written. To fix the
reported underflow behavior when DATA2 register is written,
I choose to fill the data with the previous content of the
ID / DLC / DATA1 registers, which is how I expect hardware
would do.

Note there is no hardware flag raised under such condition.

Reported-by: Qiang Liu <cyruscyliu@gmail.com>
Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1425
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/net/can/xlnx-zynqmp-can.c | 49 +++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index e93e6c5e19..58938b574e 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -434,6 +434,51 @@ static bool tx_ready_check(XlnxZynqMPCANState *s)
     return true;
 }
 
+static void read_tx_frame(XlnxZynqMPCANState *s, Fifo32 *fifo, uint32_t *data)
+{
+    unsigned used = fifo32_num_used(fifo);
+    bool is_txhpb = fifo == &s->txhpb_fifo;
+
+    assert(used > 0);
+    used %= CAN_FRAME_SIZE;
+
+    /*
+     * Frame Message Format
+     *
+     * Each frame includes four words (16 bytes). Software must read and write
+     * all four words regardless of the actual number of data bytes and valid
+     * fields in the message.
+     * If software misbehave (not writting all four words), we use the previous
+     * registers content to initialize each missing word.
+     */
+    if (used > 0) {
+        /* ID, DLC, DATA1 missing */
+        data[0] = s->regs[is_txhpb ? R_TXHPB_ID : R_TXFIFO_ID];
+    } else {
+        data[0] = fifo32_pop(fifo);
+    }
+    if (used == 1 || used == 2) {
+        /* DLC, DATA1 missing */
+        data[1] = s->regs[is_txhpb ? R_TXHPB_DLC : R_TXFIFO_DLC];
+    } else {
+        data[1] = fifo32_pop(fifo);
+    }
+    if (used == 1) {
+        /* DATA1 missing */
+        data[2] = s->regs[is_txhpb ? R_TXHPB_DATA1 : R_TXFIFO_DATA1];
+    } else {
+        data[2] = fifo32_pop(fifo);
+    }
+    /* DATA2 triggered the transfer thus is always available */
+    data[3] = fifo32_pop(fifo);
+
+    if (used) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Incomplete CAN frame (only %u/%u slots used)\n",
+                      TYPE_XLNX_ZYNQMP_CAN, used, CAN_FRAME_SIZE);
+    }
+}
+
 static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
 {
     qemu_can_frame frame;
@@ -451,9 +496,7 @@ static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
     }
 
     while (!fifo32_is_empty(fifo)) {
-        for (i = 0; i < CAN_FRAME_SIZE; i++) {
-            data[i] = fifo32_pop(fifo);
-        }
+        read_tx_frame(s, fifo, data);
 
         if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, LBACK)) {
             /*
-- 
2.41.0


