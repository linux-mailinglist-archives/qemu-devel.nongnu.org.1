Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7EF7CFB6A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCc-0002jw-9A; Thu, 19 Oct 2023 09:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBp-0001rY-9V
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBi-0001DK-Fk
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32d569e73acso6763387f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722544; x=1698327344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jaJPkRC2677TxNapfidJhq+3vwfk7C6h2dsSgCQaNac=;
 b=YNuqeiwVN+aobryW8SScEmdaW8T7kXBotjL7Kg6ZqOU1gpb//bAw5ZTOrs8eZ8UJDa
 tx9wBz6JohpcISOZqwL12eQGBZK0sfCwZSG5lTCk2byYoomLx835Or5ym0Xnrzs9ichG
 +JpApyrjPUkuZyyzIaB2Uc+PWRGVJWBe/mO9EzbztF15wi8JqdSU0k9O1w4YdIJFrp24
 T18i2CR77ZnBLae9uAP/j4IKPCrg7kopqOg2sVTs7sNkenN0vJ6d7rKRpyv2TD9YutQ1
 YQak5ytCqoUIzD6vuCUh+iCrO5pXWEcOzWLv+Dak7T7AhZlszYtS1pkK+fLgSR2/i9vf
 QBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722544; x=1698327344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaJPkRC2677TxNapfidJhq+3vwfk7C6h2dsSgCQaNac=;
 b=h8rHDrDts/XncV0C09x9BaIEr/JuajtQJVyMP4dk1hwh/E9+v1/yC3ZCJEy+Rh6O1E
 WjstJp/R0TbaOiwYssZYX8WTVJPYqVXcXo/KNJw0cwIkjiQATDkzFIJobpIZ0shdc7R6
 sYVBG/scvB9C35l2cUmL0cscCVtOTFTpgi/jE9LBP1uwAT5SSBY/IIhqF0/9sWlOwgF6
 7sKsXTuIe3OQidtBg93rmOlCJb+x2n4sw3FdSEviUvPTW2qPukTMRsXpyO6f2wdszG1I
 9nT9XWgbWznJEqc/1O2fLACs+C1dbOEqQiSVN7728+9n7/vhRJ9diC/ytP/AklwYXKbV
 rOiA==
X-Gm-Message-State: AOJu0Yy8fbN5lSkbQkUOtq+pz4bZEK6c/MJ/YZAp15YjbQPabPcHhJzu
 cvuUqYbc+UHbSjlOyPs6XVR3mU/HCNaFUCPSIsM=
X-Google-Smtp-Source: AGHT+IHz5HAhG6ZB2rBPDqyaw47YggijPcEMBS4SBlcx672dqANdsZuLU56wy3CE8QO5/H50X3sYRw==
X-Received: by 2002:adf:ee12:0:b0:31a:ed75:75df with SMTP id
 y18-20020adfee12000000b0031aed7575dfmr1311447wrn.15.1697722543963; 
 Thu, 19 Oct 2023 06:35:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/24] include/hw/arm: move BSA definitions to bsa.h
Date: Thu, 19 Oct 2023 14:35:24 +0100
Message-Id: <20231019133537.2114929-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Leif Lindholm <quic_llindhol@quicinc.com>

virt.h defines a number of IRQs that are ultimately described by Arm's
Base System Architecture specification. Move these to a dedicated header
so that they can be reused by other platforms that do the same.
Include that header from virt.h to minimise churn.

While we're moving the definitions, sort them into numerical order,
and add the ARCH_TIMER_NS_EL2_VIRT_IRQ definition used by sbsa-ref
and which will eventually be needed by virt also.

Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-id: 20230919090229.188092-3-quic_llindhol@quicinc.com
[PMM: Remove unused PPI_TO_INTID macro; sort numerically;
 add ARCH_TIMER_NS_EL2_VIRT_IRQ]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bsa.h  | 35 +++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h | 12 +-----------
 2 files changed, 36 insertions(+), 11 deletions(-)
 create mode 100644 include/hw/arm/bsa.h

diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
new file mode 100644
index 00000000000..8eaab603c03
--- /dev/null
+++ b/include/hw/arm/bsa.h
@@ -0,0 +1,35 @@
+/*
+ * Common definitions for Arm Base System Architecture (BSA) platforms.
+ *
+ * Copyright (c) 2015 Linaro Limited
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QEMU_ARM_BSA_H
+#define QEMU_ARM_BSA_H
+
+/* These are architectural INTID values */
+#define VIRTUAL_PMU_IRQ            23
+#define ARCH_GIC_MAINT_IRQ         25
+#define ARCH_TIMER_NS_EL2_IRQ      26
+#define ARCH_TIMER_VIRT_IRQ        27
+#define ARCH_TIMER_NS_EL2_VIRT_IRQ 28
+#define ARCH_TIMER_S_EL1_IRQ       29
+#define ARCH_TIMER_NS_EL1_IRQ      30
+
+#define INTID_TO_PPI(irq) ((irq) - 16)
+
+#endif /* QEMU_ARM_BSA_H */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5704d95736d..f69239850e6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -34,6 +34,7 @@
 #include "qemu/notify.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
@@ -43,17 +44,6 @@
 #define NUM_VIRTIO_TRANSPORTS 32
 #define NUM_SMMU_IRQS          4
 
-#define ARCH_GIC_MAINT_IRQ  25
-
-#define ARCH_TIMER_VIRT_IRQ   27
-#define ARCH_TIMER_S_EL1_IRQ  29
-#define ARCH_TIMER_NS_EL1_IRQ 30
-#define ARCH_TIMER_NS_EL2_IRQ 26
-
-#define VIRTUAL_PMU_IRQ 23
-
-#define INTID_TO_PPI(irq) ((irq) - 16)
-
 /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
 #define PVTIME_SIZE_PER_CPU 64
 
-- 
2.34.1


