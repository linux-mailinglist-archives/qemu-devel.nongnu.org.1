Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDDD821654
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU2u-0003Do-4B; Mon, 01 Jan 2024 20:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2t-0003DM-37
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:19 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2r-0006yI-IH
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:18 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6da55cc8e78so1691795b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160696; x=1704765496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wg9EFLLWpi5SohBEjtuSdGlbfZAlBUwGcqfT4yUFvzU=;
 b=GwM1sn00+uFANYpDwleArGWWQbKqb+x2Ye8uELpxezt6ly8lDViscHGf9GLmTboUnL
 IZg+/ZPrF7HxqwANSXE6SNHe+X29hKHKy8Z38DIV79ry+DGppCeesqdHLq8eHiAJLd2Z
 ybZBziNa8SDpM0KVHQ3Ck8ZfvzUfeLdCjfLHZlC3StYzWyF1QyVhRMWU4FtRGOTwcGv5
 cQ3rgLRdHtvxR5GB2oFpX7VaR73saI5OxTKViJwJiFl3i4KNP+a8hlf6Yc/VuFQJzO9I
 ZxvuCyprDe6yF8Mj7ChPn0JaEpOGzltnLKDtcoPwPNb/F9GbCDBhM0zoCcTxio7pBoXd
 /4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160696; x=1704765496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wg9EFLLWpi5SohBEjtuSdGlbfZAlBUwGcqfT4yUFvzU=;
 b=xRLLyMUnEdIBmoTBxLlntkS+dBkeWBLq5GqG93Uootsk+pV7bdrQ3+KNLGc2WpFp5i
 Q47kg3anNqHsJFQO957a4JO3U3C41Eem88oTZ7duzzyJxnBZX3IZji88c5Csr7CfoPYr
 qK924bpYbHJ35ykSt3iu+Y4CjHa37ga3QVIYwobsDtCz2/rB9cdTQ2QQLY9ly3CpSHo7
 u8aY9ayv1kQvTBcJ1D5LCOX69sdGLtk/0Pm/boI1swjlUUZ0sHFck2LEM2Ad3R41SD90
 WC80RNVcgZ78a10FDxi6vHOoTVqJHdi/OktlN51dQWbZuBUDb6NU4ZQ7fGQkT8o86gbu
 KBPg==
X-Gm-Message-State: AOJu0Ywahs/kArV8N7G/v6MEpw9J3/YjwqgfzPSrzsmmqLf2sZn2xnwF
 llPCSOqBUbH6s/Jl1WY9G26Bq8IGtJyEky8ljsO56Wi6Kvg=
X-Google-Smtp-Source: AGHT+IECdaUnI10UzsbunB4hFlq/2/1tgvSo9ONowlHk6M1VhGmEJVJv55F2h3OnSrZ2AdldN3yvuQ==
X-Received: by 2002:a05:6a00:6a04:b0:6d9:9277:b702 with SMTP id
 hy4-20020a056a006a0400b006d99277b702mr15270836pfb.1.1704160696186; 
 Mon, 01 Jan 2024 17:58:16 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/33] accel/tcg: Remove qemu_host_page_size from
 page_protect/page_unprotect
Date: Tue,  2 Jan 2024 12:57:36 +1100
Message-Id: <20240102015808.132373-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Use qemu_real_host_page_size instead.  Except for the final mprotect
within page_protect, we already handled host < target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 68b252cb8e..69b7429e31 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -651,16 +651,17 @@ void page_protect(tb_page_addr_t address)
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
@@ -671,7 +672,7 @@ void page_protect(tb_page_addr_t address)
 
     if (unlikely(p->itree.last < last)) {
         /* More than one protection region covers the one host page. */
-        assert(TARGET_PAGE_SIZE < qemu_host_page_size);
+        assert(TARGET_PAGE_SIZE < host_page_size);
         while ((p = pageflags_next(p, start, last)) != NULL) {
             prot |= p->flags;
         }
@@ -679,7 +680,7 @@ void page_protect(tb_page_addr_t address)
 
     if (prot & PAGE_WRITE) {
         pageflags_set_clear(start, last, 0, PAGE_WRITE);
-        mprotect(g2h_untagged(start), qemu_host_page_size,
+        mprotect(g2h_untagged(start), last - start + 1,
                  prot & (PAGE_READ | PAGE_EXEC) ? PROT_READ : PROT_NONE);
     }
 }
@@ -725,18 +726,19 @@ int page_unprotect(target_ulong address, uintptr_t pc)
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


