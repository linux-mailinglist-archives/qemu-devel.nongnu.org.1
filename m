Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AABC1791B35
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:14:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCCv-0002xx-Br; Mon, 04 Sep 2023 12:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCp-0002uC-1P
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:39 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCm-0007bG-NY
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:38 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52a5c0d949eso2152127a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844015; x=1694448815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChksAbLKNbEJCfQvP2AD4Ev1dT6yyMkl8ntg7rzJ2Ek=;
 b=s+7o8NOHFY/Qvg6keK/csogYOKCRKKZD1B+QcJut41kmffiZXk6nVoh+re/ZYugg4O
 dgj7l5wMh3bop2IrjJDsMTZRHFGP6UDkRKu/mfIc+YUW8O1ISf5KEHSLZtxAhegHwQcx
 A5djzvP1JlKzsLNcMR8Pit7Ghg15W6ukSY5EOt0UNPYH+FavaWGjDeOl3S2fNti8BIg3
 4lcq3cxyzueQbo/EBpQTXjmZs9v18TlWVKIMVv6XcIY0UZajUMM20oOFs9JqWuYu8s7e
 pJneyATXa33Z75HKE/qqS4rVUw3xqHCqE54jGIu5ek9rNC1y+cGBZkVcXyW/QXrzETpX
 c/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844015; x=1694448815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ChksAbLKNbEJCfQvP2AD4Ev1dT6yyMkl8ntg7rzJ2Ek=;
 b=Lf/1aZ7djQ+uGQQGpSsoJ+KS7Vpa018QPu5PEw2I5cQndUJuEi14r1UR1P7KEY+gNo
 Y2exJSUGl91gjfB5yTELoBSqsm2caHWCV0InSoH52DsJ4iOlfcBVIovQHNX6pKjc3ANG
 KLW3f3odzUI79Y2f+8giNMwZnI4c8G+Xa5fDpDod5FT0J08jYwjQ6RFjbX54b14X+9tS
 /sLBVRQphQGz7VBK3mrgnWFPIp6sfhaTxWjQZdkOVKl2lHFa0ikbezWhbRBhHKI1DtRL
 WEKYUBvTHvVGcscVBQLNh2NVU6Y15qQ2NkO/H7h3I3VGTT0a3t5cJBAmhVuGN5bGRSeM
 s3Mw==
X-Gm-Message-State: AOJu0YxqJczPibl07oGw/IFLRUhLbO8waKJACOGNikIyLAlaCqCW5gAq
 71nPEVR4raTI7HiB7gmYGNrzzQ==
X-Google-Smtp-Source: AGHT+IHGMBJ5El3fCpU7dgbmQM45ni+P0z5x+fpFWKaECWxZ72hZdwBUgT13Z2iztiRwAOLj+CYg2w==
X-Received: by 2002:a17:906:8a76:b0:9a1:9284:11b with SMTP id
 hy22-20020a1709068a7600b009a19284011bmr7550965ejc.7.1693844014959; 
 Mon, 04 Sep 2023 09:13:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 ox29-20020a170907101d00b00992ea405a79sm6360088ejb.166.2023.09.04.09.13.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 10/22] hw/arm/aspeed: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:22 +0200
Message-ID: <20230904161235.84651-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
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


