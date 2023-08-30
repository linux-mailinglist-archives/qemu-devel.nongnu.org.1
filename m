Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F478D4B5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:43:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgz-0006Un-Sh; Wed, 30 Aug 2023 05:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgx-0006Kz-VL
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgv-0001Rl-PW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAWXro9PmmZC4Ed5JqhuIeH+6qdeKJI2x23+xCgSDpQ=;
 b=gJJB9dO9R5uJ3LTlbJG2v8d5esZqbNZ/hfKJeAtGv5tRay4wA7r+RskzqbRO7RCGLWCE6H
 v8nyaehlgNEZz3vD13ft7mgucNHNyxTMTRl2FkK7GIYgNnvQbQkZcjkB7nnIJvr+GDxoD9
 IQXLDci9sefrcOcu4KdfHEJAewrFqU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-yjBLsFBwNT6ur0be4_55OQ-1; Wed, 30 Aug 2023 05:40:47 -0400
X-MC-Unique: yjBLsFBwNT6ur0be4_55OQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A535101CC60
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:40:47 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3B571121315;
 Wed, 30 Aug 2023 09:40:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 31/67] ui/vc: move some text console initialization to qom
 handlers
Date: Wed, 30 Aug 2023 13:38:05 +0400
Message-ID: <20230830093843.3531473-32-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 22505d093f..5d521ba79d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1413,9 +1413,20 @@ qemu_text_console_class_init(ObjectClass *oc, void *data)
     }
 }
 
+static const GraphicHwOps text_console_ops = {
+    .invalidate  = text_console_invalidate,
+    .text_update = text_console_update,
+};
+
 static void
 qemu_text_console_init(Object *obj)
 {
+    QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
+
+    fifo8_create(&c->out_fifo, 16);
+    c->total_height = DEFAULT_BACKSCROLL;
+    QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
+    QEMU_CONSOLE(c)->hw = c;
 }
 
 static void
@@ -2528,11 +2539,6 @@ static void text_console_update_cursor(void *opaque)
     }
 }
 
-static const GraphicHwOps text_console_ops = {
-    .invalidate  = text_console_invalidate,
-    .text_update = text_console_update,
-};
-
 static void vc_chr_open(Chardev *chr,
                         ChardevBackend *backend,
                         bool *be_opened,
@@ -2570,9 +2576,6 @@ static void vc_chr_open(Chardev *chr,
     s->chr = chr;
     drv->console = s;
 
-    fifo8_create(&s->out_fifo, 16);
-
-    s->total_height = DEFAULT_BACKSCROLL;
     if (QEMU_CONSOLE(s)->scanout.kind != SCANOUT_SURFACE) {
         if (active_console && active_console->scanout.kind == SCANOUT_SURFACE) {
             g_width = qemu_console_get_width(active_console, g_width);
@@ -2582,9 +2585,6 @@ static void vc_chr_open(Chardev *chr,
         QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
     }
 
-    QEMU_CONSOLE(s)->hw_ops = &text_console_ops;
-    QEMU_CONSOLE(s)->hw = s;
-
     /* set current text attributes to default */
     drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     text_console_resize(s);
-- 
2.41.0


