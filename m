Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E771A70C279
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wg-0007dg-09; Mon, 22 May 2023 11:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WE-0007Oj-8G
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WB-0001Mf-JT
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:17 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30a95ec7744so726655f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769530; x=1687361530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeXq+k+iZcDwEahQV3X8F7cWs5VQQu6bE5Hamux2tak=;
 b=TlsPvy9MfS9Tl92mIBU70ctzv29X3LgoBlOL++96iLZmUChBKbFkNb4FhlMw9Ko8XX
 VmhrgBgpOLJmx1zCjuei/gyAsgRORwDzeHJ63CTjc0lI3AGWPs8idGHISVwrl29eYYy9
 b0wzJRFQAsamkNncWQGwxF1bW92OpNs3IcIOAofaJRX6XgAM+TTZs9OZOSJKYJbYKx26
 gR6Y5TnwlYJOsaLYTPHqflzOPMRnmgS040pLIDqWt/PaOwdBB5Pk/vwgi68c2Zw58onS
 +fLGq/LmYkM2H3+SFcWpUAgUn3bRHtm/Q49xR7NjC0UEwyZ/anaVhbA1koOTnxheND04
 T6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769530; x=1687361530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DeXq+k+iZcDwEahQV3X8F7cWs5VQQu6bE5Hamux2tak=;
 b=b3tvrVa///k8AdJxfTwGVVbHLJa/B88+VqIDJuORrB8dIp7MxukmJ/8onh4kXzRzUi
 m4dsLluCjrG+UEuPoiJDmcY+4NoyL0hqmdwFQEhIssKcvu7zO/E2NH+Yq2d68PJETwkj
 6GACzuwHZ0XtsrlkncDoIA1zNF5Z9eVyfLl8/sRuAq/QYqlrFZiJ4iI6Iw3Vbr8fqraa
 IoaQTGCldkki+zgo/6gxV28AlcJYBTtB6E/dhCrafqoSqG0ka+UnWHzy79RoROrYdl8m
 JdjGsseQxWlP/p1oTFo400y3lbDHiMXdwq2vbzjVFHiF4VtR36lcTgUJ13+EY8PVxSxX
 pPVA==
X-Gm-Message-State: AC+VfDyAXuG921ttGfvRZhtfDWNnK6F37usmrrc9heoiVtCYfpKwvluY
 F95eGkXmjMmO5ZqNv1lG0MyGW+kNh5+ia5RAJXA=
X-Google-Smtp-Source: ACHHUZ4LJvxpc80HXLS2C8s3syqktw2me3xxNmUzE/3ZXCbGVJu9SvMT3pnZZTHDTyl6FrFDDsWrlQ==
X-Received: by 2002:adf:ce08:0:b0:309:4d12:64e7 with SMTP id
 p8-20020adfce08000000b003094d1264e7mr9228156wrn.31.1684769530067; 
 Mon, 22 May 2023 08:32:10 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a7bcd95000000b003f4e8530696sm8629406wmj.46.2023.05.22.08.32.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/12] hw/char/pl011: Display register name in trace events
Date: Mon, 22 May 2023 17:31:36 +0200
Message-Id: <20230522153144.30610-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

To avoid knowing the register addresses by heart,
display their name along in the trace events.

Since the MMIO region is 4K wide (0x1000 bytes),
displaying the address with 3 digits is enough,
so reduce the address format.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c      | 25 ++++++++++++++++++++++---
 hw/char/trace-events |  4 ++--
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 77bbc2a982..274e48003f 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -51,6 +51,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define PL011_INT_TX 0x20
 #define PL011_INT_RX 0x10
 
+/* Flag Register, UARTFR */
 #define PL011_FLAG_TXFE 0x80
 #define PL011_FLAG_RXFF 0x40
 #define PL011_FLAG_TXFF 0x20
@@ -76,6 +77,24 @@ static const unsigned char pl011_id_arm[8] =
 static const unsigned char pl011_id_luminary[8] =
   { 0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1 };
 
+static const char *pl011_regname(hwaddr offset)
+{
+    static const char *const rname[] = {
+        [0] = "DR", [1] = "RSR", [6] = "FR", [8] = "ILPR", [9] = "IBRD",
+        [10] = "FBRD", [11] = "LCRH", [12] = "CR", [13] = "IFLS", [14] = "IMSC",
+        [15] = "RIS", [16] = "MIS", [17] = "ICR", [18] = "DMACR",
+    };
+    unsigned idx = offset >> 2;
+
+    if (idx < ARRAY_SIZE(rname) && rname[idx]) {
+        return rname[idx];
+    }
+    if (idx >= 0x3f8 && idx <= 0x400) {
+        return "ID";
+    }
+    return "UNKN";
+}
+
 /* Which bits in the interrupt status matter for each outbound IRQ line ? */
 static const uint32_t irqmask[] = {
     INT_E | INT_MS | INT_RT | INT_TX | INT_RX, /* combined IRQ */
@@ -191,7 +210,7 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
         break;
     }
 
-    trace_pl011_read(offset, r);
+    trace_pl011_read(offset, r, pl011_regname(offset));
     return r;
 }
 
@@ -234,7 +253,7 @@ static void pl011_write(void *opaque, hwaddr offset,
     PL011State *s = (PL011State *)opaque;
     unsigned char ch;
 
-    trace_pl011_write(offset, value);
+    trace_pl011_write(offset, value, pl011_regname(offset));
 
     switch (offset >> 2) {
     case 0: /* UARTDR */
@@ -252,7 +271,7 @@ static void pl011_write(void *opaque, hwaddr offset,
     case 6: /* UARTFR */
         /* Writes to Flag register are ignored.  */
         break;
-    case 8: /* UARTUARTILPR */
+    case 8: /* UARTILPR */
         s->ilpr = value;
         break;
     case 9: /* UARTIBRD */
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 2ecb36232e..babf4d35ea 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -54,9 +54,9 @@ escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=0x%0
 
 # pl011.c
 pl011_irq_state(int level) "irq state %d"
-pl011_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
-pl011_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
 pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
 pl011_put_fifo_full(void) "FIFO now full, RXFF set"
-- 
2.38.1


