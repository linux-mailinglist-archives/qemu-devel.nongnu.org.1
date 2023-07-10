Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E84774DCD6
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:54:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv32-000161-1p; Mon, 10 Jul 2023 13:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2s-000115-KD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2r-0000I4-0s
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so53532165e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011489; x=1691603489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5e/SO+N+RtoeTP991orha9zplbwHg+c4RLGUXXBx0k4=;
 b=l1to8dCqQMacVHqlZnoIvGbQ57CXMQdasA54stxvsEmNLwwh3akC+e078Wl7OxrXi6
 2U7oyu7bcwuXqghuoNUsE4H0+0TpEhAXbmNlL4a2SQeuACisCQOAUPo8IpErTzEL37Tg
 uAXOsWG4bnorXqmr5Dj8/DanfwTLTJoFOyTLE+mY3H/L/8IIE4epH/CCtLGKqIvSkl99
 NzUu1WR3S84/KACbsMdOfOMMCmKb4R3Qu/NJ0cKOn+KxiLH4q8BuX1JV9THt5DSMcFPI
 wdIulnYs/D/bjxlkFf2QWrLqU8DjHJ8zXeenUP8YbN0jVBu/qsxXunYGq/Jw8XPAvwmI
 U2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011489; x=1691603489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5e/SO+N+RtoeTP991orha9zplbwHg+c4RLGUXXBx0k4=;
 b=OyhF/kVv6EJAMh7KCTZmwbziRUjC/6fXwGY+GLhTYxCwZY0N/TuIMboPermPGSXbyv
 cbamcSuJUr6Ig0Od/Dpwrrs5ZbzIrZeEl4vNbvFSBUEZR739etpak4StL9/nNdznE6Qb
 sKgsUYpadl/BaUZjQRShbIxzhfoDsDkTLhKv/t4Si2uMQP3lba64pElEGfLPKaAShpDA
 tMn/fq4d8GZAP/l0a8DJ4TpwnIZKxJgU5Gt8Nn0DMP0FGbMho0ObPe4dtsOzMwylEvCi
 OssShwLv8850k2z/2ta/zQ0my0+7sd3JiNQ/30MiqAOrUv0qrpdhZlxP5U7+trfGbqOX
 59LA==
X-Gm-Message-State: ABy/qLYiYlK8XsWie4Ks6g0FrIboyCdaMEHLXnCbyzXrFitSvry5rJuE
 SeR1+C4qmdmY+nbRqAQvkYxtxcnQTeibkuhVHp3aqw==
X-Google-Smtp-Source: APBJJlGETkW6jonw0dwOMG9CLw8/pMo4Dtvltzj593tgf7jvZGD6BUaWE0iks31FZneLuDq9t3Pb5A==
X-Received: by 2002:adf:ef0e:0:b0:314:1e47:8bc2 with SMTP id
 e14-20020adfef0e000000b003141e478bc2mr13833467wro.0.1689011489220; 
 Mon, 10 Jul 2023 10:51:29 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 q14-20020a05600000ce00b003062b2c5255sm36246wrx.40.2023.07.10.10.51.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/11] hw/char/pl011: Replace magic values by register
 field definitions
Date: Mon, 10 Jul 2023 19:50:55 +0200
Message-Id: <20230710175102.32429-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

0x400 is Data Register Break Error (DR_BE),
0x10 is Line Control Register Fifo Enabled (LCR_FEN)
and 0x1 is Send Break (LCR_BRK).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
2.38.1


