Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBFBB03DFD
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 14:01:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHdN-0007RJ-C9; Mon, 14 Jul 2025 07:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH6F-0006gA-Az
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH6D-0003K8-Gm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKPy83W1hiV5/W0xo6GAaKjDBMB+hmRcxLmXHAgpL6c=;
 b=dCc4E3Sd3ayJTayAuJX0TT66yVsoEWV46xT5fLOX7oyOClJ5Zsf2qBLg8a1pFyZ8yFeGPb
 peI0rsBQhehoQVf0BM58gaqzZk9Vk3WyCy/7esoBLsZCFHxi2su5no36GkhWuKfIlt39aL
 iUwo5TQTqZyq6dHl7AI5nXv3k0hD4io=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-FRdI5mDmOf2N66rbl0TBTw-1; Mon,
 14 Jul 2025 07:11:54 -0400
X-MC-Unique: FRdI5mDmOf2N66rbl0TBTw-1
X-Mimecast-MFC-AGG-ID: FRdI5mDmOf2N66rbl0TBTw_1752491513
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F0001956088; Mon, 14 Jul 2025 11:11:53 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5581C19560A3; Mon, 14 Jul 2025 11:11:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Weifeng Liu <weifeng.liu.z@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 11/13] ui/gtk: Add keep-aspect-ratio option
Date: Mon, 14 Jul 2025 15:10:34 +0400
Message-ID: <20250714111039.4150419-12-marcandre.lureau@redhat.com>
In-Reply-To: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
References: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Weifeng Liu <weifeng.liu.z@gmail.com>

When aspect ratio of host window and that of guest display are not
aligned, we can either zoom the guest content to fill the whole host
window or add padding to respect aspect ratio of the guest. Add an
option keep-aspect-ratio to allow users to select their preferred
behavior in this case.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Suggested-by: Kim, Dongwon <dongwon.kim@intel.com>
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20250601045245.36778-2-weifeng.liu.z@gmail.com>
---
 qapi/ui.json     | 12 ++++++++----
 include/ui/gtk.h |  1 +
 ui/gtk.c         | 12 ++++++++++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 514fa159b1..9e496b4835 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1335,13 +1335,17 @@
 # @show-menubar: Display the main window menubar.  Defaults to "on".
 #     (Since 8.0)
 #
+# @keep-aspect-ratio: Keep width/height aspect ratio of guest content when
+#     resizing host window.  Defaults to "on". (Since 10.1)
+#
 # Since: 2.12
 ##
 { 'struct'  : 'DisplayGTK',
-  'data'    : { '*grab-on-hover' : 'bool',
-                '*zoom-to-fit'   : 'bool',
-                '*show-tabs'     : 'bool',
-                '*show-menubar'  : 'bool'  } }
+  'data'    : { '*grab-on-hover'     : 'bool',
+                '*zoom-to-fit'       : 'bool',
+                '*show-tabs'         : 'bool',
+                '*show-menubar'      : 'bool',
+                '*keep-aspect-ratio' : 'bool'  } }
 
 ##
 # @DisplayEGLHeadless:
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index d3944046db..b7cfbf218e 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -140,6 +140,7 @@ struct GtkDisplayState {
     GdkCursor *null_cursor;
     Notifier mouse_mode_notifier;
     gboolean free_scale;
+    gboolean keep_aspect_ratio;
 
     bool external_pause_update;
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 8c4a94c8f6..9104509ee1 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -828,8 +828,12 @@ void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh)
 
         sx = (double)ww / fbw;
         sy = (double)wh / fbh;
-
-        vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
+        if (vc->s->keep_aspect_ratio) {
+            vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
+        } else {
+            vc->gfx.scale_x = sx;
+            vc->gfx.scale_y = sy;
+        }
     }
 }
 /**
@@ -2328,6 +2332,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
         s->free_scale = true;
     }
 
+    s->keep_aspect_ratio = true;
+    if (s->opts->u.gtk.has_keep_aspect_ratio)
+        s->keep_aspect_ratio = s->opts->u.gtk.keep_aspect_ratio;
+
     for (i = 0; i < INPUT_EVENT_SLOTS_MAX; i++) {
         struct touch_slot *slot = &touch_slots[i];
         slot->tracking_id = -1;
-- 
2.50.0


