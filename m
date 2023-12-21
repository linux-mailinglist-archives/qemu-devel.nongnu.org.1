Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEA881AD50
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ZZ-0007Zh-Gh; Wed, 20 Dec 2023 22:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZW-0007ZE-GK
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:06 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZU-0003oQ-Sj
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:06 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4277c62426fso2094581cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128684; x=1703733484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tZPH2y1KO8uR39WCd+rQ9lAEFPGwLvdCGkkP4HG2r4A=;
 b=ZqEfCWEgHr6dOhyiVSmC46VV+hBJ9YXfzncDgCuJtlceHRaGm3mJaWSvwQO4/yEeD0
 yJq+1VYDMofAbiK8/+e0q+12ESLW6zlhh6PZ7OG59SUyyxLpZzHSlyfl66aHWul1zQmd
 3YgcvzohVi2erlt+5snGPp+KXUANkmrXFwVDLLgO9w1Iy2Ps2qfbnr8vQ64xw5HXRIQQ
 lJJjMYFR5NGHeojbMD7hAxL0Lx067cVWWf6mOt2kxaZ/GAqutca/u/bqjuaJMAhMDYQJ
 tkq7PbnmPkjxRD6/DA3Pn2i2UbkVJC5ghe2fDr3EtcZZwxtjM2qTXUY5h5pRcKQmVyKz
 GNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128684; x=1703733484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZPH2y1KO8uR39WCd+rQ9lAEFPGwLvdCGkkP4HG2r4A=;
 b=MLb5wpLj76GBrkC7VuwEDE5mlaPlFDWZw6VuOGRdLDbMR7y+BGRBRYRCS0giYDglaZ
 WhgB47Y4+6/Xd6HfMXEfCxOVCeMF1llfxop0Fj6OFWL2OLr4kH05EL50BBUZz4MkY/Tt
 mhnzJiOALcI1aM6h3OfVNWbfvmpQ6fdQBo/XVMKh/ck27tTQ67sqyXri5F2Cf5wuy2Lr
 kgSHnbPtfZ0iVx2fg3tRm2srKD6sCt6EhDkYiAs8RciEylIiBl4lC1qwatRVbHhuk2Su
 uxrwpAT8Cn3gYMq4PpMMuv8OC6oI2ntQdVCx9PztYhqj6MZ+hTYiSGsxg7o4tNwd47fp
 hc8w==
X-Gm-Message-State: AOJu0YzoJrMGNQu1pz9hSI2fSPHu/Ix59LdVGzOLMMeLQFUVZqp6qEhU
 8+ER97d0UZY79J+4NHk7tv94kwJ6AE5+bURT/mFCe4ST
X-Google-Smtp-Source: AGHT+IGCOwfk+/MyQQviwPpQA25Y26wbYCglwv/U6EyxAROAV77hs7WZOWu4cycv7sm8rLFC17LnCQ==
X-Received: by 2002:ac8:5703:0:b0:425:9a56:9fe with SMTP id
 3-20020ac85703000000b004259a5609femr27912288qtw.79.1703128683987; 
 Wed, 20 Dec 2023 19:18:03 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/71] target/ppc: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:55 +1100
Message-Id: <20231221031652.119827-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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


