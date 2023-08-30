Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FBE78D4B9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:43:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHhd-0000oe-AV; Wed, 30 Aug 2023 05:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhb-0000eb-80
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhY-0001VI-Ll
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fjju3gR+TF3VzUQ77+/5nlp49TSlgQ3IisjTpRbw9JI=;
 b=CfrdtBH1b6aKqrcghpcz1JiJYBsOizaPvzWgp6Wy8knpWSNpr9MG5wV4S4rTK0oonbbB1k
 M/TbcMXHzkAchmmLygSviQ2wc2Lr9ZGvjKxe4rm/2ql5ceE3J+8NdugPMblBd6FePoPxbh
 GzsbnigNzzvH+GNg71IF58J3HORQIig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-qKJymTkGPI-OG0e0rthQVg-1; Wed, 30 Aug 2023 05:41:26 -0400
X-MC-Unique: qKJymTkGPI-OG0e0rthQVg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5D5385CCE2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:41:25 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF108492C14;
 Wed, 30 Aug 2023 09:41:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 40/67] ui/vc: skip text console resize when possible
Date: Wed, 30 Aug 2023 13:38:14 +0400
Message-ID: <20230830093843.3531473-41-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

This function is called on invalidate, on each cursor blink.

Avoid the extra copy when the console size didn't change.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index c31368667d..6163f73640 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -413,13 +413,19 @@ static void text_console_resize(QemuTextConsole *t)
 {
     QemuConsole *s = QEMU_CONSOLE(t);
     TextCell *cells, *c, *c1;
-    int w1, x, y, last_width;
+    int w1, x, y, last_width, w, h;
 
     assert(s->scanout.kind == SCANOUT_SURFACE);
 
+    w = surface_width(s->surface) / FONT_WIDTH;
+    h = surface_height(s->surface) / FONT_HEIGHT;
+    if (w == t->width && h == t->height) {
+        return;
+    }
+
     last_width = t->width;
-    t->width = surface_width(s->surface) / FONT_WIDTH;
-    t->height = surface_height(s->surface) / FONT_HEIGHT;
+    t->width = w;
+    t->height = h;
 
     w1 = last_width;
     if (t->width < w1)
-- 
2.41.0


