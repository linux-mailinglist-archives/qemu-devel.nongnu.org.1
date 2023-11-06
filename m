Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9597E1ACC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:11:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZm-0004Zy-DA; Mon, 06 Nov 2023 01:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZX-0004Xd-41
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:55 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZU-0001QU-HC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:54 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6c398717726so1374037b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253931; x=1699858731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9J5s0G3uuCVvnlgKOKHwA3Hr3hi6PyplEMtC2W3SLSc=;
 b=X0Pfod/y4k9h0jLCYcmAwvHRPskrfW1/4XS2jsHi5q/8BzPly6ubXvD0rd4UivvP17
 GQonVULoVIM6pSvlApZUX2+hwSRd6QTVjuBxgRDKPWLmAFHTfMhMSEHzvzFH36xmGUV3
 5dPhrDHUI1T4dKxnrBsEnR/5sY3K66wb3jjDA8l7dp2BOjqebgnMnv7FH13ZH85Iz3X1
 wc8Yod52KFdGvbYT3NpLtbveDliztvtyILOX2MVdZwLT30u44iMCclnnO6SufWiDanhD
 jHocisRnjy+op07qiQOCPyl2uC0R2eFoo4ntdJLTpupLft1KENO1RARfP2bYMI5q1dXd
 pBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253931; x=1699858731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9J5s0G3uuCVvnlgKOKHwA3Hr3hi6PyplEMtC2W3SLSc=;
 b=oryfcKJ3XR1exMVfpeYYBPM6DE9s5oNMC63NZV16VpYEbUB1+creMmD/37ZpobSS9u
 C+zbIuNZFAuimWMY3LLRT8hQTK5hkOvNWB+Cc2+1Qx3VU1uXdKNuZrVVtieCMHZLfkdV
 96dIQDaLnLjjtzyLNlzDy+cj5eWloZRyxXg2N10xuPfdN25Cw7hUuDa6ZNyomHVvEAuc
 kXnWr+k6flgZsvN9feZtd/JuZFIt6i/2qI6TUVllbsPfMDrWSvaeh3skf/1TN5w4YD42
 4BvlDVxnCfved2C3MhCYWSLyS0/CpulEd9ICyPzaB8jv6HnS+HYSNxlQ8JOWTvuOpZFS
 vJgg==
X-Gm-Message-State: AOJu0YzTj1q9+lC5GhEV93ogcKX90BBNn/ukLjqmJI8a62OghVZTiUTJ
 jKPS6QYJUVNTg4tR5tt6OuQWAsYQ+pUJCS2pxtE=
X-Google-Smtp-Source: AGHT+IGvzMMD3oN6ZRt2nqP2K6UcuktRXe1n3XfWwWX8lYG4kMu4fyDj8ZE2sU+aySTRE3t5FI2Jvg==
X-Received: by 2002:a05:6a21:3e14:b0:180:d01b:ba77 with SMTP id
 bk20-20020a056a213e1400b00180d01bba77mr17562654pzc.60.1699253930945; 
 Sun, 05 Nov 2023 22:58:50 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 25/71] hw/char: Constify VMState
