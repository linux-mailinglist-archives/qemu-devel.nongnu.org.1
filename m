Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C078B93E
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiaY-0006mw-Mx; Mon, 28 Aug 2023 16:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaM-0005v1-E1
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:43 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaK-0007qN-7F
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:42 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bcd7a207f7so53741151fa.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253498; x=1693858298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W65M7HH3Q3sGEW0PbGnCjv8Ja2Yp2eCkyr/Z1oFCq/k=;
 b=cdGVrbJBJHOZGJTea2X4l+bomIL7IzNE5aeEc7H9RpQk/I4LY4t/fyasOrQZVhnmPR
 mk8BlgDXDwWU3bSQyO+bd8l2cSuiexeAVXpQfexUBlLq7kLFji0mB6KxyZbBwCy733Qm
 1/9t65HsWXwDySbO8S1YIFagAQnbRQRSDVb8fRzXcIgvUHdZkS4o8/bHsnpLrlySIDH+
 abAxACR9LWEtQoMg34GpsyoqQzrLnUMryUlaHpI6q7ClnTE4yD7ROdhhgjgJ1HVvCq/t
 N3H0L4xByRe9qiMwyS6K4Bbwym3AB6pk0UzWpsIGVzZ8PLb1y5Vm7XD2JIedd5dgqJJ3
 sttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253498; x=1693858298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W65M7HH3Q3sGEW0PbGnCjv8Ja2Yp2eCkyr/Z1oFCq/k=;
 b=Qu72wI5/USWp8VZgIWw2CEwXKWJFPxqCb3PEFVcxo515rF7ceJFgCAYu/k5IAbGhcp
 78BE63QGFSHOK0nPXFLf5Cgngwpduk0xufbVHcwTuzDhMWpbMrMY4PY1sSdL3WNH9zvC
 dutuTtm2IIP7CumfQLx6fuU4JAm2jb38tYYMHCGx2N2XJeoxzHgG2xRDszWBr5Ky5Rsf
 uwDSQhE1pt9R4G4YhT5I3OdFO8IW+UkvS2W6+Ok1a2cFBkSx4dAVBnSojp93O6VPJ6Nt
 LC1qx/RgAjN9uExakCaqb+ftKDZjuVZp3Bgzo+zadWVdIaPkU0EboA4VzbKHJ0rKyBCr
 lmhw==
X-Gm-Message-State: AOJu0Yyk2nzaQQYkZK5uBs1RaZRT2PeD6S7oyZnYBZFOA5ovlsi5Xy+r
 jt283PDhmnUJXL2ZYGAC4BeBvM4nLC7C5Q==
X-Google-Smtp-Source: AGHT+IG/fbX55k6MzD2qRoM5LOl9VTdhtvZBfnGiOYnIsl3qQ3MFZk1zP3eBtTbebaKnctmBD72Lcw==
X-Received: by 2002:a2e:87d5:0:b0:2bc:ed75:1ba with SMTP id
 v21-20020a2e87d5000000b002bced7501bamr9121062ljj.16.1693253497925; 
 Mon, 28 Aug 2023 13:11:37 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 30/32] bsd-user: Implement fork(2) and vfork(2) system calls.
Date: Sun, 27 Aug 2023 17:57:44 +0200
Message-Id: <20230827155746.84781-31-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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
---
 bsd-user/freebsd/os-proc.h    | 34 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index bfd72c726c..385fc15adf 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -176,4 +176,38 @@ static inline abi_long do_freebsd___setugid(abi_long arg1)
     return get_errno(__setugid(arg1));
 }
 
+/* fork(2) */
+static inline abi_long do_freebsd_fork(void *cpu_env)
+{
+    abi_long ret;
+    abi_ulong child_flag;
+
+    fork_start();
+    ret = fork();
+    if (ret == 0) {
+        /* child */
+        child_flag = 1;
+        target_cpu_clone_regs(cpu_env, 0);
+    } else {
+        /* parent */
+        child_flag = 0;
+    }
+
+    /*
+     * The fork system call sets a child flag in the second return
+     * value: 0 for parent process, 1 for child process.
+     */
+    set_second_rval(cpu_env, child_flag);
+
+    fork_end(child_flag);
+
+    return ret;
+}
+
+/* vfork(2) */
+static inline abi_long do_freebsd_vfork(void *cpu_env)
+{
+    return do_freebsd_fork(cpu_env);
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 52be71546a..84c9bffff5 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -224,6 +224,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         /*
          * process system calls
          */
+    case TARGET_FREEBSD_NR_fork: /* fork(2) */
+        ret = do_freebsd_fork(cpu_env);
+        break;
+
+    case TARGET_FREEBSD_NR_vfork: /* vfork(2) */
+        ret = do_freebsd_vfork(cpu_env);
+        break;
+
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
         ret = do_freebsd_execve(arg1, arg2, arg3);
         break;
-- 
2.40.0


