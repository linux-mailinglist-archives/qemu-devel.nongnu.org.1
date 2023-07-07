Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C974B03D
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiI-0005bQ-KC; Fri, 07 Jul 2023 07:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiG-0005SI-Ub; Fri, 07 Jul 2023 07:33:25 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiE-0006uM-82; Fri, 07 Jul 2023 07:33:24 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b7279544edso1634889a34.0; 
 Fri, 07 Jul 2023 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729601; x=1691321601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aQ2B48MSVuShsJB7TdgBSeU+Iv0Ihx+0Llen/M1Dcg=;
 b=gOS2hSBpcRVQX2/YVEZ9EFgaz4m8JBygdxQfrNoX9wUsPP0CHwVXVZGenifqKGnF0o
 ldmjYuyWZwcmeI5cfOoTRFSsGeZDx+bPdzfN7IfW4qBNAOzSgF1AJhEqdhNEavvdvnq9
 7mm7gq/o1FoOgVrIjzIfTA/PWwPSPcXjjtqWVwld1Q4smAYXm5D6CNDP9j7HWSQZqF8a
 0GK/EG//HUp1/0EA+zvE76azhMlwbUecpok+q/lATe5yVFe8r+QauBq5t29MVpS3/fdh
 kevG7JZEKOdtgjceqPrnQrY5CwZRJ0kd1AyqWq58gJWOMFq5SR0Fx9bgnh9APqrvHlNQ
 weYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729601; x=1691321601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aQ2B48MSVuShsJB7TdgBSeU+Iv0Ihx+0Llen/M1Dcg=;
 b=hHcTfRRdvj5ztWl0CiSm+SUDfUeT4vK+rmaml8joChHmV3LktpI4jHWwVvZD5hs4+8
 GxZgYTOWuxwctZAmxPQfHGjePrRWZTGRfZQUIJnUUC/TONVlbkksDtt2sYNoHRJjOyh2
 S09Bxjq8G+vc6puZZ/zWEzGXCtGpIaHC8kRqiSJwnstDhs9dgxKlPUlNtSaHnOMqFqAC
 2Raolnm6kTKpTujD34/wWxKtVHjN/bGmAyf69bU3JCZncmO9KnOAh79nN0EpiNUhesLp
 e7NlQs69LafoVWFhd7Wikvyk7hqekbqyZlU+4ssQ/NZKBTz5J81sCUOoVPBTJCJ5PQvy
 psYw==
X-Gm-Message-State: ABy/qLajpXHpVE2IFDsGmBgX2DAvTYUHNCq91VxZLDOmKTgnb2ccocvK
 PfE0ElRgVyfnXLy0ll0d73w9zb9RXrY=
X-Google-Smtp-Source: APBJJlGrWQHXNKpjGa4l+dvD0xgSYhlsfi35xSY88N7AXP3UoJQOlWGp71zGWzCEO0PQCB5D6JijSA==
X-Received: by 2002:a9d:7c8f:0:b0:6b7:e9ad:db90 with SMTP id
 q15-20020a9d7c8f000000b006b7e9addb90mr4781383otn.11.1688729600756; 
 Fri, 07 Jul 2023 04:33:20 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:20 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 47/60] ppc4xx_pci: Add define for ppc4xx-host-bridge type name
Date: Fri,  7 Jul 2023 08:30:55 -0300
Message-ID: <20230707113108.7145-48-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add a QOM type name define for ppc4xx-host-bridge in the common header
and replace direct use of the string name with the constant.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <f6e2956b3a09ee481b970ef7873b374c846ba0a8.1688641673.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_pcix.c    | 3 ++-
 hw/ppc/ppc4xx_pci.c     | 4 ++--
 include/hw/ppc/ppc4xx.h | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 54286cfef4..9321ca0abd 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -498,7 +498,8 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
                          ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
                          PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
 
-    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-bridge");
+    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
+                               TYPE_PPC4xx_HOST_BRIDGE);
 
     memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index fbdf8266d8..6652119008 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -333,7 +333,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
                               TYPE_PCI_BUS);
     h->bus = b;
 
-    pci_create_simple(b, 0, "ppc4xx-host-bridge");
+    pci_create_simple(b, 0, TYPE_PPC4xx_HOST_BRIDGE);
 
     /* XXX split into 2 memory regions, one for config space, one for regs */
     memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
@@ -367,7 +367,7 @@ static void ppc4xx_host_bridge_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ppc4xx_host_bridge_info = {
-    .name          = "ppc4xx-host-bridge",
+    .name          = TYPE_PPC4xx_HOST_BRIDGE,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = ppc4xx_host_bridge_class_init,
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index e053b9751b..766d575e86 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -29,6 +29,7 @@
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 
+#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
 #define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
 #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 
-- 
2.41.0


