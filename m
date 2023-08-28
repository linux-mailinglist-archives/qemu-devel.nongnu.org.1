Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C69878BBB4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsP-0003uZ-7g; Mon, 28 Aug 2023 19:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals9-0003pP-IT
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:18 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006ot-SX
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:17 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34dec9c77d4so42705ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266124; x=1693870924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lV/5XeTX9LnWNklrCPw9QQtEp/5MCYlEuIolAxVmMo=;
 b=REaMhuXPRVeuchOFH3z8ZsLqA72BP4v+/Avi6nJ9ohx7XOHkVQ8hWz2Nm53RhibCJd
 z4g1Sxc30WPTDBZmVXwCiwMbgaZuMLIIz3wvEEJftHsXUn1LQiPKT5XUHD/7N3e5iaTd
 WIZ0yMtOW9V51quNY00IioYL0VSs64GmElOn2oNm0SJD7j3zv+0qSQxXd58VPEUhr+mE
 9hgITQOWxNa9URcHU2ZH4fSMl+RAK+M0wauoufUO9DAKky9lX9MzYjiAKubJ+NQFt3G3
 3g9cAJA9CPTMI7Zq6gZ6BcP3ZMKQsFjFU5b29oTICwF4l3mjHATAOkZ9if0/k0pJaXjk
 H8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266124; x=1693870924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lV/5XeTX9LnWNklrCPw9QQtEp/5MCYlEuIolAxVmMo=;
 b=Cw9rccghIBBi2bKR7RybvxE1Wr+jeOrpbIAvHIyDrPYeV1oql5QT5Tn7758PbpF9YL
 iFOyDKQIH4FBmdq2k4swfjf9Xm2MsyPr7KO3ivj3d1Ob1IvbumPE6s5nvo4nMPS03i7B
 xadt8u71PpytxVBusK8MoDT8VMUEzfZP5JOSnft5LJtf8FEFCrOV/YWa2UrR03sx1KxO
 VQmQ+xaCM2UfiOLsraORofin9yUuLBH7JtjjRTc2Lh2W76GQmJSqW8gylM/W9w7g93XK
 6zWRkfEqrHz8VnAKfeBJ/keqp/tzwBMo9wgze1L65ncwchJY+yP2W+ePQP0PWeLJCMdn
 eoUA==
X-Gm-Message-State: AOJu0YzRYshu+OCHv2Cp103WCSh3oE06kiGdD7aYNAUHUg/aRmgqmL6D
 3blcL8JhytcAA2iuxk/tAyTvcdtzgHfmxrOgDKI=
X-Google-Smtp-Source: AGHT+IH4bskpsrGzXbnxzN2SRc+EhYDmuKEv8f7HAMcnoNTlrTw5foncvTFznB3EIX2CccLM9XsHCw==
X-Received: by 2002:a05:6e02:2166:b0:34c:e4c6:c517 with SMTP id
 s6-20020a056e02216600b0034ce4c6c517mr10977259ilv.6.1693266124421; 
 Mon, 28 Aug 2023 16:42:04 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:03 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michal Meloun <mmel@FreeBSD.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 28/36] bsd-user: Implement freebsd11 getdirents related syscalls
Date: Mon, 28 Aug 2023 17:38:13 -0600
Message-ID: <20230828233821.43074-29-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::133;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x133.google.com
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

Implement the freebsd11 variant of the following syscalls:
getdirentries(2)

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 04a61fabd11..26909af455d 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -41,6 +41,11 @@ __sym_compat(statfs, freebsd11_statfs, FBSD_1.0);
 int freebsd11_fstatfs(int fd, struct freebsd11_statfs *buf);
 __sym_compat(fstatfs, freebsd11_fstatfs, FBSD_1.0);
 
+ssize_t freebsd11_getdirentries(int fd, char *buf, size_t nbytes, off_t *basep);
+__sym_compat(getdirentries, freebsd11_getdirentries, FBSD_1.0);
+ssize_t freebsd11_getdents(int fd, char *buf, size_t nbytes);
+__sym_compat(getdents, freebsd11_getdents, FBSD_1.0);
+
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
@@ -468,6 +473,45 @@ static inline abi_long do_freebsd11_getdents(abi_long arg1,
     return ret;
 }
 
+/* getdirecentries(2) */
+static inline abi_long do_freebsd11_getdirentries(abi_long arg1,
+        abi_ulong arg2, abi_long nbytes, abi_ulong arg4)
+{
+    abi_long ret;
+    struct freebsd11_dirent *dirp;
+    long basep;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, nbytes, 0);
+    if (dirp == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(freebsd11_getdirentries(arg1, (char *)dirp, nbytes, &basep));
+    if (!is_error(ret)) {
+        struct freebsd11_dirent *de;
+        int len = ret;
+        int reclen;
+
+        de = dirp;
+        while (len > 0) {
+            reclen = de->d_reclen;
+            if (reclen > len) {
+                return -TARGET_EFAULT;
+            }
+            de->d_reclen = tswap16(reclen);
+            de->d_fileno = tswap32(de->d_fileno);
+            len -= reclen;
+            de = (struct freebsd11_dirent *)((void *)de + reclen);
+        }
+    }
+    unlock_user(dirp, arg2, ret);
+    if (arg4) {
+        if (put_user(basep, arg4, abi_ulong)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 /* getdirecentries(2) */
 static inline abi_long do_freebsd_getdirentries(abi_long arg1,
         abi_ulong arg2, abi_long nbytes, abi_ulong arg4)
-- 
2.41.0


