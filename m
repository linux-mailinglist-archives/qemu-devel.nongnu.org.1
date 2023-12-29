Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8E8201B9
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLL-000713-Kf; Fri, 29 Dec 2023 16:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLI-0006z3-R2
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:32 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLH-0006gH-1D
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:32 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d9e62ff056so2711576b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885070; x=1704489870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GagVqcPQHuKFmUNCXS0XsIJu0ULMlIKav1OQs/IsaFA=;
 b=V31xoIATCLbG1LdDwdi0xOYOug0PZZKqzSnfw65WCkxwif/10NTCiPNuFKHBW08dwa
 fdQE8hIIUFXZrSuNQJZUQgQzgE0q0xUaOW6Q+Us5HOdDFWk9S36zvuX2STo5eidomcGJ
 /qF/cu1DCvRnLdva0lcAvzOIHiBsNlczq30gsrFS5G4aT5+U+SXvSvVyzT6hrWmtDbq6
 JX0rXslF1A6sHtRSfXmOB6j2y1e9QUxHBTwvFu25abmpJayTC5rLVnMNJD4iKIxWD9Qk
 /oj2i2iYzErd2NNin5eH1/RJ3Bq6KJ7tb+K87z6BDhI3J9g0iyASvx/MIhtTcUylp2GR
 tboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885070; x=1704489870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GagVqcPQHuKFmUNCXS0XsIJu0ULMlIKav1OQs/IsaFA=;
 b=P8JfL3ZJSTbTSnuzpZbTmNb7GIsgBe6dzqUjw1ZEXlY2IXM26G+CkU8dZt6fjujtFe
 RtgbJC4x1hYYgg1gVPujPaZyhyVx/ypG54tptQNoVlMeBSWRTqAeLRAQVtEehCgUElex
 uT/bCR7iE55l8KRRUZIPkr32Cbk9vasOSPOxHiR2wQ9IBpuuhDCMXp7wr4DjNZ/h5i41
 Hz//bjxQjB/6OcfnTR2CIQeHOL2xbRHV0DsU+1fm3bfv4/s+iu7E7wYmCstvImNL9TRQ
 KmdM0WuRXqj6SX39tigeTEvXKvma+9P0DIn+0RjOrB+50wvMwQ5Xr6Aib5zGG5/UfrvU
 JUyA==
X-Gm-Message-State: AOJu0YyrktRPzl7N9Egqpw3fgo6Knky0DrccpYfyT9WeovEhGNBSGa2/
 qXTpT5yGMMXJGjx+WBE3KQQYyDMQE+D2fy5DSNU42YRKTVZ8LQ==
X-Google-Smtp-Source: AGHT+IEFE75U6koJ8ev1A4Wr7M7yucLqifrzhfHYl3lcSxxEkGjFHA8QnQJhncey3EiCrM8uLMw79g==
X-Received: by 2002:a05:6a21:1a0:b0:195:dad0:7185 with SMTP id
 le32-20020a056a2101a000b00195dad07185mr8403380pzb.96.1703885069735; 
 Fri, 29 Dec 2023 13:24:29 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/71] target/riscv: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:50 +1100
Message-Id: <20231229212346.147149-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-16-richard.henderson@linaro.org>
---
 target/riscv/machine.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index fdde243e04..72fe2374dc 100644
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
     .version_id = 3,
     .minimum_version_id = 3,
     .needed = hyper_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.hstatus, RISCVCPU),
         VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
         VMSTATE_UINT64(env.hideleg, RISCVCPU),
@@ -138,7 +138,7 @@ static const VMStateDescription vmstate_vector = {
     .version_id = 2,
     .minimum_version_id = 2,
     .needed = vector_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
         VMSTATE_UINTTL(env.vxrm, RISCVCPU),
         VMSTATE_UINTTL(env.vxsat, RISCVCPU),
@@ -163,7 +163,7 @@ static const VMStateDescription vmstate_pointermasking = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pointermasking_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.mmte, RISCVCPU),
         VMSTATE_UINTTL(env.mpmmask, RISCVCPU),
         VMSTATE_UINTTL(env.mpmbase, RISCVCPU),
@@ -189,7 +189,7 @@ static const VMStateDescription vmstate_rv128 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = rv128_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gprh, RISCVCPU, 32),
         VMSTATE_UINT64(env.mscratchh, RISCVCPU),
         VMSTATE_UINT64(env.sscratchh, RISCVCPU),
@@ -218,7 +218,7 @@ static const VMStateDescription vmstate_kvmtimer = {
     .minimum_version_id = 1,
     .needed = kvmtimer_needed,
     .post_load = cpu_kvmtimer_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.kvm_timer_time, RISCVCPU),
         VMSTATE_UINT64(env.kvm_timer_compare, RISCVCPU),
         VMSTATE_UINT64(env.kvm_timer_state, RISCVCPU),
@@ -252,7 +252,7 @@ static const VMStateDescription vmstate_debug = {
     .minimum_version_id = 2,
     .needed = debug_needed,
     .post_load = debug_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
         VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
@@ -283,7 +283,7 @@ static const VMStateDescription vmstate_smstateen = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = smstateen_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.mstateen, RISCVCPU, 4),
         VMSTATE_UINT64_ARRAY(env.hstateen, RISCVCPU, 4),
         VMSTATE_UINT64_ARRAY(env.sstateen, RISCVCPU, 4),
@@ -304,7 +304,7 @@ static const VMStateDescription vmstate_envcfg = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = envcfg_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.menvcfg, RISCVCPU),
         VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
         VMSTATE_UINT64(env.henvcfg, RISCVCPU),
@@ -324,7 +324,7 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmu_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
@@ -346,7 +346,7 @@ static const VMStateDescription vmstate_jvt = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = jvt_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.jvt, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
@@ -357,7 +357,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     .version_id = 9,
     .minimum_version_id = 9,
     .post_load = riscv_cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
         VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
         VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
@@ -411,7 +411,7 @@ const VMStateDescription vmstate_riscv_cpu = {
 
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_pmp,
         &vmstate_hyper,
         &vmstate_vector,
-- 
2.34.1


