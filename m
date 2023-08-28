Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B978BBAB
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrt-0003kc-4T; Mon, 28 Aug 2023 19:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrp-0003io-JZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:58 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrn-0006jp-9n
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:57 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7927611c54bso125400039f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266114; x=1693870914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahz0nYuBhqMzF4IyHISo9kKm5Ghws15NUUh9cgiocLs=;
 b=z6oiQhnqL/WVC2NM0sDy4hCPii1llJ2LrGo7RRoTa9cjPd49WTFTyxQkOFjk7rhcGG
 N20VfpqxWekAGKXAO7r6wNwaTllohuucl7AVggqhhvtIBjSevpIgcqKtdH94mW4ytGPt
 nZ3sScLwrx6fFaKtnj30GHJ68+Ovyk5YrUXz0xK7NbHKG0/UzIgKOcI7duRkasYRU90u
 RanqXzgpRSnuuXJqkJM643d4rGz7uVCT6mODZzamrE2O1OZ+cXUtwj2Z3ur78b7Y/xtw
 Mr03Txg/ONHQQ2jhjuB7/MdJrzOAWHHHcap6W8sQrq71yNfCz7kv9DJ7t+1/CdoI1TyV
 Y1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266114; x=1693870914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahz0nYuBhqMzF4IyHISo9kKm5Ghws15NUUh9cgiocLs=;
 b=ZBjx9mtxgMpTqy10j7nrsD6i+7tdHT7RZV0yXVZjC1xH4zhUnmbRt+EFT5/MSV/l9A
 jg1mFXbMpIBZ6wB3O7+KDQnHouxa+N4nEuWQfzqNsHp4IwUV3Z6OYJLIW5kZ8IUVFYJu
 NQbhWU5KsAbJe5c+0NeUVSXdK1mjxScnlWzZ+gMWItK1QKUtoRL9z8dNw4Z0mPZikF04
 X23NUgOXfsAmb4xwhXSIIIWzoxi4u//Po5HIekyXmA9NakeEFBcb5h5Ucp0I+UQaj2/v
 3qkrVITMPTOMVQ5ZXXtNBbEAxquQYaiDcHmYoZsq1pq8GbukYDccA3imtpO0kKbs+sSe
 RClQ==
X-Gm-Message-State: AOJu0YyvsBgfiU40I+qZi1X2ayn17kOzbR3I2qM/fEfpK1hZDdM6M7qY
 +GUqC4lTrhyEDWj0l5o4IQLEdpuU9ijQSu30l1g=
X-Google-Smtp-Source: AGHT+IFsdzhfF23Ukale+lqzvllN9cIyntWOT0apqtBohsiUZhH3WTI5GfUVLORVXR/yuCOIOZ2eEQ==
X-Received: by 2002:a05:6e02:1a2e:b0:345:3378:4251 with SMTP id
 g14-20020a056e021a2e00b0034533784251mr6307879ile.23.1693266113903; 
 Mon, 28 Aug 2023 16:41:53 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:53 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/36] bsd-user: Implement h2t_freebds11_statfs
Date: Mon, 28 Aug 2023 17:38:02 -0600
Message-ID: <20230828233821.43074-18-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Implement the stat conversion functions:
h2t_freebds11_statfs

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 6716cee3e22..9eb01bf6645 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -129,3 +129,44 @@ abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh)
     return 0;
 }
 
+/*
+ *  file system stat
+ */
+abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
+        struct freebsd11_statfs *host_statfs)
+{
+    struct target_freebsd11_statfs *target_statfs;
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
-- 
2.41.0


