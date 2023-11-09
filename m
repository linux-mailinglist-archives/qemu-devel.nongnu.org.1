Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B77F7E7265
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:34:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AiT-0006LR-4U; Thu, 09 Nov 2023 14:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AiP-0005rH-Ej
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:21 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AiM-0005Os-P0
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:20 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9dd6dc9c00cso216087366b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558157; x=1700162957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0ZgfFAgA7ypETy4OWUsXUiUb+FjTb/S73XLff6YN2Y=;
 b=v3mqpWyBsXXej/2han14VNwj7ZGHEFIRdaiWj0FRkbUWrH6SlEDfkky/bVDJZor1EV
 dlivelR41Btds7kJLU3GtWq/OLC9PWOR0Ij7tHBuk5lmN1gs1vJv0q9d8C87hVlJc6+r
 44OdAIFhDVfRiUmPcRxb1BpGnnmqpgbUMIqBQkjBYW7tiAADH2Z3M2Cq8RlFh0ri7953
 z4H92+iJSydoxA93hHvVPalTu+cP/iHgznBLl99C9CpJ18+95fO76CwHybKBLh7RIcSG
 dqTZZ0PVr82sSF5B7dG+wKOPcPUEZ3Sd8GRLMs6BQKLxU91kR106rMqgT3qFjjAL5BfH
 Ymig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558157; x=1700162957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0ZgfFAgA7ypETy4OWUsXUiUb+FjTb/S73XLff6YN2Y=;
 b=AYTMAVb8aHOWfH5FRC9KNI1jFjG8Jke5D4D11fqoxAhf0T4B4laUiZ2nEhthL2nbHy
 bfa49Eye5XWFsTs0VDiOOWpcZOhGSxKaSUt0pRE5NZ6Zm2WvQb4sxvO+SHc89GIYaEjy
 dGVBnQtO4gkECjerRnTrBhUclHKRHaXpQ3KuAL9sDzP4FgmknUUHPhMI1ilxEbFz4vDI
 f0BgSD1IquGdXTD6C6epEJTngd9TBFJDbK9UfO/rsY17I+kWik0OhK/kC3V/4fiKCCFZ
 rBkT3PG+QH7lATUfPtQNGNut3e3aEUbJkmfBbGrJXXqi4N4QKfSLESvGD1CbBluc7JhL
 FD3w==
X-Gm-Message-State: AOJu0YwhUlF0SHag5UFGu/YUtf90gE6l+YcHb+SmybXdmVkDi4xA3qBy
 jBapiV9r+KAxg4IbH4uMpZ2KAozKQOAEVr4JA8M5CQ==
X-Google-Smtp-Source: AGHT+IFrycDbYp1brEZyLTehDLKygp53lllF/hswUqBO3IWUSyid/9YWQor0+3ILzSpUZO2vnonAPQ==
X-Received: by 2002:a17:907:3e1c:b0:9b2:d554:da0e with SMTP id
 hp28-20020a1709073e1c00b009b2d554da0emr5818301ejc.69.1699558157027; 
 Thu, 09 Nov 2023 11:29:17 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170906048400b00988e953a586sm2933836eja.61.2023.11.09.11.29.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:29:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH-for-8.2 v4 10/10] hw/char/pl011: Implement TX FIFO
Date: Thu,  9 Nov 2023 20:28:14 +0100
Message-ID: <20231109192814.95977-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

If the UART back-end chardev doesn't drain data as fast as stdout
does or blocks, buffer in the TX FIFO to try again later.

This avoids having the IO-thread busy waiting on chardev back-ends,
reported recently when testing the Trusted Reference Stack and
using the socket backend:
https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=149574

Implement registering a front-end 'watch' callback on back-end
events, so we can resume transmitting when the back-end is writable
again, not blocking the main loop.

Similarly to the RX FIFO path, FIFO level selection is not
implemented (interrupt is triggered when a single byte is available
in the FIFO).

We only migrate the TX FIFO if it is in use.

Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 107 ++++++++++++++++++++++++++++++++++++++++---
 hw/char/trace-events |   4 ++
 2 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f474f56780..a14ece4f07 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -57,6 +57,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 /* Data Register, UARTDR */
 #define DR_BE   (1 << 10)
 
