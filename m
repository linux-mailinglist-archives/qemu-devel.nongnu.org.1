Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D005D81AD43
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:22:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Zh-0007ao-4t; Wed, 20 Dec 2023 22:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zf-0007aV-HD
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:15 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zd-0003pH-Tc
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:15 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7811b05d23bso20297285a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128692; x=1703733492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vhaDOlXqK723HSaocfjU1ZCevxhmhF4yuGDJMeM3d5I=;
 b=jL5AfgEm4k7OiY/+dVcslWF1V5eGUuFBSJIxs+f8UCAsYTpxT4sHITiRxqP54ngi69
 cRiQBIfeN6BB8ar3qMZ7Q/fii8dhSdRumKgiWAlfbeKBs+9pf5XT3kgKJXQfQvdESTGD
 uLR5NNEoDCZWx58niRf6O6JQ76+0bj7fvTkqSO1FnurHwiaiIBg6A2u5+8CRXp6o1AG0
 KMkTBV+6psiNJfnutI+E4dPIFYPhJjmccHIpg9Wg/ju5gbEBIoKT3y8wzuaxa6vrKk8B
 DHZjH/dlmpQcs2rhRIH5PHLHjWcvI2zF2z8UGhxHK/OaXciOUbJkjD474qIytz/sRwOm
 Hf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128692; x=1703733492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhaDOlXqK723HSaocfjU1ZCevxhmhF4yuGDJMeM3d5I=;
 b=LSEWUSPqRbyX+C1ca4ffnP6u8NFAWttVj8eH+VnWxharBkHGZBEr9Frjo2XzPjsFc3
 MJGkvBUJIirNOH5JcINqzqUT9HISDcdPjWiQDY7RRjvKNbo45rtaTeeIsKqLfsm+5v+G
 Lsd3ZbUTEhkNWRbx2ft6xnizbdSIXFn+NebhlsoR3Qh7lpUvndLhIiRdcQpcPf4koU8b
 OGeFW457xK92ssDLizJ0REOeHsQkwubkon9ViqtFbSF+elV1mS1VBd6YlZE+2qvxm12o
 8nwkpUvMHg4IMG2ssxQuVv7x2MfgFxIaaLUgITqU8OGs0m7C1N0EZlUolCUNE+5IVgR/
 7xgw==
X-Gm-Message-State: AOJu0YzG9SYAETz63v2xXtFb54pjSXOPGH9Ju+g+//UGoKeD80BZcxxA
 bMee3Nk7sFi2vFeXEDnDzqTTMJ3AnbIYMFEJ7xsEbs7M
X-Google-Smtp-Source: AGHT+IEytkLvltHz6xQehqzpm6q6tVlu/5YcMSTgihNWxGuSpmRP3Cq9vopZdjfh9Tuhm2TUwtb0GQ==
X-Received: by 2002:a05:620a:31a7:b0:77f:5694:a03 with SMTP id
 bi39-20020a05620a31a700b0077f56940a03mr26876561qkb.111.1703128692095; 
 Wed, 20 Dec 2023 19:18:12 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/71] target/s390x: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:57 +1100
Message-Id: <20231221031652.119827-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
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
 target/s390x/machine.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 37a076858c..a125ebcc2f 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -66,7 +66,7 @@ static const VMStateDescription vmstate_fpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fpu_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.vregs[0][0], S390CPU),
         VMSTATE_UINT64(env.vregs[1][0], S390CPU),
         VMSTATE_UINT64(env.vregs[2][0], S390CPU),
@@ -98,7 +98,7 @@ static const VMStateDescription vmstate_vregs = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vregs_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* vregs[0][0] -> vregs[15][0] and fregs are overlays */
         VMSTATE_UINT64(env.vregs[16][0], S390CPU),
         VMSTATE_UINT64(env.vregs[17][0], S390CPU),
@@ -157,12 +157,12 @@ static bool riccb_needed(void *opaque)
     return s390_has_feat(S390_FEAT_RUNTIME_INSTRUMENTATION);
 }
 
-const VMStateDescription vmstate_riccb = {
+static const VMStateDescription vmstate_riccb = {
     .name = "cpu/riccb",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = riccb_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(env.riccb, S390CPU, 64),
         VMSTATE_END_OF_LIST()
     }
@@ -174,12 +174,12 @@ static bool exval_needed(void *opaque)
     return cpu->env.ex_value != 0;
 }
 
-const VMStateDescription vmstate_exval = {
+static const VMStateDescription vmstate_exval = {
     .name = "cpu/exval",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = exval_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.ex_value, S390CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -190,12 +190,12 @@ static bool gscb_needed(void *opaque)
     return s390_has_feat(S390_FEAT_GUARDED_STORAGE);
 }
 
-const VMStateDescription vmstate_gscb = {
+static const VMStateDescription vmstate_gscb = {
     .name = "cpu/gscb",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = gscb_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.gscb, S390CPU, 4),
         VMSTATE_END_OF_LIST()
         }
@@ -206,12 +206,12 @@ static bool bpbc_needed(void *opaque)
     return s390_has_feat(S390_FEAT_BPB);
 }
 
-const VMStateDescription vmstate_bpbc = {
+static const VMStateDescription vmstate_bpbc = {
     .name = "cpu/bpbc",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = bpbc_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(env.bpbc, S390CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -222,12 +222,12 @@ static bool etoken_needed(void *opaque)
     return s390_has_feat(S390_FEAT_ETOKEN);
 }
 
-const VMStateDescription vmstate_etoken = {
+static const VMStateDescription vmstate_etoken = {
     .name = "cpu/etoken",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = etoken_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.etoken, S390CPU),
         VMSTATE_UINT64(env.etoken_extension, S390CPU),
         VMSTATE_END_OF_LIST()
@@ -239,12 +239,12 @@ static bool diag318_needed(void *opaque)
     return s390_has_feat(S390_FEAT_DIAG_318);
 }
 
-const VMStateDescription vmstate_diag318 = {
+static const VMStateDescription vmstate_diag318 = {
     .name = "cpu/diag318",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = diag318_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.diag318_info, S390CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -256,7 +256,7 @@ const VMStateDescription vmstate_s390_cpu = {
     .pre_save = cpu_pre_save,
     .version_id = 4,
     .minimum_version_id = 3,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.regs, S390CPU, 16),
         VMSTATE_UINT64(env.psw.mask, S390CPU),
         VMSTATE_UINT64(env.psw.addr, S390CPU),
@@ -278,7 +278,7 @@ const VMStateDescription vmstate_s390_cpu = {
                                irqstate_saved_size),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_fpu,
         &vmstate_vregs,
         &vmstate_riccb,
-- 
2.34.1


