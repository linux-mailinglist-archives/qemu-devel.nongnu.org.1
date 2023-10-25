Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3447D7410
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjFI-0004dj-Va; Wed, 25 Oct 2023 15:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvjFE-0004bz-Mw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvjFB-0000Gw-Sv
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698260921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jn0M5HddPTW3wCc5nq/h0iBnVCjIfSYvQaej6oaWHQo=;
 b=eYsSTIJ9ZeGBvShkfi/EF/4/g3TkSKndgjlfL5J6RnQUnTTYZBlEhv9x/XvU0GHeu/M3/7
 JIAJHTAJs640hr7BwZaSyND4kBDDnLh7Sb1V/Qe31nY5izZndhHpkBEWmk37shdfweIWI1
 v/yjJjteBEao3j4NGcIyEV+fEdR+JtQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-7XzTg0s8OUmwfNYIBL-2Lg-1; Wed, 25 Oct 2023 15:08:36 -0400
X-MC-Unique: 7XzTg0s8OUmwfNYIBL-2Lg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F100811E8D;
 Wed, 25 Oct 2023 19:08:35 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D59840C6F79;
 Wed, 25 Oct 2023 19:08:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 03/23] ui: compile out some qemu-pixman functions when
 !PIXMAN
Date: Wed, 25 Oct 2023 23:07:57 +0400
Message-ID: <20231025190818.3278423-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/ui/qemu-pixman.h | 7 +++++--
 ui/qemu-pixman.c         | 6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 4bfa8fae0c..c140cd84b6 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -72,17 +72,17 @@ pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian);
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
@@ -91,6 +91,9 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
                               pixman_color_t *fgcol,
                               pixman_color_t *bgcol,
                               int x, int y, int cw, int ch);
+#endif
+
+void qemu_pixman_image_unref(pixman_image_t *image);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(pixman_image_t, qemu_pixman_image_unref)
 
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index b43ec38bf0..5ca55dd199 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -145,6 +145,7 @@ int qemu_pixman_get_type(int rshift, int gshift, int bshift)
     return type;
 }
 
+#ifdef CONFIG_PIXMAN
 pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf)
 {
     pixman_format_code_t format;
@@ -158,6 +159,7 @@ pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf)
     }
     return format;
 }
+#endif
 
 /*
  * Return true for known-good pixman conversions.
@@ -186,6 +188,7 @@ bool qemu_pixman_check_format(DisplayChangeListener *dcl,
     }
 }
 
+#ifdef CONFIG_PIXMAN
 pixman_image_t *qemu_pixman_linebuf_create(pixman_format_code_t format,
                                            int width)
 {
@@ -211,6 +214,7 @@ pixman_image_t *qemu_pixman_mirror_create(pixman_format_code_t format,
                                     NULL,
                                     pixman_image_get_stride(image));
 }
+#endif
 
 void qemu_pixman_image_unref(pixman_image_t *image)
 {
@@ -220,6 +224,7 @@ void qemu_pixman_image_unref(pixman_image_t *image)
     pixman_image_unref(image);
 }
 
+#ifdef CONFIG_PIXMAN
 pixman_image_t *qemu_pixman_glyph_from_vgafont(int height, const uint8_t *font,
                                                unsigned int ch)
 {
@@ -262,3 +267,4 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
     pixman_image_unref(ifg);
     pixman_image_unref(ibg);
 }
+#endif /* CONFIG_PIXMAN */
-- 
2.41.0


