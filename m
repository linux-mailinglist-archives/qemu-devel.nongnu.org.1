Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC287740C4
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:10:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDj-0002qC-1r; Tue, 08 Aug 2023 13:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDg-0002fR-Kn
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDe-0003cZ-NT
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31792ac0fefso4447006f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514605; x=1692119405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbWdB/ZK+UVkxi7fyaDkVKQfgjGC/Wz/Ej9MOzEDLnQ=;
 b=nUYfW7J5m1bYv30R9cYuf5c6x17CUVQfkE4JwBfsqZ91dNs6oy15zluCigUlwemmAi
 9+2Kl5ejXQQdrJejd9nBpXEdvKe0+f6RUirJc2q4mMg65yTgY5DVMdsRk6709zCSb57Y
 44L6fhQ4PSwpq6UnDqNIVOOheoro5cyQYY05JNXMZq1P2pjMUw2lw3JimkAn0c3k3wMr
 YF0HCWRNvEu7aD5XYFbfeHi68GdjDuRqRQwDEgldLcwIQCPDiBPK36RwxXUBxc2MdEk5
 4DiAdqfDHvkutgwc6xr+1s9i03+LzpWl7XvsoyuRXHRxGJWezQ6VEg1RrDt+BHAcDt4D
 zfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514605; x=1692119405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbWdB/ZK+UVkxi7fyaDkVKQfgjGC/Wz/Ej9MOzEDLnQ=;
 b=YW/1ux4w3enmWpg+Gmn37gbUgzt7KrUw2WJyut3AGAHN58BufMrscLkk6iU+ZEFASY
 pDJQUb/+eTgKWIPxeQwBnFebmOulAd8dSaBaHOpOt3aUKawCZDgtxUh0TDl/FR3Z0I/Y
 Fn7bEe4RPCHjf6rUEyJAnCVHmbYgSlD7vEe+ony8095e3Vm/J30W6g8OVBUFerto2KmS
 uiw/2OvMhg0QSFuYIZGLvTKJ04DokF/HXeN+TRdOZFblkxlQXp2n/3UFwXcBdIoj7vK0
 bClgGHDHIDSRcE2FhpQGnOqDOmD5hCu8lec7m25xQgR7decxqeZb8RdO3nfelVCwr9x+
 1R7Q==
X-Gm-Message-State: AOJu0Yz5/3uJpQo49zyP7VBRBosmkOY0ACDXiQx6EKvDLPCSJOfn/pL/
 2wZ9JPSouMGqypZVjIUDUKDvXkt0Q0H3eg==
X-Google-Smtp-Source: AGHT+IFO7iVGF3XZkNOQ4y/dqtWIXE2uH9YG7dUH8Iw5UA0uo8DomSKuY2R88lVtdPPiUpQV78yowA==
X-Received: by 2002:adf:f58c:0:b0:314:2fdd:28ef with SMTP id
 f12-20020adff58c000000b003142fdd28efmr68665wro.18.1691514604808; 
 Tue, 08 Aug 2023 10:10:04 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:04 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 21/33] Implement stat related syscalls
Date: Tue,  8 Aug 2023 08:08:03 +0200
Message-Id: <20230808060815.9001-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 bsd-user/freebsd/os-stat.h | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 9492c93c55..7dc41cd0bf 100644
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
2.40.0


