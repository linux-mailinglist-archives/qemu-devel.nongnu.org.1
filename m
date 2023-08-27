Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F6478B922
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZI-0000Rz-8b; Mon, 28 Aug 2023 16:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZ6-0008U2-1v
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:26 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZ2-0007bk-TK
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:23 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so53840961fa.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253419; x=1693858219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNWJX9N7eMedxWSpyDRMtxE1oCTIUjFxpuItWl9On+4=;
 b=qZ0BHCYIhPdNNW+FJOBZNlcr7dmB8gXNLHNC315KUn/zPKhPEcEZvv1ZQkAP8Ty633
 RLS8geZz8k8Fc0EVXoiPTDgiiNC+MZOVBX9aWEari2SARUYwW8kpjurg9BI8zF0oE4aV
 nfP8dcOiWuzfw4K1cN6Ze8iAXW0X8gbLWBa+W15vl9B0a6OQD7pXa/cjSxkwhSHuIqcX
 8lK+X29cZDNnZxCpWek9eeX1+Qz8hNcLQ2/qoT34KnuXmRH4/GPArX5DxAaXcR0uKJBQ
 1zOoMjvVdxgAoG/RApQhWeNKTwsAz5MWNWB7iiJL2CRJ83y1XWEfPlyBkdzA79QP9+x1
 IWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253419; x=1693858219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNWJX9N7eMedxWSpyDRMtxE1oCTIUjFxpuItWl9On+4=;
 b=BkdCTzVOo9DeHyus8QqU1j3JtM3lTQdWDWndQMoaZjt8DEfDAh4EM3wm1hWLXMd4OI
 OCnPqcTw334b7S2SEC/ay8y7ggp1fCxioovzrPlFrZr9JI5GrLlZcE1AyvJDTOoC2A4t
 CNT/fAMlQTxmZSHFTKC5HHoBPqme0CTW6CWkZXFHrbVCp9AG8nDA3SX0hw7pitQ2jfxV
 1JaUmYaGmdYCveT8eoC+/iU7G5YdmxjNGsOHz7WSJrCZPSrgk3tkwSUk4dxk61A0gMXR
 aQ93E4ju5nqO+TkBsSZzFk7o15zyiEsMuJf3FemPt8Put6Jro9iHC2htH4nMneCsEbP6
 xJRw==
X-Gm-Message-State: AOJu0Yy84D67Gr/T8k5lQaiEFM5GZt0tNKQXDqkxvg7s/FJgZX7IiQXn
 Cj1Lod5cWOFMsXfOd+dNRGxONbuLfBWgSA==
X-Google-Smtp-Source: AGHT+IG54bJ+aJ/nrh0yu39bT+T7T1eJ4/h2hZ62sNEFLp7PVlQfiqaUOAAZSLPaAtJyopq4kCjfPw==
X-Received: by 2002:a2e:6a03:0:b0:2bc:d993:b7ba with SMTP id
 f3-20020a2e6a03000000b002bcd993b7bamr13007296ljc.27.1693253418828; 
 Mon, 28 Aug 2023 13:10:18 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:18 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 13/32] bsd-user: Implement umask(2),
 setlogin(2) and getlogin(2)
Date: Sun, 27 Aug 2023 17:57:27 +0200
Message-Id: <20230827155746.84781-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x233.google.com
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
 bsd-user/bsd-proc.h           | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index ecd6a13c2d..5228b4be78 100644
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
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(_getlogin(p, arg2));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 17160ab532..194248924d 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -228,6 +228,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.40.0


