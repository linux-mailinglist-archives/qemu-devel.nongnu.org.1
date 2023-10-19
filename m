Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A897CF0E5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:17:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNGk-0004ps-Bi; Thu, 19 Oct 2023 03:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNGh-0004pL-Ak
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:16:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNGf-00039b-OT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:16:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso10557825e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699788; x=1698304588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOvC+JkvU7gWETYwa7wI+/RczFUNZ/p1uyKYV90ynnc=;
 b=FX42EUgYGnz64T4a6ETBEonvlxQ+wSJEokfTz2/Ct03NP74jOP04yLpc0Vqi9x8RVg
 GJAcR6izmRcWU+h8ApoN9KvziRmhi47x18Uiso75cXAt+1VqYydGu2b17Q6GB9Letp/O
 8AxOyTVrOsAuTvAp+FHRF/IbWMfFWNkS10mGPtlJF3N3CDWqpkBqmRGZ5nwoYQBqW08m
 N9io0GOvDGB2bJ7YhqiT/urbPMiyW72zLO3nQWFxA/b7dkecNbbI4o6WswephuEBBNqe
 v0SFiR2cQc1/BkdeUZdpX1ryn7rgiAEzK73O5tVvtv/Zl2VpNvv/7PbSrjMTGtj2/pDL
 V4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699788; x=1698304588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOvC+JkvU7gWETYwa7wI+/RczFUNZ/p1uyKYV90ynnc=;
 b=dYRLrCUp6qph+dnVNhClV3iqhE7w2h5yKHiF0lR7DWz9EYwHvvsH7ACv/tock2rRh3
 eiseQ/8+lKJEpIBHsVk7i0xUOL5EqSKIZSNeCQeU1oVJSXr8KnYLD7ckwEYSy1FMD1H1
 V0Qon+gzoIgbyFKj4hhOJzk/a9sVrfvM9s4PQzSMCtn4/uriC87eTzaXWdNzX0jGPGMO
 l/XsdllnfpdCjjJunaV8e72IUT6lg5ow/xY19GR1LU+pO5D7lEgax+ZCsWqPPTeJtsIZ
 343pcCyQ1wf+SCbqMAxMo7rUI6RmWK3OgucG8BjuQISPVP0yXxLXJvCddp4Az8os6Agn
 Nu9Q==
X-Gm-Message-State: AOJu0YzcagEBwWMxo4m+CtwL8sdW7C19QYXKzEkwEG/qPVw4uDSdgr1I
 FENUgrGLldADeHt0J7EwLn7ZbVCOGQRKgH0cn6MYvQ==
X-Google-Smtp-Source: AGHT+IE18ZMdzK+JVmE9u4qq1be+E0MHtStE9Zinp/YaKTYKz2xARZ5x7ooF8oLui45pFY713988Bw==
X-Received: by 2002:a05:600c:358b:b0:403:cc79:44f3 with SMTP id
 p11-20020a05600c358b00b00403cc7944f3mr1168643wmq.19.1697699788230; 
 Thu, 19 Oct 2023 00:16:28 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c315300b004064741f855sm3609993wmo.47.2023.10.19.00.16.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:16:27 -0700 (PDT)
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
Subject: [PATCH v2 01/12] hw/i386/amd_iommu: Do not use SysBus API to map
 local MMIO region
Date: Thu, 19 Oct 2023 09:15:59 +0200
Message-ID: <20231019071611.98885-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


