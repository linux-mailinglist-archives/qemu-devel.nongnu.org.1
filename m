Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4577AAFB
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzt-0007un-RC; Sun, 13 Aug 2023 15:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzr-0007u5-Ad
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzp-0002Sf-P2
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe1d9a8ec6so26609515e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955808; x=1692560608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLo5r1g4/RAPygywIJaYvQMkE2Y7Fg+pDuqNkJm5wq4=;
 b=GbdKwFIkikkE5cyVnyoU5B5lOU8+Ov+87dFHiPtXn4hTRRMuuaIUPUw3HKxOIzy6H/
 3l7w3PulQssIHZ4NNgj2jukkUoLt6hoRxAPmCMb0hpZxxuGSKFGZrWdDxbFUZlTNAU+a
 QZpG0ffhddmLKc0spisYZ8zToc0aXXd6bZQB1H6CPhpfpu41rundpk55l9XmHxRJX7RN
 Z8YPpVyuEbVPR51cFLzLG3hM0hwM+MYbtTmzDUcVajc1tqtbsCKgDwb9YTenVduiNq+Y
 4qFC41J9PapDO4L5V/OkyNR9IgzN+rHki0VPyNiVkI3Nys9+DMHo/3GlEleZQP2tBmmD
 ndCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955808; x=1692560608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLo5r1g4/RAPygywIJaYvQMkE2Y7Fg+pDuqNkJm5wq4=;
 b=j3rCE3G9DpWSGwcJzSBZ7fLiZrVAFHwM66Hxj1tbpggOiDvcGEYGx9tKnjuNEieb36
 Ex0z8QbzzcuxNj8BwBtbYBQ9UtVqddwHbJMBpsipUnd2DlnRIZX3uvfANPaQAFhW15Iq
 tr5wQA0dfAfaC5L3S7K58QcLunGFah7fWzYJMTnr2rDEP4fQzy/AYvQf0zV3oUh7vDyB
 x05T8tr+FcXAe7axtrxh/YIuB87+MHOdgB/8QOdjBGYZ/m7OeJhPUOXG+f0bc9AGEN37
 DMH1ENVuGetv3bg2ttI3TeXPLKOdi2W9K2QDJwqNjcehnWa0jfdckwuSdUOp8Mp5qQwa
 sSCA==
X-Gm-Message-State: AOJu0YwcxCRXyBCeJI47rt7ZIBeB2UUc9nUgfdB3Kqhfk+MdGuZflMAR
 mF4st9VdFVVJApnmqVe3DV/DCWPPEoA=
X-Google-Smtp-Source: AGHT+IGCxtjY545PwKdDWtp9+x9+i2voJYUNyQsFsMth1nDWAKb30V2e1smkbPIbn/XNSef8hM5MUg==
X-Received: by 2002:a7b:cd0d:0:b0:3fb:e1d0:6417 with SMTP id
 f13-20020a7bcd0d000000b003fbe1d06417mr8166809wmj.19.1691955807459; 
 Sun, 13 Aug 2023 12:43:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:27 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 23/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 10:41:44 +0200
Message-Id: <20230813084153.6510-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
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

From: Michal Meloun <mmel@FreeBSD.org>

Implement the freebsd11 variant of the following syscalls:
fstat(2)
fstatat(2)
fhstat(2)
fhstatfs(2)

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 78 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index aef55c8bb5..2e0c7245df 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -24,6 +24,17 @@ int freebsd11_stat(const char *path, struct freebsd11_stat *stat);
 __sym_compat(stat, freebsd11_stat, FBSD_1.0);
 int freebsd11_lstat(const char *path, struct freebsd11_stat *stat);
 __sym_compat(lstat, freebsd11_lstat, FBSD_1.0);
+int freebsd11_fstat(int fd, struct freebsd11_stat *stat);
+__sym_compat(fstat, freebsd11_fstat, FBSD_1.0);
+int freebsd11_fstatat(int fd, const char *path, struct freebsd11_stat *stat,
+        int flag);
+__sym_compat(fstatat, freebsd11_fstatat, FBSD_1.1);
+
+int freebsd11_fhstat(const fhandle_t *fhandle, struct freebsd11_stat *stat);
+__sym_compat(fhstat, freebsd11_fhstat, FBSD_1.0);
+int freebsd11_fhstatfs(const fhandle_t *fhandle, struct freebsd11_statfs * buf);
+__sym_compat(fhstatfs, freebsd11_fhstatfs, FBSD_1.0);
+int freebsd11_statfs(const char *path, struct freebsd11_statfs *buf);
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
@@ -57,6 +68,19 @@ static inline abi_long do_freebsd11_lstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* fstat(2) */
+static inline abi_long do_freebsd11_fstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct freebsd11_stat st;
+
+    ret = get_errno(freebsd11_fstat(arg1, &st));
+    if (!is_error(ret))  {
+        ret = h2t_freebsd11_stat(arg2, &st);
+    }
+    return ret;
+}
+
 /* fstat(2) */
 static inline abi_long do_freebsd_fstat(abi_long arg1, abi_long arg2)
 {
@@ -70,6 +94,23 @@ static inline abi_long do_freebsd_fstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* fstatat(2) */
+static inline abi_long do_freebsd11_fstatat(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg2);
+    ret = get_errno(freebsd11_fstatat(arg1, p, &st, arg4));
+    UNLOCK_PATH(p, arg2);
+    if (!is_error(ret) && arg3) {
+        ret = h2t_freebsd11_stat(arg3, &st);
+    }
+    return ret;
+}
+
 /* fstatat(2) */
 static inline abi_long do_freebsd_fstatat(abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4)
@@ -178,6 +219,24 @@ static inline abi_long do_freebsd_fhopen(abi_long arg1, abi_long arg2)
     return get_errno(fhopen(&host_fh, arg2));
 }
 
+/* fhstat(2) */
+static inline abi_long do_freebsd11_fhstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct freebsd11_stat host_sb;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(freebsd11_fhstat(&host_fh, &host_sb));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd11_stat(arg2, &host_sb);
+}
+
 /* fhstat(2) */
 static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
 {
@@ -196,6 +255,25 @@ static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
     return h2t_freebsd_stat(arg2, &host_sb);
 }
 
+/* fhstatfs(2) */
+static inline abi_long do_freebsd11_fhstatfs(abi_ulong target_fhp_addr,
+        abi_ulong target_stfs_addr)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct freebsd11_statfs host_stfs;
+
+    ret = t2h_freebsd_fhandle(&host_fh, target_fhp_addr);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(freebsd11_fhstatfs(&host_fh, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd11_statfs(target_stfs_addr, &host_stfs);
+}
+
 /* fhstatfs(2) */
 static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
         abi_ulong target_stfs_addr)
-- 
2.40.0


