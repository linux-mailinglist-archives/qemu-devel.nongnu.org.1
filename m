Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92832737DE1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbX-0001vH-N7; Wed, 21 Jun 2023 04:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbV-0001v8-CJ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbT-0003Lf-RV
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9lasJdKtCrbK4QgvPkXoDKIi80sC10wxU9yjgj6rCWk=; b=nN/uuQwpVUQ6b5/bCcxUc4BsLp
 +6lcib/Lm4nyyxdBxhAFupIoqlYHpuvlHfb+ZcaSRHSLcKK9DHKptoUcNLNIT9XpOfZclCkpkA6Zq
 HqcbeFUh+VWynabu8QcNnXaKqdXStOwJS/O2bKlcegNTc/JhAiU0dHVqJN8RwBjxYOGKETXSgcVHc
 XDMzpnCLutaWv8/EsiMT9QwRlU+D4cbGra5N9ABeK9a/Xu2WU78FhLTzt9GeJOoZbhW/bDjJhLCM3
 cjdre26l1/2k/fjcagrtLJZMON9CwFtEmecFRN1prQ025+hf2UNzEP+28e7fcfZAFCxTYXcIHqe4I
 FoU9tUz2EmBudyaZsbz/drFxS/JiWxqWloDHHrUGtJWj8Ac4bpda6FvgUiVKcZK3/Sb6lxPgbT5nD
 cSIMNL3yD9b+NOA+9h4cdSKiWguebQcebdPw+oLStHajfSeHRVlwA6Z7UjBnCxqgOkE7ZPVhUPV2G
 HgVj5fsWp2tmKhCpCa819TaKvMm2VtGFR6RY8NfKL7TEVr3JW3Ko1363blabRAbtZQbpssakE0hLz
 cQ3n+eGfIZ4pTukpl3NCiCV6plWqWC0hZ1wiWXjBwQDzsl1Ep7X3f9IFlnKRQQqgJnL8NY/W4gQEl
 WhZOQK4gYodmIP6kLMS6jmBomZoJHlWXDwLWxJ4jg=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbI-0001ZB-JQ; Wed, 21 Jun 2023 09:54:08 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:32 +0100
Message-Id: <20230621085353.113233-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 03/24] q800: introduce Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This provides an overall container and owner for Machine-related objects such
as MemoryRegions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS            |  1 +
 hw/m68k/q800.c         |  2 ++
 include/hw/m68k/q800.h | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 include/hw/m68k/q800.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 88b5a7ee0a..748a66fbaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1236,6 +1236,7 @@ F: include/hw/misc/mac_via.h
 F: include/hw/nubus/*
 F: include/hw/display/macfb.h
 F: include/hw/block/swim.h
+F: include/hw/m68k/q800.h
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 465c510c18..c0256c8a90 100644
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
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
new file mode 100644
index 0000000000..f3bc17aa1b
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
-- 
2.30.2


