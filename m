Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28578B91D
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYl-000873-2p; Mon, 28 Aug 2023 16:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYi-00086X-Pv
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:00 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYg-0007NA-AF
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:00 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcb50e194dso55285851fa.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253396; x=1693858196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf4E6n27eQkUsjdF4nO89SKJQY0WwuuH7rr5VrB/ebI=;
 b=o1fZi32+prVPdO7T/litxi+4cxvwN7Py90zu9XcmWctwKneTTOPqHwb1Q6vkabnejY
 RVW5IUiq8L5B/07AZAauOw15eV9sal5T4S7GtjKSSziMQgd1L8L5hR8V0PpzH0Ldji+O
 2toEGn2UFOkgXrylTWMyqsMp34vHSsfYtSsDYWCCnCQNyeMhdGh/6A+WithL5PA/ZXHp
 UoVeZOmBF3TJJ8WTX9sKrVliyQkx8K6CvoeL+f5Oj19bpon8ZF/KGyLFXXe2n+kTt8wz
 HT9sQ0127l39/MBzh/kWKg1aZWibdqjjSyAPbYF0uJedE0FD1PL3ElL+DzVqQ1E2h4SF
 qVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253396; x=1693858196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf4E6n27eQkUsjdF4nO89SKJQY0WwuuH7rr5VrB/ebI=;
 b=FoN17gFQ3BrMT8weKGcP0ygSvKQe4FKPDLMcJe6M6iUPvajeaxDNj+t/Lxw65jgfiG
 o9r2Z/uazeKF1bkKgsCq2AMVykN41v1oRecTYDtHR8SaaWkPMxZ52SmrNVKUxcXDTuv8
 a/mwFv/B/u6KXAJdXwQQdOdPRiYOQwNsOwLy28pphnDZAghDSnqG53BXBaOvbPn4POd+
 +xNEB21btfGxWsKNgQfqT05mJGAIXVf6DnNe8kYuGqzlpE0BbMDgc0lpEycb0UlWuLpY
 5b/jSM7fZ/lRjKWi6Uv9CjAs9Xkt0ShVQATllG9GUg3G76KCS18428r59Iq5Lq76BRRO
 Nufw==
X-Gm-Message-State: AOJu0Yzk0wKjyUfU5MSkIVhWOwRwVfUx0C8+AqdjbSceMbDyfLD6/yQx
 X6yiRkLYbBo7NtQNPvOH1BQ+UafvfmuX7w==
X-Google-Smtp-Source: AGHT+IEowMzLfNzbq6UjnJxzJvdaMqouDlsCAbWsOBAebBQWXbbuNzgdoI1pMmF6zVP50sUQWlnH4A==
X-Received: by 2002:a2e:8ecc:0:b0:2b5:bc27:d6eb with SMTP id
 e12-20020a2e8ecc000000b002b5bc27d6ebmr19665528ljl.8.1693253396260; 
 Mon, 28 Aug 2023 13:09:56 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:09:55 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 07/32] bsd-user: Implement target_to_host_resource conversion
 function
Date: Sun, 27 Aug 2023 17:57:21 +0200
Message-Id: <20230827155746.84781-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x231.google.com
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
 bsd-user/bsd-proc.c | 83 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 bsd-user/bsd-proc.c

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
new file mode 100644
index 0000000000..ae2e636bb3
--- /dev/null
+++ b/bsd-user/bsd-proc.c
@@ -0,0 +1,83 @@
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
+
+    switch (code) {
+    case TARGET_RLIMIT_AS:
+        return RLIMIT_AS;
+
+    case TARGET_RLIMIT_CORE:
+        return RLIMIT_CORE;
+
+    case TARGET_RLIMIT_CPU:
+        return RLIMIT_CPU;
+
+    case TARGET_RLIMIT_DATA:
+        return RLIMIT_DATA;
+
+    case TARGET_RLIMIT_FSIZE:
+        return RLIMIT_FSIZE;
+
+    case TARGET_RLIMIT_MEMLOCK:
+        return RLIMIT_MEMLOCK;
+
+    case TARGET_RLIMIT_NOFILE:
+        return RLIMIT_NOFILE;
+
+    case TARGET_RLIMIT_NPROC:
+        return RLIMIT_NPROC;
+
+    case TARGET_RLIMIT_RSS:
+        return RLIMIT_RSS;
+
+    case TARGET_RLIMIT_SBSIZE:
+        return RLIMIT_SBSIZE;
+
+    case TARGET_RLIMIT_STACK:
+        return RLIMIT_STACK;
+
+    case TARGET_RLIMIT_SWAP:
+        return RLIMIT_SWAP;
+
+    case TARGET_RLIMIT_NPTS:
+        return RLIMIT_NPTS;
+
+    default:
+        return code;
+    }
+}
+
-- 
2.40.0


