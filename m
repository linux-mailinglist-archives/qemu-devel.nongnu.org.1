Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6866D72B16C
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:36:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IP0-0006Rw-Ho; Sun, 11 Jun 2023 06:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOy-0006R7-4B
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:28 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOw-0008IH-IN
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:27 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5183101690cso1609835a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479665; x=1689071665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tt10HuR+62JCOV6v9nG6fmfAatbw2ckxOQLUUV+0Yac=;
 b=dL6hlIz/faHLjHILy/B6iG7ZiEOLaQ21vcITkRY+SK2bCLYMLajlhiwyn1Jpro5uXM
 YC2F92FGt/UrZQNHeib+55/SNwfr0x5PN2G2TynYjUoAAPEDL3QTVUABlHgPGUBzOMhO
 0VDwhmlSbzS1HV/19NpkfGXPZdDhFWOxUuvW21jmKmNWacqIj2HUmhRPnqM2F13Cem15
 UuwLjorsNEVgoEYexesBr4KPNlx8XU1gNkXszMcuhkTxgpuyUFOXxGHV7tp/CZSSwTsR
 vEPSWFb5UxZWsN8E4IIvVRipcePeP8IIrSDBBOiZjpvinJLTxAP1Wkm9w/UY5SFAtrIE
 +BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479665; x=1689071665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tt10HuR+62JCOV6v9nG6fmfAatbw2ckxOQLUUV+0Yac=;
 b=D1f5COBIXww+6mjIHH7BOwYD1zURBQEo+9u1XYziCBMhb2K4Av+EoPseAB26fG/2oX
 7sezYZlTq2MEsyz3ljZW9yJXl+oYkcmi7kuePhGwPpBACKKxJ/FTESe4isn8uU6rGXIc
 bxTMvLC8mD/NygmXrTi/YA4m+l7W5hEQo/FS/rRT6d7A06Af4UkTJ5L4/sQenoZBR1c1
 8vLQTQ+AUiUasbAYUBIK2hc3hPoSrIU/EStoxAstfc7J9pHxsjQLjzux8F9tLge6RCH9
 8zlmp1h6riDIaSKCRfwAU9C+On/XxfmgRHrb8q5TXzkUCuzrlGYwWu5QrZUGU/K+hhrO
 KoLA==
X-Gm-Message-State: AC+VfDzvnuesWBk0TsfoCSoXEAHaH02H7k7l2caozovfjwLW6N8ivFfM
 R+WAbRg6mXmDuV2k4EC3smBjvZrfvao=
X-Google-Smtp-Source: ACHHUZ4W2m2R4q5JDvcCVh3en+LA+nrWiM7GA8QgcAvCzhtJdRb/Buz1Lw2EhHvSCidd4cWcNsIqSA==
X-Received: by 2002:a17:907:7253:b0:96f:9cea:a34d with SMTP id
 ds19-20020a170907725300b0096f9ceaa34dmr7103793ejc.21.1686479664769; 
 Sun, 11 Jun 2023 03:34:24 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:24 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 05/15] hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU
 property from board code
Date: Sun, 11 Jun 2023 12:34:02 +0200
Message-ID: <20230611103412.12109-6-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The Q35 PCI host already has a PCI_HOST_BYPASS_IOMMU property. However, the
host initializes this property itself by accessing global machine state,
thereby assuming it to be a PC machine. Avoid this by having board code
set this property.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_q35.c  | 2 ++
 hw/pci-host/q35.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 29b46d3e1c..5220b535b2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -230,6 +230,8 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->below_4g_mem_size, NULL);
     object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+    object_property_set_bool(phb, PCI_HOST_BYPASS_IOMMU,
+                             pcms->default_bus_bypass_iommu, NULL);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 23b689dba3..7980ddde69 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -66,8 +66,7 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
                                 s->mch.pci_address_space,
                                 s->mch.address_space_io,
                                 0, TYPE_PCIE_BUS);
-    pci->bypass_iommu =
-        PC_MACHINE(qdev_get_machine())->default_bus_bypass_iommu;
+
     qdev_realize(DEVICE(&s->mch), BUS(pci->bus), &error_fatal);
 }
 
-- 
2.41.0


