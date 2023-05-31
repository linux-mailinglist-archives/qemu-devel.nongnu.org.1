Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AAC71731D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AYy-0004ov-NC; Tue, 30 May 2023 21:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYw-0004ha-14; Tue, 30 May 2023 21:23:42 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYu-0005Gq-H3; Tue, 30 May 2023 21:23:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b04949e5baso21531345ad.0; 
 Tue, 30 May 2023 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685496218; x=1688088218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaJPnkMdqEyXleUkWVpoAwGBUt7AFKQl6C5a9llnJ3I=;
 b=hKOPP/ymGwlx81QecaRffmdnigWjGmdtZ/cJh1ndlwMLQRjxa2e1h48d/qhsrQrW9d
 EuMGBsQBC90MhrOXPIsScIvj0lu7gDmSD7Z1VtPmSMdkZ+xdldHp2jnbEX7pLasHL9Od
 anIcezHUFhJxP3QLzeobhraUyOa5ZIGv+PTOGHST3sbGhzVW8JNmqOcEB5b7cMoDFIta
 RoOZuzjw17BnBbBJO7wGQ/j76s+o+hSbSLtIAG1UOlzCRRg+Xb3XXlBe+PwhwCvnjHng
 FulfI5sexhQisjjSB2n9fgtFzWDiOFZJIbVb7yU4us83E/HKpX8mqbsrRCb76rCTwDIT
 +2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685496218; x=1688088218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaJPnkMdqEyXleUkWVpoAwGBUt7AFKQl6C5a9llnJ3I=;
 b=YdwOL6GUW1IG7SAGi4yETLReTeZjtWjyInLBNqcpSkoJyUl8R563IN0iqUQRuLjHiF
 MJTT4DV+c8g+e5/3hjZNpJjzWNpWCi6O/F2ke8rZzmjNwwmtsmNNCVAGPD/ODJZOA+ZS
 8nfdAe/oEMmvPZsFXESfVVvjXHKrHGVd/qcOfy8dCXRRPo04BJ7uweBxR06X9v2662Co
 afNSVA2eDlFxll62+89VljZLJtJQfW5BqjkUflZ/zvhfDy+nx97WnnZvNzPPbmyFpaou
 oSUyjzgDM9Lfh4ZwfDwaCSLv7HU26gtmxhSgCehIYndTnl9Pr5mcoK1ConNQk/4oQX/D
 L83A==
X-Gm-Message-State: AC+VfDy/Tp3z/tqOMfJ81PURzFgflisyTQ6gfo4rxxpJObjcsmYdcSr3
 qXtRbUQuNRVflGkb2tVlTMPTLVknXzM=
X-Google-Smtp-Source: ACHHUZ4CGoAgqdvju4OeJ1upj8cYN87WOuK+hi/TErnkXa2mq84lfwj2Htt/AxPFAPtbCy2C3mqoZw==
X-Received: by 2002:a17:902:e744:b0:1af:a349:3f0d with SMTP id
 p4-20020a170902e74400b001afa3493f0dmr4802042plf.23.1685496218382; 
 Tue, 30 May 2023 18:23:38 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 9-20020a170902c10900b00186a2274382sm10928840pli.76.2023.05.30.18.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 18:23:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RFC PATCH 5/5] spapr: Allow up to 8 threads SMT configuration
Date: Wed, 31 May 2023 11:23:13 +1000
Message-Id: <20230531012313.19891-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531012313.19891-1-npiggin@gmail.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

TCG now supports multi-threaded configuration at least enough for
pseries to be functional enough to boot Linux.

This requires PIR and TIR be set, because that's how sibling thread
matching is done.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c          | 4 ++--
 hw/ppc/spapr_cpu_core.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dcb7f1c70a..11074cefea 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2524,8 +2524,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     int ret;
     unsigned int smp_threads = ms->smp.threads;
 
-    if (!kvm_enabled() && (smp_threads > 1)) {
-        error_setg(errp, "TCG cannot support more than 1 thread/core "
+    if (!kvm_enabled() && (smp_threads > 8)) {
+        error_setg(errp, "TCG cannot support more than 8 threads/core "
                    "on a pseries machine");
         return;
     }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9b88dd549a..f35ee600f1 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -255,7 +255,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
 }
 
 static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
-                               SpaprCpuCore *sc, Error **errp)
+                               SpaprCpuCore *sc, int thread_nr, Error **errp)
 {
     CPUPPCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
@@ -267,6 +267,9 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
     kvmppc_set_papr(cpu);
 
+    env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
+    env->spr_cb[SPR_TIR].default_value = thread_nr;
+
     /* Set time-base frequency to 512 MHz. vhyp must be set first. */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
 
@@ -337,7 +340,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < cc->nr_threads; i++) {
         sc->threads[i] = spapr_create_vcpu(sc, i, errp);
         if (!sc->threads[i] ||
-            !spapr_realize_vcpu(sc->threads[i], spapr, sc, errp)) {
+            !spapr_realize_vcpu(sc->threads[i], spapr, sc, i, errp)) {
             spapr_cpu_core_unrealize(dev);
             return;
         }
-- 
2.40.1


