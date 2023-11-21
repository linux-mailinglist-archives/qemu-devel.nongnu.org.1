Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E57F2AD0
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:41:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5OBU-0007eZ-Ru; Tue, 21 Nov 2023 05:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r5OBS-0007eG-Uf
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:40:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r5OBR-0003Gl-E1
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700563244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xcSybLVQML97R4ifQxa3cpKai5dO7+D+ef9nCuYM/6s=;
 b=V4oTs7JhT7g78LtcGZZRGsjkPt6BcQyKhfUCXcVnwlevZEQoXUgAp8B9ypE9IRi30CPGcb
 qF3gp8T+jLa0zp389JQRnepmiY0k3Sjh0l8FmmMzPDWjs8N7DskbWJORZ45ZnnT4gJZIcm
 Da8ZQN2WjKAE1BUuBmAyMlgw/o2omNE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-SfJ4gcIQOSazrJCdGOOvIw-1; Tue,
 21 Nov 2023 05:40:43 -0500
X-MC-Unique: SfJ4gcIQOSazrJCdGOOvIw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED10438107A3;
 Tue, 21 Nov 2023 10:40:42 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 238E9492BE0;
 Tue, 21 Nov 2023 10:40:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peter.maydell@linaro.org, dwmw@amazon.co.uk,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 5/5] ui/pixman-minimal.h: fix empty allocation
Date: Tue, 21 Nov 2023 14:40:20 +0400
Message-ID: <20231121104020.2209345-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
References: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

In the minimal pixman API stub that is used when the real pixman
dependency is missing a NULL dereference happens when
virtio-gpu-rutabaga allocates a pixman image with bits = NULL and
rowstride_bytes = zero. A buffer of rowstride_bytes * height is
allocated which is NULL. However, in that scenario pixman calculates a
new stride value based on given width, height and format size.

This commit adds a helper function that performs the same logic as
pixman.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231121093840.2121195-1-manos.pitsidianakis@linaro.org>
---
 include/ui/pixman-minimal.h | 48 +++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/ui/pixman-minimal.h b/include/ui/pixman-minimal.h
index efcf570c9e..6dd7de1c7e 100644
--- a/include/ui/pixman-minimal.h
+++ b/include/ui/pixman-minimal.h
@@ -113,6 +113,45 @@ typedef struct pixman_color {
     uint16_t    alpha;
 } pixman_color_t;
 
+static inline uint32_t *create_bits(pixman_format_code_t format,
+                                    int width,
+                                    int height,
+                                    int *rowstride_bytes)
+{
+    int stride = 0;
+    size_t buf_size = 0;
+    int bpp = PIXMAN_FORMAT_BPP(format);
+
+    /*
+     * Calculate the following while checking for overflow truncation:
+     * stride = ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
+     */
+
+    if (unlikely(__builtin_mul_overflow(width, bpp, &stride))) {
+        return NULL;
+    }
+
+    if (unlikely(__builtin_add_overflow(stride, 0x1f, &stride))) {
+        return NULL;
+    }
+
+    stride >>= 5;
+
+    stride *= sizeof(uint32_t);
+
+    if (unlikely(__builtin_mul_overflow((size_t) height,
+                                        (size_t) stride,
+                                        &buf_size))) {
+        return NULL;
+    }
+
+    if (rowstride_bytes) {
+        *rowstride_bytes = stride;
+    }
+
+    return g_malloc0(buf_size);
+}
+
 static inline pixman_image_t *pixman_image_create_bits(pixman_format_code_t format,
                                                        int width,
                                                        int height,
@@ -123,13 +162,18 @@ static inline pixman_image_t *pixman_image_create_bits(pixman_format_code_t form
 
     i->width = width;
     i->height = height;
-    i->stride = rowstride_bytes ?: width * DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
     i->format = format;
     if (bits) {
         i->data = bits;
     } else {
-        i->free_me = i->data = g_malloc0(rowstride_bytes * height);
+        i->free_me = i->data =
+            create_bits(format, width, height, &rowstride_bytes);
+        if (width && height) {
+            assert(i->data);
+        }
     }
+    i->stride = rowstride_bytes ? rowstride_bytes :
+                            width * DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
     i->ref_count = 1;
 
     return i;
-- 
2.42.0


