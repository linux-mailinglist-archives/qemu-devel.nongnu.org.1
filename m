Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577F7A3DF4
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUR-0004Vj-Tg; Sun, 17 Sep 2023 17:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUP-0004UN-OB
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUO-0004FP-2h
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so3726935f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986774; x=1695591574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1vmTkZas+Mn1wLG44nID34aYL1fdKfYh9PS0Nb3bf0=;
 b=RbrQc40JdC1JsYsgrtpIdoyQybLRf6cMNZ0p61J4Zuz8v6G4D7x9KHyWLGLa8DAtql
 neTvcm88qc7szQWL40NEuahZ6b+HMR+n8B0ZJfRz6isGgn22AK7RRlpMd0l6VDQa78mD
 61kD2ZQurk79Rz2I9Ue//UhwhxWTelpaWtDF368SugLcHvBsahOTIcxuWd/GA5OjdlGP
 jMPQOIPFgV7R1WlBtuvmsfLtmUyLtccVFPzUGb3eYKuoDYhA/NIqeo+RWPf/+pSRdgS/
 yWKE1Gz2RtjkfYZaOzi1Zse1qi9f2TVNQO+MIuwsD+/5nNmVaA0XQBZLJ0R4Tk0ecQGC
 bTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986774; x=1695591574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1vmTkZas+Mn1wLG44nID34aYL1fdKfYh9PS0Nb3bf0=;
 b=g6B33CU1gnZ9ut7T62orDiYxBgWG0hez3gtbr2CG5wUtPjOBbZ9IP4KV5asBIV7egr
 jnhtFvpG1uc6wNttbF7SYRJ+DJjd5UE6e9Sty1Wgbci7yCkX0FgKrRljrUzggNvJmb9r
 /8QLfN4m/U88EgDPQi7W201rsLhi+epuYnYFLotEmnMM6Vv1vzdICvpW+WzR1s+Wvzqi
 PV/kJOfffqrR7R2bvCFBfJzTPlVFOcRT3Xo04nk0/i/fbkhgozf12opki+G29iuIRhdT
 TUs7f6LhtIVzWgYnwI0GnHAh2c6mX2DzOq3m7sq8Pk7cOjfXwCVAKCcbvfT05HGHHm8O
 XXlQ==
X-Gm-Message-State: AOJu0Yxt8MDYMrIgJNEjxPkHB/ClWhXp1huwzdDXWrQIsBRP8lxrA2ms
 78EBk+jg2V2r4vT0ONjGz5QhCDElZio=
X-Google-Smtp-Source: AGHT+IF42lktu9FJLWE9/D33Lvsc1U4lIDwUxYfqDdKYGXrAMb4/W9+Hc0IFCNvtobtIhK70hyelWg==
X-Received: by 2002:adf:a40c:0:b0:31f:fa1b:bbb3 with SMTP id
 d12-20020adfa40c000000b0031ffa1bbbb3mr4459562wra.40.1694986774367; 
 Sun, 17 Sep 2023 14:39:34 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:34 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 06/28] bsd-user: Implement target_to_host_resource
 conversion function
Date: Mon, 18 Sep 2023 00:37:41 +0300
Message-ID: <20230917213803.20683-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
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


