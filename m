Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0170C27A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:34:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wc-0007VA-Id; Mon, 22 May 2023 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Vr-0007Mr-TM
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Vq-0001Ju-BJ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:31:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f603e0edddso10172285e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769513; x=1687361513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glXXfgsRplQFxPF2FEdJ5asogB54RtufXxooiyPAR7A=;
 b=N0ERuWsLU6iXzOmNBKOlOpg4dVkGIjpNumO8nlBuo/g3l/21CGfmxDKG1N7GJHIODC
 xCjmdmKdHuOGQoAkqrhwNkOM6uT88izAuP3FNvvfanq3672NomTXUdILkhUxwC0a/sp9
 pn9WJZchyTXwhmGPVJMVCOhemcgIzwWs6X8tVscCiw12/7/1QLhGqWtV/rlzRdmkZsDL
 K54krVxaFq8L9I28MWlWWq+S0m9wjStStKhVHGEc+Xuroh0ag4vwadyLsW7JN0s/tFFZ
 /HbGaIxvd+PaBTr+bRLhP/UN7MdfhJW7lvLzTZSuiui4WalCkBefKzxfbp8TjbkbFBME
 0YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769513; x=1687361513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glXXfgsRplQFxPF2FEdJ5asogB54RtufXxooiyPAR7A=;
 b=QbeDMYF3dApeplxU9N5D1XyOuXFI3IkMrTPg7E6pamBHljmiFjJt5ndZH/CtJUYg1t
 M1xjXAz5PznIF+y2GHNMJWT9B0h34xeFzB2/z1UHZph9bzO4kjq2fMFJ+m/BfFfoCQD7
 b9uz68vohWvCj1Pbdbr8+aa7pl3PU3LqbK+7uC8TsW/wC0uyulPFEeXifvU3vvUAJq7L
 faOTQLWkQjWrXP9gLzlSnIoImMdG1Dq2aeHkjOamynj0iNqV5sry6va/qEkBVx1I5jiJ
 HnFkXQwX+cdYcNGwVNpFwhErf9MBnnQHJMX/vYkyEuVt7f38BZN7sa3LoSSAb9uMSotf
 5ZLA==
X-Gm-Message-State: AC+VfDzrIaUfHValu8EZitwE1w8HLq9OpGzB/8Q0JN9US9peT8N0aV3V
 H+Kg/Tg8BZXuFnpToQYdWCIj28p3JQwZTfAwYlI=
X-Google-Smtp-Source: ACHHUZ76Trc8v9vEFbD2AWUKqFB0luBfRmsTYpHZPG+DYF4hzmK1sSjy1HfwK+v4/lpt1CFMe8JjBg==
X-Received: by 2002:a05:600c:220d:b0:3f6:3bc:8562 with SMTP id
 z13-20020a05600c220d00b003f603bc8562mr3097333wml.1.1684769512764; 
 Mon, 22 May 2023 08:31:52 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a7bcd0f000000b003f0aefcc457sm11845054wmj.45.2023.05.22.08.31.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:31:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/12] util/fifo8: Fix typo in fifo8_push_all() description
Date: Mon, 22 May 2023 17:31:33 +0200
Message-Id: <20230522153144.30610-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 28bf2cee57..16be02f361 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -46,7 +46,7 @@ void fifo8_push(Fifo8 *fifo, uint8_t data);
  * fifo8_push_all:
  * @fifo: FIFO to push to
  * @data: data to push
- * @size: number of bytes to push
+ * @num: number of bytes to push
  *
  * Push a byte array to the FIFO. Behaviour is undefined if the FIFO is full.
  * Clients are responsible for checking the space left in the FIFO using
-- 
2.38.1


