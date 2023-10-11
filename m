Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 418837C5556
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:25:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZCk-0006yQ-ES; Wed, 11 Oct 2023 09:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCg-0006tJ-Kr
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:47 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCd-0004W5-8s
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:45 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ae75ece209so1237636766b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697030681; x=1697635481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n00LFK1jZay5AN34FCEsSqtYKs4uHiPMhfa+zrLt3Oo=;
 b=hkHAfE41GIpm5PoBYEQW/8W3iN4znLWqfk72mfddQ8DyRATMv46039aJSM2ArNSTWZ
 P8uFK3/HzKQWAFV3/p+XLy390BwpOATcndkmGahfWeWl6INeQxs4wiOhHt1A0bw37ChW
 qx0rtV8WPMnrOaMf5VMU5x4R+ezupUGWblk/tDFFOuWFk3sDdnbj7oeIZRRXxjsWa8H/
 XMsgCDMze25Ao/e3W+F7rDRtiY7D/SnFTxU0UsIVxV/4ir+lwEA+EYDRSw/ssJPqLjgX
 CB9M4mpp9Hy00wkWNBsTzoqfrBidIu/QA710r8692hn3o33mO65BT8/kYV6ne0HSOoMM
 5/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030681; x=1697635481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n00LFK1jZay5AN34FCEsSqtYKs4uHiPMhfa+zrLt3Oo=;
 b=TT79KQqvUoiDhLtKvgWjfwZO0rvGCqj6Bfn4dtHtUCrgIOYAknhm5a2kC9n5qmpJyk
 ZgUfRvYpbolOuMIrTPrbObkOuiCTG8Zlei1mbPPLS8aoC67G8nafV0e3RNkGUqr2zOEh
 Xk9joMh90CaJUw1ImBkkGGBQjSiCThfJBbcjq93OWy6DY+xOiCLM69RLrl1EWWvT8pzY
 9dcpgxsyRoV3Kp1tyVL8+9agBlUdESV1XMl0cB76wSUAAU7UVCuU6TIW9nW6wD2tOTeR
 g2xCniFSu3iRNeONno/s8K65W8+Pz15qQJnMO+VV15knnwpTBClF3HMrvIvimbefK9Z1
 jrdA==
X-Gm-Message-State: AOJu0YxCGxq6+Yun6FAaM/HYen+dx0Q6CE7dgF0ccNDT8phK/bGFUWYq
 cNQt8IKOoht5EuBImU0wanDjZNrgFUdiv/Ez1m8=
X-Google-Smtp-Source: AGHT+IE4XM+Hp2ixZiL4+2uxsORzkbtak0CSekrElNN9xH3kXmT0mHV1n8ED8w0q9b0RNG9KYH8ezA==
X-Received: by 2002:a17:906:51d1:b0:9ae:4843:66ee with SMTP id
 v17-20020a17090651d100b009ae484366eemr20116415ejk.36.1697030681139; 
 Wed, 11 Oct 2023 06:24:41 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 n24-20020a170906089800b009929d998abcsm9757647eje.209.2023.10.11.06.24.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 06:24:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/ppc/ppc4xx_pci: Extract PCI host definitions to
 hw/pci-host/ppc4xx.h
Date: Wed, 11 Oct 2023 15:24:24 +0200
Message-ID: <20231011132427.65001-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011132427.65001-1-philmd@linaro.org>
References: <20231011132427.65001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                  |  1 +
 include/hw/pci-host/ppc4xx.h | 17 +++++++++++++++++
 include/hw/ppc/ppc4xx.h      |  5 -----
 hw/ppc/ppc440_bamboo.c       |  1 +
 hw/ppc/ppc440_pcix.c         |  2 +-
 hw/ppc/ppc440_uc.c           |  1 +
 hw/ppc/ppc4xx_pci.c          |  2 +-
 hw/ppc/sam460ex.c            |  1 +
 8 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/pci-host/ppc4xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c07d07927..158896d03e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1969,6 +1969,7 @@ L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc4*.c
 F: hw/i2c/ppc4xx_i2c.c
+F: include/hw/pci-host/ppc4xx.h
 F: include/hw/ppc/ppc4xx.h
 F: include/hw/i2c/ppc4xx_i2c.h
 F: hw/intc/ppc-uic.c
diff --git a/include/hw/pci-host/ppc4xx.h b/include/hw/pci-host/ppc4xx.h
new file mode 100644
index 0000000000..dc36e1ea29
--- /dev/null
+++ b/include/hw/pci-host/ppc4xx.h
@@ -0,0 +1,17 @@
+/*
+ * QEMU PowerPC 4xx PCI-host definitions
+ *
+ * Copyright (c) 2007 Jocelyn Mayer
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_PCIHOST_PPC4XX_H
+#define HW_PCIHOST_PPC4XX_H
+
+#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
+#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
+#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
+#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
+
+#endif
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index ea7740239b..1bd9b8821b 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -29,11 +29,6 @@
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 
-#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
-#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
-#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
-#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
-
 /*
  * Generic DCR device
  */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 45f409c838..2049ff0eef 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -24,6 +24,7 @@
 #include "elf.h"
 #include "hw/char/serial.h"
 #include "hw/ppc/ppc.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "ppc405.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index e4dadbc84d..418dff6590 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
 #include "trace.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 643a79e330..3a66b0c7f7 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -14,6 +14,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 51c265f0ba..d2434a93ac 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1e615b8d35..a28498f39c 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -25,6 +25,7 @@
 #include "elf.h"
 #include "exec/memory.h"
 #include "ppc440.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
-- 
2.41.0


