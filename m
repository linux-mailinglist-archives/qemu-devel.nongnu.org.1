Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F02CF72A2A0
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hDB-0000yF-0M; Fri, 09 Jun 2023 14:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD4-0000xL-53; Fri, 09 Jun 2023 14:51:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD2-0002rw-Jw; Fri, 09 Jun 2023 14:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KZZHoQewgBXwL13bfUxestEau4HgdSwG+IGmDreN6Ew=; b=VQ5zxdRL8BkWkAuZZrxcYJobgO
 Davqkb3XvMbXJyoV4ncPzB73tsLUv3D95E69U6DJrLTBBbBV4MWLIIUkQTrVzh8McjKLIdjHm2E8e
 9wA6H5TiSDXGb0N+v7bABK+iQq5NzO+sO5XmmYkbhFG13rgVbZ6LxdM3MSqnvG/tsshncRWyqHUkV
 FufzC34geV/cq8jr84cptekSKDchO9+LnKZh9FN3jqz+Yum193vD40Cr4mJZy/ryLFb6hCgDDQd7v
 B+JbQq1b21CWy7QDa0Q3ytubVBhnhp42ve5yerQZnKDqvAF/2JEwxk7voTOLqoVSGn/9vYGDburjl
 oEAmzoGk0u6E5GSZH8h6lG1CpqoSBY3i11Bgn+Zoba/TNw+GEFZWPKzP1DqDL71A9/nzbcG4IW7t3
 F7sIMHNTpOu+iQhKT7+iSb8S4qznJWZDA9iZuZ0ZXgoKnN9hVPh+t7txGvPrHPcU63XuPjodoeypu
 rxz4O4OQNn761b3oKIUKj4T+otwjzX2pE3PLINhTLKAsuhTHnMoVU794G5vSPRc6wK5zzXKppy7ZW
 4yuxpAnZUPF2tVtPvVo+/tmaGYtazGWvWod3js2iWwFLcrhnRYqRQYP6bbN2YPS1GcLaEMfTAEFno
 oTGRQOWoRoaz57rFWLEwcrEO6OEZEzHHq2ysqHvM4=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hCu-0000p5-At; Fri, 09 Jun 2023 19:51:36 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, shentey@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Date: Fri,  9 Jun 2023 19:51:16 +0100
Message-Id: <20230609185119.691152-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/5] cmd646: create separate header and QOM type for CMD646_IDE
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

This will enable CMD646-specific fields to be added to CMD6464IDEState in
future.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/cmd646.c         |  4 +++-
 include/hw/ide/cmd646.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/ide/cmd646.h

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 20f1e41d57..a3e227fba7 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -33,6 +33,7 @@
 #include "sysemu/reset.h"
 
 #include "hw/ide/pci.h"
+#include "hw/ide/cmd646.h"
 #include "trace.h"
 
 /* CMD646 specific */
@@ -339,9 +340,10 @@ static void cmd646_ide_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo cmd646_ide_info = {
-    .name          = "cmd646-ide",
+    .name          = TYPE_CMD646_IDE,
     .parent        = TYPE_PCI_IDE,
     .class_init    = cmd646_ide_class_init,
+    .instance_size = sizeof(CMD646IDEState),
 };
 
 static void cmd646_ide_register_types(void)
diff --git a/include/hw/ide/cmd646.h b/include/hw/ide/cmd646.h
new file mode 100644
index 0000000000..4780b1132c
--- /dev/null
+++ b/include/hw/ide/cmd646.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU IDE Emulation: PCI cmd646 support.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * Copyright (c) 2006 Openedhand Ltd.
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
+#ifndef HW_IDE_CMD646_H
+#define HW_IDE_CMD646_H
+
+#define TYPE_CMD646_IDE "cmd646-ide"
+OBJECT_DECLARE_SIMPLE_TYPE(CMD646IDEState, CMD646_IDE)
+
+#include "hw/ide/pci.h"
+
+struct CMD646IDEState {
+    PCIIDEState parent_obj;
+};
+
+#endif
-- 
2.30.2


