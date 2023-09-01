Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B47A78F6FE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:24:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpD-0006aW-N4; Thu, 31 Aug 2023 22:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpA-0006ZT-9G
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp7-0001RF-Sx
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68c3b9f85b7so1081011b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535028; x=1694139828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ46g3X5MlXZj0BEFn3YDfl7TXV4QZY7r+Hh8MCrB4c=;
 b=iMrDTA3qlVYjAW6wa4ZF7CSXG4YVNyoe4KVU1M4djmVy3SDfwxEwoyDhs7GWozS3A4
 WTdlsREe8pe2JuHjLzCt2zvNIkJ51DYltmQDFnI51Zj9wzlvYr9LUHcCRGy55VbPuu+I
 Ubgm5yDYuApPDt7ToGUBxwX4XM7hnoMlRfujGK7rmKhk0hz7egNNI9l9eytcYaVm4i8j
 XxpRNqpI4heC1P845a8F3RPIUpLXz2/e64iBrzfwJG+FUuAgoOdqhWQfglWvi/MfnjvX
 N0fCT0IqayCSso8PcHzSvLL6bLahd3Zbto4lQisgO+OT6G2cHVh49vtzrlGLFugeNteC
 6woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535028; x=1694139828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ46g3X5MlXZj0BEFn3YDfl7TXV4QZY7r+Hh8MCrB4c=;
 b=E7+IWwTuy1x4iE/oLwVs+b3y5MTSZl9PdA6dMH71Aml1/XSaQNbtrwW5MIwQPqKc3D
 o6vIPgGBGemqj06kaYuicVCb+0P6oOg/jKhNIqdty0/zH9aoBnSY5KSRqaeHIDE4MPMQ
 YUD5LTsjBj+lmobJ5AZRHD31sxLKaKLXx0p+pC8jpeLPPbQf97/hg5aEsuHv3HZH8Fj7
 KiKg7FA4StiU1TnNz2AfR5XB/avNxOHFuwPj/xKjY8iOuxFg0XZ2QkhSqiNBE+nCbj/P
 l4qUXlXpiQYLTN/Cpquu8Brk/KIiLLta6L7I/U3yyd5LfoWtt1s+mrCSTrNxW+HyVTPI
 ZJ8g==
X-Gm-Message-State: AOJu0YwBk0RCCWCVf/UgVGuKKF0uTUcW9tLMWuxfAW1NUHo89cpaNzgV
 3IHXfmk9cfuQfO22L2Emq3vQGsT7a9MuQJk9268=
X-Google-Smtp-Source: AGHT+IHVAu5H+TmcTKD7Tdhgxj9snjB4b+9hQfSl/TEs53x344RsUWJWKEymjMSKd8F/ZoNOO5lHxA==
X-Received: by 2002:a05:6a00:3909:b0:68a:6808:3053 with SMTP id
 fh9-20020a056a00390900b0068a68083053mr1617749pfb.25.1693535028286; 
 Thu, 31 Aug 2023 19:23:48 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 19/33] linux-user: Split out mmap_end
Date: Thu, 31 Aug 2023 19:23:17 -0700
Message-Id: <20230901022331.115247-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Use a subroutine instead of a goto within target_mmap__locked.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 69 +++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e905b1b8f2..caa76eb11a 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -446,6 +446,42 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     }
 }
 
+/*
+ * Record a successful mmap within the user-exec interval tree.
+ */
+static abi_long mmap_end(abi_ulong start, abi_ulong last,
+                         abi_ulong passthrough_start,
+                         abi_ulong passthrough_last,
+                         int flags, int page_flags)
+{
+    if (flags & MAP_ANONYMOUS) {
+        page_flags |= PAGE_ANON;
+    }
+    page_flags |= PAGE_RESET;
+    if (passthrough_start > passthrough_last) {
+        page_set_flags(start, last, page_flags);
+    } else {
+        if (start < passthrough_start) {
+            page_set_flags(start, passthrough_start - 1, page_flags);
+        }
+        page_set_flags(passthrough_start, passthrough_last,
+                       page_flags | PAGE_PASSTHROUGH);
+        if (passthrough_last < last) {
+            page_set_flags(passthrough_last + 1, last, page_flags);
+        }
+    }
+    trace_target_mmap_complete(start);
+    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
+        FILE *f = qemu_log_trylock();
+        if (f) {
+            fprintf(f, "page layout changed following mmap\n");
+            page_dump(f);
+            qemu_log_unlock(f);
+        }
+    }
+    return start;
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -588,7 +624,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                 ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
-            goto the_end;
+            return mmap_end(start, last, -1, 0, flags, page_flags);
         }
 
         /* handle the start of the mapping */
@@ -599,7 +635,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end;
+                return mmap_end(start, last, -1, 0, flags, page_flags);
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -646,33 +682,8 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end:
-    if (flags & MAP_ANONYMOUS) {
-        page_flags |= PAGE_ANON;
-    }
-    page_flags |= PAGE_RESET;
-    if (passthrough_start > passthrough_last) {
-        page_set_flags(start, last, page_flags);
-    } else {
-        if (start < passthrough_start) {
-            page_set_flags(start, passthrough_start - 1, page_flags);
-        }
-        page_set_flags(passthrough_start, passthrough_last,
-                       page_flags | PAGE_PASSTHROUGH);
-        if (passthrough_last < last) {
-            page_set_flags(passthrough_last + 1, last, page_flags);
-        }
-    }
-    trace_target_mmap_complete(start);
-    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
-        FILE *f = qemu_log_trylock();
-        if (f) {
-            fprintf(f, "page layout changed following mmap\n");
-            page_dump(f);
-            qemu_log_unlock(f);
-        }
-    }
-    return start;
+    return mmap_end(start, last, passthrough_start, passthrough_last,
+                    flags, page_flags);
 }
 
 /* NOTE: all the constants are the HOST ones */
-- 
2.34.1


