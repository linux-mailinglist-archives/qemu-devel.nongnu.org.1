Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE878BB9C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qals7-0003nj-FT; Mon, 28 Aug 2023 19:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrs-0003jw-82
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:00 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrp-0006kG-C3
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:59 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34cc0ad6f61so13464405ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266116; x=1693870916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNhh9+MBHOyqqlgYFbkX8f4P9c6wy/M5jr+0vrvfSDo=;
 b=HcOtgRDvx1x8ZU5Y/BNaqubdpsQrx2DwfkcDXjHBHIal8uQwxzjo8nrk776QzLCtEx
 FAFZJagMeHdp6twtqW1Boom4y39CTD1i7mBRsA8IY0xhvIsh/bNFd2vHZUoBwFfkCCdO
 0ErWSzPuZX4XygCl4PX3DWX5mdHM5jjo5fTCk/gaYDkgQ75XZPBs0Ax6U3Ws7GlGV7a9
 yHupuZ++v4aFkM1evAI1UANkUDODlYRAZA6NfKuR8/0f7m0exmySc0oaXYRwjxyZVM+J
 CKpqrmSBVUvrrDsw2/C+c/L+WAZPHkcKl3+QtX4iSi+oMcF/Rrml46zFF1zoZyq/xg6t
 6IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266116; x=1693870916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNhh9+MBHOyqqlgYFbkX8f4P9c6wy/M5jr+0vrvfSDo=;
 b=LWH1gBS7bk1YHhfV2c3Uu3Qk6o/rA3/tZFKB0gTpDVNS6gASKvPxq0csvPWoLCaQZO
 OUfDcMx88nypWO/qfgVDgdG4pZYypSwvkT8XMpa00Zh01KLg9Bv/V8QS+Kh2C8bN2jCw
 mPaRpW7UU0aUTOJMXcEmRcd0AodQRWcKSqoMPyMLyy4/veFgpRW7hwbi4fxMqZZhYhny
 B2Tdhrimw0kxBXF4BXGIkGVp2oMF2bcgyANsPvhmv5yNHKzZG/291Icjf3Pc31o8Qs4U
 CyH2MfeeLKsDb4ImhHTbSpWed0CnUJqzOotCvRA+jy3AmAkiFkudsCbDMu3e52NMsUXH
 swWQ==
X-Gm-Message-State: AOJu0YwMle2nJh2G93FyR7aTWndyb+NnK+ijBVqvnjzFaMrySoA5JSDs
 93nHD0dfKYTBQo2XPZPFo9KPYuPuh2VtWSbvjsA=
X-Google-Smtp-Source: AGHT+IHPZz3R/crxK4s7CcqurxjWl8KABd+QYsly64Inec8nAnSsKSjszJLLFvsminUEX2PIA6oOKQ==
X-Received: by 2002:a05:6e02:2198:b0:34c:e84b:4c5d with SMTP id
 j24-20020a056e02219800b0034ce84b4c5dmr9961592ila.26.1693266115965; 
 Mon, 28 Aug 2023 16:41:55 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:55 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michal Meloun <mmel@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/36] bsd-uesr: Implement h2t_freebsd_stat and
 h2t_freebsd_statfs functions
Date: Mon, 28 Aug 2023 17:38:04 -0600
Message-ID: <20230828233821.43074-20-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::134;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x134.google.com
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

From: Michal Meloun <mmel@FreeBSD.org>

They are the 64-bit variants of h2t_freebsd11_stat and
h2t_freebsd11_statfs, respectively

Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.c | 82 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 2ce235d5dae..f0f9e609c3b 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -58,6 +58,50 @@ abi_long h2t_freebsd11_stat(abi_ulong target_addr,
     return 0;
 }
 
