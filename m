Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F0A7D9BED
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:45:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0s-0000aP-Mt; Fri, 27 Oct 2023 10:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0J-0007Lh-PE
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0E-0008AP-HO
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso1389366f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417595; x=1699022395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7L+ZM2Ew3INynFGy53+roTgbFE4u6NxZeR9zzUy5oKQ=;
 b=lIzPy6tNEp7MFZB7PUr3MyJtYkQppuN/Bckrdql5Ln8lTxp/vpuV32+MY0B9LRwRxS
 PfZggdqShXiue/axLzq+kUXXT8T5YKertTXGskebjEOCTEF5fgsSRFe0szN3sDhHVBqR
 ehjpJaz3cvfI4bbwAYE79xkSG1D2PbBC64KG94cmReReTtziR4fnYxgouA4XoRiLKE2s
 epSRYYgg2HAW/Qxi7fm5URAC/pNH4BsCtgdDIMDPaaB3mJq4cRKbtcdEnkXPANM72lXi
 7SOgUdmXzrc4vbcTx5z3oFdJZWa6c3CwRmm0UlFzRR5xNnt4NLEuHb8suQKbT+sP3ivw
 HYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417595; x=1699022395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7L+ZM2Ew3INynFGy53+roTgbFE4u6NxZeR9zzUy5oKQ=;
 b=ocnq0BNfdJfrveJV/4oi5PsWDrPfN7WfSVinYTuADrxXtZtCfYf+qCdW7mqoyPRl7I
 I1F0ldwoT6Pb9lSSJuOjIS5cJ2uft1diBX4j9vrgNQxmo1db0CUTGoKcEWtawzXFUu8C
 eGcYWbxg2Zxkre7OIh3xh5IenMTo/zRAJBbBEqzJM5I0A6M+439jDVTfY3sFMBQQbg0F
 6jyHALF0V+MYye5JaujnpLaw0iQHGsJHwy2oyAn6p9zBbbVmNBsbDRdb9XCQVU+GeuOx
 ZEbhtvcmsoM51OCNCpJB/e6sHPMateETatieG7Cv+MPafoYKaTcNVVtB4CsifrIkxQ4f
 3yhA==
X-Gm-Message-State: AOJu0Yx8RIVuy9WvZOGIoDgFLWfzybL42d8KNGVNaYNwJHDcabVosd9I
 y8EDgeORtqMmTUhJg2btFklnSkvVUSXEJTUj+cU=
X-Google-Smtp-Source: AGHT+IHbVyX3ChRAXk47KcG161lh8lAJJreK7bcS/ti/zKWTYqE/DOpBq8Xx51y/nUhzp6HNIR1g/A==
X-Received: by 2002:a5d:64a4:0:b0:320:bae:2dfd with SMTP id
 m4-20020a5d64a4000000b003200bae2dfdmr2907123wrp.5.1698417595037; 
 Fri, 27 Oct 2023 07:39:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/41] hw/pcmcia/pxa2xx: Do not open-code sysbus_create_simple()
Date: Fri, 27 Oct 2023 15:39:24 +0100
Message-Id: <20231027143942.3413881-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231020130331.50048-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pcmcia/pxa2xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index e7264feb455..3d512a292c7 100644
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
2.34.1


