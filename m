Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA4174DCD0
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv3U-0001JO-Bi; Mon, 10 Jul 2023 13:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv3R-0001Ip-5Q
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:52:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv3O-0000ZH-RZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:52:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-314417861b9so4857164f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011523; x=1691603523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ8DNr0ETWD1Ms+NV1FciyuZYg6CvPu0oUthK2WDbYk=;
 b=jRPo//N88Xz2LKiydkosg17oCPcLw8bBUkxqEyYDL7buG+CtATrHJ/0Vbr0KK7fESh
 Y5jZtAtBb8faX3h0hzHRjbwptN6JV3RM4wcvuB/vp5tLRlCa1dBWSDEDNiAeW0DafnjW
 cVjoJyKV3HpPk+nx5qSGVRBiYpe2tWgekqYqqOVLbk4eFR4XvB2CHu4fmRgUI7SuuSq/
 E43UpmrWHYeEmxwFRXFWKHAxt3mjqsKzoi6pNuwKiZ3lo6BYo4CgzSSBuaxtms2TlrPh
 tFTK7zP+EkXeOlJjdwJQNP5FUn4zxArGF3/zMPyrWylERgd4g4BnzVxSE9DRcxEWtGbj
 MR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011523; x=1691603523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZ8DNr0ETWD1Ms+NV1FciyuZYg6CvPu0oUthK2WDbYk=;
 b=ci1I24bM+WLC7bzcp/t/ll8QWrcJhMTwSu0+y8xa3+sk2MF36HlN+8UMr4Dlvpa2pm
 nZawIcVcAZkwfC6EqJxy8PFrc3UkW+21hg1XE8T4c9VPxCI1ckQPR3vAE2UJEiSiIRdD
 YnklIcFbr0G9bO1mhbNx0Cvhq+ASku8YB4v2P3qwZWfS0s4CdkRsFuK9VruDSQpMUlJW
 H8rrPIhEhNnLg35a/YSz+6NiNgxUR4mscwqHdXqPzFpPlw9rVbUVZyi3axfd2tfVVe2h
 GfULj6v5XNItRy67DhWT7bYsUCbkZ4JDUMqvlNYXy2Uq7hXD1q7vdN6zarpqiD9Aj5xM
 bJHA==
X-Gm-Message-State: ABy/qLbVpQldBrwpZ7Y52fgOlHX9gU7RCeWeaPTWtrGray0JbJ5bQqPm
 FF8iYFeU7YlS4mUV/KTHybdvOxJbIFrcywdcgLY/Ww==
X-Google-Smtp-Source: APBJJlG0bCbTPyIF2mpHdv8nJElaML7v6z6Rr3jZG5bLcNpBm9grpTJxEx7vqk+D6GiDwuIo9COf9w==
X-Received: by 2002:adf:ecc8:0:b0:30f:af06:7320 with SMTP id
 s8-20020adfecc8000000b0030faf067320mr12999692wro.23.1689011523373; 
 Mon, 10 Jul 2023 10:52:03 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 d6-20020adfe846000000b0030fd03e3d25sm20872wrn.75.2023.07.10.10.52.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:52:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/11] hw/char/pl011: Rename RX FIFO methods
Date: Mon, 10 Jul 2023 19:51:01 +0200
Message-Id: <20230710175102.32429-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
---
 hw/char/pl011.c      | 10 +++++-----
 hw/char/trace-events |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 59d239cb83..7c785e7bb0 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -367,7 +367,7 @@ static int pl011_can_receive(void *opaque)
     return r;
 }
 
-static void pl011_put_fifo(void *opaque, uint32_t value)
+static void pl011_fifo_rx_put(void *opaque, uint32_t value)
 {
     PL011State *s = (PL011State *)opaque;
     int slot;
@@ -378,9 +378,9 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
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
@@ -391,13 +391,13 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
 
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


