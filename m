Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DECA78F5DF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqb0-0004Gw-AH; Thu, 31 Aug 2023 18:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqav-0004AM-PB
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:58 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqar-00030b-SX
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so1127898f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522612; x=1694127412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C//OKonAhBTdAA31WeZt4HEKfoMaq1ExT5IohWC+GEE=;
 b=ZycqYeTqToEPoiQHOVNKnceVyOBEVaynFCechXy+p2eraxH3cKL91PfxRb4CABXGA3
 /mTjWwghNxCk7Bi5GJAwvuoOcSUJu+3nQAvogD1KUdjEFL5FimMTHVpEBftMjyE8c/Um
 q/MZ1w+x5f7NNmjb/V/klkYgRJ3LJerJX+7ysJ27Nyph9PTRv5kt3DcA2nnYVc9lSOAK
 lgqpCDM4PYDFZQjQvAOj9LgIIyOqZCp2F6xNAuKo5BnkEA4F77Jk0gPxgBQI+7VD72gy
 j7SqZYK1++1t75rTZTrptC3QcoQE4xPERgxy4a+tHsFaytbQTtHIQONHBy+zs/m1/0rA
 B1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522612; x=1694127412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C//OKonAhBTdAA31WeZt4HEKfoMaq1ExT5IohWC+GEE=;
 b=B/xlwJk7FoW0eBrN6dk2S29dSb8VEjry49qIjMZBg6ElPfz2m9CyXlSQFCeqpXn01m
 1Bmii4L2iCCdQQRLqfDdDxl9MPIklzSIoFqwzf/2+Hyrqjz7QA3t/Ruee5MV6F8JEve6
 oEcYiqfsyHp5r9HiS6KVd/gWq0GyTzCBuQjuX7lloNSpUpWCB7Owmty8l/kn+k/+wZcZ
 ZXoiGsAirU7d2btK9Bf2nMvy+aFw8DH3vAmWGMaIKff1jbXJCTEYDp8wG5r/TGcniHI5
 zC0raS3ovFN7YgvOWc8BA9rocfKI9bC9KhEG+DTwRsESSo51BkA55nyxRu9/QfU+Cq0r
 IVTA==
X-Gm-Message-State: AOJu0YzTZ8MQ4F7PnRsTWj7grsn2XkNFvaiIn+N77KceUNRFQc0kMKdY
 A0S/AH5LSwfJiS3YSYF82ASlOu9NCngEXxXoHx4=
X-Google-Smtp-Source: AGHT+IExJJe9xfYPCBDQVxl437CHKPhfHDuIBzzhnctSYQd6U90cYx5OZVN8hU/ADxYmhHo9qrhALg==
X-Received: by 2002:a5d:4388:0:b0:31a:d6cf:7709 with SMTP id
 i8-20020a5d4388000000b0031ad6cf7709mr718311wrq.22.1693522612215; 
 Thu, 31 Aug 2023 15:56:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa7d5c3000000b005232ea6a330sm1345355eds.2.2023.08.31.15.56.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:56:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH 07/11] hw/arm/aspeed: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:56:02 +0200
Message-ID: <20230831225607.30829-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Fix:

  hw/arm/aspeed_ast2600.c:391:18: error: declaration shadows a local variable [-Werror,-Wshadow]
        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
                 ^
  hw/arm/aspeed_ast2600.c:283:14: note: previous declaration is here
    qemu_irq irq;
             ^
  hw/arm/aspeed_ast2600.c:416:18: error: declaration shadows a local variable [-Werror,-Wshadow]
        qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore),
                 ^
  hw/arm/aspeed_ast2600.c:283:14: note: previous declaration is here
    qemu_irq irq;
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_ast2600.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a8b3a8065a..f54063445d 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -280,7 +280,6 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     Error *err = NULL;
-    qemu_irq irq;
     g_autofree char *sram_name = NULL;
 
     /* Default boot region (SPI memory or ROMs) */
@@ -339,6 +338,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->num_cpus; i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
         DeviceState  *d   = DEVICE(&s->cpu[i]);
+        qemu_irq irq;
 
         irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
         sysbus_connect_irq(sbd, i, irq);
-- 
2.41.0


