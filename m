Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6681AD62
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ZL-0007Tb-HG; Wed, 20 Dec 2023 22:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZJ-0007Su-6f
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:53 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZG-0003lN-Ih
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:51 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-781161d18ecso19280485a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128669; x=1703733469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f07Tp+0mYV+bULmieTe4MG0b2eAMCRT0j+8uQBbiafk=;
 b=j32/K7FqinfT3CBnSXe3fknv1JY8QOZx/VzMveqmZR/yYO0i4PUzFx1H0gQYfSJwoA
 xSngrPUmDq42BWvQ4K/1LB63/9RQMIitRGiSZKIInue5MIjN7Ficmab14i/CUXpE2SHl
 t1LvvH/AVWGGnG6SPfGGbnJcL152hkrapUJYN2ist52+avsWv4aQsdPIk8AJD+/wST1H
 LmerI7O59ud9XY6uIWh73TT4IXIvdQPIhthgdtpEEyrwgv4jM5LtVYJS9qMzNzZg/gfD
 2lfVmDKiXIytbNll8+PCk6ZN/3hpXjhyp84EZai0NrMeUXaTF4a8sh0GpTfKqu4BdiZ3
 55YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128669; x=1703733469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f07Tp+0mYV+bULmieTe4MG0b2eAMCRT0j+8uQBbiafk=;
 b=ciOh2zcuYkEXa2MbWpW4unBXcR62DN13wDaWnyzvbdiJB8R9rLhLJ6h/fVxXtVleCP
 L4NOkqS4Mv3sVAtwmpeyP85CV7Q+KiOulgl2VDxW46TISGSBB4eL1f2bQbqncQX5vD+6
 kqM3RM8YAqtNFcyWSEeVbwg/CSKrQBpaoGE/rqDx/wP4FB0P5uT3pKxCq5WjUbCSZDbs
 KrW+jB4EgBxWS/dgkaENa1Hrw+fj7yDiHtolNcZvD0XGKDy3ZA5j23mSugJ5Lrpx9e+M
 D/VQesYRjGC8FqSyIQG67UX3NoNayvICHXm/EubyUUTkhViBbEkfO7+MWqi4Jn5Tr3V8
 8Fww==
X-Gm-Message-State: AOJu0YwrEBJmzQ4LpuGvZnlyetcIMnVJ7XWbRkPqAhKaDSRhpv8UaGxh
 fm3eZjmybUOd7bRfvc4zFo2aScyenics8+i/AEmLBGEV
X-Google-Smtp-Source: AGHT+IHOJF1v/b3xOpAvDpeM6Gs32UtmLID6o7CdKSTBxvPbHR/SWOMaUZEFJL0WWukd0E0/Gj0D7w==
X-Received: by 2002:a05:620a:100a:b0:77f:2f19:27a5 with SMTP id
 z10-20020a05620a100a00b0077f2f1927a5mr24127668qkj.84.1703128669666; 
 Wed, 20 Dec 2023 19:17:49 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/71] target/m68k: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:51 +1100
Message-Id: <20231221031652.119827-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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
index 11c7e0a790..43b1bde21c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -381,7 +381,7 @@ static const VMStateDescription vmstate_freg_tmp = {
     .name = "freg_tmp",
     .post_load = freg_post_load,
     .pre_save  = freg_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tmp_mant, m68k_FPReg_tmp),
         VMSTATE_UINT16(tmp_exp, m68k_FPReg_tmp),
         VMSTATE_END_OF_LIST()
@@ -390,7 +390,7 @@ static const VMStateDescription vmstate_freg_tmp = {
 
 static const VMStateDescription vmstate_freg = {
     .name = "freg",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP(FPReg, m68k_FPReg_tmp, vmstate_freg_tmp),
         VMSTATE_END_OF_LIST()
     }
@@ -411,7 +411,7 @@ const VMStateDescription vmmstate_fpu = {
     .minimum_version_id = 1,
     .needed = fpu_needed,
     .post_load = fpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.fpcr, M68kCPU),
         VMSTATE_UINT32(env.fpsr, M68kCPU),
         VMSTATE_STRUCT_ARRAY(env.fregs, M68kCPU, 8, 0, vmstate_freg, FPReg),
@@ -432,7 +432,7 @@ const VMStateDescription vmstate_cf_spregs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cf_spregs_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.macc, M68kCPU, 4),
         VMSTATE_UINT32(env.macsr, M68kCPU),
         VMSTATE_UINT32(env.mac_mask, M68kCPU),
@@ -454,7 +454,7 @@ const VMStateDescription vmstate_68040_mmu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpu_68040_mmu_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.mmu.ar, M68kCPU),
         VMSTATE_UINT32(env.mmu.ssw, M68kCPU),
         VMSTATE_UINT16(env.mmu.tcr, M68kCPU),
@@ -479,7 +479,7 @@ const VMStateDescription vmstate_68040_spregs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpu_68040_spregs_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.vbr, M68kCPU),
         VMSTATE_UINT32(env.cacr, M68kCPU),
         VMSTATE_UINT32(env.sfc, M68kCPU),
@@ -492,7 +492,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.dregs, M68kCPU, 8),
         VMSTATE_UINT32_ARRAY(env.aregs, M68kCPU, 8),
         VMSTATE_UINT32(env.pc, M68kCPU),
@@ -509,7 +509,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
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


