Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EEE78EE27
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhKM-0006NQ-RV; Thu, 31 Aug 2023 09:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGa-0004Ml-K5
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:24 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGY-0005uE-1J
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:20 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-76f08e302a1so50149885a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486756; x=1694091556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9fF8pIxAEbO1JVLS8qke83pavQv2lkvy3aArf23uO4=;
 b=U+ujwEYqQM3eIXUkydQYLzhXZYQ2rseIjBxygt4+yAiMOIOu1LuDSiTCt2uUMHyQL2
 5N6KEjj4pXlAqzzTMIARnwRv89aPxO6PsXqK4HSuKiPoVZ2GfgAVyj02/Uv1smN61aHZ
 QMo47O7uS0P6bLaNipi+hC+OA9gJ0DSisbb/yNzxtUPGvmzJBhwVqKBAj5weEn6nFfBP
 nLwoYvQrMf6DRnbfmVuXHsNmpXtKm28D65wzEvd8reQhaYugbaAZkry8HMg2iZvpGhP9
 PsJV+MaYoZ/6CTfs+wOI5Sfra2XMSZggrRsyr24PRQQUyxp7nfJrAlJ/KdOu9E/lJq5+
 LVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486756; x=1694091556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9fF8pIxAEbO1JVLS8qke83pavQv2lkvy3aArf23uO4=;
 b=RRAiu0KVcaA8c7SEewfZ59+zqCkTCeTYdnPZHnGCi4H0hkZXh4GyFI2aDx5kJetPfo
 KnzXO/EHf/QCbOyNGDQ+CjTDKc2redH54pwgAw9ryfwMM976BvLjat1WEtSobtwPF+kj
 GX6zcREJ2Ah2nYdN6x+gYF2XOX7659/ZhBxXXqqYcq8cjBp0P/YhY6jBrJOJ5th/R1T+
 2syT0L7guXmAmLOEIj/bA0MXG1B0UDwS3MiT40QDbRa9ddvhXM/Lj5YLOWU3+ltHmKFc
 7ozKUrg/8RHf/FpWpyZD80sV98HHTBOhreb7M8F7pqT9Mnw/EOaXRSQ8z6fvW7KvWCKx
 EQ8Q==
X-Gm-Message-State: AOJu0YxSATxbBPzD1Rl8OQg7Q430CJFOtG/IPcTCDsBT6TZ+/cQ5K+xd
 rKKAE7QIUsTucTR577/T/2iMGS+5UD8NkK0DB9Q=
X-Google-Smtp-Source: AGHT+IGwjHt9Woz6qrincB4KsE1QT88bhz5+lOlWGReU9TCMWSDsRn3K1so61hSEvDs7bfEfS/oM1w==
X-Received: by 2002:a05:620a:143a:b0:767:915a:ccf6 with SMTP id
 k26-20020a05620a143a00b00767915accf6mr2254503qkj.65.1693486756318; 
 Thu, 31 Aug 2023 05:59:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 x12-20020ae9f80c000000b00767da10efb6sm565423qkh.97.2023.08.31.05.59.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:59:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 24/41] hw/char/pl011: Replace magic values by register field
 definitions
Date: Thu, 31 Aug 2023 14:56:26 +0200
Message-ID: <20230831125646.67855-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

0x400 is Data Register Break Error (DR_BE),
0x10 is Line Control Register Fifo Enabled (LCR_FEN)
and 0x1 is Send Break (LCR_BRK).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230522153144.30610-7-philmd@linaro.org>
---
 hw/char/pl011.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 96675f52cc..58edeb9ddb 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -54,6 +54,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define PL011_FLAG_TXFF 0x20
 #define PL011_FLAG_RXFE 0x10
 
+/* Data Register, UARTDR */
+#define DR_BE   (1 << 10)
+
 /* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
 #define INT_OE (1 << 10)
 #define INT_BE (1 << 9)
@@ -69,6 +72,10 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define INT_E (INT_OE | INT_BE | INT_PE | INT_FE)
 #define INT_MS (INT_RI | INT_DSR | INT_DCD | INT_CTS)
 
+/* Line Control Register, UARTLCR_H */
+#define LCR_FEN     (1 << 4)
+#define LCR_BRK     (1 << 0)
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
@@ -116,7 +123,7 @@ static void pl011_update(PL011State *s)
 
 static bool pl011_is_fifo_enabled(PL011State *s)
 {
-    return (s->lcr & 0x10) != 0;
+    return (s->lcr & LCR_FEN) != 0;
 }
 
 static inline unsigned pl011_get_fifo_depth(PL011State *s)
@@ -218,7 +225,7 @@ static void pl011_set_read_trigger(PL011State *s)
        the threshold.  However linux only reads the FIFO in response to an
        interrupt.  Triggering the interrupt when the FIFO is non-empty seems
        to make things work.  */
-    if (s->lcr & 0x10)
+    if (s->lcr & LCR_FEN)
         s->read_trigger = (s->ifl >> 1) & 0x1c;
     else
 #endif
@@ -281,11 +288,11 @@ static void pl011_write(void *opaque, hwaddr offset,
         break;
     case 11: /* UARTLCR_H */
         /* Reset the FIFO state on FIFO enable or disable */
-        if ((s->lcr ^ value) & 0x10) {
+        if ((s->lcr ^ value) & LCR_FEN) {
             pl011_reset_fifo(s);
         }
-        if ((s->lcr ^ value) & 0x1) {
-            int break_enable = value & 0x1;
+        if ((s->lcr ^ value) & LCR_BRK) {
+            int break_enable = value & LCR_BRK;
             qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
                               &break_enable);
         }
@@ -359,8 +366,9 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
 {
-    if (event == CHR_EVENT_BREAK)
-        pl011_put_fifo(opaque, 0x400);
+    if (event == CHR_EVENT_BREAK) {
+        pl011_put_fifo(opaque, DR_BE);
+    }
 }
 
 static void pl011_clock_update(void *opaque, ClockEvent event)
-- 
2.41.0


