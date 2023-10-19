Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C432F7D0406
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:28:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaTP-0003kK-Pp; Thu, 19 Oct 2023 17:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTN-0003hx-MD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTK-0000aA-UM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so1160695e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750545; x=1698355345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8655uhkf4Iv3nGM9fMF2CltwIDAJNWHol1jKSBeCR8A=;
 b=X+UUb/6U60mLi+OG1P+nmw2Y3pBMwy6+hXg33OSoxjofgUE/R17wqSqikT5OiLzAnm
 1jRCS0VbGGXWBiVMCBmfbVmA/4NBFVPJ+cwMks6S47/UkAX58/KTsufxo3vB6p5a60tN
 1BgLc4k1wGo801pJMx8TQNPHJKc5g3F1MyXRRa6dz8i4R5VXQDxLE4OWTAYWm692mKqf
 ycIM3nkb+yaTcsOEdM4+Nt+LQgs0fprdouRXnIP/WsVPnu2/yQmXiPjvJ7u6iCA7d9dQ
 yBJL9Ccu6D9vMcyZbO3Bepju5CoB8KRx/JTa8PKc52z4jP4b89MQOziw+1gXSoJ1tDcU
 GlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750545; x=1698355345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8655uhkf4Iv3nGM9fMF2CltwIDAJNWHol1jKSBeCR8A=;
 b=SA0IGC1TuvdgcX/7rIMOFpmZMawtErB6NwyCoX9j+ofwPs8zfHnQCir2NojJJ/M8Yf
 ypv6gDrXq7Mjco0vkpTIhEC07GqIZ6dCB5hsNgmkv6NtjeGf0aNrQlHbkhP93UjU5khF
 1Q/GmqMSumXzAxTD4HXGnWhGNeYUatha+1NNzTstQjvaEyGQ95He+642aG0akjPgHOYD
 G9RSj1CwPilUHBZUkX7/F+Kv1wll8RzKxeATPg6yCsEE9I4p8DEM6vrWXklVzKrJc6mR
 D+lXeWtGpcRxQKfHGvUNEA2Egq67uDm8onoang+KvFSbWn552/PG5m2s3vRty7qvNIbg
 T/+A==
X-Gm-Message-State: AOJu0YyS28R0DA3DfHIplITJ7JaAcSQFu1rNvtw85YR0p9uJJpu8CjLa
 C+MiJwGen6OLFVQ7MbGQDZbqhXkORl6wdypRWyjFAw==
X-Google-Smtp-Source: AGHT+IEKLzPtSO2lOSxMVUz2nzHdaZKjK8aH/+1QmAN1bXQFNrTwBcSvLo+HJzVWuiRGH8a2nOFurg==
X-Received: by 2002:adf:ee06:0:b0:32d:9e48:c2ef with SMTP id
 y6-20020adfee06000000b0032d9e48c2efmr2057438wrn.44.1697750545332; 
 Thu, 19 Oct 2023 14:22:25 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a056000136b00b0032dc74c093dsm215583wrz.103.2023.10.19.14.22.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 37/46] hw/arm/virt: Realize ARM_GICV2M sysbus device before
 accessing it
Date: Thu, 19 Oct 2023 23:18:02 +0200
Message-ID: <20231019211814.30576-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

sysbus_mmio_map() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231018141151.87466-8-philmd@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02c7a7ff3c..5b08a98f07 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -690,10 +690,10 @@ static void create_v2m(VirtMachineState *vms)
     DeviceState *dev;
 
     dev = qdev_new("arm-gicv2m");
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
 
     for (i = 0; i < NUM_GICV2M_SPIS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-- 
2.41.0


