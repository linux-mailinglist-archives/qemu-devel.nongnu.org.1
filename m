Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04978D4B0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHhk-0001xo-KF; Wed, 30 Aug 2023 05:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhi-0001q2-MW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhg-0001WT-EH
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbZPdl4MmnEdz3jiVMYa04OYEqlEPn9Irk3oQRO3GDo=;
 b=D/aeaYKHMk2f4/t73KroS4jLGSqeiy/+21jLT4ngJMOcI5RcdWoW4ttnXUgTuSAVKeVQpj
 9owsWIaPkl6StCGz3LqdF0nFnloBWwq06B3ZM45GlKdsiUzFFyuLm9nZxD8NiVulrtpFVO
 IKjbnW+VDEJ7iFRd043G2qM4HMtxb8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-JaUoprGFOFSNtI0wmSQbew-1; Wed, 30 Aug 2023 05:41:34 -0400
X-MC-Unique: JaUoprGFOFSNtI0wmSQbew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B89185CCE0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:41:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19B8E6466B;
 Wed, 30 Aug 2023 09:41:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 42/67] ui/vc: move text console invalidate in helper
Date: Wed, 30 Aug 2023 13:38:16 +0400
Message-ID: <20230830093843.3531473-43-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
index c0b60284b2..7be2d4eef3 100644
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
         timer_mod(cursor_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
                   + CONSOLE_CURSOR_PERIOD / 2);
     }
-- 
2.41.0