Date: Sun,  5 Nov 2023 22:57:41 -0800
Message-Id: <20231106065827.543129-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/bcm2835_aux.c       |  2 +-
 hw/char/cadence_uart.c      |  2 +-
 hw/char/cmsdk-apb-uart.c    |  2 +-
 hw/char/digic-uart.c        |  2 +-
 hw/char/escc.c              |  4 ++--
 hw/char/exynos4210_uart.c   |  4 ++--
 hw/char/goldfish_tty.c      |  2 +-
 hw/char/ibex_uart.c         |  2 +-
 hw/char/imx_serial.c        |  2 +-
 hw/char/ipoctal232.c        |  6 +++---
 hw/char/mchp_pfsoc_mmuart.c |  2 +-
 hw/char/nrf51_uart.c        |  2 +-
 hw/char/parallel.c          |  2 +-
 hw/char/pl011.c             |  6 +++---
 hw/char/renesas_sci.c       |  2 +-
 hw/char/sclpconsole-lm.c    |  2 +-
 hw/char/sclpconsole.c       |  2 +-
 hw/char/serial-isa.c        |  2 +-
 hw/char/serial-pci-multi.c  |  2 +-
 hw/char/serial-pci.c        |  2 +-
 hw/char/serial.c            | 20 ++++++++++----------
 hw/char/sifive_uart.c       |  2 +-
 hw/char/spapr_vty.c         |  2 +-
 hw/char/virtio-serial-bus.c |  2 +-
 24 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 96410b1ff8..83990e20f7 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -260,7 +260,7 @@ static const VMStateDescription vmstate_bcm2835_aux = {
     .name = TYPE_BCM2835_AUX,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(read_fifo, BCM2835AuxState,
                             BCM2835_AUX_RX_FIFO_LEN),
         VMSTATE_UINT8(read_pos, BCM2835AuxState),
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index a2ac062b1e..db31d7cc85 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -602,7 +602,7 @@ static const VMStateDescription vmstate_cadence_uart = {
     .minimum_version_id = 2,
     .pre_load = cadence_uart_pre_load,
     .post_load = cadence_uart_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX),
         VMSTATE_UINT8_ARRAY(rx_fifo, CadenceUARTState,
                             CADENCE_UART_RX_FIFO_SIZE),
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index d466cd93de..d07cca1bd4 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -366,7 +366,7 @@ static const VMStateDescription cmsdk_apb_uart_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = cmsdk_apb_uart_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state, CMSDKAPBUART),
         VMSTATE_UINT32(ctrl, CMSDKAPBUART),
         VMSTATE_UINT32(intstatus, CMSDKAPBUART),
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 51d4e7db52..ef2d762726 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -165,7 +165,7 @@ static const VMStateDescription vmstate_digic_uart = {
     .name = "digic-uart",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(reg_rx, DigicUartState),
         VMSTATE_UINT32(reg_st, DigicUartState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 48b30ee760..d450d70eda 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -766,7 +766,7 @@ static const VMStateDescription vmstate_escc_chn = {
     .name = "escc_chn",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(vmstate_dummy, ESCCChannelState),
         VMSTATE_UINT32(reg, ESCCChannelState),
         VMSTATE_UINT32(rxint, ESCCChannelState),
@@ -785,7 +785,7 @@ static const VMStateDescription vmstate_escc = {
     .name = "escc",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(chn, ESCCState, 2, 2, vmstate_escc_chn,
                              ESCCChannelState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 7b7c56b6ef..8cdd42e54f 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -628,7 +628,7 @@ static const VMStateDescription vmstate_exynos4210_uart_fifo = {
     .name = "exynos4210.uart.fifo",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(sp, Exynos4210UartFIFO),
         VMSTATE_UINT32(rp, Exynos4210UartFIFO),
         VMSTATE_VBUFFER_UINT32(data, Exynos4210UartFIFO, 1, NULL, size),
@@ -641,7 +641,7 @@ static const VMStateDescription vmstate_exynos4210_uart = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = exynos4210_uart_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(rx, Exynos4210UartState, 1,
                        vmstate_exynos4210_uart_fifo, Exynos4210UartFIFO),
         VMSTATE_UINT32_ARRAY(reg, Exynos4210UartState,
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index 20b77885c1..f8ff043c39 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -232,7 +232,7 @@ static const VMStateDescription vmstate_goldfish_tty = {
     .name = "goldfish_tty",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(data_len, GoldfishTTYState),
         VMSTATE_UINT64(data_ptr, GoldfishTTYState),
         VMSTATE_BOOL(int_enabled, GoldfishTTYState),
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 51708c0836..63aae6dc2c 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -488,7 +488,7 @@ static const VMStateDescription vmstate_ibex_uart = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ibex_uart_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(tx_fifo, IbexUartState,
                             IBEX_UART_TX_FIFO_SIZE),
         VMSTATE_UINT32(tx_level, IbexUartState),
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 377d1d9773..1df862eb7f 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -43,7 +43,7 @@ static const VMStateDescription vmstate_imx_serial = {
     .name = TYPE_IMX_SERIAL,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(readbuff, IMXSerialState),
         VMSTATE_UINT32(usr1, IMXSerialState),
         VMSTATE_UINT32(usr2, IMXSerialState),
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 3311e0872c..64be5226d4 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -130,7 +130,7 @@ static const VMStateDescription vmstate_scc2698_channel = {
     .name = "scc2698_channel",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(rx_enabled, SCC2698Channel),
         VMSTATE_UINT8_ARRAY(mr, SCC2698Channel, 2),
         VMSTATE_UINT8(mr_idx, SCC2698Channel),
@@ -146,7 +146,7 @@ static const VMStateDescription vmstate_scc2698_block = {
     .name = "scc2698_block",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(imr, SCC2698Block),
         VMSTATE_UINT8(isr, SCC2698Block),
         VMSTATE_END_OF_LIST()
@@ -157,7 +157,7 @@ static const VMStateDescription vmstate_ipoctal = {
     .name = "ipoctal232",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_IPACK_DEVICE(parent_obj, IPOctalState),
         VMSTATE_STRUCT_ARRAY(ch, IPOctalState, N_CHANNELS, 1,
                              vmstate_scc2698_channel, SCC2698Channel),
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
index 22f3e78eb9..e7908bbfb5 100644
--- a/hw/char/mchp_pfsoc_mmuart.c
+++ b/hw/char/mchp_pfsoc_mmuart.c
@@ -114,7 +114,7 @@ static const VMStateDescription mchp_pfsoc_mmuart_vmstate = {
     .name = "mchp.pfsoc.uart",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, MchpPfSoCMMUartState,
                              MCHP_PFSOC_MMUART_REG_COUNT),
         VMSTATE_END_OF_LIST()
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index dfe2276d71..c2cd6bb5e7 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -291,7 +291,7 @@ static int nrf51_uart_post_load(void *opaque, int version_id)
 static const VMStateDescription nrf51_uart_vmstate = {
     .name = "nrf51_soc.uart",
     .post_load = nrf51_uart_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, NRF51UARTState, 0x56C),
         VMSTATE_UINT8_ARRAY(rx_fifo, NRF51UARTState, UART_FIFO_LENGTH),
         VMSTATE_UINT32(rx_fifo_pos, NRF51UARTState),
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 147c900f0d..bd488cd7f9 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -478,7 +478,7 @@ static const VMStateDescription vmstate_parallel_isa = {
     .name = "parallel_isa",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(state.dataw, ISAParallelState),
         VMSTATE_UINT8(state.datar, ISAParallelState),
         VMSTATE_UINT8(state.status, ISAParallelState),
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 58edeb9ddb..855cb82d08 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -398,7 +398,7 @@ static const VMStateDescription vmstate_pl011_clock = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pl011_clock_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(clk, PL011State),
         VMSTATE_END_OF_LIST()
     }
@@ -433,7 +433,7 @@ static const VMStateDescription vmstate_pl011 = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = pl011_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(readbuff, PL011State),
         VMSTATE_UINT32(flags, PL011State),
         VMSTATE_UINT32(lcr, PL011State),
@@ -452,7 +452,7 @@ static const VMStateDescription vmstate_pl011 = {
         VMSTATE_INT32(read_trigger, PL011State),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_pl011_clock,
         NULL
     }
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index 1c63467290..5cb733545c 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -302,7 +302,7 @@ static const VMStateDescription vmstate_rsci = {
     .name = "renesas-sci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(trtime, RSCIState),
         VMSTATE_INT64(rx_next, RSCIState),
         VMSTATE_UINT8(smr, RSCIState),
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index b9e9b2d453..7719f438f6 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -292,7 +292,7 @@ static const VMStateDescription vmstate_sclplmconsole = {
     .name = "sclplmconsole",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(event.event_pending, SCLPConsoleLM),
         VMSTATE_UINT32(write_errors, SCLPConsoleLM),
         VMSTATE_UINT32(length, SCLPConsoleLM),
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index c36b572222..5d630b04bb 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -206,7 +206,7 @@ static const VMStateDescription vmstate_sclpconsole = {
     .name = "sclpconsole",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(event.event_pending, SCLPConsole),
         VMSTATE_UINT8_ARRAY(iov, SCLPConsole, SIZE_BUFFER_VT220),
         VMSTATE_UINT32(iov_sclp, SCLPConsole),
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 141a6cb168..1c793b20f7 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -106,7 +106,7 @@ static const VMStateDescription vmstate_isa_serial = {
     .name = "serial",
     .version_id = 3,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(state, ISASerialState, 0, vmstate_serial, SerialState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 5d65c534cb..28b275709a 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -123,7 +123,7 @@ static const VMStateDescription vmstate_pci_multi_serial = {
     .name = "pci-serial-multi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIMultiSerialState),
         VMSTATE_STRUCT_ARRAY(state, PCIMultiSerialState, PCI_SERIAL_MAX_PORTS,
                              0, vmstate_serial, SerialState),
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 087da3059a..f8a1a94d0c 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -74,7 +74,7 @@ static const VMStateDescription vmstate_pci_serial = {
     .name = "pci-serial",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCISerialState),
         VMSTATE_STRUCT(state, PCISerialState, 0, vmstate_serial, SerialState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/char/serial.c b/hw/char/serial.c
index a32eb25f58..d8b2db5082 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -707,7 +707,7 @@ static const VMStateDescription vmstate_serial_thr_ipending = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = serial_thr_ipending_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(thr_ipending, SerialState),
         VMSTATE_END_OF_LIST()
     }
@@ -724,7 +724,7 @@ static const VMStateDescription vmstate_serial_tsr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = serial_tsr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tsr_retry, SerialState),
         VMSTATE_UINT8(thr, SerialState),
         VMSTATE_UINT8(tsr, SerialState),
@@ -744,7 +744,7 @@ static const VMStateDescription vmstate_serial_recv_fifo = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = serial_recv_fifo_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(recv_fifo, SerialState, 1, vmstate_fifo8, Fifo8),
         VMSTATE_END_OF_LIST()
     }
@@ -761,7 +761,7 @@ static const VMStateDescription vmstate_serial_xmit_fifo = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = serial_xmit_fifo_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(xmit_fifo, SerialState, 1, vmstate_fifo8, Fifo8),
         VMSTATE_END_OF_LIST()
     }
@@ -778,7 +778,7 @@ static const VMStateDescription vmstate_serial_fifo_timeout_timer = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = serial_fifo_timeout_timer_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(fifo_timeout_timer, SerialState),
         VMSTATE_END_OF_LIST()
     }
@@ -795,7 +795,7 @@ static const VMStateDescription vmstate_serial_timeout_ipending = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = serial_timeout_ipending_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(timeout_ipending, SerialState),
         VMSTATE_END_OF_LIST()
     }
@@ -812,7 +812,7 @@ static const VMStateDescription vmstate_serial_poll = {
     .version_id = 1,
     .needed = serial_poll_needed,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(poll_msl, SerialState),
         VMSTATE_TIMER_PTR(modem_status_poll, SerialState),
         VMSTATE_END_OF_LIST()
@@ -826,7 +826,7 @@ const VMStateDescription vmstate_serial = {
     .pre_save = serial_pre_save,
     .pre_load = serial_pre_load,
     .post_load = serial_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16_V(divider, SerialState, 2),
         VMSTATE_UINT8(rbr, SerialState),
         VMSTATE_UINT8(ier, SerialState),
@@ -839,7 +839,7 @@ const VMStateDescription vmstate_serial = {
         VMSTATE_UINT8_V(fcr_vmstate, SerialState, 3),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_serial_thr_ipending,
         &vmstate_serial_tsr,
         &vmstate_serial_recv_fifo,
@@ -1056,7 +1056,7 @@ static const VMStateDescription vmstate_serial_mm = {
     .name = "serial",
     .version_id = 3,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(serial, SerialMM, 0, vmstate_serial, SerialState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index f2684e57bc..e8716c4252 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -224,7 +224,7 @@ static const VMStateDescription vmstate_sifive_uart = {
     .name = TYPE_SIFIVE_UART,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
                             SIFIVE_UART_RX_FIFO_SIZE),
         VMSTATE_UINT8(rx_fifo_len, SiFiveUARTState),
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 91eae1a598..3e23d9cbab 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -173,7 +173,7 @@ static const VMStateDescription vmstate_spapr_vty = {
     .name = "spapr_vty",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SPAPR_VIO(sdev, SpaprVioVty),
 
         VMSTATE_UINT32(in, SpaprVioVty),
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index dd619f0731..016aba6374 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1148,7 +1148,7 @@ static const VMStateDescription vmstate_virtio_console = {
     .name = "virtio-console",
     .minimum_version_id = 3,
     .version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


