Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CAC7D147C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsre-0002cn-2l; Fri, 20 Oct 2023 13:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsrX-0002bf-Hw
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:00:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsrW-0000KC-2z
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:00:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4084095722aso8498185e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697821235; x=1698426035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbtFw1Pjg71UOOCnDLcng5H0rDRsRUycUpGk3Jvwf+E=;
 b=HVhWsJ12DKZ8Ias3+ZxP+xhNixI8LvNChPDSguMrKjxp+PElSUgnURMXXu2I1hgYHS
 VNwWHasZDgdqKht1LlDjDFxDRFHNhlS6DXmNA++oJPFf1w3ktG7NiYUTYRdLmkrgcr6y
 aElMdEa7Vq7zzcjBfMABVmKYPOLk81Wre5OBRxtWTyb3W8dGlez/M0vBC4CRMfbxuSwN
 oW0coYyiGaZdOH9R5iXLJxcMoTAdJouvZ1UGpxt9DQSJxxGrgHom49zXVl/dhIiWspJq
 IDtQ0CI2zylbg7Uls/jL1fALGKgiLCdx8SOmzJ7YrO1kyKE1U98ExVxZEDJbLAwb19tU
 do1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697821235; x=1698426035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbtFw1Pjg71UOOCnDLcng5H0rDRsRUycUpGk3Jvwf+E=;
 b=ibQYLM9D12Bi9gqfxDI4wYY+630BjMhJEiOgd9Yps5WZWMuVuND/SlxwSQtgvuNaq0
 BnNApL0WsF7DsLB/2AH9nMOvPye0x3Asl4mHHYkI54ouYG+S5zLKTcSv7HDXY1AKtMUb
 o7Z2EKLXVQT5+J31zHtn5LTNdQIPlJcL+pRe3uvCY2JPuA1eOVAk28GwtrrRfq5QLX/3
 lTLhlG3EEeFxY72piMwcIFgv84n98SJauOhz9QcOlPlmno48gdz9e/Wm+sRUGfcd5ZV+
 l16ly8j2m+dNj9OyH5ZUKV8R/7I/tgIzL38CT5hZ1YF8UF2ALZ6PH181QEb805IjUKa9
 IN5g==
X-Gm-Message-State: AOJu0YyAY+Q9LD8jy7oQFOjWEyv0J6JA9Fi4RxKtAQ4PcUXK8s3JMs6w
 mHTdCVD8oTWtOi9ImW1Y2srYVQ==
X-Google-Smtp-Source: AGHT+IHgXp/pyYGQcB+Znnn+qGHKGrmFIvhhgjgNRwAqbEcww/oT1lx6pilbiE9t2wKWHn2Phgsz1Q==
X-Received: by 2002:a05:600c:4f49:b0:3fb:a100:2581 with SMTP id
 m9-20020a05600c4f4900b003fba1002581mr1888317wmq.14.1697821235488; 
 Fri, 20 Oct 2023 10:00:35 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b0040531f5c51asm2625453wms.5.2023.10.20.10.00.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:00:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] hw/char/stm32f2xx_usart: Add more definitions for CR1
 register
Date: Fri, 20 Oct 2023 19:00:08 +0200
Message-ID: <20231020170009.86870-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020170009.86870-1-philmd@linaro.org>
References: <20231020170009.86870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>

Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
[PMD: Split from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Useful if unused?
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
2.41.0


