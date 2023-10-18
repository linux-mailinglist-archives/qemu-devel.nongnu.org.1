Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB97CDE96
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7He-0006aO-7l; Wed, 18 Oct 2023 10:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7HF-0006KZ-Js
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:07 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7HC-0004l9-Vo
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso1116959566b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638316; x=1698243116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rdrrCecaS7boB6xf2s60//LTwDBNeqBEOJ0/YhcfJ5Q=;
 b=bc55sAcyHN+VTrjyis1Os3lSJXSEIUOQBzwvgWfd9fHuekyUU0qrrMt4OOA2kgOgFq
 TqKxYcAA+OOk02pk9BYuMHNjI76Unslx8QKqqUn8twZTPmH5Mb5bDCS+uHMqCoZXOQ+E
 o+g9eIp5bfK0J++GWxKObyh/ck6pXmK3XppU+Z4ExQIgLrCALqsRYZqGR08pfnkHfJRr
 6ZH/II0tTYt9PYp4IGb80fn/G+Rr1VdXQpojZRetbg936VQc/bUlqBhewBNSL2zBBNXG
 4tuky38fyS5l8NeZK14ribZ3unhhU/7o5GaRd6hQDH1f9IMFTXz4izyzYagIpzgT12Xp
 9dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638316; x=1698243116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdrrCecaS7boB6xf2s60//LTwDBNeqBEOJ0/YhcfJ5Q=;
 b=GE+mLhqrCX2pcPat9Th4pH1Qn4Nz9qDwQIgw5gxvTuOHRS2q6oKKqV3lf2texcIw1v
 1/ddf5Q8Q76wwC2LbFUKlNxDmvb+tg9DFw2JfFGU7+d5ltom5/c5SJFJvw4AavNIhrtb
 infOIVOcfH1rsgnkhGlxpU1UZpolw08jqQzqwn+JWLqqPAVy92slOC4yOzytugz+U0/P
 ojWEPc2jkAhh9fLRKmNcGgcWB1nFnivYqP2/gj9I7I5LXTUL0M6OnQfOaqVKFbeY6Ijs
 FkxZCi0sjApS7sl81A4dr/pvO7L4YDOEHndW5/XVtB8F4Rhu0t8N+CLuD4917bM7zW1Z
 B00w==
X-Gm-Message-State: AOJu0YzkSdR0UO6togc8bhsBMhYd8TcqnE6h2+93EagNnjCuTVjJFLKw
 LBLXFStYcEU5HH/mzv+tnXy2qqob6AkQekMW9XM=
X-Google-Smtp-Source: AGHT+IH9PIIQgqxRseZliD9eF1h6dT1xsu7v//KgxEYBqKC2avc/nGnbIjt35/zk2d2It3vTUHIwvg==
X-Received: by 2002:a17:907:97c3:b0:9c5:8a6b:29e with SMTP id
 js3-20020a17090797c300b009c58a6b029emr4392025ejc.13.1697638316266; 
 Wed, 18 Oct 2023 07:11:56 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 jt24-20020a170906dfd800b009b9977867fbsm1747995ejc.109.2023.10.18.07.11.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:11:55 -0700 (PDT)
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
Subject: [PATCH 00/12] hw: Strengthen SysBus & QBus API
Date: Wed, 18 Oct 2023 16:11:38 +0200
Message-ID: <20231018141151.87466-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Hi,

This series ensure:

- qbus_new() and sysbus_init_mmio() are called *before*
  a device is realized,
- sysbus_mmio_map() is called *after* it is realized.

First we fix some abuse, then we enforce in qdev/sysbus
core code.

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
 hw/pci-host/bonito.c          | 29 ++++++++++++++---------------
 hw/s390x/css-bridge.c         |  7 +++----
 11 files changed, 63 insertions(+), 43 deletions(-)

-- 
2.41.0