+abi_long h2t_freebsd_stat(abi_ulong target_addr,
+        struct stat *host_st)
+{
+    struct target_stat *target_st;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_st, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    memset(target_st, 0, sizeof(*target_st));
+    __put_user(host_st->st_dev, &target_st->st_dev);
+    __put_user(host_st->st_ino, &target_st->st_ino);
+    __put_user(host_st->st_nlink, &target_st->st_nlink);
+    __put_user(host_st->st_mode, &target_st->st_mode);
+    __put_user(host_st->st_uid, &target_st->st_uid);
+    __put_user(host_st->st_gid, &target_st->st_gid);
+    __put_user(host_st->st_rdev, &target_st->st_rdev);
+    __put_user(host_st->st_atim.tv_sec, &target_st->st_atim.tv_sec);
+    __put_user(host_st->st_atim.tv_nsec, &target_st->st_atim.tv_nsec);
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+/*    __put_user(host_st->st_mtim_ext, &target_st->st_mtim_ext); XXX */
+#endif
+    __put_user(host_st->st_mtim.tv_sec, &target_st->st_mtim.tv_sec);
+    __put_user(host_st->st_mtim.tv_nsec, &target_st->st_mtim.tv_nsec);
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+/*    __put_user(host_st->st_ctim_ext, &target_st->st_ctim_ext); XXX */
+#endif
+    __put_user(host_st->st_ctim.tv_sec, &target_st->st_ctim.tv_sec);
+    __put_user(host_st->st_ctim.tv_nsec, &target_st->st_ctim.tv_nsec);
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+/*    __put_user(host_st->st_birthtim_ext, &target_st->st_birthtim_ext); XXX */
+#endif
+    __put_user(host_st->st_birthtim.tv_sec, &target_st->st_birthtim.tv_sec);
+    __put_user(host_st->st_birthtim.tv_nsec, &target_st->st_birthtim.tv_nsec);
+
+    __put_user(host_st->st_size, &target_st->st_size);
+    __put_user(host_st->st_blocks, &target_st->st_blocks);
+    __put_user(host_st->st_blksize, &target_st->st_blksize);
+    __put_user(host_st->st_flags, &target_st->st_flags);
+    __put_user(host_st->st_gen, &target_st->st_gen);
+    unlock_user_struct(target_st, target_addr, 1);
+
+    return 0;
+}
+
 abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
         struct freebsd11_stat *host_st)
 {
@@ -170,6 +214,44 @@ abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
     return 0;
 }
 
+abi_long h2t_freebsd_statfs(abi_ulong target_addr,
+        struct statfs *host_statfs)
+{
+    struct target_statfs *target_statfs;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_statfs, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_statfs->f_version, &target_statfs->f_version);
+    __put_user(host_statfs->f_type, &target_statfs->f_type);
+    __put_user(host_statfs->f_flags, &target_statfs->f_flags);
+    __put_user(host_statfs->f_bsize, &target_statfs->f_bsize);
+    __put_user(host_statfs->f_iosize, &target_statfs->f_iosize);
+    __put_user(host_statfs->f_blocks, &target_statfs->f_blocks);
+    __put_user(host_statfs->f_bfree, &target_statfs->f_bfree);
+    __put_user(host_statfs->f_bavail, &target_statfs->f_bavail);
+    __put_user(host_statfs->f_files, &target_statfs->f_files);
+    __put_user(host_statfs->f_ffree, &target_statfs->f_ffree);
+    __put_user(host_statfs->f_syncwrites, &target_statfs->f_syncwrites);
+    __put_user(host_statfs->f_asyncwrites, &target_statfs->f_asyncwrites);
+    __put_user(host_statfs->f_syncreads, &target_statfs->f_syncreads);
+    __put_user(host_statfs->f_asyncreads, &target_statfs->f_asyncreads);
+    /* uint64_t f_spare[10]; */
+    __put_user(host_statfs->f_namemax, &target_statfs->f_namemax);
+    __put_user(host_statfs->f_owner, &target_statfs->f_owner);
+    __put_user(host_statfs->f_fsid.val[0], &target_statfs->f_fsid.val[0]);
+    __put_user(host_statfs->f_fsid.val[1], &target_statfs->f_fsid.val[1]);
+    /* char f_charspace[80]; */
+    strncpy(target_statfs->f_fstypename, host_statfs->f_fstypename,
+        sizeof(target_statfs->f_fstypename));
+    strncpy(target_statfs->f_mntfromname, host_statfs->f_mntfromname,
+        sizeof(target_statfs->f_mntfromname));
+    strncpy(target_statfs->f_mntonname, host_statfs->f_mntonname,
+        sizeof(target_statfs->f_mntonname));
+    unlock_user_struct(target_statfs, target_addr, 1);
+    return 0;
+}
+
 /*
  * fcntl cmd conversion
  */
-- 
2.41.0


