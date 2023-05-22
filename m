Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B57170C286
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:36:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17We-0007bz-TJ; Mon, 22 May 2023 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WS-0007Sp-4U
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WJ-0001QG-Rp
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f475366514so42744295e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769541; x=1687361541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcPyr1Hd/Zw7pAX4B7gZfLX+zfoHJG12lzmzj0tU/xY=;
 b=hrPWDhgPUFiBuAMhA5CDRbl9BVs8bETJD7pwCAZ5uhag+rdaBUug4RgowQqjaEhxuM
 +fSrM+tvfbW9e5Cr3eJIY9N0rjM0VQpSrg6QkPETPvt5EWGG5+jGeeLghnx4DzymM+Nu
 lR/BBDrel+DVWDmU2r/3TLcPzBDppUkfo/pccf/BWPWf+lxGSaDP2hBKILuouM9OuJLc
 arCCSLhFVSFQMASuCGNHxBnTBBj4ccKzOM2rCsCFMN3Pmpi5CbZh2ypz5pDkPkUlb5sb
 YLLcYqiwj28v1nUE8NpWeohdHCcnv8yOGJsNuvGG+y4Dke4tQBnRJYZF2ShR+WQBmIfr
 yN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769541; x=1687361541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcPyr1Hd/Zw7pAX4B7gZfLX+zfoHJG12lzmzj0tU/xY=;
 b=PgiEgunFpSVbtpxOiom0IiMx9t1hyg9fTmz17as1jrYkaMWGR0BUWC7BRQRMjf0nj4
 ifYziSv0pY7XSyC9oiVguQtPED9sIMKkd2ExUkf9QCPOoD1hrRrxbmiUkoEcEMar46b8
 3mz8U8Xq9M0zWCt3XKjFbY9+Y6jAigQIFf83nmdlUTKWmCIO71Sk+2sr1+vrMEWJZSKL
 ERK9HNg4UOiWxNDoCSC+bBMf8BnAIOLEMA6VeRx7r0mH8eKfCOM+AnKQV8KvM/dFp1tp
 mlWoQrnDVTSbOLH4chWKMFHyzG8JW3WK2c9F47hc0xk7LUj3TGOEZsf6nN4U4Hx5oSCx
 BxZw==
X-Gm-Message-State: AC+VfDyWhhTSDY5UGgmo5coKeQI/RCOJcb/tQfjM3cbyqaLkoQB685cz
 uc5EnhGlWXldXHXQQ0WJaO2xb235NxtW+KPFHCo=
X-Google-Smtp-Source: ACHHUZ41Lu1ostv+MOkaW5Ot1RWFYYpgCpfgOpbGq8Jr5VShUHgNitA0+MeQTErk6rAJ1JkJCxk0EQ==
X-Received: by 2002:a05:600c:220a:b0:3f0:b1c9:25d4 with SMTP id
 z10-20020a05600c220a00b003f0b1c925d4mr7732831wml.21.1684769541121; 
 Mon, 22 May 2023 08:32:21 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a7bcd14000000b003f17848673fsm8688467wmj.27.2023.05.22.08.32.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/12] hw/char/pl011: Replace magic values by register field
 definitions
Date: Mon, 22 May 2023 17:31:38 +0200
Message-Id: <20230522153144.30610-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

0x400 is Data Register Break Error (DR_BE),
0x10 is Line Control Register Fifo Enabled (LCR_FEN)
and 0x1 is Send Break (LCR_BRK).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 93e19b2c40..98c5268388 100644
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
2.38.1


