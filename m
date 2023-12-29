Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6578201AB
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:27:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLE-0006xG-0L; Fri, 29 Dec 2023 16:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL7-0006vI-5H
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:21 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL5-0006Vz-HL
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:20 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so5597163a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885058; x=1704489858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WQ7Vx56bKbymYuLyooz5UOtSKpXbnXiz4KIzxIin+2g=;
 b=Ce9pOGectX4uZP2xhKzF/Q1ZuN3hrS4Kc6PjyccrImdoxFPXvRtZDP9w4lEsT6h6vq
 vKfDwRsF6cNJ5oEjOv/Q7NNXKs1nMYViOrSwR+DcrhP3NU6w9VIcAc4PWiy5g3KvU6VS
 H3VLOldGDJdnDHDh5OlBd5gIB3X970svWH9KeFWoPm0lr6L/OXupc5EgtlCSAXv/gGQB
 6aNt0J6JuAmHJr+HQTJdYy9JZ8yozyRWyIZiACOWP8p2WVfdLcKz1tJIbxxsWJ/q1D6v
 SuxfRSxasggwko/2IGkj1WkJHjzn+23kC160Dj3oxMQTGI5hqiLhHY7OzvN1C8hZOEDk
 hLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885058; x=1704489858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQ7Vx56bKbymYuLyooz5UOtSKpXbnXiz4KIzxIin+2g=;
 b=JAanHisFT5uq+LwVIVelbR039NY3QsRBoP+fSOt2Dm8GdYfIsr02C2lmZxJg2tbKIA
 xI0KTNi28xOY2HsQmtme5vI2zsmAtg7OFkoW9iz7Yri9E6caXfIIKdwg0FgcQxs1lkc6
 22vO+PHU1hNOLAT8GIC7KSt4q0N/bssw/QpVxSeszqA4xI1UDp67sJc3b9lyn/2UNH4L
 k4eIQ6fQ5Nj2kVh61t3B0igmLu51R2VML1soce7G4WHrQXjxP6lE3iZaW3rwx6FNHIfV
 4Lzbt7Xvl3c4XgC8K80VHwPv4NbZ0NUEMbFw+72Zy2GK937SVEwxfktRPcNkRk7X7F+8
 VQyg==
X-Gm-Message-State: AOJu0YyCROSZXRkQsP7xXVfxwfjoB8YEE38fH9tJBwiMBB0WbxT/3rF/
 eDwescKa7RFadyrYAU0ruGrS3vll/FvTZmw6/X/caZAsSu7leQ==
X-Google-Smtp-Source: AGHT+IEwjZo2ZrU0/TYxZ85h1Ty2CeFhsDB4i2O+DVuRtN4haDf5iU2vTEIvoDuYSL7S7/UD4++fjg==
X-Received: by 2002:a05:6a20:9708:b0:189:c46d:9790 with SMTP id
 hr8-20020a056a20970800b00189c46d9790mr12328790pzc.30.1703885058156; 
 Fri, 29 Dec 2023 13:24:18 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/71] target/m68k: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:45 +1100
Message-Id: <20231229212346.147149-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
Message-Id: <20231221031652.119827-11-richard.henderson@linaro.org>
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


