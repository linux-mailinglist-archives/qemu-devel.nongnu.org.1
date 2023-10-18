Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCA7CDEBE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Hc-0006Yl-Bg; Wed, 18 Oct 2023 10:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7HP-0006R4-JN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:13 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7HK-0004m0-Uw
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:10 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso1116988466b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638324; x=1698243124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehToEO0OS6e+ZoKHCVyGegzWxdjPGpE7iPcfW8fCv8Y=;
 b=PRyJI27iRVjAL4qoajKCnKH4BOcJr8fFUCpFwhYOqsvClwaQzGSUdFS3AbG9UmcezV
 wy8WSi8x2FlR4WyaqRo4IIHcxR5wkgZyr09v4tAeWx0Xvx419wULGrpxPRvgZbs3cTVr
 Z9vEaTgA0xzYzeaPNVuKR/08G98yc16/OaIMnc27KpetuJQnB65Xvh4NMN4OZHejCcLY
 KRkAHTFHOZ1rjnGaio97xvX8+vQ8vqXQSnG3fMVqPP7o9GvCEFvtVdQAA38sYP5u2zKh
 AwCjCJVQccPObSWzFiw6iGepsZMafTo7+wZWV5GdTLiREWtApDFalB1/RLHv9kNh4v0N
 F/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638324; x=1698243124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehToEO0OS6e+ZoKHCVyGegzWxdjPGpE7iPcfW8fCv8Y=;
 b=V7K1pEwUMVJxJhdK+Nl0eZ0ztaaIzxdlhIga0yi8PDH0mRMb2qrX3p9WaLVEt6XTf1
 FwlcpwUqQ8gHLlAqhDjznpfHVU1WrLTxLjGtWjYcvLSGh+sUPDs1BsiXY2Zo8I0pUOhB
 fdhL72cnpteCZS5VcKFzYlgOSRhEcQW9T9f9agZLaOc1stxB0IN+/VVOy+7TP3gvFkbA
 FWFezg3idCrXUPEtxKsNCcTGIH27RKhX6xj6tbtMdL3fYUDKX+NCtro6OSFfuvf+IMiO
 x55S4QQDLNBD1qGTfywG0UxZT2vtxyMdOAAdeDIEcrRExBmnUOa4SSzRgACPFlrcu1I7
 EPjQ==
X-Gm-Message-State: AOJu0YwBMjpkBn7SgnEwwRk27l3rXNLDv14HXWirv9rNnxasLpbGM66X
 IDck4Tt26dIhskdNh/mO1f1XUNi1jMY8m5oGFyk=
X-Google-Smtp-Source: AGHT+IGpORwcOgVOXLUgftcUBi24IzgEK2qyeNY49+UAOAtF2ov/IsicmmNY1TbupuqzQF2bRy3S5w==
X-Received: by 2002:a17:907:7ba0:b0:9bf:20e0:bfe8 with SMTP id
 ne32-20020a1709077ba000b009bf20e0bfe8mr4137350ejc.9.1697638324267; 
 Wed, 18 Oct 2023 07:12:04 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 j26-20020a170906255a00b009c503bf61c9sm1746799ejb.165.2023.10.18.07.12.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:12:03 -0700 (PDT)
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
Subject: [PATCH 01/12] hw/i386/amd_iommu: Do not use SysBus API to map local
 MMIO region
Date: Wed, 18 Oct 2023 16:11:39 +0200
Message-ID: <20231018141151.87466-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/amd_iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8d0f2f99dd..7965415b47 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1579,9 +1579,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
                           AMDVI_MMIO_SIZE);
-
-    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
-    sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
+    memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
+                                &s->mmio);
     pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
     amdvi_init(s);
 }
-- 
2.41.0


