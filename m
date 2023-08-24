Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14F787559
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:28:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDBs-00036j-NE; Thu, 24 Aug 2023 12:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qZB10-0003b7-QB
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:08:50 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qZB0x-0003rY-Q1
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:08:50 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1692886122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w56S2Yk8f1THfH1NfdjH0+859/7enehIyNIANHv+SFg=;
 b=G3EPXFNdHzZZrZwNk714Qj8JqJUGz6LqIjcm7nxQdxdsARj9XrROqRraYJsKGDkh1f2WRu
 KlmHmrhXGJSOmZ3UgkluVGZ5iJA/Augk5MzGfjHC5ZxZukDkcuTl/h7hyI0ZYRLb/AKNGw
 MObBjdATRGkRYlaqxUTHTSEGv0iMgfE=
To: kraxel@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org,
	Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] fix leaks found wtih fuzzing
Date: Thu, 24 Aug 2023 17:08:39 +0300
Message-Id: <20230824140839.391585-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 24 Aug 2023 12:28:08 -0400
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

Fuzzing causes thousands of identical crashes with message:
"AddressSanitizer: 3744 byte(s) leaked in 1 allocation(s)"

Fixes: 060ab76356 ("gtk: don't exit early in case gtk init fails")

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 ui/gtk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 8ba41c8f13..996ca7949d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2358,6 +2358,10 @@ static gboolean gtkinit;
 
 static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 {
+    if (!gtkinit) {
+        fprintf(stderr, "gtk initialization failed\n");
+        exit(1);
+    }
     VirtualConsole *vc;
 
     GtkDisplayState *s = g_malloc0(sizeof(*s));
@@ -2365,10 +2369,6 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     GtkIconTheme *theme;
     char *dir;
 
-    if (!gtkinit) {
-        fprintf(stderr, "gtk initialization failed\n");
-        exit(1);
-    }
     assert(opts->type == DISPLAY_TYPE_GTK);
     s->opts = opts;
 
-- 
2.34.1


