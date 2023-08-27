Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0AA78B92B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZJ-0000Z3-Ag; Mon, 28 Aug 2023 16:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZ1-0008KT-Md
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:20 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYy-0007ai-R8
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:18 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bb9a063f26so55474641fa.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253414; x=1693858214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1kvUaujUbfIE3YRxf4HkJ0zNC+AtY4GwgRBRBxQqoc=;
 b=EtmSxWzliP7HheTOeDyQkkMzdn/FbLvn732adSLDYnhZtiOSOWrnlZj/AuDlkoewoK
 0BIcDKdKbW5qcqS18htDNh+x30+FDcBLLtJQXt/QO4osy+da9rzKiwLvyRETTWO3CSyw
 LHkedeUm8OQJiAqqSej3AhCd/bM17z9j+KetxfR5NQH+lexYlkeEY3rVd3iKcVSiDhBK
 NU9ORGydzSAzls1Cq5DYNguF9QlfD5FWIRnnUZ1+TLjjgoiroaA79nz+GmB77xsHZ3D4
 kadXbzejyVVItsDlMiDdxDhNIuH2u71VQE59ePDeeblB2j8vfforXHL2B96F0nldj4MJ
 mFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253414; x=1693858214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1kvUaujUbfIE3YRxf4HkJ0zNC+AtY4GwgRBRBxQqoc=;
 b=hYDEY6RxA3Vu3SbcfVWnFVMZylhWWGIjmuWqg858JLi4IwIH5euDdfZ4lT5b/2eWIH
 o5ulCqY8vyUZ5h2Asq3NC87bLhezsm47kal6gJVbDhU+W//oGPx7s5JyNQx6iuvPYAbp
 R85feoxZHDUivDKHHGs8gc0XNpubvoppERErqiird1aHjo3w77QkDHH8r18pu1rKxSyj
 K9U7VXjhvh3BUYYWuWE0cXB3mjuOe9VjsqE1y3s/RwQVSecwe8aTk/RS7h+M5UzKYiW7
 ebvoi7qodGLQc2vNplTbquPOjpddgF59q0HQBoUUD4SvzZxIVY4TsH+o3VeH9D5XZUGI
 CJZw==
X-Gm-Message-State: AOJu0YwxiDmz/Pwtrx424g6nwn4jQgwEYKcQir0udziaVjW4o3xbEDOM
 shpV5GBwUx3cxeVcuasBvHmE0uuh6JtAag==
X-Google-Smtp-Source: AGHT+IG6rqgeLpGqsUwW6kdrdReScPduqqNd0Zkxt9zZEgvysPminC1q2wO3eIo6fG+qFzIDgjXbww==
X-Received: by 2002:a05:651c:104:b0:2bc:c326:54a2 with SMTP id
 a4-20020a05651c010400b002bcc32654a2mr15434383ljb.50.1693253414017; 
 Mon, 28 Aug 2023 13:10:14 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:13 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 11/32] bsd-user: Get number of cpus.
Date: Sun, 27 Aug 2023 17:57:25 +0200
Message-Id: <20230827155746.84781-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x229.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.c | 39 +++++++++++++++++++++++++++++++++++++++
 bsd-user/bsd-proc.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 49c0fb67d0..dd6bad6de3 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -185,3 +185,42 @@ int host_to_target_waitstatus(int status)
     return status;
 }
 
+int bsd_get_ncpu(void)
+{
+    static int ncpu = -1;
+
+    if (ncpu != -1) {
+        return ncpu;
+    }
+    if (ncpu == -1) {
+        cpuset_t mask;
+
+        CPU_ZERO(&mask);
+
+        if (cpuset_getaffinity(CPU_LEVEL_WHICH, CPU_WHICH_TID, -1, sizeof(mask),
+                               &mask) == 0) {
+            ncpu = CPU_COUNT(&mask);
+        }
+    }
+#ifdef _SC_NPROCESSORS_ONLN
+    if (ncpu == -1)
+        ncpu = sysconf(_SC_NPROCESSORS_ONLN);
+#endif
+#if defined(CTL_HW) && defined(HW_NCPU)
+    if (ncpu == -1) {
+        int mib[2] = {CTL_HW, HW_NCPU};
+        size_t sz;
+
+        sz = sizeof(ncpu);
+        if (sysctl(mib, 2, &ncpu, &sz, NULL, NULL) == -1) {
+            ncpu = -1;
+        }
+    }
+#endif
+    if (ncpu == -1) {
+        gemu_log("XXX Missing bsd_get_ncpu() implementation\n");
+        ncpu = 1;
+    }
+    return ncpu;
+}
+
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 048773a75d..b6225e520e 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -26,6 +26,8 @@
 #include "gdbstub/syscalls.h"
 #include "qemu/plugin.h"
 
+int bsd_get_ncpu(void);
+
 /* exit(2) */
 static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
 {
-- 
2.40.0


