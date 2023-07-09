Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FF74C729
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:35:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEC-0004ms-Gv; Sun, 09 Jul 2023 14:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE8-0004KA-1u
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE3-0004Iz-85
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so4042883f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927618; x=1691519618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfvLV6T2p9fP56/v/Xia6iQ7yK2dQ6zBkNiykDOKhfw=;
 b=Iu769+CeDmbhxeaP4f3c/BUQzMW00to6eQPH8l9S4Twt9ml4jNywDOIozg16e/cLuj
 Y3gdayKKPxma+e1VR2wileGpd3hvnI3CfJ/9DLff9lKI4RqfEeJN26+QXnGmDM27ZXw2
 S5/Ho/+5Hcrf/bZ9BZvfhdh7pYXPRhf15NAFjwYvbDvKM+BW64HZ3fY3MVhsf3tJstOH
 b5NDev7Rog5h/QEcxgFn9Z0Gtc3x0r/HDs2L565wle4XFLOKZSNPPT4++0k8fYJuIrrh
 2guCMO283HZ/eYb+OQwodWXdRmAXOqevFVJp49tC8ph6hRIV2E5gq39Y7cvtlt9S6cyg
 uM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927618; x=1691519618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfvLV6T2p9fP56/v/Xia6iQ7yK2dQ6zBkNiykDOKhfw=;
 b=kil+BwgTdJViItSq0KorjLGF0t4d9Kf9wkSY3SH2hbPxKzQLMvvOL3zqkGwcP1RCgT
 Z9ZxVeZLAxfWorLXW20h0uZc5Ys/16p8BLNJw2Dgh4OBRTkUsmOXoVt7iV4DV57DpBHv
 CZIMu/rxMOBRhZIa87q2aVde+EAfQRGempa/OdoqiE5n/7hp//Rr25t47qd8AzAlqJcF
 +peylS+FrH4hH0/c5TYOQLYH6vEUYIxU4uhG+Af2WuonrAy1BmIcVGhVhaWRfHvcg012
 eb6BMdtsvnV5Hvn1V5K+uv4ZKiGD1Imcd7iAx/csCdyyjxSmWm6yBWnbwmoqsACCMS4u
 ajaA==
X-Gm-Message-State: ABy/qLaKyT7RSxORhzwlXYdJjCzoMnv9mjTcri2JMrVlifJsXqG3CpXH
 i00xPwUxjClI1k/VWzudnZI3ttqnx+0tPvmmS5Ly0A==
X-Google-Smtp-Source: APBJJlG5f59GrLEkDZPzq0oKmGX1P0Qu9yH8iQa2fQLSveoP3Sf4h5anCgRMrF/9/Nk8h0EGHcHWMg==
X-Received: by 2002:adf:ed05:0:b0:313:f0d7:a43 with SMTP id
 a5-20020adfed05000000b00313f0d70a43mr9922790wro.23.1688927617982; 
 Sun, 09 Jul 2023 11:33:37 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 36/45] linux-user: Use 'last' instead of 'end' in target_mmap
Date: Sun,  9 Jul 2023 19:29:24 +0100
Message-Id: <20230709182934.309468-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

Complete the transition within the mmap functions to a formulation
that does not overflow at the end of the address space.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230707204054.8792-20-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 738b9b797d..bb9cbe52cd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -456,8 +456,8 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
-    abi_ulong ret, end, real_start, real_end, retaddr, host_len,
-              passthrough_start = -1, passthrough_end = -1;
+    abi_ulong ret, last, real_start, real_last, retaddr, host_len;
+    abi_ulong passthrough_start = -1, passthrough_last = 0;
     int page_flags;
     off_t host_offset;
 
@@ -581,29 +581,30 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             host_start += offset - host_offset;
         }
         start = h2g(host_start);
+        last = start + len - 1;
         passthrough_start = start;
-        passthrough_end = start + len;
+        passthrough_last = last;
     } else {
         if (start & ~TARGET_PAGE_MASK) {
             errno = EINVAL;
             goto fail;
         }
-        end = start + len;
-        real_end = HOST_PAGE_ALIGN(end);
+        last = start + len - 1;
+        real_last = HOST_PAGE_ALIGN(last) - 1;
 
         /*
          * Test if requested memory area fits target address space
          * It can fail only on 64-bit host with 32-bit target.
          * On any other target/host host mmap() handles this error correctly.
          */
-        if (end < start || !guest_range_valid_untagged(start, len)) {
+        if (last < start || !guest_range_valid_untagged(start, len)) {
             errno = ENOMEM;
             goto fail;
         }
 
         /* Validate that the chosen range is empty. */
         if ((flags & MAP_FIXED_NOREPLACE)
-            && !page_check_range_empty(start, end - 1)) {
+            && !page_check_range_empty(start, last)) {
             errno = EEXIST;
             goto fail;
         }
@@ -642,9 +643,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 
         /* handle the start of the mapping */
         if (start > real_start) {
-            if (real_end == real_start + qemu_host_page_size) {
+            if (real_last == real_start + qemu_host_page_size - 1) {
                 /* one single host page */
-                if (!mmap_frag(real_start, start, end - 1,
+                if (!mmap_frag(real_start, start, last,
                                target_prot, flags, fd, offset)) {
                     goto fail;
                 }
@@ -658,18 +659,18 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             real_start += qemu_host_page_size;
         }
         /* handle the end of the mapping */
-        if (end < real_end) {
-            if (!mmap_frag(real_end - qemu_host_page_size,
-                           real_end - qemu_host_page_size, end - 1,
+        if (last < real_last) {
+            abi_ulong real_page = real_last - qemu_host_page_size + 1;
+            if (!mmap_frag(real_page, real_page, last,
                            target_prot, flags, fd,
-                           offset + real_end - qemu_host_page_size - start)) {
+                           offset + real_page - start)) {
                 goto fail;
             }
-            real_end -= qemu_host_page_size;
+            real_last -= qemu_host_page_size;
         }
 
         /* map the middle (easier) */
-        if (real_start < real_end) {
+        if (real_start < real_last) {
             void *p;
             off_t offset1;
 
@@ -678,13 +679,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             } else {
                 offset1 = offset + real_start - start;
             }
-            p = mmap(g2h_untagged(real_start), real_end - real_start,
+            p = mmap(g2h_untagged(real_start), real_last - real_start + 1,
                      target_to_host_prot(target_prot), flags, fd, offset1);
             if (p == MAP_FAILED) {
                 goto fail;
             }
             passthrough_start = real_start;
-            passthrough_end = real_end;
+            passthrough_last = real_last;
         }
     }
  the_end1:
@@ -692,16 +693,16 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         page_flags |= PAGE_ANON;
     }
     page_flags |= PAGE_RESET;
-    if (passthrough_start == passthrough_end) {
-        page_set_flags(start, start + len - 1, page_flags);
+    if (passthrough_start > passthrough_last) {
+        page_set_flags(start, last, page_flags);
     } else {
         if (start < passthrough_start) {
             page_set_flags(start, passthrough_start - 1, page_flags);
         }
-        page_set_flags(passthrough_start, passthrough_end - 1,
+        page_set_flags(passthrough_start, passthrough_last,
                        page_flags | PAGE_PASSTHROUGH);
-        if (passthrough_end < start + len) {
-            page_set_flags(passthrough_end, start + len - 1, page_flags);
+        if (passthrough_last < last) {
+            page_set_flags(passthrough_last + 1, last, page_flags);
         }
     }
  the_end:
-- 
2.34.1


