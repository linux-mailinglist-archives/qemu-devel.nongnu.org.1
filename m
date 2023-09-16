Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F407A32B8
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3k-0005vk-AC; Sat, 16 Sep 2023 17:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3C-0005Eu-7l
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd39-0000WK-MQ
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso3072296b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900517; x=1695505317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VTpBWRs4wNK7fliIDMYgMpLG0bEcOQT795ogcrcYr0=;
 b=yRy/7G7Pm0V2+MwkQKB9d9p+Zc5ozkrW57msve/Uyn5o3I4jnOqmDbAa1D8iyi8lJM
 EUkvbxnVzH/mtUR4iJwhBqZUwwsaicwGiYfquQCI2PC/ecKby/e1CLA5UPUaWkgyd9Iy
 0vI2QJIMHbYit7GksR3ZHxrkLzQNeDT53HepI6CPI0UUPy07QCbuMz2VtkOxww0nYkFw
 9Kmj4DQC1hQaJgzG65eAojR9PM+LGTZtPn68Yiw9Tb4M1l9671zoKZUm8uA5uGtVqTMx
 4tBp+I7yQ6Hrz2r7zFnHm5VpNMTU6sXYtNqibdGZQGQVIUslaPnnnaL+qAHvgTmtQ2Bs
 /f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900517; x=1695505317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6VTpBWRs4wNK7fliIDMYgMpLG0bEcOQT795ogcrcYr0=;
 b=pIFvwaND3/dSt2CAJXrU6nv0NnEpPwCsGe6SJg8z2ICLqlgIDaWp34EDBWSVpm0fhi
 L1Rrf+pr1UDFatM0AhJzO1aMk6g3BjFVGgeTZUGCdcCgRkh9Ygq6JL6bg78Qx8SyXOX3
 5aHThh4tRDiRUPX6rZ0knplTI8QndEHbgOHX958aVYPa3W52ADwpQi/9ndNQoKKNS2v7
 DFNK9rlvuUfM7OmMIlnp11XAhxWXUS56UdxybeHYtBNJEN/PYbhDSyrmnZJRKjdJIcoT
 ahhnEvmjTuRnFpzn7WHsiIuZ0NnZj96vX90+zoTVB333TisZgQxym5wBjs5fKnrrqohB
 RW4Q==
X-Gm-Message-State: AOJu0Yy6k5lUCbdxlAw80pUhiuKzPOmSGCHNbwor1mx3jqdCwlsP+AJo
 Z07sUEa8460f9620pXn9fOyMG6o3z2Sc+4f984o=
X-Google-Smtp-Source: AGHT+IEBaRerfQfLVI3HNp2zSufW/MjL0q8V3zM5SEUjxSJrYAOWlyj0POm/BQjRntRIZb4LnxHs8Q==
X-Received: by 2002:a05:6a00:c96:b0:68f:d864:596 with SMTP id
 a22-20020a056a000c9600b0068fd8640596mr6961545pfv.3.1694900517281; 
 Sat, 16 Sep 2023 14:41:57 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 34/39] accel/tcg: Make cpu-exec-common.c a target agnostic
 unit
Date: Sat, 16 Sep 2023 14:41:18 -0700
Message-Id: <20230916214123.525796-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu_in_serial_context() is not target specific,
move it declaration to "internal-common.h" (which
we include in the 4 source files modified).

Remove the unused "exec/exec-all.h" header from
cpu-exec-common.c.  There is no more target specific
code in this file: make it target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-12-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 11 +++++++++++
 accel/tcg/internal-target.h |  9 ---------
 accel/tcg/cpu-exec-common.c |  3 +--
 accel/tcg/cputlb.c          |  1 +
 accel/tcg/tb-maint.c        |  1 +
 accel/tcg/user-exec.c       |  1 +
 accel/tcg/meson.build       |  4 +++-
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 5d5247442e..3b2277e6e9 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -9,9 +9,20 @@
 #ifndef ACCEL_TCG_INTERNAL_COMMON_H
 #define ACCEL_TCG_INTERNAL_COMMON_H
 
+#include "exec/translation-block.h"
+
 extern int64_t max_delay;
 extern int64_t max_advance;
 
 void dump_exec_info(GString *buf);
 
+/*
+ * Return true if CS is not running in parallel with other cpus, either
+ * because there are no other cpus or we are within an exclusive context.
+ */
+static inline bool cpu_in_serial_context(CPUState *cs)
+{
+    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
+}
+
 #endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index f9eec1ce28..932bbe4b63 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -90,15 +90,6 @@ static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
     }
 }
 
-/*
- * Return true if CS is not running in parallel with other cpus, either
- * because there are no other cpus or we are within an exclusive context.
- */
-static inline bool cpu_in_serial_context(CPUState *cs)
-{
-    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
-}
-
 extern bool one_insn_per_tb;
 
 /**
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 55980417b4..b6cc387482 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -20,9 +20,8 @@
 #include "qemu/osdep.h"
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
-#include "exec/exec-all.h"
 #include "qemu/plugin.h"
-#include "internal-target.h"
+#include "internal-common.h"
 
 bool tcg_allowed;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index df20bf4034..b8c5e345b8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -35,6 +35,7 @@
 #include "exec/translate-all.h"
 #include "trace.h"
 #include "tb-hash.h"
+#include "internal-common.h"
 #include "internal-target.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 85cf51445d..b194f8f065 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -29,6 +29,7 @@
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f925dd0305..5bf2761bf4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -29,6 +29,7 @@
 #include "qemu/atomic128.h"
 #include "trace/trace-root.h"
 #include "tcg/tcg-ldst.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 __thread uintptr_t helper_retaddr;
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 4633a34d28..8783edd06e 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,7 +1,9 @@
 tcg_ss = ss.source_set()
+common_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'cpu-exec-common.c',
+))
 tcg_ss.add(files(
   'tcg-all.c',
-  'cpu-exec-common.c',
   'cpu-exec.c',
   'tb-maint.c',
   'tcg-runtime-gvec.c',
-- 
2.34.1


