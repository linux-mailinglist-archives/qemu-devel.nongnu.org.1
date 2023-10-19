Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B7B7CFA8F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSmm-0004aE-5i; Thu, 19 Oct 2023 09:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmR-0004MB-7t
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmO-0007Dn-TC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso13215055e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697720974; x=1698325774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuH7XtOKs5G9Ns2H+BnAt+HjsoiLIzrJP7Sikrea0Vo=;
 b=i92aIzOUdayOZ6agwNL5c/JOzhuUpczsum+3ccFhwjCw7yhD5w3NoB3EuG8SQNvuCs
 rQOGKXYmUBaoS7hkozxUD5KLB4HLTI837EctSTMVUE5VbVHKpvO1QYcKKx/hpEpaqqyo
 edvg095qMpRhc3jbPMyhBz9RdPUPxYu9yUJVltu0m7Fz6UNCFyDUKN19M8RoMSPsVtqt
 kw6Zwd7Q5pEwDzu6NWukXQejItc0qS/vJWh2RiXXNjCd9OikwnWxRHVcMKvQ6mM/kcoM
 EB6eq5miedZM7319qkIExGlaN3JtKB0/BuMQEPyfxdIMu35MvCerQaHzbQ1OxPYgrpro
 iaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697720974; x=1698325774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuH7XtOKs5G9Ns2H+BnAt+HjsoiLIzrJP7Sikrea0Vo=;
 b=qzqpTIHAKj+9odJcgDqOC8c1P0Ll0O4fT+4DAREGHaa7SzE5Mq0L6vczuwbIqVrzYn
 FzToDdnKcL7/ScJv7CHkrIRKPvhiLCMi4Dc8qobmKedyN8rZtq0v7Jl+0R7tlYhzwHTI
 TgLabnNXSCGSxjA1ITKXagbyg8+oJeGY5aBnQJKTAx9sf/xASvwqNXu0l1U+ft/byWhU
 Z0WT/TQFBzdcG9woRajRREqpO4xMBN8tlo2GzAiYKNx2OZZo3iamrpR/G9lkrD1zl0Hp
 0TSCdluvUxMwUeumUdwwfMxtU2v14x/y+opRC/jUzhZoYFgYGamn/ZcWkJ97saKK6vVO
 ZYCw==
X-Gm-Message-State: AOJu0YyklxUg9WP3ojmixoxIC9mSKayGZjI2/VSSwfkgrkxVJvswzyW0
 0oZNOJxNf0rmrFq6+x+qhgDrf4ucDZ+q6BMIY9TjcQ==
X-Google-Smtp-Source: AGHT+IGDsJfbILsr2xJPe+a80Wy1FrKTGIMKsJG202Jf+9zGebWakE5HODkgVHapM/P1H6Cqc9T+bQ==
X-Received: by 2002:a05:600c:4588:b0:3fb:a102:6d7a with SMTP id
 r8-20020a05600c458800b003fba1026d7amr1762628wmo.28.1697720973980; 
 Thu, 19 Oct 2023 06:09:33 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c231100b00401d8181f8bsm4373980wmo.25.2023.10.19.06.09.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:09:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/9] hw/sd/pxa2xx: Realize sysbus device before accessing it
Date: Thu, 19 Oct 2023 15:09:16 +0200
Message-ID: <20231019130925.18744-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019130925.18744-1-philmd@linaro.org>
References: <20231019130925.18744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

sysbus_mmio_map() and sysbus_connect_irq() should not be
called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/pxa2xx_mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 124fbf8bbd..9f7a880bac 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -483,11 +483,11 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
 
     dev = qdev_new(TYPE_PXA2XX_MMCI);
     sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
     sysbus_mmio_map(sbd, 0, base);
     sysbus_connect_irq(sbd, 0, irq);
     qdev_connect_gpio_out_named(dev, "rx-dma", 0, rx_dma);
     qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
-    sysbus_realize_and_unref(sbd, &error_fatal);
 
     return PXA2XX_MMCI(dev);
 }
-- 
2.41.0


