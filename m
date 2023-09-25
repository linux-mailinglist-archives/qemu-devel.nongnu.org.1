Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C27ADEBF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKb-0000VZ-Md; Mon, 25 Sep 2023 14:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKH-0000Hz-IF
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKE-0007qL-Fy
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4053d53a1bfso59036895e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666533; x=1696271333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYIaVv5fzpG/4IW8/3zE5TeazHpFYJhJio5PGpCXaJY=;
 b=L4F+QMofrjyu7wIRm2cZ64fuPBWaN8NF6SYxqk3rACzKJpTVf8+NfkHukfnVhfSuFV
 7FqYSrJYsj6E2N28exGhLORW5+nXYNYNrvjfJKXtjPGJqW+CJk6v2e84pCOSvi5U7/hI
 Q57WxUDeCP0g5d59Io1zxVrKmUoq4U3Gb/Lvi5/0+dZbGJECoZfyy8yvgJsPT133D8YE
 mYxy6iohohooOtc9ZMDmMlQwOWrkZ+4FHiOmTPzHxA1sgA1ebkXESLUV8Qq6oxPBA0fP
 nFKHgNWcNgBt/TZXSK5o35CYBKQggx1Jtr4lSxiKK6/5pbK5OjlkGravpp7rbxB4Qhs1
 7dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666533; x=1696271333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYIaVv5fzpG/4IW8/3zE5TeazHpFYJhJio5PGpCXaJY=;
 b=Jl0JbPW3suXxSgcfI5DpFxTcgqHED0gG+j4E4jL97L8kBYGmgb5Owsvaly2dKB0Ito
 6boJ707unB5rqM9mO276YhQwPpD2jGczPniH8smkewhvCGAi1guYmf+wXKTcGsjxSsHi
 h3Qct1I7CTtaF5FsfZdoTqFRi305Tq4Gg02oPR6jJiiAk2zy30v9vUmBuipKKKiukm/p
 Rhw54DQKYTS7HK8dpW//yDdGy6U8OtytJaiJQq8RVPuSCNVy9Zo2am1j3DYHOc8aovBE
 VAbEqBRTjDF2Lps1KXZXfhldfyC7Tz6OZq9Wlpmi23s/mQeAp5gzO2SRAIOa6VYO4vZX
 8Nog==
X-Gm-Message-State: AOJu0YwlAyylVz9zA8nRwIM0z0pcy8W3L+HzQYm/1x5FETtUQqX5HExk
 sO2Y4ixzqXWYKKJodejVBPIKRDG1DfM=
X-Google-Smtp-Source: AGHT+IF1TNzVfGN1GYl5LPOYfdRkudAu40mE/Ejp70tJQGOJkidOprOga5zVQXsv5MeWmGohJYSpVw==
X-Received: by 2002:a05:600c:3b89:b0:405:9666:5242 with SMTP id
 n9-20020a05600c3b8900b0040596665242mr1269196wms.31.1695666532509; 
 Mon, 25 Sep 2023 11:28:52 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:52 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 16/23] bsd-user: Implment madvise(2) to match the
 linux-user implementation.
Date: Mon, 25 Sep 2023 21:27:02 +0300
Message-ID: <20230925182709.4834-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
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


