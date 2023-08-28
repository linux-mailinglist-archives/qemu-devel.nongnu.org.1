Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD778BBB8
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:45:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsQ-0003uj-7O; Mon, 28 Aug 2023 19:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003se-GP
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006qY-Up
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:19 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79241bb5807so136357039f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266130; x=1693870930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fr2lJgWGvnGEd848mGunRkkes2I0QZce3Voahhm5Tb0=;
 b=bTqL6yN4gMgYrvIljZedJf0SZkfVhBgwW6zBxIGj0opSeXPgE5mZvxHc8zMImCf/X9
 G+ShVuyd6zR6V6Php2/9OXb+0asVCqw8be2c3Kx/wScjtI6HpMmkFxGy+11+l5KBk45R
 rnSq/dIrqrRAJc6SA0dyK1RbX98a0xBsLjPMHv9G7EmUwEciOh6R7PP87IL1CibVuX0Q
 dQ03U6Gkpja9m1HVhxOtlxwF5QBDFMj6JLUOSmUJKpSd3ocaGTQmjo7XG+pj34T+rSBD
 379Cc7E6noziLrs1aLO/nMN2IzAgGuu/+sD3wdf0iey/9T/sAosCVWrVZRXTg5dWacA+
 woUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266130; x=1693870930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fr2lJgWGvnGEd848mGunRkkes2I0QZce3Voahhm5Tb0=;
 b=hEbonbRjRCwb3USDvBQt2S30YpaQiPcUd0dAXV9+d6xAevjJhpNXkJD3vn2jtPWkBK
 ioVYZ4oP/f98lzCM6P7L2FhHd2Nzv/7DdwcD/ibO5T8fMCHUMKRDDPzG6bvY9rcyInpW
 VO3B8J6AUR8HiDPPP+uwZiIE/z2BbN08PTfLxoRDyjw+7sMkxta3hGQ6l1tGREvFdOKg
 R9R9OPQ9mzaYK5qKPNfLy2Cpp0JpqLWaNcLneKWpBVsIjk/I4c/P34COrX3fyykDlhNP
 sOf+ntL6hUrXgNFJW+E0qFgogufUakhZH4h6qAke89ZdAkFcZg6M4k5iJDkh8HDr/EMg
 mpsA==
X-Gm-Message-State: AOJu0Yx61irMlqSfrkqzvoALkFALdKSJMKsFxFu9wMs4lsCtB9ENizD4
 3ZK4QLDMYrzUMBIKsbxwNiHn1LdDu1S7szUIl7c=
X-Google-Smtp-Source: AGHT+IFF0Jo0ma4ELvDcvQQkA/atoyJoLsCwGpQMtN0ixiJU45a7AbnPFDNxE+A0N/CXPlg5O6Mmuw==
X-Received: by 2002:a05:6e02:1a4f:b0:349:8811:fc51 with SMTP id
 u15-20020a056e021a4f00b003498811fc51mr20839630ilv.20.1693266129840; 
 Mon, 28 Aug 2023 16:42:09 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 35/36] bsd-user: Add getdents and fcntl related system calls
Date: Mon, 28 Aug 2023 17:38:20 -0600
Message-ID: <20230828233821.43074-36-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
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

Add glue to call the following syscalls to the freebsd_syscall:

freebsd11_getdents
getdirentries
freebsd11_getdirentries
fcntl

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 916a754bf8b..e9b1b663af4 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -576,6 +576,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_getfsstat(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_getdents: /* getdents(2) */
+        ret = do_freebsd11_getdents(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getdirentries: /* getdirentries(2) */
+        ret = do_freebsd_getdirentries(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getdirentries: /* getdirentries(2) */
+        ret = do_freebsd11_getdirentries(arg1, arg2, arg3, arg4);
+        break;
+    case TARGET_FREEBSD_NR_fcntl: /* fcntl(2) */
+        ret = do_freebsd_fcntl(arg1, arg2, arg3);
+        break;
+
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.41.0


