Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FF7A4AE3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEgH-0005rZ-An; Mon, 18 Sep 2023 09:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qiEgF-0005of-4z
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qiEft-0000SQ-LM
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695045147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmceWz+fW/f6mW7ArQcdXxETusp17PAPVXGQctgkm7E=;
 b=I2mZMADVIDdW5h5QyuGMulViCt/h/dZJMAzRYzzQ9qXur+brF2SvAnHDl6xQqzQnkdhAET
 l03QgV2ODaIrPbkfcxJM/TQwZC/i7fmrz5ex/IMjGOEoDYjtO7Quh5sg3EgPdm34i3APKo
 rAJBurQAQD4Mo7IOlk6EfPQPWTNA5Pw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-tP0eUp4aOv2dP3eiHe1XYQ-1; Mon, 18 Sep 2023 09:52:24 -0400
X-MC-Unique: tP0eUp4aOv2dP3eiHe1XYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C59811019C9E;
 Mon, 18 Sep 2023 13:52:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D00F2156701;
 Mon, 18 Sep 2023 13:52:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 03/18] ui: add pixman-compat.h
Date: Mon, 18 Sep 2023 17:51:50 +0400
Message-ID: <20230918135206.2739222-4-marcandre.lureau@redhat.com>
In-Reply-To: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

This is a tiny subset of PIXMAN API that is used pervasively in QEMU
codebase to manage images and identify the underlying format.

It doesn't seems worth to wrap this in a QEMU-specific API.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/pixman-compat.h | 190 +++++++++++++++++++++++++++++++++++++
 include/ui/qemu-pixman.h   |   2 +
 2 files changed, 192 insertions(+)
 create mode 100644 include/ui/pixman-compat.h

