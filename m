Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 513687E1ADF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztdn-0001z3-CS; Mon, 06 Nov 2023 02:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-0001CC-JX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcr-00020W-Jz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:41 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27d0e3d823fso2971429a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254138; x=1699858938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7LIaV9HF0TQmppwbsEAPwfyhsqnA6z0yJHOJBVMH4k=;
 b=IsGvLFchSYcf+6NTGpd0wNo3aLUy7hAOU0bs7oRMMGS/VZDy5AR2z3dEhiNmf1S12G
 x9U34ANy4J6/iAobwu1/qLnoaszEiTuxh4TxsP6D4XTNel90Gq0trLGKCIQ5LhPQGZPb
 cta4CTt6kKUl4PdnuXb7ptZhlaoQo3iXlysOaWQQNHAeCgdFlNv6ghcmdWzhiE2hVH6e
 Hky2UJEZJsWCeKG+y9qa8M0DRn8MVQ5bL4eQaoUfCFJR2sdsKHFuDMPxPyjOonXDKeXF
 y0nICfLXQ4D2Soe8NZRo8Gg0LAn3dWqrn136QGR+o2KZya8skj3T+IKnS/ML7tGFomLT
 GdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254138; x=1699858938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7LIaV9HF0TQmppwbsEAPwfyhsqnA6z0yJHOJBVMH4k=;
 b=DRTGDbz4erSo0HyQK14vtAs1Ci50FMz3W86+EnlaURyNo9opMyBMV79/LL2a81XS5a
 m9a4/EewNj3fcobuG3ekH77XnFoft1Ah3i87eSZiHpjixpG7Z1crWcBCK6p2NsaLYuk2
 uJIN1yryakfE0yNFkWdhV+KJICN/f5v5BROvoiJBMlbC/T8KFrV1B9o7k04c96ECS7c6
 r/4G/ZYKqf4uOnWWscmImY4wmeAhY89kslqIRKk73u7NHiVSdmjorEtGfkJwozIqtBrf
 yn55OYeTuZyEgSAuFaYiWpZ4+CG9A60R1EAAiOs31tqA0PNAuWQL9WrtUcUVwJ/INURL
 /5ig==
X-Gm-Message-State: AOJu0YwrGB59HUu+jdooxzYZbTZxI3g9XOInOu2K9W5fp3dT8r7a5y6O
 5q3LfNcPw3rE7NbjAt1AcJY4X0egSjb2Kw0yZwE=
X-Google-Smtp-Source: AGHT+IGF4DhyBE2y9kdHDG3uPRfsHvx+wflKveuH983CgYdL5QSkHt8VocXCXf1UvhGq814igie5ew==
X-Received: by 2002:a17:90b:e17:b0:280:a6a6:9b1b with SMTP id
 ge23-20020a17090b0e1700b00280a6a69b1bmr12798369pjb.19.1699254137702; 
 Sun, 05 Nov 2023 23:02:17 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 56/71] hw/timer: Constify VMState
