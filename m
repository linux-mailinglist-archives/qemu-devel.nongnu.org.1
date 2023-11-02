Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 297977DF8E9
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfS-0003tT-2g; Thu, 02 Nov 2023 13:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybej-0003HP-Dz
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:39:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeg-0002ys-Rl
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so745309f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946733; x=1699551533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sPFWc1s7OJlbSKqVGRhWCnDV7XV3swiqvpQRbW+f2QQ=;
 b=Tsu/4h8JLzq7JobhgKmiSIYx25jhrH4Oh+tCwfQ9ikKfZ5Q+TScVl6WamPcdmoIFVm
 00bmmKVluXSzVxVXwUt1wwW8iaKRduaSuesd9TKjMobFj4btYZPoF1Beq2K4iLiNJSJD
 HYSLv8kgdlnZMY4upEcrvenVulytjgi97PO6/heER8Inhm8NjCA3kGe/ijQaJ6ohxk5T
 CBpgO/Ndj8xwjB1wDDljl2Jb8fLJVEz9SsnFJkuYzZ+EfZyFFG1rTZat38v2x7qP99Ft
 dVaNg5kB1jdDm65CvcI7rqEKKZ7v9GqnzyOqgvXY3HK1gNZ7E7SP6uzt4cAFBgkL9rlE
 DSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946733; x=1699551533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPFWc1s7OJlbSKqVGRhWCnDV7XV3swiqvpQRbW+f2QQ=;
 b=v9s90g1y7cDKHz5u4tfD9cF8KwDWlKtyPD4sXBCT9tV+kxYfFhByVgTMKZi7Gshj4x
 YINmwTNcT9cU76dSy+hM+RM0J+1VTf33OKOAr1vsuCO53hsQwE4ROjkJBhCYVsA5CpJU
 72PJh23PA5utMVOvZMjFBliCQUJgl93T8oGpaHqSqwnzcmzE1w5epjxCpYdTUcgh9QS8
 KHMN1kA9dC9kK0VcHONIbCBoKAOXxeeZHUMK8TRlP0r9AO9OQDpnoLXFNa2Dv7xX8VvH
 7tC+H2yvpFVR11M1pxHL90gsJbRCBFBIkxtJmaJfld2sP5SR3KCdxsp35W/34ZRVSeyY
 MUIg==
X-Gm-Message-State: AOJu0YyI/sPRECvNkbvdiGgXGIaKCkJacEoFLRXP3elPEvgqz7qopBmC
 9fKIuxC1IuIW6lEbd4cHu96YUnL3CjImvZxY020=
X-Google-Smtp-Source: AGHT+IEqt4R6Kkumr4m2kvihdkeHVRMPMYAXxGBk2raHs9cdOmfETfrE02+sHGUgovTcwN3Pp+hP7A==
X-Received: by 2002:a05:6000:2ce:b0:32f:7e24:ddaf with SMTP id
 o14-20020a05600002ce00b0032f7e24ddafmr16011841wry.10.1698946733031; 
 Thu, 02 Nov 2023 10:38:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/33] hw/char/stm32f2xx_usart: Add more definitions for CR1
 register
Date: Thu,  2 Nov 2023 17:38:31 +0000
Message-Id: <20231102173835.609985-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Message-id: 20231030151528.1138131-4-hans-erik.floryd@rt-labs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/stm32f2xx_usart.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
index 65bcc85470d..fdfa7424a70 100644
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
2.34.1


