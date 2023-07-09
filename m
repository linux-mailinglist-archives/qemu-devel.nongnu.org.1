Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9574C763
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEQ-0005sf-EN; Sun, 09 Jul 2023 14:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZEA-0004di-OG
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE7-0004JX-Py
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so37716355e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927619; x=1691519619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwsEQEgJb6LbDaZv4vgO4Dp17xTKrnyDcX9Cf57n7+Y=;
 b=ai1DTp+ccHs4f1A3033BgUFM6Uw7ESmhWqxSLSPOuYNx47XuZDu4C7f+vRbKbAaWUT
 GeIhdRdnINtPqY3HofItJhLnW4SyPrA2NTYohFa7zEuVwW0Hm2BmAdT8cQ+VJ0NfdOdI
 SQS24I4mUOT6qnuMV84nmam/yTvx0Egh57pS1nQdFvdtTXegRrkYJEZ6VD4hkwV7LMKN
 lahF12qWckmrg5qvPxqNpwipYlexr/HF3P8c21LqAc0Fn8d/En5r5Hn+8isbw3Bavg3X
 P7HHKZ2GF8tinYtSzBURCfK+l9yzJNCk/wnouvCT6jWbF2CpQ1j3nVtSGpqJ8gtClERC
 S4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927619; x=1691519619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwsEQEgJb6LbDaZv4vgO4Dp17xTKrnyDcX9Cf57n7+Y=;
 b=aAQxwh+T3s/wc6A3BfdT/W1qrsIN6jlxqbpWVj5+XDfTq4EEWBwYQjhMy/+wYR4Nks
 tGA9/XlOWye8j0XeDD/G5U+KrtZqtdUVD0MeBUzNjvdPX4eg2QlbYsEuLEcszzYlYzjE
 YESnoDzn6Gny+yF7sBz+uF2TSemcsEDNZDkBODdeuOIL+WnhRbPKqulyOrhc2uHLEvK9
 y+g2J+PmZk87eWs94MSLYrecar65xYy7ZhKL4mTIKaWLQzYFEIoqwEuG0GUkcw2ypdoV
 /csgtyqkjhEhjGpvkrySBs8ZpJa9iVVQsMtW9jSXYxfPp2JrsZZ95BGhQJBMt7H/dhXs
 uWkg==
X-Gm-Message-State: ABy/qLYTGc+UT8NCIUOpmtjTRfDUom6vO8pINetp/+gIwkybQUQBW3Iz
 e2J1PbrIr5urQICVp5ER3ohyFFYDWETcMcavUxtldA==
X-Google-Smtp-Source: APBJJlGsuylhUpLLqcAYJ62JIiqlMMX22d+czLmqbViCM/Ag6gTxt0lJlpsPyHgfHPAKMI8+IlMiYg==
X-Received: by 2002:adf:dec5:0:b0:314:423c:95a3 with SMTP id
 i5-20020adfdec5000000b00314423c95a3mr12599566wrn.9.1688927619494; 
 Sun, 09 Jul 2023 11:33:39 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 37/45] linux-user: Rewrite mmap_reserve
Date: Sun,  9 Jul 2023 19:29:26 +0100
Message-Id: <20230709182934.309468-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

Use 'last' variables instead of 'end' variables; be careful
about avoiding overflow.  Assert that the mmap succeeded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-21-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 68 +++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index bb9cbe52cd..6308787942 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -722,47 +722,63 @@ fail:
     return -1;
 }
 
-static void mmap_reserve(abi_ulong start, abi_ulong size)
+static void mmap_reserve(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
-    abi_ulong real_end;
-    abi_ulong addr;
-    abi_ulong end;
+    abi_ulong real_last;
+    abi_ulong real_len;
+    abi_ulong last;
+    abi_ulong a;
+    void *host_start, *ptr;
     int prot;
 
+    last = start + len - 1;
     real_start = start & qemu_host_page_mask;
-    real_end = HOST_PAGE_ALIGN(start + size);
-    end = start + size;
-    if (start > real_start) {
-        /* handle host page containing start */
+    real_last = HOST_PAGE_ALIGN(last) - 1;
+
+    /*
+     * If guest pages remain on the first or last host pages,
+     * adjust the deallocation to retain those guest pages.
+     * The single page special case is required for the last page,
+     * lest real_start overflow to zero.
+     */
+    if (real_last - real_start < qemu_host_page_size) {
         prot = 0;
-        for (addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
+        for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a);
         }
-        if (real_end == real_start + qemu_host_page_size) {
-            for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-                prot |= page_get_flags(addr);
-            }
-            end = real_end;
+        for (a = last; a < real_last; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a + 1);
+        }
+        if (prot != 0) {
+            return;
+        }
+    } else {
+        for (prot = 0, a = real_start; a < start; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a);
         }
         if (prot != 0) {
             real_start += qemu_host_page_size;
         }
-    }
-    if (end < real_end) {
-        prot = 0;
-        for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
+
+        for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
+            prot |= page_get_flags(a + 1);
         }
         if (prot != 0) {
-            real_end -= qemu_host_page_size;
+            real_last -= qemu_host_page_size;
+        }
+
+        if (real_last < real_start) {
+            return;
         }
     }
-    if (real_start != real_end) {
-        mmap(g2h_untagged(real_start), real_end - real_start, PROT_NONE,
-                 MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE,
-                 -1, 0);
-    }
+
+    real_len = real_last - real_start + 1;
+    host_start = g2h_untagged(real_start);
+
+    ptr = mmap(host_start, real_len, PROT_NONE,
+               MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+    assert(ptr == host_start);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
-- 
2.34.1


