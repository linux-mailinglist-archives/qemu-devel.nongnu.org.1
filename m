Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A261C7A3E88
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bs-0006Zk-Qe; Sun, 17 Sep 2023 18:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bq-0006YW-Gz
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:30 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bo-0002wZ-KM
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso3825133f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989467; x=1695594267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XO44dATT/BC4OT705qsiRIOdp9R+PZLsbNAQswN5pU=;
 b=hnJm1eNOPmRt24qecrew52OAFn3n0icLshWPUB7thhXpCO6a4BZ2OyRIGVTlmsf7v5
 jr51Xw0N7LmZZ3TqvFkGh5B9rexIUG2kFybLYUdqE3eGvZ7SHNKX6NGLiELAbNRSVd3/
 NrAeCA5yrwRYDFtxmhIFvzSVs1SDYp6NCOAjvFRZI5rycv3t+gJteeLSJuzJfnZzZtsW
 Vq6EcmYdbl3Juh8vCj3MkDTHuvuMq2FjL7idGHt56g/EDjosQfJxNGTDJ2VcO18Cn5nE
 Y1o5M78zDDnGcZ5UDMlYxywva4akICX6cETSbxknELXT47Ho672wzYtWx7+ie0kYrv9Q
 /YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989467; x=1695594267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XO44dATT/BC4OT705qsiRIOdp9R+PZLsbNAQswN5pU=;
 b=vPcmXDpcPpuARaajFVZ4/L3ajbHKv/9CQfDgzEykLKa2Y7iWrC4mw3OSV4Wb6g2k+u
 wC4yza5Vijq43XTD35eOfygTZ+wXWM9r03YcIs1Ur/fBOa4rOn7Ljd6971jINlNx6zlV
 V1dpA8XhtLPjVwd2qu4O9UmzSWJ36IXfIGoOOcEW35moSUwU5Br+F3O/kuPDmrcshxWX
 TkFa89NRVMekB2ZrfS+dKIhyMjUzmWLlykIlYH1cO24LIdLW3bXxn3QFe7SWH80PkOfn
 G/Fq8pfWr0wH0UDWe+NWWlMHh7RGNwjPHfQbfkobWkSvSzo8R7dNiTE/AIwhhtzCKAFZ
 ZC+g==
X-Gm-Message-State: AOJu0YyrID7WjO72ZMpLui0vwZ6Fv6En/osI+ca7PWJrPGY66jBB50ar
 WdU6WuCb8FnQWe0Twf//+HFptr3CBdw=
X-Google-Smtp-Source: AGHT+IHxad3yXQpTORn97UkAIgnU4e9mIrqRhSYI/jt1/ThAh5OVp2VZzUzzxOVAhGfiNg+qclIH5g==
X-Received: by 2002:adf:f80e:0:b0:313:f45f:74a1 with SMTP id
 s14-20020adff80e000000b00313f45f74a1mr5818434wrp.51.1694989466933; 
 Sun, 17 Sep 2023 15:24:26 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 16/28] bsd-user: Implement get/set[resuid/resgid/sid] and
 issetugid.
Date: Mon, 18 Sep 2023 01:22:33 +0300
Message-ID: <20230917222246.1921-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x430.google.com
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
---
 bsd-user/bsd-proc.h           | 76 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 28 +++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 9709939337..edbd408995 100644
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


