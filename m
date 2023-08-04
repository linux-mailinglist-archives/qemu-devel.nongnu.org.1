Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F151770B9F
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rE-0004nx-Hb; Fri, 04 Aug 2023 18:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2ql-0004aR-0m
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:49 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qi-0001qZ-94
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:46 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-267fc1d776eso1512707a91.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186442; x=1691791242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcmdNjO5rFxrj9FLufrsNHQ94VqSwsdLVl0LIEVlaaw=;
 b=vALiQe0SydAlf+fkGUUJoBvGsj2RqfGaGRZ1jZcZana50bkDH8YTB0/ENgJLXrSncO
 Dfo+5itmqoATnM02V5wRO77nmimqZoHp7Vu8BAUVRXvGDLijsxXDVdDsg9hcAeCXot4j
 y3uqrFUIrxpWNSMUoTTe8BtIgRgi/8q/739h+ruIzqr6rWrrdnbLf3htU1XrCa8zWwsH
 OMb6gOSAf5yZsIAWROH0RrUERJw0ewhMaLES7KuwRvAAwt14NtDPelDR1UEByreFyrKR
 NsF8QyKjbuVKmg2X+ifQXPYaKl78VE7sxpjRhiEB35o/UGLzAf9/qu6Fq4nTFdCWKUDB
 iTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186442; x=1691791242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcmdNjO5rFxrj9FLufrsNHQ94VqSwsdLVl0LIEVlaaw=;
 b=fknXswry8n1Rki1PAXg2SMOR9mt1FyLwa6jOBSOdEu9Rmn5DoENi/5Q8nG1t6NoF0d
 C0tkUjVp0D0xh7X+tc3eLWJ4sdCVdNGI1nWl5ephhGv7TJEzfE4xtdklV0K0UpUPct0Z
 YuOpi2xXxI/mianU+q7pQIih5H/2dCZ+vV1TGP1wUlJelBPfGuLuYBTLYBEs07DWHWJq
 SxhXVk9HzN5RfbpulCojoUBP44zAbgtXOmedqCruHEXxDYo9v+lLRXlkwMyXFCzbQj+C
 tJ0SwZEeM6Yp4dCvGIYDKZe3q/VVziimo/9RkKWS2kXikLNH6avVQK0/hBouK35rxxBl
 chXQ==
X-Gm-Message-State: AOJu0YyEY6BMA+t1eE73t8CNEVRPUJlJW8E5VYY9epUHhkexorHbUT3C
 DQgg1D4H8pmvRitMhcqwP3mJ0wzbWqnm4PfU4AU=
X-Google-Smtp-Source: AGHT+IHkT/EoB3si9+JeczHUZRTVpTfuBDjCQH6KzHOnaPDfgg2x+7Pr6CW6x7EkvLRGYQiO6mepjg==
X-Received: by 2002:a17:90a:3905:b0:268:5919:a276 with SMTP id
 y5-20020a17090a390500b002685919a276mr2505015pjb.20.1691186442548; 
 Fri, 04 Aug 2023 15:00:42 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 10/24] linux-user: Do not align brk with host page size
Date: Fri,  4 Aug 2023 15:00:18 -0700
Message-Id: <20230804220032.295411-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

do_brk() minimizes calls into target_mmap() by aligning the address
with host page size, which is potentially larger than the target page
size. However, the current implementation of this optimization has two
bugs:

- The start of brk is rounded up with the host page size while brk
  advertises an address aligned with the target page size as the
  beginning of brk. This makes the beginning of brk unmapped.
- Content clearing after mapping is flawed. The size to clear is
  specified as HOST_PAGE_ALIGN(brk_page) - brk_page, but brk_page is
  aligned with the host page size so it is always zero.

This optimization actually has no practical benefit. It makes difference
when brk() is called multiple times with values in a range of the host
page size. However, sophisticated memory allocators try to avoid to
make such frequent brk() calls. For example, glibc 2.37 calls brk() to
shrink the heap only when there is a room more than 128 KiB. It is
rare to have a page size larger than 128 KiB if it happens.

