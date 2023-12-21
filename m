Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A981AD5E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Ze-0007aP-JS; Wed, 20 Dec 2023 22:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zc-0007Zy-5r
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:12 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZZ-0003oj-RB
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:11 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7811548d0b7so16364085a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128688; x=1703733488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/NT/YE7spb3oCGefAs+uhAEps1MxIK78/n+Fb9MdnI=;
 b=qGQDpArgrqj6ZPjxTeNZ0lOQMWIGTUGyPyA0T4e74F7GzLJ6FitwbfgBUxA2IbETju
 FNA5FoAf2lzJbHOa6DbPhCh7U/Up48flIhyQJG6n+ydwZeS9PWYjTdPKecKyNFahR9Sa
 AxJAaAPqwY4/ilSZFV35+ft7bJLljbOi08uU54l6t/VVwp79HI8s3KbZijdjKRviValW
 /JUHjo/fuTbd8dOX8fEgDHH7vip72MjcLVc9q7haajBmstG05RuF/I4GvIsd2aSwKFRY
 kREbEpYUhzcLHiTnN3dddCZpAKS3HcJsXRBEsQnZtnuQyEo/E4G2Wx+OzMGw02mwi1hE
 YJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128688; x=1703733488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/NT/YE7spb3oCGefAs+uhAEps1MxIK78/n+Fb9MdnI=;
 b=SHJi4C2Lkfq5C6AnGb6sGhrgLHQoulJhla5VRJJPUP34hzjPAusQXLNEsllA7qdAPQ
 V1Fe5WEI8dN8utXbJrOTLWM8q+0hoyVDHVRpjxfQmQHU1mzMLPADF/GiDQzMbyjsNxMo
 MqdgIaZrU001/yh8B1dVE3/BB7UR5zCAlOA5uVVWPCYzuguo0hZE/4xS0KMw7LSMeE1u
 mnkuDYVutadmBrXRPyQVwPzjgUeXsIiiuA99IniLsAcSTD1iI+Nhg+JIhuogDiEccY+Y
 DxhCyKnILX4dTmj9iwgaejs2UBM6ugev3WeWRf2/mmxuKMklHpIyf0r3ka2TwpNI+URB
 KYZg==
X-Gm-Message-State: AOJu0YwsvADAY59GuLNfHZ9P9HJzlrND+GxAH1K7zY6nlOukHUs10zQV
 hz+kcmHt48qnQJC2SlnIQYEH4JKdVJ+0/1QAsK9TsHda
X-Google-Smtp-Source: AGHT+IGy/QGP8Ir3PXFz2H5CBKWy1iiTzzYL9Q19mw4eyPwVAk3sOttGKno1gilMPCPRmFIsJsqexw==
X-Received: by 2002:a05:620a:3847:b0:77f:2496:1016 with SMTP id
 po7-20020a05620a384700b0077f24961016mr18515367qkn.113.1703128688120; 
 Wed, 20 Dec 2023 19:18:08 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 15/71] target/riscv: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:56 +1100
Message-Id: <20231221031652.119827-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72d.google.com
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


