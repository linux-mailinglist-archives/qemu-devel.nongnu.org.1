Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F670C283
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:35:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wu-0007l6-KI; Mon, 22 May 2023 11:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Wo-0007kN-8T
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Wk-0001WZ-HW
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3078cc99232so5978155f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769569; x=1687361569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4NEdvvVpuVzw0Qn5uC2iypDr0fWHEDLqqeZGtVwP7o=;
 b=bb/CPJDlZE3O8+Gr6hYx0FTiPCVvThuj/wbwKpHTQ6taKkcCafnD0RUUdXqgOQdTfP
 vZCL5mKUV0TGhagPeetazHKAhjwh94/TFmOWrB8v4jzILm0YXtNmfob0TPTIXiuoGWWE
 7n77wj/R4gFxkF0YA9mygsxMHho1a6ZQYDJjiKJmktaGifNR2O8yKOxE28imuCglHntg
 xmm0obzCX/wASoYmjRYiDAY2IicsVSfmsI13NXleKZ2tWDi0O2+Mq12rk7xK3Gbplm2M
 zK5ykPaLQZzpoH++aPOQ5vr4TmnuqgYpmAwQBGmy3e12PRbVB6yakD7jCmm11a3suFbr
 mWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769569; x=1687361569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4NEdvvVpuVzw0Qn5uC2iypDr0fWHEDLqqeZGtVwP7o=;
 b=dbiCkvMc+2VzJxfnPw/t9aaefKhzg6tdm2JEe/d2RxFIYcUHlVUrDZjJN8SEr853dc
 Imm1Lj5CxmxGHpC+hVeW987HbGONp5J4wq33dErJFbWaZJx1T86n284DCG2UoJiy5zy8
 89mxg0R+2Rul5EZWFWQRqYvR9tz++DCODIdJ4LAIyaJcM0NCCOYUcsubzBFamd6a/KHu
 XKzJDT/AOaX89fvsX4VLZcvYXHSe9GFEgWl/qPDuyicKfwRoHpKseU+9nl0c0DRj7Yxm
 JPa8HHBTGZJ6nAt7LN4JfsXc1CGbeRomXu6d/f18wieOmaxu77G7G+YYcecumtxxBjxx
 cz8g==
X-Gm-Message-State: AC+VfDxf6GrD8Rs7Q15Yhgizp0xIapblhMjV2/fPBc3h+XcXkWN1O1KL
 /qkfyL85uyL5PeuCivGwIEv7jEEgkiO0oCp64y4=
X-Google-Smtp-Source: ACHHUZ5kQAl8ogeBWflbUQH7VYByjmF9Lr4XrWPrssj6qCYYRRwUqy0QOvlSEPJGjxuaXYR2Jt+F6w==
X-Received: by 2002:adf:cf11:0:b0:306:36b5:8ada with SMTP id
 o17-20020adfcf11000000b0030636b58adamr7958771wrj.29.1684769568907; 
 Mon, 22 May 2023 08:32:48 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 y11-20020adff6cb000000b003063a1cdaf2sm8046868wrp.48.2023.05.22.08.32.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/12] hw/char/pl011: Rename RX FIFO methods
Date: Mon, 22 May 2023 17:31:43 +0200
Message-Id: <20230522153144.30610-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

In preparation of having a TX FIFO, rename the RX FIFO methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 10 +++++-----
 hw/char/trace-events |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 1ec102d8de..03c006199e 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -358,7 +358,7 @@ static int pl011_can_receive(void *opaque)
     return r;
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value)
+static void pl011_fifo_rx_put(void *opaque, uint32_t value)
 {
     PL011State *s = (PL011State *)opaque;
     int slot;
@@ -369,9 +369,9 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
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
@@ -382,13 +382,13 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
 
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
index babf4d35ea..9fd40e3aae 100644
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
2.38.1


