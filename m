Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4564D7CDD06
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6MO-0007PL-QP; Wed, 18 Oct 2023 09:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Lk-00075N-Qy
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:39 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Lh-0000eh-0t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:35 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso46009641fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634749; x=1698239549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuH7XtOKs5G9Ns2H+BnAt+HjsoiLIzrJP7Sikrea0Vo=;
 b=SrSJkTYOkevL7GWhmn+UksdlmmebYoVEuuwc/4qVjplfAedN/SrDBvnNvee/v8vT4H
 ujqxKqDUfDXjgu+7zT6y8HyCMyr5vdGcDu89V/C8Zg60x7QeeFehfct5l10+SokgFsE3
 hUA2eJ9j7IK+Y6T3HVYeUAMOk+Dvaz+HLHyHxsnkJYPHIol0Thq6g7DSw4lwOdmJgafp
 Ey/ID04u2Re5GcQ2qTdegqtyV7sOp3dgn6fCfTcT4LGDFn1SCM8SqzFe8/EJM/KfEgAA
 qcxj6UokGAMjMzDGqqX+apre3Cv/m+pqo9/JxBDOF/dMrAAIxxXISoHifUHx7ToJBWXT
 KS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634749; x=1698239549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuH7XtOKs5G9Ns2H+BnAt+HjsoiLIzrJP7Sikrea0Vo=;
 b=d6jv8nkP5erkKIfzW9CY5sP7V4yr32IXzy94ZXaCKPL7ka70s1teL6ygE6l/tO32YF
 NT1jDSTpaHGqfyL8eRp9T9uttMFJak8kpB0xGhTzUZodcT9eEgUpLjXiOoK0wpfqYHvr
 aWblVjGIAWyaECBpx7sD4q2GU3tWN5R7kt5ND8dZnFG3a6QVPdvMpAxTYtg94Qj7xD1n
 yfB8+6+hl+5QPGEw9F4T+G9Da7+AAkXPTvnml4PfQGrRh9IrvVL9rxLaoKVG1RYAkccc
 YLloAiJCnOwQac+ZGbQOMAy64SlP0B0YhHstizspndav5712rmWEkm8XfTvkIq/WQT4r
 tjxg==
X-Gm-Message-State: AOJu0YyV8eBLu4D+c9dG5UoSvf2W0IHz/BQcnUTn74BaWo4n+IO8gZQB
 NhfFZURZucqbJxf0MupgEXtKyAr1Dm6KxdpPMfM=
X-Google-Smtp-Source: AGHT+IHLPxsD0sCBOFgs9a222m+CPiKUuLKlMJozJW90w1t4MDN0n0qh0oWAR1/30qtstysx+luFhA==
X-Received: by 2002:ac2:4d86:0:b0:500:d970:6541 with SMTP id
 g6-20020ac24d86000000b00500d9706541mr3793512lfe.39.1697634749089; 
 Wed, 18 Oct 2023 06:12:29 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 b42-20020a509f2d000000b0053e43492ef1sm2855045edf.65.2023.10.18.06.12.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:12:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] hw/sd/pxa2xx: Realize sysbus device before accessing it
Date: Wed, 18 Oct 2023 15:12:13 +0200
Message-ID: <20231018131220.84380-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018131220.84380-1-philmd@linaro.org>
References: <20231018131220.84380-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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


