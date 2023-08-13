Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24177AAEB
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzX-0007l1-5x; Sun, 13 Aug 2023 15:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzV-0007kQ-8U
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzT-0002MY-CN
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb727cso37658205e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955785; x=1692560585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rihZrS1lXwvEqAtW/9cqI/d+KmpRY2H0KWTcRttsIkw=;
 b=edDY1tzRF+ZXqbuaWC3iPJoQ9/PanrXnol5IaD3n1aKokEyzkfUuMpBplBi+PR+laW
 Kssf0fFpkMaobcnv01Cs7T+XFnhvf/l5DBCvmAVBEvXaTgT++YrEwkw/9QM5p2j4hNvH
 UXXpKI01InOP46aPdXU5Way23++P7xj4O3bmqgHhkuZ6GE56Zb++QvCpyXheD6XdDagH
 y3AHw3Vnd7T3+ymZeljh8sx72GGsgkSu4ajDq+jBzx0/EpdMOUhuIMcgQiVgwjVq7BKj
 0xgmk64fMxHr64FUHlOVu9/YMUC30aDy0cTxFt3qmA4IYRwikoWbRQeCt8RAMMOvNw+C
 RQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955785; x=1692560585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rihZrS1lXwvEqAtW/9cqI/d+KmpRY2H0KWTcRttsIkw=;
 b=Rq5pNGPmg0rTGlNQEjfs6lz8QGn3Z+XN8vJyd4qXBpklH5pYFUnhsyu08Qfjz17EwQ
 kLULnhRrkL24cEEGp8RKiObi5ygcygOEnh+B0XMs6MZ6ABLw7oHG6xQuEMDqZMsXD7Qc
 0gLn//gIz0RsupWtS0L1LfImAzEMt8Ic+O4tCAPSbWRoogx8/nTJkonQbDF7BzqyuECw
 AcxV+QmAAAj9+nOPqqQJe3VTgfkNaNBc84nOjOWVaa8n25Pm+HYmelmbjzlhMskCpZtT
 OlE/t04PdLEhcoCMiWjH9CIyER+XpgcehRrSWvgX8drNp5BmrzqGLH2NfExSjTijk61b
 6PAg==
X-Gm-Message-State: AOJu0YwG0dkSMHO/ni7l9H93ML4AQfh24joYGN1fjHxkDNFeN/r/z6xV
 T9CjhvQSi+MwezHkAr6B12XPCkDI9PE=
X-Google-Smtp-Source: AGHT+IE1OewVvgflXoca6bRMzSnIsbZedwi+veqjKxk0eDv+iuMvCLMLqs85Ln4dHFC+DdIxzu8xpw==
X-Received: by 2002:a05:600c:230f:b0:3fa:964e:e85 with SMTP id
 15-20020a05600c230f00b003fa964e0e85mr6252865wmo.5.1691955785072; 
 Sun, 13 Aug 2023 12:43:05 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:04 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Michal Meloun <mmel@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 04/32] Declarations of h2t and t2h conversion functions.
Date: Sun, 13 Aug 2023 10:41:25 +0200
Message-Id: <20230813084153.6510-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Declarations of functions that convert between host and target structs.

Co-authored-by: Michal Meloun <mmel@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/qemu-os.h | 50 ++++++++++++++++++++++++++++++++++++++
 bsd-user/qemu.h            |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 bsd-user/freebsd/qemu-os.h

diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
new file mode 100644
index 0000000000..12adc50928
--- /dev/null
+++ b/bsd-user/freebsd/qemu-os.h
@@ -0,0 +1,50 @@
+/*
+ *  FreeBSD conversion extern declarations
+ *
+ *  Copyright (c) 2013 Stacey D. Son
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
+#ifndef QEMU_OS_H
+#define QEMU_OS_H
+
+/* qemu/osdep.h pulls in the rest */
+
+#include <sys/acl.h>
+#include <sys/mount.h>
+#include <sys/timex.h>
+#include <sys/rtprio.h>
+#include <sys/select.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+struct freebsd11_stat;
+
+/* os-stat.c */
+abi_long h2t_freebsd11_stat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st);
+abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st);
+abi_long t2h_freebsd_fhandle(fhandle_t *host_fh, abi_ulong target_addr);
+abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh);
+abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
+    struct freebsd11_statfs *host_statfs);
+abi_long target_to_host_fcntl_cmd(int cmd);
+abi_long h2t_freebsd_stat(abi_ulong target_addr,
+        struct stat *host_st);
+abi_long h2t_freebsd_statfs(abi_ulong target_addr,
+    struct statfs *host_statfs);
+
+#endif /* QEMU_OS_H */
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 656f38db56..2725fdd7ac 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -38,6 +38,7 @@ extern char **environ;
 #include "exec/gdbstub.h"
 #include "qemu/clang-tsa.h"
 
+#include "qemu-os.h"
 /*
  * This struct is used to hold certain information about the image.  Basically,
  * it replicates in user space what would be certain task_struct fields in the
-- 
2.40.0


