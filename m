Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A167C7FD1
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:17:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCzG-0004t1-EC; Fri, 13 Oct 2023 03:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxy-0001hl-Ch
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxf-0005Hl-CB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40684f53ef3so20829315e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183513; x=1697788313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otVaVJDhbuHMXV9luSXKOD49q6dBPVmJnIkfSS0ltHs=;
 b=J+TkEpCg+21YWv4WwSIKy4zCCrxC74NJcx27K2pb7WReUyiaU6YZk7AzcWjpI8vCZS
 VqvFHsQdQte5B5f8yc7Ve0MerKXJQ+2d7V9Kul1Nx6dT91xmu1LvQWn4bNgrfwc9NgeQ
 NGYJDCO2JT+FNPFFNLuhKXNgcdlYHmEX9Pud6/arYBROCggEvJwRpnfEQIH81XJU0iXv
 2eVJS8F36OZNzSFsSnP5yH09Zs80kECfhzHhsRP5zvuB7gTHMJq9+Fova0A0/Vb0dmWf
 n9oZMJBPrbaix2SxauDZ1oAzvd9kNC1MsqvWPBY5rHG/hGeuSWze+1zM7i8ye6NFmuwz
 2o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183513; x=1697788313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otVaVJDhbuHMXV9luSXKOD49q6dBPVmJnIkfSS0ltHs=;
 b=NLvmRcMZmAKDyvi8w7qJoRTzMtw4KXQ0/m+15RoOSVngmfHfzZzLWOHx2tk/jX1MEa
 hfF4l9vOh2kRiMcw0zUyt17XG0H8xDVaHulO6cam7YhV/QpzEA1nqPAVT11dZfcox3kn
 miZ430vf2sBXgc3wf98qkAKUpWqJVYtpiuPV9E3zmUM3PKbK5s/i1VkSrYLeFYYhbNd+
 XQfm0JsrNLATrMO1V0zJyF7BZXQnQ8/WupENgTtZmvcnmw1L0W2v10lh7mrfmAOiBsH+
 SzJgVn48MbuorDj1Fz387/dr5TWPbSZlmkADispFA7LIrhaJe6i8vJ6gDZAnC4fviMHF
 cCZQ==
X-Gm-Message-State: AOJu0YyVHTG2ZmoxBbj/5KfAv5y7nk14nTY0iogaF5VQLDNqcwKpzRzF
 g1JMLWytIC/R661t3TOv779aparSFpDqYo46o1k=
X-Google-Smtp-Source: AGHT+IFvfo7amcs//gQJ+HEf/NOMzbbsbPMZegukKWV8IYDE0FtDk6MTx/VMetIbC7oTryKQbF2WAA==
X-Received: by 2002:adf:a351:0:b0:32d:88dc:b219 with SMTP id
 d17-20020adfa351000000b0032d88dcb219mr5335136wrb.45.1697183513689; 
 Fri, 13 Oct 2023 00:51:53 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:53 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 52/78] hw/char: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:11 +0300
Message-Id: <892c67609977bb00b317089ca9b6f9485be226fe.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/char/nrf51_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index dfe2276d71..3e2b35c7ad 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -113,79 +113,79 @@ static void uart_cancel_transmit(NRF51UARTState *s)
 static void uart_write(void *opaque, hwaddr addr,
                        uint64_t value, unsigned int size)
 {
     NRF51UARTState *s = NRF51_UART(opaque);
 
     trace_nrf51_uart_write(addr, value, size);
 
     if (!s->enabled && (addr != A_UART_ENABLE)) {
         return;
     }
 
     switch (addr) {
     case A_UART_TXD:
         if (!s->pending_tx_byte && s->tx_started) {
             s->reg[R_UART_TXD] = value;
             s->pending_tx_byte = true;
             uart_transmit(NULL, G_IO_OUT, s);
         }
         break;
     case A_UART_INTEN:
         s->reg[R_UART_INTEN] = value;
         break;
     case A_UART_INTENSET:
         s->reg[R_UART_INTEN] |= value;
         break;
     case A_UART_INTENCLR:
         s->reg[R_UART_INTEN] &= ~value;
         break;
     case A_UART_TXDRDY ... A_UART_RXTO:
         s->reg[addr / 4] = value;
         break;
     case A_UART_ERRORSRC:
         s->reg[addr / 4] &= ~value;
         break;
     case A_UART_RXD:
         break;
     case A_UART_RXDRDY:
         if (value == 0) {
             s->reg[R_UART_RXDRDY] = 0;
         }
         break;
     case A_UART_STARTTX:
         if (value == 1) {
             s->tx_started = true;
         }
         break;
     case A_UART_STARTRX:
         if (value == 1) {
             s->rx_started = true;
         }
         break;
     case A_UART_ENABLE:
         if (value) {
             if (value == 4) {
                 s->enabled = true;
             }
             break;
         }
         s->enabled = false;
         value = 1;
-        /* fall through */
+        fallthrough;
     case A_UART_SUSPEND:
     case A_UART_STOPTX:
         if (value == 1) {
             s->tx_started = false;
         }
-        /* fall through */
+        fallthrough;
     case A_UART_STOPRX:
         if (addr != A_UART_STOPTX && value == 1) {
             s->rx_started = false;
             s->reg[R_UART_RXTO] = 1;
         }
         break;
     default:
         s->reg[addr / 4] = value;
         break;
     }
     nrf51_uart_update_irq(s);
 }
-- 
2.39.2


