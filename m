Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF087D581F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:25:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKCy-0000k5-Mz; Tue, 24 Oct 2023 12:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKCu-0000jS-Lx
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKCt-0000vl-35
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so34433235e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164677; x=1698769477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mMwve7k/zHxbrLWqEeZdnxp8MMBcEIAPhWDeuAu34o=;
 b=lPCWSbMoRzVF0AgMyn9nVgf+WpMupv5G92CFPEiL7lbeiWcLM6Kn8R3bLR8jyQa9UR
 n3Sa/8WyivM//93KeSWgucTGtIdxfMKfEmepURSygGieTyx9l4BRSy+/hd7Ke7qYRQ2q
 F1XJiOA1D7ZqjGCZap1E2XocgAXhl3yHoDllqHioZrLl+VBV8Ntv0u5Ll6lf2sOIabZF
 qnt9jbPw8F8+dgoeamBsg3X9hdxsue4BkG30feP4sd/WJGxdf3MZsLaT17IyWdVTW257
 7Warhhl4gEUIUStmL+wgYRFdchiyo006C4iK3Hh9nAGVt8o/XzX3GfmVuNuDzMX/ufOM
 g2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164677; x=1698769477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mMwve7k/zHxbrLWqEeZdnxp8MMBcEIAPhWDeuAu34o=;
 b=X/tXGwjquVvh0Syal+2MRopg5gARXa9GGayWxuEmTuCxlIyunhq1oDok3lP2J7ABcf
 zdAC/pjPDPbdU62Q4dxDB2dtztDIu+DKyci3LmyDqvKTqiSOpm5HHEkled3waxQFpiok
 qYXinloON8GbAXU3/nqkdkyOT+YqqXpomoOGWGo2FSEbnsjW0ZFNjhM4Qlcha4ADdDPs
 GdMByFlVEPcL7erqVr0V/i9g93bVHszYxJ8kBcTAC6+cUVF/V3HQKLGGlYUEev3L/Vcn
 VPtO7HGgpsA5s2vuX5RctVMv44qH8Y/jByhYrreAlUXk7hzORPfOApDKss0OTagQhjLy
 x9Yw==
X-Gm-Message-State: AOJu0YzpzXbYI7+BlHAJ/rg7rC9lV6QnfrICYBSiHLstkJAklgRoECWF
 4KkmzGcgvsqpYDHASCiRk3WlLUNGb6RVv8/USuU=
X-Google-Smtp-Source: AGHT+IFBqnleGgUy0hXQ8Fri8iuVnIE3EPl3vHhoQAXyPU+NO+lGqdUX78AjTBgqHBj06b2lZXBiqQ==
X-Received: by 2002:a05:600c:4ecc:b0:408:37d4:b5ba with SMTP id
 g12-20020a05600c4ecc00b0040837d4b5bamr11075260wmq.12.1698164677348; 
 Tue, 24 Oct 2023 09:24:37 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 n13-20020a05600c3b8d00b004053e9276easm17311182wms.32.2023.10.24.09.24.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:24:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/11] hw/arm/aspeed: Rename aspeed_soc_init() as AST2400/2500
 specific
Date: Tue, 24 Oct 2023 18:24:13 +0200
Message-ID: <20231024162423.40206-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_soc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index f6c2ead4ac..bb377e9e6e 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -140,7 +140,7 @@ static qemu_irq aspeed_soc_ast2400_get_irq(AspeedSoCState *s, int dev)
     return qdev_get_gpio_in(DEVICE(&s->vic), sc->irqmap[dev]);
 }
 
-static void aspeed_soc_init(Object *obj)
+static void aspeed_ast2400_soc_init(Object *obj)
 {
     AspeedSoCState *s = ASPEED_SOC(obj);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
@@ -546,7 +546,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 static const TypeInfo aspeed_soc_ast2400_type_info = {
     .name           = "ast2400-a1",
     .parent         = TYPE_ASPEED_SOC,
-    .instance_init  = aspeed_soc_init,
+    .instance_init  = aspeed_ast2400_soc_init,
     .instance_size  = sizeof(AspeedSoCState),
     .class_init     = aspeed_soc_ast2400_class_init,
 };
@@ -573,7 +573,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
 static const TypeInfo aspeed_soc_ast2500_type_info = {
     .name           = "ast2500-a1",
     .parent         = TYPE_ASPEED_SOC,
-    .instance_init  = aspeed_soc_init,
+    .instance_init  = aspeed_ast2400_soc_init,
     .instance_size  = sizeof(AspeedSoCState),
     .class_init     = aspeed_soc_ast2500_class_init,
 };
-- 
2.41.0


