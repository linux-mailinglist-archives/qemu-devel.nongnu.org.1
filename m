Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 170317E1AA3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:02:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZP-0004V5-Hi; Mon, 06 Nov 2023 01:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZM-0004T6-7Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:44 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZJ-0001OB-FI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:43 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso37339735ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253920; x=1699858720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vxw3QQRIQXYzolDfKpmpHblvCKZ/zXYizIMVhlat3k=;
 b=Y+eYMwEP9YfoUQPOUxAvVoFCeEUZyvXXGvcVy47M0EpxbZOx+8IWY3atLyH00bmScn
 P3xBeXynbbJsfKb9Vd4pgvPDgiXkgSVQzDA9oRJLw9avOV2tuWUFrHVljAjgG4ixcsn+
 CroF6ww++OuwrqpJvDMZLHkmAQr+rspb4nLt7E2ANcxuim+Kq5BgEBBQmEl7Jp/jeowW
 gJbRL5471no5RmMZFHU/67aOPiEAWAGsSE4yNw2O7fax2sEeqF/PyjW9VgdLD1lfIW5D
 nBDvUoy1iXX0HDBZOE21Ci+qfp1G2AnY8PQDLbQQOIzBIdH4/vGUXbBLeujDTttn08EX
 3XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253920; x=1699858720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vxw3QQRIQXYzolDfKpmpHblvCKZ/zXYizIMVhlat3k=;
 b=m0raHFH3ChhyZM/i/hp7P39Ar7tnPLXGzPTijFrYzc/FPSIvHtmnrWQ4/1z1Y23GNl
 W9cmyZ02cAiMbI8kikLs/5mPpS0aYLFB7WlD1YjjHb27jgcSRJiDWi9K/+PxNFF6Vt9D
 n10ELZM6ZAdbL/6P4CzwMFdNPmRDMYVhtZm8iZZAnjji6Q/aWgWoccUOBWMWu3xmh/dB
 T43w+44iZUSnJ329TT9z6tz77RM/1srHvi7DdIbV6R9d1DpKRmUZELBSLOMk9kMl1+49
 G1VJO/wRTc1uA4qUGbFwRkvqjK0vdVgcCvdM7EK6MFA4eacMQHVYny0kSQts9RcqhpAJ
 YW4Q==
X-Gm-Message-State: AOJu0YypWhOvqQXNNf9IFog0j7fD801YXr5ALxXS3Gk1jXlrJAE/Padq
 UfJQZCSgEQiRuAg+I0Iqcz8WXfr+bm5tYNO7zJo=
X-Google-Smtp-Source: AGHT+IEDgjDhd5Vs5O7d1R2cYsgEuFXvsrdvWutMe/+Cc2SJWuxjqN2v819Hz034m9P6mt5MTzI0cg==
X-Received: by 2002:a17:903:2303:b0:1cc:4fbe:9271 with SMTP id
 d3-20020a170903230300b001cc4fbe9271mr24881989plh.22.1699253920071; 
 Sun, 05 Nov 2023 22:58:40 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 12/71] target/mips: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:28 -0800
Message-Id: <20231106065827.543129-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/mips/sysemu/machine.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 80d37f9c2f..218f4c3a67 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -44,7 +44,7 @@ static int put_fpr(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-const VMStateInfo vmstate_info_fpr = {
+static const VMStateInfo vmstate_info_fpr = {
     .name = "fpr",
     .get  = get_fpr,
     .put  = put_fpr,
@@ -56,21 +56,21 @@ const VMStateInfo vmstate_info_fpr = {
 #define VMSTATE_FPR_ARRAY(_f, _s, _n)                           \
     VMSTATE_FPR_ARRAY_V(_f, _s, _n, 0)
 
-static VMStateField vmstate_fpu_fields[] = {
+static const VMStateField vmstate_fpu_fields[] = {
     VMSTATE_FPR_ARRAY(fpr, CPUMIPSFPUContext, 32),
     VMSTATE_UINT32(fcr0, CPUMIPSFPUContext),
     VMSTATE_UINT32(fcr31, CPUMIPSFPUContext),
     VMSTATE_END_OF_LIST()
 };
 
-const VMStateDescription vmstate_fpu = {
+static const VMStateDescription vmstate_fpu = {
     .name = "cpu/fpu",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = vmstate_fpu_fields
 };
 
-const VMStateDescription vmstate_inactive_fpu = {
+static const VMStateDescription vmstate_inactive_fpu = {
     .name = "cpu/inactive_fpu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -79,7 +79,7 @@ const VMStateDescription vmstate_inactive_fpu = {
 
 /* TC state */
 
-static VMStateField vmstate_tc_fields[] = {
+static const VMStateField vmstate_tc_fields[] = {
     VMSTATE_UINTTL_ARRAY(gpr, TCState, 32),
 #if defined(TARGET_MIPS64)
     VMSTATE_UINT64_ARRAY(gpr_hi, TCState, 32),
@@ -103,14 +103,14 @@ static VMStateField vmstate_tc_fields[] = {
     VMSTATE_END_OF_LIST()
 };
 
-const VMStateDescription vmstate_tc = {
+static const VMStateDescription vmstate_tc = {
     .name = "cpu/tc",
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = vmstate_tc_fields
 };
 
-const VMStateDescription vmstate_inactive_tc = {
+static const VMStateDescription vmstate_inactive_tc = {
     .name = "cpu/inactive_tc",
     .version_id = 2,
     .minimum_version_id = 2,
@@ -119,11 +119,11 @@ const VMStateDescription vmstate_inactive_tc = {
 
 /* MVP state */
 
-const VMStateDescription vmstate_mvp = {
+static const VMStateDescription vmstate_mvp = {
     .name = "cpu/mvp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(CP0_MVPControl, CPUMIPSMVPContext),
         VMSTATE_INT32(CP0_MVPConf0, CPUMIPSMVPContext),
         VMSTATE_INT32(CP0_MVPConf1, CPUMIPSMVPContext),
@@ -190,7 +190,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-const VMStateInfo vmstate_info_tlb = {
+static const VMStateInfo vmstate_info_tlb = {
     .name = "tlb_entry",
     .get  = get_tlb,
     .put  = put_tlb,
@@ -202,11 +202,11 @@ const VMStateInfo vmstate_info_tlb = {
 #define VMSTATE_TLB_ARRAY(_f, _s, _n)                           \
     VMSTATE_TLB_ARRAY_V(_f, _s, _n, 0)
 
-const VMStateDescription vmstate_tlb = {
+static const VMStateDescription vmstate_tlb = {
     .name = "cpu/tlb",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(nb_tlb, CPUMIPSTLBContext),
         VMSTATE_UINT32(tlb_in_use, CPUMIPSTLBContext),
         VMSTATE_TLB_ARRAY(mmu.r4k.tlb, CPUMIPSTLBContext, MIPS_TLB_MAX),
@@ -221,7 +221,7 @@ const VMStateDescription vmstate_mips_cpu = {
     .version_id = 21,
     .minimum_version_id = 21,
     .post_load = cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* Active TC */
         VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1, vmstate_tc, TCState),
 
-- 
2.34.1


