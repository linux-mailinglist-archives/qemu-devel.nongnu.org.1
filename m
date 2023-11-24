Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 220667F7EA7
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 19:34:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6azj-00024P-Gd; Fri, 24 Nov 2023 13:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6azh-000245-4B
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:33:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6azf-0003Xm-6p
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:33:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b36e31b57so15150865e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700850813; x=1701455613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SKOL+p0foMt3mWbWCnSJdA8STcRVEmjnWCmXC+Skls=;
 b=KriKj1UdxZHwtoM4dvRgA5JIX5D5NKEkcWug3S0oisz/IWNi1JNxpG8cnTbWiHAslS
 fDJFMcKjlvCMbDMlIoe98v5vEw8kbBbkMFNbZSDFEmA1ge9+VG7+7rqDSdqUXmEmGgGK
 Smml/44Kfy/L8zR4zJW+5aOG/j7CA/8LvFyfjcLg7vh3esm3zuaWHqliZlFoBJwRI3q3
 TWk7KZ0rISJQwymPrL3lP3Hc1Abbsg4KyVL79zEY9dHpz4RNhKTqNghHQI1PktnR102b
 X2cQD+2ww2Chma4yRMvM8nzpNHYcHo+6ffLczfqlmmJ2jAdcfT2+He25H80XtisiG7M/
 1JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700850813; x=1701455613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SKOL+p0foMt3mWbWCnSJdA8STcRVEmjnWCmXC+Skls=;
 b=kGVo+jShv8nIQqIJQ2hxQvCw0jaZ+aHNl0atgOkOfiNlfArrpAHHRPoNzKBmoGAGyD
 KnZ7nHBjVLXzTNAiqgBwkAOtN/6z3mDXItol713KD6cWXqSihEb14gV2axXAJIif/Llv
 3md1VEme63A/5M2K/Y1FZTKweut4nTCmVWuWED+JMoeboxGUPvLwUwriToBPLIG6Uvo6
 U1hYmVOayHXzP145wQFpWaGEkaE5MxtaqnmI8lloXfXl3SXZGjvOtloMfDr/2W8dLf3J
 7NRWqz8zPvClBlX8UeH2uu6J8cx8Gl7TW6o1nUjnewHsgDLZKz6s50/WZXMoe13t3LKa
 rcdA==
X-Gm-Message-State: AOJu0Yyz+NZxXBukJvO+ME6E3UX4V6fSwl3krQS/2MeAlMM9NwmFTvHW
 76wJDJ7gQL18aTLN+WRVx+DRAgBNPDr6uT26pqU=
X-Google-Smtp-Source: AGHT+IHr5Nrugp47/bKENYgNyHf8eZMPwssOJwJ2qV3bAOQDrOno0yBCIqpgyapEtp/rXOioQc275Q==
X-Received: by 2002:a5d:6605:0:b0:332:e31b:1f3 with SMTP id
 n5-20020a5d6605000000b00332e31b01f3mr2875131wru.31.1700850813439; 
 Fri, 24 Nov 2023 10:33:33 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 c9-20020adfef49000000b00331698cb263sm4955541wrp.103.2023.11.24.10.33.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Nov 2023 10:33:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Vikram Garhwal <vikram.garhwal@amd.com>,
 Anton Kochkov <anton.kochkov@proton.me>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Qiang Liu <cyruscyliu@gmail.com>
Subject: [PATCH-for-8.2? v3 1/2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping TX FIFOs
Date: Fri, 24 Nov 2023 19:33:24 +0100
Message-ID: <20231124183325.95392-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124183325.95392-1-philmd@linaro.org>
References: <20231124183325.95392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/can/xlnx-zynqmp-can.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index e93e6c5e19..1f1c686479 100644
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
2.41.0


