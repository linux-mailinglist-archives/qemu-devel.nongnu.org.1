Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB6B7ACE3D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSx-0003Vm-6g; Sun, 24 Sep 2023 22:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSu-0003Qn-Rv
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSt-00007D-5R
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:52 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32003aae100so4495687f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609409; x=1696214209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nclM6JiCGY7mFmLYiUs3Sh+q/hGi5ONE8JD20ZP5YqQ=;
 b=XAaSEOfkpCMKVEuCdbiTV8ol+8c1eEaDeFtOiIfRH/v6AkBXZkIBt2ET5823Fa+vHd
 dd5+2Ae5QsOCVr8KA+koT1cIyRdKWCDwAfNJsRxMQ0gkVcBTIaHJHr3aMKChFUD9bIua
 u2a36g3dZRi9qjeDxGB5yiBVTvJgkHL0Fns+i3Glc2kMY8qj2p4ZLkHbBCtM1+z92xvN
 IVKtjQaR7ymMGA8rvhAs5o0Kj3eP1twzCW+ltB38rm8S0x19L1y1U1EiwRjcFjvz6A14
 XRjDp0NA9BQYq36gkKNCQLcQIrcOEUrHsDB+1F30o3EdhBw7bnlRyHIOXi0XCvmCLqXC
 gD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609409; x=1696214209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nclM6JiCGY7mFmLYiUs3Sh+q/hGi5ONE8JD20ZP5YqQ=;
 b=RbCW1L5QNPLAQNXhP0eNYtVH0Yjy91dpy+2hYYFYycLl5TckVYb0BLpAqbb+x8KlVp
 ghVPaMq3wXK8J1sSu3uSa+e2DxCHPAo0rnvs/J5ihTpq5WQHhe4lXWPw863JAhd97Fjd
 EVw6/AjPkVAN6YTgvhdDjaeDMUjGi/lb2HCOza54Mq2lfKQnLtWMBfOi2GqKsjO3W/dY
 ZvfRKoRMOIfdzXgrsPazxe0rg8uswQ+GGBDK5/0qKCjpsvJBNg0LsO3F52PGP3bltv7h
 xuz+ihEDDwI8Aym/KsXjWE9RABLOPozE2jwMKgY+1YdbnXVosOL50Nt31yVILMd7qwky
 N6Kg==
X-Gm-Message-State: AOJu0Ywontw79wZBJLmnHcqD6cXs++vNIWhfuc9IgRr9vqP41DiU5q3Q
 tv9mfuUZ2UWkFotvCNs6hq0IqnxOOrQ=
X-Google-Smtp-Source: AGHT+IEY+jUmo8Q0r2TIy8yAotVK48bGiwyLJ24NxTKUcEOssa9DchX0hLCnjDZzit0IfWaNg86uuw==
X-Received: by 2002:adf:ef8d:0:b0:313:f75b:c552 with SMTP id
 d13-20020adfef8d000000b00313f75bc552mr3734888wro.15.1695609409419; 
 Sun, 24 Sep 2023 19:36:49 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 16/28] bsd-user: Implement get/set[resuid/resgid/sid] and
 issetugid.
Date: Mon, 25 Sep 2023 00:01:24 +0300
Message-ID: <20230924210136.11966-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h           | 76 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 28 +++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 6ff07c0ac3..a5f301c72f 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -286,4 +286,80 @@ static inline abi_long do_bsd_setregid(abi_long arg1, abi_long arg2)
     return get_errno(setregid(arg1, arg2));
 }
 
+/* setresgid(2) */
+static inline abi_long do_bsd_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
+{
+    return get_errno(setresgid(rgid, egid, sgid));
+}
+
+/* setresuid(2) */
+static inline abi_long do_bsd_setresuid(uid_t ruid, uid_t euid, uid_t suid)
+{
+    return get_errno(setresuid(ruid, euid, suid));
+}
+
+/* getresuid(2) */
+static inline abi_long do_bsd_getresuid(abi_ulong arg1, abi_ulong arg2,
+        abi_ulong arg3)
+{
+    abi_long ret;
+    uid_t ruid, euid, suid;
+
+    ret = get_errno(getresuid(&ruid, &euid, &suid));
+    if (is_error(ret)) {
+            return ret;
+    }
+    if (put_user_s32(ruid, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    if (put_user_s32(euid, arg2)) {
+        return -TARGET_EFAULT;
+    }
+    if (put_user_s32(suid, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+/* getresgid(2) */
+static inline abi_long do_bsd_getresgid(abi_ulong arg1, abi_ulong arg2,
+                                        abi_ulong arg3)
+{
+    abi_long ret;
+    uid_t ruid, euid, suid;
+
+    ret = get_errno(getresgid(&ruid, &euid, &suid));
+    if (is_error(ret)) {
+            return ret;
+    }
+    if (put_user_s32(ruid, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    if (put_user_s32(euid, arg2)) {
+        return -TARGET_EFAULT;
+    }
+    if (put_user_s32(suid, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+/* getsid(2) */
+static inline abi_long do_bsd_getsid(abi_long arg1)
+{
+    return get_errno(getsid(arg1));
+}
+
+/* setsid(2) */
+static inline abi_long do_bsd_setsid(void)
+{
+    return get_errno(setsid());
+}
+
+/* issetugid(2) */
+static inline abi_long do_bsd_issetugid(void)
+{
+    return get_errno(issetugid());
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7565e69e76..7b51f4f16e 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -315,6 +315,34 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_setregid(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getresuid: /* getresuid(2) */
+        ret = do_bsd_getresuid(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getresgid: /* getresgid(2) */
+        ret = do_bsd_getresgid(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_setresuid: /* setresuid(2) */
+        ret = do_bsd_setresuid(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_setresgid: /* setresgid(2) */
+        ret = do_bsd_setresgid(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getsid: /* getsid(2) */
+        ret = do_bsd_getsid(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setsid: /* setsid(2) */
+        ret = do_bsd_setsid();
+        break;
+
+    case TARGET_FREEBSD_NR_issetugid: /* issetugid(2) */
+        ret = do_bsd_issetugid();
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


