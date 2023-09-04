Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE59791690
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:56:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8BX-0000kx-5w; Mon, 04 Sep 2023 07:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BF-0000QQ-Po
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8BC-0000lG-K6
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tw8Jfq1yleSfAzzkeHw+4IZ6jVaWLy6lodD1vq/fnME=;
 b=UzPF8lK6ReyYtWEzc2GpTMpaQzZWB8VxVPCriIL0LStH8+SUlk7RQMbsm3O/Su7KO2vbbS
 x6HO6kJ2UyEMIjkr7XKAAXsW08F1O37fBrymC1sACyoHBJVt8tvy7IT49ouuHg5S8r89r5
 4QDyPLSDCcrMmV3/nylz8fnXpxkHLQE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-IOcxeru7NQ6bItJIa5yuUA-1; Mon, 04 Sep 2023 07:55:40 -0400
X-MC-Unique: IOcxeru7NQ6bItJIa5yuUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0086F380671E
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:40 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3350E40C206F;
 Mon,  4 Sep 2023 11:55:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 42/52] ui/vc: move text console invalidate in helper
Date: Mon,  4 Sep 2023 15:52:39 +0400
Message-ID: <20230904115251.4161397-43-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This will allow to split the VC code in a separate unit more easily.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-43-marcandre.lureau@redhat.com>
---
 include/ui/console.h |  1 +
 ui/console.c         | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 0f7f50deaf..91d8bbc9dc 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -521,6 +521,7 @@ void console_select(unsigned int index);
 void qemu_console_resize(QemuConsole *con, int width, int height);
 DisplaySurface *qemu_console_surface(QemuConsole *con);
 void coroutine_fn qemu_console_co_wait_update(QemuConsole *con);
+int qemu_invalidate_text_consoles(void);
 
 /* console-gl.c */
 #ifdef CONFIG_OPENGL
diff --git a/ui/console.c b/ui/console.c
index b1d375ecb4..ba9da8c1b3 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2500,13 +2500,11 @@ static void vc_chr_set_echo(Chardev *chr, bool echo)
     drv->console->echo = echo;
 }
 
-static void text_console_update_cursor(void *opaque)
+int qemu_invalidate_text_consoles(void)
 {
     QemuConsole *s;
     int count = 0;
 
-    cursor_visible_phase = !cursor_visible_phase;
-
     QTAILQ_FOREACH(s, &consoles, next) {
         if (qemu_console_is_graphic(s) ||
             !qemu_console_is_visible(s)) {
@@ -2516,7 +2514,14 @@ static void text_console_update_cursor(void *opaque)
         graphic_hw_invalidate(s);
     }
 
-    if (count) {
+    return count;
+}
+
+static void text_console_update_cursor(void *opaque)
+{
+    cursor_visible_phase = !cursor_visible_phase;
+
+    if (qemu_invalidate_text_consoles()) {
         timer_mod(cursor_timer,
                   qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
     }
-- 
2.41.0


