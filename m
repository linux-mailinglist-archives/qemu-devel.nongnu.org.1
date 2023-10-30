Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1847DBC79
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 16:16:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTzs-0002l0-EQ; Mon, 30 Oct 2023 11:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qxTzp-0002gt-9E
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:16:05 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hans-erik.floryd@rt-labs.com>)
 id 1qxTzn-0002w3-N2
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:16:05 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c6b48cb2b6so25602071fa.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rt-labs-com.20230601.gappssmtp.com; s=20230601; t=1698678956; x=1699283756;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wzlyeAffKIVPpofvyyI/nktGGQtprwS66d1BSP8mFU=;
 b=M1iyU99ILxKIerB97LwhXffQUWHj5UG/op0Ufhz18Z7vFY1YYL0J58Q8ZpcmoUZarG
 jYjAEOsRoxWA/qj2PymPn11H78l1XeGItPwgfcd5Rno7+BA8WaY15jy6lESexomebJ1o
 DJdGDjnv3hQ3qL/UnshvUreX3ATFmB4NFqU9/h1gagcos6VT4vswSWVH9j2AFIJZVp0j
 uLWXIzCQEFfBEHaSTkTK3V98/ilpTsd5WNJ5aqID1uMu/A39u2Argh2uejsjybZW+pb2
 dnJw7JWwpVW9jgsmKYoAAPjP+vZrKbvOP4I5df6xzNaKzOmNueszLxdBYFB23qtJQ9WO
 DiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698678956; x=1699283756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wzlyeAffKIVPpofvyyI/nktGGQtprwS66d1BSP8mFU=;
 b=kYc4UBtL6Pk8TzEwnhcwGckBPH25DViYeVjl4xQXvMXwytX+/php3LPh27qvnMHiGN
 gm/DU904uNT9F4/ruz5wKULD0V03McH/Pns2d9KcuYUIQgmBUJZgDujPzMuqiAnLvpyI
 PsDXjGOdCZX5xl2JFgBynHDVpHkYfUiv1GG9naHTlrAzsh87J1gTX+RIH5vieXJdGF8R
 U4uFQ03lPdc76oupdx9crcJAgrIC1RREqXqxdJ9sQalmij9UhKaHiLzr4gZ68IazqbIa
 tFKIuUy7GXvymm6MInJhoIgDhG8H/b4nTC1JvN3g3rp7e/b/TjS2O2WvGUwSO6N+NZhJ
 i2xQ==
X-Gm-Message-State: AOJu0YxuYFi9CPmBHMEoX6LA9dXkIhjNj76jPvi/d576iK/t+9GLVXvO
 8Cbv/wizfbmwKWiraZdJkWb3Ow==
X-Google-Smtp-Source: AGHT+IFtHvbE9QvzIfnw5YuQsGmbAXcdPBagWWWcn1pcnlpit+3joS7+aTnDohsMrK6K8t6gP9wG5A==
X-Received: by 2002:a05:651c:1c5:b0:2c5:175f:6466 with SMTP id
 d5-20020a05651c01c500b002c5175f6466mr9054675ljn.34.1698678956328; 
 Mon, 30 Oct 2023 08:15:56 -0700 (PDT)
Received: from rtlap47.intra.rt-labs.com (h-213-136-33-86.NA.cust.bahnhof.se.
 [213.136.33.86]) by smtp.gmail.com with ESMTPSA id
 j18-20020a2e3c12000000b002b95eb96ab7sm1282274lja.18.2023.10.30.08.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:15:55 -0700 (PDT)
From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
To: alistair@alistair23.me, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, philmd@linaro.org
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 3/3] hw/char/stm32f2xx_usart: Add more definitions for CR1
 register
Date: Mon, 30 Oct 2023 16:15:18 +0100
Message-ID: <20231030151528.1138131-4-hans-erik.floryd@rt-labs.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030151528.1138131-1-hans-erik.floryd@rt-labs.com>
References: <20231030151528.1138131-1-hans-erik.floryd@rt-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=hans-erik.floryd@rt-labs.com; helo=mail-lj1-x230.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
---
 include/hw/char/stm32f2xx_usart.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

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


