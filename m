Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA4820197
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLO-00076L-92; Fri, 29 Dec 2023 16:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLL-00075R-Mm
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:35 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLJ-0006iY-1R
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:35 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cdfed46372so4075063a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885072; x=1704489872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CWWqpcyXTMz7Xz2FP1em44VzN8AMs3WMuNzELPAxUXs=;
 b=nuRG0sELlKyURlE6DWlxfWPCVx8KKKiYVtnSrMUmCKixunW197g2CP+c+PYjKx7zU+
 tVVvtizm85Klny6nGxwxq1VYv221etCvncxc77mEqjBZZZhNBYur0oOY/kwtzKxYVYPV
 Rgzi0mshwyzaCZ0gOSh3vsACZR6HZych+w6KRD0vg2zopbqEuTvtiEXiB3ngvQ04UZlJ
 jMO6zvMkih0L2nL/OrEE1YLemHNEYkWL0dA0JdRJ+3KYqp1ZdXjVVIGlz2ZjS2laqqX4
 SqJkegta1o+YJtzqFdZwLkpXuNaU+pV3qpID9GR70rLp5QyZngqiQlr+O87WPfAotvPE
 ht/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885072; x=1704489872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWWqpcyXTMz7Xz2FP1em44VzN8AMs3WMuNzELPAxUXs=;
 b=Dfypk8F7DZcwGA44/iRfvSHibz41U3DZRMhX/svOki1RLInZO+anAJhzwQrQTfGNZ8
 JS9a8fbxip59lLIMH5GHQIRMlerpihj5aQFkh6gD88jZq5UwW+tHiUw1z/9NiwReEqAe
 TjtTkQ0I817axWBZt4rzTDyHZqOVvxWcuINEGTar33WQ4La+m7ahiKP+vJFidTpJG55U
 SSIRPODRk6G3nF2W+ZV5eGfbWvNloto8v8iht++lBWZq3WGyocVS9xzaAo+8CA34JokB
 6fzKqVCo5/lzfCJjwQC85wJ54ccG7v1CTiN8g129HLmEK68c1hmozxEELoDV+sEe4Gg0
 g8Wg==
X-Gm-Message-State: AOJu0YxI6iGE2DL4Kje9tNbtii0RI9NWSXq3FCNoRd9Lo7NcdcYL1h2Z
 ptdaLkIMmVJ+/vB+nse3a03Gvor0/Vfm6bw76hnQXbQL3FT/eg==
X-Google-Smtp-Source: AGHT+IHQno1zufSBtbssHdZ6d92z1j6M1E01PE1o/dqyvjZKRmfkT7jQQQuDh2I4jcY/FEdu55vWsQ==
X-Received: by 2002:a05:6a20:6311:b0:18c:2d7:c4b0 with SMTP id
 h17-20020a056a20631100b0018c02d7c4b0mr11389742pzf.4.1703885071718; 
 Fri, 29 Dec 2023 13:24:31 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/71] target/s390x: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:51 +1100
Message-Id: <20231229212346.147149-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
Message-Id: <20231221031652.119827-17-richard.henderson@linaro.org>
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


