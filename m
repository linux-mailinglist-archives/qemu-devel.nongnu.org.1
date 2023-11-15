Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 951877EC701
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:17:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Hdo-0007qL-Ag; Wed, 15 Nov 2023 10:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Hdm-0007pt-Jf
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:17:18 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Hdk-0005n4-DT
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:17:18 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so53797285e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700061434; x=1700666234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0alafnMtesIHAdBuYm/oZ4SZ4FUqrIv4OM5Vdsj26zQ=;
 b=Oh4ltF86Tvwgetx/Cy2kE8/5maSFpGS15uaKe3e0xvrXal66u0dJaMblzZ3sK03dqp
 jO+zi1vic5sPlH4Z6MHvVghYTEt21wM4YDKVTq+Bls0YFnn0gf81rAWMTKvCPQLXjmNM
 vXS58gY/e9+A2Nlld54vHLtj3nZM6USALVUOUhKvMPCvLZ8Pp8M6HfHaWw9q8HO93Snz
 hykXsOx2aGD0pg1YiBUPgco9mjhbCUPpoPrinDpqaGbJ3ukMtGxpHE1PrMJwH20cOzkU
 /kI/ueC3M1WPm5HtUzqnEEd3qrKLbKxPu0XTmjg3QRmSNEFJi+lCwEtNZfEcJyBNJGDD
 u1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700061434; x=1700666234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0alafnMtesIHAdBuYm/oZ4SZ4FUqrIv4OM5Vdsj26zQ=;
 b=s8ApRFFiARphpBXW3wkjFdjmP5dQEQx/NEnGhE95ZA68uA+FO72fI0g12/FD2amlKA
 QwojTDc9NpdOCe8qMDXC/vL7UHN0nmP5RFP0hlGnWeopsMEp22rv7uz4qjHv88m1FGye
 dlBxZ+ewJNoBf62jVWnJ/UALEHCHgWbUo4i1YjCUdHs4o7oIMYvCy0oOyDPWm2ujUyKI
 auHAede1EwJznQl/euiwTzjIKp81kEgyyKCwBfsD9EQqhLD2BIZq9PKkBJXmPSUmMHy2
 UbkdwRhMuHwJ7BQYoA9MQnkTc6zy9OpwsLKckPctMYaCM7raWptCwPVq5mUCL4Xi6Ycn
 xXjQ==
X-Gm-Message-State: AOJu0YyFj2NT959Zgzzx3P4qd2TbAHwNUTbZKmRrMEN9y8bxcOG9C541
 HVrQ6pWuK9RzGpEUG2N1yBvNKAeFoysvUtmx400=
X-Google-Smtp-Source: AGHT+IHMldOQVgunT4NDeGTTTmFEpCHOtZH4pRBtYNtvMnmU2eBGVQlFG0K5+FT9jQPTR+v2+1n4gQ==
X-Received: by 2002:a05:600c:1ca7:b0:3fe:f667:4e4c with SMTP id
 k39-20020a05600c1ca700b003fef6674e4cmr10926561wms.12.1700061434428; 
 Wed, 15 Nov 2023 07:17:14 -0800 (PST)
Received: from m1x-phil.lan ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c469100b004064e3b94afsm21447860wmo.4.2023.11.15.07.17.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Nov 2023 07:17:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Anton Kochkov <anton.kochkov@proton.me>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Qiang Liu <cyruscyliu@gmail.com>
Subject: [PATCH-for-8.2] hw/net/can/xlnx-zynqmp: Avoid underflow while popping
 TX FIFO
Date: Wed, 15 Nov 2023 16:17:11 +0100
Message-ID: <20231115151711.89170-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
---
Tested with the CAN tests from 'make check-qtest-aarch64'
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


