Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416578D4EE
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:50:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHiy-00051H-0m; Wed, 30 Aug 2023 05:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHiT-0003aL-Mj
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHiO-0001gF-Q7
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36GFC5TPI0ds1WvEYMWYwriEYzeCfd3nV9CShiKZNcI=;
 b=aZEgziG75F9NTHymDqgIIMD3PJaJx1pUP0CzbSjS9w8cav9Qmcl0cW5SEvl6ONgTybJuGC
 dGninDiNEkybSyyZBH46x0XTHsXrZPeqIJQ+Lu+mbk/lV4wlWU1hcXEqIazlJOVALTFNqz
 p5puV7yccw08lb+YOmrWRXfIAVsT18I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-O9ixrTk9PLCYyn93fi8IxA-1; Wed, 30 Aug 2023 05:42:16 -0400
X-MC-Unique: O9ixrTk9PLCYyn93fi8IxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59870803E2E
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:42:16 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23371C15BAE;
 Wed, 30 Aug 2023 09:42:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 52/67] ui: compile out some qemu-pixman functions when !PIXMAN
Date: Wed, 30 Aug 2023 13:38:26 +0400
Message-ID: <20230830093843.3531473-53-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Those functions require the PIXMAN library.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/qemu-pixman.h | 7 +++++--
 ui/qemu-pixman.c         | 6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 51f8709327..c5a0911cc7 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -70,17 +70,17 @@ pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian);
 pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format);
 uint32_t qemu_pixman_to_drm_format(pixman_format_code_t pixman);
 int qemu_pixman_get_type(int rshift, int gshift, int bshift);
-pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf);
 bool qemu_pixman_check_format(DisplayChangeListener *dcl,
                               pixman_format_code_t format);
 
+#ifdef CONFIG_PIXMAN
+pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf);
 pixman_image_t *qemu_pixman_linebuf_create(pixman_format_code_t format,
                                            int width);
 void qemu_pixman_linebuf_fill(pixman_image_t *linebuf, pixman_image_t *fb,
                               int width, int x, int y);
 pixman_image_t *qemu_pixman_mirror_create(pixman_format_code_t format,
                                           pixman_image_t *image);
-void qemu_pixman_image_unref(pixman_image_t *image);
 
 pixman_image_t *qemu_pixman_glyph_from_vgafont(int height, const uint8_t *font,
                                                unsigned int ch);
@@ -89,6 +89,9 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
                               pixman_color_t *fgcol,
                               pixman_color_t *bgcol,
                               int x, int y, int cw, int ch);
+#endif
+
+void qemu_pixman_image_unref(pixman_image_t *image);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(pixman_image_t, qemu_pixman_image_unref)
 
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index be00a96340..4272a43744 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -143,6 +143,7 @@ int qemu_pixman_get_type(int rshift, int gshift, int bshift)
     return type;
 }
 
+#ifdef CONFIG_PIXMAN
 pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf)
 {
     pixman_format_code_t format;
@@ -156,6 +157,7 @@ pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf)
     }
     return format;
 }
+#endif
 
 /*
  * Return true for known-good pixman conversions.
@@ -184,6 +186,7 @@ bool qemu_pixman_check_format(DisplayChangeListener *dcl,
     }
 }
 
+#ifdef CONFIG_PIXMAN
 pixman_image_t *qemu_pixman_linebuf_create(pixman_format_code_t format,
                                            int width)
 {
@@ -209,6 +212,7 @@ pixman_image_t *qemu_pixman_mirror_create(pixman_format_code_t format,
                                     NULL,
                                     pixman_image_get_stride(image));
 }
+#endif
 
 void qemu_pixman_image_unref(pixman_image_t *image)
 {
@@ -218,6 +222,7 @@ void qemu_pixman_image_unref(pixman_image_t *image)
     pixman_image_unref(image);
 }
 
+#ifdef CONFIG_PIXMAN
 pixman_image_t *qemu_pixman_glyph_from_vgafont(int height, const uint8_t *font,
                                                unsigned int ch)
 {
@@ -260,3 +265,4 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
     pixman_image_unref(ifg);
     pixman_image_unref(ibg);
 }
+#endif /* CONFIG_PIXMAN */
-- 
2.41.0


