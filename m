Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 122227E1A9D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:00:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZd-0004Za-Du; Mon, 06 Nov 2023 01:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZO-0004V6-Pk
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:46 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZM-0001Oj-GS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:46 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ccbb7f79cdso5485845ad.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253923; x=1699858723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhaDOlXqK723HSaocfjU1ZCevxhmhF4yuGDJMeM3d5I=;
 b=DfILDRyzNDrR8ECbgoMra8J2l2D3unYez3+EyiQ8B+kbolZpjFa+SsZTuK4qKAxvg3
 9zG00trlXnKRS7D+C2rIzME572xh1wbmvXW3CecJzRktynwg0oiKnRvdyj3GxBAu2qGw
 PlLGy+LUVpFOgl4O+Rha8856WR7zldbl74B7I4IWvwb7H4r+ZpyryWEI+hU5HI02ViR/
 Mhk2NKEU2rCiWrHhWsVbnpyUtsLHAjuNFViLemyN7sh3PB6CsKr8U20++2poCiFHwpfL
 d9zTtRO29qKBJ625M2xxG2HkcHXHO/yJR75RTrCxOvSbUGkwecgFLGsNb1x3HTgZDuz6
 AxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253923; x=1699858723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhaDOlXqK723HSaocfjU1ZCevxhmhF4yuGDJMeM3d5I=;
 b=WTdmcUrkxl28yZXBfA5+z6S30sUXI61d2OrKk2tTAY6oaq3TuOHL7O6VBLsrwXi9Fb
 ZLY7GRR/PJmy4UUymxzDM7TWieQtPLTI7qmnMRzQt9z9kC0/blkZITrFhhNB5urCLpZL
 ApLfM/ZqTw2FCB+S/r7w1neae+noNI4WSnDDPtYPNOfdjA5TQ/GlQ3rVCKNuIcAxnJUD
 mJpaG03zTPNyLlPCva/1JHKrQ3t2qjU/JA7e+JPh9tdR+Y9oiIftfGAZHPJz+xnftnAn
 1PxubCG7M3tkDefUtQps5W2JVc8VAeZeJHoqxJwcNaJUVin30acg3ajTaFnsl653+vUI
 KZCQ==
X-Gm-Message-State: AOJu0YzuikB9xB3bXu3IoySb4Zcm77IaN4hzQrbpaer+9DQ7ya5FlbJI
 YyXx0dyJbap6tpf3K4BTd1OZNCi+LONgCI8ho/Y=
X-Google-Smtp-Source: AGHT+IH83f0Cf0hajY0vjmjAE1rk4AdIk8I8H51KPTNbZ0EPaIlwYfBrmw5Y9r0HzvEhxaCNH9HFNg==
X-Received: by 2002:a17:902:d18d:b0:1cc:1106:cf5b with SMTP id
 m13-20020a170902d18d00b001cc1106cf5bmr20889551plb.19.1699253923326; 
 Sun, 05 Nov 2023 22:58:43 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 16/71] target/s390x: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:32 -0800
Message-Id: <20231106065827.543129-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


