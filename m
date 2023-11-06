Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDB7E1AD9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:13:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZZ-0004Xz-OU; Mon, 06 Nov 2023 01:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZR-0004Vt-29
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:49 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZH-0001Nt-1O
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:48 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso4297587b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253917; x=1699858717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMPR6TTrX6GWl8h7/aL4Gqc3rWTo5f01ao2+3Bn7sJs=;
 b=ovu/Cnre9HgQloUfqPrlpgojo6n7QFGweY1DFWAFE2ASN+3nGkZKZtlHtwQ5VxyNlF
 o9BcUqL3xn6ldrSjZYmv1pzosUD+iskVaGK6iAkxXTUAiaTEOb+wKuv7iIzYxhaDjHKr
 qVXmxjNOwBz53IeMDLCnhRqORhn5LejtR1KWY2+Ljs4mI+PlPXoJunjhPQabQEzNKaIr
 bUfjMtq4o0cGYDuX3dS51hKA5i0EKTUKn1SVN4x+gLg4xplcz2a09ii7rKfBI4V+ZH8y
 7OfB+jpxAXP6uARDRy8Vg/KHIha1hApVx0cKisn5EgtaORpnUNl7ldxTQu04p8h1Tbrd
 igpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253917; x=1699858717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMPR6TTrX6GWl8h7/aL4Gqc3rWTo5f01ao2+3Bn7sJs=;
 b=Tq9zXhFcc23+fNdyxq/eyRO8Ku7IYqcswIu2cLwReTDZoLWcnPApWuyepaeaTmCAQO
 nOz53wch68MgquMIyqkTKB+TI3OIDLLgwE0UcZesBH/hiEwv2mamvSYPuIvxYg6t87tf
 gFwlmBrTLHYd6OcaspoMiWe9b+eMlG0XJsRzzfF+0ROpaEIO85Q1qmcPzGU6urPBSaxz
 gKG1N9jnLsD2YWib9Xt4QikmBK9brP14o4ZItuWwT0ultRGGPKv4umfddbqqKgL9M/q3
 8a0EF6vcm7qtZbXni/YLKb5mDpUyKyMFq7jocQ0AyU+vQEyPPZskDCsqOJZq5sl2zJII
 Q6Cw==
X-Gm-Message-State: AOJu0YxIi8N68vVfZ38moJy9v6+VYmoj58TSyL7S14kNlNWsQOig0Xkb
 EfBabBNUYja/vEiVgIfWRWjTVeWLTElSFoKFyAQ=
X-Google-Smtp-Source: AGHT+IGg0soIeilPs8q9zM1B946kcyUCbCvxjqTtJSNedHzXYYes0+vh2P7U9DM9Lsl2+n7r/vur5w==
X-Received: by 2002:a05:6a21:99a4:b0:181:9b30:89d6 with SMTP id
 ve36-20020a056a2199a400b001819b3089d6mr13801489pzb.27.1699253917705; 
 Sun, 05 Nov 2023 22:58:37 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 10/71] target/m68k: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:26 -0800
Message-Id: <20231106065827.543129-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 538d9473c2..63b40de762 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -382,7 +382,7 @@ static const VMStateDescription vmstate_freg_tmp = {
     .name = "freg_tmp",
     .post_load = freg_post_load,
     .pre_save  = freg_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tmp_mant, m68k_FPReg_tmp),
         VMSTATE_UINT16(tmp_exp, m68k_FPReg_tmp),
         VMSTATE_END_OF_LIST()
@@ -391,7 +391,7 @@ static const VMStateDescription vmstate_freg_tmp = {
 
 static const VMStateDescription vmstate_freg = {
     .name = "freg",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP(FPReg, m68k_FPReg_tmp, vmstate_freg_tmp),
         VMSTATE_END_OF_LIST()
     }
@@ -412,7 +412,7 @@ const VMStateDescription vmmstate_fpu = {
     .minimum_version_id = 1,
     .needed = fpu_needed,
     .post_load = fpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.fpcr, M68kCPU),
         VMSTATE_UINT32(env.fpsr, M68kCPU),
         VMSTATE_STRUCT_ARRAY(env.fregs, M68kCPU, 8, 0, vmstate_freg, FPReg),
@@ -433,7 +433,7 @@ const VMStateDescription vmstate_cf_spregs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cf_spregs_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.macc, M68kCPU, 4),
         VMSTATE_UINT32(env.macsr, M68kCPU),
         VMSTATE_UINT32(env.mac_mask, M68kCPU),
@@ -455,7 +455,7 @@ const VMStateDescription vmstate_68040_mmu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpu_68040_mmu_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.mmu.ar, M68kCPU),
         VMSTATE_UINT32(env.mmu.ssw, M68kCPU),
         VMSTATE_UINT16(env.mmu.tcr, M68kCPU),
@@ -480,7 +480,7 @@ const VMStateDescription vmstate_68040_spregs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpu_68040_spregs_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.vbr, M68kCPU),
         VMSTATE_UINT32(env.cacr, M68kCPU),
         VMSTATE_UINT32(env.sfc, M68kCPU),
@@ -493,7 +493,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.dregs, M68kCPU, 8),
         VMSTATE_UINT32_ARRAY(env.aregs, M68kCPU, 8),
         VMSTATE_UINT32(env.pc, M68kCPU),
@@ -510,7 +510,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
         VMSTATE_INT32(env.pending_level, M68kCPU),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmmstate_fpu,
         &vmstate_cf_spregs,
         &vmstate_68040_mmu,
-- 
2.34.1


