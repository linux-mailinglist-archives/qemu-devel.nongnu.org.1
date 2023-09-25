Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 199737ADEC0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:30:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHs-0001NT-4X; Mon, 25 Sep 2023 14:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHn-0001MA-UT
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:23 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHl-0007RG-VY
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32179d3c167so6066087f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666380; x=1696271180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vvWAJOaU9svMDhrs7MJr+20FyL1xi564pnSJRDac5w=;
 b=Xd6vGa/Dx2WKjt1nyHC/cpgPfkCgBMgBlycYcRYWegm2Lmp3ippmY5hOXsq4UuOU6G
 gBldAefS6ACRjU7mGL6vSQmlxVz0cNXGsgqNYLzcJ01spIs/3wX09pGFQ8EbhomjuWkK
 FcutebLWGJ/DPEsFfqLmNmUmidWc4kkMVPReAvR2fbejDHvCFV5oCZiOvKnBYTx7rUqm
 0XEUDYJ9PDGp6m5NlG+QOWOA5SqmQm1SSmpZrEtUTxffexvLgtT3iv8+dnly/cGo5RTX
 XP0xTGgLkuGY5DVNe4iagpJI2YeoVaU8Osv+7fOucb1KWJhDvsZW67X8dk0UiIGrpOAw
 7ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666380; x=1696271180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vvWAJOaU9svMDhrs7MJr+20FyL1xi564pnSJRDac5w=;
 b=sVuIxIZwGPZDdVIosl2go9ouF8na+cBMoK0io7iw0VJwiuN6n0k6kOI4wd2w2z3XTj
 HptBFqFSoAZGv5T62KLkitVUTBK8TbFfkAYVbuRNfSxdVEK/U+V0knh8tYyqWMER5e0t
 JAKEEDVh+hxO06quTZc1u2KAyYz9k0yAO3ntzEAVS7kIGaDomn/GfmOQCEOw0Knsaunf
 3rGD6+4Zcye8Wff5W4jHBhTuPweiZ76AMBENlFsi4PuDrESvTVmdeaWCZNDfA0TCmEcu
 RqgZV6l3dgj8nERQXWdpRArA2odg3zHxfQDEW7i3HukdXuIoUxZ47guFa8cEPHUjo4cB
 +EAA==
X-Gm-Message-State: AOJu0Yw4S2hkLVqYlrv7a7zNh4+wccm73a4vob2hGM4H09q9G5XFXeDL
 9h4d0lpXOkber5ufvYf6AVhy7lde5w8=
X-Google-Smtp-Source: AGHT+IEhmhJyOA2pQX399BN6e0IIBqc25bRR89CY7VPw4pbAizlxuLKyfl7ACDmPwxiHrI/gN1FObg==
X-Received: by 2002:adf:f9ce:0:b0:317:55c:4936 with SMTP id
 w14-20020adff9ce000000b00317055c4936mr6811624wrr.9.1695666380033; 
 Mon, 25 Sep 2023 11:26:20 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:19 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Stacey Son <sson@FreeBSD.org>
Subject: [PATCH v5 22/28] bsd-user: Implement execve(2) and fexecve(2) system
 calls.
Date: Mon, 25 Sep 2023 21:24:19 +0300
Message-ID: <20230925182425.3163-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-proc.h    | 49 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 11 +++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 bsd-user/freebsd/os-proc.h

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
new file mode 100644
index 0000000000..75ed39f8dd
--- /dev/null
+++ b/bsd-user/freebsd/os-proc.h
@@ -0,0 +1,49 @@
+/*
+ *  process related system call shims and definitions
+ *
+ *  Copyright (c) 2013-14 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BSD_USER_FREEBSD_OS_PROC_H
+#define BSD_USER_FREEBSD_OS_PROC_H
+
+#include <sys/param.h>
+#include <sys/procctl.h>
+#include <sys/signal.h>
+#include <sys/types.h>
+#include <sys/procdesc.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "target_arch_cpu.h"
+
+/* execve(2) */
+static inline abi_long do_freebsd_execve(abi_ulong path_or_fd, abi_ulong argp,
+        abi_ulong envp)
+{
+
+    return freebsd_exec_common(path_or_fd, argp, envp, 0);
+}
+
+/* fexecve(2) */
+static inline abi_long do_freebsd_fexecve(abi_ulong path_or_fd, abi_ulong argp,
+        abi_ulong envp)
+{
+
+    return freebsd_exec_common(path_or_fd, argp, envp, 1);
+}
+
+#endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index b7bd0b92a6..515eaaf31f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -36,8 +36,9 @@
 #include "bsd-file.h"
 #include "bsd-proc.h"
 
-/* *BSD dependent syscall shims */
+/* BSD dependent syscall shims */
 #include "os-stat.h"
+#include "os-proc.h"
 
 /* I/O */
 safe_syscall3(int, open, const char *, path, int, flags, mode_t, mode);
@@ -219,6 +220,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         /*
          * process system calls
          */
+    case TARGET_FREEBSD_NR_execve: /* execve(2) */
+        ret = do_freebsd_execve(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_fexecve: /* fexecve(2) */
+        ret = do_freebsd_fexecve(arg1, arg2, arg3);
+        break;
+
     case TARGET_FREEBSD_NR_exit: /* exit(2) */
         ret = do_bsd_exit(cpu_env, arg1);
         break;
-- 
2.42.0


