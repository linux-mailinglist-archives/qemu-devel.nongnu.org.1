Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1E7ADEB9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHh-0001Kd-F4; Mon, 25 Sep 2023 14:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHf-0001Jm-8v
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHd-0007Le-Gk
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32179d3c167so6065805f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666371; x=1696271171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nclM6JiCGY7mFmLYiUs3Sh+q/hGi5ONE8JD20ZP5YqQ=;
 b=eTpAwGtiGYFfPVaVlWGR2Gf/R1ize4n3vJd8tg+nQV17nZfC8v0tBeviMYd+3iAdbn
 X4fJRuR05PIK8VOx+Y0abhhEAn3Eu/Pxhz/Vandp/s1SBt/2bh/LHb1ycTxj83zdiNx9
 rdQCi3bwG4xegBw3fCV6T8n9kqXq6mMuTGPqYxDs9UU23k/QgsSnoHDpPLOsaScXceQW
 3gSmSIOHgZwXZg9j3qOTovWxUpUSjolCpGunmdW3UCpa3Vr3KQI7CVLQDEDy9iq2aWIY
 TWXlZYvNGjWvMsjSQg9fmj0URCtFicSiNrPPr6H0Fb7sGq53NcLCFkDphuNzoqV9szia
 JPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666371; x=1696271171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nclM6JiCGY7mFmLYiUs3Sh+q/hGi5ONE8JD20ZP5YqQ=;
 b=FKiZMWK4olZPyq0qZdufj/VxSLa3PhCYnf4LV7B2IxU9VwcIscnPchNTzEsbQYIcEt
 u9LcXNrNAidi0LNu9fhMBEu/Ig1dmfeHiVa+iOAuNaY2tNoZ8OipkzhupU9CcblhcpEW
 PMO9dqkRSURRomCvHxb0PRIApvQfhRaYZDjra3cFjG/w493yXINqPY2R/SGIVp884Z3k
 +wnw98MwxNNf/lzJznENnqfR/H94oiTtQO6tBVQhpxcCZ1B8dYOW+DEoUBDMxHOkDcf8
 C4Rqt1kh51rFWoI/MFyflMlGxuStZKDJaxe84bOmbTSnSqMVcnHsqob6vzknR+lgAwTI
 +UHw==
X-Gm-Message-State: AOJu0Yw1WjmGq1raGpLdLQVxT3Qi6+fdgzYEDwgAmyOZstX4XvurDgsJ
 YsjyBZUmIDjWW8zuEQi+zp9bNwFe5pc=
X-Google-Smtp-Source: AGHT+IEtPSZaADLHiTrvBqEg1e/+bcM3X66Op/aa8AIgynWSDMMBnmQ+YvcG99ZTNjuYIOUuSR6dSA==
X-Received: by 2002:a5d:60d2:0:b0:321:6bed:1646 with SMTP id
 x18-20020a5d60d2000000b003216bed1646mr6849134wrt.14.1695666371419; 
 Mon, 25 Sep 2023 11:26:11 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:11 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 16/28] bsd-user: Implement get/set[resuid/resgid/sid] and
 issetugid.
Date: Mon, 25 Sep 2023 21:24:13 +0300
Message-ID: <20230925182425.3163-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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


