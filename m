Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ADA73D0E4
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 14:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDOjl-0002yo-HR; Sun, 25 Jun 2023 08:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOjk-0002yc-1X; Sun, 25 Jun 2023 08:21:00 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOje-0002ze-Ud; Sun, 25 Jun 2023 08:20:58 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-666eef03ebdso1015427b3a.1; 
 Sun, 25 Jun 2023 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687695653; x=1690287653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p/15pLlbxzHEme4kY/b5wt7Kjg5dVBgWuJVjMRXXaUY=;
 b=ajWdnXnUH+ckpM6/WSess8ewYF+4ZueIZZOvIwcUZCTp5zxoxJNxRY+r/xoCzIjXg7
 umTLXtQLhKdCCEpOfXpCI7tFi3dYiD/xRjMzm8UKwCtxlE4lgiDM5SyMSvAa/apeCmn8
 +ssbTRS2NJYSXTeIkpO2JxMTxwWlQf8AsxB0TU8qQnXRaK0C66LsUFakctWcxk5v+qSZ
 UIy8sJlpQOHVhoBMGNw0JiWGwguDlAtZJoDxqitjpTiWXdXTJMu6NLpNuBFiwOopldDG
 CqRVwblVyR70CZhso+enyMJZuOtqgOJbfzvZFG+WdYM65P5Zs6TpZAN497yCqe0MCcum
 i+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687695653; x=1690287653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p/15pLlbxzHEme4kY/b5wt7Kjg5dVBgWuJVjMRXXaUY=;
 b=PJoFKka63edUUamv7N01YvfInijZvpa1wcTohjOzQPS8uq9EnRL7aNmtoGOFxrYF5c
 Y71p/fRb1DZX/15nJn0YYqbXiO3t/lUxSS7UJ26mC/RXC04pEeFQw662sjDs3EL29gNA
 kX/K/7k80wv9iZcNRADStxrywqk7wk27tQXavUCvHyqkgh/6dKucTHD4Yqm1kLCyL+3D
 hgZx7aTFtImXyUl9I/UxJW/wOd56tE9g/eC/S5tsCVBTsWIi0aNU5S+w+2zlGRgK1qip
 tu1I3M+XTEvQJLiYrgkUVEz9fNx9D5AfR1DE0KKxHCUCI0il1ahFnJiv1YgoPXKGM+LH
 jHlw==
X-Gm-Message-State: AC+VfDx6N7yIrj+kKW7kWs7+h/Pkcp2KkBUoEz3lkpRIyyAWLtf0ZfhP
 SUi2jWBNOuGwdFoOa42jwMQrHkZYKBo=
X-Google-Smtp-Source: ACHHUZ6jKKaHHVvzdX9uENfSSevZNfYFdlbzIZj+v6uDopLpq1UwULIisTXjJvBqB3Vlia/LUd1OyQ==
X-Received: by 2002:a05:6a20:151:b0:125:d34f:e905 with SMTP id
 17-20020a056a20015100b00125d34fe905mr2883900pzs.37.1687695652713; 
 Sun, 25 Jun 2023 05:20:52 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 e11-20020aa78c4b000000b0065ecdefa57fsm2225648pfd.0.2023.06.25.05.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 05:20:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH] target/ppc: Make HDECR underflow edge triggered
Date: Sun, 25 Jun 2023 22:20:45 +1000
Message-Id: <20230625122045.15544-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

HDEC interrupts are edge-triggered on HDECR underflow (notably different
from DEC which is level-triggered).

HDEC interrupts already clear the irq on delivery so that does not need
to be changed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 7b7db30f95..f4fe1767d6 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -789,8 +789,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
                                  QEMUTimer *timer,
                                  void (*raise_excp)(void *),
                                  void (*lower_excp)(PowerPCCPU *),
-                                 target_ulong decr, target_ulong value,
-                                 int nr_bits)
+                                 uint32_t flags, target_ulong decr,
+                                 target_ulong value, int nr_bits)
 {
     CPUPPCState *env = &cpu->env;
     ppc_tb_t *tb_env = env->tb_env;
@@ -820,15 +820,15 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
      * On MSB edge based DEC implementations the MSB going from 0 -> 1 triggers
      * an edge interrupt, so raise it here too.
      */
-    if (((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
-        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
+    if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
         return;
     }
 
     /* On MSB level based systems a 0 for the MSB stops interrupt delivery */
-    if (signed_value >= 0 && (tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL)) {
+    if (signed_value >= 0 && (flags & PPC_DECR_UNDERFLOW_LEVEL)) {
         (*lower_excp)(cpu);
     }
 
@@ -847,8 +847,8 @@ static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
     __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env->decr_timer,
-                         tb_env->decr_timer->cb, &cpu_ppc_decr_lower, decr,
-                         value, nr_bits);
+                         tb_env->decr_timer->cb, &cpu_ppc_decr_lower,
+                         tb_env->flags, decr, value, nr_bits);
 }
 
 void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value)
@@ -877,8 +877,10 @@ static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hdecr,
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
     if (tb_env->hdecr_timer != NULL) {
+        /* HDECR (Book3S 64bit) is edge-based, not level like DECR */
         __cpu_ppc_store_decr(cpu, &tb_env->hdecr_next, tb_env->hdecr_timer,
                              tb_env->hdecr_timer->cb, &cpu_ppc_hdecr_lower,
+                             PPC_DECR_UNDERFLOW_TRIGGERED,
                              hdecr, value, nr_bits);
     }
 }
-- 
2.40.1


