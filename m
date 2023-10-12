Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 893977C6DDF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qquez-0002uE-79; Thu, 12 Oct 2023 08:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qquex-0002si-Tc
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:23 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qquew-0001ob-BQ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99357737980so148430666b.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697113160; x=1697717960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9j0wB4sagFap8UlCk3DGG3Emv5eeF0Xy9DDluHlDSM=;
 b=Op3YQS6ii/w+7k2SJnNHXrk/kAAJsSBVqntkgWO0CFTlGNUQT0P9OEIEy/6SO3hkht
 w4ywhxzzwqHrNXTSw97p10oxyAFjVjEuq8LLIU6+V/26THL0nGcetp8Btu2w5kCUYhfs
 JXqqeEeVpIBnjXI/7Bl07CfUEz6nglBWbGes11tLaHDhnqZZtx0N4RFX57G9r9PUAOZr
 kuIQ1WRMOOeGsM+0C6zN0BZBnbP14/jtO4n7aw9gv4eRIk1NN1nmpx+7w8eVKLnLP2/8
 2m/CsuRMInH3mzUZwjB0GOK2rZJNl1A35aFQ6rqMjwbRs7+u10vysecr5dnvOPlOle7Q
 j1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113160; x=1697717960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9j0wB4sagFap8UlCk3DGG3Emv5eeF0Xy9DDluHlDSM=;
 b=SPjhFyzHuON6/SlwqpSuo7bEFFYSuhn8Oist28JzLjfshvEq+Z8POhgOWJzimJjyPG
 R7hCjjvrRnubs3dv5DIPdWpA3jyiyiTK29M1cfi2JxA+S8tqyjX7Jv3Ja9TNONWnFSHJ
 oYV2S0kfS6HlZvOMxeFyWzQP4Ipwd3fxb1CBNhmMPjYLFZcWiwHU7/8cnTi99mFfKfRd
 pyXdOEW6JYu4ZjIO+sZxxvCWEyIfy8FWoz3G9hmw+YXNGi9V8kOndmgNMEknh8wxv7c6
 wvViizPjMjZSX1gRxL54c6zFEB3FlNrsqn/vydtzh/73cAXUHSc4Ihd4yTjrsP7wuUPB
 Ey1g==
X-Gm-Message-State: AOJu0Yztuuf94OehB+WE9sOpTUEs776xtOs3MUVTqJ3Gfscx3+iO5z5V
 gRCJoddX6DM7PWy66NWpORl8wIX4pqA3X9xy4vJRug==
X-Google-Smtp-Source: AGHT+IHGvXpV2Q3xs/5bEm7kcHpoP3IQ0jJmcbp6cTD1sa7rTP7GWV6FqC8UM1N90P9YzEGIXNAO6A==
X-Received: by 2002:a17:906:3288:b0:9a1:fb4c:3b6c with SMTP id
 8-20020a170906328800b009a1fb4c3b6cmr21893209ejw.59.1697113160687; 
 Thu, 12 Oct 2023 05:19:20 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-232.abo.bbox.fr. [176.131.211.232])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a170906139700b0098f99048053sm11226132ejc.148.2023.10.12.05.19.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Oct 2023 05:19:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] hw/pci-host/designware: Add 'host_mem' variable for
 clarity
Date: Thu, 12 Oct 2023 14:18:51 +0200
Message-ID: <20231012121857.31873-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012121857.31873-1-philmd@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
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

designware_pcie_root_realize() uses get_system_memory()
as the "host side memory region", as opposed to the "PCI
side" one. Introduce the 'host_mem' variable for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/designware.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 692e0731cd..bacb2bdb2d 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -393,6 +393,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
     DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
+    MemoryRegion *host_mem = get_system_memory();
     MemoryRegion *address_space = &host->pci.memory;
     PCIBridge *br = PCI_BRIDGE(dev);
     DesignwarePCIEViewport *viewport;
@@ -433,7 +434,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
         source      = &host->pci.address_space_root;
-        destination = get_system_memory();
+        destination = host_mem;
         direction   = "Inbound";
 
         /*
@@ -458,7 +459,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 
         destination = &host->pci.memory;
         direction   = "Outbound";
-        source      = get_system_memory();
+        source      = host_mem;
 
         /*
          * Configure MemoryRegion implementing CPU -> PCI memory
-- 
2.41.0


