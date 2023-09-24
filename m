Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C47ACE40
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSq-0003Jr-UH; Sun, 24 Sep 2023 22:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSn-0003IJ-CU
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSl-00005m-BO
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-405524e6740so32083445e9.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609401; x=1696214201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0Dqs0KOjTr5dCbbJ1YQtsQ7bJYAtc0s59yQIYeZ8Mk=;
 b=jBndt5K2MqQQg6WyD83V6NpLvNe3cbBPXxU4xcezzOLmCsD39dEQDegjmL1BaqePo3
 rt4/Fs9DlryD+11mtiNfn2nzLt6dADGzTbuFkYJg2oVNzukFi+b6mwPqe/LfqFaLSKh+
 01AeRBOrlscqct7jsv6/+2k0YQmjA8KSWJr+BHIIt9pmiu6TrCcOsN85tRVmS9Plekaz
 UyrLx4RXbVKuzy/1+0KMGDfkhKEPTco/PEkCnMG2a4dAJH1/dpWEJfjdZr++YZYcD4wz
 RjplR8erTHJx11H1iK1/HUoLfakSE38AjVnu7wPkWqd2OOgCu/t1bstoDFwywfpVrqCu
 aQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609401; x=1696214201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0Dqs0KOjTr5dCbbJ1YQtsQ7bJYAtc0s59yQIYeZ8Mk=;
 b=PYjLtznKIUTyOK2WJAI19+ZsmIFcZHkx/5+Qfp68dXrJdZJVTn+nNGah+HmfXRY0wJ
 qj4i0zy80T72wSMjfT40YrmrOnoaZElAGkYCKzEVHzbfJ4mZ1teb+K6knKvyQNI0GKT6
 QO+2AK9LFVXdke/0Kkv7mYhZ4FwRb234TU4YeN6oAIMRlVmJr6shnEq0wlM4eVHOb94E
 MUcI0pTyI4QJWaSbNZ4s3JJJDOJy9ea62V/QSNx+ps6P89WW8wBr8kHx342jeSjyRmFH
 cBmjBkZXn3j0nCln2vTunIyJwxAOUO3EmdWIzrYR7GGQc2ITvuE/k9o0xPFGkpqmzxPu
 ileA==
X-Gm-Message-State: AOJu0YyEgEhzLZ2kTI28ZGkbWKTqk6flkExuFbOMKXWI6FjpGMcU5YB0
 SAcDSvQhMugdtBRzJEIEh6LA5LFXPcI=
X-Google-Smtp-Source: AGHT+IHx+oyPZI1yaWpPNYYUmyyR5iXoE6WV4gG6D4eG+E0vvzOxsHpNlrywaU5zx15eco1KRg6DRg==
X-Received: by 2002:adf:ec4b:0:b0:313:f4e2:901d with SMTP id
 w11-20020adfec4b000000b00313f4e2901dmr5946333wrn.22.1695609401652; 
 Sun, 24 Sep 2023 19:36:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:41 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 10/28] bsd-user: Get number of cpus.
Date: Mon, 25 Sep 2023 00:01:18 +0300
Message-ID: <20230924210136.11966-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.c | 24 ++++++++++++++++++++++++
 bsd-user/bsd-proc.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 19f6efe1f7..ca3c1bf94f 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -119,3 +119,27 @@ int host_to_target_waitstatus(int status)
     return status;
 }
 
+int bsd_get_ncpu(void)
+{
+    int ncpu = -1;
+    cpuset_t mask;
+
+    CPU_ZERO(&mask);
+
+    if (cpuset_getaffinity(CPU_LEVEL_WHICH, CPU_WHICH_TID, -1, sizeof(mask),
+                           &mask) == 0) {
+        ncpu = CPU_COUNT(&mask);
+    }
+
+    if (ncpu == -1) {
+        ncpu = sysconf(_SC_NPROCESSORS_ONLN);
+    }
+
+    if (ncpu == -1) {
+        gemu_log("XXX Missing bsd_get_ncpu() implementation\n");
+        ncpu = 1;
+    }
+
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
2.42.0


