Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6977B72FB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:03:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmXK-0002gI-0T; Tue, 03 Oct 2023 17:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnmXC-0002fo-3b
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:02:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnmX9-0007xG-EQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:02:25 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so10686815ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696366941; x=1696971741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N938UrnFkOT2gy6JyFgGyO/OoKqKi29Ln0bJArnR3w0=;
 b=uviH3D9MbNGPHL/5GUamj9Fjxptkm70l+s5xqnc5JSuP2Q942pD+0d4t1tWlOj+CYc
 JgENfPYs4FhThnB/wjfe/W6D170NDf19u7eiXuEP2MwsM4GXILYVwICJa9voaD0faQJV
 BGjUr934/DdW4xe+RnVFlD9P8k9G7eM8u+nv8Ks5EVLWrUl2QkWlxJ19RpgHogWAZo1w
 CHbRi81oAokzJGVBLrrWxu07AmwL9oO+6+u7QhLE7GBlwsi9xI82MxsgzqJ9Ydb7vmGz
 1FgWzg9EyC1wj0ojbq3Va95s5pXakZqB9X57jYKGnRAb5K4UOr7Zt1C5fFl6Lw3a2Bm2
 APlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696366941; x=1696971741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N938UrnFkOT2gy6JyFgGyO/OoKqKi29Ln0bJArnR3w0=;
 b=T+tG6+BsGQetwgQiM2eatkw69R6lqnWeUxlfph+ud1aW7mVMZDIuge2m3Qt2+ceFMh
 kJGasoiXLU6B7fX1+EvYibSxG2h77HUM9NJuPqnaF7fBhah9YkIZtSbYN8C0tBjhL4YL
 RqLllSGOnNxDROikccgCRGSCEbAvzfKeSejDJPsoJmLLDb1hkb39UNfVii5vaL/rD+97
 FO3R51L+0tGzlZsy+O4pdG/ujas/2yxO239t7tchAc/rcqDx9m0Vg3r4bR+Az8HiTuWi
 DIGcp4WKHvYEWlGwXVr+TrMrNnweSeDWXm0HEU4WuaWJEviTwmm6D02f0n0tMcvR1RGk
 3vfQ==
X-Gm-Message-State: AOJu0YwFsjsaOLmcxleceYnVoeDi5hZUsr+GCnIg0JpvBYE8lQew4nBT
 061+VLiJQGdVIlVF4OpkAcT6SYcH1so0PxEyQ0w=
X-Google-Smtp-Source: AGHT+IFVq7r6ntIlB2H9qvqBMiwBB2zX0P9ztERmwDdA/35jlnsKI8KyIQHyq3ceSCYp/kcxejMEjg==
X-Received: by 2002:a17:90b:1a8c:b0:273:ed61:a682 with SMTP id
 ng12-20020a17090b1a8c00b00273ed61a682mr521487pjb.1.1696366941555; 
 Tue, 03 Oct 2023 14:02:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 cu24-20020a17090afa9800b00274b9dd8519sm17493pjb.35.2023.10.03.14.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 14:02:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	Andreas Schwab <schwab@suse.de>
Subject: [PATCH] linux-user: Propagate failure in mmap_reserve_or_unmap back
 to target_munmap
Date: Tue,  3 Oct 2023 14:02:20 -0700
Message-Id: <20231003210220.1713908-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Do not assert success, but return any failure received.
Additionally, fix the method of earlier error return in target_munmap.

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8eaf57b208..2d8b7842d1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -778,7 +778,7 @@ fail:
     return -1;
 }
 
-static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
+static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
     abi_ulong real_last;
@@ -807,7 +807,7 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
             prot |= page_get_flags(a + 1);
         }
         if (prot != 0) {
-            return;
+            return 0;
         }
     } else {
         for (prot = 0, a = real_start; a < start; a += TARGET_PAGE_SIZE) {
@@ -825,7 +825,7 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
         }
 
         if (real_last < real_start) {
-            return;
+            return 0;
         }
     }
 
@@ -836,32 +836,36 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
         void *ptr = mmap(host_start, real_len, PROT_NONE,
                          MAP_FIXED | MAP_ANONYMOUS
                          | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-        assert(ptr == host_start);
-    } else {
-        int ret = munmap(host_start, real_len);
-        assert(ret == 0);
+        return ptr == host_start ? 0 : -1;
     }
+    return munmap(host_start, real_len);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
 {
+    int ret;
+
     trace_target_munmap(start, len);
 
     if (start & ~TARGET_PAGE_MASK) {
-        return -TARGET_EINVAL;
+        errno = EINVAL;
+        return -1;
     }
     len = TARGET_PAGE_ALIGN(len);
     if (len == 0 || !guest_range_valid_untagged(start, len)) {
-        return -TARGET_EINVAL;
+        errno = EINVAL;
+        return -1;
     }
 
     mmap_lock();
-    mmap_reserve_or_unmap(start, len);
-    page_set_flags(start, start + len - 1, 0);
-    shm_region_rm_complete(start, start + len - 1);
+    ret = mmap_reserve_or_unmap(start, len);
+    if (likely(ret == 0)) {
+        page_set_flags(start, start + len - 1, 0);
+        shm_region_rm_complete(start, start + len - 1);
+    }
     mmap_unlock();
 
-    return 0;
+    return ret;
 }
 
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-- 
2.34.1


