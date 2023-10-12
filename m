Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF587C6DE9
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qquf6-0003Dz-TG; Thu, 12 Oct 2023 08:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qquf4-0003Cz-Lj
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:30 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qquf2-0001pi-CX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:30 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53db1fbee70so1579933a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697113166; x=1697717966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xa2WXsDwKflmWK2k8quohK6TTrUH1twZfhC/r4NA1UE=;
 b=nLvXAOThsr3uR2a97tQKtPvjWU5llPjrq1nzOnGCKl7KH7fwtOhSdT94qupGpCjG0y
 8c+v1cI7n38tjYOxCocAEHgf/k6EW0aT3oRM4Yn2STewLs9hXQ/lZFe3ioSlx9mW1I4R
 up6QG8M8zCaqmlyZkMllUtAbR6MG4HWD5m/WBA9ooygZ02Tuh9wAKMpXZGw/etkTByoV
 71R5RMsRUWembW/3ou+a//5CntVsJuvcocvtbErCFJuNPrF85ul0C1K/3wG+QKxUDSob
 ObF7BNgLK5UrJXzIfGrBjplEbekqf/rOx7WsHoE1O5B91no482mHkob/YgGyAGPU9w0n
 UJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113166; x=1697717966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xa2WXsDwKflmWK2k8quohK6TTrUH1twZfhC/r4NA1UE=;
 b=uPyPLwu411Qtb2ySiuQG/eFNQyDLVMLut6oPsfWHGuGaROUX9wduGvTWrWbJ8eKoak
 tb1m17x28P9Sey8in6JxBRok5RhEqU5hFupovYDRNbp40OtSNkqQzpc/b3m0XqE/sQJ7
 SO+Oqsh6v7vACeyZQqJbqrwwGh6qCKpqY//wI+jbrAPts0+WCZaj0hClsrbifsinKoSJ
 FHXk0goVPPpzAQWe8u3opvXUKAgA8J1m6vVLeku1GTtnMK54na9rUVAUX6XVwxMxoz+d
 Q1fiL/bwro3ov4H0lMJvl0rhkgXAShsS7RDtXjGJG9xd6a+uYjb0V8+6gpH3WPxXdFOH
 TJBA==
X-Gm-Message-State: AOJu0YxmDaLCUWhVTTDYK11HggoxT82XzA+OnEhGazYSOAgWyhqU6cfe
 irRlay0F280bd/pBs6mPyzknh/X5vupvkAYLQYOIeA==
X-Google-Smtp-Source: AGHT+IHWri4VGwpam1SvWstYU1rGbm25Dgour2hCbCjOI/FDptteoXJULnsYH1UGWghsYmgDZzClYA==
X-Received: by 2002:a05:6402:1250:b0:533:e314:20dd with SMTP id
 l16-20020a056402125000b00533e31420ddmr20275891edw.13.1697113166626; 
 Thu, 12 Oct 2023 05:19:26 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-232.abo.bbox.fr. [176.131.211.232])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a50ff17000000b005342fa19070sm10081874edu.89.2023.10.12.05.19.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Oct 2023 05:19:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] hw/pci-host/designware: Hoist host controller in root
 function #0
Date: Thu, 12 Oct 2023 14:18:52 +0200
Message-ID: <20231012121857.31873-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012121857.31873-1-philmd@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

There is always an unique root function for the host bridge
controller. We create this function when the controller is
realized, in designware_pcie_host_realize().

No need to call qdev_get_parent_bus() each time the root function
want to resolve its host part. Hoist a pointer in its state. Set
the pointer once when the function is realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci-host/designware.h |  1 +
 hw/pci-host/designware.c         | 15 +++++----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index c484e377a8..9e2caa04e9 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -71,6 +71,7 @@ struct DesignwarePCIERoot {
 
     DesignwarePCIEViewport viewports[2][DESIGNWARE_PCIE_NUM_VIEWPORTS];
     DesignwarePCIEMSI msi;
+    DesignwarePCIEHost *host;
 };
 
 struct DesignwarePCIEHost {
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index bacb2bdb2d..fb46493a05 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -57,13 +57,6 @@
 
 #define DESIGNWARE_PCIE_IRQ_MSI                    3
 
-static DesignwarePCIEHost *
-designware_pcie_root_to_host(DesignwarePCIERoot *root)
-{
-    BusState *bus = qdev_get_parent_bus(DEVICE(root));
-    return DESIGNWARE_PCIE_HOST(bus->parent);
-}
-
 static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
                                               unsigned size)
 {
@@ -85,7 +78,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
                                            uint64_t val, unsigned len)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(opaque);
-    DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
+    DesignwarePCIEHost *host = root->host;
 
     root->msi.intr[0].status |= BIT(val) & root->msi.intr[0].enable;
 
@@ -300,7 +293,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
                                               uint32_t val, int len)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(d);
-    DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
+    DesignwarePCIEHost *host = root->host;
     DesignwarePCIEViewport *viewport =
         designware_pcie_root_get_current_viewport(root);
 
@@ -392,7 +385,8 @@ static char *designware_pcie_viewport_name(const char *direction,
 static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
-    DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
+    DesignwarePCIEHost *host = DESIGNWARE_PCIE_HOST(
+                                    qdev_get_parent_bus(DEVICE(dev))->parent);
     MemoryRegion *host_mem = get_system_memory();
     MemoryRegion *address_space = &host->pci.memory;
     PCIBridge *br = PCI_BRIDGE(dev);
@@ -406,6 +400,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
     size_t i;
 
     br->bus_name  = "dw-pcie";
+    root->host = host;
 
     pci_set_word(dev->config + PCI_COMMAND,
                  PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-- 
2.41.0


