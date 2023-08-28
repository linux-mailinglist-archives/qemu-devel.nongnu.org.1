Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6078BB98
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsJ-0003q2-1T; Mon, 28 Aug 2023 19:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrv-0003n0-UP
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:04 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrt-0006lL-MG
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:03 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34cc0ad6f61so13464535ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266120; x=1693870920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8KyIPO+6/qtk663eKB4TGmb1eaoTmFby8ULGYDVGqk=;
 b=tgC+PLKHG5w/kNJ5TdB5EfNO8uESu60yTkhcU0svBOWzSNu3tJN+rs1Y23bo33m9Rv
 8VTix1wWC6eawF5HLXurkzUA6gs6oLDFUguNfNSAvgTdqIRg7dthIxrba0Bu4xqiQJ0k
 9dacGz19xln59358J7Jft7VSY8l3LGO5ozNETjY3IxYOIaiSuhc3XjCeSY9cttKe4ojf
 /1w2yaInLSnXbAbV7joqLuW/wQWVtUGGoid97r8MJfS8FAmN0KCDiXiWOhQ/+xaLRlxP
 nFCM1kuyFORijgoHWxO+sZt3C1P7ManEDWcxBrgLwzJmKvKSICbveb72GZxp2qER4+8Y
 2MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266120; x=1693870920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8KyIPO+6/qtk663eKB4TGmb1eaoTmFby8ULGYDVGqk=;
 b=dNDKUzwk1j2xUeOGp0m7nJ+S244VqV2W4gxAXtLTRQxrzqp+H/mqw3vndRrf+dI3ve
 UL5xCWXdFUcB+KkhsXp3zsuHb0qH16p9yUcCViry72WrFAnvO/G9ikwODBTQ2G+7kGMK
 ZBx+OL8OdA/QFV7AOzvP2jP/KMXCuYBMwfSSDSvVj1OEJJJVpyYx2DzmjtiLEMJWahoE
 tPU1602ZGgewS2UjnHTCvnZ9lNOvtpDkcYJ/0ND9bKBszFh9rIGFt0yootL147uta1va
 nkMLTyoJeoXUjKF4umVR8hZXhyvXGYkphOEXUhKA+8rwE0/K1N4F8qXvUvnXc4koOTjl
 /fGg==
X-Gm-Message-State: AOJu0Yw+4i+dmxbJfzjQvCRb+UGpa406ELVylSX7ZZQFiIcsmImVgbVp
 a6JUelh0jdEE2ZhpUa/QNSkmAwhvehXm59rQKVA=
X-Google-Smtp-Source: AGHT+IHoWwjmGkhiXcKoPEWJbxvir3H9s3RPTyXPxccs+2h9iTA3AGIVtEFfvw0krD84pywy8TIALw==
X-Received: by 2002:a05:6e02:1c28:b0:345:df7f:efc4 with SMTP id
 m8-20020a056e021c2800b00345df7fefc4mr19515994ilh.27.1693266120462; 
 Mon, 28 Aug 2023 16:42:00 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/36] bsd-user: Implement stat related syscalls
Date: Mon, 28 Aug 2023 17:38:09 -0600
Message-ID: <20230828233821.43074-25-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x135.google.com
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
fcntl(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 74 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 7dc41cd0bfe..5d9323c7d1b 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -351,4 +351,78 @@ static inline abi_long do_freebsd_getdirentries(abi_long arg1,
     return ret;
 }
 
+/* fcntl(2) */
+static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
+        abi_ulong arg3)
+{
+    abi_long ret;
+    int host_cmd;
+    struct flock fl;
+    struct target_freebsd_flock *target_fl;
+
+    host_cmd = target_to_host_fcntl_cmd(arg2);
+    if (host_cmd < 0) {
+        return host_cmd;
+    }
+    switch (arg2) {
+    case TARGET_F_GETLK:
+        if (!lock_user_struct(VERIFY_READ, target_fl, arg3, 1)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(fl.l_type, &target_fl->l_type);
+        __get_user(fl.l_whence, &target_fl->l_whence);
+        __get_user(fl.l_start, &target_fl->l_start);
+        __get_user(fl.l_len, &target_fl->l_len);
+        __get_user(fl.l_pid, &target_fl->l_pid);
+        __get_user(fl.l_sysid, &target_fl->l_sysid);
+        unlock_user_struct(target_fl, arg3, 0);
+        ret = get_errno(safe_fcntl(arg1, host_cmd, &fl));
+        if (!is_error(ret)) {
+            if (!lock_user_struct(VERIFY_WRITE, target_fl, arg3, 0)) {
+                return -TARGET_EFAULT;
+            }
+            __put_user(fl.l_type, &target_fl->l_type);
+            __put_user(fl.l_whence, &target_fl->l_whence);
+            __put_user(fl.l_start, &target_fl->l_start);
+            __put_user(fl.l_len, &target_fl->l_len);
+            __put_user(fl.l_pid, &target_fl->l_pid);
+            __put_user(fl.l_sysid, &target_fl->l_sysid);
+            unlock_user_struct(target_fl, arg3, 1);
+        }
+        break;
+
+    case TARGET_F_SETLK:
+    case TARGET_F_SETLKW:
+        if (!lock_user_struct(VERIFY_READ, target_fl, arg3, 1)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(fl.l_type, &target_fl->l_type);
+        __get_user(fl.l_whence, &target_fl->l_whence);
+        __get_user(fl.l_start, &target_fl->l_start);
+        __get_user(fl.l_len, &target_fl->l_len);
+        __get_user(fl.l_pid, &target_fl->l_pid);
+        __get_user(fl.l_sysid, &target_fl->l_sysid);
+        unlock_user_struct(target_fl, arg3, 0);
+        ret = get_errno(safe_fcntl(arg1, host_cmd, &fl));
+        break;
+
+    case TARGET_F_DUPFD:
+    case TARGET_F_DUP2FD:
+    case TARGET_F_GETOWN:
+    case TARGET_F_SETOWN:
+    case TARGET_F_GETFD:
+    case TARGET_F_SETFD:
+    case TARGET_F_GETFL:
+    case TARGET_F_SETFL:
+    case TARGET_F_READAHEAD:
+    case TARGET_F_RDAHEAD:
+    case TARGET_F_ADD_SEALS:
+    case TARGET_F_GET_SEALS:
+    default:
+        ret = get_errno(safe_fcntl(arg1, host_cmd, arg3));
+        break;
+    }
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.41.0


