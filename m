Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C40F7D0E41
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:15:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnSo-0003FW-Fm; Fri, 20 Oct 2023 07:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qtnSk-0003FE-Ei
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:14:42 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qtnSf-0003Es-0y
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:14:42 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507b96095abso946394e87.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 04:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rt-labs-com.20230601.gappssmtp.com; s=20230601; t=1697800474; x=1698405274;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CBHR/jGxzCHvB6qAfZMLA6Uyr80r4hbJHX7wpcD2jQc=;
 b=blo9QuyIndGiSGuZuTZ0XT1zhtzO1cuy4ZRKqXTrCMSqafArTDQAKvHzmMC4DMAC3s
 aqdNN77Yiwn+GCRWkbC7SJ61LS+Yzp++QwEAQxMJjZcBg7wEpK2SrOodvOl6f1zjuRDT
 DpM2A2ND8MHL4qf4UeMhWdBcng7DzZuEOt270+B+UXvsP9Psb5oFAjpMXKJ45BaedwzQ
 dCxYRfyPzy0VxwlvDmxGqtcOHkCeKcxF13UYtMntzHX54igwYGwpjQa+o4Qbs8MZGAc4
 tpt6BQYIfb9IY3ZYCGJG/H0pi2/bG0E3nqHld/N7wNyFPYNCJ+0x2MEhDs7GFQTkCq/R
 5mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697800474; x=1698405274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CBHR/jGxzCHvB6qAfZMLA6Uyr80r4hbJHX7wpcD2jQc=;
 b=G/9TJRFgGWp8CSXHOPytpB/wNpR/0QEZglpzBHSfgh5K6hJ5ZB5+jdSeojgHXVAl1Z
 /LgPR7Ap1JS0mhhIlTYtnc05Kx6OHVfoxY2GkHyYvaOO6KiwKyKVc0E8JjqopSflcIyd
 rCz9wtTtwmgIKMyYYXXJcz/wS8m6rUzvqZ/MtruJeuqvwrN01/8JvTpRoLTkg86Bd48/
 qiesrfzCJ0FGIjGNTdDSQH7FIchLfCKw0X91VfK/e/xj20k22cBFdqhlXR/rDXlPvPU/
 hY1x7H/FaNqc4cki5SOWhRPR84Xv8sd/rVeto155FntChq0nUquCwyymE+cMVMDQHnRt
 WOHw==
X-Gm-Message-State: AOJu0Yzlmr0bR3n0O98aJgEYd7bZvoqAWVQQcohbhUM3tOZRHJD+rMDx
 0XP3JjCH5ZJK2kwzPNjgX8bszw==
X-Google-Smtp-Source: AGHT+IEG2aK7bR0avIufyjga4Oy4yVGj+WiDG634oPXj++X9ra7+So/tv1VIPDNRpyEb5VeE3VpGnA==
X-Received: by 2002:ac2:4848:0:b0:503:c51:74e1 with SMTP id
 8-20020ac24848000000b005030c5174e1mr993850lfy.15.1697800474358; 
 Fri, 20 Oct 2023 04:14:34 -0700 (PDT)
Received: from rtlap47.intra.rt-labs.com (h-213-136-33-86.NA.cust.bahnhof.se.
 [213.136.33.86]) by smtp.gmail.com with ESMTPSA id
 s16-20020a056512203000b00500d1a72734sm309711lfs.130.2023.10.20.04.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 04:14:33 -0700 (PDT)
From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
To: 
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:STM32F205),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 1/1] stm32f2xx_usart: implement TX interrupts
Date: Fri, 20 Oct 2023 13:14:26 +0200
Message-ID: <20231020111428.3260965-1-hans-erik.floryd@rt-labs.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=hans-erik.floryd@rt-labs.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Generate interrupt if either of the TXE, TC or RXNE bits are active
and the corresponding interrupt enable bit is set.

Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
---
 hw/char/stm32f2xx_usart.c         | 29 +++++++++++++++++------------
 include/hw/char/stm32f2xx_usart.h | 10 ++++++----
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index fde67f4f03..2947c3a260 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -53,6 +53,16 @@ static int stm32f2xx_usart_can_receive(void *opaque)
     return 0;
 }
 
+static void stm32f2xx_update(STM32F2XXUsartState *s)
+{
+    uint32_t mask = s->usart_sr & s->usart_cr1;
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
@@ -66,9 +76,7 @@ static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
     s->usart_dr = *buf;
     s->usart_sr |= USART_SR_RXNE;
 
-    if (s->usart_cr1 & USART_CR1_RXNEIE) {
-        qemu_set_irq(s->irq, 1);
-    }
+    stm32f2xx_update(s);
 
     DB_PRINT("Receiving: %c\n", s->usart_dr);
 }
@@ -85,7 +93,7 @@ static void stm32f2xx_usart_reset(DeviceState *dev)
     s->usart_cr3 = 0x00000000;
     s->usart_gtpr = 0x00000000;
 
-    qemu_set_irq(s->irq, 0);
+    stm32f2xx_update(s);
 }
 
 static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
@@ -100,13 +108,14 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
     case USART_SR:
         retvalue = s->usart_sr;
         qemu_chr_fe_accept_input(&s->chr);
+        stm32f2xx_update(s);
         return retvalue;
     case USART_DR:
         DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
         retvalue = s->usart_dr & 0x3FF;
         s->usart_sr &= ~USART_SR_RXNE;
         qemu_chr_fe_accept_input(&s->chr);
-        qemu_set_irq(s->irq, 0);
+        stm32f2xx_update(s);
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
+        stm32f2xx_update(s);
         return;
     case USART_DR:
         if (value < 0xF000) {
@@ -161,6 +168,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
                clear TC by writing 0 to the SR register, so set it again
                on each write. */
             s->usart_sr |= USART_SR_TC;
+            stm32f2xx_update(s);
         }
         return;
     case USART_BRR:
@@ -168,10 +176,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
         return;
     case USART_CR1:
         s->usart_cr1 = value;
-            if (s->usart_cr1 & USART_CR1_RXNEIE &&
-                s->usart_sr & USART_SR_RXNE) {
-                qemu_set_irq(s->irq, 1);
-            }
+        stm32f2xx_update(s);
         return;
     case USART_CR2:
         s->usart_cr2 = value;
diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
index 65bcc85470..fdfa7424a7 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -48,10 +48,12 @@
 #define USART_SR_TC   (1 << 6)
 #define USART_SR_RXNE (1 << 5)
 
-#define USART_CR1_UE  (1 << 13)
-#define USART_CR1_RXNEIE  (1 << 5)
-#define USART_CR1_TE  (1 << 3)
-#define USART_CR1_RE  (1 << 2)
+#define USART_CR1_UE     (1 << 13)
+#define USART_CR1_TXEIE  (1 << 7)
+#define USART_CR1_TCEIE  (1 << 6)
+#define USART_CR1_RXNEIE (1 << 5)
+#define USART_CR1_TE     (1 << 3)
+#define USART_CR1_RE     (1 << 2)
 
 #define TYPE_STM32F2XX_USART "stm32f2xx-usart"
 OBJECT_DECLARE_SIMPLE_TYPE(STM32F2XXUsartState, STM32F2XX_USART)
-- 
2.42.0


