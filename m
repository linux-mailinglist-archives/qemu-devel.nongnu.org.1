Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1940382EF5B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:04:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5W-0007F7-Vw; Tue, 16 Jan 2024 08:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5U-0007El-MO
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:40 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5S-0006dy-BS
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:40 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso27214025e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410156; x=1706014956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TK+NHKCuGfk31+/40pfLDx6gHFMsBB1EG2XubSSfMQU=;
 b=kJeJ78MCrrZzB5BEMGVYELaw+Hoa/ghi1Mtx7luZjlr+lhoz6wyiTi+jXRf6DvfDnR
 Sfoh7/VRhFyvKOtY4J6bhAArBAvG3HISbQu+1mWTQjetILXRtAvkrkBZ5P+zOjFaOw7P
 iA7/+9CPTfnBeO4EHXrovMkXEzCLgIpqAC2PwHDEoqDNnC7IYdYcoUAjoVF1qmzmwHC/
 piR1TqIzsjSPuiHxLtdKMoDdfHjS+jwMri/Rd0vzZgM+Qo6XmzDJn1pllg+7FFQ7BB4F
 wn9cEp70f8+LWOu0qfP1LIcPXslo4YiaG9/nSWByc05Cuij6e9Z2noH1drlBJ8reUYtp
 SgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410156; x=1706014956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TK+NHKCuGfk31+/40pfLDx6gHFMsBB1EG2XubSSfMQU=;
 b=lT/Lupoz7WhI3rJZmUAt+XNwxOPDmJTPtw0n4NCJfCsOes83bmIxxepKuzHkOf79l/
 o+QOA7wdqaUoUJ9XVZhVVKmbyV3XAccBNhdfg4uQiEKjdvVT7FELSwDLv+ciOz/r+BH1
 i8Voa1Eq7H6K7/ulO8nItcYfqgNWxd0dOQC3irCtSvxXKQ21il92mPjUQCtn8d4Ffcd/
 rvDkUixqQzOwVN/HfCKS1gKDHJraQyN4v6HDQEfFWeJ7CgIlZAcOvW8QNp//pd+RB7JF
 r/sKBkpdKsU6OPXYM4pBlwYqjjQx/0igzAZJKdRN2nbcVkE7zw12EtsGw/aGlAYKZfwS
 cTfw==
X-Gm-Message-State: AOJu0YxLhB2df7ZXPrdH/dMTMThQB1PLUs0p4Uy7zMqkcAtRo+FoQRZ5
 soh3Zda9x6ecLRyLGXYOMSwh9J6nEYpWdCf8Rp3Oh19OJQ==
X-Google-Smtp-Source: AGHT+IFJ7i/pp/APzvtc6wJLJn210IFkdWx3I6TeRGT1I2HEvZ9jTw6lUzQXFB1UIjv5xCrjT6rrYw==
X-Received: by 2002:a7b:cb99:0:b0:40e:67b5:4654 with SMTP id
 m25-20020a7bcb99000000b0040e67b54654mr2155992wmi.3.1705410156224; 
 Tue, 16 Jan 2024 05:02:36 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:35 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH v2 1/8] sparc/grlib: split out the headers for each peripherals
Date: Tue, 16 Jan 2024 14:02:06 +0100
Message-Id: <20240116130213.172358-2-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
References: <20240116130213.172358-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32d.google.com
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

Update Copyright and add SPDX-License-Identifier at the same time.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/char/grlib_apbuart.c                       |  6 ++--
 hw/intc/grlib_irqmp.c                         |  6 ++--
 hw/sparc/leon3.c                              |  8 +++--
 hw/timer/grlib_gptimer.c                      |  6 ++--
 include/hw/char/grlib_uart.h                  | 32 +++++++++++++++++++
 .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  | 16 ++++------
 include/hw/timer/grlib_gptimer.h              | 32 +++++++++++++++++++
 7 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/char/grlib_uart.h
 rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (86%)
 create mode 100644 include/hw/timer/grlib_gptimer.h

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 82ff40a530..515b65bc07 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB APB UART Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -26,7 +28,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "hw/sparc/grlib.h"
+#include "hw/char/grlib_uart.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 3bfe2544b7..11eef62457 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -3,7 +3,9 @@
  *
  * (Multiprocessor and extended interrupt not supported)
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -29,7 +31,7 @@
 #include "hw/sysbus.h"
 
 #include "hw/qdev-properties.h"
-#include "hw/sparc/grlib.h"
+#include "hw/intc/grlib_irqmp.h"
 
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 2dfb742566..b7d81c76f3 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -1,7 +1,9 @@
 /*
  * QEMU Leon3 System Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -40,7 +42,9 @@
 #include "elf.h"
 #include "trace.h"
 
-#include "hw/sparc/grlib.h"
+#include "hw/timer/grlib_gptimer.h"
+#include "hw/char/grlib_uart.h"
+#include "hw/intc/grlib_irqmp.h"
 #include "hw/misc/grlib_ahb_apb_pnp.h"
 
 /* Default system clock.  */
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 5c4923c1e0..4990885451 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB GPTimer Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -23,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sparc/grlib.h"
+#include "hw/timer/grlib_gptimer.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
diff --git a/include/hw/char/grlib_uart.h b/include/hw/char/grlib_uart.h
new file mode 100644
index 0000000000..7496f8fd5e
--- /dev/null
+++ b/include/hw/char/grlib_uart.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU GRLIB UART
+ *
+ * SPDX-License-Identifier: MIT
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
index ef1946c7f8..c5a90cbb3e 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB Components
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -22,8 +24,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef GRLIB_H
-#define GRLIB_H
+#ifndef GRLIB_IRQMP_H
+#define GRLIB_IRQMP_H
 
 #include "hw/sysbus.h"
 
@@ -36,10 +38,4 @@
 
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
index 0000000000..e56f1b8bf3
--- /dev/null
+++ b/include/hw/timer/grlib_gptimer.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU GRLIB GPTimer
+ *
+ * SPDX-License-Identifier: MIT
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


