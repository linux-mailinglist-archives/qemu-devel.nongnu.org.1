Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0707C803F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5n-0000EU-Le; Fri, 13 Oct 2023 04:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5O-0007u8-Ps
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5L-0007Nm-5k
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso18497045e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183989; x=1697788789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+1yJwn3zmXEC3qXSgScF2rHQYYxqdr3vGb0Ox5zm5c=;
 b=qrPbnDrwEjQb4XrBZP2lA4pto/QuuBj/PYuWFT+dM6AOgIFqa8W249gka3wv7BVbaB
 ouVo1o80B1bKOnoo2sa+NgoVAAJXzLgGFU9BC+05vQSCigQsZZ79rmU1u0F+MaN9WOJ6
 s28BgstOntcdEGqPUdcdTCyiGmsX4moGXXP9nFT2CC9LMgX1qq5UCmwStxf3MeDonfCl
 zN7j1CLJ9H3F5N429MQLqWgn8Ik95FooPAUeg9DI0fNCNpNcT5UOIkIVXYQ77uO1jKgu
 Uuw4XGuHAyInzgnZjzjIlh5InMjGSnNU+OYsQeEE+EwK9Zbd/q8GOentq6sfzuakqIUl
 3QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183989; x=1697788789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+1yJwn3zmXEC3qXSgScF2rHQYYxqdr3vGb0Ox5zm5c=;
 b=IoJvrDRgvbOF9EtqXyPcIbh5KxRIKHtxFU96KqxUXK+bnVfmkvDzJrmRtMNIFmjk7B
 j/aAG3W9QGjV/cixMIdt6EJMkRhr7pCqKT2hCIZzr+VTxyw+0o9Eqr8uce2oPXq21uDX
 0SK77Bx/PhpKKTc6oJUoT+4FGySF6bAkk4uDrKcjmNmyVsfqrVvsM2MP1y2OXOMU+P+/
 fOe+1cWHnLCAgfCQfCYfxmEXnzC1IlG5HEQfd5mIbN7vDQGO1B02EgnrNaQHzFRp1rw/
 n6WnM3I+RPvHISe5Wo5d7yLz8T0BkKiC+fg62PMvX5XdtFJiBeM07ZhNzMmRcxrqqkuI
 pmEQ==
X-Gm-Message-State: AOJu0Yyar6pYu8vvnQg/ASs3NKpyKSqGLVLCZexbXOqlkP4ZPNEaMSlp
 g9Ka5MTlFfyqp/dYBK22I2xPOw69ZBz2AFpWpxo=
X-Google-Smtp-Source: AGHT+IEOdLt389slTyb4h/+TWYabVke1OXf0/+Nh070iSDEd5vSq3Gaea6/IpmwgQ1nlGvaqB7fgiA==
X-Received: by 2002:a05:6000:1088:b0:32d:9e4f:718f with SMTP id
 y8-20020a056000108800b0032d9e4f718fmr511515wrw.44.1697183989394; 
 Fri, 13 Oct 2023 00:59:49 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:48 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC PATCH v2 64/78] hw/mips: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:31 +0300
Message-Id: <417f87aa892d8c2b4d97186f4c9918de5608fa20.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/mips/boston.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 4e11ff6cd6..4ca53b790a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -164,27 +164,27 @@ static void boston_lcd_event(void *opaque, QEMUChrEvent event)
 static uint64_t boston_lcd_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
     BostonState *s = opaque;
     uint64_t val = 0;
 
     switch (size) {
     case 8:
         val |= (uint64_t)s->lcd_content[(addr + 7) & 0x7] << 56;
         val |= (uint64_t)s->lcd_content[(addr + 6) & 0x7] << 48;
         val |= (uint64_t)s->lcd_content[(addr + 5) & 0x7] << 40;
         val |= (uint64_t)s->lcd_content[(addr + 4) & 0x7] << 32;
-        /* fall through */
+        fallthrough;
     case 4:
         val |= (uint64_t)s->lcd_content[(addr + 3) & 0x7] << 24;
         val |= (uint64_t)s->lcd_content[(addr + 2) & 0x7] << 16;
-        /* fall through */
+        fallthrough;
     case 2:
         val |= (uint64_t)s->lcd_content[(addr + 1) & 0x7] << 8;
-        /* fall through */
+        fallthrough;
     case 1:
         val |= (uint64_t)s->lcd_content[(addr + 0) & 0x7];
         break;
     }
 
     return val;
 }
@@ -192,27 +192,27 @@ static uint64_t boston_lcd_read(void *opaque, hwaddr addr,
 static void boston_lcd_write(void *opaque, hwaddr addr,
                              uint64_t val, unsigned size)
 {
     BostonState *s = opaque;
 
     switch (size) {
     case 8:
         s->lcd_content[(addr + 7) & 0x7] = val >> 56;
         s->lcd_content[(addr + 6) & 0x7] = val >> 48;
         s->lcd_content[(addr + 5) & 0x7] = val >> 40;
         s->lcd_content[(addr + 4) & 0x7] = val >> 32;
-        /* fall through */
+        fallthrough;
     case 4:
         s->lcd_content[(addr + 3) & 0x7] = val >> 24;
         s->lcd_content[(addr + 2) & 0x7] = val >> 16;
-        /* fall through */
+        fallthrough;
     case 2:
         s->lcd_content[(addr + 1) & 0x7] = val >> 8;
-        /* fall through */
+        fallthrough;
     case 1:
         s->lcd_content[(addr + 0) & 0x7] = val;
         break;
     }
 
     qemu_chr_fe_printf(&s->lcd_display,
                        "\r%-8.8s", s->lcd_content);
 }
-- 
2.39.2


