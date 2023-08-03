Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6449C76DD9B
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWd-0000gR-Ot; Wed, 02 Aug 2023 21:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWa-0000fC-RD
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:12 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWY-0000lU-HR
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:12 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a5ac8717c6so319587b6e.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027589; x=1691632389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcmdNjO5rFxrj9FLufrsNHQ94VqSwsdLVl0LIEVlaaw=;
 b=DRLz2fiUfkvPI1zo0oGor91BpNa8cPoJaYsBO8OJXiLyMltIrOkacwpUg/88tnWEag
 LXERiQtee/WWkVjp/7JMnkhmIPizsgV2C90FyuU4/JiMjEZjY1I5pcVzcejB9QRhO2uG
 4ZVINfg7wXwnyf+cazeJJs76NVkH9BCEC/c65w0YTOHMTulwwD3KNeOZ7oMvcE1l9/Sl
 h2dUMjod1Nd9MSnd31iPpa1kXPCe6Afrnu1GFMTzq/qCxjiESbdTvdn1sfQwFKFMFxmN
 RuKw5ydFyTQi/8hI508hBkzu9/c4fVJWHTV0w6IC7xNtiFYjuBZb5/ss37W+lwvDvA1v
 ehDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027589; x=1691632389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcmdNjO5rFxrj9FLufrsNHQ94VqSwsdLVl0LIEVlaaw=;
 b=RVIvhhj7+ypI8PbCIkiV5lvZuHw0VnIIQHOQCD+grsD96BVwm9dlP8mPf5igXy1tOK
 WiADrXu85Ak5CRKFIpuRgsizWWeZXAphfNAFSYC/LUE/85xIcY0dYf1lcPm2pZ31ddff
 aNbsB2AilULGJhZ9DNxXxy5fUcZTQX8Mpx94a0CrVlvGcVzMM5MBaMufyeMq5E6YqJNV
 lvPpckjahJKC1fQmIl8608P4SSfPeJh1xoCNOHR1JnJX61UJAzRj+D2EUwjriZZxB6Hc
 aj1W30hh5wxb3aOm3DTdpG+OiZJBvEQdINzlW2gNk+2dredDcCuLii4u5XYpCmFXJ4ox
 PoSQ==
X-Gm-Message-State: ABy/qLZ2//4xXmDbYVNArnw76JWbawnHw2+wDgnWt6O5AuJdpGj4i9Fz
 5DGNfhwxaYruFnwAwSF2qDBs6997qmaggB1w/OM=
X-Google-Smtp-Source: APBJJlEGoP8WhRzNwOFp9KjokW+qudsAzzhPLz1uk9YxaEPL2KbxJF2S0W57Fk8s671TB1IP9SxXRQ==
X-Received: by 2002:a05:6358:5284:b0:135:46d9:12f7 with SMTP id
 g4-20020a056358528400b0013546d912f7mr8794992rwa.26.1691027589269; 
 Wed, 02 Aug 2023 18:53:09 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 06/14] linux-user: Do not align brk with host page size
Date: Wed,  2 Aug 2023 18:52:54 -0700
Message-Id: <20230803015302.407219-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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


