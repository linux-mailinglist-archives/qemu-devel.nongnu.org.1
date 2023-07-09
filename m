Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D374C739
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEN-0005q9-LP; Sun, 09 Jul 2023 14:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZEA-0004ef-S7
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE7-0004Ji-QD
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so39224275e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927620; x=1691519620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PG65sHHMcFZxBzSd8xJSgpPdsxuZoeu52o+OB1adTRg=;
 b=bWpCwr6oIeaRCR3Ljp5v3nPuvlCaD/jzUjNqgX71QHYBMq46PU2JuphL67Oz9eG+vH
 zVpSM3rAzArFaDZ9m+94SIgvLZS/YQYvBDOjfSzgpktizCpRmrCddd3eQUwensory+MN
 lFAza014Hzc1tnmVfQyrSM4Kd6tcI8e9zv2bNd/x91JIkl7XCuxXlkwGCvaAPxa98EDb
 Ag5/PbjIev+XMH7tsvC1WIXZuwLqJq5+cGfx9BOgWKI4FV18eCpQ5/6BaDeWXZau26jh
 +qGf0qmFOsaQZq435z7EC5yWjX8xWmjt8wyr/EF51Gvva6pgifU7g1nhIKsR9G+U+QIG
 q/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927620; x=1691519620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PG65sHHMcFZxBzSd8xJSgpPdsxuZoeu52o+OB1adTRg=;
 b=fdFOQVCb9fHzpc+P6bjM0QLvtVllJxNdRa0hT5cjfbNpPHjc8zldBGpbiwNqLrRzcF
 +/lf+ggE/+GkKBMh4eEwUSdNm2jIFcqpR89j+be+yC7UbF0I+gvcnyeNNgCSlmpBS+La
 u4DVjDQICSzTQq9r2Pbw+5GIbR5gofg1WCqlJKQg0JzNuxkFYs4UifwmlakVBXjyQeBf
 GWCE8sgvHMemfXQFPHKyvt+ll0hkaMPfS6c9fPAS2wntR8n7A3PrcJIMOoGvDmd1LJel
 M6XCb3i0THPFSUVGIJZ/9IOFPNVchKx6Cw7sbPe3fiwsWgmq0Idra93aHTZjJsCb0A8M
 39UQ==
X-Gm-Message-State: ABy/qLYtN47WXKm57nbg3jh9b0N7vw/92CLLQ3xYrrxfaLrI+QkoI8MS
 015oktLccEXzGowiLiWOzR/C9CPwDGXXll048V1Pmg==
X-Google-Smtp-Source: APBJJlGAJMcgwp5FHZV0xgXEBkha/Xvi2D3OoLCZySTPTTho9zmRRvlyGCmm+8oLSxb48bXH+6tRcw==
X-Received: by 2002:a1c:7416:0:b0:3fc:27:7e46 with SMTP id
 p22-20020a1c7416000000b003fc00277e46mr6260858wmc.3.1688927620257; 
 Sun, 09 Jul 2023 11:33:40 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 38/45] linux-user: Rename mmap_reserve to mmap_reserve_or_unmap
Date: Sun,  9 Jul 2023 19:29:27 +0100
Message-Id: <20230709182934.309468-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

If !reserved_va, munmap instead and assert success.
Update all callers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-22-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6308787942..22c2869be8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -722,14 +722,14 @@ fail:
     return -1;
 }
 
-static void mmap_reserve(abi_ulong start, abi_ulong len)
+static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
     abi_ulong real_last;
     abi_ulong real_len;
     abi_ulong last;
     abi_ulong a;
-    void *host_start, *ptr;
+    void *host_start;
     int prot;
 
     last = start + len - 1;
@@ -776,9 +776,15 @@ static void mmap_reserve(abi_ulong start, abi_ulong len)
     real_len = real_last - real_start + 1;
     host_start = g2h_untagged(real_start);
 
-    ptr = mmap(host_start, real_len, PROT_NONE,
-               MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-    assert(ptr == host_start);
+    if (reserved_va) {
+        void *ptr = mmap(host_start, real_len, PROT_NONE,
+                         MAP_FIXED | MAP_ANONYMOUS
+                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+        assert(ptr == host_start);
+    } else {
+        int ret = munmap(host_start, real_len);
+        assert(ret == 0);
+    }
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
@@ -830,11 +836,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     ret = 0;
     /* unmap what we can */
     if (real_start < real_end) {
-        if (reserved_va) {
-            mmap_reserve(real_start, real_end - real_start);
-        } else {
-            ret = munmap(g2h_untagged(real_start), real_end - real_start);
-        }
+        mmap_reserve_or_unmap(real_start, real_end - real_start);
     }
 
     if (ret == 0) {
@@ -871,7 +873,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
              * If new and old addresses overlap then the above mremap will
              * already have failed with EINVAL.
              */
-            mmap_reserve(old_addr, old_size);
+            mmap_reserve_or_unmap(old_addr, old_size);
         }
     } else if (flags & MREMAP_MAYMOVE) {
         abi_ulong mmap_start;
@@ -886,7 +888,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                                flags | MREMAP_FIXED,
                                g2h_untagged(mmap_start));
             if (reserved_va) {
-                mmap_reserve(old_addr, old_size);
+                mmap_reserve_or_unmap(old_addr, old_size);
             }
         }
     } else {
@@ -912,7 +914,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                     errno = ENOMEM;
                     host_addr = MAP_FAILED;
                 } else if (reserved_va && old_size > new_size) {
-                    mmap_reserve(old_addr + old_size, old_size - new_size);
+                    mmap_reserve_or_unmap(old_addr + old_size,
+                                          old_size - new_size);
                 }
             }
         } else {
-- 
2.34.1


