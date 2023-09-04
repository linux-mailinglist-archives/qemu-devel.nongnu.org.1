Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEA791687
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8Aa-0006Bm-0j; Mon, 04 Sep 2023 07:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8AW-0005xe-V9
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8AU-0000LX-LP
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFQ0KWzPVQZfSv1/4EvjQpexOYJPeODMQsywT4DFGeg=;
 b=eXvtqukkHCGOEOGvKNddBLJRbeIdOV0rZLmiK614oRciGzIs2p75Myxqv31TPMgGmE6Sc+
 h29kHXkhc3YKuoeZ9hoCabCRt8rXXDvFh+eYvrhij4tL3wHF7pWYHSb6hNsnY3Q7Owcxpz
 lebam1qUwIvRGhQghf74h3Jp4ZMwTLc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-tdYQXmTvPUy7Gpej3NttXw-1; Mon, 04 Sep 2023 07:54:56 -0400
X-MC-Unique: tdYQXmTvPUy7Gpej3NttXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 126BD1C2979A
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:54:56 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FF6A2026D4B;
 Mon,  4 Sep 2023 11:54:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 31/52] ui/vc: move some text console initialization to qom
 handlers
Date: Mon,  4 Sep 2023 15:52:28 +0400
Message-ID: <20230904115251.4161397-32-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-32-marcandre.lureau@redhat.com>
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


