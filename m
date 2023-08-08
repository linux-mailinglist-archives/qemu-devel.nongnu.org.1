Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F97737D8
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTECx-0006hj-BM; Tue, 08 Aug 2023 00:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECv-0006ee-2k; Tue, 08 Aug 2023 00:20:33 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECs-0007fc-Hm; Tue, 08 Aug 2023 00:20:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686f0d66652so4981920b3a.2; 
 Mon, 07 Aug 2023 21:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468429; x=1692073229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9ouVweL8lLdZYVLMOSmjhorKuJ+xhwD5JToKTQsGl0=;
 b=YwRHbU88+Vv8mUeDEVN/4iM8uNC4tB9ELbCY6kX0szPpMHJhVqxXchQ+9caUeiSkKB
 9f2nE+6gV1x+zSFD5a/CeYUHwUbroYefju2oxM7Ez0eBvBO4y/NoId0bdfaN32I5iz1y
 rChVUKubj+PTNWLd2w6O3S+/0OynQmnTZDeqZVj4qaDhRI0U7FqAlqdMtTDt01KtyQhc
 SUqz57JGp4jBU534zNaEJzbVNbK4lI4foYdCnMl/R9wDhhh9+2xW60pDo9++euVKIou/
 VfZwtJqkmv20nQUHbewGPQIRnWe9kOPxv4nBy4ere23Owk+Zxew81INDkIrQYU9F6gmD
 uj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468429; x=1692073229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9ouVweL8lLdZYVLMOSmjhorKuJ+xhwD5JToKTQsGl0=;
 b=Bcf0P3EwSe+4ke8+iDlGCm2eO78Blz1Hmfy8K3Ajvxd6dsCbJS+IlNNARHRKeUZhoe
 P+hNRPts+2p7n7Pj3lnaG/p6cGXg+mHOmdc9fL5bxOPCEww2p4Ukxh3vYXvsBueLfEg6
 y/SqyiYGzMcVrIHn87PuOFtKq+pUPQTdD9QxpHW5MLsXvmt3xwtseMyuqMQ1Hp384vn9
 RMt05LL8CoKjdRGZUxHNCGP4S9FkCGVx47aoWCl5fDtdEj9cGYSqfeuHLB111pL7bRIK
 ybxtOH5iT+tcbkE7OeZ8SgnT3RajnPtoWJtG5B1jSdqwgyTKEzxsC6F8foOrhFEJduRz
 Kz4g==
X-Gm-Message-State: AOJu0Ywa6huZgGJKM+ZBkJSAzGccnyH5oc6Q71OyNUiZq4MV7tM9l9xi
 EQXmaS3RypcvdZF0xlE1eS0=
X-Google-Smtp-Source: AGHT+IE3oOcNvkacK4pTZIlP9sUV2SLjKR8Bm5LcCOu9LTxyBw47E670T7Jfo7H70JQWUrqQQPcrAQ==
X-Received: by 2002:a05:6a00:15c9:b0:686:babd:f5c1 with SMTP id
 o9-20020a056a0015c900b00686babdf5c1mr13856907pfu.25.1691468428895; 
 Mon, 07 Aug 2023 21:20:28 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 04/19] hw/ppc: Introduce functions for conversion between
 timebase and nanoseconds
Date: Tue,  8 Aug 2023 14:19:46 +1000
Message-Id: <20230808042001.411094-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These calculations are repeated several times, and they will become
a little more complicated with subsequent changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 09b82f68a8..423a3a117a 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -482,10 +482,20 @@ void ppce500_set_mpic_proxy(bool enabled)
 /*****************************************************************************/
 /* PowerPC time base and decrementer emulation */
 
+static uint64_t ns_to_tb(uint32_t freq, int64_t clock)
+{
+    return muldiv64(clock, freq, NANOSECONDS_PER_SECOND);
+}
+
+static int64_t tb_to_ns(uint32_t freq, uint64_t tb)
+{
+    return muldiv64(tb, NANOSECONDS_PER_SECOND, freq);
+}
+
 uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
 {
     /* TB time in tb periods */
-    return muldiv64(vmclk, tb_env->tb_freq, NANOSECONDS_PER_SECOND) + tb_offset;
+    return ns_to_tb(tb_env->tb_freq, vmclk) + tb_offset;
 }
 
 uint64_t cpu_ppc_load_tbl (CPUPPCState *env)
@@ -528,8 +538,7 @@ uint32_t cpu_ppc_load_tbu (CPUPPCState *env)
 static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
                                     int64_t *tb_offsetp, uint64_t value)
 {
-    *tb_offsetp = value -
-        muldiv64(vmclk, tb_env->tb_freq, NANOSECONDS_PER_SECOND);
+    *tb_offsetp = value - ns_to_tb(tb_env->tb_freq, vmclk);
 
     trace_ppc_tb_store(value, *tb_offsetp);
 }
@@ -694,11 +703,11 @@ static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
 
     diff = next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     if (diff >= 0) {
-        decr = muldiv64(diff, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
+        decr = ns_to_tb(tb_env->decr_freq, diff);
     } else if (tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
     }  else {
-        decr = -muldiv64(-diff, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
+        decr = -ns_to_tb(tb_env->decr_freq, -diff);
     }
     trace_ppc_decr_load(decr);
 
@@ -838,7 +847,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     /* Calculate the next timer event */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + muldiv64(value, NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+    next = now + tb_to_ns(tb_env->decr_freq, value);
     *nextp = next;
 
     /* Adjust timer */
@@ -1130,7 +1139,7 @@ static void cpu_4xx_fit_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->tb_freq);
+    next = now + tb_to_ns(tb_env->tb_freq, next);
     if (next == now)
         next++;
     timer_mod(ppc40x_timer->fit_timer, next);
@@ -1158,8 +1167,7 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
     } else {
         trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + muldiv64(ppc40x_timer->pit_reload,
-                              NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+        next = now + tb_to_ns(tb_env->decr_freq, ppc40x_timer->pit_reload);
         if (is_excp)
             next += tb_env->decr_next - now;
         if (next == now)
@@ -1218,7 +1226,7 @@ static void cpu_4xx_wdt_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+    next = now + tb_to_ns(tb_env->decr_freq, next);
     if (next == now)
         next++;
     trace_ppc4xx_wdt(env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR]);
-- 
2.40.1


