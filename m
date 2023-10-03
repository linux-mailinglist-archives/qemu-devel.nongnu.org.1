Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA84D7B754B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovA-0003y0-Hz; Tue, 03 Oct 2023 19:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov6-0003vx-Lq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:16 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov3-0006gy-UL
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:16 -0400
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so59899339f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376112; x=1696980912;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFpktNXIySwtSsbpcJMzWq911+k8gCH4IHFHAdVVqKM=;
 b=E++xI/zizL7OjRk7lk61mjLYqrpizSdeWJGEEGzBnw1hBJSd6YT3A728j3JCRliNF6
 eiFHXp2sHC30QFUFUHaj7adf7SE2cUe3pltO532bGdy5Tt1BfO/9vJpqSkBjLGP6vrBP
 t/02TxF4v+xPRO6XOo6DlFQzDetRo6FRoaDAnGfHjMzBC5RFa5Ttf8PAPG8Xh9ouPGCe
 Q7wVRn4vu85IBWXFFfzb3gmzL9kCLAnXr+bR4auSutTKadtPp9LMlOumEXXoWQD40uWm
 e4oYzStGjThIedEEA3BGEZcqAYDm9IMqcgRdadCQ3Dn8MKgg6WvQ3x83fzcYArgr5ZtS
 QJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376112; x=1696980912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFpktNXIySwtSsbpcJMzWq911+k8gCH4IHFHAdVVqKM=;
 b=cqfXgBT8c3njWQNKbnk50arRj2JVG0BlSZgxPdTc3cnTqWUz8vHpoWh47dZBHzOgGE
 UbowWz7UmzJpnutm6XaZG35oHKelRIk0OdeflCR15QDyWcHDwj+UB2KArZSJ5Wc1SdOH
 /e0vASLFrG104oalLd+2AmTFEyB3p0yQ75xn7z1n/5BSPLntAMnsE/HHAjujKICNPQ2/
 TOqgmta7WwMLGPIhBhE3PhVVao1ZoIgafJP1Y4MSoSxMZTjZpFERLiRab9ivfQhQ36td
 ucDfz92cUAbDYQdRf4CAVhNZzCCQzGv48P101sLyD7o5lsdUeLLnCQJIKIooErP53eI0
 9U4w==
X-Gm-Message-State: AOJu0YxTN8ra/0fLvCmxxQZerLuIGtQ/vyZSXqhSA7dX/3gqKIcVPufa
 6wIOUz+bkAGZKxDB3cnAG8Tp+V+SxkzOwOloT1HNGReb
X-Google-Smtp-Source: AGHT+IEKgm8wmfJAJGTrKRwsn7yuTREMwSJ/dCr2EA7jHzkdPeFF4asHknSy4uYifxXyD4FZjmPduA==
X-Received: by 2002:a5e:8804:0:b0:7a2:9fd3:5684 with SMTP id
 l4-20020a5e8804000000b007a29fd35684mr835735ioj.18.1696376112473; 
 Tue, 03 Oct 2023 16:35:12 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:12 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 06/51] bsd-user: Implement target_to_host_resource conversion
 function
Date: Tue,  3 Oct 2023 17:31:30 -0600
Message-ID: <20231003233215.95557-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d44;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd44.google.com
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
Message-Id: <20230925182425.3163-7-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 bsd-user/bsd-proc.h  |  4 ++++
 bsd-user/meson.build |  6 ++++++
 3 files changed, 50 insertions(+)
 create mode 100644 bsd-user/bsd-proc.c

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
new file mode 100644
index 00000000000..68410a0aa9d
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
index a1061bffb8f..048773a75dd 100644
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
index 5243122fc56..b97fce14722 100644
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
2.41.0


