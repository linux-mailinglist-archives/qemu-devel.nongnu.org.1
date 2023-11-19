Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AE7F097A
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 23:52:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4qdQ-0004vf-On; Sun, 19 Nov 2023 17:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4qdO-0004vJ-B3
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 17:51:22 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4qdM-0002D1-KV
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 17:51:22 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-991c786369cso519170366b.1
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700434279; x=1701039079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+TRmFh4XF/6EizUthtIP3l2xJd8V/WH+CN52HJC1Pc=;
 b=O1XTQe4AzyRJPngyScEGoTUfBoIm/m+5dgawTavcTbATLw1zdTBUViYQV7cjSykvZX
 SGMs7/fMvqTPlZuDIGLiH4lS7d4YgGV1+lBbpLPKT2zf4l5g7lwpkfVdS9n96lL0Vp3v
 T+yfgQ00HcONVRcXYo5A2OihxZgQU52p/1MgcBwDtVyJHl4xI2oxDcladez8NRjPfTG8
 r6BA/epBOlc0NjuoXK1dyxBjqtmWqAHqjJSPTDKwMfL6cvZ3o3Q6Booo1bl5aztV0qBc
 JVmFPsKZVhPq0eXxDU8u3oD7XEUisrAyB6lrqnRG8UbSEgPAfIdRpLwaHoeYsSdxBCRL
 GmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700434279; x=1701039079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+TRmFh4XF/6EizUthtIP3l2xJd8V/WH+CN52HJC1Pc=;
 b=ACqLnxF2YufgaSBCZDo1rEm9UFh1BTKCh94MVTCwddiqa4AyMcpNjUuRBfVwEDVxv0
 eVTrI618tsux/jvMFpaMmufP748csDaDLLgJE9Hg9+1ist+Cwl2DFVivYl8dftD4DqFe
 orDUnTJmJoISJCtwbXQbeZS7k7IDoCOc3ProRnBEQX9pKV2vZpyGMMpCc8Wr7InJ8Yc+
 sQhfL0yW2QnSOayK8DEENYjwV7G2WGuIpDszYcd4fdhL8SjgguADy2NALFAqqUp/t/cD
 a35/3duLc7B9EUg/0BuGX3ITgVbX8RBRRan5wW/AFGOELx5w71dttY0w8alP42CuvFze
 fOzA==
X-Gm-Message-State: AOJu0YwKfaROFhxX/zmXFL7yxdMf0jryaVsH5MRlgCiJaVSydbdu62RZ
 5hVjL/a213jEN+oVSKLtLuepF8KUaOxZcIOd6RE=
X-Google-Smtp-Source: AGHT+IGCPzfuH/3uFAixlyzgnH1RIdWiHEF/2AA3xaEYCv2ZgltPrqPRoNhKK9f6PCgU49rijitZAQ==
X-Received: by 2002:a17:906:2da:b0:9ff:1e84:76fc with SMTP id
 26-20020a17090602da00b009ff1e8476fcmr212961ejk.5.1700434279173; 
 Sun, 19 Nov 2023 14:51:19 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.133])
 by smtp.gmail.com with ESMTPSA id
 jz2-20020a170906bb0200b009ddf38056f8sm3272534ejb.118.2023.11.19.14.51.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Nov 2023 14:51:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Kochkov <anton.kochkov@proton.me>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@amd.com>, Jason Wang <jasowang@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Qiang Liu <cyruscyliu@gmail.com>
Subject: [PATCH-for-8.2 v2 2/2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping RX FIFO
Date: Sun, 19 Nov 2023 23:51:02 +0100
Message-ID: <20231119225102.49227-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119225102.49227-1-philmd@linaro.org>
References: <20231119225102.49227-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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
---
 hw/net/can/xlnx-zynqmp-can.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index 58938b574e..c63fb4a83c 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -777,14 +777,18 @@ static void update_rx_fifo(XlnxZynqMPCANState *s, const qemu_can_frame *frame)
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
@@ -945,14 +949,11 @@ static const RegisterAccessInfo can_regs_info[] = {
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


