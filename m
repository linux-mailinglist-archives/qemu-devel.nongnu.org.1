Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A54077B7513
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovF-000444-5J; Tue, 03 Oct 2023 19:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovB-00040K-8q
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:21 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov9-0006q9-Gi
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:20 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35133097583so5856445ab.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376118; x=1696980918;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ieaVmtKu6WB7XBYFcTLrCbXTONlGyxzlpnV4UW4ZRY=;
 b=vgG0NfFSs826xUkDXUwaQwvw856BpYzk7dSL3OOH47EoZ5sOKHJ+tPc7KwKPPyJRdh
 1b2CfQnzV/yBZBSsvDSoGqvCCqMbgJNP/0PdGv51ae2NlNpDqZVCB+4Q2xk+xryrRfUf
 3ZTSQgYIGjQPQvVjoYMzilNjYw8LYEho9kMsG0PcOpUH9PCUvrIDcYQQbuWETOIXttV4
 gsE5m8GbTf7LBWfy8GSQ/sn/EoPGu5uzbiTo/tqVsIqssUwf2cgKVDR7sPVwQen+4sb4
 wj2vYDv4UjnZxXABaKsrm2dqGJsYiWrIRUptfUPYcCKx8GGNDXbTeiHXuPbfZ3GmOEir
 uevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376118; x=1696980918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ieaVmtKu6WB7XBYFcTLrCbXTONlGyxzlpnV4UW4ZRY=;
 b=TLGys+DwL5ZQWvKjH65LDD6hvCiNBtqoD9jY9LiV89jgizU2fdo+/OWHuE+0Gzeurg
 rYO9gr1L6uEOvTKpnzlP38yRfhJeQu0B9a2YmbsLtb6/VMYeeCLItzEdZXgOgRXRB2SU
 6LJm/Dv1kMKXgAuqp3Am3DUds3tL/9psYbhW4joiy7We4i6e80f/RxUWarEFB3gMA4eM
 Gr9++q3cTy9r9m8zLaM3qQf7RIW4HSYjavAglUHbBuz0Ya5j/MRqFx2vmnZpWKW3oAlz
 J2X3UXIR3U3ULKE0O5eXqSEBT/kmGvdUHespVqktCYNQ4k5Za7ifa/rGwBf7BimuSNPo
 QvLA==
X-Gm-Message-State: AOJu0Yy3vQXewp96S+m6/B5c7A5NIRVtU5gOXff6A40BflCKjSnDDDVs
 SB/EDrZZPf66/sVF3PsfFxRimZBJOLNISAc6ELBB2w==
X-Google-Smtp-Source: AGHT+IFMtdvEoOHG9DOjBFAK1IjGbs+cEgXLsDRAScOqeqR/wHqtYhLnQlokB6ZZgA/mS32iskYxAQ==
X-Received: by 2002:a6b:c413:0:b0:79a:b526:2f2a with SMTP id
 y19-20020a6bc413000000b0079ab5262f2amr823991ioa.5.1696376117918; 
 Tue, 03 Oct 2023 16:35:17 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:17 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 12/51] bsd-user: Implement umask(2), setlogin(2) and getlogin(2)
Date: Tue,  3 Oct 2023 17:31:36 -0600
Message-ID: <20231003233215.95557-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::129;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x129.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-13-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 7b25aa19829..cb7c69acb0c 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -26,6 +26,7 @@
 #include "gdbstub/syscalls.h"
 #include "qemu/plugin.h"
 
+extern int _getlogin(char*, int);
 int bsd_get_ncpu(void);
 
 /* exit(2) */
@@ -85,4 +86,42 @@ static inline abi_long do_bsd_setgroups(abi_long gidsetsize, abi_long arg2)
     return get_errno(setgroups(gidsetsize, grouplist));
 }
 
+/* umask(2) */
+static inline abi_long do_bsd_umask(abi_long arg1)
+{
+    return get_errno(umask(arg1));
+}
+
+/* setlogin(2) */
+static inline abi_long do_bsd_setlogin(abi_long arg1)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setlogin(p));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* getlogin(2) */
+static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(_getlogin(p, arg2));
+    unlock_user(p, arg1, arg2);
+
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 535e6287bde..44cbf52f087 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -231,6 +231,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_setgroups(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_umask: /* umask(2) */
+        ret = do_bsd_umask(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setlogin: /* setlogin(2) */
+        ret = do_bsd_setlogin(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_getlogin: /* getlogin(2) */
+        ret = do_bsd_getlogin(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.41.0


