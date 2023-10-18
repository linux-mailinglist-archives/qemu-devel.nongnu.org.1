Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8657CDCFA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6MX-0007cq-WC; Wed, 18 Oct 2023 09:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6M0-0007D7-JB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:53 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Lx-0000ls-Gs
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:51 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e84912038so6548852a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634767; x=1698239567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrXKI6jVLRlYzi/YxZFiozSO1YVRsr5CmuAToS28wAk=;
 b=lEcKY7oq2aVDkJm9QEs7FF5I3qgwi4I4I4k6eW8OU5ATE+X7eqO5wqD0bUs6Jg9uu5
 oLu/4FPHja7mGpsNAA+K87PzaeRvAybNfUn6bvQoT6FmKJDN/Wi5KpvQvph7DwcpYNMu
 H+xZNuAXf+wf917HlcW2QgBeSMm+HD3MfZhaIahiHwEL6A6wlz/NH5/w+ZB8ZFuAHlUh
 5QIw0vfW54YY5DuIRTBG4i/BDXM4W7CpYkLqhhW7iNZ0M2CYtPNARZgo5MWi9WkFDcVl
 LcnAVhkA5Vr4S13bo7vi5n5r363CvUgm9DPTC4CZw/TewOYMsrxrKlx665e9gE290FU4
 YKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634767; x=1698239567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IrXKI6jVLRlYzi/YxZFiozSO1YVRsr5CmuAToS28wAk=;
 b=Cps3aA+g6YzjAQcDPwPYmOnrBv0EYe4bcSLLKJPBbpkCuC/V5r3CGshR6RuLjgGC4R
 wOdsdCm8hbv2matO/RDanyT4/+XK2dJfzyfZQaHmJrTO4bNf3IpLvAK7RKxYtS3mudFY
 wqTWFlgjh3vOTQHagQwMEZyNf/3hjFj5pNqGJU3GLnb8T11sMYEM9WGK620/gSgoRYfo
 BjCLLP4qHcP2UBhiXngo8VkWro10AEaBMYfE36caFYeBpkaARkoSX/VlDOLdoOtu1IL0
 E59papLGacM1Bi8Fse5+wOYZx/WRKVlY/RbmKvtkeul9DvXoMhantbj4KJ/jOmRyHNLh
 s14Q==
X-Gm-Message-State: AOJu0Yxd+penHoY8/0QWKgDSs1kO2crgcQA5GE2SUgpKUDIUCluwaiNf
 moDWEf4nl+aTEG88GradZq1Jg9kct7hY4bPiIhk=
X-Google-Smtp-Source: AGHT+IG28bY9i0EuG4kzlcU6ITOWPTBzM5x1JQJeFr/IgKFr7SknhPRFLxlzUw1DwqToMA3nBd996A==
X-Received: by 2002:a17:906:7310:b0:9be:53ef:211d with SMTP id
 di16-20020a170906731000b009be53ef211dmr3340434ejc.72.1697634766801; 
 Wed, 18 Oct 2023 06:12:46 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 7-20020a17090602c700b009b97aa5a3aesm1689320ejk.34.2023.10.18.06.12.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:12:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] hw/pcmcia/pxa2xx: Do not open-code sysbus_create_simple()
Date: Wed, 18 Oct 2023 15:12:16 +0200
Message-ID: <20231018131220.84380-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018131220.84380-1-philmd@linaro.org>
References: <20231018131220.84380-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pcmcia/pxa2xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index e7264feb45..a2ab96d749 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -141,13 +141,7 @@ static void pxa2xx_pcmcia_set_irq(void *opaque, int line, int level)
 PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
                                       hwaddr base)
 {
-    DeviceState *dev;
-
-    dev = qdev_new(TYPE_PXA2XX_PCMCIA);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    return PXA2XX_PCMCIA(dev);
+    return PXA2XX_PCMCIA(sysbus_create_simple(TYPE_PXA2XX_PCMCIA, base, NULL));
 }
 
 static void pxa2xx_pcmcia_initfn(Object *obj)
-- 
2.41.0


