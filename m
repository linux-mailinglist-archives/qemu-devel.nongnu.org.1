Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C05AA713993
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GLF-0001W0-At; Sun, 28 May 2023 09:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GLC-0001Eg-Kf
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GLA-0008Kl-KO
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uifq9/hStfYF2JjYnG0Cit5tGfRXOCmXnT2IfX361G8=;
 b=NRAvcT30i4/bubxGM7H7s6LR2BNoF9hEGifgg+MdAeO9GxvsypsZ7M0pYPM7Q30z97F/m/
 AjtwZJD1u7tpSppEleyOjbMjuBMB+hj46VO8LLOTe5VHV2KfCsYLzNO0sSvW+x5UkFElfM
 RzmTH/Oc5zdkRneV8WC3y6DPLzJIstc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-DWap3mEYMwe_zPJy8xPTtQ-1; Sun, 28 May 2023 09:21:40 -0400
X-MC-Unique: DWap3mEYMwe_zPJy8xPTtQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F846185A78E;
 Sun, 28 May 2023 13:21:40 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 057F4492B0A;
 Sun, 28 May 2023 13:21:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: [PULL 19/19] ui/gtk: enable backend to send multi-touch events
Date: Sun, 28 May 2023 17:20:16 +0400
Message-Id: <20230528132016.3218152-20-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Sergio Lopez <slp@redhat.com>

GTK3 provides the infrastructure to receive and process multi-touch
events through the "touch-event" signal and the GdkEventTouch type.
Make use of it to transpose events from the host to the guest.

This allows users of machines with hardware capable of receiving
multi-touch events to run guests that can also receive those events
and interpret them as gestures, when appropriate.

An example of this in action can be seen here:

 https://fosstodon.org/@slp/109545849296546767

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230526112925.38794-7-slp@redhat.com>
---
 ui/gtk.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 2b7268124f..e50f950f2b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -130,6 +130,13 @@ typedef struct VCChardev VCChardev;
 DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
                          TYPE_CHARDEV_VC)
 
+struct touch_slot {
+    int x;
+    int y;
+    int tracking_id;
+};
+static struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX];
+
 bool gtk_use_gl_area;
 
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
@@ -1057,6 +1064,82 @@ static gboolean gd_scroll_event(GtkWidget *widget, GdkEventScroll *scroll,
 }
 
 
+static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
+                               void *opaque)
+{
+    VirtualConsole *vc = opaque;
+    struct touch_slot *slot;
+    uint64_t num_slot = GPOINTER_TO_UINT(touch->sequence);
+    bool needs_sync = false;
+    int update;
+    int type = -1;
+    int i;
+
+    if (num_slot >= INPUT_EVENT_SLOTS_MAX) {
+        warn_report("gtk: unexpected touch slot number: % " PRId64" >= %d\n",
+                    num_slot, INPUT_EVENT_SLOTS_MAX);
+        return FALSE;
+    }
+
+    slot = &touch_slots[num_slot];
+    slot->x = touch->x;
+    slot->y = touch->y;
+
+    switch (touch->type) {
+    case GDK_TOUCH_BEGIN:
+        type = INPUT_MULTI_TOUCH_TYPE_BEGIN;
+        slot->tracking_id = num_slot;
+        break;
+    case GDK_TOUCH_UPDATE:
+        type = INPUT_MULTI_TOUCH_TYPE_UPDATE;
+        break;
+    case GDK_TOUCH_END:
+    case GDK_TOUCH_CANCEL:
+        type = INPUT_MULTI_TOUCH_TYPE_END;
+        break;
+    default:
+        warn_report("gtk: unexpected touch event type\n");
+    }
+
+    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; ++i) {
+        if (i == num_slot) {
+            update = type;
+        } else {
+            update = INPUT_MULTI_TOUCH_TYPE_UPDATE;
+        }
+
+        slot = &touch_slots[i];
+
+        if (slot->tracking_id == -1) {
+            continue;
+        }
+
+        if (update == INPUT_MULTI_TOUCH_TYPE_END) {
+            slot->tracking_id = -1;
+            qemu_input_queue_mtt(vc->gfx.dcl.con, update, i, slot->tracking_id);
+            needs_sync = true;
+        } else {
+            qemu_input_queue_mtt(vc->gfx.dcl.con, update, i, slot->tracking_id);
+            qemu_input_queue_btn(vc->gfx.dcl.con, INPUT_BUTTON_TOUCH, true);
+            qemu_input_queue_mtt_abs(vc->gfx.dcl.con,
+                                     INPUT_AXIS_X, (int) slot->x,
+                                     0, surface_width(vc->gfx.ds),
+                                     i, slot->tracking_id);
+            qemu_input_queue_mtt_abs(vc->gfx.dcl.con,
+                                     INPUT_AXIS_Y, (int) slot->y,
+                                     0, surface_height(vc->gfx.ds),
+                                     i, slot->tracking_id);
+            needs_sync = true;
+        }
+    }
+
+    if (needs_sync) {
+        qemu_input_event_sync();
+    }
+
+    return TRUE;
+}
+
 static const guint16 *gd_get_keymap(size_t *maplen)
 {
     GdkDisplay *dpy = gdk_display_get_default();
@@ -1978,6 +2061,8 @@ static void gd_connect_vc_gfx_signals(VirtualConsole *vc)
                          G_CALLBACK(gd_key_event), vc);
         g_signal_connect(vc->gfx.drawing_area, "key-release-event",
                          G_CALLBACK(gd_key_event), vc);
+        g_signal_connect(vc->gfx.drawing_area, "touch-event",
+                         G_CALLBACK(gd_touch_event), vc);
 
         g_signal_connect(vc->gfx.drawing_area, "enter-notify-event",
                          G_CALLBACK(gd_enter_event), vc);
@@ -2087,6 +2172,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               GSList *group, GtkWidget *view_menu)
 {
     bool zoom_to_fit = false;
+    int i;
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
@@ -2134,6 +2220,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                           GDK_BUTTON_PRESS_MASK |
                           GDK_BUTTON_RELEASE_MASK |
                           GDK_BUTTON_MOTION_MASK |
+                          GDK_TOUCH_MASK |
                           GDK_ENTER_NOTIFY_MASK |
                           GDK_LEAVE_NOTIFY_MASK |
                           GDK_SCROLL_MASK |
@@ -2169,6 +2256,11 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
         s->free_scale = true;
     }
 
+    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; i++) {
+        struct touch_slot *slot = &touch_slots[i];
+        slot->tracking_id = -1;
+    }
+
     return group;
 }
 
-- 
2.40.1


