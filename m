Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9807D1038
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpAm-0000Q0-L6; Fri, 20 Oct 2023 09:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAM-0000H4-LL
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:03:50 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAK-0005I5-M8
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:03:50 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so177212166b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807026; x=1698411826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkM/85hWmZ9SV/FNcYSH0O2+Ai96FulzN3LwQBfEAtk=;
 b=fz0NQGU9471iYg4GO3VbOIPLGT9uobXl9GyUpEDQYX6fPwUXO9wWJx5rHb9iIZj2/a
 7t8L+KCAhofo0UmDlkanyNd6JhZxUM6ag+rrYfivzUpSwrPz4vF7jiCQMhPIhbmnMMc9
 lSlvHUkKPmQGt/1ditwzusqn363BvpA1aiKv1xH5ZUskJJ/DwBL474XZ4l5Qxj+Kk0qF
 a3/G4Em1s9p/s4A7Nd7MgWHyF+7xWJRsQ+RQyWJ9mbQwOaK4WScHBy30MKF1B7hFZos3
 YmKBcogPNcUJl7RZK8nns6di5Z5G0Jko2I1siSeevHn9suBhC4FsdsjWbzJgwI7y0P71
 5ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807026; x=1698411826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkM/85hWmZ9SV/FNcYSH0O2+Ai96FulzN3LwQBfEAtk=;
 b=PT8DnIn/w4tNdl02eqsRaK8Kj1gvB8gGLzP8KYTbArP3CTHrzhr+/7oE/y+7Hu4Qv7
 l3xqkWQHNJ3N3NEJhhqV/vdaV+m1Y+/F2oRY1lVgDp5hRgscKZAso2zei5Ny44zWCwVQ
 4MuHi7DNB2HDS5+bUrNpbHu2a9XDRTpQjxYK53iZfspp1ijdnKzIQzo1zQ/Y3Nrjf/oL
 tl+VNZRZfCdtVOTzqFBxmkJZcmVOPhHuwHk+V7aVjTI/a9VG8OhdvqndXa6EditCNa3L
 RoCmRZ8mDmsJLH0VOADJvipv3d5E7F2KpLooizddgpmIs9GE0OYltJrqGa3k2jbCc42L
 25Cw==
X-Gm-Message-State: AOJu0YzOS0LRy5bwsqv3NCOOgOmRZkFeocP+gHfr4khTNHlo8BDxrkKt
 ZQabrYtS1A80b7eRA7ny4nN82rrbnZnmXb4W40I=
X-Google-Smtp-Source: AGHT+IF4lpq7yj1LfgbMnKPc7grhVqGQH88JdhNtSSjJtDx7+CE7PtarxBggqZyVezhvLox6h7p6fw==
X-Received: by 2002:a17:907:868f:b0:9ad:e3fd:d46c with SMTP id
 qa15-20020a170907868f00b009ade3fdd46cmr4254879ejc.10.1697807025923; 
 Fri, 20 Oct 2023 06:03:45 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 lg15-20020a170906f88f00b009ae587ce135sm1452393ejb.223.2023.10.20.06.03.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:03:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/9] hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
Date: Fri, 20 Oct 2023 15:03:23 +0200
Message-ID: <20231020130331.50048-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
References: <20231020130331.50048-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


