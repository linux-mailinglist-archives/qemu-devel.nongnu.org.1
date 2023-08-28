Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D2678BBA0
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsA-0003nx-77; Mon, 28 Aug 2023 19:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrp-0003iT-6u
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:57 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrm-0006jU-GF
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:56 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7927611c54bso125399139f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266112; x=1693870912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OfqJxry5f581sIZWAhIjAoRAlIB/L3PO5LHdIfc+KE=;
 b=114nOv6dhvQcq1M0O3Us0vXefMq598vpSzvb3qiFBESBkGgXD1YaSa+PXL4s1gOKsl
 jtNE05XKw4xD3BvQq8XEKGY7z2I93LgkIKy2HquGoJEQax0B+AdkXl4QZEEuqJK6BcC/
 wCRkGhnP2vTKbB+V/Crr27uFuSl+tRhemveK89ybk+Fsb/PXdNyGz0Ka+J8Ain8nB7Nk
 FtDhf08pKvnpojkpPeWQmGBhfCRuVyNOccJHhWTajk/+2GZMglCBlG5xkZEJp0x8UbTH
 kEo816mDo0LIsszzOEYQV+kq6HintGYGYcE0LrD69I6hLnGe+o6NXQFXKrnZvjPMhfFR
 dbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266112; x=1693870912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OfqJxry5f581sIZWAhIjAoRAlIB/L3PO5LHdIfc+KE=;
 b=URuh+7lRY9B5l3qFqhzG0Gd1WOXTgR2UK3upH8/Fp1ejxrg0u9EdmPdp7OtZg2Pe/n
 KO9JY27n/Qog8qq+FlGLDM7LZ9JwEhfS6zShrkVPZwZxT0JsjQKJm+Z5FES+BHBXKCKb
 jelX+SknA6Y6n+opE9jz6hwXNytuGmQEVwLjxnsHIrUcCI9HGfTb++u3nR8c9OD1HYn3
 ts0lw5jZ2w0oRN2VUoV0cj8VpW7vSq1EwsKGDfC8DWY5ZGvvqJmgepS5P8GBf4ruRTK2
 +pSFnUsWRwHFsZ6vrQHQYktYs7UVqqQCClXaerJFypMVQ7IF0JYyioBuoA2oGATGiUyv
 7cJQ==
X-Gm-Message-State: AOJu0YyrCq8+nDglPNFOtXnkDPsnCGfafuZ/C3Xrk0Ar8YfH/k4gjafB
 4O8DFaQTqQzOAUQNkGQB8UOI36YWBxoIDwdTQrA=
X-Google-Smtp-Source: AGHT+IGqTvX2onqzQhiRQahvRhmkM9GJcVcwHp+9WT3NLfhSrH3ligYmxIMaIL/cib2tlygUYKwsEg==
X-Received: by 2002:a05:6e02:1ca8:b0:349:36e1:10fb with SMTP id
 x8-20020a056e021ca800b0034936e110fbmr20198717ill.18.1693266112306; 
 Mon, 28 Aug 2023 16:41:52 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:51 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/36] bsd-user: Implement h2t_freebsd11_stat h2t_freebsd_nstat
Date: Mon, 28 Aug 2023 17:38:00 -0600
Message-ID: <20230828233821.43074-16-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2c.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Implement the stat conversion functions:
h2t_freebsd11_stat
h2t_freebsd_nstat

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 bsd-user/freebsd/os-stat.c

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
new file mode 100644
index 00000000000..8c73f7402c2
--- /dev/null
+++ b/bsd-user/freebsd/os-stat.c
@@ -0,0 +1,94 @@
+/*
+ *  FreeBSD stat related conversion routines
+ *
+ *  Copyright (c) 2013 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+
+#include "qemu.h"
+
+/*
+ * stat conversion
+ */
+abi_long h2t_freebsd11_stat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st)
+{
+    struct target_freebsd11_stat *target_st;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_st, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    memset(target_st, 0, sizeof(*target_st));
+    __put_user(host_st->st_dev, &target_st->st_dev);
+    __put_user(host_st->st_ino, &target_st->st_ino);
+    __put_user(host_st->st_mode, &target_st->st_mode);
+    __put_user(host_st->st_nlink, &target_st->st_nlink);
+    __put_user(host_st->st_uid, &target_st->st_uid);
+    __put_user(host_st->st_gid, &target_st->st_gid);
+    __put_user(host_st->st_rdev, &target_st->st_rdev);
+    __put_user(host_st->st_atim.tv_sec, &target_st->st_atim.tv_sec);
+    __put_user(host_st->st_atim.tv_nsec, &target_st->st_atim.tv_nsec);
+    __put_user(host_st->st_mtim.tv_sec, &target_st->st_mtim.tv_sec);
+    __put_user(host_st->st_mtim.tv_nsec, &target_st->st_mtim.tv_nsec);
+    __put_user(host_st->st_ctim.tv_sec, &target_st->st_ctim.tv_sec);
+    __put_user(host_st->st_ctim.tv_nsec, &target_st->st_ctim.tv_nsec);
+    __put_user(host_st->st_size, &target_st->st_size);
+    __put_user(host_st->st_blocks, &target_st->st_blocks);
+    __put_user(host_st->st_blksize, &target_st->st_blksize);
+    __put_user(host_st->st_flags, &target_st->st_flags);
+    __put_user(host_st->st_gen, &target_st->st_gen);
+    /* st_lspare not used */
+    __put_user(host_st->st_birthtim.tv_sec, &target_st->st_birthtim.tv_sec);
+    __put_user(host_st->st_birthtim.tv_nsec, &target_st->st_birthtim.tv_nsec);
+    unlock_user_struct(target_st, target_addr, 1);
+
+    return 0;
+}
+
+abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st)
+{
+    struct target_freebsd11_nstat *target_st;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_st, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    memset(target_st, 0, sizeof(*target_st));
+    __put_user(host_st->st_dev, &target_st->st_dev);
+    __put_user(host_st->st_ino, &target_st->st_ino);
+    __put_user(host_st->st_mode, &target_st->st_mode);
+    __put_user(host_st->st_nlink, &target_st->st_nlink);
+    __put_user(host_st->st_uid, &target_st->st_uid);
+    __put_user(host_st->st_gid, &target_st->st_gid);
+    __put_user(host_st->st_rdev, &target_st->st_rdev);
+    __put_user(host_st->st_atim.tv_sec, &target_st->st_atim.tv_sec);
+    __put_user(host_st->st_atim.tv_nsec, &target_st->st_atim.tv_nsec);
+    __put_user(host_st->st_mtim.tv_sec, &target_st->st_mtim.tv_sec);
+    __put_user(host_st->st_mtim.tv_nsec, &target_st->st_mtim.tv_nsec);
+    __put_user(host_st->st_ctim.tv_sec, &target_st->st_ctim.tv_sec);
+    __put_user(host_st->st_ctim.tv_nsec, &target_st->st_ctim.tv_nsec);
+    __put_user(host_st->st_size, &target_st->st_size);
+    __put_user(host_st->st_blocks, &target_st->st_blocks);
+    __put_user(host_st->st_blksize, &target_st->st_blksize);
+    __put_user(host_st->st_flags, &target_st->st_flags);
+    __put_user(host_st->st_gen, &target_st->st_gen);
+    __put_user(host_st->st_birthtim.tv_sec, &target_st->st_birthtim.tv_sec);
+    __put_user(host_st->st_birthtim.tv_nsec, &target_st->st_birthtim.tv_nsec);
+    unlock_user_struct(target_st, target_addr, 1);
+
+    return 0;
+}
+
-- 
2.41.0


