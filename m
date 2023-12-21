Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB881AD24
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:19:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ZJ-0007Sq-Jk; Wed, 20 Dec 2023 22:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZE-0007Mn-DL
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:49 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZC-0003km-Nz
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:47 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42795ea3e35so2378751cf.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128666; x=1703733466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bGO4SKx+78nJlz7T7KRC0paS7HeJqQ6oQsF4iEBtiBw=;
 b=pH760Loej2zNboLdixx1WYdAC+YbRacafLGWbUYsDyjbhMaOdeiUhUFfJdhr6YUits
 8exnZTRHW/5DMmeCUlpalz3Yu1S/6JUdINfVbQuoD/po+w/INtGe6UH2Ffc58nP52tRw
 peAyxHuY/lOicmqqk1ym5SllC1FHm7ARbo3V+amegz70TctD5J0QKdFaNu4aPO0SlCQF
 Ltiql0L+/aLJvnpfOT5KO2g6KFt98dZjwk79IGyfpoYSnWKaTWfKPL6E9YwE+LE7yk7H
 3n0zJsH3+rzRMIi2Nu1Miea2VKr3nii/dh2hyk6V9lO0ySJS8398RqppJqjjfTvYaBwL
 a7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128666; x=1703733466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGO4SKx+78nJlz7T7KRC0paS7HeJqQ6oQsF4iEBtiBw=;
 b=N7UNhFPLLZLYBBOirr+rujkLmdAlvLzg1BDeDmuqNQ6WknabnWIFpDWd3UUB27y6iy
 QNyrMxJOh+XSHjmswfdjqtQkOUGscGS65QcNl4KBMkhruyAz3SHzoP/YDJWbMhcWPW6i
 /SbmVwWa2eWwz0dLeQkZPDtXQyAPEzH2YgSVKIWn9WGXvLNXMTafTAU2GWPNJ8+DROmK
 l+4FP4IfkOFbvC25QJo5cgyIqGhPwvd3D/TLeUnV6PnblVX8tIey4eI6iRgCN3MTydK9
 zK4nHbuPRcZW1GFm0SPBkpDp7PWwyhiZ+IcX0Nyh0BSMvVppMgKzuzs5eiaiY6iJLm8/
 F80w==
X-Gm-Message-State: AOJu0YwArPpZ/QFU/CVhSjVYnRsOhwVF5YVSFNKlniuM85Wbpzht1jjy
 AUqj416UMJjCD/l182UYtSqIbKRPjZZsh/H36CtROCGs
X-Google-Smtp-Source: AGHT+IEfHw4HfD6hYNlgGQchbqkPpZiIb8LgDJ5fs4sX3POgpZZUSraBBM4TULtvinbvzGfZyZ9VgQ==
X-Received: by 2002:a05:622a:138b:b0:423:9cce:296d with SMTP id
 o11-20020a05622a138b00b004239cce296dmr34237318qtk.37.1703128665743; 
 Wed, 20 Dec 2023 19:17:45 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/71] target/loongarch: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:50 +1100
Message-Id: <20231221031652.119827-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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
 target/loongarch/machine.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 1c4e01d076..c7029fb9b4 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -14,7 +14,7 @@ static const VMStateDescription vmstate_fpu_reg = {
     .name = "fpu_reg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(UD(0), VReg),
         VMSTATE_END_OF_LIST()
     }
@@ -36,7 +36,7 @@ static const VMStateDescription vmstate_fpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fpu_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_FPU_REGS(env.fpr, LoongArchCPU, 0),
         VMSTATE_UINT32(env.fcsr0, LoongArchCPU),
         VMSTATE_BOOL_ARRAY(env.cf, LoongArchCPU, 8),
@@ -48,7 +48,7 @@ static const VMStateDescription vmstate_lsxh_reg = {
     .name = "lsxh_reg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(UD(1), VReg),
         VMSTATE_END_OF_LIST()
     }
@@ -70,7 +70,7 @@ static const VMStateDescription vmstate_lsx = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = lsx_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_LSXH_REGS(env.fpr, LoongArchCPU, 0),
         VMSTATE_END_OF_LIST()
     },
@@ -80,7 +80,7 @@ static const VMStateDescription vmstate_lasxh_reg = {
     .name = "lasxh_reg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(UD(2), VReg),
         VMSTATE_UINT64(UD(3), VReg),
         VMSTATE_END_OF_LIST()
@@ -103,7 +103,7 @@ static const VMStateDescription vmstate_lasx = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = lasx_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_LASXH_REGS(env.fpr, LoongArchCPU, 0),
         VMSTATE_END_OF_LIST()
     },
@@ -114,7 +114,7 @@ const VMStateDescription vmstate_tlb = {
     .name = "cpu/tlb",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tlb_misc, LoongArchTLB),
         VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
         VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
@@ -127,7 +127,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
 
@@ -193,7 +193,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
 
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_fpu,
         &vmstate_lsx,
         &vmstate_lasx,
-- 
2.34.1


