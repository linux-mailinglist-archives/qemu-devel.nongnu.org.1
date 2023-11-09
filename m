Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E97E7263
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AiR-0005yb-Gl; Thu, 09 Nov 2023 14:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AiC-0005Zw-HD
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:13 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AiA-0005Nk-BZ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:08 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9e213f198dfso217183666b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558145; x=1700162945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHS4Z4THTDrdonuMomFxK3JmiClhr4y8badmiGx38uU=;
 b=srhFSKYFdWB0BPPj3McGWeBEDt1J5YjW8dFWpWiphF45b8D2hC4I20hFhnQGv+hEs0
 YlF38S6XfE9Oz5A2LtyLZI19U6UiTDQI0C+NCOr1ZOOckmx5NhZtTWq+JOqIWTFDHIs4
 q5iBSYHtn0RhTuJHMHwMRdni3fJkJTKe69jys+vPAel/y5Ujv7ZFaT2jKBM8d67ORb+S
 b4gNnvvxAhdMBk2rouzly41OFeLvbZSW8KkWHwUxmmn9PKcBAZ1PbL5/dXeqV7GBP9vm
 5JC9UwsIrvVjIpfPp6WvzBMm3sXm5ld27DwxSTCavLccXIydT+57sPpqwkDqoTYlX2ah
 eqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558145; x=1700162945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHS4Z4THTDrdonuMomFxK3JmiClhr4y8badmiGx38uU=;
 b=D57OKciEPsUuZqK9I9Uqdeq5WtUur+EE/EYIRfx46Z0fbbg+xvHGf2OrjdhxVSVAbH
 CZjQp1lVfhzlsW5+j3tcyEzb+Ucn0P3CH/84cP+TxGHsOJtsiwIS2aMMqnAggZzAHg0t
 3S7JTvGVdoqqHCfU15HWgvFT0tMAKamrnfeFQdaA9IXWwCc7u2u7fy7vg+L8QiweCK1G
 JfNn3NATKW6+rFEBenYmgG7zdL8/pSQW5RMW7uA8IHFvv/60O5l11qBwEEOnUdlh/FHt
 cyAnqzNbIcaxxwQy6R9tbhQOWp0gxg9Br0gC+PFaLIDdiDFpxFiGsHX161yBCX+81tYE
 17LQ==
X-Gm-Message-State: AOJu0YzrRCwKyLQiE5pB7Wiip/J2nxCysGqcm4f3WDUL9y0G3GWSjVqC
 ZLvWdSfJ2nUFcJuE1QjYirJiRnvaWIHTOtJRutVyJg==
X-Google-Smtp-Source: AGHT+IHXkY9UsEk1pUD7sRTwEoyz3cZAuo+O1RcB0EcPzc4SAAb7hsOUbik4GhbKjbYbhKz1aDV7YQ==
X-Received: by 2002:a17:907:9304:b0:9c7:5186:de1a with SMTP id
 bu4-20020a170907930400b009c75186de1amr5108548ejc.8.1699558144629; 
 Thu, 09 Nov 2023 11:29:04 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a17090612d600b009c3828fec06sm2914829ejb.81.2023.11.09.11.29.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:29:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-8.2 v4 08/10] hw/char/pl011: Rename RX FIFO methods
Date: Thu,  9 Nov 2023 20:28:12 +0100
Message-ID: <20231109192814.95977-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In preparation of having a TX FIFO, rename the RX FIFO methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/pl011.c      | 10 +++++-----
 hw/char/trace-events |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index ca931be139..727decd428 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -369,7 +369,7 @@ static int pl011_can_receive(void *opaque)
     return r;
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value)
+static void pl011_fifo_rx_put(void *opaque, uint32_t value)
 {
     PL011State *s = (PL011State *)opaque;
     int slot;
@@ -380,9 +380,9 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
     s->read_fifo[slot] = value;
     s->read_count++;
     s->flags &= ~PL011_FLAG_RXFE;
-    trace_pl011_put_fifo(value, s->read_count);
+    trace_pl011_fifo_rx_put(value, s->read_count);
     if (s->read_count == pipe_depth) {
-        trace_pl011_put_fifo_full();
+        trace_pl011_fifo_rx_full();
         s->flags |= PL011_FLAG_RXFF;
     }
     if (s->read_count == s->read_trigger) {
@@ -393,13 +393,13 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
 
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
-    pl011_put_fifo(opaque, *buf);
+    pl011_fifo_rx_put(opaque, *buf);
 }
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
 {
     if (event == CHR_EVENT_BREAK) {
-        pl011_put_fifo(opaque, DR_BE);
+        pl011_fifo_rx_put(opaque, DR_BE);
     }
 }
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 7a398c82a5..bc9e84261f 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -58,8 +58,8 @@ pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x valu
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
 pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
-pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
-pl011_put_fifo_full(void) "FIFO now full, RXFF set"
+pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
+pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
-- 
2.41.0


