Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067477A0F2B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtB1-0003ZE-Oq; Thu, 14 Sep 2023 16:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAr-0003Nh-7k
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAp-0006Oq-GM
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso1253568f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724169; x=1695328969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYIaVv5fzpG/4IW8/3zE5TeazHpFYJhJio5PGpCXaJY=;
 b=PdaFDpudHUPolAmDMs2Jm0e8YNAwRyaQoztNgmtoErhnS/VF5KNvLxLKpyEETLLHON
 tIi71qs/kQKzUsSieDNJgDA9NRGhCNVrlLzyoXRJNY1TF3wzxqfJw9ju+dbDLCDPNOrt
 IOox3/O3sDgwI/bo/Ftov0Is8gil6TxH5JOxYJdikvvEfQP+8OudIkBz4jP51IpY3Qna
 OAIFVSHPORI/T57oAzvpf6QhWSFmSkTBodmD/JQ/mTVJxh3UVJVYvUcB6lL9JInmFW8t
 LbE8BUje3M6ho5Zl/Hm38sjSugfB0ao5UDL4afE/nPmjqTizlU5Au+33MOu8zYi8EmIF
 74NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724169; x=1695328969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYIaVv5fzpG/4IW8/3zE5TeazHpFYJhJio5PGpCXaJY=;
 b=OUbUrnha/BPrawRFqBImbqQyAzRX4bDrVYlKLPxWGT5ztVgK1UL8xgZVNkCzQc7hbR
 HVyJQ6Z0Jum1EGGjivWb9JtsSFp9rCXguLAa+0LvXMqZ2vDJ5F4Sng1xJvlWH/mQ/cOl
 j+Vn69i20XjmAtpJ/XDhAAxQjpBd0tJkKWrBtE7/bXZhOotDzqg61Yyvp3KsJQda627T
 kjz2HgxiGs8e3KJytT8NKB5TytF3xyi5SOsv2mQdURjUm0ybZB68xXRjOnR0hkJKA1Sj
 /a8iiWO9iI1xKDPPDj6rP4fId8hHinI8AE0cN8s2zJ3RPq7yEEiQImcWo1ohB5uX8xkT
 6uGw==
X-Gm-Message-State: AOJu0YyEm/BHPyAZ0HSKcfNu4VYerRyVJS6bQjaWLcLVUBMLjFIqPv8I
 UlbhF0XfqK7M+xee/oSFB/VmPaE2los=
X-Google-Smtp-Source: AGHT+IFEcnZtvQe1SwmlWk9AqxBTHYW0b6unqCbhOArNdqykcZU4XDufM9DcxhcA76reBuWRgVSQww==
X-Received: by 2002:a05:6000:1a54:b0:317:6470:3271 with SMTP id
 t20-20020a0560001a5400b0031764703271mr5444213wry.45.1694724169563; 
 Thu, 14 Sep 2023 13:42:49 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 16/23] bsd-user: Implment madvise(2) to match the
 linux-user implementation.
Date: Thu, 14 Sep 2023 23:41:00 +0300
Message-ID: <20230914204107.23778-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 53 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 +++
 bsd-user/syscall_defs.h       |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 16c22593bf..b00ab3aed8 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -129,6 +129,59 @@ static inline abi_long do_bsd_munlockall(void)
     return get_errno(munlockall());
 }
 
+/* madvise(2) */
+static inline abi_long do_bsd_madvise(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    abi_ulong len;
+    int ret = 0;
+    abi_long start = arg1;
+    abi_long len_in = arg2;
+    abi_long advice = arg3;
+
+    if (start & ~TARGET_PAGE_MASK) {
+        return -TARGET_EINVAL;
+    }
+    if (len_in == 0) {
+        return 0;
+    }
+    len = TARGET_PAGE_ALIGN(len_in);
+    if (len == 0 || !guest_range_valid_untagged(start, len)) {
+        return -TARGET_EINVAL;
+    }
+
+    /*
+     * Most advice values are hints, so ignoring and returning success is ok.
+     *
+     * However, some advice values such as MADV_DONTNEED, are not hints and
+     * need to be emulated.
+     *
+     * A straight passthrough for those may not be safe because qemu sometimes
+     * turns private file-backed mappings into anonymous mappings.
+     * If all guest pages have PAGE_PASSTHROUGH set, mappings have the
+     * same semantics for the host as for the guest.
+     *
+     * MADV_DONTNEED is passed through, if possible.
+     * If passthrough isn't possible, we nevertheless (wrongly!) return
+     * success, which is broken but some userspace programs fail to work
+     * otherwise. Completely implementing such emulation is quite complicated
+     * though.
+     */
+    mmap_lock();
+    switch (advice) {
+    case MADV_DONTNEED:
+        if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
+            ret = get_errno(madvise(g2h_untagged(start), len, advice));
+            if (ret == 0) {
+                page_reset_target_data(start, start + len - 1);
+            }
+        }
+    }
+    mmap_unlock();
+
+    return ret;
+}
+
 /* minherit(2) */
 static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
         abi_long inherit)
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 553578708b..600d048120 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -627,6 +627,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_munlockall();
         break;
 
+    case TARGET_FREEBSD_NR_madvise: /* madvise(2) */
+        ret = do_bsd_madvise(arg1, arg2, arg3);
+        break;
+
     case TARGET_FREEBSD_NR_minherit: /* minherit(2) */
         ret = do_bsd_minherit(arg1, arg2, arg3);
         break;
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index f4a5ae2a12..929b155b10 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -95,6 +95,8 @@ struct bsd_shm_regions {
 /*
  *  sys/mman.h
  */
+#define TARGET_MADV_DONTNEED            4       /* dont need these pages */
+
 #define TARGET_FREEBSD_MAP_RESERVED0080 0x0080  /* previously misimplemented */
                                                 /* MAP_INHERIT */
 #define TARGET_FREEBSD_MAP_RESERVED0100 0x0100  /* previously unimplemented */
-- 
2.42.0


