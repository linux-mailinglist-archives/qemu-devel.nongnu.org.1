Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8598251D7
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:25:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNX-0007jt-N1; Fri, 05 Jan 2024 05:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNW-0007jf-Bd
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNU-0004LB-E1
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e3a67ca9fso1001525e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450274; x=1705055074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlBWcwz5/uNxxE5HcedXNLhE+jIf4Z06u/LEi3FC4kY=;
 b=MDnZ7LPN69/JZ0RjsoeWnYhJ+V7aKyM9rEylTlzKY0mlZDCfkgB3Atgwxgkb/L0Abz
 jodBydUNJ9Tdf/zTeI/o04LHQZAUapjwVaCmdQaK0Ac7E77fLE+5NJi5eHoy55rxCQr0
 uMIpTcnFIjNZIk4t5m8SPQB6UVaNA5tQi0p9u/AMnJpF1peI9mDInT5ysVqwsnc2jn9C
 L4MFYMpjjGvNN5qGIFescUFj0QE85qvZNmv7LVOIAanUNSwVGPXEeymIXoUwIYXjNYoP
 w+KKwKjhjThfsQ23yrhp48n2F1L4KJ25gbNkX0GJG40m4YKVLzjfJ2svB+HwfZX71SZL
 Pliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450274; x=1705055074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlBWcwz5/uNxxE5HcedXNLhE+jIf4Z06u/LEi3FC4kY=;
 b=kEB5nRb/yZ94fcZq6ht46UwYTmXzkf6cbScHvHVK+ZPuMLtGs10b3h0mWXFKdHVGd2
 FxLtDezW9kMYA2mnvyPsz5XJwy45h+MMPxbJPusKivy63vo9OhHy8VOJ8mj/KYHKWGJ/
 wbsEvsRC8FCxcCLpi/jiq5reFhl60bYnuTMhW3pc1ThdbUbPlduePCznEPkh5K23Efi8
 wisXJcqbOoV5GPR3cmotEe7rvwA/EWQz4K1KVaDKUJ2H3n51sbU2waqS+ab0lrTxUEKT
 Tutl2xe1IxCTi4C/ykrfr/fpNdL6Sr71W3jTQmxV9n3/YjEZbCBczYsG25szzVWKc5++
 Ym/w==
X-Gm-Message-State: AOJu0Yxm0nXI78EsAn5enCzsnEs38m16cEYMdZjP2bGjUHceamoxr1ll
 An3xfmbxaNih73CL0xi+XjPDkOf7hl9vrYl9cpKB4U3UTQ==
X-Google-Smtp-Source: AGHT+IHWgvZpdCYamCYi4o1gV2DKLOQ5EKDs0Jod9PjPfuZlHo2zae5cWfkQgUQTAw4B+6W+Hgy8VQ==
X-Received: by 2002:a05:600c:600a:b0:40e:39bc:816d with SMTP id
 az10-20020a05600c600a00b0040e39bc816dmr209349wmb.152.1704450274537; 
 Fri, 05 Jan 2024 02:24:34 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:34 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH 1/9] sparc/grlib: split out the headers for each peripherals
Date: Fri,  5 Jan 2024 11:24:13 +0100
Message-Id: <20240105102421.163554-2-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

... and move them in their right hardware directory.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/char/grlib_apbuart.c                       |  4 +--
 hw/intc/grlib_irqmp.c                         |  4 +--
 hw/sparc/leon3.c                              |  6 ++--
 hw/timer/grlib_gptimer.c                      |  4 +--
 include/hw/char/grlib_uart.h                  | 30 +++++++++++++++++++
 .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  | 14 +++------
 include/hw/timer/grlib_gptimer.h              | 30 +++++++++++++++++++
 7 files changed, 74 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/char/grlib_uart.h
 rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (86%)
 create mode 100644 include/hw/timer/grlib_gptimer.h

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 82ff40a530..2c9ab70b85 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB APB UART Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -26,7 +26,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "hw/sparc/grlib.h"
+#include "hw/char/grlib_uart.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 3bfe2544b7..c994d5dacc 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -3,7 +3,7 @@
  *
  * (Multiprocessor and extended interrupt not supported)
  *
- * Copyright (c) 2010-2019 AdaCore
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -29,7 +29,7 @@
 #include "hw/sysbus.h"
 
 #include "hw/qdev-properties.h"
-#include "hw/sparc/grlib.h"
+#include "hw/intc/grlib_irqmp.h"
 
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 1e39d2e2d0..58784c099a 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -1,7 +1,7 @@
 /*
  * QEMU Leon3 System Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -40,7 +40,9 @@
 #include "elf.h"
 #include "trace.h"
 
-#include "hw/sparc/grlib.h"
+#include "hw/timer/grlib_gptimer.h"
+#include "hw/char/grlib_uart.h"
+#include "hw/intc/grlib_irqmp.h"
 #include "hw/misc/grlib_ahb_apb_pnp.h"
 
 /* Default system clock.  */
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 5c4923c1e0..5c2cddcec3 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB GPTimer Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sparc/grlib.h"
+#include "hw/timer/grlib_gptimer.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
diff --git a/include/hw/char/grlib_uart.h b/include/hw/char/grlib_uart.h
new file mode 100644
index 0000000000..b67da6c62a
--- /dev/null
+++ b/include/hw/char/grlib_uart.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU GRLIB UART
+ *
+ * Copyright (c) 2024 AdaCore
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef GRLIB_UART_H
+#define GRLIB_UART_H
+
+#define TYPE_GRLIB_APB_UART "grlib-apbuart"
+
+#endif
diff --git a/include/hw/sparc/grlib.h b/include/hw/intc/grlib_irqmp.h
similarity index 86%
rename from include/hw/sparc/grlib.h
rename to include/hw/intc/grlib_irqmp.h
index ef1946c7f8..b9cc584168 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB Components
  *
- * Copyright (c) 2010-2019 AdaCore
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -22,8 +22,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef GRLIB_H
-#define GRLIB_H
+#ifndef GRLIB_IRQMP_H
+#define GRLIB_IRQMP_H
 
 #include "hw/sysbus.h"
 
@@ -36,10 +36,4 @@
 
 void grlib_irqmp_ack(DeviceState *dev, int intno);
 
-/* GPTimer */
-#define TYPE_GRLIB_GPTIMER "grlib-gptimer"
-
-/* APB UART */
-#define TYPE_GRLIB_APB_UART "grlib-apbuart"
-
-#endif /* GRLIB_H */
+#endif /* GRLIB_IRQMP_H */
diff --git a/include/hw/timer/grlib_gptimer.h b/include/hw/timer/grlib_gptimer.h
new file mode 100644
index 0000000000..81b1ff0511
--- /dev/null
+++ b/include/hw/timer/grlib_gptimer.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU GRLIB GPTimer
+ *
+ * Copyright (c) 2024 AdaCore
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef GRLIB_GPTIMER_H
+#define GRLIB_GPTIMER_H
+
+#define TYPE_GRLIB_GPTIMER "grlib-gptimer"
+
+#endif
-- 
2.25.1


