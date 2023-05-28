Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B61713994
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GL9-0000rc-Ov; Sun, 28 May 2023 09:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GL7-0000hJ-N4
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GL6-0008K3-44
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SWC9t6O/Sc5V5cSODqnjYGoUV3KqFL5ECgzo41W9aY=;
 b=HtAK5iHAZvnwGCdGW1S3YZjaPIeUxjk5SkWrJaE06OP6qo+TNo32Qh72IaU9OIuDWqSHbu
 cA5RcrffQlRHNUAnUN6s0iHJariiUfJ0GetOkQAPVnboZGZ2mC3hxB8DhgW5prhmvjxDgU
 LWM/KbaDrHA9yje1VP5Nw+0h6xHSL9U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-Sm5UPGDPN9200CBCuMn8SA-1; Sun, 28 May 2023 09:21:36 -0400
X-MC-Unique: Sm5UPGDPN9200CBCuMn8SA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED80629ABA0F;
 Sun, 28 May 2023 13:21:35 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5DE5492B00;
 Sun, 28 May 2023 13:21:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: [PULL 18/19] ui: add helpers for virtio-multitouch events
Date: Sun, 28 May 2023 17:20:15 +0400
Message-Id: <20230528132016.3218152-19-marcandre.lureau@redhat.com>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
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

Add helpers for generating Multi-touch events from the UI backends that
can be sent to the guest through a virtio-multitouch device.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230526112925.38794-6-slp@redhat.com>
---
 include/ui/input.h |  5 +++++
 ui/input.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/ui/input.h b/include/ui/input.h
index 2a3dffd417..c29a730a71 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -64,6 +64,11 @@ int qemu_input_scale_axis(int value,
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value);
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in);
+void qemu_input_queue_mtt(QemuConsole *src, InputMultiTouchType type, int slot,
+                          int tracking_id);
+void qemu_input_queue_mtt_abs(QemuConsole *src, InputAxis axis, int value,
+                              int min_in, int max_in,
+                              int slot, int tracking_id);
 
 void qemu_input_check_mode_change(void);
 void qemu_add_mouse_mode_change_notifier(Notifier *notify);
diff --git a/ui/input.c b/ui/input.c
index fc75f1353c..1aad64b07c 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -547,6 +547,42 @@ void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
     qemu_input_event_send(src, &evt);
 }
 
+void qemu_input_queue_mtt(QemuConsole *src, InputMultiTouchType type,
+                          int slot, int tracking_id)
+{
+    InputMultiTouchEvent mtt = {
+        .type = type,
+        .slot = slot,
+        .tracking_id = tracking_id,
+    };
+    InputEvent evt = {
+        .type = INPUT_EVENT_KIND_MTT,
+        .u.mtt.data = &mtt,
+    };
+
+    qemu_input_event_send(src, &evt);
+}
+
+void qemu_input_queue_mtt_abs(QemuConsole *src, InputAxis axis, int value,
+                              int min_in, int max_in, int slot, int tracking_id)
+{
+    InputMultiTouchEvent mtt = {
+        .type = INPUT_MULTI_TOUCH_TYPE_DATA,
+        .slot = slot,
+        .tracking_id = tracking_id,
+        .axis = axis,
+        .value = qemu_input_scale_axis(value, min_in, max_in,
+                                       INPUT_EVENT_ABS_MIN,
+                                       INPUT_EVENT_ABS_MAX),
+    };
+    InputEvent evt = {
+        .type = INPUT_EVENT_KIND_MTT,
+        .u.mtt.data = &mtt,
+    };
+
+    qemu_input_event_send(src, &evt);
+}
+
 void qemu_input_check_mode_change(void)
 {
     static int current_is_absolute;
-- 
2.40.1


