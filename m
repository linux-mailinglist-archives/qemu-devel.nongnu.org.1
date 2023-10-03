Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E757B70E1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAw-000879-UD; Tue, 03 Oct 2023 14:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAu-00086g-Ng
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAs-0001hD-TJ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c60cec8041so9028365ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357873; x=1696962673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POqUGdOlnRWwwN/7EyrWIkFLDkOwEr6+ScS6TPAGSfI=;
 b=T0TIP8A7ufHt9wc3Uc0qx/A9hX1HbfKth08yfvzvRz9N+08yrthZN5BoBTH/u+/OfA
 rI7wwlVyWb6RZmYPDAr9J3m3C+wpgV28hLnBl1ym5PRLxPSpGNfpPuu8ePg2D+uj4O6a
 Z6OqPAndFkYbDdEl8qM8meNe1dgxmElJPkpeGmhhe+OzKz/tWC66az7KkJlOgsGv3eww
 hj9/aoU3V8npGku1GYUn1RerEQVDVw1eRHQRNYEuDKUSkLQVi1Q+s+lh/z69+02nNMif
 3vDD/oFrQwgxTrRX5N6OiJpJCOs7OrlL5Od9peoTCOeN2vfynq0I4wOs6cWg5MyKqXia
 pQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357873; x=1696962673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POqUGdOlnRWwwN/7EyrWIkFLDkOwEr6+ScS6TPAGSfI=;
 b=Ii8fVdJayTakgEmKmpHcxsfp+dRMH+CtJV+z6ol1S5b46zA7nHC2hT90ajGVs8SIdY
 d+YRm12wWo0lk4SP/aTP8q4JF/Gsgokmn7tEEQAPzKQUZ2BcTwExqtm0o0JhsHmuqfkU
 azpPX0TVBpAEWGB97J+KObstbWPgORwq0DqcSNTUvJQcwl6EKOOljGoZRmEB8WO8TWRf
 NYR0RJBCP/ZwoPSbRostke/TSS64gojRdUkjbHwq3lrWeBA1PBh1ShWlIl3F6OSconh3
 LQhlogxX+MZ42xj9N2pXX/S1d0bx3r96E0fOCr92i4rgo5/fJabmIr2ZCl3V7QrkERrn
 nFFg==
X-Gm-Message-State: AOJu0YyTC1eb2IW5GJj64k2KQto+qj0/CoVS/IIlY5p7fPD+6BmCUqIQ
 1zLFp/CMf5fJ+aVNLk9mHJUJQkM2lXEMcDoWmIY=
X-Google-Smtp-Source: AGHT+IH21jREf0LyA4ybqPIVOuvm35+wv7i59aehcSWjFMOQGVY+jZO5scW8ufRp+rPHEXGD4Ou27Q==
X-Received: by 2002:a17:902:ab82:b0:1c1:e7b2:27ad with SMTP id
 f2-20020a170902ab8200b001c1e7b227admr316096plr.60.1696357873399; 
 Tue, 03 Oct 2023 11:31:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 14/16] monitor: Change MonitorDec.get_value return type to
 int64_t
Date: Tue,  3 Oct 2023 11:30:56 -0700
Message-Id: <20231003183058.1639121-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

This matches the type of the pval parameter to get_monitor_def.
This means that "monitor/hmp-target.h" itself is now target
independent, even if monitor/hmp-target.c isn't.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/monitor/hmp-target.h |  5 +----
 monitor/hmp-target.c         |  2 ++
 target/i386/monitor.c        |  4 ++--
 target/ppc/ppc-qmp-cmds.c    | 20 ++++++++++----------
 target/sparc/monitor.c       |  8 ++++----
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index d78e979f05..730507bd65 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -25,16 +25,13 @@
 #ifndef MONITOR_HMP_TARGET_H
 #define MONITOR_HMP_TARGET_H
 
-#include "cpu.h"
-
 #define MD_TLONG 0
 #define MD_I32   1
 
 struct MonitorDef {
     const char *name;
     int offset;
-    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
-                             int val);
+    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
     int type;
 };
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 1eb72ac1bf..ed7149b5ff 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -35,6 +35,8 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "cpu-param.h"
+#include "exec/target_long.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 6512846327..6759ec7ca0 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -600,8 +600,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     }
 }
 
-static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                                  int val)
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return env->eip + env->segs[R_CS].base;
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index f9acc21056..ea2c152228 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -32,8 +32,8 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
-static target_long monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static int64_t monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
+                               int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     unsigned int u;
@@ -43,15 +43,15 @@ static target_long monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
     return u;
 }
 
-static target_long monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static int64_t monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
+                               int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return cpu_read_xer(env);
 }
 
-static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
-                                    int val)
+static int64_t monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
+                                int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     if (!env->tb_env) {
@@ -60,8 +60,8 @@ static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
     return cpu_ppc_load_decr(env);
 }
 
-static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static int64_t monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
+                               int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     if (!env->tb_env) {
@@ -70,8 +70,8 @@ static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
     return cpu_ppc_load_tbu(env);
 }
 
-static target_long monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static int64_t monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
+                               int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     if (!env->tb_env) {
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 73f15aa272..24cc3dbf68 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -40,8 +40,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 #ifndef TARGET_SPARC64
-static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static int64_t monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
+                               int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
 
@@ -49,8 +49,8 @@ static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
 }
 #endif
 
-static target_long monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static int64_t monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
+                               int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return env->regwptr[val];
-- 
2.34.1


