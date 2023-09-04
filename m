Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B77791697
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:57:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8BS-0000Yl-Oh; Mon, 04 Sep 2023 07:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Az-0007Cf-90
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Aw-0000dF-S3
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmFenIM6fiAIHCfc6XVEryrdi9dLy3h1rbHdrUpWTCY=;
 b=ds6JlHhO4gs2JEdCc0EjTVoqqIs2QzsmAXZtNtuWh6IsOnbNamDUJlfm7yipJFNg5ePIUr
 K3uLRtUax5n52kGtXEWcn4v5r+sDk2c1nlx2G4mtDDeQZqEo6tunLYFbDfroP6F8jkFEJu
 En1wIee9pf9DpOWK/LJ2KJia0X1gECM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-Cvl8aw57PpiyiI-DxmNFmg-1; Mon, 04 Sep 2023 07:55:25 -0400
X-MC-Unique: Cvl8aw57PpiyiI-DxmNFmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0269380671E
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:24 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BD4A1121314;
 Mon,  4 Sep 2023 11:55:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 38/52] ui/console: assert(surface) where appropriate
Date: Mon,  4 Sep 2023 15:52:35 +0400
Message-ID: <20230904115251.4161397-39-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
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

The QemuTextConsole code paths assume a surface is being used as
scanout, let's make this more explicit.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-39-marcandre.lureau@redhat.com>
---
 ui/console.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index a157a5b31c..04ec2d2488 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -339,6 +339,7 @@ static void qemu_console_fill_rect(QemuConsole *con, int posx, int posy,
         .x = posx, .y = posy, .width = width, .height = height
     };
 
+    assert(surface);
     pixman_image_fill_rectangles(PIXMAN_OP_SRC, surface->image,
                                  &color, 1, &rect);
 }
@@ -349,6 +350,7 @@ static void qemu_console_bitblt(QemuConsole *con,
 {
     DisplaySurface *surface = qemu_console_surface(con);
 
+    assert(surface);
     pixman_image_composite(PIXMAN_OP_SRC,
                            surface->image, NULL, surface->image,
                            xs, ys, 0, 0, xd, yd, w, h);
@@ -392,6 +394,7 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
     DisplaySurface *surface = qemu_console_surface(s);
     pixman_color_t fgcol, bgcol;
 
+    assert(surface);
     if (t_attrib->invers) {
         bgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
         fgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
@@ -519,6 +522,7 @@ static void console_refresh(QemuTextConsole *s)
     TextCell *c;
     int x, y, y1;
 
+    assert(surface);
     s->text_x[0] = 0;
     s->text_y[0] = 0;
     s->text_x[1] = s->width - 1;
-- 
2.41.0


