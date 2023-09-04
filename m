Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E602C7916CE
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8CF-0001cH-Hk; Mon, 04 Sep 2023 07:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bx-0001Me-LW
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bv-000142-HI
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:29 -0400
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-OxotyrIJP8u7enRm_qYQHg-1; Mon, 04 Sep 2023 07:56:25 -0400
X-MC-Unique: OxotyrIJP8u7enRm_qYQHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 639173C0C491;
 Mon,  4 Sep 2023 11:56:25 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A3D6200A4B6;
 Mon,  4 Sep 2023 11:56:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Dmitry Frolov <frolov@swemel.ru>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 52/52] ui/gtk: fix leaks found wtih fuzzing
Date: Mon,  4 Sep 2023 15:52:49 +0400
Message-ID: <20230904115251.4161397-53-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Dmitry Frolov <frolov@swemel.ru>

It is true, that there is no problem during runtime
from the first sight, because the memory is lost just
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
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20230825115818.1091936-1-frolov@swemel.ru>
---
 ui/gtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index c34c133550..a14d56168d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2359,7 +2359,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     VirtualConsole *vc;
 
-    GtkDisplayState *s = g_malloc0(sizeof(*s));
+    GtkDisplayState *s;
     GdkDisplay *window_display;
     GtkIconTheme *theme;
     char *dir;
@@ -2369,6 +2369,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
         exit(1);
     }
     assert(opts->type == DISPLAY_TYPE_GTK);
+    s = g_malloc0(sizeof(*s));
     s->opts = opts;
 
     theme = gtk_icon_theme_get_default();
-- 
2.41.0