Date: Sun,  5 Nov 2023 22:58:12 -0800
Message-Id: <20231106065827.543129-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/timer/a9gtimer.c            |  8 ++++----
 hw/timer/allwinner-a10-pit.c   |  2 +-
 hw/timer/arm_mptimer.c         |  4 ++--
 hw/timer/arm_timer.c           |  4 ++--
 hw/timer/armv7m_systick.c      |  2 +-
 hw/timer/aspeed_timer.c        |  4 ++--
 hw/timer/bcm2835_systmr.c      |  2 +-
 hw/timer/cadence_ttc.c         |  4 ++--
 hw/timer/cmsdk-apb-dualtimer.c |  4 ++--
 hw/timer/cmsdk-apb-timer.c     |  2 +-
 hw/timer/digic-timer.c         |  2 +-
 hw/timer/etraxfs_timer.c       |  2 +-
 hw/timer/exynos4210_mct.c      | 12 ++++++------
 hw/timer/exynos4210_pwm.c      |  4 ++--
 hw/timer/hpet.c                | 10 +++++-----
 hw/timer/i8254_common.c        |  4 ++--
 hw/timer/ibex_timer.c          |  2 +-
 hw/timer/imx_epit.c            |  2 +-
 hw/timer/imx_gpt.c             |  2 +-
 hw/timer/mss-timer.c           |  4 ++--
 hw/timer/npcm7xx_timer.c       |  8 ++++----
 hw/timer/nrf51_timer.c         |  2 +-
 hw/timer/pxa2xx_timer.c        |  6 +++---
 hw/timer/renesas_cmt.c         |  2 +-
 hw/timer/renesas_tmr.c         |  2 +-
 hw/timer/sifive_pwm.c          |  2 +-
 hw/timer/slavio_timer.c        |  4 ++--
 hw/timer/sse-counter.c         |  2 +-
 hw/timer/sse-timer.c           |  2 +-
 hw/timer/stellaris-gptm.c      |  2 +-
 hw/timer/stm32f2xx_timer.c     |  2 +-
 31 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 5e959b6d09..a2ac5bdfb9 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -328,7 +328,7 @@ static const VMStateDescription vmstate_a9_gtimer_per_cpu = {
     .name = "arm.cortex-a9-global-timer.percpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, A9GTimerPerCPU),
         VMSTATE_UINT64(compare, A9GTimerPerCPU),
         VMSTATE_UINT32(status, A9GTimerPerCPU),
@@ -342,7 +342,7 @@ static const VMStateDescription vmstate_a9_gtimer_control = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_a9_gtimer_control_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, A9GTimerState),
         VMSTATE_END_OF_LIST()
     }
