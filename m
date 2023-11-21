Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3597F2912
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 10:40:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5NDX-0006Ru-6d; Tue, 21 Nov 2023 04:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5NDU-0006Rb-Mv
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:38:48 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5NDS-000524-5o
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:38:47 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3316bb1303bso2413319f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 01:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700559523; x=1701164323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wlXZSco/DJ1MZcyiWgBQiO9YbVtMIGlTF29irfQo8Ik=;
 b=mQxuaraoBKTD0/446Xe4oUVUth9WdZeIq0SjZ7Tqq2Gr6Mo/QrDsy2aTxR+SGhgUEo
 3H8K+mJiRkAuF/SyS91sgOj/E/r7hQwlE3R6fz6kDgDyBfjTFBq437lzLmKEPvh4KJzi
 kkOKK0vO4GJrB4fWxWgenMZ+tidZK+78cW/ealbDHFYoP33Ei2NPuk2koaTXpbQQCgpK
 fY/WpRmErCCqVYswHWZ/cIv4GnGwMe5gzEy7wHT/bgKrsw5olOrj9K5EMXpxq7hN6r2T
 RLmlBS4bw9Qck1C3nLIDybwzzOoY33vgZSCA3nCiN24FoJK1SMH/ShOGlXtRYJDp6tr4
 Ek4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700559523; x=1701164323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wlXZSco/DJ1MZcyiWgBQiO9YbVtMIGlTF29irfQo8Ik=;
 b=uYwQ+CqdLDXUMDHOzc8ZKwQxBIqV/ZNsHzjVHvliGZ1Oe3haFabaE2yt1e8UkeqVXC
 pY+uMdmZpLjTb33/gnV2Ah1aKCWgTN1dYazKvScNqE5DlYnksXobNTMxGslFITpqVd0c
 IObYIFqQEXmLiiV5PF68Wa4Mu54aCdR0tsdm0YGUA7YDSvdhhgh+TxSV+ujFZB6S7sFo
 FdLR8K+vtebv0ZxdrB+bj1Y8ThyR7O1K/TSnMsGbidiUahlGH+cl9xtudAskJjf5JMGE
 Z5ovGFnDcoWFDOd/9HqGJA7t5DQ978N7WWZEbbTUTr8OgIBHpnx6yu/igvmgdSC4G25U
 PQHg==
X-Gm-Message-State: AOJu0YzcWWg9PXZt6hMLMb13KRaOaqSTDVZU8MXrSxF2AATJIdOPYcf1
 nPB+lTteGN54XvEkfDMYRFqnl5CRBHxL45qBWReFdg==
X-Google-Smtp-Source: AGHT+IE7r6TR7brwIuelBd/i0tWENIXQqlJPkwRqaROuY4eBOUEJWjxCgVkrIoVP20uQsC9jRpVdhw==
X-Received: by 2002:a05:6000:188b:b0:332:c9be:d9bd with SMTP id
 a11-20020a056000188b00b00332c9bed9bdmr4062020wri.45.1700559522796; 
 Tue, 21 Nov 2023 01:38:42 -0800 (PST)
Received: from localhost.localdomain (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a056000014700b0032fab28e9c9sm13968996wrx.73.2023.11.21.01.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 01:38:42 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH for-8.2] ui/pixman-minimal.h: fix empty allocation
Date: Tue, 21 Nov 2023 11:38:39 +0200
Message-Id: <20231121093840.2121195-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In the minimal pixman API stub that is used when the real pixman
dependency is missing a NULL dereference happens when
virtio-gpu-rutabaga allocates a pixman image with bits = NULL and
rowstride_bytes = zero. A buffer of rowstride_bytes * height is
allocated which is NULL. However, in that scenario pixman calculates a
new stride value based on given width, height and format size.

This commit adds a helper function that performs the same logic as
pixman.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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

base-commit: af9264da80073435fd78944bc5a46e695897d7e5
-- 
2.39.2


