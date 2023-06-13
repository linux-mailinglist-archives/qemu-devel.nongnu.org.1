Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9CA72E1D6
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:41:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90Wj-0005vT-OE; Tue, 13 Jun 2023 05:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Wh-0005vE-G9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:41:23 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Vu-00062w-Eb
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:41:23 -0400
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5147e40bbbbso8018214a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649169; x=1689241169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UvD454+E/4A8Q/LAPF1RA7H96fHdTps7nh2m1LLDUQ=;
 b=yfB922hVWq/dpgM5cDzY0Y4iKv2hNGBW6agoFw1UHGnEfO57BSaG6BmpNOgG5adKxb
 TIlV0tTmGvLNdvwFqfKrDIZ/Ha8UXW0rJTglQGJiLy79vlMGPBGS1VwSb6oKNoA6xVnZ
 dieOUi0osJiHmUp0b9KSunWgET00P+Si4sGzuBELwEJOVd/VBk+Shk6JwcPu2cmvzp1i
 ovaHCkLWpcGOzmUNEWIA8YOmXbLUylSSNKXzLN3ZBK9gYrCr0Ud91pOKanYjj/d6cZ0r
 NIjXbUvkQip0wYzn69F/leUbpXb5BUO2UZdSJoDTYsjSrG+Q5YZJGnQjMtCxKzraNL4C
 6Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649169; x=1689241169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2UvD454+E/4A8Q/LAPF1RA7H96fHdTps7nh2m1LLDUQ=;
 b=Yjop5uvflPTbsWpnrt940ikZgRCYHWp6Gl1dRiZ/7P6ck+N9jCVFOf1zPBqO8XV1LA
 +LRjg5JCNwSj/PnKQFmDU+N0OFx0menlhH9h4hjEjjuokoyyuzsxseUaZ8HC5QQRPG6Q
 A9BVyNzlV0opc7pyL9PlO8pRAXXcdtvl+ykNeM6jnZvi+ImxPqzmufv6IdRU86MRrMPJ
 4rknQ+8srN7xQ9QbIjbjory+KbD+HerOj3p/vLj121wOqmcaf3URZAuqFwXr3jqT/0bR
 OV5fPlY4zZmNKLmyh4Gs0n5psFj3W/n1fGaewnCB72MsD+yOz6Xt+UVBrZdOwUF9cQmE
 0Vrw==
X-Gm-Message-State: AC+VfDxyes5RCYNgLWCtGzMp7kWMSLe2oLCDibnJhjnujj2dY0iGhRrF
 2ud+0Egh9CWPIAfzqruKIhETrTw8hsf+HsIqVeecmg==
X-Google-Smtp-Source: ACHHUZ6e+yr69Ach54IimmTeICsFAHo5OVWxNVs0MJqltvnK4FVNR5hgMcuBcZ8RJ55d+1SgH9VAkQ==
X-Received: by 2002:a05:6402:44d:b0:50b:d553:3822 with SMTP id
 p13-20020a056402044d00b0050bd5533822mr6106458edw.7.1686649168926; 
 Tue, 13 Jun 2023 02:39:28 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a056402048a00b005149e012658sm6181916edv.34.2023.06.13.02.39.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/17] hw/char/parallel-isa: Export struct ISAParallelState
Date: Tue, 13 Jun 2023 11:38:19 +0200
Message-Id: <20230613093822.63750-15-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.45; envelope-from=philmd@linaro.org;
 helo=mail-ed1-f45.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Allows the struct to be embedded directly into device models without additional
allocation.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230612081238.1742-3-shentey@gmail.com>
[PMD: Update MAINTAINERS entry and use SPDX license identifier]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                    |  2 +-
 include/hw/char/parallel-isa.h | 30 ++++++++++++++++++++++++++++++
 include/hw/char/parallel.h     |  2 --
 hw/char/parallel-isa.c         |  1 +
 hw/char/parallel.c             | 12 +-----------
 hw/i386/pc_piix.c              |  2 +-
 hw/i386/pc_q35.c               |  2 +-
 hw/isa/isa-superio.c           |  1 +
 hw/sparc64/sun4u.c             |  2 +-
 9 files changed, 37 insertions(+), 17 deletions(-)
 create mode 100644 include/hw/char/parallel-isa.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a80a38511..88b5a7ee0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1740,7 +1740,7 @@ F: hw/rtc/mc146818rtc*
 F: hw/watchdog/wdt_ib700.c
 F: hw/watchdog/wdt_i6300esb.c
 F: include/hw/display/vga.h
-F: include/hw/char/parallel.h
+F: include/hw/char/parallel*.h
 F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/input/i8042.h
diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
new file mode 100644
index 0000000000..d24ccecf05
--- /dev/null
+++ b/include/hw/char/parallel-isa.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU ISA Parallel PORT emulation
+ *
+ * Copyright (c) 2003-2005 Fabrice Bellard
+ * Copyright (c) 2007 Marko Kohtala
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_PARALLEL_ISA_H
+#define HW_PARALLEL_ISA_H
+
+#include "parallel.h"
+
+#include "hw/isa/isa.h"
+#include "qom/object.h"
+
+#define TYPE_ISA_PARALLEL "isa-parallel"
+OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
+
+struct ISAParallelState {
+    ISADevice parent_obj;
+
+    uint32_t index;
+    uint32_t iobase;
+    uint32_t isairq;
+    ParallelState state;
+};
+
+#endif /* HW_PARALLEL_ISA_H */
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 9f76edca81..7b5a309a03 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -25,8 +25,6 @@ typedef struct ParallelState {
     PortioList portio_list;
 } ParallelState;
 
-#define TYPE_ISA_PARALLEL "isa-parallel"
-
 void parallel_hds_isa_init(ISABus *bus, int n);
 
 bool parallel_mm_init(MemoryRegion *address_space,
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index 547ae69304..ab0f879998 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -13,6 +13,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/char/parallel.h"
 #include "qapi/error.h"
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index e75fc5019d..147c900f0d 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/char/parallel.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
@@ -73,17 +74,6 @@
 
 #define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
 
-OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
-
-struct ISAParallelState {
-    ISADevice parent_obj;
-
-    uint32_t index;
-    uint32_t iobase;
-    uint32_t isairq;
-    ParallelState state;
-};
-
 static void parallel_update_irq(ParallelState *s)
 {
     if (s->irq_pending)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 42af03dbb4..44146e6ff5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -26,7 +26,7 @@
 #include CONFIG_DEVICES
 
 #include "qemu/units.h"
-#include "hw/char/parallel.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/dma/i8257.h"
 #include "hw/loader.h"
 #include "hw/i386/x86.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6155427e48..a9a59ed42b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -30,7 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/char/parallel.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 9292ec3bcf..7dbfc374da 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -21,6 +21,7 @@
 #include "hw/isa/superio.h"
 #include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/char/serial.h"
 #include "trace.h"
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index e2858a0331..29e9b6cc26 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -35,7 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci-host/sabre.h"
 #include "hw/char/serial.h"
-#include "hw/char/parallel.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
 #include "hw/input/i8042.h"
-- 
2.38.1


