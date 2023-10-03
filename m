Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A2E7B754F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovs-0004Wl-O1; Tue, 03 Oct 2023 19:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovm-0004Pe-JB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:58 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnove-0007Sm-C3
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:57 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fce245bf6so58309539f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376147; x=1696980947;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bS/7XD3QWTqjRTlEK+pQc9fvJl6oodvE6Kcpj/qv1/I=;
 b=K+FZsvYQn/Dms7+tGp7rIEXU4TyWxNDSuLA8jz8SGQIpE7IeRjsmKBEs/TXBTMYAaW
 nUdY9KL/1gzLyTX0p47MGCTvSUzi83qNLss6oagKv70/mYi8isaEhZGADCyccx7bUCVz
 q3bGvXrAni54YbK/MwiUWbKbqFSVQYK8nEt0n3Fjwfvjv5UyNGlcAAqR5ztRClgN0Ndl
 zG7A6ORMeT7cfGLZYVrgutl5AfXvo5GokWq+QmEbsHjCbgaGXH4pV3QM9lS574ivtULY
 lv6M//h94T3NBKh/hdcXtImYGqwyvwwKzFHnESSrMhsQRqaqUaPzhnctysda6t6zLh8E
 ra6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376147; x=1696980947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bS/7XD3QWTqjRTlEK+pQc9fvJl6oodvE6Kcpj/qv1/I=;
 b=RZDFieL9RBvSB07KN4h0sL5ypgx9+MeIj5Ia1e4QTfvZCaV9+vK6P5/jWD92YA6MDy
 cGatA4XKgA5VZao395NLryVbpngd9eVrxZEARJzYEF00+cr60O6Or96i1N+HNCR+Fh5K
 oGa/kn3RlYksRs+rqmLthhSwvO2pUI0UCEOSaW7rAwkK8Pcba3/gciuvkUtgIkLidaC3
 jzW1gYeqT1JvLF2tqE2mHMrJUjWYMAdZ4Wc6qJ1QgcNhR3zpR94wPjScIBvB7c5GyP/p
 HgwiCUmyAzvwrHMp2b3kHvxM6uc97GF8dIFy+6V4mrQUojzgSYvwNCDKf0Gpmy7QIYh3
 Wmrg==
X-Gm-Message-State: AOJu0Yz5lY6oQyI0TjQerjdf98WkxRuiujwAQvnBaDAwvs7cq+lYacPL
 684B/X8LPSMsOJPiCLhTKx927clQvJdJ239iMq32gw==
X-Google-Smtp-Source: AGHT+IFTgELGiniy3zspwhILwfQ6tZZeSqWzKg5NIzC/6o8EBcGUX5m24V3c+TJ8PHKa84yt4JeZXA==
X-Received: by 2002:a6b:7e05:0:b0:79f:cb49:f476 with SMTP id
 i5-20020a6b7e05000000b0079fcb49f476mr859321iom.21.1696376147085; 
 Tue, 03 Oct 2023 16:35:47 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 44/51] bsd-user: Implment madvise(2) to match the linux-user
 implementation.
Date: Tue,  3 Oct 2023 17:32:08 -0600
Message-ID: <20231003233215.95557-45-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Karim Taha <kariem.taha2.7@gmail.com>

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-17-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 53 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 +++
 bsd-user/syscall_defs.h       |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 16c22593bfd..b00ab3aed8e 100644
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
index 7a7ae26793f..b8c44cea0ff 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -831,6 +831,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
index ff692814333..52f84d5dd17 100644
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
2.41.0


