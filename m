Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495497CDEA4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:13:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7IB-00088d-Bz; Wed, 18 Oct 2023 10:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7I8-0007tq-NO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:56 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7I6-0004sO-I9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:56 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99de884ad25so1112145566b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638371; x=1698243171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkmiVBp/zutORpRQJRGohvqORFK1Jt4bFBInADm6Rqg=;
 b=KtoBNDHzjLh/xScZkQ9Q2ifN78dNENGoqdZ9k3Ii858DEwmn+Y3suyCZATcX1m304m
 rUfLwPsUiVdWufCOF4rEdk3LOWaTzJQ6CBDSvr+v+O2+HkVibNFLjqKCpaYifUiqUAxC
 o08JhLs5YW+qtXWU3YuXSL46wHb7LL0Nqf2+2MfjZaECrRk2BgVmTjvU9C+M7u+PXdYk
 gmwCq8FyUfdB2ljjVR1ehtymzHB+gb/izQfSjgtWu8oBTpVD3WLAS9s/oNLhtJJuuYcm
 tnmnY230tMSBQ6CABR6VeFXU5KyIO6+RDJu4lbYWi6xUYHGYdT+H1tAG8Cy3UFA23Y/O
 03sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638371; x=1698243171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkmiVBp/zutORpRQJRGohvqORFK1Jt4bFBInADm6Rqg=;
 b=Hzuvayl4PQeeYfxufqGxgRjPk1k7WxLgGC/TM9FBZUmpaKtIKFfr6QuxqQssBjVJHc
 bDIwCqOUDOLbO0j93cADipv+N90BPLJJdDHIII13r+Qme4mkPW1yqmQT6yu0TMdKsRTl
 CPkGDWWR0zRTyRWOzeDnjQzwmwdSAjaD2qeWY3jm86ZsWyHRE06i5MwNj84pXeq8SOm1
 CqCSLOctRHWmdhRKFcgnCz1jBcPA04sITxXPejjN2zGj1tHj+601jolul4lcwflyTFZv
 ZxJmTV/P0lWZdHdCQzZwJTsoCs7Oh4ph8MeiE0BUQ5a+2O2oc7zCfMtiF+kS00BiiDA4
 jabw==
X-Gm-Message-State: AOJu0Yz3qHAXvEA/YTJZ5jAOmEhLuhKtcTkT3kYpAYQsqbLB6hm5OT9j
 FVM3BWdtgLmxJdrreMlsrlTuVbAQdxFTpMpqEsY=
X-Google-Smtp-Source: AGHT+IEl2ckZ7vQxPuRronT67dLSdRZ06scBCTpUl9TjeFQL39UZitRWISrKRy2a6ljzgSB81ztHWQ==
X-Received: by 2002:a17:907:6ea8:b0:9bd:a063:39d2 with SMTP id
 sh40-20020a1709076ea800b009bda06339d2mr4943796ejc.16.1697638371529; 
 Wed, 18 Oct 2023 07:12:51 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 o9-20020a170906358900b009ae587ce128sm1704610ejb.216.2023.10.18.07.12.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:12:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/12] hw/arm/virt: Realize ARM_GICV2M sysbus device before
 accessing it
Date: Wed, 18 Oct 2023 16:11:45 +0200
Message-ID: <20231018141151.87466-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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


