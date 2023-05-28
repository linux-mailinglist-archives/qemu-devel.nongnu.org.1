Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 243DF71399F
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKy-0008Ru-PK; Sun, 28 May 2023 09:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKw-0008R1-16
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GKu-0008Gs-4p
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nllr13g5KC+bhfc4tzi0xHvcEUdSzwg7eGQUYy+8T4=;
 b=cwEhq89iHpxrPGtsYvD6VdyMJMrA+6QWteN/iiQRyBfSv3QpoD7sfrAnhU/9BZbdLq71GY
 lCYwURzNsx+239ISaJcfFijKxfxoztB9qPufA42A1A9o6CGTTVsxQM17cxE1mraPEG3AS3
 OkhamKmjQwGDSPMI0uCqzNKSUMp+BFA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-uxwbEMgoPs2GWvvKQx8U5Q-1; Sun, 28 May 2023 09:21:23 -0400
X-MC-Unique: uxwbEMgoPs2GWvvKQx8U5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45D7929AA384;
 Sun, 28 May 2023 13:21:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0625F112132C;
 Sun, 28 May 2023 13:21:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: [PULL 15/19] ui: add the infrastructure to support MT events
Date: Sun, 28 May 2023 17:20:12 +0400
Message-Id: <20230528132016.3218152-16-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Add the required infrastructure to support generating multitouch events.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20230526112925.38794-3-slp@redhat.com>
---
 qapi/ui.json          | 68 +++++++++++++++++++++++++++++++++++++------
 include/ui/input.h    |  3 ++
 replay/replay-input.c | 18 ++++++++++++
 ui/input.c            |  6 ++++
 ui/trace-events       |  1 +
 5 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index d51e34049c..2755395483 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1055,11 +1055,13 @@
 #
 # @extra: rear side button of a 5-button mouse (since 2.9)
 #
+# @touch: screen contact on a multi-touch device (since 8.1)
+#
 # Since: 2.0
 ##
 { 'enum'  : 'InputButton',
   'data'  : [ 'left', 'middle', 'right', 'wheel-up', 'wheel-down', 'side',
-  'extra', 'wheel-left', 'wheel-right' ] }
+  'extra', 'wheel-left', 'wheel-right', 'touch' ] }
 
 ##
 # @InputAxis:
@@ -1071,6 +1073,17 @@
 { 'enum'  : 'InputAxis',
   'data'  : [ 'x', 'y' ] }
 
+##
+# @InputMultiTouchType:
+#
+# Type of a multi-touch event.
+#
+# Since: 8.1
+##
+{ 'enum'  : 'InputMultiTouchType',
+  'data'  : [ 'begin', 'update', 'end', 'cancel', 'data' ] }
+
+
 ##
 # @InputKeyEvent:
 #
@@ -1117,13 +1130,46 @@
   'data'  : { 'axis'    : 'InputAxis',
               'value'   : 'int' } }
 
+##
+# @InputMultiTouchEvent:
+#
+# MultiTouch input event.
+#
+# @slot: Which slot has generated the event.
+#
+# @tracking-id: ID to correlate this event with previously generated
+#     events.
+#
+# @axis: Which axis is referenced by @value.
+#
+# @value: Contact position.
+#
+# Since: 8.1
+##
+{ 'struct'  : 'InputMultiTouchEvent',
+  'data'  : { 'type'       : 'InputMultiTouchType',
+              'slot'       : 'int',
+              'tracking-id': 'int',
+              'axis'       : 'InputAxis',
+              'value'      : 'int' } }
+
 ##
 # @InputEventKind:
 #
+# @key: a keyboard input event
+#
+# @btn: a pointer button input event
+#
+# @rel: a relative pointer motion input event
+#
+# @abs: an absolute pointer motion input event
+#
+# @mtt: a multi-touch input event
+#
 # Since: 2.0
 ##
 { 'enum': 'InputEventKind',
-  'data': [ 'key', 'btn', 'rel', 'abs' ] }
+  'data': [ 'key', 'btn', 'rel', 'abs', 'mtt' ] }
 
 ##
 # @InputKeyEventWrapper:
@@ -1149,17 +1195,20 @@
 { 'struct': 'InputMoveEventWrapper',
   'data': { 'data': 'InputMoveEvent' } }
 
+##
+# @InputMultiTouchEventWrapper:
+#
+# Since: 8.1
+##
+{ 'struct': 'InputMultiTouchEventWrapper',
+  'data': { 'data': 'InputMultiTouchEvent' } }
+
 ##
 # @InputEvent:
 #
 # Input event union.
 #
-# @type: the input type, one of:
-#
-#     - 'key': Input event of Keyboard
-#     - 'btn': Input event of pointer buttons
-#     - 'rel': Input event of relative pointer motion
-#     - 'abs': Input event of absolute pointer motion
+# @type: the type of input event
 #
 # Since: 2.0
 ##