@@ -352,7 +352,7 @@ static const VMStateDescription vmstate_a9_gtimer = {
     .name = "arm.cortex-a9-global-timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, A9GTimerState),
         VMSTATE_UINT64(counter, A9GTimerState),
         VMSTATE_UINT64(ref_counter, A9GTimerState),
@@ -362,7 +362,7 @@ static const VMStateDescription vmstate_a9_gtimer = {
                                      A9GTimerPerCPU),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_a9_gtimer_control,
         NULL
     }
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 971f78462a..a524de1381 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -200,7 +200,7 @@ static const VMStateDescription vmstate_a10_pit = {
     .name = "a10.pit",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(irq_enable, AwA10PITState),
         VMSTATE_UINT32(irq_status, AwA10PITState),
         VMSTATE_UINT32_ARRAY(control, AwA10PITState, AW_A10_PIT_TIMER_NR),
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index cdfca3000b..bca4cee0e4 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -281,7 +281,7 @@ static const VMStateDescription vmstate_timerblock = {
     .name = "arm_mptimer_timerblock",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, TimerBlock),
         VMSTATE_UINT32(status, TimerBlock),
         VMSTATE_PTIMER(timer, TimerBlock),
@@ -293,7 +293,7 @@ static const VMStateDescription vmstate_arm_mptimer = {
     .name = "arm_mptimer",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_UINT32(timerblock, ARMMPTimerState, num_cpu,
                                      3, vmstate_timerblock, TimerBlock),
         VMSTATE_END_OF_LIST()
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 9afe8da831..0940e03f1d 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -163,7 +163,7 @@ static const VMStateDescription vmstate_arm_timer = {
     .name = "arm_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(control, arm_timer_state),
         VMSTATE_UINT32(limit, arm_timer_state),
         VMSTATE_INT32(int_level, arm_timer_state),
@@ -282,7 +282,7 @@ static const VMStateDescription vmstate_sp804 = {
     .name = "sp804",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_ARRAY(level, SP804State, 2),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 5dfe39afe3..f6b1acef27 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -275,7 +275,7 @@ static const VMStateDescription vmstate_systick = {
     .name = "armv7m_systick",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(refclk, SysTickState),
         VMSTATE_CLOCK(cpuclk, SysTickState),
         VMSTATE_UINT32(control, SysTickState),
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 72161f07bb..fc5c94bdf3 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -645,7 +645,7 @@ static const VMStateDescription vmstate_aspeed_timer = {
     .name = "aspeed.timer",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(id, AspeedTimer),
         VMSTATE_INT32(level, AspeedTimer),
         VMSTATE_TIMER(timer, AspeedTimer),
@@ -659,7 +659,7 @@ static const VMStateDescription vmstate_aspeed_timer_state = {
     .name = "aspeed.timerctrl",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl3, AspeedTimerCtrlState),
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 67669a57ff..3ec64604ee 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -146,7 +146,7 @@ static const VMStateDescription bcm2835_systmr_vmstate = {
     .name = "bcm2835_sys_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(reg.ctrl_status, BCM2835SystemTimerState),
         VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState,
                              BCM2835_SYSTIMER_COUNT),
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index e57a0f5f09..54dbd4c564 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -425,7 +425,7 @@ static const VMStateDescription vmstate_cadence_timer = {
     .minimum_version_id = 1,
     .pre_save = cadence_timer_pre_save,
     .post_load = cadence_timer_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(reg_clock, CadenceTimerState),
         VMSTATE_UINT32(reg_count, CadenceTimerState),
         VMSTATE_UINT32(reg_value, CadenceTimerState),
@@ -443,7 +443,7 @@ static const VMStateDescription vmstate_cadence_ttc = {
     .name = "cadence_TTC",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(timer, CadenceTTCState, 3, 0,
                             vmstate_cadence_timer,
                             CadenceTimerState),
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index d4a509c798..ddf9070c3c 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -508,7 +508,7 @@ static const VMStateDescription cmsdk_dualtimermod_vmstate = {
     .name = "cmsdk-apb-dualtimer-module",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, CMSDKAPBDualTimerModule),
         VMSTATE_UINT32(load, CMSDKAPBDualTimerModule),
         VMSTATE_UINT32(value, CMSDKAPBDualTimerModule),
@@ -522,7 +522,7 @@ static const VMStateDescription cmsdk_apb_dualtimer_vmstate = {
     .name = "cmsdk-apb-dualtimer",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(timclk, CMSDKAPBDualTimer),
         VMSTATE_STRUCT_ARRAY(timermod, CMSDKAPBDualTimer,
                              CMSDK_APB_DUALTIMER_NUM_MODULES,
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 68aa1a7636..814545c783 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -250,7 +250,7 @@ static const VMStateDescription cmsdk_apb_timer_vmstate = {
     .name = "cmsdk-apb-timer",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, CMSDKAPBTimer),
         VMSTATE_CLOCK(pclk, CMSDKAPBTimer),
         VMSTATE_UINT32(ctrl, CMSDKAPBTimer),
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index 973eab4386..9fc5c1d8a4 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -39,7 +39,7 @@ static const VMStateDescription vmstate_digic_timer = {
     .name = "digic.timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(ptimer, DigicTimerState),
         VMSTATE_UINT32(control, DigicTimerState),
         VMSTATE_UINT32(relvalue, DigicTimerState),
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index f035b74560..da7c946af5 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -88,7 +88,7 @@ static const VMStateDescription vmstate_etraxfs = {
     .name = "etraxfs",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(ptimer_t0, ETRAXTimerState),
         VMSTATE_PTIMER(ptimer_t1, ETRAXTimerState),
         VMSTATE_PTIMER(ptimer_wd, ETRAXTimerState),
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 446bbd2b96..75098cdb55 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -264,7 +264,7 @@ static const VMStateDescription vmstate_tick_timer = {
     .name = "exynos4210.mct.tick_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cnt_run, struct tick_timer),
         VMSTATE_UINT32(int_run, struct tick_timer),
         VMSTATE_UINT32(last_icnto, struct tick_timer),
@@ -283,7 +283,7 @@ static const VMStateDescription vmstate_lregs = {
     .name = "exynos4210.mct.lregs",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(cnt, struct lregs, L_REG_CNT_AMOUNT),
         VMSTATE_UINT32(tcon, struct lregs),
         VMSTATE_UINT32(int_cstat, struct lregs),
@@ -297,7 +297,7 @@ static const VMStateDescription vmstate_exynos4210_mct_lt = {
     .name = "exynos4210.mct.lt",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(id, Exynos4210MCTLT),
         VMSTATE_STRUCT(tick_timer, Exynos4210MCTLT, 0,
                 vmstate_tick_timer,
@@ -314,7 +314,7 @@ static const VMStateDescription vmstate_gregs = {
     .name = "exynos4210.mct.lregs",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(cnt, struct gregs),
         VMSTATE_UINT32(cnt_wstat, struct gregs),
         VMSTATE_UINT32(tcon, struct gregs),
@@ -332,7 +332,7 @@ static const VMStateDescription vmstate_exynos4210_mct_gt = {
     .name = "exynos4210.mct.lt",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(reg, Exynos4210MCTGT, 0, vmstate_gregs,
                 struct gregs),
         VMSTATE_UINT64(count, Exynos4210MCTGT),
@@ -346,7 +346,7 @@ static const VMStateDescription vmstate_exynos4210_mct_state = {
     .name = "exynos4210.mct",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(reg_mct_cfg, Exynos4210MCTState),
         VMSTATE_STRUCT_ARRAY(l_timer, Exynos4210MCTState, 2, 0,
             vmstate_exynos4210_mct_lt, Exynos4210MCTLT),
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index 3528d0f33a..ca330e9446 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -123,7 +123,7 @@ static const VMStateDescription vmstate_exynos4210_pwm = {
     .name = "exynos4210.pwm.pwm",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, Exynos4210PWM),
         VMSTATE_UINT32(freq, Exynos4210PWM),
         VMSTATE_PTIMER(ptimer, Exynos4210PWM),
@@ -137,7 +137,7 @@ static const VMStateDescription vmstate_exynos4210_pwm_state = {
     .name = "exynos4210.pwm",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg_tcfg, Exynos4210PWMState, 2),
         VMSTATE_UINT32(reg_tcon, Exynos4210PWMState),
         VMSTATE_UINT32(reg_tint_cstat, Exynos4210PWMState),
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 6998094233..f2f1580f81 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -296,7 +296,7 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hpet_rtc_irq_level_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(rtc_irq_level, HPETState),
         VMSTATE_END_OF_LIST()
     }
@@ -307,7 +307,7 @@ static const VMStateDescription vmstate_hpet_offset = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hpet_offset_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(hpet_offset, HPETState),
         VMSTATE_END_OF_LIST()
     }
@@ -317,7 +317,7 @@ static const VMStateDescription vmstate_hpet_timer = {
     .name = "hpet_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(tn, HPETTimer),
         VMSTATE_UINT64(config, HPETTimer),
         VMSTATE_UINT64(cmp, HPETTimer),
@@ -336,7 +336,7 @@ static const VMStateDescription vmstate_hpet = {
     .pre_save = hpet_pre_save,
     .pre_load = hpet_pre_load,
     .post_load = hpet_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(config, HPETState),
         VMSTATE_UINT64(isr, HPETState),
         VMSTATE_UINT64(hpet_counter, HPETState),
@@ -346,7 +346,7 @@ static const VMStateDescription vmstate_hpet = {
                                     vmstate_hpet_timer, HPETTimer),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_hpet_rtc_irq_level,
         &vmstate_hpet_offset,
         NULL
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index b25da448c8..28fdabc321 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -180,7 +180,7 @@ static const VMStateDescription vmstate_pit_channel = {
     .name = "pit channel",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(count, PITChannelState),
         VMSTATE_UINT16(latched_count, PITChannelState),
         VMSTATE_UINT8(count_latched, PITChannelState),
@@ -228,7 +228,7 @@ static const VMStateDescription vmstate_pit_common = {
     .minimum_version_id = 2,
     .pre_save = pit_dispatch_pre_save,
     .post_load = pit_dispatch_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_V(channels[0].irq_disabled, PITCommonState, 3),
         VMSTATE_STRUCT_ARRAY(channels, PITCommonState, 3, 2,
                              vmstate_pit_channel, PITChannelState),
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index d8b8e4e1f6..4917388d45 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -252,7 +252,7 @@ static const VMStateDescription vmstate_ibex_timer = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = ibex_timer_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(timer_ctrl, IbexTimerState),
         VMSTATE_UINT32(timer_cfg0, IbexTimerState),
         VMSTATE_UINT32(timer_compare_lower0, IbexTimerState),
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index 640e4399c2..bd625203aa 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -383,7 +383,7 @@ static const VMStateDescription vmstate_imx_timer_epit = {
     .name = TYPE_IMX_EPIT,
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cr, IMXEPITState),
         VMSTATE_UINT32(sr, IMXEPITState),
         VMSTATE_UINT32(lr, IMXEPITState),
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 7222b1b387..a8edaec867 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -63,7 +63,7 @@ static const VMStateDescription vmstate_imx_timer_gpt = {
     .name = TYPE_IMX_GPT,
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cr, IMXGPTState),
         VMSTATE_UINT32(pr, IMXGPTState),
         VMSTATE_UINT32(sr, IMXGPTState),
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index ee7438f168..b66aed56ea 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -260,7 +260,7 @@ static const VMStateDescription vmstate_timers = {
     .name = "mss-timer-block",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(ptimer, struct Msf2Timer),
         VMSTATE_UINT32_ARRAY(regs, struct Msf2Timer, R_TIM1_MAX),
         VMSTATE_END_OF_LIST()
@@ -271,7 +271,7 @@ static const VMStateDescription vmstate_mss_timer = {
     .name = TYPE_MSS_TIMER,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(freq_hz, MSSTimerState),
         VMSTATE_STRUCT_ARRAY(timers, MSSTimerState, NUM_TIMERS, 0,
                 vmstate_timers, struct Msf2Timer),
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index a8bd93aeb2..779c6049fa 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -637,7 +637,7 @@ static const VMStateDescription vmstate_npcm7xx_base_timer = {
     .name = "npcm7xx-base-timer",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER(qtimer, NPCM7xxBaseTimer),
         VMSTATE_INT64(expires_ns, NPCM7xxBaseTimer),
         VMSTATE_INT64(remaining_ns, NPCM7xxBaseTimer),
@@ -649,7 +649,7 @@ static const VMStateDescription vmstate_npcm7xx_timer = {
     .name = "npcm7xx-timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(base_timer, NPCM7xxTimer,
                              0, vmstate_npcm7xx_base_timer,
                              NPCM7xxBaseTimer),
@@ -663,7 +663,7 @@ static const VMStateDescription vmstate_npcm7xx_watchdog_timer = {
     .name = "npcm7xx-watchdog-timer",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(base_timer, NPCM7xxWatchdogTimer,
                              0, vmstate_npcm7xx_base_timer,
                              NPCM7xxBaseTimer),
@@ -676,7 +676,7 @@ static const VMStateDescription vmstate_npcm7xx_timer_ctrl = {
     .name = "npcm7xx-timer-ctrl",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tisr, NPCM7xxTimerCtrlState),
         VMSTATE_CLOCK(clock, NPCM7xxTimerCtrlState),
         VMSTATE_STRUCT_ARRAY(timer, NPCM7xxTimerCtrlState,
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 50c6772383..a33166a881 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -361,7 +361,7 @@ static const VMStateDescription vmstate_nrf51_timer = {
     .name = TYPE_NRF51_TIMER,
     .version_id = 1,
     .post_load = nrf51_timer_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER(timer, NRF51TimerState),
         VMSTATE_INT64(timer_start_ns, NRF51TimerState),
         VMSTATE_INT64(update_counter_ns, NRF51TimerState),
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 2ae5ae3212..6a7d5551f4 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -501,7 +501,7 @@ static const VMStateDescription vmstate_pxa2xx_timer0_regs = {
     .name = "pxa2xx_timer0",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(value, PXA2xxTimer0),
         VMSTATE_END_OF_LIST(),
     },
@@ -511,7 +511,7 @@ static const VMStateDescription vmstate_pxa2xx_timer4_regs = {
     .name = "pxa2xx_timer4",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(tm, PXA2xxTimer4, 1,
                         vmstate_pxa2xx_timer0_regs, PXA2xxTimer0),
         VMSTATE_INT32(oldclock, PXA2xxTimer4),
@@ -533,7 +533,7 @@ static const VMStateDescription vmstate_pxa2xx_timer_regs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pxa25x_timer_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(clock, PXA2xxTimerInfo),
         VMSTATE_INT32(oldclock, PXA2xxTimerInfo),
         VMSTATE_UINT64(lastload, PXA2xxTimerInfo),
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index 69eabc678a..08832932d2 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -242,7 +242,7 @@ static const VMStateDescription vmstate_rcmt = {
     .name = "rx-cmt",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(cmstr, RCMTState),
         VMSTATE_UINT16_ARRAY(cmcr, RCMTState, CMT_CH),
         VMSTATE_UINT16_ARRAY(cmcnt, RCMTState, CMT_CH),
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 43b31213bc..1d47d0615a 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -447,7 +447,7 @@ static const VMStateDescription vmstate_rtmr = {
     .name = "rx-tmr",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(tick, RTMRState),
         VMSTATE_UINT8_ARRAY(tcnt, RTMRState, TMR_CH),
         VMSTATE_UINT8_ARRAY(tcora, RTMRState, TMR_CH),
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index c664480ccf..e8610c37dd 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -395,7 +395,7 @@ static const VMStateDescription vmstate_sifive_pwm = {
     .name = TYPE_SIFIVE_PWM,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_ARRAY(timer, SiFivePwmState, 4),
         VMSTATE_UINT64(tick_offset, SiFivePwmState),
         VMSTATE_UINT32(pwmcfg, SiFivePwmState),
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 8c4f6eb06b..5507b0145b 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -344,7 +344,7 @@ static const VMStateDescription vmstate_timer = {
     .name ="timer",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(limit, CPUTimerState),
         VMSTATE_UINT32(count, CPUTimerState),
         VMSTATE_UINT32(counthigh, CPUTimerState),
@@ -359,7 +359,7 @@ static const VMStateDescription vmstate_slavio_timer = {
     .name ="slavio_timer",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(cputimer, SLAVIO_TIMERState, MAX_CPUS + 1, 3,
                              vmstate_timer, CPUTimerState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/timer/sse-counter.c b/hw/timer/sse-counter.c
index 16c0e8ad15..daceedf964 100644
--- a/hw/timer/sse-counter.c
+++ b/hw/timer/sse-counter.c
@@ -442,7 +442,7 @@ static const VMStateDescription sse_counter_vmstate = {
     .name = "sse-counter",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(clk, SSECounter),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index e92e83747d..cb20a9eb79 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -428,7 +428,7 @@ static const VMStateDescription sse_timer_vmstate = {
     .name = "sse-timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER(timer, SSETimer),
         VMSTATE_UINT32(cntfrq, SSETimer),
         VMSTATE_UINT32(cntp_ctl, SSETimer),
diff --git a/hw/timer/stellaris-gptm.c b/hw/timer/stellaris-gptm.c
index fd71c79be4..f28958cefc 100644
--- a/hw/timer/stellaris-gptm.c
+++ b/hw/timer/stellaris-gptm.c
@@ -250,7 +250,7 @@ static const VMStateDescription vmstate_stellaris_gptm = {
     .name = "stellaris_gptm",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(config, gptm_state),
         VMSTATE_UINT32_ARRAY(mode, gptm_state, 2),
         VMSTATE_UINT32(control, gptm_state),
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index ba8694dcd3..de4208b1a6 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -274,7 +274,7 @@ static const VMStateDescription vmstate_stm32f2xx_timer = {
     .name = TYPE_STM32F2XX_TIMER,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_cr2, STM32F2XXTimerState),
-- 
2.34.1


