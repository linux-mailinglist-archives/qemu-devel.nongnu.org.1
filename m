Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3539F7E7264
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:33:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AiR-0005wf-1w; Thu, 09 Nov 2023 14:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ai6-0005Ru-MA
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:04 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ai5-0005J3-58
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:02 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so216555366b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558138; x=1700162938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyyFM5rojPE+uJBRWUA1uUis15hpR5uGCcF147lyuU8=;
 b=ceWJJSVTDqh3rVWtpr6FLID8/EGtwSPZfOCpxla5lqrYQx5o8LuqgVLsuI+x9kWjfm
 tDUiNPz1AsI0xqahGzAeKR7UoUT22pE1lh2Lzs+mHwgcJ20qRWtHHAZggxQoUcF9mN6N
 f/Ay6ySseUgVFULW6LSOeWLkNRdXFW9Zs/7UvVgtZIgJqO+msBUoE5xirzO+TSbAuIdT
 T89g69M3uNaLF7g9JMYKBQmwYWvi2VwDGkDXCseUgIdxqjIZgmPzBFawoNED1+jh7+Vl
 Y4BOZnq6dGKytEU/CHJxwGdD5cyrYpWjOaSoFdoCDSditHlKy/yMd1BaHv5+UbsqEgVG
 DjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558138; x=1700162938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SyyFM5rojPE+uJBRWUA1uUis15hpR5uGCcF147lyuU8=;
 b=pOYEqV/7pvC15swAJObP1fwqYMJR4bD99PBknWT0keOhYg+83NEfoL2vRkyofImcKv
 DILEilAFtH8WtoIVhBiQ80XyXTG6QTg8JIfWkyt9eCFEQmmUKsemIEE5QB6oezub9FyO
 qWFK4cnBVesx8krdjcI1ZNQojJQCw376mLtQyHiROTfGQ34/KLICBimLDfAYrTjuf8Wm
 Gi4c4wHOvNvEARUwtplSzwAQFXU0DwokGfYv84Fn70WtrBIRa/BoNuBKGR8b8cnPhICc
 Zu5bwhmJE/eTVi86O1JBh2PIZX1wYgHlmmI9ZjR9FO5wZxlQ+BJMqP/HIG2LYfXARx22
 z4kg==
X-Gm-Message-State: AOJu0Ywhc/RYpkpZ7kjlvavtGK6LIx14nda+F8XwqW1Bm4PXX388966v
 AoEXXw6C1qWjzsVQfhslE0tUqY3tVFMF6kwY6EiQFg==
X-Google-Smtp-Source: AGHT+IEEqqr7N64ypg881HZQy8Pe4TRT0j60Rt1LHwaHNJh1J82Hmd1+KXR5zRxwESQEg12Z5PsU9A==
X-Received: by 2002:a17:907:96a5:b0:9c5:7f8b:bafc with SMTP id
 hd37-20020a17090796a500b009c57f8bbafcmr5691609ejc.22.1699558138606; 
 Thu, 09 Nov 2023 11:28:58 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a1709067b8300b009adc77fe164sm2938523ejo.66.2023.11.09.11.28.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:28:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-8.2 v4 07/10] hw/char/pl011: Check if receiver is enabled
Date: Thu,  9 Nov 2023 20:28:11 +0100
Message-ID: <20231109192814.95977-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Do not receive characters when UART or receiver are disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 9c43cb47bf..ca931be139 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -77,6 +77,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_BRK     (1 << 0)
 
 /* Control Register, UARTCR */
+#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_UARTEN   (1 << 0)
 
@@ -359,9 +360,11 @@ static void pl011_write(void *opaque, hwaddr offset,
 static int pl011_can_receive(void *opaque)
 {
     PL011State *s = (PL011State *)opaque;
-    int r;
+    int r = 0;
 
-    r = s->read_count < pl011_get_fifo_depth(s);
+    if ((s->cr & CR_UARTEN) && (s->cr & CR_RXE)) {
+        r = s->read_count < pl011_get_fifo_depth(s);
+    }
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
 }
-- 
2.41.0


