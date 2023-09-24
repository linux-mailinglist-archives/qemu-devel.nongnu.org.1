Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA87ACE47
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSj-0003H1-PP; Sun, 24 Sep 2023 22:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSh-0003Ft-SN
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSg-000055-3z
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4053c6f0db8so44954925e9.3
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609396; x=1696214196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1vmTkZas+Mn1wLG44nID34aYL1fdKfYh9PS0Nb3bf0=;
 b=lHWCQSiG+s0E/rW054RJCbUb/cyihPnDFlWkqQklSrL202zqAa82NpVbnLa7iRDFu1
 Gt/ByPmlPjksOjKOVYsvN1dE7cmzr1KoHGgSpZiTwidOdAkVEbND4S6cuye6+DFZXsXc
 5H4VqYf6hg9Jq2OXCiecSdZccetoAsRjF9JGOAkVMR5HAvd8UWuPt119wcmnI2UsloHi
 arWu/4I1wsO66zemdo0ckQiXMiO7MzEmfGn5dXr1El9dhLppUsEP/Vh/0/egqEFXefEE
 MyJa5Olr4xMyC6s/GYZNiuSMv8OAexEbnEnZnz6fLB8HsRXAADMvwu35PZkAifdgIGqs
 xTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609396; x=1696214196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1vmTkZas+Mn1wLG44nID34aYL1fdKfYh9PS0Nb3bf0=;
 b=bCqUtXfh5f6WdG9I6v4gIcZyKLK5Airm/+ZA9PrtyD4atekAJml9QgvsLK5Tkgtccx
 dY9MVHI1YeKpqBu/JOigI5HEGPyMD+VAIpfe5KpRgNbAEm4oCRcYtPJpksKzkX+Y/RK4
 THYo+/xNFHOHv1TE7KEJOjlYV+WdUeAwM+vAFVH/tPfofd2yWSiTDqrTdoZTdoHx6N8/
 acosLmpQWZ+wkV9bB22oYlkG6Awq+i0W6s2F9XvL2zNKVuN91yR/4z9RBjizmUPw1kov
 c9PQAG0I1p+3EzNc7nsuRUV9d+HjSfe9cO7XTBO3Vjum3kQymF3a89hNXrlckua9rSOP
 nebw==
X-Gm-Message-State: AOJu0Ywxl8FkBhlaXpO3vVikcmBD7g4Z9gq8VgUCwz1YRmT1qxTVP679
 3ZHODOJgWr67yBrUZUY7fIvVZMV50RM=
X-Google-Smtp-Source: AGHT+IGAPcL3kYSahaDH+Kieh9ygu0xNycz0CqpVjJgcKiSqwIeXp/zyX+cy3oeHfrMA2E0tvEcEMw==
X-Received: by 2002:a7b:cd88:0:b0:401:1b58:72f7 with SMTP id
 y8-20020a7bcd88000000b004011b5872f7mr4451714wmj.38.1695609396309; 
 Sun, 24 Sep 2023 19:36:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 06/28] bsd-user: Implement target_to_host_resource
 conversion function
Date: Mon, 25 Sep 2023 00:01:14 +0300
Message-ID: <20230924210136.11966-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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
---
 bsd-user/bsd-proc.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 bsd-user/bsd-proc.h  |  4 ++++
 bsd-user/meson.build |  6 ++++++
 3 files changed, 50 insertions(+)
 create mode 100644 bsd-user/bsd-proc.c

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
new file mode 100644
index 0000000000..68410a0aa9
--- /dev/null
+++ b/bsd-user/bsd-proc.c
@@ -0,0 +1,40 @@
+/*
+ *  BSD process related system call helpers
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
+#include "qemu/osdep.h"
+
+#include <sys/param.h>
+#include <sys/types.h>
+#include <sys/cpuset.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
+
+#include "qemu.h"
+#include "qemu-bsd.h"
+#include "signal-common.h"
+
+#include "bsd-proc.h"
+
+/*
+ * resource/rusage conversion
+ */
+int target_to_host_resource(int code)
+{
+    return code;
+}
+
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index a1061bffb8..048773a75d 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -22,6 +22,10 @@
 
 #include <sys/resource.h>
 
+#include "qemu-bsd.h"
+#include "gdbstub/syscalls.h"
+#include "qemu/plugin.h"
+
 /* exit(2) */
 static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
 {
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 5243122fc5..b97fce1472 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-proc.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
@@ -16,6 +17,11 @@ bsd_user_ss.add(files(
   'uaccess.c',
 ))
 
+elf = cc.find_library('elf', required: true)
+procstat = cc.find_library('procstat', required: true)
+kvm = cc.find_library('kvm', required: true)
+bsd_user_ss.add(elf, procstat, kvm)
+
 # Pull in the OS-specific build glue, if any
 subdir(targetos)
 
-- 
2.42.0


