Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CEC74B015
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgT-0001nh-7Z; Fri, 07 Jul 2023 07:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgR-0001mx-Fa; Fri, 07 Jul 2023 07:31:31 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgP-0006Tw-PZ; Fri, 07 Jul 2023 07:31:31 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b5d57d7db9so1619253a34.3; 
 Fri, 07 Jul 2023 04:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729488; x=1691321488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwJ9IADkYcbtKTE0O06D8PcQkEaZONSm/3zDPd3q/Aw=;
 b=kD0xRJsoFdiQdsyWykqEM8amow9xWsnI+7ehHiED3o7K07nOq86lDFJM6VFcK0Tf3t
 q7+KTq4/e8WzRPdW2X6WEA8VHPupPztVXZGBe2h8MLJb0jRGPacHyLkFvBXFCTT5V5i3
 k0UTcGViP3bV7+Prx6IsDoa6AnIQBKuX7Zu6dePbjpkVpbOdCEEb/pEBrccPTzLYPjKL
 gfbJRxamQQ3JanSGJ87Q9n8tmzVcEICFOD4o+GJ9Wi3ibLE1Z+tdslbHdW0Ig1/ZwvsK
 L6xMWNLJWALh8gcUlQNxHEYok/OKR27E4U7THo+6UBMIHryF2ODSPVYKmX57c/tTw1pA
 LgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729488; x=1691321488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwJ9IADkYcbtKTE0O06D8PcQkEaZONSm/3zDPd3q/Aw=;
 b=MDBH7tzDkm6B57fZksPHu/r1CeTyNG2VVdrQNZVEkRgAbLsYvntIKTuej1ibEzjc6q
 8DiS+K/IUndG8aqL2E22MqbIR8iaypgpC6SmLkr2xpz5vzQgTZf2qbF1v4n9vAFD1kWw
 HGO8findwoK+gIBIgAC0Ajzxn/XWiABvUJwOwQg/vk6d0vQ1ExChk1CKUVeQY5yf/lKF
 q/+fPxIImSrUpmMM1zSWLHwLLn/pA+cChxIdDhcLGGMkbE3uQgUDpvGeysw+wVdshzJ/
 p/7h3iUJ5MG5jKzwNSeWHRGCcTPErxV2ocjlRpJv1N5TMD4yeqr0+CYGm6PE6lQ3u3aG
 fumA==
X-Gm-Message-State: ABy/qLaAzuwePXY4BQ8KScjDzO8lM+PVm3NVqkGQBIlq8J9RKk19Rl09
 3vuc9X5OpTCbtP1JJIpDh4uwWaREJWM=
X-Google-Smtp-Source: APBJJlHhMtX+01K3fZppLYS33eQoi/a7Jkk2E2iqdhO2X7fIRjFynihVpBVlF2w38a8fVMeJR52EzA==
X-Received: by 2002:a9d:67d9:0:b0:6b8:6f94:d3a2 with SMTP id
 c25-20020a9d67d9000000b006b86f94d3a2mr4451166otn.25.1688729488125; 
 Fri, 07 Jul 2023 04:31:28 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:27 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 02/60] target/ppc: Make HDECR underflow edge triggered
Date: Fri,  7 Jul 2023 08:30:10 -0300
Message-ID: <20230707113108.7145-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

HDEC interrupts are edge-triggered on HDECR underflow (notably different
from DEC which is level-triggered).

HDEC interrupts already clear the irq on delivery so that does not need
to be changed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230625122045.15544-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 82e4408c5c..0fc82bb175 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -788,8 +788,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
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
@@ -819,15 +819,15 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
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
 
@@ -846,8 +846,8 @@ static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
     __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env->decr_timer,
-                         tb_env->decr_timer->cb, &cpu_ppc_decr_lower, decr,
-                         value, nr_bits);
+                         tb_env->decr_timer->cb, &cpu_ppc_decr_lower,
+                         tb_env->flags, decr, value, nr_bits);
 }
 
 void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value)
@@ -876,8 +876,10 @@ static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hdecr,
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
2.41.0


