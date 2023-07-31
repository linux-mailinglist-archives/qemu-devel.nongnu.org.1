Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20227768F80
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNsW-0002Dp-Ao; Mon, 31 Jul 2023 04:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsU-0002D5-C2
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsS-00060e-HN
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bbc7b2133fso25816335ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690790619; x=1691395419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZmw+WGj+dKArQBXoU9nV+Zof62NM5jUx/ZLEkyqwJU=;
 b=fpPmEhC+VlHh2XvX7ONmDZuGIO5moWxYoKyZK1tvppswuBOtfNo3/6uhn+bBDqQ5GE
 ovYYfikbXZeyGxDQ4PdNxAzIOExEcgkAeB6TzT11i4L0534G8DbXyCiyBou7M2sDP8eX
 4vBFPPA4Cd8KadUWpFYgZS3Cq4xRNORnZh2MaeQVERmQpdsJuz8Z7que3l9fWKzFlVn6
 PIIAgG62dUTpaHJU9IJcv9Twyze+ZFzYgdHFNWgPqE9Omx471EHIWUFXRoWIMiWPYxTx
 1p5nd2rdXOOWKQsdRjacypP7eodQ6R+RGRMDr0YTUTYo2puqgT6jZ2C00Vu488+IwaRz
 CwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690790619; x=1691395419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZmw+WGj+dKArQBXoU9nV+Zof62NM5jUx/ZLEkyqwJU=;
 b=EAKf6vX/64lUG6WEPYZldBZDENRMIxpx53JyOkOhavQrU22AV34rRxnaPcTub5GovO
 1vYRWLmSUIphvN4Z+jmZmkmiconQtKwxNBUwFT3ala5J+yspUUgu47RiUnx4mEk1dnn7
 PixNT0SyCdJ2gm+7Ac+nt5kpfptFqvxg+bFq147F4WFFPJSdXZ2G9zTtQ/v2EbjpbWsv
 LmLK8iKCONsppB1nQ0At+eCggtsC/oypmPVyUdLzJ5h7YZB7bkjSsxo4ZI8kkAOiuAup
 D1v+Z4djTsMdQpgckXU6dXWh6TT6xXmOTFk7R4ABv1RIhjo6w3M91lz4WHhSdC5zg7f2
 zipg==
X-Gm-Message-State: ABy/qLYAMKSADJb/oDQp3JrK1y6WVo2Tsm2AAalOqfHpsILyo9pNV4az
 SqhaZA7Zt4DflPc3eaB0WG9e/F6zopKGd3OMwNk=
X-Google-Smtp-Source: APBJJlGqcqLZVZ5vl+Tar9kVsu2WkrOJK40pTCPPbeZxDnty64oe2MdMql9E2TlnbDhC8lIKELnoeg==
X-Received: by 2002:a17:902:c94f:b0:1bb:91f2:bb3e with SMTP id
 i15-20020a170902c94f00b001bb91f2bb3emr9673478pla.49.1690790619111; 
 Mon, 31 Jul 2023 01:03:39 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001b89466a5f4sm7883559plb.105.2023.07.31.01.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:03:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 5/5] linux-user: Do not align brk with host page size
Date: Mon, 31 Jul 2023 17:03:14 +0900
Message-ID: <20230731080317.112658-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080317.112658-1-akihiko.odaki@daynix.com>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index ebdc8c144c..475260b7ce 100644
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
-                                  0, 0);
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
+                              0, 0);
 
+    if (mapped_addr == old_brk) {
         target_brk = brk_val;
-        brk_page = new_host_brk_page;
         return target_brk;
     }
 
-- 
2.41.0


