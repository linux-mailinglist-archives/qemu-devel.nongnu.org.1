Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453607E1AF4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZZ-0004XL-2U; Mon, 06 Nov 2023 01:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZN-0004UI-DY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:45 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZL-0001OV-M6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:45 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5b97ca78da8so2678933a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253922; x=1699858722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PhUC+9kvh84R2fbWfuNd1Ay5hqcHoYqA4DGopSo4Pk=;
 b=eAyAlVgZhPZl0fsMM8xsZSSvJb86JXFrh8cLWg3xqVwPkC1nGpJUwh8i98XZddCxcP
 tUjBtA79ppJBFcd8hgO0WAf3sFImX/D4UEFXgmAuFqJZMAYt8+bRH4kmS//L3jNbyGdh
 7mmoYVPxubqQt1ofcxnln6sjvvCbaZIt+3jnvmhYo0LXTEWPWZk2kRznZJg6/d6JNPJL
 Kzgjbx4VGUKKChI3mZzK+IFq6AcnOeD2xgLtTELC/muJeFCsrI9OeZy9oOGEOkISjFSM
 48UgzDHndXuB2T8zZ72XfCckgWmr+rzKfeq5tq3EMuyXEPVLamYJfRrfUoAXprvI/UZz
 1a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253922; x=1699858722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PhUC+9kvh84R2fbWfuNd1Ay5hqcHoYqA4DGopSo4Pk=;
 b=HP6E+1A2BSo9x1QlmzFn/wbcgGit55yW3BU3XSfO9Sv6bhUktZVfRKHToD157k4U6X
 X/TFTctsxf1JhD1NLkR7DX0G7fPMuE+UseOGOs7Ub+odDyScF/XYV4Ov4zTi1NILaoED
 pcbClqnDT0uAupwQnqSVNBFj1nLL+FZr4WhIPM0GsdkjStDOmH23ry+vRNFRv/vPR1it
 zbi8Gu9pcC03+daZ1jgLYJg03ibcw6DZelcAW0o6Kk+/Q5wx1/Y61p7c5KX8N0JljL5b
 JD3zjO7x4oQXyj8ABGxG7XmJTNg3o8cADreyWBZThh2QYfyD5FG9KtZqcsmE+RXCEEry
 nflw==
X-Gm-Message-State: AOJu0YyGabBYuW2905Tn6zAivdZmdMSacMVO2yvLuo4ubkP+2wLKCCxW
 fNqwXWOHeH3vkktNTNuXLYSjGyJ42B2KD06+7HI=
X-Google-Smtp-Source: AGHT+IFi0Eow7VHiWTJm+o7XPOfEHzQK2iWkCtoMqHTUEMGpIdSqyKBkdVs9Rf7y5L8TN3AkfwksNw==
X-Received: by 2002:a05:6a21:32aa:b0:15f:b5:bfee with SMTP id
 yt42-20020a056a2132aa00b0015f00b5bfeemr27173650pzb.5.1699253922405; 
 Sun, 05 Nov 2023 22:58:42 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 15/71] target/riscv: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:31 -0800
Message-Id: <20231106065827.543129-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
---
 target/riscv/machine.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c7c862cdd3..7d857f479b 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -49,7 +49,7 @@ static const VMStateDescription vmstate_pmp_entry = {
     .name = "cpu/pmp/entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(addr_reg, pmp_entry_t),
         VMSTATE_UINT8(cfg_reg, pmp_entry_t),
         VMSTATE_END_OF_LIST()
@@ -62,7 +62,7 @@ static const VMStateDescription vmstate_pmp = {
     .minimum_version_id = 1,
     .needed = pmp_needed,
     .post_load = pmp_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(env.pmp_state.pmp, RISCVCPU, MAX_RISCV_PMPS,
                              0, vmstate_pmp_entry, pmp_entry_t),
         VMSTATE_END_OF_LIST()
@@ -82,7 +82,7 @@ static const VMStateDescription vmstate_hyper = {
     .version_id = 2,
     .minimum_version_id = 2,
     .needed = hyper_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.hstatus, RISCVCPU),
         VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
         VMSTATE_UINT64(env.hideleg, RISCVCPU),
@@ -135,7 +135,7 @@ static const VMStateDescription vmstate_vector = {
     .version_id = 2,
     .minimum_version_id = 2,
     .needed = vector_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
         VMSTATE_UINTTL(env.vxrm, RISCVCPU),
         VMSTATE_UINTTL(env.vxsat, RISCVCPU),
@@ -160,7 +160,7 @@ static const VMStateDescription vmstate_pointermasking = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pointermasking_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.mmte, RISCVCPU),
         VMSTATE_UINTTL(env.mpmmask, RISCVCPU),
         VMSTATE_UINTTL(env.mpmbase, RISCVCPU),
@@ -186,7 +186,7 @@ static const VMStateDescription vmstate_rv128 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = rv128_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gprh, RISCVCPU, 32),
         VMSTATE_UINT64(env.mscratchh, RISCVCPU),
         VMSTATE_UINT64(env.sscratchh, RISCVCPU),
@@ -215,7 +215,7 @@ static const VMStateDescription vmstate_kvmtimer = {
     .minimum_version_id = 1,
     .needed = kvmtimer_needed,
     .post_load = cpu_kvmtimer_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.kvm_timer_time, RISCVCPU),
         VMSTATE_UINT64(env.kvm_timer_compare, RISCVCPU),
         VMSTATE_UINT64(env.kvm_timer_state, RISCVCPU),
@@ -249,7 +249,7 @@ static const VMStateDescription vmstate_debug = {
     .minimum_version_id = 2,
     .needed = debug_needed,
     .post_load = debug_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
         VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
@@ -280,7 +280,7 @@ static const VMStateDescription vmstate_smstateen = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = smstateen_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.mstateen, RISCVCPU, 4),
         VMSTATE_UINT64_ARRAY(env.hstateen, RISCVCPU, 4),
         VMSTATE_UINT64_ARRAY(env.sstateen, RISCVCPU, 4),
@@ -301,7 +301,7 @@ static const VMStateDescription vmstate_envcfg = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = envcfg_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.menvcfg, RISCVCPU),
         VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
         VMSTATE_UINT64(env.henvcfg, RISCVCPU),
@@ -321,7 +321,7 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmu_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
@@ -343,7 +343,7 @@ static const VMStateDescription vmstate_jvt = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = jvt_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.jvt, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -354,7 +354,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     .version_id = 8,
     .minimum_version_id = 8,
     .post_load = riscv_cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
         VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
         VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
@@ -405,7 +405,7 @@ const VMStateDescription vmstate_riscv_cpu = {
 
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_pmp,
         &vmstate_hyper,
         &vmstate_vector,
-- 
2.34.1


