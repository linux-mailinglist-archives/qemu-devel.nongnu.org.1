Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8278B938
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZM-0000wK-Vu; Mon, 28 Aug 2023 16:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZK-0000no-GR
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:38 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZI-0007j6-5V
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:38 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2bccda76fb1so54916481fa.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253434; x=1693858234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGJcl3BOXhUnndM8ORtPwX5e+vJ4bSok+GBn3iB9dGo=;
 b=Qe1Jy164KGnzx3V4d//xK12d6hhRdQyh5PfKSyhhNpyWk+YE54jFsD0R5ObiivrobF
 58S+9Cm7u81I9Bdo/J3vOSzOSnaQ/k5Mz4M6oMujAgrnqQJTOJP3ILGK+0Ijf5FnBXaF
 A5TVSNwLMtUgyqgWL41t8kM8tUXyfEzj6vf3LeT4HHTSkManur/B7jStDRkkSsHX1gB3
 2O+X83krc6Ial3FfTf8Pa7m94ZT9t8VxkpRqHYnTouwicwSVaKDPwXXEc/YaCBXK2ZHO
 4WVpD3oHV9WkO3yVF6Queo8tvVZZJ/hvbtz56TLrpYXihq5tDl2DxKSlbbvt+5QI94zt
 WsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253434; x=1693858234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGJcl3BOXhUnndM8ORtPwX5e+vJ4bSok+GBn3iB9dGo=;
 b=EFTVnhYnyOqsL+Ajyzr9GwGQ4CsuC1GPeITxkbTZDdNf84d1y5lKjB6q3x7sILGicL
 gPi6zAxgA4piuzieWLyf3hlUjBubt+gLabBF2ivd07ywJJ0gNuL3i0NvnncnC0h3u2tI
 TP/zA2Kwc1QwxO4uugqORkF83id3k+sQAuo+ZZiJGhin1VAU/c62zvf3FNFAjQi7HI3p
 +XY2apl+XoEtxO5nPAuxBPGfnuTgGGNCDNlyijwISVY9NVe9EpjSZyNvhizy3tzEGryJ
 IGi+Y07yAPW5XdDQ4rZBOJyikqmys2iKuf8gPZImQ5ylshSYdNY2Jyqh5EsMB/jbfwgB
 rWsQ==
X-Gm-Message-State: AOJu0YyC/4ZgGPwO2bm7LW4L73osYeNEE7L0OAT/Y1VMlg8HYZqYQfLx
 QOridrJejWXeWFjZ7zWv0GFO0+ewArhOEQ==
X-Google-Smtp-Source: AGHT+IHTcuH27i3giVmLPm/P4QdcbCobNzweiPeEzRd8rMUFTzhXg1ucU0KmnSg0/+DnARmJDgJq9Q==
X-Received: by 2002:a2e:8717:0:b0:2bc:c11c:4471 with SMTP id
 m23-20020a2e8717000000b002bcc11c4471mr18016366lji.21.1693253433925; 
 Mon, 28 Aug 2023 13:10:33 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 18/32] bsd-user: Add stubs for profil(2), ktrace(2),
 utrace(2) and ptrace(2).
Date: Sun, 27 Aug 2023 17:57:32 +0200
Message-Id: <20230827155746.84781-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x22d.google.com
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
 bsd-user/bsd-proc.h           | 28 ++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 5c072d75b7..c9b5a4cbb6 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -362,4 +362,32 @@ static inline abi_long do_bsd_issetugid(void)
     return get_errno(issetugid());
 }
 
+/* profil(2) */
+static inline abi_long do_bsd_profil(abi_long arg1, abi_long arg2,
+                                     abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
+/* ktrace(2) */
+static inline abi_long do_bsd_ktrace(abi_long arg1, abi_long arg2,
+                                     abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
+/* utrace(2) */
+static inline abi_long do_bsd_utrace(abi_long arg1, abi_long arg2)
+{
+    return -TARGET_ENOSYS;
+}
+
+
+/* ptrace(2) */
+static inline abi_long do_bsd_ptrace(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    return -TARGET_ENOSYS;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index bbfd260fe0..7c5c17e70b 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -340,6 +340,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_issetugid();
         break;
 
+    case TARGET_FREEBSD_NR_profil: /* profil(2) */
+        ret = do_bsd_profil(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_ktrace: /* ktrace(2) */
+        ret = do_bsd_ktrace(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
+        ret = do_bsd_utrace(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_ptrace: /* ptrace(2) */
+        ret = do_bsd_ptrace(arg1, arg2, arg3, arg4);
+        break;
+
 
         /*
          * File system calls.
-- 
2.40.0