diff --git a/include/ui/pixman-compat.h b/include/ui/pixman-compat.h
new file mode 100644
index 0000000000..e511c8b946
--- /dev/null
+++ b/include/ui/pixman-compat.h
@@ -0,0 +1,190 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Tiny subset of PIXMAN API commonly used by QEMU.
+ *
+ * Copyright 1987, 1988, 1989, 1998  The Open Group
+ * Copyright 1987, 1988, 1989 Digital Equipment Corporation
+ * Copyright 1999, 2004, 2008 Keith Packard
+ * Copyright 2000 SuSE, Inc.
+ * Copyright 2000 Keith Packard, member of The XFree86 Project, Inc.
+ * Copyright 2004, 2005, 2007, 2008, 2009, 2010 Red Hat, Inc.
+ * Copyright 2004 Nicholas Miell
+ * Copyright 2005 Lars Knoll & Zack Rusin, Trolltech
+ * Copyright 2005 Trolltech AS
+ * Copyright 2007 Luca Barbato
+ * Copyright 2008 Aaron Plattner, NVIDIA Corporation
+ * Copyright 2008 Rodrigo Kumpera
+ * Copyright 2008 André Tupinambá
+ * Copyright 2008 Mozilla Corporation
+ * Copyright 2008 Frederic Plourde
+ * Copyright 2009, Oracle and/or its affiliates. All rights reserved.
+ * Copyright 2009, 2010 Nokia Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef PIXMAN_COMPAT_H
+#define PIXMAN_COMPAT_H
+
+#define PIXMAN_TYPE_OTHER       0
+#define PIXMAN_TYPE_ARGB        2
+#define PIXMAN_TYPE_ABGR        3
+#define PIXMAN_TYPE_BGRA        8
+#define PIXMAN_TYPE_RGBA        9
+
+#define PIXMAN_FORMAT(bpp,type,a,r,g,b) (((bpp) << 24) |  \
+                                         ((type) << 16) | \
+                                         ((a) << 12) |    \
+                                         ((r) << 8) |     \
+                                         ((g) << 4) |     \
+                                         ((b)))
+
+#define PIXMAN_FORMAT_RESHIFT(val, ofs, num)                            \
+        (((val >> (ofs)) & ((1 << (num)) - 1)) << ((val >> 22) & 3))
+
+#define PIXMAN_FORMAT_BPP(f)    PIXMAN_FORMAT_RESHIFT(f, 24, 8)
+#define PIXMAN_FORMAT_TYPE(f)   (((f) >> 16) & 0x3f)
+#define PIXMAN_FORMAT_A(f)      PIXMAN_FORMAT_RESHIFT(f, 12, 4)
+#define PIXMAN_FORMAT_R(f)      PIXMAN_FORMAT_RESHIFT(f, 8, 4)
+#define PIXMAN_FORMAT_G(f)      PIXMAN_FORMAT_RESHIFT(f, 4, 4)
+#define PIXMAN_FORMAT_B(f)      PIXMAN_FORMAT_RESHIFT(f, 0, 4)
+#define PIXMAN_FORMAT_DEPTH(f)  (PIXMAN_FORMAT_A(f) +   \
+                                 PIXMAN_FORMAT_R(f) +   \
+                                 PIXMAN_FORMAT_G(f) +   \
+                                 PIXMAN_FORMAT_B(f))
+
+typedef enum {
+    /* 32bpp formats */
+    PIXMAN_a8r8g8b8 =    PIXMAN_FORMAT(32,PIXMAN_TYPE_ARGB,8,8,8,8),
+    PIXMAN_x8r8g8b8 =    PIXMAN_FORMAT(32,PIXMAN_TYPE_ARGB,0,8,8,8),
+    PIXMAN_a8b8g8r8 =    PIXMAN_FORMAT(32,PIXMAN_TYPE_ABGR,8,8,8,8),
+    PIXMAN_x8b8g8r8 =    PIXMAN_FORMAT(32,PIXMAN_TYPE_ABGR,0,8,8,8),
+    PIXMAN_b8g8r8a8 =    PIXMAN_FORMAT(32,PIXMAN_TYPE_BGRA,8,8,8,8),
+    PIXMAN_b8g8r8x8 =    PIXMAN_FORMAT(32,PIXMAN_TYPE_BGRA,0,8,8,8),
+    PIXMAN_r8g8b8a8 =    PIXMAN_FORMAT(32,PIXMAN_TYPE_RGBA,8,8,8,8),
+    PIXMAN_r8g8b8x8 =    PIXMAN_FORMAT(32,PIXMAN_TYPE_RGBA,0,8,8,8),
+    /* 24bpp formats */
+    PIXMAN_r8g8b8 =      PIXMAN_FORMAT(24,PIXMAN_TYPE_ARGB,0,8,8,8),
+    PIXMAN_b8g8r8 =      PIXMAN_FORMAT(24,PIXMAN_TYPE_ABGR,0,8,8,8),
+    /* 16bpp formats */
+    PIXMAN_r5g6b5 =      PIXMAN_FORMAT(16,PIXMAN_TYPE_ARGB,0,5,6,5),
+    PIXMAN_a1r5g5b5 =    PIXMAN_FORMAT(16,PIXMAN_TYPE_ARGB,1,5,5,5),
+    PIXMAN_x1r5g5b5 =    PIXMAN_FORMAT(16,PIXMAN_TYPE_ARGB,0,5,5,5),
+} pixman_format_code_t;
+
+typedef struct pixman_image pixman_image_t;
+
+typedef void (* pixman_image_destroy_func_t)(pixman_image_t *image, void *data);
+
+struct pixman_image {
+    int ref_count;
+    pixman_format_code_t format;
+    int width;
+    int height;
+    int stride;
+    uint8_t *data;
+    pixman_image_destroy_func_t destroy_func;
+    void *destroy_data;
+};
+
+typedef struct pixman_color {
+    uint16_t    red;
+    uint16_t    green;
+    uint16_t    blue;
+    uint16_t    alpha;
+} pixman_color_t;
+
+static inline pixman_image_t *pixman_image_create_bits(pixman_format_code_t format,
+                                                       int width,
+                                                       int height,
+                                                       uint32_t *bits,
+                                                       int rowstride_bytes)
+{
+    pixman_image_t *i = g_new0(pixman_image_t, 1);
+
+    i->width = width;
+    i->height = height;
+    i->stride = rowstride_bytes ?: width * DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
+    i->format = format;
+    i->data = bits ?: g_malloc0(rowstride_bytes * height);
+    i->ref_count = 1;
+
+    return i;
+}
+
+static inline pixman_image_t *pixman_image_ref(pixman_image_t *i)
+{
+    i->ref_count++;
+    return i;
+}
+
+static inline bool pixman_image_unref(pixman_image_t *i)
+{
+    i->ref_count--;
+
+    if (i->ref_count == 0) {
+        if (i->destroy_func) {
+            i->destroy_func (i, i->destroy_data);
+            g_free(i->data);
+            g_free(i);
+        }
+
+        return true;
+    }
+
+    return false;
+}
+
+static inline void pixman_image_set_destroy_function(pixman_image_t *i,
+                                                     pixman_image_destroy_func_t func,
+                                                     void *data)
+
+{
+    i->destroy_func = func;
+    i->destroy_data = data;
+}
+
+static inline uint8_t* pixman_image_get_data(pixman_image_t *i)
+{
+    return i->data;
+}
+
+static inline int pixman_image_get_height(pixman_image_t *i)
+{
+    return i->height;
+}
+
+static inline int pixman_image_get_width(pixman_image_t *i)
+{
+    return i->width;
+}
+
+static inline int pixman_image_get_stride(pixman_image_t *i)
+{
+    return i->stride;
+}
+
+static inline pixman_format_code_t pixman_image_get_format(pixman_image_t *i)
+{
+    return i->format;
+}
+
+#endif /* PIXMAN_COMPAT_H */
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 539c089f1d..9c693df8dd 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -12,6 +12,8 @@
 #pragma GCC diagnostic ignored "-Wredundant-decls"
 #include <pixman.h>
 #pragma GCC diagnostic pop
+#else
+#include "pixman-compat.h"
 #endif
 
 /*
-- 
2.41.0


