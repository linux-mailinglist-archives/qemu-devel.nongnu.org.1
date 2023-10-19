Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E277CF0EB
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:17:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNGe-0004nw-VP; Thu, 19 Oct 2023 03:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNGZ-0004n4-8q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:16:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNGX-00038i-BZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:16:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40651a726acso66550385e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699778; x=1698304578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+EoZC8QJYohplZssBUca1igR4l0fxuTHI687dh8zUaA=;
 b=nzjFG+hA/e77ESZnnCjeiEBKAItftXlWew6k/3xW8BoBAO+pN6ApLbAHY2Zl58V5nW
 yaxOnG3vKnoZ1LqiRSTx5hi2iW5Xojof+p/35NvL7vFQfOKPb4mOiOkQAZ5MjMIs5vIO
 rIvECmMus9y/EJ0IoKr1FtvDB0fqCGcPnuYwdPya8GvVuIiBG+9etvBeWGXLaAK7vZT2
 gsXzLfeRzEjhw+c0iRiMq6mi7Uw7/OlJA7avd3pcaJZrF6YDd2mTr6k2NAfuzBpMumdZ
 yd7r4wJW2/XElbfLleYVMPwrAtGDDRd8Ae+nUAcCCZWCbB5blFemoHmX0zGkx0ceIZat
 X/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699778; x=1698304578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+EoZC8QJYohplZssBUca1igR4l0fxuTHI687dh8zUaA=;
 b=YPoc/nNtq2lJD55HXBU1p1e1ZAc8UkyS/vyDAu3maTi5zHoTStN/uYfeO/eqyygfHz
 O2xjYJc33iBGCS/MwmwKzbUXwy6NWmJKBu27GLSU6CQRkFh7n89iw7vARJEJTUFCI3oG
 jyETWNmQW45n+3bZ6z3i2kzXFo2S3rUzFeYreDZGE294lNOSWy7BIQVpCUsNb3P/+3GX
 zXspOK4phEVt3PVDHLPyVf++YYY+gQ734cdXPMvhX1j8E9SAUK6VY7UZyU4VgKo3EUGk
 DqUzreplaRIxka3DX4T6Mtw9mkOpoGMQKqm0G58fNqJuh0zCn94NOG6ZjNLnJRaHSWjB
 vlAA==
X-Gm-Message-State: AOJu0Yy6GAHIiQBuTYJgLJfaGy1yiG+pfnLKMIp3RdClSaYaEf9lNKd0
 bCU/IFN4o1pJXfd+40KcNjIbhoF4sCRDipnRFiuJTQ==
X-Google-Smtp-Source: AGHT+IF86TUbf1XVu3YTbpCEDIkIam0X3XBKgfsRlwv1dBN2VJ7fKpVHvjultYNKTYMnA/zLyXOMrg==
X-Received: by 2002:adf:e8ca:0:b0:32d:9395:dec6 with SMTP id
 k10-20020adfe8ca000000b0032d9395dec6mr915133wrn.67.1697699778520; 
 Thu, 19 Oct 2023 00:16:18 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 n15-20020a5d4c4f000000b0032dc24ae625sm3763417wrt.12.2023.10.19.00.16.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:16:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 00/12] hw: Strengthen SysBus & QBus API
Date: Thu, 19 Oct 2023 09:15:58 +0200
Message-ID: <20231019071611.98885-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi,

This series ensure:

- qbus_new() and sysbus_init_mmio() are called *before*
  a device is realized,
- sysbus_mmio_map() is called *after* it is realized.

First we fix some abuse, then we enforce in qdev/sysbus
core code.

There is still a failure in PXA2xx:

  qemu-system-aarch64: sysbus_init_mmio(type:pxa2xx_pic) but object is realized

Apparently it cames from commit 3f6c925f37 ("Use i2c_slave_init() to
allocate the PXA (dummy) I2C slave"), which I presume was how to model
slave<->master transactions *before* I2C bus modelling.

Based-on: <20231018133059.85765-1-philmd@linaro.org>
          "hw/ppc: SysBus simplifications" [1]
Based-on: <20231018131220.84380-1-philmd@linaro.org>
          "hw/arm/pxa2xx: SysBus/QDev fixes" [2]

v1: https://lore.kernel.org/qemu-devel/20231018141151.87466-1-philmd@linaro.org/
[1] https://lore.kernel.org/qemu-devel/20231018133059.85765-1-philmd@linaro.org/
[2] https://lore.kernel.org/qemu-devel/20231018131220.84380-1-philmd@linaro.org/

Philippe Mathieu-Daudé (12):
  hw/i386/amd_iommu: Do not use SysBus API to map local MMIO region
  hw/i386/intel_iommu: Do not use SysBus API to map local MMIO region
  hw/misc/allwinner-dramc: Move sysbus_mmio_map call from init ->
    realize
  hw/misc/allwinner-dramc: Do not use SysBus API to map local MMIO
    region
  hw/pci-host/bonito: Do not use SysBus API to map local MMIO region
  hw/acpi: Realize ACPI_GED sysbus device before accessing it
  hw/arm/virt: Realize ARM_GICV2M sysbus device before accessing it
  hw/isa: Realize ISA BUS sysbus device before accessing it
  hw/s390x/css-bridge: Realize sysbus device before accessing it
  hw/qdev: Ensure parent device is not realized before adding bus
  hw/sysbus: Ensure device is not realized before adding MMIO region
  hw/sysbus: Ensure device is realized before mapping it

 hw/arm/virt.c                 |  5 ++---
 hw/core/bus.c                 |  7 +++++++
 hw/core/sysbus.c              | 13 +++++++++++++
 hw/i386/amd_iommu.c           |  5 ++---
 hw/i386/intel_iommu.c         |  5 ++---
 hw/i386/microvm.c             |  2 +-
 hw/isa/isa-bus.c              | 11 +++++++++--
 hw/loongarch/virt.c           |  2 +-
 hw/misc/allwinner-r40-dramc.c | 20 +++++++++-----------
 hw/pci-host/bonito.c          | 32 ++++++++++++++++----------------
 hw/s390x/css-bridge.c         |  7 +++----
 11 files changed, 65 insertions(+), 44 deletions(-)

-- 
2.41.0


