Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E167C5D54
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 21:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeRU-0001Lx-9H; Wed, 11 Oct 2023 15:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeRP-0001JP-IV
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:19 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeRN-00072C-Vf
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:19 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso25323766b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697050815; x=1697655615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUM2nwqmw9SH+qUH3W/mCq9cH7GldJMBYoc4FaiK2EI=;
 b=Kzt3Hue5txekYjomGbQk3KWl5DpJR5rnn+/NwyOdoGIiHwUJJx+RzbPdu8L4EcGBzp
 TXp2CuANuU2VQ1FIU2/qOFo3q5NqvCQG0K8e2y6miaekRmBCEWqkkC4f12LLHndHbuV6
 k7GfM9qk2TOOiwBSeke/HsfJqdAerzrSl5tZRMUBQzMH9Pb14xEQL3Y55Nd7nhEPdWl3
 nQEPxAKbn4N6ccJLa2zBp7iCb0DVPpWUsF4zPAvkmGc0w6mNF0slxcRpnynvl2jXVeHJ
 UwwW5cn0X/m2K2SV5bOiiz5asfoOdS4Frl7kHZ2qkGqQjKYzu7yidf164Yj4SKKqnhMW
 4ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697050815; x=1697655615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUM2nwqmw9SH+qUH3W/mCq9cH7GldJMBYoc4FaiK2EI=;
 b=klIldHvPf0nnzZAYPtwHfg+JAr39eFjY+uyHVcNs/O6RM/uw6S6rzlB8mVTdR2Sty8
 Q3jmI2mAlyHqRJa4U/3Bx9aVl59Mlx8BTF2cYihe7yFyoKSmAOeUAI3G7rpMMuaXe5lt
 lybOZNz8O4el2Pexj6QO0GakYZhQ8j7NJXscVdI29TvrP5PPK0aSk2VRzsN4Q3pI52ga
 mGG+qCaJixcPal/hHs9X3VD18QoFZxjPjI2tefrIGsDRj5xHjIwA9bp6BVciwo6hejw8
 w7XJalxLFK85q9TuAar9pnigRuYI9v45bf3NLoruNy6mQxYnewFdNP1dbBFC/4/IQI8n
 SMlA==
X-Gm-Message-State: AOJu0YxL+ZUi5ymU5K+pnS7vfl3V/TCtzCiqmsTXzweMsuz76BDPet72
 dO3SSU+e43I/1Ub1U0U5yWo0/iqaBz0Cdo8iGhY=
X-Google-Smtp-Source: AGHT+IF7Hu2EJon3elCx7JE8lFoYAuGWHznqhIiuXP4TTVfpkd9tyUIKBPTn+3ryqo9T+i4z0cF0vw==
X-Received: by 2002:a17:907:77c9:b0:9b2:6d09:847c with SMTP id
 kz9-20020a17090777c900b009b26d09847cmr17990861ejc.10.1697050814822; 
 Wed, 11 Oct 2023 12:00:14 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 dx12-20020a170906a84c00b009b977bea1dcsm10105270ejb.23.2023.10.11.12.00.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 12:00:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/4] hw/pci-host/bonito: Access memory regions via
 pci_address_space[_io]()
Date: Wed, 11 Oct 2023 20:59:53 +0200
Message-ID: <20231011185954.10337-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185954.10337-1-philmd@linaro.org>
References: <20231011185954.10337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

PCI functions are plugged on a PCI bus. They can only access
external memory regions via the bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/bonito.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ee6cb85e97..50bde57862 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -700,14 +700,14 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
 
     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
-                             get_system_io(), 0, BONITO_PCIIO_SIZE);
+                             pci_address_space_io(dev), 0, BONITO_PCIIO_SIZE);
     sysbus_init_mmio(sysbus, &s->bonito_pciio);
     sysbus_mmio_map(sysbus, 5, BONITO_PCIIO_BASE);
 
     /* add pci local io mapping */
 
     memory_region_init_alias(&s->bonito_localio, OBJECT(s), "IOCS[0]",
-                             get_system_io(), 0, 256 * KiB);
+                             pci_address_space_io(dev), 0, 256 * KiB);
     sysbus_init_mmio(sysbus, &s->bonito_localio);
     sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
     create_unimplemented_device("IOCS[1]", BONITO_DEV_BASE + 1 * 256 * KiB,
@@ -719,7 +719,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
-    memory_region_add_subregion(get_system_memory(),
+    memory_region_add_subregion(pci_address_space(dev),
                                 BONITO_PCIHI_BASE, pcimem_alias);
     create_unimplemented_device("PCI_2",
                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE,
-- 
2.41.0


