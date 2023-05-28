Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 506EF71399B
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GKD-0007Xv-1T; Sun, 28 May 2023 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GK2-0007Up-HW
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GK0-000810-0m
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+yBun4joz8CpCnJWZkJ8wIlZdHmkizuP4CqdvuOigY=;
 b=g5WZHev6p7GZlKYoqV65SafYZNZqCdSTYPAr63nWCmsCyuzvfbEg2hW+qdW1qjg1b9Z0BK
 /Y+u/Z6/iERb+kMWsy1gIXPskQiqqOpiKRg3GIT3SH9+Aw8Z+dhO+j3NoH7CTm9Q1iaZ6B
 5ln4n1tF5jm8k5gv41RbJWh1uh5gryw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-I0xSZq8rOwuFmVM8Mw2jYQ-1; Sun, 28 May 2023 09:20:26 -0400
X-MC-Unique: I0xSZq8rOwuFmVM8Mw2jYQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CE8A101A52C;
 Sun, 28 May 2023 13:20:26 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1837E492B00;
 Sun, 28 May 2023 13:20:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Erico Nunes <ernunes@redhat.com>
Subject: [PULL 01/19] ui/gtk: fix passing y0_top parameter to scanout
Date: Sun, 28 May 2023 17:19:58 +0400
Message-Id: <20230528132016.3218152-2-marcandre.lureau@redhat.com>
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

From: Erico Nunes <ernunes@redhat.com>

The dmabuf->y0_top flag is passed to .dpy_gl_scanout_dmabuf(), however
in the gtk ui both implementations dropped it when doing the next
scanout_texture call.

Fixes flipped linux console using vhost-user-gpu with the gtk ui
display.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230220175605.43759-1-ernunes@redhat.com>
---
 ui/gtk-egl.c     | 2 +-
 ui/gtk-gl-area.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index e84431790c..557668e418 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -256,7 +256,7 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
     }
 
     gd_egl_scanout_texture(dcl, dmabuf->texture,
-                           false, dmabuf->width, dmabuf->height,
+                           dmabuf->y0_top, dmabuf->width, dmabuf->height,
                            0, 0, dmabuf->width, dmabuf->height);
 
     if (dmabuf->allow_fences) {
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 7696df1f6b..c384a1516b 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -298,7 +298,7 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
     }
 
     gd_gl_area_scanout_texture(dcl, dmabuf->texture,
-                               false, dmabuf->width, dmabuf->height,
+                               dmabuf->y0_top, dmabuf->width, dmabuf->height,
                                0, 0, dmabuf->width, dmabuf->height);
 
     if (dmabuf->allow_fences) {
-- 
2.40.1


