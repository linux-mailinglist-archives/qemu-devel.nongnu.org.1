Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C10791675
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:54:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd88m-00021B-Qs; Mon, 04 Sep 2023 07:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88d-0001za-PL
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88b-0008F0-J5
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPGziKzGBPsTm6kXFIORJt+KfCslq6m16s757uhh9hk=;
 b=OGLEdgVU+yTcVUjAUjH0T6KEdGHApoXIXRWS9vfnn6+7HJbQFfdtkMp11Q0x47ord6DKmV
 n0v+qMlEsHFrjjcTdPEhRW7wQ/jCte41ZhHHW3EKFhUsvctn0EtUHA1/1PLQTTD+ayT3OV
 dFwQ2eyBlyqvF1pcpsfwkGeHfC2DE/s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-EOMZ7R5JNIamXeo4PwRKJA-1; Mon, 04 Sep 2023 07:52:58 -0400
X-MC-Unique: EOMZ7R5JNIamXeo4PwRKJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1CC33C02B81
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:52:58 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1EFE568FF;
 Mon,  4 Sep 2023 11:52:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 01/52] ui: remove qemu_pixman_color() helper
Date: Mon,  4 Sep 2023 15:51:58 +0400
Message-ID: <20230904115251.4161397-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
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

Usage removed in commit e27bd65a72d ("console: switch color_table_rgb to pixman_color_t")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230830093843.3531473-2-marcandre.lureau@redhat.com>
---
 include/ui/qemu-pixman.h |  1 -
 ui/qemu-pixman.c         | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 0c775604d1..fd78d17124 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -78,7 +78,6 @@ pixman_image_t *qemu_pixman_mirror_create(pixman_format_code_t format,
                                           pixman_image_t *image);
 void qemu_pixman_image_unref(pixman_image_t *image);
 
-pixman_color_t qemu_pixman_color(PixelFormat *pf, uint32_t color);
 pixman_image_t *qemu_pixman_glyph_from_vgafont(int height, const uint8_t *font,
                                                unsigned int ch);
 void qemu_pixman_glyph_render(pixman_image_t *glyph,
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index e4f024a85e..c5053cd326 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -226,17 +226,6 @@ void qemu_pixman_image_unref(pixman_image_t *image)
     pixman_image_unref(image);
 }
 
-pixman_color_t qemu_pixman_color(PixelFormat *pf, uint32_t color)
-{
-    pixman_color_t c;
-
-    c.red   = ((color & pf->rmask) >> pf->rshift) << (16 - pf->rbits);
-    c.green = ((color & pf->gmask) >> pf->gshift) << (16 - pf->gbits);
-    c.blue  = ((color & pf->bmask) >> pf->bshift) << (16 - pf->bbits);
-    c.alpha = ((color & pf->amask) >> pf->ashift) << (16 - pf->abits);
-    return c;
-}
-
 pixman_image_t *qemu_pixman_glyph_from_vgafont(int height, const uint8_t *font,
                                                unsigned int ch)
 {
-- 
2.41.0


