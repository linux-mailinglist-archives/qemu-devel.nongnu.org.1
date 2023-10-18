Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B97CDDBD
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:45:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6lX-0000Tr-Bf; Wed, 18 Oct 2023 09:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qt6lV-0000SH-KK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qt6lS-0006F3-WF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697636349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6xjrN7887k/ybU0jIiiMTuLEWDRldLbFb/r1uyi5ms=;
 b=MkCM2iy5imZ/kT/aAtSCTyhHP03ank9arNISJyOAAz0PEHEcUWCrK1sBcohRb4kzfIthUh
 PSi8p+D2ih9qlVFnKhGrSocNEGfF1xnAnN96PD5hZiuDjLhpBuWSwVU2+ydLPMPtTev8Rh
 jM60zABrzM1iYzxfMw2+sJAapLzv6eE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-Q306MCuNNqGXEU0tv8S_4A-1; Wed, 18 Oct 2023 09:39:05 -0400
X-MC-Unique: Q306MCuNNqGXEU0tv8S_4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 214A4800C7A;
 Wed, 18 Oct 2023 13:39:05 +0000 (UTC)
Received: from localhost (unknown [10.39.208.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BBC7503B;
 Wed, 18 Oct 2023 13:39:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 09/19] ui/console: when PIXMAN is unavailable,
 don't draw placeholder msg
Date: Wed, 18 Oct 2023 17:38:10 +0400
Message-ID: <20231018133820.1556962-10-marcandre.lureau@redhat.com>
In-Reply-To: <20231018133820.1556962-1-marcandre.lureau@redhat.com>
References: <20231018133820.1556962-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When we can't draw text, simply show a blank display.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


