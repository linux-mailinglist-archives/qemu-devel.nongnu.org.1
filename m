Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45972754917
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:03:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfiu-0004Ea-DI; Sat, 15 Jul 2023 09:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfif-00049O-Ch
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:54:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiX-0001Kb-JH
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso3044055f8f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429227; x=1692021227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfvLV6T2p9fP56/v/Xia6iQ7yK2dQ6zBkNiykDOKhfw=;
 b=EMQyNSaeIKeDjVFlaVD5gqYRd55tk+AR81ac1OEKLIKnmiUvIb0xX9oVRez+CgM8NC
 xNnQkgiPfbsL0cKC+eJRVn8ON5pi6jh1MBH1tpM0NB9485xXe2hrwuDzsJ/JMGXRJkYb
 vlQphrJbOXT5RB8FkrSdlbxweMEpcwlh38UVd0kVsyR39n4JT10rBub3z9V6AZYlahgt
 S0O5DJl19Wb9dUelScpBh0bL4hCE4bEmMXKs/nnC/rJpa6wsWnDV/qULyXzQQoPpbvKQ
 ASp9GG0ahV4n5php7HBCBCJ0rxHqCk0YfaMGjsAbxvLfSgDb8AoyMjD5Brgp8D3bTVjy
 AjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429227; x=1692021227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfvLV6T2p9fP56/v/Xia6iQ7yK2dQ6zBkNiykDOKhfw=;
 b=RP22RhbOWUbkrhiMk9JDuCme8FOv2AIPzwzt7hXI+8f7XwmenR/ExfiFnkPSJF/qoI
 Oe4wG34q1xwtbbRM2oMiOwJqNFaS4omExysW1sofKikLTfaw4FAFAf4VOOml//2qa5wo
 Ma5RHi7RK9MLfyrS968ZgZ4DVPYROW8HVQ7L9OfJy73c487gvZ3DfISIydCpQ7oo77Xb
 +LxiXOR0zsgoaiUJvjfcVOYKWvJ565N3aOTg3I1r09xiBymAblSnSgcOBkd0s8ecc0gf
 eofDgdynGWUwdgWVtssNB9mh0f8SEofiMlJSYhpFacFSSaXhnTxi7CASAg+IHUjr61Ez
 Z73w==
X-Gm-Message-State: ABy/qLYQ9MBhF8oBRisE5M4c0wGiqOmIuQQtlhYThCRLQrIw2DuH3zvB
 htscNUEmHWiHuOd4FNplp2lptUXT+CCEXAVTGMCHeg==
X-Google-Smtp-Source: APBJJlE/DwK53V37TtkYSQjc3adoVzPqzNSyPMQAQJdfbdlCgyqqSq3tOc8oahHwv19lEE6QKZYpYA==
X-Received: by 2002:a5d:5651:0:b0:314:3a3d:5d1f with SMTP id
 j17-20020a5d5651000000b003143a3d5d1fmr7217201wrw.19.1689429227461; 
 Sat, 15 Jul 2023 06:53:47 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/47] linux-user: Use 'last' instead of 'end' in target_mmap
Date: Sat, 15 Jul 2023 14:53:06 +0100
Message-Id: <20230715135317.7219-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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


