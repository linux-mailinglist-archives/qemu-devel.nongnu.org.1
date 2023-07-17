Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD69C756097
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLLa3-00051E-Mf; Mon, 17 Jul 2023 06:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLLa1-00050z-Dx
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:35:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLLZz-0001eM-Lf
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:35:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso38490255e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 03:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689590146; x=1692182146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M1MqawxeSQ21l3F80aXIWQDFB6limixWvLVjx1m/xHs=;
 b=gTeye8Nt6CoLj3MjDt46uadxEytqs8L8qefsmMHQ5zLWyL0ejN4/wEJ8Vad0NErTcf
 9EtEVXRsIVBHlUjV06vl4sGEumPMdMR92BqZlAXVVGXpoVQ5ka7R/DRqWNQj0Y11qCmx
 pl1yuUlGskgcdSNUw0oIbmJGdWrLW7OCOnw8MuxXHSxCttUb55aTOP7vXEryymYjSVfe
 A/axj7W7oQb0Ng5ca2gLdTqa3KgNRpNVbfN7iBsUiRU5mfqSB5jUlBp3CCqsPzVQoQlg
 uI7xIYMiFxWzduEF0jAoIwOrrI2AOWEgtE57MXHN6yNXcDjW9uqgXsigyfyBYv+XUcqm
 0N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689590146; x=1692182146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1MqawxeSQ21l3F80aXIWQDFB6limixWvLVjx1m/xHs=;
 b=LUvZWkCOCGBI7gBfe3wP96JItUL0t5DOvwMPKiQMYtpLJw8ggwT+FidXZ6aHZtr8Re
 6c6KfTqXftaY+L4pjteyIablguZRMPkiAZk6eiixKGyv8AMd5Bc+FW5R8p2ekQqNnsEX
 5fAQdlAeVw0GbHjRCOpEwxcxhauP53UMH/uBSuovONUbTjHeXOrELjxxTNJasKRWtiiy
 6P3f8zpeS7XRfaW1lZGhZc0wxv+AbBghOGQqrOLUekUaboZak20ejs3Trf4siBfckcOM
 iSeszpnHnGTDK5gz3cB1Jotaw86aHm41lAetjIbsTw93FlBL3zjXC2Gj3Rs8YVK3MfzZ
 0Ehg==
X-Gm-Message-State: ABy/qLay5Dhio5HIa6OfbsHo3uGRvoZnOHV5Xats9Z/VGjq4MHFeqpBI
 segWBuJhsetM4M9r+sXyh/RoTNIMjRYv1IMQVD0=
X-Google-Smtp-Source: APBJJlGqdC/y92H50Dr8S2hxzvIEZLBLQW8mj9TUCySc7GKKnRgJf5/nv5oD+hZj2iTuBqDJDXDz3Q==
X-Received: by 2002:a7b:cb10:0:b0:3fc:21:2c43 with SMTP id
 u16-20020a7bcb10000000b003fc00212c43mr8921942wmj.13.1689590146101; 
 Mon, 17 Jul 2023 03:35:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f25-20020a1c6a19000000b003fc015ae1e1sm7767435wmc.3.2023.07.17.03.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 03:35:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/sparc: Handle FPRS correctly on big-endian hosts
Date: Mon, 17 Jul 2023 11:35:44 +0100
Message-Id: <20230717103544.637453-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In CPUSparcState we define the fprs field as uint64_t.  However we
then refer to it in translate.c via a TCGv_i32 which we set up with
tcg_global_mem_new_ptr().  This means that on a big-endian host when
the guest does something to writo te the FPRS register this value
ends up in the wrong half of the uint64_t, and the QEMU C code that
refers to env->fprs sees the wrong value.  The effect of this is that
guest code that enables the FPU crashes with spurious FPU Disabled
exceptions.  In particular, this is why
 tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
times out on an s390 host.

There are multiple ways we could fix this; since there are actually
only three bits in the FPRS register and the code in translate.c
would be a bit painful to convert to dealing with a TCGv_i64, change
the type of the CPU state struct field to match what translate.c is
expecting.

(None of the other fields referenced by the r32[] array in
sparc_tcg_init() have the wrong type.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2:
 * drop unnecessary change to gdbstub.c
 * put the vmstate fields the correct way around

NB: I believe the vmstate changes to be correct, but sparc64
seems unable to successfully do a savevm/loadvm even before
this change due to some other bug (the guest kernel panics
immediately after the loadvm).
---
 target/sparc/cpu.h     | 2 +-
 target/sparc/cpu.c     | 4 ++--
 target/sparc/machine.c | 3 ++-
 target/sparc/monitor.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 95d2d0da71d..98044572f26 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -521,7 +521,7 @@ struct CPUArchState {
     uint64_t igregs[8]; /* interrupt general registers */
     uint64_t mgregs[8]; /* mmu general registers */
     uint64_t glregs[8 * MAXTL_MAX];
-    uint64_t fprs;
+    uint32_t fprs;
     uint64_t tick_cmpr, stick_cmpr;
     CPUTimer *tick, *stick;
 #define TICK_NPT_MASK        0x8000000000000000ULL
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e329a7aece5..130ab8f5781 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -673,8 +673,8 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  "cleanwin: %d cwp: %d\n",
                  env->cansave, env->canrestore, env->otherwin, env->wstate,
                  env->cleanwin, env->nwindows - 1 - env->cwp);
-    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
-                 TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
+    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: %016x\n",
+                 env->fsr, env->y, env->fprs);
 
 #else
     qemu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 44b9e7d75d6..274e1217dfb 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -168,7 +168,8 @@ const VMStateDescription vmstate_sparc_cpu = {
         VMSTATE_UINT64_ARRAY(env.bgregs, SPARCCPU, 8),
         VMSTATE_UINT64_ARRAY(env.igregs, SPARCCPU, 8),
         VMSTATE_UINT64_ARRAY(env.mgregs, SPARCCPU, 8),
-        VMSTATE_UINT64(env.fprs, SPARCCPU),
+        VMSTATE_UNUSED(4), /* was unused high half of uint64_t fprs */
+        VMSTATE_UINT32(env.fprs, SPARCCPU),
         VMSTATE_UINT64(env.tick_cmpr, SPARCCPU),
         VMSTATE_UINT64(env.stick_cmpr, SPARCCPU),
         VMSTATE_CPU_TIMER(env.tick, SPARCCPU),
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 318413686aa..73f15aa272d 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -154,7 +154,7 @@ const MonitorDef monitor_defs[] = {
     { "otherwin", offsetof(CPUSPARCState, otherwin) },
     { "wstate", offsetof(CPUSPARCState, wstate) },
     { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-    { "fprs", offsetof(CPUSPARCState, fprs) },
+    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_I32 },
 #endif
     { NULL },
 };
-- 
2.34.1


