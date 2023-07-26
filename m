Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7875763F29
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:02:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjAe-0003yx-Q8; Wed, 26 Jul 2023 14:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjA5-0003sT-Su; Wed, 26 Jul 2023 14:23:07 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjA4-0008Sv-7s; Wed, 26 Jul 2023 14:23:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686efdeabaeso84731b3a.3; 
 Wed, 26 Jul 2023 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690395777; x=1691000577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0qoXrPvoquYQTQlBD4shTNqfDEEX1RsqpNF9V5SWPc=;
 b=B3wGmMWFO3XJMuyGEoyug48XJIh15PYfIFa2oSM1BTpOwu2j4HQb5IIhqeDL6B70F0
 vrTyarTn2u9v6PBYio/VS69KZREc7U8UerY8ELnQPKlPtj+epjKEawrkVFHZg77fguDa
 C11x8IRFyBD8jJLs8Wlfz7NYnEiI+u3PmhetlaleNNe0SgtR7tTpuAJh8e5Wf9yfptL1
 XJMB3PECpZt5mgqCFbSfz597aYil8+jHmPmkzn2+hFyb/v0DMiVTkvsAx8tubeLcAfUP
 zYbSrooHK70PO94WwmsV3BCWx1MEBJAkTldGs4ytdnK98cH45TTGvTTj0VGakcUUn6KG
 rFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690395777; x=1691000577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0qoXrPvoquYQTQlBD4shTNqfDEEX1RsqpNF9V5SWPc=;
 b=CAs7YL1XWXJORhQj5yQDU2gfFIoPEGMwiNtGQ99UrxftRUOZgjN7bjHpiKXftIm7k+
 IjymyIjgqGP0VoHCZMAVUvliO3jrU3oubYrWa7VCUSXqpsNRFmhjbDYB3go6Q1T+VC9Y
 gPBiDmBh+JamCjkRnK+ua29S4GCoebSRDk4rUP+Nmo2FcmFRalQudmQEERsGGYElpkWw
 B4DZF1EDsUqV8hOhLxGrJn2agiz2+r4MvaF3LHpzhdGEG8MWMPIh+mcDd1Mcg/AeX/nP
 0NIZmGETJuK9nfjhP2tnEoRZUMyKq13t5mzsEhABCxOER3usMiqMeptdxmaaIAkg+9Zg
 05EQ==
X-Gm-Message-State: ABy/qLZD/nXjQx5MV1Vo1Zp8riLUsasOiys8NBTza2H6W7BSZ9KBE8se
 mkrqhGBoaKun34x6/oIgZh8=
X-Google-Smtp-Source: APBJJlF9DQuaUtkL1fP91w0hYg+EcarJH6svrfzjFHZNdPrtLJ5ODu45Lu5irTijvk990ifXRlyMPg==
X-Received: by 2002:a05:6a20:7f84:b0:126:43f7:e271 with SMTP id
 d4-20020a056a207f8400b0012643f7e271mr2655208pzj.39.1690395777122; 
 Wed, 26 Jul 2023 11:22:57 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a639319000000b0055adced9e13sm360185pge.0.2023.07.26.11.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:22:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/ppc: Avoid decrementer rounding errors
Date: Thu, 27 Jul 2023 04:22:28 +1000
Message-Id: <20230726182230.433945-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726182230.433945-1-npiggin@gmail.com>
References: <20230726182230.433945-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The decrementer register contains a relative time in timebase units.
When writing to DECR this is converted and stored as an absolute value
in nanosecond units, reading DECR converts back to relative timebase.

The tb<->ns conversion of the relative part can cause rounding such that
a value writen to the decrementer can read back a different, with time
held constant. This is a particular problem for a deterministic icount
and record-replay trace.

Fix this by storing the absolute value in timebase units rather than
nanoseconds. The math before:
  store:  decr_next = now_ns + decr * ns_per_sec / tb_per_sec
  load:        decr = (decr_next - now_ns) * tb_per_sec / ns_per_sec
  load(store): decr = decr * ns_per_sec / tb_per_sec * tb_per_sec /
                      ns_per_sec

After:
  store:  decr_next = now_ns * tb_per_sec / ns_per_sec + decr
  load:        decr = decr_next - now_ns * tb_per_sec / ns_per_sec
  load(store): decr = decr

Fixes: 9fddaa0c0cab ("PowerPC merge: real time TB and decrementer - faster and simpler exception handling (Jocelyn Mayer)")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0e0a3d93c3..fa60f76dd4 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -686,16 +686,17 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
 static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    int64_t decr, diff;
+    uint64_t now, n;
+    int64_t decr;
 
-    diff = next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    if (diff >= 0) {
-        decr = muldiv64(diff, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
-    } else if (tb_env->flags & PPC_TIMER_BOOKE) {
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    n = muldiv64(now, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
+    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
-    }  else {
-        decr = -muldiv64(-diff, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
+    } else {
+        decr = next - n;
     }
+
     trace_ppc_decr_load(decr);
 
     return decr;
@@ -834,11 +835,11 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     /* Calculate the next timer event */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + muldiv64(value, NANOSECONDS_PER_SECOND, tb_env->decr_freq);
-    *nextp = next;
+    next = muldiv64(now, tb_env->decr_freq, NANOSECONDS_PER_SECOND) + value;
+    *nextp = next; /* nextp is in timebase units */
 
     /* Adjust timer */
-    timer_mod(timer, next);
+    timer_mod(timer, muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->decr_freq));
 }
 
 static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
@@ -1153,14 +1154,20 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
     } else {
         trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + muldiv64(ppc40x_timer->pit_reload,
-                              NANOSECONDS_PER_SECOND, tb_env->decr_freq);
-        if (is_excp)
-            next += tb_env->decr_next - now;
-        if (next == now)
-            next++;
+
+        if (is_excp) {
+            tb_env->decr_next += ppc40x_timer->pit_reload;
+        } else {
+            tb_env->decr_next = muldiv64(now, tb_env->decr_freq,
+                                         NANOSECONDS_PER_SECOND)
+                                + ppc40x_timer->pit_reload;
+        }
+        next = muldiv64(tb_env->decr_next, NANOSECONDS_PER_SECOND,
+                        tb_env->decr_freq);
+        if (next <= now) {
+            next = now + 1;
+        }
         timer_mod(tb_env->decr_timer, next);
-        tb_env->decr_next = next;
     }
 }
 
-- 
2.40.1


