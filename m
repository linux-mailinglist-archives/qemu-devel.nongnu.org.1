Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA275DBEF
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 13:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNAtQ-00064B-7U; Sat, 22 Jul 2023 07:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNAtL-00062C-US
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:35:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNAtI-0000i5-Ok
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:35:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3144bf65ce9so2126260f8f.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690025710; x=1690630510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwu65N+s8vZwcpL6IuBfk53JluVR+lDy/6W6cKZOd5I=;
 b=v/KbTlbR2C5X3O70K01JPvvOucDhBj+MmTbvOyOBpBghJnuuHxGKVtaKY53t/C6G8Q
 /F5FfJ5cWDuyvxxqYbWwXyCombBjuY9aFUpFApLtbCwakgpUZf4hpeU3YqsUingjXHZE
 rFsBsgVYXTSzQVrflTyd+vHICXhdr6Cgw2KKCbaoc9z33Xp33uNCNC0+kaSM9v6BiW7Q
 RzTkK8iigdC/h+/SpVh47n5S7Edy5z8XWOaJsQYg1plVSqVJtVAtXaVAOrlJWYp7M8WJ
 IVUdTOhzbxaAPwXU99u2vrOx+dKvUJPyEyflcYUabpTR1Fu/cF/VdTdW7/KDcIg/oRyz
 s3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690025710; x=1690630510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwu65N+s8vZwcpL6IuBfk53JluVR+lDy/6W6cKZOd5I=;
 b=LcnLmfCpSS/Ez/X7iZiLSM3VCyFjbAUsNt4ydBF3TZI/d0GlYDJogXdcwwsEQMjTCc
 p3PGZBn6tvSKbGSRp6SerAaE9bsF9KU7orItWZimrGrDqdw9nX3/7JJSlqf88rReXQ/B
 ezLHZ17OBJYcHUs7A/bFs/dFRQcD8G0eYmSYyyYUpa8cRUELK761uwHLYM9naBmif4W0
 3F/uZ449IoeE7PmwGPp4vS6N2WTWv8zkaBFj0P21UZ8upIYkw0U9A7jK1lmJlDsa+WwZ
 cZWBq1gG2nR1B6iFb7FFS9BzaE9PYzHSjHAMPxZJFeHq3+MHjOY/fDF6gi1rOqszhT6Y
 7VJg==
X-Gm-Message-State: ABy/qLaIf2xmJI2rwcLfWUAClKk/ZWwj0Wp3WS2GBgiUgOJx3CQWmF5u
 xjKr2FfMJIujh7imvRtu1nPJsWG2Oxa0Wvz6Y7SWJA==
X-Google-Smtp-Source: APBJJlFKHU86xkzxe60pD2JIlnpFLTvSyDJeimdIKpKVUsPMWbn49NdXQC45ev8bBvTZP02i8gl/Pw==
X-Received: by 2002:adf:e584:0:b0:314:248d:d9df with SMTP id
 l4-20020adfe584000000b00314248dd9dfmr3559375wrm.13.1690025710639; 
 Sat, 22 Jul 2023 04:35:10 -0700 (PDT)
Received: from stoup.acentic.lan
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a7bcd8f000000b003fbdd5d0758sm5130938wmj.22.2023.07.22.04.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 04:35:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 3/3] accel/tcg: Take mmap_lock in load_atomic*_or_exit
Date: Sat, 22 Jul 2023 12:35:07 +0100
Message-Id: <20230722113507.78332-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722113507.78332-1-richard.henderson@linaro.org>
References: <20230722113507.78332-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

For user-only, the probe for page writability may race with another
thread's mprotect.  Take the mmap_lock around the operation.  This
is still faster than the start/end_exclusive fallback.

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


