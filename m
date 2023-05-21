Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC6970AD89
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:01:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0goF-0004yM-77; Sun, 21 May 2023 07:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gnt-0004yC-Hp
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:00:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gnr-0001Rw-L2
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:00:45 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 035D45C010F;
 Sun, 21 May 2023 07:00:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Sun, 21 May 2023 07:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1684666841; x=1684753241; bh=Z4nCXcCAaV
 i9VHHeHv3qATH6KOa7RYJUKN9eWZ9J+T4=; b=G2LiN/ufk92F6iVfRZV6F7XlAv
 Xa2x9C1rM2aSK08UGuUo4o3WvNYGrOZXdoZHKonXzjJN8Ka6sZv4544VDowvEMco
 Nk5TPyKX/B9CgffafY+h4y9gQVwL3NhJ66zHA6u3ffJZz6x6vumbxa6oGb65baTS
 94IYLReeJRlTMX67FK6N0vOa89A4vAi8o5nteiy4/cmlv4cDuSkVu1FHktGTmzll
 O7jwrv4cbaUoJNc/xTMIkWKmeuonRE8GxinhMaW6IhDpNuMpBaUU/y+ZtkJmGlvk
 6yQBUKoTzY/7hg2O3AKJFY1suNjs8JPxDQFsvdZuFf4JAffMdF3/3176MYiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684666841; x=1684753241; bh=Z4nCXcCAaVi9V
 HHeHv3qATH6KOa7RYJUKN9eWZ9J+T4=; b=hS431qSzaORpBcTH57jgqNNnaWdLZ
 hpYTerht09Z9+hz03qakOXx+TaeRrNNHn6sshx8dJjwnZt5nccmuQM6UldrfFGsj
 Bm3YC4z+acbZ/6+h272pNckt0zNyI7p0VvZVfY3IQ7uyGUu/s8bg+wtG/1tbi+51
 0em3+U5uf+xmxW0kFbFVzmPzOlMcTWNrMI9t9w3Xeu1aGD5YbsDxj8uydeAdo4dn
 3jTBzrGEbBHVdQ2KWesu/ea57eiYj/U63i2bj56clt+5HQRFzeVfXKCKwkZTm4pz
 AG4E4IxudwXioeuN/GDUBNZNjRNruarqwm5Hml1MhJhZXikOKkoKv5d2w==
X-ME-Sender: <xms:2flpZB3etRbNcIcFHLwyHYvLmKunltolklDT0SgmLn48GDQOVbsu3A>
 <xme:2flpZIG8r0FXyQr8lWV66JLKg6krMb7hAhj6g7EU61G45L6wnhEkEiGknDqKL7hSi
 L1E3v_k3beTuMGkReY>
X-ME-Received: <xmr:2flpZB6Be3fxUpV_Gi8hbsBnU2biYcDNsGRrSWYmG9wBwQ3edLqZqIiuuWXS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiledgfeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
 fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
 ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomh
X-ME-Proxy: <xmx:2flpZO1ZIiZ3wPuj0uqrP6UNTwNPZatUfux50DhKJmY43H4S8lFjSQ>
 <xmx:2flpZEH8KsIo41cMQWjLBzbEpwFWmLtCBViqDK8B90pDl0pMcIdgMA>
 <xmx:2flpZP9pwrUgXbXL7kH-E4MqQgI7XX0wzoCOZA-2-t3cVZU-7PtfDg>
 <xmx:2flpZJTwZkuIoc7SumPd12i1_Zks7kQ12Ov1fkY1jnoIfXSnBDCKeg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 07:00:40 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, chenhuacai@kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] target/mips: Rework cp0_timer with clock API
Date: Sun, 21 May 2023 12:00:37 +0100
Message-Id: <20230521110037.90049-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.25; envelope-from=jiaxun.yang@flygoat.com;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Previous implementation of MIPS cp0_timer computes a
cp0_count_ns based on input clock. However rounding
error of cp0_count_ns can affect precision of cp0_timer.

Using clock API and a divider for cp0_timer, so we can
use clock_ns_to_ticks/clock_ns_to_ticks to avoid rounding
issue.

Also workaround the situation that in such handler flow:

count = read_c0_count()
write_c0_compare(count)

