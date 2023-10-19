Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAC7CF0E4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNGv-0004s3-0J; Thu, 19 Oct 2023 03:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNGt-0004rZ-25
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:16:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNGq-0003Ao-Do
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:16:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32db8924201so3002238f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699799; x=1698304599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31IMAee+VZo6+j+lZFd22FV62NKoWHWg3TvBlA119f8=;
 b=JiiiZJX2Ul0XFeys+tTH56OyMyqLueNy/2tqHDb0lNtj0AWpJiGsUTR1k3CXGVtbwV
 UUbQDwMxmtDknDnLBgaWXp+ByJ3RM3C750Bp1pFu1oWWbvmgrCGLxfCi4KmvaOam3iGK
 bsI8rxL/6a9kSuTNyCNY9eYarRW038iqRyfFn2Kq/cT+tYsaz5Iqkphu0yiG22EmyM8+
 hWs9p8Sio9fur8zvbrEEP0rIMc6V/GytAkHJZuJMK5nbWgGP9eP0twgyigFWKjxgmvcY
 c1Vpxcai1SPM825bZO94Dk58PbbWiIG4wW128/oAXEVh/+E5sOAby8BN/sl5R5KLtAw3
 CHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699799; x=1698304599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31IMAee+VZo6+j+lZFd22FV62NKoWHWg3TvBlA119f8=;
 b=d4oGaHtqChv+kHwLp3oxkN3KenJ6Vb0kTMn+jqGWucAyoWhve8c2u6xnjghQR4udK9
 /dsKsGwVlq2GM2B/mI+EfMkO8oW668jUby/KTDcP4jQLl6VB6in7xmRQcEBhEg1psO14
 3E1wjQBXQyu3hA8GIKTQgXXMftBEc1uwlkS6ze86/uUhOmPSEYsvrJCew4cuTlQQ5HLP
 RVrlGpooQJ1Do+hyaw1+uGN5B2ki/VnwVKIouHrBwm+DsNFqb8S/3jKodzonTfTLkavE
 1HOL8pkU8G/a/6cVllK3Ht5Re+6QxLeIz+ru0Sm3WGpweU9O0FSFTa9UdEFzAf+jQ5xJ
 WGRg==
X-Gm-Message-State: AOJu0Yzk4W+gHfUpWy+XtISNRdX9rrU/EOfY2LEZp2kIBcQZzEaUuM0W
 yFlFmW268JccaU87POsUiEfP+bizFCQdIiOwkW+AzA==
X-Google-Smtp-Source: AGHT+IERqn/NQbTCifCYHB+iHBMzjhsCdd2ivdaD+3JecOOUjmqJGhXWHNvC+P8/U9mRQygROC4n1g==
X-Received: by 2002:adf:f682:0:b0:32d:8cfd:5780 with SMTP id
 v2-20020adff682000000b0032d8cfd5780mr918954wrp.27.1697699798766; 
 Thu, 19 Oct 2023 00:16:38 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 i3-20020a5d6303000000b0032db4e660d9sm3755308wru.56.2023.10.19.00.16.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:16:38 -0700 (PDT)
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
Subject: [PATCH v2 02/12] hw/i386/intel_iommu: Do not use SysBus API to map
 local MMIO region
Date: Thu, 19 Oct 2023 09:16:00 +0200
Message-ID: <20231019071611.98885-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Transformation done using the following coccinelle script:

  @@
  expression sbdev;
  expression index;
  expression addr;
  expression subregion;
  @@
  -    sysbus_init_mmio(sbdev, subregion);
       ... when != sbdev
  -    sysbus_mmio_map(sbdev, index, addr);
  +    memory_region_add_subregion(get_system_memory(), addr, subregion);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2c832ab68b..e4f6cedcb1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4134,6 +4134,8 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     qemu_mutex_init(&s->iommu_lock);
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
                           "intel_iommu", DMAR_REG_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                Q35_HOST_BRIDGE_IOMMU_ADDR, &s->csrmem);
 
     /* Create the shared memory regions by all devices */
     memory_region_init(&s->mr_nodmar, OBJECT(s), "vtd-nodmar",
@@ -4148,15 +4150,12 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_nodmar,
                                         VTD_INTERRUPT_ADDR_FIRST,
                                         &s->mr_ir, 1);
-
-    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->csrmem);
     /* No corresponding destroy */
     s->iotlb = g_hash_table_new_full(vtd_iotlb_hash, vtd_iotlb_equal,
                                      g_free, g_free);
     s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
                                       g_free, g_free);
     vtd_init(s);
-    sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
     pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
-- 
2.41.0


