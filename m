Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF47DF8FD
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:41:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybgj-0005v6-DE; Thu, 02 Nov 2023 13:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybej-0003HO-Dn
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:39:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybef-0002su-BB
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32fb190bf9bso420234f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946731; x=1699551531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CwqI4acJjz6s4N0ziHLsowruaotlOGTTthUe1CdZYBE=;
 b=OHylroomT0by7hpr9M9CG1+t6uHuM5S/AbfKa76dZq+UFgfND2fYxzwoyNxbd5bFh5
 iUvgoeQV3mTN0F2g8DW5bOqqg2Nwge+kILkKPdVn2HweLSRPO9ZC0LJTh8OF3zLv8ade
 8eqM8SLcpJQa1xWSj2BEgt+PODD26ifVWuFtD5lJQu2hiZRh+YDOsAQ7V4bSNdsgFgXj
 bf/TMrDyrZmFBKGEn/xEQ+azrDdibKnBd4C+RvUKfKpLrTckoE0PGfxPkFcXWBjed9AA
 FW8fgHEvrNtQ4/7ZttlRWavmlkgbMjJCQZKFjs7nPd0LxoPny9OehiOW0yKQn/0UYfU9
 h8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946731; x=1699551531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwqI4acJjz6s4N0ziHLsowruaotlOGTTthUe1CdZYBE=;
 b=iq3xooKZfG1qF/KuBw9+Sk2qJVDdHnltsWXLLqEtIHtiNUyfxShpJsn1urgoc7oG2l
 EllSzs3T55/6UVzr0sNBdOzheN4BxGtEL6deupfkdAN7kG5btb9noNJStrMElOmKDqhT
 DByKqyq4TWSF72EH1ytkFGmOEGss8Hsoy+dqKAKxFcpAY4pnrv0xAogAsoACJL2Jf6Xi
 BFSdw9TZ8MP3ip9OsopK7YX4zgYrm56+i2KMmj7YwsdWHOvzkRH4EOJ+yW21JZBRAfel
 gHe+/rbwxd5jUmu8Xqg5blkyjULxXzSdLX1doFvzA8QRQFUiON/PywtrjemmP4AVm78T
 i3oQ==
X-Gm-Message-State: AOJu0YyBrT9tskeDl/Hn+gHwDrZG3Us8kYjBpolihCTwGQu+Zo+3v7eo
 4gaubTFxC+0/pei7nhct7tdisEpTgCkwOW6GnmM=
X-Google-Smtp-Source: AGHT+IF1M/mIiwR74K9k3r8iQg2+MkuqzkwRu/bwSERGhL+aEGzIxUsoQSayOinE2k9NhId03GkyRQ==
X-Received: by 2002:a5d:64e3:0:b0:32f:8b77:d423 with SMTP id
 g3-20020a5d64e3000000b0032f8b77d423mr679039wri.3.1698946731371; 
 Thu, 02 Nov 2023 10:38:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/33] hw/char/stm32f2xx_usart: Extract common IRQ update code
 to update_irq()
Date: Thu,  2 Nov 2023 17:38:29 +0000
Message-Id: <20231102173835.609985-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Message-id: 20231030151528.1138131-2-hans-erik.floryd@rt-labs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32f2xx_usart.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index fde67f4f03f..519d3461a33 100644
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
2.34.1


