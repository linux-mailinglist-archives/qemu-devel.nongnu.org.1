Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3384754FFE
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 19:04:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL58f-0007lk-OP; Sun, 16 Jul 2023 13:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qL58L-0007kf-HO
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 13:02:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qL587-0000Jq-UL
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 13:02:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fc02a92dcfso33235635e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jul 2023 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689526913; x=1692118913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=m+aKjXXtzrH6vTx7sZZSVOziqUdTEM3PJZLXAdWDOg8=;
 b=ybSNyHbUvdD1TCu0wuabNzfjLythWJfAKE0mIy5iRac//w67sX7uPK5KJcccpBq5Lc
 LmyIYdgYJroCanVkj72EZSvyN8oT4xkzTiXUiXNA6f6GZw7S+oOSl4ITY9/jKnxKSmdr
 RgstpBYtdcQFhzI3hhcMzjN8js+hBlajvUkeOIWacFwe51BKykBJ7wxIymU2xvODfBq2
 xRgecpnDv4ViWG6iHTehuKdx7CiVfkjLvNgT7tudbFAz+oGmh0SZ37ZwZ2k6ArIEBGU/
 YjeMQYc8JZ9WbUizCu2Kh8qHx7hKE+UNQ6w3A8lp5a2Uv9URkRX8yePJlulf217YsEOF
 ol6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689526913; x=1692118913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m+aKjXXtzrH6vTx7sZZSVOziqUdTEM3PJZLXAdWDOg8=;
 b=eoI94WVe4BixbGt1HEbxhSj1OMErMj/PfhSmKfWirOVprlhWv0ztMjuUCwfEg66ILy
 s9YqsacLVt/bt56gV3SfWzOh1R0v3ZFHyky5YRN/FbPRwtwYC7YCaYwyb4CczBmS83hq
 HdweAaznmUTm4Wgg6LKIZD70E47vAjgyn558btjKFEvZGP+Ehwg9/qry41EVZr4Knj+y
 GishBKi/mTkyMZ4UU6Bzzj9oEhytu0Nyd4UFpcPkEWSHf9qHwio4V2I0RT9MqyndhWCh
 8duxtug6Pht8uSWSW4gQMpfiIXHnVeuEEdjtJLrFUsacp+dftd4YFQ8CW3DW3MFNRo9v
 N8pQ==
X-Gm-Message-State: ABy/qLbfh+qJpmsWhw2vAvBIZ2B3hHnEN/WHUxsHY7/Xs2h0FbdnLlzk
 3UO8lap6Em4UvyTrHSZF/7jgwoGT2FbfYSn1+0pohQ==
X-Google-Smtp-Source: APBJJlGiJh3z09LbZv26OP36a9U/gAr2LnS7s3CxaOKGuV5cSfXUxWaxlraTPrm5YTN7FqaxghkZsQ==
X-Received: by 2002:a05:600c:298:b0:3fc:175:ade7 with SMTP id
 24-20020a05600c029800b003fc0175ade7mr8349175wmk.38.1689526912847; 
 Sun, 16 Jul 2023 10:01:52 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 a5-20020a5d53c5000000b002fb60c7995esm16949077wrw.8.2023.07.16.10.01.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jul 2023 10:01:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-8.1] accel/tcg: Take mmap_lock in load_atomic16_or_exit
Date: Sun, 16 Jul 2023 18:01:50 +0100
Message-Id: <20230716170150.22398-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove the write probe in load_atomic8_or_exit.  There we don't have
the same machinery for testing the existance of an 8-byte cmpxchg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 54 +++++++++++++++-------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 4de0a80492..e7170f8ba2 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -152,19 +152,6 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
         return load_atomic8(pv);
     }
 
-#ifdef CONFIG_USER_ONLY
-    /*
-     * If the page is not writable, then assume the value is immutable
-     * and requires no locking.  This ignores the case of MAP_SHARED with
-     * another process, because the fallback start_exclusive solution
-     * provides no protection across processes.
-     */
-    if (page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
-        uint64_t *p = __builtin_assume_aligned(pv, 8);
-        return *p;
-    }
-#endif
-
     /* Ultimate fallback: re-execute in serial context. */
     cpu_loop_exit_atomic(env_cpu(env), ra);
 }
@@ -186,25 +173,32 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
         return atomic16_read_ro(p);
     }
 
-#ifdef CONFIG_USER_ONLY
-    /*
-     * We can only use cmpxchg to emulate a load if the page is writable.
-     * If the page is not writable, then assume the value is immutable
-     * and requires no locking.  This ignores the case of MAP_SHARED with
-     * another process, because the fallback start_exclusive solution
-     * provides no protection across processes.
-     */
-    if (page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
-        return *p;
-    }
-#endif
-
-    /*
-     * In system mode all guest pages are writable, and for user-only
-     * we have just checked writability.  Try cmpxchg.
-     */
+    /* We can only use cmpxchg to emulate a load if the page is writable. */
     if (HAVE_ATOMIC128_RW) {
+#ifdef CONFIG_USER_ONLY
+        /*
+         * If the page is not writable, then assume the value is immutable
+         * and requires no locking.  This ignores the case of MAP_SHARED with
+         * another process, because the fallback start_exclusive solution
+         * provides no protection across processes.
+         * We must take mmap_lock so that the query remains valid until
+         * the write is complete -- tests/tcg/multiarch/munmap-pthread.c
+         * is an example that can race.
+         */
+        Int128 r;
+
+        mmap_lock();
+        if (page_get_flags(h2g(p)) & PAGE_WRITE_ORG) {
+            r = atomic16_read_rw(p);
+        } else {
+            r = *p;
+        }
+        mmap_unlock();
+        return r;
+#else
+        /* In system mode all guest pages are host writable. */
         return atomic16_read_rw(p);
+#endif
     }
 
     /* Ultimate fallback: re-execute in serial context. */
-- 
2.34.1