+/* Receive Status Register/Error Clear Register, UARTRSR/UARTECR */
+#define RSR_OE  (1 << 3)
+
 /* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
 #define INT_OE (1 << 10)
 #define INT_BE (1 << 9)
@@ -156,6 +159,68 @@ static void pl011_reset_tx_fifo(PL011State *s)
     fifo8_reset(&s->xmit_fifo);
 }
 
+static gboolean pl011_drain_tx(PL011State *s)
+{
+    trace_pl011_fifo_tx_drain(fifo8_num_used(&s->xmit_fifo));
+    pl011_reset_tx_fifo(s);
+    s->rsr &= ~RSR_OE;
+    return G_SOURCE_REMOVE;
+}
+
+static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
+{
+    PL011State *s = opaque;
+    int ret;
+    const uint8_t *buf;
+    uint32_t buflen;
+    uint32_t count;
+    bool tx_enabled;
+
+    tx_enabled = (s->cr & CR_UARTEN) && (s->cr & CR_TXE);
+    if (!tx_enabled) {
+        /*
+         * If TX is disabled, nothing to do.
+         * Keep the potentially used FIFO as is.
+         */
+        return G_SOURCE_REMOVE;
+    }
+
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        /* Instant drain the fifo when there's no back-end */
+        return pl011_drain_tx(s);
+    }
+
+    count = fifo8_num_used(&s->xmit_fifo);
+    if (count < 1) {
+        /* FIFO empty */
+        return G_SOURCE_REMOVE;
+    }
+
+    /* Transmit as much data as we can */
+    buf = fifo8_peek_buf(&s->xmit_fifo, count, &buflen);
+    ret = qemu_chr_fe_write(&s->chr, buf, buflen);
+    if (ret >= 0) {
+        /* Pop the data we could transmit */
+        trace_pl011_fifo_tx_xmit(ret);
+        fifo8_pop_buf(&s->xmit_fifo, ret, NULL);
+        s->int_level |= INT_TX;
+    }
+
+    if (!fifo8_is_empty(&s->xmit_fifo)) {
+        /* Reschedule another transmission if we couldn't transmit all */
+        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                        pl011_xmit, s);
+        if (!r) {
+            /* Error in back-end? */
+            return pl011_drain_tx(s);
+        }
+    }
+
+    pl011_update(s);
+
+    return G_SOURCE_REMOVE;
+}
+
 static void pl011_write_txdata(PL011State *s, uint8_t data)
 {
     if (!(s->cr & CR_UARTEN)) {
@@ -165,11 +230,25 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
     }
 
-    /* XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks */
-    qemu_chr_fe_write_all(&s->chr, &data, 1);
-    s->int_level |= INT_TX;
-    pl011_update(s);
+    if (fifo8_is_full(&s->xmit_fifo)) {
+        /*
+         * The FIFO contents remain valid because no more data is
+         * written when the FIFO is full, only the contents of the
+         * shift register are overwritten. The CPU must now read
+         * the data, to empty the FIFO.
+         */
+        trace_pl011_fifo_tx_overrun();
+        s->rsr |= RSR_OE;
+        return;
+    }
+
+    trace_pl011_fifo_tx_put(data);
+    fifo8_push(&s->xmit_fifo, data);
+    if (fifo8_is_full(&s->xmit_fifo)) {
+        s->flags |= PL011_FLAG_TXFF;
+    }
+
+    pl011_xmit(NULL, G_IO_OUT, s);
 }
 
 static uint32_t pl011_read_rxdata(PL011State *s)
@@ -331,10 +410,21 @@ static void pl011_write(void *opaque, hwaddr offset,
         s->lcr = value;
         pl011_set_read_trigger(s);
         break;
-    case 12: /* UARTCR */
+    case 12: /* UARTCR */ {
+        uint16_t en_bits = s->cr & (CR_UARTEN | CR_TXE | CR_RXE);
+        uint16_t dis_bits = value & (CR_UARTEN | CR_TXE | CR_RXE);
+        if (en_bits ^ dis_bits && !fifo8_is_empty(&s->xmit_fifo)) {
+            /*
+             * If the UART is disabled in the middle of transmission
+             * or reception, it completes the current character before
+             * stopping.
+             */
+            pl011_xmit(NULL, G_IO_OUT, s);
+        }
         /* ??? Need to implement the enable and loopback bits.  */
         s->cr = value;
         break;
+    }
     case 13: /* UARTIFS */
         s->ifl = value;
         pl011_set_read_trigger(s);
@@ -477,6 +567,11 @@ static int pl011_post_load(void *opaque, int version_id)
         s->read_pos = 0;
     }
 
+    if (!fifo8_is_empty(&s->xmit_fifo)) {
+        /* Reschedule another transmission */
+        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP, pl011_xmit, s);
+    }
+
     return 0;
 }
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index bc9e84261f..ee00af0c66 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -60,6 +60,10 @@ pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x val
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
 pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
+pl011_fifo_tx_put(uint8_t byte) "TX FIFO push [0x%02x]"
+pl011_fifo_tx_xmit(int count) "TX FIFO pop %d"
+pl011_fifo_tx_overrun(void) "TX FIFO overrun"
+pl011_fifo_tx_drain(unsigned drained) "TX FIFO draining %u"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.41.0