@@ -1169,7 +1218,8 @@
   'data'  : { 'key'     : 'InputKeyEventWrapper',
               'btn'     : 'InputBtnEventWrapper',
               'rel'     : 'InputMoveEventWrapper',
-              'abs'     : 'InputMoveEventWrapper' } }
+              'abs'     : 'InputMoveEventWrapper',
+              'mtt'     : 'InputMultiTouchEventWrapper' } }
 
 ##
 # @input-send-event:
diff --git a/include/ui/input.h b/include/ui/input.h
index c86219a1c1..2a3dffd417 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -8,9 +8,12 @@
 #define INPUT_EVENT_MASK_BTN   (1<<INPUT_EVENT_KIND_BTN)
 #define INPUT_EVENT_MASK_REL   (1<<INPUT_EVENT_KIND_REL)
 #define INPUT_EVENT_MASK_ABS   (1<<INPUT_EVENT_KIND_ABS)
+#define INPUT_EVENT_MASK_MTT   (1<<INPUT_EVENT_KIND_MTT)
 
 #define INPUT_EVENT_ABS_MIN    0x0000
 #define INPUT_EVENT_ABS_MAX    0x7FFF
+#define INPUT_EVENT_SLOTS_MIN  0x0
+#define INPUT_EVENT_SLOTS_MAX  0xa
 
 typedef struct QemuInputHandler QemuInputHandler;
 typedef struct QemuInputHandlerState QemuInputHandlerState;
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 1147e3d34e..bee3dbe528 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -22,6 +22,7 @@ void replay_save_input_event(InputEvent *evt)
     InputKeyEvent *key;
     InputBtnEvent *btn;
     InputMoveEvent *move;
+    InputMultiTouchEvent *mtt;
     replay_put_dword(evt->type);
 
     switch (evt->type) {
@@ -58,6 +59,14 @@ void replay_save_input_event(InputEvent *evt)
         replay_put_dword(move->axis);
         replay_put_qword(move->value);
         break;
+    case INPUT_EVENT_KIND_MTT:
+        mtt = evt->u.mtt.data;
+        replay_put_dword(mtt->type);
+        replay_put_qword(mtt->slot);
+        replay_put_qword(mtt->tracking_id);
+        replay_put_dword(mtt->axis);
+        replay_put_qword(mtt->value);
+        break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
         break;
@@ -73,6 +82,7 @@ InputEvent *replay_read_input_event(void)
     InputBtnEvent btn;
     InputMoveEvent rel;
     InputMoveEvent abs;
+    InputMultiTouchEvent mtt;
 
     evt.type = replay_get_dword();
     switch (evt.type) {
@@ -109,6 +119,14 @@ InputEvent *replay_read_input_event(void)
         evt.u.abs.data->axis = (InputAxis)replay_get_dword();
         evt.u.abs.data->value = replay_get_qword();
         break;
+    case INPUT_EVENT_KIND_MTT:
+        evt.u.mtt.data = &mtt;
+        evt.u.mtt.data->type = (InputMultiTouchType)replay_get_dword();
+        evt.u.mtt.data->slot = replay_get_qword();
+        evt.u.mtt.data->tracking_id = replay_get_qword();
+        evt.u.mtt.data->axis = (InputAxis)replay_get_dword();
+        evt.u.mtt.data->value = replay_get_qword();
+        break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
         break;
diff --git a/ui/input.c b/ui/input.c
index f2d1e7a3a7..fc75f1353c 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -212,6 +212,7 @@ static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
     InputKeyEvent *key;
     InputBtnEvent *btn;
     InputMoveEvent *move;
+    InputMultiTouchEvent *mtt;
 
     if (src) {
         idx = qemu_console_get_index(src);
@@ -250,6 +251,11 @@ static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
         name = InputAxis_str(move->axis);
         trace_input_event_abs(idx, name, move->value);
         break;
+    case INPUT_EVENT_KIND_MTT:
+        mtt = evt->u.mtt.data;
+        name = InputAxis_str(mtt->axis);
+        trace_input_event_mtt(idx, name, mtt->value);
+        break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
         break;
diff --git a/ui/trace-events b/ui/trace-events
index 977577fbba..6747361745 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -90,6 +90,7 @@ input_event_key_qcode(int conidx, const char *qcode, bool down) "con %d, key qco
 input_event_btn(int conidx, const char *btn, bool down) "con %d, button %s, down %d"
 input_event_rel(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
 input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
+input_event_mtt(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
 input_event_sync(void) ""
 input_mouse_mode(int absolute) "absolute %d"
 
-- 
2.40.1


