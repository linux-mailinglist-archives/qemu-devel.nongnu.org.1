Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698517E1ACB
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:11:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZV-0004Vs-L7; Mon, 06 Nov 2023 01:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZN-0004Ur-Uj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:46 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZM-0001OT-4v
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:45 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso37339875ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253921; x=1699858721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZPH2y1KO8uR39WCd+rQ9lAEFPGwLvdCGkkP4HG2r4A=;
 b=LY0+UP/RQ+Q2B876fIoEHLKLcy7rpJf3P2mKZWMPpLdc7Mk3XSTvIDbbcyk4y88Goi
 pinQzVLk+bRhi4Z7lYDEJAikqZdysB6dNdOCFzYA0IgASHY8ygdQ4Zy/ai+JQiYZIoNj
 xkt3irKO5bv+rUjilhuEqYlYhEzLgPNUHkJbestN019R7SNG0+Um2u9Ya8SCVPrOK0em
 EWhWEJqvKgWqJ5QooPp3NIij1tOuM/CvOWiPWkPpRSoUN3FswIVIcSCeWiNzZizN1crP
 UYWDiO24y3q9K8dBSo3pWW/a4afZlqvCwlRh8hZCi3fLscJjVHcKBcMxBMweWzFAKSa/
 lH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253921; x=1699858721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZPH2y1KO8uR39WCd+rQ9lAEFPGwLvdCGkkP4HG2r4A=;
 b=EkROOFE/npYdnXHXPYnVzGSXLuF4qUGw4uKxHt884bIGwfdwtOXK3HEG6O+ZMgDRoL
 uI3wFTsruJiJlAZtgjqWHC2xPapJ2mx1eUo3BJTrhwWgDb7N1KOqVZbQeJ6uJJunou0g
 50NE6NpMpY6JA/jzPJzXRNDRjhSfz8iB6ZdEzs04A6TmRNmZeGg2lP1sopwXhiiSxlmU
 EofyHTVkKCsVbfogdpdrHNc1Uj5Fz2CN8itf3L2A3YWqeqGc8n1r047frB0/ho7KCYlS
 tOn81ES+NUaoSvzVAe9S7XRNfht0B1Mmkm52J6dnEjPFc76JN6y4xIuhvgk6dNTaeHsf
 AZPg==
X-Gm-Message-State: AOJu0YxsuXaHHy/FeqJVs5M1Y5I4ZtkuFOkqAZA23MCpSnPyXQDUh8cp
 jS0QQy3WM4tsOfdtO0i0+d2BXn3tINvn0UWxxPg=
X-Google-Smtp-Source: AGHT+IEL5pHpw3OuymQBfeyuZxVNg7Sull0cB4C0YuN7CBZGjow0thYwEUqoK28yCBMlIb6uB62inw==
X-Received: by 2002:a17:902:c451:b0:1cc:2ed0:5ab1 with SMTP id
 m17-20020a170902c45100b001cc2ed05ab1mr21685572plm.17.1699253921696; 
 Sun, 05 Nov 2023 22:58:41 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 14/71] target/ppc: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:30 -0800
Message-Id: <20231106065827.543129-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


