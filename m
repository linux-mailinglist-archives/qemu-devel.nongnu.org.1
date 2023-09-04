Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B301A7916E0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8BR-0000VG-Oo; Mon, 04 Sep 2023 07:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8B6-0007XA-K0
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8B4-0000fe-Cd
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:36 -0400
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-bHROCRF9NTaw-V1XJ_AkOg-1; Mon, 04 Sep 2023 07:55:32 -0400
X-MC-Unique: bHROCRF9NTaw-V1XJ_AkOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68AA810264C1
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:32 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB2AC1182EB;
 Mon,  4 Sep 2023 11:55:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 40/52] ui/vc: skip text console resize when possible
Date: Mon,  4 Sep 2023 15:52:37 +0400
Message-ID: <20230904115251.4161397-41-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This function is called on invalidate, on each cursor blink.

Avoid the extra copy when the console size didn't change.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-41-marcandre.lureau@redhat.com>
---
 ui/console.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 0a48ce9159..4ee3b77568 100644
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


