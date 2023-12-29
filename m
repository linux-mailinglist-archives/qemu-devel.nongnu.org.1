Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BA8201AC
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:28:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLI-0006z2-Pe; Fri, 29 Dec 2023 16:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLG-0006yJ-Cy
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:30 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLE-0006e4-Fj
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:30 -0500
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7ba737ee9b5so505928539f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885067; x=1704489867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NbLag/EB+bHmmgZuugtXh6y657JKbfbzieGWYM5hvCY=;
 b=oAYTO0+p3TOe6m9RMQJmhu13PywPs5SuS9/xbOlKKoS81DLoiiJD8aEqQgYiuGqYu8
 +/BBtz6fTjacWVD2jl7iK3MPFnk/kNPUsUKICL/+oS13d8R1SApS/DBxLqToZ3+3qPFL
 ZEG+sN7Gq9u9JLARWIkNlAHB2lOtScXCLiPGOsbYlrTozaPymhaV7IN4m7qAR0MZqMY3
 cBPra/h9SixPMazwVa23pRBaZZ01OMHLY5m/chn2tGuD7Rd4halPF95zJjI/FUNFx3aN
 v3UgfUMZcV2xGVNGMCsQ6hgWNvNiO5lI70FeXaxpISu4PoIgxzmTF4y6he1HbDwzbnLt
 /tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885067; x=1704489867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbLag/EB+bHmmgZuugtXh6y657JKbfbzieGWYM5hvCY=;
 b=en/jJhbU6BHyKehXMwmAb9H6OxfNTNDGzdc0TS/VVzDrOxlaoHrS9lk6EL2GxVs+Gn
 uCcDcC2FiD1JzdQg0iRTTBQbu8yW6KPCwnVtcni7O9y6KoWjvzRPMbBto4vOXshIGGyv
 QsHluRUUJouI8yqNxNt334l7nCjyXG1iECxmQHx0krKwcI3998Z2HDqd3KrUoJFw2Pj9
 r/D5j9clPazJSU1spJobD0SQCeylPUny2rpg6XAcYp2P2iv7fH9h3eizrOAHj0YIEYIG
 5fC+BNhX/Wdt8uCrBYmKQcsDt2xge42KNNn+6kQdSvJ65MqKRUmT8Ec5pzKK13Q3gpbO
 pNfw==
X-Gm-Message-State: AOJu0YxqxSLqvHufL3rIzldTuH1uTpwZwXn3TtJsle68sCuvKt4EwXkc
 m3jf3ulq5k/448MaaoamzFlPYNuKeNKUhx/WsioMh8TeyZb0qA==
X-Google-Smtp-Source: AGHT+IHeJ9Xe71DcdIlz3LvEPXgpOvz2abTQ7l6nGscFUpggD+UxlD2IgYYFMTu/fRQeGMAMQ0e5rA==
X-Received: by 2002:a05:6e02:2408:b0:35d:5995:7992 with SMTP id
 bs8-20020a056e02240800b0035d59957992mr22555504ilb.44.1703885067229; 
 Fri, 29 Dec 2023 13:24:27 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/71] target/ppc: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:49 +1100
Message-Id: <20231229212346.147149-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd33.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-15-richard.henderson@linaro.org>
---
 target/ppc/machine.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 68cbdffecd..203fe28e01 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -351,7 +351,7 @@ static const VMStateDescription vmstate_fpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fpu_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FPR_ARRAY(env.vsr, PowerPCCPU, 32),
         VMSTATE_UINTTL(env.fpscr, PowerPCCPU),
         VMSTATE_END_OF_LIST()
@@ -392,7 +392,7 @@ static const VMStateDescription vmstate_altivec = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = altivec_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_AVR_ARRAY(env.vsr, PowerPCCPU, 32),
         /*
          * Save the architecture value of the vscr, not the internally
@@ -425,7 +425,7 @@ static const VMStateDescription vmstate_vsx = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vsx_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VSR_ARRAY(env.vsr, PowerPCCPU, 32),
         VMSTATE_END_OF_LIST()
     },
@@ -445,7 +445,7 @@ static const VMStateDescription vmstate_tm = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tm_needed,
-    .fields      = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINTTL_ARRAY(env.tm_gpr, PowerPCCPU, 32),
         VMSTATE_AVR_ARRAY(env.tm_vsr, PowerPCCPU, 64),
         VMSTATE_UINT64(env.tm_cr, PowerPCCPU),
@@ -479,7 +479,7 @@ static const VMStateDescription vmstate_sr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = sr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.sr, PowerPCCPU, 32),
         VMSTATE_END_OF_LIST()
     },
@@ -553,7 +553,7 @@ static const VMStateDescription vmstate_slb = {
     .minimum_version_id = 1,
     .needed = slb_needed,
     .post_load = slb_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_TEST(mig_slb_nr, PowerPCCPU, cpu_pre_3_0_migration),
         VMSTATE_SLB_ARRAY(env.slb, PowerPCCPU, MAX_SLB_ENTRIES),
         VMSTATE_END_OF_LIST()
@@ -565,7 +565,7 @@ static const VMStateDescription vmstate_tlb6xx_entry = {
     .name = "cpu/tlb6xx_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(pte0, ppc6xx_tlb_t),
         VMSTATE_UINTTL(pte1, ppc6xx_tlb_t),
         VMSTATE_UINTTL(EPN, ppc6xx_tlb_t),
@@ -586,7 +586,7 @@ static const VMStateDescription vmstate_tlb6xx = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tlb6xx_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlb6, PowerPCCPU,
                                             env.nb_tlb,
@@ -601,7 +601,7 @@ static const VMStateDescription vmstate_tlbemb_entry = {
     .name = "cpu/tlbemb_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(RPN, ppcemb_tlb_t),
         VMSTATE_UINTTL(EPN, ppcemb_tlb_t),
         VMSTATE_UINTTL(PID, ppcemb_tlb_t),
@@ -625,7 +625,7 @@ static const VMStateDescription vmstate_tlbemb = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tlbemb_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlbe, PowerPCCPU,
                                             env.nb_tlb,
@@ -639,7 +639,7 @@ static const VMStateDescription vmstate_tlbmas_entry = {
     .name = "cpu/tlbmas_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(mas8, ppcmas_tlb_t),
         VMSTATE_UINT32(mas1, ppcmas_tlb_t),
         VMSTATE_UINT64(mas2, ppcmas_tlb_t),
@@ -661,7 +661,7 @@ static const VMStateDescription vmstate_tlbmas = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tlbmas_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlbm, PowerPCCPU,
                                             env.nb_tlb,
@@ -684,7 +684,7 @@ static const VMStateDescription vmstate_compat = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = compat_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(compat_pvr, PowerPCCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -700,7 +700,7 @@ static const VMStateDescription vmstate_reservation = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = reservation_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
         VMSTATE_UINTTL(env.reserve_length, PowerPCCPU),
         VMSTATE_UINTTL(env.reserve_val, PowerPCCPU),
@@ -717,7 +717,7 @@ const VMStateDescription vmstate_ppc_cpu = {
     .minimum_version_id = 5,
     .pre_save = cpu_pre_save,
     .post_load = cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UNUSED(sizeof(target_ulong)), /* was _EQUAL(env.spr[SPR_PVR]) */
 
         /* User mode architected state */
@@ -748,7 +748,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         VMSTATE_UINT32_TEST(mig_nb_BATs, PowerPCCPU, cpu_pre_2_8_migration),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_fpu,
         &vmstate_altivec,
         &vmstate_vsx,
-- 
2.34.1


