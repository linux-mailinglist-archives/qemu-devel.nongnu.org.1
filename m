Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3583778838C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 11:31:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZT9M-0004xm-JQ; Fri, 25 Aug 2023 05:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qZT92-0004o4-M6
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 05:30:20 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qZT8z-0002u7-B1
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 05:30:20 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1692955811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LGDF2n5hpKQfoKviutJ0zCz9Nk6TTrx7a0lndypGT8U=;
 b=SareousgynlD/pm4xBIUERVAa2xJBP2CAYOFp3cVH7OEQqSxbKY/rCxPUx1WEjqf1IsC2Y
 QKwncKtz10vmul2J0izqzUirkh51Bq1hKVVwAXIh+JU+Sk7NH/a3F+RjeMUKK5KDo4jVVr
 uPNBG/f3Y3J1/h6Cp41rewE6ykgBMw0=
To: kraxel@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org,
	Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] fix leaks found wtih fuzzing
Date: Fri, 25 Aug 2023 12:29:09 +0300
Message-Id: <20230825092907.862583-1-frolov@swemel.ru>
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

It is true, that there is no problem during runtime
from the first sight, because the memmory is lost just
before qemu exits. Nevertheless, this change is necessary,
because AddressSanitizer is not able to recognize this
situation and produces crash-report (which is
false-positive in fact). Lots of False-Positive warnings
are davaluing problems, found with fuzzing, and thus the
whole methodology of dynamic analysis.
This patch eliminates such False-Positive reports,
and makes every problem, found with fuzzing, more valuable.

Fixes: 060ab76356 ("gtk: don't exit early in case gtk init fails")

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
v2: Moved declarations in the beginning.

 ui/gtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 8ba41c8f13..23a78787df 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2360,7 +2360,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     VirtualConsole *vc;
 
-    GtkDisplayState *s = g_malloc0(sizeof(*s));
+    GtkDisplayState *s;
     GdkDisplay *window_display;
     GtkIconTheme *theme;
     char *dir;
@@ -2372,6 +2372,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     assert(opts->type == DISPLAY_TYPE_GTK);
     s->opts = opts;
 
+    *s = g_malloc0(sizeof(*s));
     theme = gtk_icon_theme_get_default();
     dir = get_relocated_path(CONFIG_QEMU_ICONDIR);
     gtk_icon_theme_prepend_search_path(theme, dir);
-- 
2.34.1


