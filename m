Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6BE708FD4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 08:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pztUq-0006fj-4v; Fri, 19 May 2023 02:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1pztUn-0006fJ-NL
 for qemu-devel@nongnu.org; Fri, 19 May 2023 02:21:45 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1pztUm-0006xb-0F
 for qemu-devel@nongnu.org; Fri, 19 May 2023 02:21:45 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6abeffced6fso2136250a34.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 23:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684477300; x=1687069300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s7dJrdvRQEkn0UC/4oL0GCL3y+1fYJXpabQdYpFpR3Q=;
 b=HTcpvBfuSUyQOyf2kd3CwwTDCyOGTItkQFPbTxwSmmt82IVSvdIDtOLX2G0596IcLJ
 /yJtMsnHGfHG0aYEumtE2pjMxBhUPiHO1Lnt4nKA8Yv40kvQc5ZCAtmyG+K0b1TSDQMg
 BfcDV7io1TTk1KPxJ2xPb+jgHZE0MskU8gb9VKurTMz4GpHNwOUHvxNr6XRmdLKTJ7CM
 QW6IkVGIN8wKh5iNUpXDTJlKUAV12G19w3cHd55CFs8LHLgg35zcdyow7ORg/IyHIVdT
 FLvnfb0g47P2gPr4j3qBz6+xtOd6ZN+SkIZ/738GQTU+QBzu71hsOGuLvReXOhg6vzP1
 bJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684477300; x=1687069300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7dJrdvRQEkn0UC/4oL0GCL3y+1fYJXpabQdYpFpR3Q=;
 b=QASCckhmNC6qaEsezuoiPl1qMAxFMO46AAd3zGjswuPV/BzsioKtI6PTa6t4SGMb57
 aG/8wgYyTvmZsonKefos4loBu5uKJCR1rPaaB9tlCBDHKmc0KkTNO2s0Jh2OTx2ivk6J
 CMiRnSDd6NlVA9iiLFwNsZkVsBABtPALcgMWVpC/59jMZ1kICEyMJebYNO/9nPccKnYw
 FK+1/6c+bgonyAx6KhoS8LBVZOUzehrlD00PdH4KsrT9ud/fZYHbiuGhlNJc8Ji1LMAK
 hF4rt5tVTmBltHQrbrzT4zrwVeHDB2dEo7D1MHbpswx2GtwC6bQU4xiUvG/3SHhRgHRM
 NcuA==
X-Gm-Message-State: AC+VfDy4cs8RB1TCp6mfnz/XCJYfushd0gHgQG/rraSgztOI3vJApjll
 EuXtuD5p6fWxFva6pHZ2Rh1VGese/q1P2XZMCwkSSaKnO/v5bgsw0GFRy8IZtUTloTBA4jUstgx
 TfjdffvSJ9EqUiWopmiTtamS4isJP/RLXRE/XEQqFT5Urr75r82w6+D3WJsxZ9s7dkHe/yAcCIw
 ==
X-Google-Smtp-Source: ACHHUZ7EF3mqLiKvazs/uUgFQ+9+iN9QkRqyI0L7HbJw5d5ayD4ZANJjno7TgRdI9fS2nl/Xok2kXQ==
X-Received: by 2002:aca:1a0b:0:b0:394:5402:14cb with SMTP id
 a11-20020aca1a0b000000b00394540214cbmr571919oia.21.1684477300113; 
 Thu, 18 May 2023 23:21:40 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 4-20020aca1104000000b0038e086c764dsm1324577oir.43.2023.05.18.23.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 23:21:39 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Tommy Wu <tommy.wu@sifive.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH] hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent infinite
 loop.
Date: Thu, 18 May 2023 23:21:35 -0700
Message-Id: <20230519062137.1251741-1-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=tommy.wu@sifive.com; helo=mail-ot1-x32b.google.com
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

When we receive a packet from the xilinx_axienet and then try to s2mem
through the xilinx_axidma, if the descriptor ring buffer is full in the
xilinx axidma driver, we’ll assert the DMASR.HALTED in the
function : stream_process_s2mem and return 0. In the end, we’ll be stuck in
an infinite loop in axienet_eth_rx_notify.

This patch checks the DMASR.HALTED state when we try to push data
from xilinx axi-enet to xilinx axi-dma. When the DMASR.HALTED is asserted,
we will not keep pushing the data and then prevent the infinte loop.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 hw/dma/xilinx_axidma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

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
2.31.1


