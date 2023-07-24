Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95075EE72
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrJy-00021g-0b; Mon, 24 Jul 2023 04:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJw-00020E-1D
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJu-0000eP-By
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fd190065a8so39351265e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188813; x=1690793613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtcjV7RLMVbCUSYkAiLh5IZllixWR3iJOTzr/2oXRS0=;
 b=cvcAyU+AZgDpWf1Io/RLMTmwARxeWpyv0NX/Qw1BzUK/nboWFkW75BgBrvS6gfvL68
 eZiPikHTEVYRF2/hSKo6pF9/nyWYc4SSf87FUH0PRnvedIv7xjGJGvGHUF+peQ8hKR8l
 D/NIUenF5dbkHS0Ck5nyi5DSGanLfaA38FPsqhBNFtdgouBlVDgzpS3+mdFYbMYHV4bi
 J3yfJkKLSWlZUX6o90n5uRf73Igk9i4Anqy0vo7sIHQJOZLqUFuys4r2RpRAfdKo+/Mm
 koWuZs08OODB73FfjKc0v5wrHWLfm9TwBYjtIoqxPgwxU9LrSfVGuQ5H6ZmbrHIKQFiM
 2llQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188813; x=1690793613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtcjV7RLMVbCUSYkAiLh5IZllixWR3iJOTzr/2oXRS0=;
 b=G20qr+lFaDf98JRGtTXLtype2CfsXiYOLfFMXiIaobDrRhfV35UrPw16kTLMu9b5sz
 KUpR92gnng5+/dVjUC+eAbxQ+w9kMJIJCzTeUujM2Ia68TDZbyHEQg2X2blagfR0yf5V
 Mm9QvDfYuXbO4ajvXAafUd7eGAK4yC/2nGfZWm2w2wXAHwPhkvAdJjl8q9u4eZLr/j2b
 V+HJCq2THs6sfFewlyGfv9eF8rhS34qxDCDK8Y9wKyEGS1LITcfnMzoAohGHWRI+/jaG
 zoMYc4Avqh6SlAiEMB3h6Ycbtg8Ijkxzswy+sBM6Q1M7tAfw8reIiSyTfZSK+K0zDNn5
 QNKw==
X-Gm-Message-State: ABy/qLY2l7ufELbGztY5wSzpfbqTncRObIEhE3Th0YAkR0j+Fo8L/jw5
 ZXknYE9ZfJczO4qXnQ4dcIhak9FsIyYnGGs/OGh5kg==
X-Google-Smtp-Source: APBJJlEGSBOaLZEEzU68QdP5bgZ4Y3aU+n7ai8CGHWjia+YFD3eQB44EwwtEkY4ggIIvaUuW76BZBg==
X-Received: by 2002:a05:600c:219a:b0:3fb:415f:a85b with SMTP id
 e26-20020a05600c219a00b003fb415fa85bmr7569973wme.3.1690188812917; 
 Mon, 24 Jul 2023 01:53:32 -0700 (PDT)
Received: from stoup.. ([62.252.144.58]) by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm9570994wmi.26.2023.07.24.01.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 01:53:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 4/7] accel/tcg: Take mmap_lock in load_atomic*_or_exit
Date: Mon, 24 Jul 2023 09:53:25 +0100
Message-Id: <20230724085328.4936-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724085328.4936-1-richard.henderson@linaro.org>
References: <20230724085328.4936-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

For user-only, the probe for page writability may race with another
thread's mprotect.  Take the mmap_lock around the operation.  This
is still faster than the start/end_exclusive fallback.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index de70531a7a..e5c590a499 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -159,9 +159,11 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (!page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
-        uint64_t *p = __builtin_assume_aligned(pv, 8);
-        return *p;
+    WITH_MMAP_LOCK_GUARD() {
+        if (!page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
+            uint64_t *p = __builtin_assume_aligned(pv, 8);
+            return *p;
+        }
     }
 #endif
 
@@ -186,25 +188,27 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
         return atomic16_read_ro(p);
     }
 
-#ifdef CONFIG_USER_ONLY
     /*
      * We can only use cmpxchg to emulate a load if the page is writable.
      * If the page is not writable, then assume the value is immutable
      * and requires no locking.  This ignores the case of MAP_SHARED with
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
+     *
+     * In system mode all guest pages are writable.  For user mode,
+     * we must take mmap_lock so that the query remains valid until
+     * the write is complete -- tests/tcg/multiarch/munmap-pthread.c
+     * is an example that can race.
      */
-    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
-        return *p;
-    }
+    WITH_MMAP_LOCK_GUARD() {
+#ifdef CONFIG_USER_ONLY
+        if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
+            return *p;
+        }
 #endif
-
-    /*
-     * In system mode all guest pages are writable, and for user-only
-     * we have just checked writability.  Try cmpxchg.
-     */
-    if (HAVE_ATOMIC128_RW) {
-        return atomic16_read_rw(p);
+        if (HAVE_ATOMIC128_RW) {
+            return atomic16_read_rw(p);
+        }
     }
 
     /* Ultimate fallback: re-execute in serial context. */
-- 
2.34.1


