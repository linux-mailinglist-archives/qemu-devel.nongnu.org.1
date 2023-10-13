Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DE67C7F0F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:56:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyk-0004Dv-LC; Fri, 13 Oct 2023 03:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxx-0001Xa-0t
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxd-0005Gx-H2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so18680315e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183512; x=1697788312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1OhV6qS5rsFOKsCecCidHB0/dji6/R7YehoLsjqmZ4=;
 b=RjCeVuVAPqICNQZK440RqOkZBdilWzt6gINGsMBcV4WKZsoKXvOt/U5D1a+SwnhBDW
 xWmXZ8pNl3swD0HGfodec7RJxfxr6olt+Z5E/4S5OlhkcCJuPovsrteSOO+Mzv5Dfij/
 mvp6gDhneEUNX7bE0QZTZYfJQfjHlWJ4LRGlES/ESnA5q8TWnhJL/XBSQZ1KUqweuxc4
 fCYb6m/9wpApjO3PMmSfgOAMm//cFlinm0SERZmnwS0KXLX74y4NE45iel0syhGNaPvI
 Wx+o6BCTRA5LdrQpcxUAKXSfgOnyny5N2UGZfBmn95WYj6IZIdhPJWWOX1Hm3Wzd+5JP
 ySmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183512; x=1697788312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1OhV6qS5rsFOKsCecCidHB0/dji6/R7YehoLsjqmZ4=;
 b=TUessl6/uGadU2mSIem99BttMoy57+Flkx3OqEaRI5tqcJKjVLlwd8/87bn2MaRtbf
 NpdexK33HklNAl9pdZ45ZgBihDppzw+yjCh5R5xPneM/ONdC8GynL6ZRLtKOE0MeLY4R
 gY9vAa4ylUCA3j+kwmntNqor//14ZpglQtsCpRsul3+uhQccuTDMitCxp7PqQxjNGYTM
 TP045hnRBC4JdfBwSAEedOi47Cfc6cQzOA8h4ufeuLd48NxH4HdWyD1lya26bANpao6X
 stJ2ODXEDBKFqbYR+MK0lE/VN4/Nq3RAmffwWOOfWjdbBJ24Q69IPWn8M3Wcn0kqKy8+
 aZSg==
X-Gm-Message-State: AOJu0YwZVLHahmrqTN7zuiTQaFXbl7QeFyUzOFP6G8TID/WJW+1hzNpS
 eog9GDjsJ6WOFRMbHm084lkzedgWB0c+SXof+Lw=
X-Google-Smtp-Source: AGHT+IGDjuod4fMHGBdNQ5IRL0qh/QqhZ9O5QVi/W9ts2r2sqb4XOPu4+ivQhopVkCBI74Ffw0+bbw==
X-Received: by 2002:adf:ecc3:0:b0:319:7c0f:d920 with SMTP id
 s3-20020adfecc3000000b003197c0fd920mr24613357wro.57.1697183511822; 
 Fri, 13 Oct 2023 00:51:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:51 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 51/75] hw/char: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:10 +0300
Message-Id: <c5632702ea33995c5f4f02d3b1e70eead463be40.1697034504.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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


