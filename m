Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51F7ADEA4
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:27:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHU-0001DG-Nf; Mon, 25 Sep 2023 14:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHT-0001Ch-CN
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHR-0007Hk-7d
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4050bd2e33aso74588535e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666359; x=1696271159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0jw18nchCfPvc4qF6WttckGZZQd4GL3KWtYznFJQBA=;
 b=jT8+tmVBdypbP9RkFWeWTYJb4bEkMU0lSoOk2V9aQjzmRvi4uDrAUP9+b/aHzFa37u
 G3ljzdSXVe3lh3FwsXjKfcD+O91Nj9dFtQp5Sr0xtAw0UjMeS8GqjTnqNUUwISP5wTsu
 /HZPIzSq7edCaUd7U7Vts1QBWcnjKMeLI79Pb2qG6y6TZi95xyQyys6WqA9M9G6JVGPh
 FH5k9endt7II2g81pJJ2WiZ0S+W8GGuT9DS8tBHmkHtsyCUP7pjtX/cpoGuNns3ekG0U
 qZHXEPtYMhaxUt2hYQL3WjuEzhhwm6mtMBCeMTv5UvVcFNkjwxrNtikWodafhz4AoVmX
 N7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666359; x=1696271159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0jw18nchCfPvc4qF6WttckGZZQd4GL3KWtYznFJQBA=;
 b=BaPLcM+sIxK2Wv/IewUJR0t8leakChE6gYz1iYbMhpWvNK3heb80EZ/S9aAdE8wxyZ
 Y4zxHI2zZ85DAg2sSZ7d8wPpNVj/k9ke5acitHO/hCUbpVn6ePTRdAIz+qTFtw6n6fGH
 qmG6OODUCRld4F54U26YdEZkOJ53JyuejQq+Vdwxxtz+yAtEOQjPVctNGAL/8n3s00uk
 X3G4P6FRWQ+osxGt18zb9qUGah3ZeNfVl+egWqsbKN12vyFU4StO/BVbd2FlkwvMFAEs
 5drpxkHRIphmHCjUU23m10/Zp4fWrQC3wqDGn/SP7eohqtdABa6tugba8wGI5XDABLUx
 qepw==
X-Gm-Message-State: AOJu0Yza2ezc6jvLBIHNpJsVovEJzXqrWNAb0zwh9so/Bdsy3nuTZzsI
 q/CM+QeXdGGl4EFnVNdk/6sxlTX0pKY=
X-Google-Smtp-Source: AGHT+IG2zySgGPJHODQQlmwsXT1oXECJuOaVsm+u1A67WBKWYa8DYbHTo2AtfPw4FxnGRM5LDwU80g==
X-Received: by 2002:a05:600c:3798:b0:402:f501:447c with SMTP id
 o24-20020a05600c379800b00402f501447cmr6605815wmr.0.1695666358962; 
 Mon, 25 Sep 2023 11:25:58 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:25:58 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 06/28] bsd-user: Implement target_to_host_resource
 conversion function
Date: Mon, 25 Sep 2023 21:24:03 +0300
Message-ID: <20230925182425.3163-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
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


