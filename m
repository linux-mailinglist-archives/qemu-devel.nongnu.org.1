Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 893807D103E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpAu-00019f-6p; Fri, 20 Oct 2023 09:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAZ-0000hL-QR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:10 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAX-0005K4-SB
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:03 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so121593266b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807038; x=1698411838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVpVhfYsMArn5+3t2ZWXwVgzj4H5ByX4fZEF0dWkMj4=;
 b=pDh492T0LIHfqyFWzMWdCkOe2e5VCyI6wjvYCJ1hnXWIQzVhBvHoi4OhSjtyO0NZXy
 xwi2tUgYe+PZETFDCKjCgKNIpRrdA528KnQqUKB3B0WDdi+fbIDuBjIQ68P7z1yxSKZR
 51nUQpL0KwnZALAi3NStibBptq3T6L8jGXhN0cye6UIxDUq8T+KgjRWSstc7Tp/srljR
 kb+hr94b4xl4SkjuZtNIjK7VFzYYZXZwD3Y7KLELxnL6d2GU9D+nMhueThiiiIcCqWGH
 YaPBvSJ2oPYpTCkl3ILjXNPoU1+IOoGErLOupU1brNWw48kpzQ5EJPZbamxEb3CdYUvy
 8BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807038; x=1698411838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVpVhfYsMArn5+3t2ZWXwVgzj4H5ByX4fZEF0dWkMj4=;
 b=b6+qXp0l36ceJYXeeEdQPVnWQQXGXt5vgFmgp3xJVU9NFiDv/c+yY3Oem0kvWUqiqb
 JsLh7xTNz8pMBvaGvdymER4gJsrb/bHgrGK0zhlk1tARuFShgCp5g7mK2VizpJb7hodR
 lbwUla2MSRPlYcUZropJvVs/sWuhAsNWckZblZL7IoMnilHgsJa7zk1ROnOGKlsJg750
 jxc67m60Hd+Dg451iqyDT8WxtyMHZzCbFjBiYbCi9ElozKXHv916gYJRUctETGVAeIP9
 6lQte6/pRO3zQHJcZod+9R0KEh9fJKwP3iaSXwByl99t+rJCGiK50iVp5G2/JwkZ8p6y
 b1iw==
X-Gm-Message-State: AOJu0Yx5kw5pNZ0Dc0LtbywCR7v+FK6wKpvqbX7r01oPjmdhzrm11xN8
 rAhUzbMLQ9YiOzWaQUDukTJlObg979fzQbkHCSM=
X-Google-Smtp-Source: AGHT+IG/0VQrqjViewyBQe2fMBcwXG9J5zJRIE980+gmv/GovkUaWhRDE1Lql2DXSlG89Y8NLNqDgg==
X-Received: by 2002:a17:906:d555:b0:9be:fc31:8cd4 with SMTP id
 cr21-20020a170906d55500b009befc318cd4mr1556257ejc.18.1697807037847; 
 Fri, 20 Oct 2023 06:03:57 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 my18-20020a1709065a5200b009a9fbeb15f5sm1447874ejc.46.2023.10.20.06.03.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:03:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/9] hw/pcmcia/pxa2xx: Do not open-code
 sysbus_create_simple()
Date: Fri, 20 Oct 2023 15:03:25 +0200
Message-ID: <20231020130331.50048-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
References: <20231020130331.50048-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pcmcia/pxa2xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index e7264feb45..3d512a292c 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -143,9 +143,7 @@ PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
 {
     DeviceState *dev;
 
-    dev = qdev_new(TYPE_PXA2XX_PCMCIA);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+    dev = sysbus_create_simple(TYPE_PXA2XX_PCMCIA, base, NULL);
 
     return PXA2XX_PCMCIA(dev);
 }
-- 
2.41.0