If timer had not progressed when compare was written, the
interrupt would trigger again.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
This seems fixed MTTCG booting issue on malta 5kEc with SMP.
I'm going to do more test and see if we can enable MTTCG for
mips64el.
---
 target/mips/cpu.c              |  8 +++++---
 target/mips/cpu.h              |  3 ++-
 target/mips/sysemu/cp0_timer.c | 35 ++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 01e0fbe10db2..b7119cbbb459 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -449,9 +449,9 @@ static void mips_cp0_period_set(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-    env->cp0_count_ns = clock_ticks_to_ns(MIPS_CPU(cpu)->clock,
-                                          env->cpu_model->CCRes);
-    assert(env->cp0_count_ns);
+    clock_set_mul_div(cpu->count_div, env->cpu_model->CCRes, 1);
+    clock_set_source(cpu->count_div, cpu->clock);
+    clock_set_source(env->count_clock, cpu->count_div);
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -504,6 +504,8 @@ static void mips_cpu_initfn(Object *obj)
 
     cpu_set_cpustate_pointers(cpu);
     cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
+    cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
+    env->count_clock = clock_new(OBJECT(obj), "clk-count");
     env->cpu_model = mcc->cpu_def;
 }
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 142c55af478b..1b8107b0af86 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1160,8 +1160,8 @@ typedef struct CPUArchState {
 
     const mips_def_t *cpu_model;
     QEMUTimer *timer; /* Internal timer */
+    Clock *count_clock; /* CP0_Count clock */
     target_ulong exception_base; /* ExceptionBase input to the core */
-    uint64_t cp0_count_ns; /* CP0_Count clock period (in nanoseconds) */
 } CPUMIPSState;
 
 /**
@@ -1178,6 +1178,7 @@ struct ArchCPU {
     /*< public >*/
 
     Clock *clock;
+    Clock *count_div; /* Divider for CP0_Count clock */
     CPUNegativeOffsetState neg;
     CPUMIPSState env;
 };
diff --git a/target/mips/sysemu/cp0_timer.c b/target/mips/sysemu/cp0_timer.c
index 70de95d338f8..9d2bcb0dea21 100644
--- a/target/mips/sysemu/cp0_timer.c
+++ b/target/mips/sysemu/cp0_timer.c
@@ -28,15 +28,26 @@
 #include "internal.h"
 
 /* MIPS R4K timer */
+static uint32_t cpu_mips_get_count_val(CPUMIPSState *env)
+{
+    int64_t now_ns;
+    now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    return env->CP0_Count +
+            (uint32_t)clock_ns_to_ticks(env->count_clock, now_ns);
+}
+
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
     uint64_t now_ns, next_ns;
     uint32_t wait;
 
     now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    wait = env->CP0_Compare - env->CP0_Count -
-           (uint32_t)(now_ns / env->cp0_count_ns);
-    next_ns = now_ns + (uint64_t)wait * env->cp0_count_ns;
+    wait = env->CP0_Compare - cpu_mips_get_count_val(env);
+    /* Clamp interval to overflow if virtual time had not progressed */
+    if (!wait) {
+        wait = UINT32_MAX;
+    }
+    next_ns = now_ns + clock_ticks_to_ns(env->count_clock, wait);
     timer_mod(env->timer, next_ns);
 }
 
@@ -64,7 +75,7 @@ uint32_t cpu_mips_get_count(CPUMIPSState *env)
             cpu_mips_timer_expire(env);
         }
 
-        return env->CP0_Count + (uint32_t)(now_ns / env->cp0_count_ns);
+        return cpu_mips_get_count_val(env);
     }
 }
 
@@ -79,9 +90,8 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
         env->CP0_Count = count;
     } else {
         /* Store new count register */
-        env->CP0_Count = count -
-               (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-                          env->cp0_count_ns);
+        env->CP0_Count = count - (uint32_t)clock_ns_to_ticks(env->count_clock,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         /* Update timer timer */
         cpu_mips_timer_update(env);
     }
@@ -107,8 +117,8 @@ void cpu_mips_start_count(CPUMIPSState *env)
 void cpu_mips_stop_count(CPUMIPSState *env)
 {
     /* Store the current value */
-    env->CP0_Count += (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-                                 env->cp0_count_ns);
+    env->CP0_Count += (uint32_t)clock_ns_to_ticks(env->count_clock,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
 }
 
 static void mips_timer_cb(void *opaque)
@@ -121,14 +131,7 @@ static void mips_timer_cb(void *opaque)
         return;
     }
 
-    /*
-     * ??? This callback should occur when the counter is exactly equal to
-     * the comparator value.  Offset the count by one to avoid immediately
-     * retriggering the callback before any virtual time has passed.
-     */
-    env->CP0_Count++;
     cpu_mips_timer_expire(env);
-    env->CP0_Count--;
 }
 
 void cpu_mips_clock_init(MIPSCPU *cpu)
-- 
2.39.2 (Apple Git-143)


