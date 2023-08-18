Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233CA781176
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:17:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX321-0008JT-WD; Fri, 18 Aug 2023 13:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31w-0008IH-IA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:01 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31u-00083s-5G
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:00 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so8862655ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378775; x=1692983575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aZCDY6HGP026VqifIVtsa4bWLrsurTMJBgnQi1P0Q6s=;
 b=rzZTAbEZZzl96WAOoxxSWynUwNAe+tUbCrhbZRXFwztOaO4Wf2uvviaFU+anHiC/Rr
 DuLzvhjCJWJQ7BYDqUGfVqMv76rBEsH2azq6Sb0rbtS87OX2diQvaHlPo22lEL6TsdSs
 Dycghc7B7Kznv9SyppTsb+EoTEDxyxIRhshnc3F4qibD2VFtxVBursvUqf6udQhuzHaM
 FuAk77QyIGcZ9Z8GW10j9Mw+Rjt0517+z+UCXQ7DMynsYkJFYdZybG6PgNslCBxDVH5L
 mg7mRliccgQdU+juO2MlvhxQbx/OdQE+bdMzLFexHgLCV6zvkdJRfYdYpr+gc0ArIDwr
 4foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378775; x=1692983575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZCDY6HGP026VqifIVtsa4bWLrsurTMJBgnQi1P0Q6s=;
 b=HfYD2n/lhaIsuYGDGn3FEvajH+gQORZhuOxWT2jwVSsF97gi0gbTBW5g+Th1tAwEEY
 l4pku8N8HvYt9s9TPbd9yCEHIdQtE8QIUeU0vv+TQWhiIO92BKYXx+1OVtFlyMjQfoks
 d8+v1Jy+7CGG7jLoz2GJIMHL15L77pAouvQCGSzTzAkvtsJCTPtCfshOgqsak26xZIAo
 fyqStZGTvQDUK9budziNpfYCRGg6GCSb1cATX/lu91/2rJLGq6QTVkwoJ4LVukHAFqlv
 apwhvGvC5WVRfFX6EZ8tDDf8Z3qzqLFT5ADqlCRBmfgTf4sBHUh73HJX1WIfag6a/u0D
 Havw==
X-Gm-Message-State: AOJu0Ywo1wdhSOXF2ysyxH2XDw1Y+FIGT86z3wKWyXWp9XAmEejdBdyK
 eGbfJHnrfUwmvBkGqjfEwW5PSWANZ3Bv5dU5ydk=
X-Google-Smtp-Source: AGHT+IFs7CH0qp+exTwNpxHp3i0mlHDb+/YJakqiSaDikaXR+JrhzL4ReVMNfir9ohmHXMQTTQ6tRA==
X-Received: by 2002:a17:902:bd93:b0:1b8:3786:3344 with SMTP id
 q19-20020a170902bd9300b001b837863344mr2458204pls.49.1692378775563; 
 Fri, 18 Aug 2023 10:12:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/33] linux-user: Split out mmap_end
Date: Fri, 18 Aug 2023 10:12:13 -0700
Message-Id: <20230818171227.141728-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


