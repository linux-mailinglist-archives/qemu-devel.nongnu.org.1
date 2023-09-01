Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9E78F706
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtoz-0006TY-0U; Thu, 31 Aug 2023 22:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtow-0006SE-Cc
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtot-0001Nj-Hu
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:38 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a529e1974so1171855b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535013; x=1694139813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0ddZs7bYg6jrh/HugPDxFYzx9+2rJ0wZJYAYZEah5o=;
 b=slvMMuLhNqib2zcWsTXMFpycln0Psey3QkDLkdP2GSpZUp/JWNlhlydrcJDGcl9T1e
 QcHKlU7EZZXd8mA9xfmzO7uj30QEbrrqTuBIwyeZe2K5nnpyuPS5iY71hQEcK4Ionmzi
 vFJJo6dgu5+Pampx29XqPxM3XuWHu+Vl7mhnYH2KsdzzBw7za+BKIakJ4Y9SdrDTzv2F
 23hqRW0LeDep2tWfN8efSznvUpAiVybpubz9+B9nQnNwO9XPMCLU2vH3LvohI+JqJjNe
 CaOhbhnDlpyGMQl7s1OR+mr/6AHap9arDpJDfitulzG7SGFpbMDAdsybYT101AK/SJ8a
 FeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535013; x=1694139813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0ddZs7bYg6jrh/HugPDxFYzx9+2rJ0wZJYAYZEah5o=;
 b=JsswbJEfJRn1V4embR94W1vOeTi0MOotFrvZX+1p8MWp3o4cMUOrDIGm8p2ZOojiA8
 sOnzRQ7REfTyexZSqFW4t43seRNP9XFX+wyRJdwF4+/IOFFQTD7Opw2rNLStvEp+scSd
 r/rmnh/ex2PkODkBZz/lESUuJ5ptHt4FEw3awj4xA9iTZV9dmvHcl/l5IlWJq7OGsFvH
 +6k78BsDKwLj56ON/NqXoBhBMD1bU3GiXKliXJp+8l5NU7TMulowHO6O8ktRJZ42i8lh
 7XwlOk91mH3rUFJMWVkaqQD0lX35Bblh6JEUKPSOfpcKF3TA6P4TP1PpWEkhCV7de4hP
 I3Pw==
X-Gm-Message-State: AOJu0Yz7dimDJt2js7p5xjcgdhnLcd05Z627Z18umDo9bBQH8Lnpybj0
 XUMOj4mKF2Jy2GkjRYVlMLLLPlc7M7QVx8HH46k=
X-Google-Smtp-Source: AGHT+IGyqcCx1LSeaj+QgdzlBR8X+07dimRq54ZuitamRx+tRYsFnbvGnKKFNCSGCdMwHeXNB/pSjA==
X-Received: by 2002:a05:6a00:1a87:b0:68a:5395:7aa9 with SMTP id
 e7-20020a056a001a8700b0068a53957aa9mr1717296pfv.6.1693535013189; 
 Thu, 31 Aug 2023 19:23:33 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 01/33] accel/tcg: Remove qemu_host_page_size from
 page_protect/page_unprotect
Date: Thu, 31 Aug 2023 19:22:59 -0700
Message-Id: <20230901022331.115247-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use qemu_real_host_page_size instead.  Except for the final mprotect
within page_protect, we already handled host < target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ab48cb41e4..4c1697500a 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -650,16 +650,17 @@ void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
     target_ulong start, last;
+    int host_page_size = qemu_real_host_page_size();
     int prot;
 
     assert_memory_lock();
 
-    if (qemu_host_page_size <= TARGET_PAGE_SIZE) {
+    if (host_page_size <= TARGET_PAGE_SIZE) {
         start = address & TARGET_PAGE_MASK;
         last = start + TARGET_PAGE_SIZE - 1;
     } else {
-        start = address & qemu_host_page_mask;
-        last = start + qemu_host_page_size - 1;
+        start = address & -host_page_size;
+        last = start + host_page_size - 1;
     }
 
     p = pageflags_find(start, last);
@@ -670,7 +671,7 @@ void page_protect(tb_page_addr_t address)
 
     if (unlikely(p->itree.last < last)) {
         /* More than one protection region covers the one host page. */
-        assert(TARGET_PAGE_SIZE < qemu_host_page_size);
+        assert(TARGET_PAGE_SIZE < host_page_size);
         while ((p = pageflags_next(p, start, last)) != NULL) {
             prot |= p->flags;
         }
@@ -678,7 +679,7 @@ void page_protect(tb_page_addr_t address)
 
     if (prot & PAGE_WRITE) {
         pageflags_set_clear(start, last, 0, PAGE_WRITE);
-        mprotect(g2h_untagged(start), qemu_host_page_size,
+        mprotect(g2h_untagged(start), last - start + 1,
                  prot & (PAGE_READ | PAGE_EXEC) ? PROT_READ : PROT_NONE);
     }
 }
@@ -724,18 +725,19 @@ int page_unprotect(target_ulong address, uintptr_t pc)
         }
 #endif
     } else {
+        int host_page_size = qemu_real_host_page_size();
         target_ulong start, len, i;
         int prot;
 
-        if (qemu_host_page_size <= TARGET_PAGE_SIZE) {
+        if (host_page_size <= TARGET_PAGE_SIZE) {
             start = address & TARGET_PAGE_MASK;
             len = TARGET_PAGE_SIZE;
             prot = p->flags | PAGE_WRITE;
             pageflags_set_clear(start, start + len - 1, PAGE_WRITE, 0);
             current_tb_invalidated = tb_invalidate_phys_page_unwind(start, pc);
         } else {
-            start = address & qemu_host_page_mask;
-            len = qemu_host_page_size;
+            start = address & -host_page_size;
+            len = host_page_size;
             prot = 0;
 
             for (i = 0; i < len; i += TARGET_PAGE_SIZE) {
-- 
2.34.1


