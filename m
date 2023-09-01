Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FDA78FBA6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc19f-0001NM-8U; Fri, 01 Sep 2023 06:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19U-0001Kf-6e
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc19R-0001bc-F7
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:13:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CA0B51E734;
 Fri,  1 Sep 2023 13:13:39 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1F39D2506C;
 Fri,  1 Sep 2023 13:13:04 +0300 (MSK)
Received: (nullmailer pid 3619005 invoked by uid 1000);
 Fri, 01 Sep 2023 10:13:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 7/8] softmmu/vl.c: inline include/qemu/qemu-options.h into vl.c
Date: Fri,  1 Sep 2023 13:13:01 +0300
Message-Id: <20230901101302.3618955-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230901101302.3618955-1-mjt@tls.msk.ru>
References: <20230901101302.3618955-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qemu-options.h just includes qemu-options.def with some #defines.
We already do this in vl.c in other place. Since no other file
includes qemu-options.h anymore, just inline it in vl.c.

This effectively reverts second half of commit 59a5264b99434.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/qemu-options.h | 41 -------------------------------------
 softmmu/vl.c                | 11 +++++++++-
 2 files changed, 10 insertions(+), 42 deletions(-)
 delete mode 100644 include/qemu/qemu-options.h

diff --git a/include/qemu/qemu-options.h b/include/qemu/qemu-options.h
deleted file mode 100644
index 4a62c83c45..0000000000
--- a/include/qemu/qemu-options.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * qemu-options.h
- *
- * Defines needed for command line argument processing.
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- * Copyright (c) 2010 Jes Sorensen <Jes.Sorensen@redhat.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef QEMU_OPTIONS_H
-#define QEMU_OPTIONS_H
-
-enum {
-
-#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
-    opt_enum,
-#define DEFHEADING(text)
-#define ARCHHEADING(text, arch_mask)
-
-#include "qemu-options.def"
-};
-
-#endif
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0a74810ca3..78b6570f19 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -91,7 +91,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "qemu/qemu-options.h"
 #include "qemu/main-loop.h"
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
@@ -894,6 +893,16 @@ static void help(int exitcode)
     exit(exitcode);
 }
 
+enum {
+
+#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
+    opt_enum,
+#define DEFHEADING(text)
+#define ARCHHEADING(text, arch_mask)
+
+#include "qemu-options.def"
+};
+
 #define HAS_ARG 0x0001
 
 typedef struct QEMUOption {
-- 
2.39.2