Let's remove the optimization to fix the bugs and make the code simpler.

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1616
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-7-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c |  4 ++--
 linux-user/syscall.c | 54 ++++++++++----------------------------------
 2 files changed, 14 insertions(+), 44 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 861ec07abc..2aee2298ec 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3678,8 +3678,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
      * to mmap pages in this space.
      */
     if (info->reserve_brk) {
-        abi_ulong start_brk = HOST_PAGE_ALIGN(info->brk);
-        abi_ulong end_brk = HOST_PAGE_ALIGN(info->brk + info->reserve_brk);
+        abi_ulong start_brk = TARGET_PAGE_ALIGN(info->brk);
+        abi_ulong end_brk = TARGET_PAGE_ALIGN(info->brk + info->reserve_brk);
         target_munmap(start_brk, end_brk - start_brk);
     }
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e1436a3962..7c2c2f6e2f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -802,81 +802,51 @@ static inline int host_to_target_sock_type(int host_type)
 }
 
 static abi_ulong target_brk, initial_target_brk;
-static abi_ulong brk_page;
 
 void target_set_brk(abi_ulong new_brk)
 {
     target_brk = TARGET_PAGE_ALIGN(new_brk);
     initial_target_brk = target_brk;
-    brk_page = HOST_PAGE_ALIGN(target_brk);
 }
 
 /* do_brk() must return target values and target errnos. */
 abi_long do_brk(abi_ulong brk_val)
 {
     abi_long mapped_addr;
-    abi_ulong new_alloc_size;
-    abi_ulong new_brk, new_host_brk_page;
+    abi_ulong new_brk;
+    abi_ulong old_brk;
 
     /* brk pointers are always untagged */
 
-    /* return old brk value if brk_val unchanged */
-    if (brk_val == target_brk) {
-        return target_brk;
-    }
-
     /* do not allow to shrink below initial brk value */
     if (brk_val < initial_target_brk) {
         return target_brk;
     }
 
     new_brk = TARGET_PAGE_ALIGN(brk_val);
-    new_host_brk_page = HOST_PAGE_ALIGN(brk_val);
+    old_brk = TARGET_PAGE_ALIGN(target_brk);
 
-    /* brk_val and old target_brk might be on the same page */
-    if (new_brk == TARGET_PAGE_ALIGN(target_brk)) {
-        /* empty remaining bytes in (possibly larger) host page */
-        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
+    /* new and old target_brk might be on the same page */
+    if (new_brk == old_brk) {
         target_brk = brk_val;
         return target_brk;
     }
 
     /* Release heap if necesary */
-    if (new_brk < target_brk) {
-        /* empty remaining bytes in (possibly larger) host page */
-        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
-
-        /* free unused host pages and set new brk_page */
-        target_munmap(new_host_brk_page, brk_page - new_host_brk_page);
-        brk_page = new_host_brk_page;
+    if (new_brk < old_brk) {
+        target_munmap(new_brk, old_brk - new_brk);
 
         target_brk = brk_val;
         return target_brk;
     }
 
-    if (new_host_brk_page > brk_page) {
-        new_alloc_size = new_host_brk_page - brk_page;
-        mapped_addr = target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ | PROT_WRITE,
-                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVATE,
-                                  -1, 0);
-    } else {
-        new_alloc_size = 0;
-        mapped_addr = brk_page;
-    }
-
-    if (mapped_addr == brk_page) {
-        /* Heap contents are initialized to zero, as for anonymous
-         * mapped pages.  Technically the new pages are already
-         * initialized to zero since they *are* anonymous mapped
-         * pages, however we have to take care with the contents that
-         * come from the remaining part of the previous page: it may
-         * contains garbage data due to a previous heap usage (grown
-         * then shrunken).  */
-        memset(g2h_untagged(brk_page), 0, HOST_PAGE_ALIGN(brk_page) - brk_page);
+    mapped_addr = target_mmap(old_brk, new_brk - old_brk,
+                              PROT_READ | PROT_WRITE,
+                              MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVATE,
+                              -1, 0);
 
+    if (mapped_addr == old_brk) {
         target_brk = brk_val;
-        brk_page = new_host_brk_page;
         return target_brk;
     }
 
-- 
2.34.1


