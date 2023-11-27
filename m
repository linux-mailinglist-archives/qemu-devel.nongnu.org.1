Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9667FA7A3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:10:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f61-0007Qo-Li; Mon, 27 Nov 2023 12:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5z-0007QN-9q
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:31 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5w-0004cg-UP
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:31 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50ba71356ddso3845708e87.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104907; x=1701709707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XMt53kiqR+i4rM2UsF6jb59Ec0CHoTw/+lCPhnJeyTY=;
 b=TbBkLSOz/3t2/2ZnPcudtG0fKkOkewGtPb8mnmWd9GJYp9BBX8pB16bKeTtumxSq1h
 pjM4yaPDkGxrtcqanV97ueXleIGvMEjQDOZmffLbGz8BnypCVzLj7D2r20VbmmCJZWnw
 IYdGxKwDScOW/Xo2TOEkSnANEI8lvAQlTCFAsk2D4zlBBN55e+4GGr+c3mW/NNh84Lh6
 gXZ3ZMnRHlUlltY5u2mbGR1K29Ne1Xtq/Ut0M2IaXIXIu//ix4xgKGSWpTOsV9vsx1pd
 yrJtHefsVgrYsI2cMMJz/eZvPZpp9G3E9qpMFzB/yaYMouz0rO/0swypAhQz2xqP1nf+
 WfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104907; x=1701709707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMt53kiqR+i4rM2UsF6jb59Ec0CHoTw/+lCPhnJeyTY=;
 b=jm0f+f39cddJ4oig/EplEQ2hNFdzUfFEWpl7SzjFRu1h1Cp599p+VNZPXaFsL4esNS
 NCzP04jwJt/r/NJBEYltqw6PIfqRDVoRquntNdXOQs3aBj1Rc6tArfnR+U17oQrpEu9R
 lxLVacybY2fGnalPl9/ooc9p7dY5K1Bc3FGz4mh96UtV+jJEzrqsVWIkoGgItUKEr7aS
 msOmpU97X/QAOuirfZC1jf+YDziYirH8M0+YydXuPFpZPpBqZunDSur3Uj24wKzcEBtL
 9TZk3kTqp/KDd8u1tEDSGzXUss+9wdmnGdVByo3ce7bCV+854jpZLOIh+QLSLp3VT51Y
 Zllw==
X-Gm-Message-State: AOJu0YznjhOkBDeT9K+XgxQhH1nw8jFDoYQ4gdZVQg5lFb49kpdYUcWx
 g4tXJGewn8O5hvRGRgsDLliDqRIYHsC7UI1t3+U=
X-Google-Smtp-Source: AGHT+IH8GRrC65vER9fez5cn4Sfprh1YHVeLCCbYSfHFyzb1jZZfXEMUIrjcc86FTWW3PfPLSq4qhA==
X-Received: by 2002:a19:6515:0:b0:50b:a6e6:1e8b with SMTP id
 z21-20020a196515000000b0050ba6e61e8bmr5801824lfb.65.1701104906889; 
 Mon, 27 Nov 2023 09:08:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] hw/net/can/xlnx-zynqmp: Avoid underflow while popping TX
 FIFOs
Date: Mon, 27 Nov 2023 17:08:13 +0000
Message-Id: <20231127170823.589863-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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
hardware does when not all four words are written. To fix the
reported underflow behavior when DATA2 register is written,
I choose to fill the data with the previous content of the
ID / DLC / DATA1 registers, which is how I expect hardware
would do.

Note there is no hardware flag raised under such condition.

Reported-by: Qiang Liu <cyruscyliu@gmail.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231124183325.95392-2-philmd@linaro.org
Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1425
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-zynqmp-can.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index e93e6c5e194..1f1c686479c 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -434,6 +434,52 @@ static bool tx_ready_check(XlnxZynqMPCANState *s)
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
+     * If software misbehave (not writing all four words), we use the previous
+     * registers content to initialize each missing word.
+     *
+     * If used is 1 then ID, DLC and DATA1 are missing.
+     * if used is 2 then ID and DLC are missing.
+     * if used is 3 then only ID is missing.
+     */
+     if (used > 0) {
+        data[0] = s->regs[is_txhpb ? R_TXHPB_ID : R_TXFIFO_ID];
+    } else {
+        data[0] = fifo32_pop(fifo);
+    }
+    if (used == 1 || used == 2) {
+        data[1] = s->regs[is_txhpb ? R_TXHPB_DLC : R_TXFIFO_DLC];
+    } else {
+        data[1] = fifo32_pop(fifo);
+    }
+    if (used == 1) {
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
@@ -451,9 +497,7 @@ static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
     }
 
     while (!fifo32_is_empty(fifo)) {
-        for (i = 0; i < CAN_FRAME_SIZE; i++) {
-            data[i] = fifo32_pop(fifo);
-        }
+        read_tx_frame(s, fifo, data);
 
         if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, LBACK)) {
             /*
-- 
2.34.1


