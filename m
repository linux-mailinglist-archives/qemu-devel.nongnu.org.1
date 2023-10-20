Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 009077D1037
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpAL-0000Fd-JE; Fri, 20 Oct 2023 09:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAH-0000Es-M7
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:03:46 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAF-0005Fn-Vg
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:03:45 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9c5b313b3ffso122759566b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807020; x=1698411820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7mClc/LVpV4WxhBVsV429+V8CLaLMPjHNY4x1KwfS4=;
 b=F26q20g1TgPUCF56MHKXbOwhTHzuhOBmxQ8CZdXZhKODaqrC66aYi8bSQR0/ZFoKMT
 um4l5dcYdyr/hnuBrO30prSEW5M3u1rJSlBXzPGWvTNtjXvhuoAfFQdJjbhc9tV3GoYW
 FHQSAhTrMtRmO9W0V9GUGvFE45x4i6uJf/J4QNX56nZOgPZ3E1/72cvjB3YNmqueP35Q
 KNa6CqHNXvHY9a4tFcZD1cJ6WnZqK9RL1ccZGccxpo3atjG46KgrNUlHqOftvWxBYSch
 WYatl4vnNM06C9qSvGE473V9Gbi+rozL6hpNrIt1VSreBgMe2RhUw+WK4CwhSyQf+t0t
 j4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807020; x=1698411820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7mClc/LVpV4WxhBVsV429+V8CLaLMPjHNY4x1KwfS4=;
 b=lKA6Rd66NlEE6TOp1bSh09dvEu9johIQS44xuk/WjwZlMMC6dGvRhmDBYT6yzXR7TQ
 QthhtZExEcp5N3r8pRwYzBqinPn86z6OeEfoUpOSLIaWTizCaLQmr65G/sUw8iRn3FWM
 XoPVN+UO5hFEAeymlKH2mdqE/AbZEo6fz+5MPZfR3178iWvRTker8Ci0HHzrOu2jlHSn
 liKczUerbXds79IwmFMDjEDk2siDYPJolAjwK9BvvsEjMHLKm4SfG83Wv5Rwh5FMu9Xb
 FeBlqgmz2YVi6MbwgpfmM1t9K7vmMSImC8RT/68rZ+LOEkn8+I1djDIVbmuZaQ37ZWgn
 txUg==
X-Gm-Message-State: AOJu0YyJve+KkzpBJDDpzelk04u3UfS8tO4tyXG93F0r0o8f/ksLvcVx
 NAb5Dtt7ee+Vgf/CnCC9AnQ/D8GFiF4sD/IzurU=
X-Google-Smtp-Source: AGHT+IFpLaNaE4vz0GbwgYW6AqWqMhHqXlj83S9U6W3rmyvbjmydIjSrSmKNrTbKWh/vQu1LQZw/UA==
X-Received: by 2002:a17:907:26c9:b0:9c6:287d:c59d with SMTP id
 bp9-20020a17090726c900b009c6287dc59dmr1485002ejc.28.1697807019858; 
 Fri, 20 Oct 2023 06:03:39 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 f26-20020a170906085a00b009ad8796a6aesm1454419ejd.56.2023.10.20.06.03.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:03:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/9] hw/sd/pxa2xx: Realize sysbus device before accessing it
Date: Fri, 20 Oct 2023 15:03:22 +0200
Message-ID: <20231020130331.50048-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
References: <20231020130331.50048-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


