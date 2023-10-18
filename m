Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7020C7CDD08
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6Mc-0007ds-BV; Wed, 18 Oct 2023 09:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Lq-00075p-AF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:46 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Lk-0000fM-WB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so1176723666b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634755; x=1698239555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJfJ06RDafLRLEOQTU58KKvhb0KtBRhLr9Bft9JesEY=;
 b=nwLHPQxcxrq0eIiAVJQcQdEJTcBjisfsAsYuM+ZewX85WmC0wdX/3bzAZGTLo9mucG
 NJzDa41pPtkflueCbvcHh/xzOWCYid6oIKuCUmWH+fxV0NtHuKn/YKprso7D6zs81pIB
 mjh4WE1vRoXLdxysBEm34RaNrVTlzL9bRtQ3IHVLlsWIW5vkuUQviNZgdTrE0nWDQN+8
 vmqZYGz7TyKrmgePGS/v+0Co5AcgBdv1dliA7/Ld640ztZ/IMYExicsQD5NvdUNYKhAx
 voc0Jdz/TTJcF/jpFcX3JOFAtzkw/5LMMsFQM3JB1Bb7YAAe/R/B2HX8PdEj2+dXsoH0
 cFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634755; x=1698239555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJfJ06RDafLRLEOQTU58KKvhb0KtBRhLr9Bft9JesEY=;
 b=kERiIwSSaDxCeKJUSQbEHGwq8p4oHDfnRn5vBinaFNglRV7VICXh4owyBzVKv8sH9j
 +ajXu6BnBVOgchg/RCQqOHBJUZmRpmYgUaVkDMlbSIrjb0AKwDpFllr86AneQWToGjHt
 GDA/e0aZ5d3GXzyIi4O6sezW+YeXfOvl1yqdA30dMjzx0TSwYTQz6HvAFmi3iPVT3dZD
 heNxdFoG+2qdvGWyXiioTz2wVtH5LgbMYc0/yd8Mg1J6nDrnoykObGKzwKDJraE/Jzbv
 tkW3LclF1pDs+md10vLbxKr250X01YOUxgCdh+P+RsuMDn/+m5jhujN5O0Jya3tDDuJt
 Omkg==
X-Gm-Message-State: AOJu0Yxdb3EVJ2r+ughy1xv4UVBYif6UJCqd6id1AWMK3ftolj6FG65c
 Xs5tCGNLdfbS1dNUyAvbr18hUbGC+pPmaPlGipo=
X-Google-Smtp-Source: AGHT+IEhye1VJhb3Hz7aHt6f4DRfkmZq7F7Sf0JcZYdaawkRznya3z7iWohlpu6DW7Pr3nnkIUnd3Q==
X-Received: by 2002:a17:906:fe4b:b0:9ae:6388:e09b with SMTP id
 wz11-20020a170906fe4b00b009ae6388e09bmr3768847ejb.40.1697634754942; 
 Wed, 18 Oct 2023 06:12:34 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 og49-20020a1709071df100b009c657110cf2sm1664374ejc.99.2023.10.18.06.12.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:12:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
Date: Wed, 18 Oct 2023 15:12:14 +0200
Message-ID: <20231018131220.84380-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018131220.84380-1-philmd@linaro.org>
References: <20231018131220.84380-1-philmd@linaro.org>
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
 hw/sd/pxa2xx_mmci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 9f7a880bac..4749e935d8 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -479,13 +479,8 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
                 qemu_irq irq, qemu_irq rx_dma, qemu_irq tx_dma)
 {
     DeviceState *dev;
-    SysBusDevice *sbd;
 
-    dev = qdev_new(TYPE_PXA2XX_MMCI);
-    sbd = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sbd, &error_fatal);
-    sysbus_mmio_map(sbd, 0, base);
-    sysbus_connect_irq(sbd, 0, irq);
+    dev = sysbus_create_simple(TYPE_PXA2XX_MMCI, base, irq);
     qdev_connect_gpio_out_named(dev, "rx-dma", 0, rx_dma);
     qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
 
-- 
2.41.0


