Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3227DBC77
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 16:16:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTze-0002cM-Ul; Mon, 30 Oct 2023 11:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qxTzb-0002bT-VR
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:15:51 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qxTza-0002sg-AM
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:15:51 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso66469661fa.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rt-labs-com.20230601.gappssmtp.com; s=20230601; t=1698678948; x=1699283748;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRsK1HoIvBsHW04NClN2xLhUJUoshMkHuCRflJWwSIs=;
 b=u00We0yHzWTCK/bccSWx54NxZ4yx6o5CQ15E2rI9HkgsWuRd0gjOq3PURyKCHJQT4u
 EuGFOWwYxzFoPPQsaHw7Ry8W8beNQgUBC6tnpdH+7kWad0KeDBn7OXzGNySBSfqJcpnS
 nVNQtabne01FeExVO3W2yssQCu1PqflcDSm1BUcBjuEpWR+3+sL3oZs9NinLhNBF3Hj0
 rgpR5AN8yBfYC1nKkIOGZcM7n+vfMDouJ2WFwqccIL4PIv4lgv80XMCcw/czQcusOdZj
 fRsjqKVkAAAxUwYDNBYBIl9NWRzqY/XOegfH7CFQqOX4Gj0MLaFhQVLYLaUC/c/fI6wU
 ZHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698678948; x=1699283748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRsK1HoIvBsHW04NClN2xLhUJUoshMkHuCRflJWwSIs=;
 b=Kialzpu8SuwJlE0vshiip7i1Rp5pQDaxLXtR7uL9gFzb76rtkr4E4sMDIMmKcReQdv
 KFRafC3saUZaV/xgO08Q/QVJOcEhxyNoIcvDy+vDJJKNQHyPy0Noqa5l3MKUjIRH8zq0
 BTTHF3ZduJL5eCtNzkT5a65QpZKGLAN5xkPZUBD2c/hctDajkev3Nhwz02hC2vks7sei
 WwdfzvRPudJwcKtms2th2xvjQDog0vy5LE1LTfPV1yqA65w3JxPM/hCKba5FIUndtDDD
 ELpE5K5YkTkL/cWKm+5/2mx+mU3srnP3lfp75znRFF1I5z3z7VEI/f7rM8yx/WU9jkQH
 9wtA==
X-Gm-Message-State: AOJu0YytzcDPnfsySiQeu/2jK9WtuVjZNLvm1As7bEeUKPChJbI1hSRO
 fDKGfBpGVG358R9Xc3iLXIAexg==
X-Google-Smtp-Source: AGHT+IFD85AQY2li6kHv/un90GppQdVcr1HxBsd91lcZaRtNjW2jphA1FskcgByxzIw1cA7VIOplbg==
X-Received: by 2002:a2e:b0ef:0:b0:2c5:f54:2497 with SMTP id
 h15-20020a2eb0ef000000b002c50f542497mr8340714ljl.39.1698678948158; 
 Mon, 30 Oct 2023 08:15:48 -0700 (PDT)
Received: from rtlap47.intra.rt-labs.com (h-213-136-33-86.NA.cust.bahnhof.se.
 [213.136.33.86]) by smtp.gmail.com with ESMTPSA id
 j18-20020a2e3c12000000b002b95eb96ab7sm1282274lja.18.2023.10.30.08.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:15:47 -0700 (PDT)
From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
To: alistair@alistair23.me, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, philmd@linaro.org
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 1/3] hw/char/stm32f2xx_usart: Extract common IRQ update
 code to update_irq()
Date: Mon, 30 Oct 2023 16:15:16 +0100
Message-ID: <20231030151528.1138131-2-hans-erik.floryd@rt-labs.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030151528.1138131-1-hans-erik.floryd@rt-labs.com>
References: <20231030151528.1138131-1-hans-erik.floryd@rt-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=hans-erik.floryd@rt-labs.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
---
 hw/char/stm32f2xx_usart.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index fde67f4f03..519d3461a3 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -53,6 +53,17 @@ static int stm32f2xx_usart_can_receive(void *opaque)
     return 0;
 }
 
+static void stm32f2xx_update_irq(STM32F2XXUsartState *s)
+{
+    uint32_t mask = s->usart_sr & s->usart_cr1;
+
+    if (mask & (USART_SR_TXE | USART_SR_TC | USART_SR_RXNE)) {
+        qemu_set_irq(s->irq, 1);
+    } else {
+        qemu_set_irq(s->irq, 0);
+    }
+}
+
 static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
 {
     STM32F2XXUsartState *s = opaque;
@@ -66,9 +77,7 @@ static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
     s->usart_dr = *buf;
     s->usart_sr |= USART_SR_RXNE;
 
-    if (s->usart_cr1 & USART_CR1_RXNEIE) {
-        qemu_set_irq(s->irq, 1);
-    }
+    stm32f2xx_update_irq(s);
 
     DB_PRINT("Receiving: %c\n", s->usart_dr);
 }
@@ -85,7 +94,7 @@ static void stm32f2xx_usart_reset(DeviceState *dev)
     s->usart_cr3 = 0x00000000;
     s->usart_gtpr = 0x00000000;
 
-    qemu_set_irq(s->irq, 0);
+    stm32f2xx_update_irq(s);
 }
 
 static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
@@ -106,7 +115,7 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
         retvalue = s->usart_dr & 0x3FF;
         s->usart_sr &= ~USART_SR_RXNE;
         qemu_chr_fe_accept_input(&s->chr);
-        qemu_set_irq(s->irq, 0);
+        stm32f2xx_update_irq(s);
         return retvalue;
     case USART_BRR:
         return s->usart_brr;
@@ -145,9 +154,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
         } else {
             s->usart_sr &= value;
         }
-        if (!(s->usart_sr & USART_SR_RXNE)) {
-            qemu_set_irq(s->irq, 0);
-        }
+        stm32f2xx_update_irq(s);
         return;
     case USART_DR:
         if (value < 0xF000) {
@@ -168,10 +175,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
         return;
     case USART_CR1:
         s->usart_cr1 = value;
-            if (s->usart_cr1 & USART_CR1_RXNEIE &&
-                s->usart_sr & USART_SR_RXNE) {
-                qemu_set_irq(s->irq, 1);
-            }
+        stm32f2xx_update_irq(s);
         return;
     case USART_CR2:
         s->usart_cr2 = value;
-- 
2.42.0


