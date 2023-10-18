Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98A7CDEC7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Hh-0006df-VN; Wed, 18 Oct 2023 10:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7HV-0006UV-5F
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:20 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7HS-0004mc-9O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:16 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso5435337a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638332; x=1698243132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poPJ+bMANM3F4WTSkIKk7d4BzsQMnyYxPL7gQ+lwFeU=;
 b=zLjopPIifT36n5nFcapJFlzMHhgOBP48e2+Z1PZ1IRk1VkflpRd8BDmz5eX4sROu2+
 4nhc173G/9+XDDFxdJjCmIzCZNQAI8sWcs1ssahUHT0l1TuVGDZomK9odYRyj27Gbe7U
 kp2yIJeC3pzNMyJRr3LxdSfnmh3fwH3Gq4GZqaukisUekN3RIR/LtEEvGUVWxHxh7EqN
 8KY92s8K/CI6wXAO1MvVE1fZpO9QyGaMvDbriBfEwVy0BPgxLJ+6VeyV/YM/QXu2PAJ9
 hMWn55cbBTvoe8xQtWEWqgLCdeu1M1n1i4a4nuPMtcvHww+lL0g85Sy6EahmlnMbKzhf
 aHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638332; x=1698243132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poPJ+bMANM3F4WTSkIKk7d4BzsQMnyYxPL7gQ+lwFeU=;
 b=s/qhq7OvFRZQnmvKuSZhwfmcqcUnAhMUT6y/16wN/18/eefoZRiRVV6f9PtwjSKS5P
 22UNrfxhXEHNkpVb6ZWpkbwyMyckZb2r7AFt0KDjKRtnC3d2NHHLOxL2MoxuN3PvWERO
 e03r4WU9qgxQKjflVNQH6KjnQaolK/4oigPrS/l5wZF0prNs8aHR5UmlciiEEFi1Mjhc
 pRFlkeIKHeTPTqWrGISSdePN7d2sAXmk2l0XTLGHYV1S9fw8nF3mX+Cs8f5p+J2Ulhfv
 m9qZHoCcJX801Q78h1MA0p9TVumujctQphUxRde4VOe07PJsvLxKxiiX9O7vj66WvtFU
 O/Kg==
X-Gm-Message-State: AOJu0YxQDiLthAT5DZJlIf4vzdZYKmuB7eCliBSuKFHA77ziPwkUah4k
 ea160/ZAGs2n3fH7jgNTCOHOD1vd5i9innl1iHM=
X-Google-Smtp-Source: AGHT+IGvRzK7AZsaMO1eaXzPeJ2zNokdr1fKTMPDzyT94moeXuisZIt1dwQdij9y/I7hth++zfyYOw==
X-Received: by 2002:a17:906:c105:b0:9be:aebc:d479 with SMTP id
 do5-20020a170906c10500b009beaebcd479mr4429521ejc.19.1697638332227; 
 Wed, 18 Oct 2023 07:12:12 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 jt24-20020a170906dfd800b009b9977867fbsm1748529ejc.109.2023.10.18.07.12.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:12:11 -0700 (PDT)
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
Subject: [PATCH 02/12] hw/i386/intel_iommu: Do not use SysBus API to map local
 MMIO region
Date: Wed, 18 Oct 2023 16:11:40 +0200
Message-ID: <20231018141151.87466-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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


