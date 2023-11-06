Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 637817E1B10
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:24:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztyJ-0002nT-2k; Mon, 06 Nov 2023 02:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztyA-0002Rw-Kw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzty8-0006P6-AZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUYXOavKjr3nBQePklqtEwSaDfyRGwnYpWD8MCr0umI=;
 b=TJQX61p4vZqtjKrcShgoTb1LQID8/pjP0rK1tJ2j7eWPs28Bez/bZEux2lFJd+XOI41qGv
 uwauLQ5avG6fOe8IaUtLQVN7X/o7UTZbuBhZOMzP65FDxQo7O2KhGMaW/UssqamSaKurI+
 x5BU8Cb6SIzRC08Cb5jD+lYkiFMT3R4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-tl0VdavQP7CJGh3iDGDqZw-1; Mon, 06 Nov 2023 02:24:12 -0500
X-MC-Unique: tl0VdavQP7CJGh3iDGDqZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AA56101A54C;
 Mon,  6 Nov 2023 07:24:12 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DF241121307;
 Mon,  6 Nov 2023 07:24:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 13/23] ui/console: when PIXMAN is unavailable,
 don't draw placeholder msg
Date: Mon,  6 Nov 2023 11:23:02 +0400
Message-ID: <20231106072313.1742543-14-marcandre.lureau@redhat.com>
In-Reply-To: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
References: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When we can't draw text, simply show a blank display.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 ui/console.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index a72c495b5a..8e688d3569 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -584,6 +584,7 @@ DisplaySurface *qemu_create_placeholder_surface(int w, int h,
                                                 const char *msg)
 {
     DisplaySurface *surface = qemu_create_displaysurface(w, h);
+#ifdef CONFIG_PIXMAN
     pixman_color_t bg = QEMU_PIXMAN_COLOR_BLACK;
     pixman_color_t fg = QEMU_PIXMAN_COLOR_GRAY;
     pixman_image_t *glyph;
@@ -598,6 +599,7 @@ DisplaySurface *qemu_create_placeholder_surface(int w, int h,
                                  x+i, y, FONT_WIDTH, FONT_HEIGHT);
         qemu_pixman_image_unref(glyph);
     }
+#endif
     surface->flags |= QEMU_PLACEHOLDER_FLAG;
     return surface;
 }
-- 
2.41.0


