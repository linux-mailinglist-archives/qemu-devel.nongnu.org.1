Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C667D7A3E83
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bi-0006VZ-2J; Sun, 17 Sep 2023 18:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Be-0006TW-1v
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bc-0002uW-8T
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso44181725e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989454; x=1695594254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1vmTkZas+Mn1wLG44nID34aYL1fdKfYh9PS0Nb3bf0=;
 b=Npw633csGwvDQpcwGk0ABC5huDcuvdfBYOGM12A6MFw4ZEkpwEw83MGKH/4fAuiYA8
 wjFmCfzn4NyiA4lndDP72bwo2G86yF0slw+p9jc9m/VZrXtSl5+j42pAsZpYdJXwzL0f
 iZENMZZa4SPIIW3WLrunTP9eG7ivgUEoka/ku8jRnT0W3O2woqJx6ryxf0J7UlZ2BnaT
 ipnyWk0DR7cii4f1t+nHeICaobhEc+QpPhF5bQQSq3INOnoTyomPp2zxOiBEHEdEffjY
 cwhnngMTYUStfl9Z6T3QBjAfPHTb/9gLHgpea8HgZ1tWiJdzPl4HfTpfmKt9jeU/qo32
 OB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989454; x=1695594254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1vmTkZas+Mn1wLG44nID34aYL1fdKfYh9PS0Nb3bf0=;
 b=Uh4fKWqDoF5aVsXyfOIWXXLBxKAkd/v9jTmZFLi9d6dGZ46Ure/aocwScXBYuAiCWa
 zCfwSbT8KiO8LAhQ9vQcm2gWzEEfNWgk1zby8+8D5PfdNVVIf28SwISzZzMAEh+7q+oc
 8J6QHDpt2v4XHNbc9m0ChJIQ3nBa05A/C9xOL7je0vorOOpsTOaBxQQueHWFZ01rog69
 01RBfJHkj4UPp2px5s+fK6Y7N1xw6R+NgDY6cUT9BeQJPQkXDM9T/h7QFCxPwVbxS3N/
 y9CazJt+97R2txyJW9xC/H3miJW/bkTxXlhlEd5CybPzVb9ccfurbp8IHxNDUQ3AFWQf
 k9ew==
X-Gm-Message-State: AOJu0Yws8quSIefZGoYEhCsniYm3OCWMcV+eulIaRowGthfdj72IQCKe
 wDZ52bN6EKi1M3jcpQAE0+uZ65CgFgM=
X-Google-Smtp-Source: AGHT+IFHnN1r8RxG/koQcTNeHz+P7aM3qKbzd+eDqF9mucLhf2rBK1/gcOfQfgQAL7WXFT/7cM6l8Q==
X-Received: by 2002:adf:e40d:0:b0:317:61af:d64a with SMTP id
 g13-20020adfe40d000000b0031761afd64amr6472727wrm.3.1694989454524; 
 Sun, 17 Sep 2023 15:24:14 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:14 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 06/28] bsd-user: Implement target_to_host_resource
 conversion function
Date: Mon, 18 Sep 2023 01:22:23 +0300
Message-ID: <20230917222246.1921-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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


