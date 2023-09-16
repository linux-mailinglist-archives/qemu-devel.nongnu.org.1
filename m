Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4BA7A32C5
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3s-00071e-Aa; Sat, 16 Sep 2023 17:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd38-0005EH-Vx
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd37-0000Vn-Bw
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:58 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fb98745c1so2628342b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900516; x=1695505316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6gfR2aUZDEN0GM3qWd4UDvByhc2dFh0dzXal65oWsM=;
 b=gW6YjUHpNd+282hZ+6ZJ3vKpH9mw79O2G1ytk+zRHBQWZDTYV3/2zzLDpF/yoy6ozo
 rlixmSPeNnIlwKF5MxkI2drgmFBuUbnAHvvUy1MwVyJS6rk74OzSLYyvW08OnoW1AJoO
 W9z1YfhVUN3enLkV8EMT3v8/atb1VGp8xhXQM/RLf6IIHipxF9vX3CgmqxzhaKTwrdsY
 4PHdG+ZcSZSvVP8IlhhubdfM9NrNvLtl3Ldddh5R5jaehk3S92mLeTtJYzCHcRoY2NEX
 t4MdTKH0AEr94ZC/xmNEyza6ZU7FFL/GATxfEkDthxiZNoIzN/efDV7nGKtd4jULFjIP
 N0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900516; x=1695505316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6gfR2aUZDEN0GM3qWd4UDvByhc2dFh0dzXal65oWsM=;
 b=IwIUXRUozp4zK7KkOiNVwqeee+Bnw5C+AfKoNtBxg7Fwkt5YegoOa5iw4O8a75nra/
 GKUnI0BP6YSuA74P/vG+9v37ccKtrHktHrECbe0i7u1GaA9/5jTvlVbYoetCPbVThu22
 PBMJhQfDam401YvKQj7S9jXVtqF6JdkCfQN1kyar0wk+i5piZ6/3zjOHPvnvengYxHCj
 UYahVIKJD86kd2gHBNRxxwJQ5Moo6bBFXM+SmgRn2WSM/j6qQ9s+KalkXYMXiFNFVw6A
 cBbTtBWU7xPcVkOpsAHkBF4LvPn1lTAi0AYSrAPjpmXGrRaWKV5ps9dhn7hJIBWDbYam
 tyHg==
X-Gm-Message-State: AOJu0YykTnLjIq3Q2qdqlWO0wf9U62Cm0gPTX63lSbWW5Vtdea0v2PQZ
 +TaoNu4HeJouyV937DtGyO7CM5SDX0N5ZF70rIY=
X-Google-Smtp-Source: AGHT+IFvtbbemW1iDJQU0YCk+iHWY84hHSeAZBFDIc/E9Keh6PrwWQUOZqCLxLUuo3b8lewRdXrREA==
X-Received: by 2002:a05:6a00:24ca:b0:68e:2f6e:b4c0 with SMTP id
 d10-20020a056a0024ca00b0068e2f6eb4c0mr6242884pfv.28.1694900515679; 
 Sat, 16 Sep 2023 14:41:55 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 32/39] accel/tcg: Make monitor.c a target-agnostic unit
Date: Sat, 16 Sep 2023 14:41:16 -0700
Message-Id: <20230916214123.525796-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Move target-agnostic declarations from "internal-target.h"
to a new "internal-common.h" header.
monitor.c now don't include target specific headers and can
be compiled once in system_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-10-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 17 +++++++++++++++++
 accel/tcg/internal-target.h |  5 -----
 accel/tcg/cpu-exec.c        |  1 +
 accel/tcg/monitor.c         |  2 +-
 accel/tcg/translate-all.c   |  1 +
 accel/tcg/meson.build       |  3 +++
 6 files changed, 23 insertions(+), 6 deletions(-)
 create mode 100644 accel/tcg/internal-common.h

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
new file mode 100644
index 0000000000..5d5247442e
--- /dev/null
+++ b/accel/tcg/internal-common.h
@@ -0,0 +1,17 @@
+/*
+ * Internal execution defines for qemu (target agnostic)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_INTERNAL_COMMON_H
+#define ACCEL_TCG_INTERNAL_COMMON_H
+
+extern int64_t max_delay;
+extern int64_t max_advance;
+
+void dump_exec_info(GString *buf);
+
+#endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 4ce3b29056..f9eec1ce28 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -99,11 +99,6 @@ static inline bool cpu_in_serial_context(CPUState *cs)
     return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
-extern int64_t max_delay;
-extern int64_t max_advance;
-
-void dump_exec_info(GString *buf);
-
 extern bool one_insn_per_tb;
 
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f5625e047a..95dd8a30cb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -42,6 +42,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 /* -icount align implementation. */
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 30724fdb98..caf1189e0b 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -16,7 +16,7 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
-#include "internal-target.h"
+#include "internal-common.h"
 
 
 static void dump_drift_info(GString *buf)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6c09b7f50d..8cb6ad3511 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -61,6 +61,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 #include "perf.h"
 #include "tcg/insn-start-words.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 8ace783707..0fb03bd7d3 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,6 +20,9 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
+))
+
+system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'monitor.c',
 ))
 
-- 
2.34.1


