Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE578BB9D
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qals8-0003no-Iy; Mon, 28 Aug 2023 19:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrv-0003mo-A2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:03 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrt-0006lC-1C
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:03 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34ccc0fca24so13757755ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266119; x=1693870919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zii+bXewDYitejvupsp9eZMnhHeSRtYNzFVqXQF7jis=;
 b=izHmnwP/6KYpQmryTa9aECQdLjdfH61iEUQw6SWJPALn1zmKOGmleQKAOR4BmIBfao
 zoLRaPxM2CcMIqE/NS6i9SFSCAeVYdTSMV4cNs2h1gzSenJaWOVf824D6yz8gD96O/Rm
 1inYSSZHLNvKYMCQkQXD2p0NPxXAhIVjvwiMXMsCbpmluDY1gpE8QF/9elHcZ3/KMD/B
 q3Qhxp90Ky8q0rcCxTT8j2q/zkgb6CJaFN11LOLSNp1SMNxJPq9AjJmmpJ5nFPjzf1SG
 cXhBxLcpzMjV3LXAJODICgIlLLHbrCImHjnEY6cgEF9MB3Re3qSSoRxDqG6y0d/D0LqQ
 Sgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266119; x=1693870919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zii+bXewDYitejvupsp9eZMnhHeSRtYNzFVqXQF7jis=;
 b=QjDbxhHsPb5wG28OCTHSuo2uA4H2uMJHB9MW7NMPgBItsdyhnSQgcWI8VpY1PwVp6J
 /z/9ygVnmHlbe081qZsP2L60n0e8PdpVIwvaUMxu6+PrkA6BoiKIWM9ehw3tHpvg40L0
 fltr/jiNlMhjhCmg3PexbvOyhX359zH+kPhSk0g3pCobzffu5kaIqeQOWV0zHNMBQYMS
 Xpa7FN7a+qGsIRsu1BubYQcKJsARCR9HT7H1pUUSEsGk9s1a9Weyz4VEoS9yO+fcts5C
 eci6A1fi+r9QILfpOFqVsbztSANMq931fi7r5MTkmgWuh04LEbxOa82XTnC2y0WSmem1
 nUdw==
X-Gm-Message-State: AOJu0YyIMZj+ixcPou+g4aGJZSutoKrQHBA5RfHhBqLOK9NXtTQ9RSdX
 dvM5tqCvnLZuzTfIeOoRhe4ElicGvE1uG6ODbX8=
X-Google-Smtp-Source: AGHT+IHXn+ccytLG5BXJ7LNSRq8Gl9W51hs4IKLA+HIyFs8/Fe3h1IvlX+Ox1GSWSG9X3dLkfVBHKA==
X-Received: by 2002:a05:6e02:1a4f:b0:34a:c751:28ca with SMTP id
 u15-20020a056e021a4f00b0034ac75128camr22227033ilv.15.1693266119646; 
 Mon, 28 Aug 2023 16:41:59 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:59 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/36] bsd-user: Implement getdents related syscalls
Date: Mon, 28 Aug 2023 17:38:08 -0600
Message-ID: <20230828233821.43074-24-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12f;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12f.google.com
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

Implement the following syscalls:
getdents(2)
getdirecentries(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 9492c93c55a..7dc41cd0bfe 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -279,4 +279,76 @@ static inline abi_long do_freebsd_getfsstat(abi_ulong target_addr,
     return ret;
 }
 
+/* getdents(2) */
+static inline abi_long do_freebsd11_getdents(abi_long arg1,
+        abi_ulong arg2, abi_long nbytes)
+{
+    abi_long ret;
+    struct freebsd11_dirent *dirp;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, nbytes, 0);
+    if (dirp == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(freebsd11_getdents(arg1, (char *)dirp, nbytes));
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
+        }
+    }
+    return ret;
+}
+
+/* getdirecentries(2) */
+static inline abi_long do_freebsd_getdirentries(abi_long arg1,
+        abi_ulong arg2, abi_long nbytes, abi_ulong arg4)
+{
+    abi_long ret;
+    struct dirent *dirp;
+    long basep;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, nbytes, 0);
+    if (dirp == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getdirentries(arg1, (char *)dirp, nbytes, &basep));
+    if (!is_error(ret)) {
+        struct dirent *de;
+        int len = ret;
+        int reclen;
+
+        de = dirp;
+        while (len > 0) {
+            reclen = de->d_reclen;
+            if (reclen > len) {
+                return -TARGET_EFAULT;
+            }
+            de->d_fileno = tswap64(de->d_fileno);
+            de->d_off = tswap64(de->d_off);
+            de->d_reclen = tswap16(de->d_reclen);
+            de->d_namlen = tswap16(de->d_namlen);
+            len -= reclen;
+            de = (struct dirent *)((void *)de + reclen);
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
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.41.0


