Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F9B7398A3
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAl-0004Cb-4R; Thu, 22 Jun 2023 03:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040v-8y
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002rY-9D
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:55:58 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mn2Fb-1plwVY2zW3-00k6qH; Thu, 22
 Jun 2023 09:55:47 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/24] q800: introduce Q800MachineState
Date: Thu, 22 Jun 2023 09:55:23 +0200
Message-Id: <20230622075544.210899-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o89uu9sa2mhTYJOgC+SpgjAxtFd+Y89mK5k6yuHGVel6U6Xmf7u
 i07NHNeaiwO2k2c+PJhXPetQUtWD6uXno3i9M+PUhkozjAmLnu61YmAVz7JsK9tikSvKG3g
 PBYT+Qtem8HGFrsjD268UOX5hsiNnDzcKb4jVx4TIS0xcYl0OBTg7WIluGfHdVDh1ez0TjL
 B4LVFFtlhLv/NOwF3ndsQ==
UI-OutboundReport: notjunk:1;M01:P0:YWvgwPQVBWs=;3jbaIfCt3M9q0LAzZ1m8U8vqMtw
 7w3BqvEjTzm6PYdsmJghYxIcohEPPIdrA07V87DiybcEZx1nQn6RC60Oc15Oah2xwyKxTkvmV
 ra54LDg+h27x5iu3vzuElsPKNkSB26finn/EwiNO6VvRD5v7hfpveCBe6T8aGTf8yjURCcLac
 S12ZerGtaYO/593c3y7t1o1C3n3kt9LtzWmsNty3LKz5GrLa3oRtQi9Bx2X5GKr+q2c6noBKd
 hPQM0nzn9PWOvl8e/KBIVLVMpPKxHRHh+nTzVnYpSc1Min2qCPYesPxJ6/4UfUiNL0g7BHcoQ
 /AMcvt4wACJ16F+rQERPPsjforkcykHbwYDfmhPBA0JMMTvSiBlUcstiEJ9EKv6aIZTjVKTO4
 DLh6OhavevTW2/uxJ0xjKT+1HLGsm7kWQY6nGMFAN9k42dc5wFTSVIiqPdFpJzG6e3Lbaq8o2
 BlSQYoCY8cBoSHlpNdJOc0yxoxQZGfJj+ARv0rc7o5ZiEkgLawd0Ryc/8btfDPBwN1Z70WQgN
 5q3g/4MJlJK2NPy8KYgRLnXmtXgkIb+nfkLUuOXLQN5WTwJf4FPYMq+JR55bw7RpVNJXzsxD7
 uxprNmuyY2u6E8YNmd3Ev2g6Rq7wjxhkjKyiVcLcpz/0OZqjHmSS2YaRyMdUwvdqeGmyJqQUp
 yMIRBge1ASzW+jJTwCCjzhGPW2c7d9Mc23IC+RzY8Q==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This provides an overall container and owner for Machine-related objects such
as MemoryRegions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS            |  1 +
 include/hw/m68k/q800.h | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/m68k/q800.c         |  2 ++
 3 files changed, 43 insertions(+)
 create mode 100644 include/hw/m68k/q800.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 88b5a7ee0a79..748a66fbaa30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1236,6 +1236,7 @@ F: include/hw/misc/mac_via.h
 F: include/hw/nubus/*
 F: include/hw/display/macfb.h
 F: include/hw/block/swim.h
+F: include/hw/m68k/q800.h
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
new file mode 100644
index 000000000000..f3bc17aa1bdc
--- /dev/null
+++ b/include/hw/m68k/q800.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU Motorla 680x0 Macintosh hardware System Emulator
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
+#ifndef HW_Q800_H
+#define HW_Q800_H
+
+#include "hw/boards.h"
+#include "qom/object.h"
+
+/*
+ * The main Q800 machine
+ */
+
+struct Q800MachineState {
+    MachineState parent_obj;
+};
+
+#define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
+OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, Q800_MACHINE)
+
+#endif
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 465c510c186e..c0256c8a904c 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -38,6 +38,7 @@
 #include "standard-headers/asm-m68k/bootinfo.h"
 #include "standard-headers/asm-m68k/bootinfo-mac.h"
 #include "bootinfo.h"
+#include "hw/m68k/q800.h"
 #include "hw/misc/mac_via.h"
 #include "hw/input/adb.h"
 #include "hw/nubus/mac-nubus-bridge.h"
@@ -749,6 +750,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
 static const TypeInfo q800_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("q800"),
     .parent     = TYPE_MACHINE,
+    .instance_size = sizeof(Q800MachineState),
     .class_init = q800_machine_class_init,
 };
 
-- 
2.40.1


