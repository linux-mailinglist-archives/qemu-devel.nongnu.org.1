Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF88201B2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:28:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLA-0006vl-Gi; Fri, 29 Dec 2023 16:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL4-0006uc-NF
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:20 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL3-0006S4-4q
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:18 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35feb61c91fso23479935ab.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885056; x=1704489856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMN6P6UkRFuIZLQOv+2lhjHpbohYNcYTosCGWfaizOs=;
 b=EM82f/IF+VKt9AtJpaKTCtbk3iVh1sb9Vkeei8WC8Q1Gw6XFHEjKFgVaC4SQl2mNfg
 oKtWKqvrhNz29oh01VKt11hr0g2S9hvrzRKcXeZaTy5t0V4o+axrzjE/paOHxaTFHQbA
 6l8123nVCzqMggKXbZ+rTRZQndXnW37muX+BXloJc7Dq8YJAlWLEc2TPiKmPBULs1AqQ
 bWyteaVU1dlYcZA/lv/fC8UngqvR5hVWD1IEcp/Lwq9a/c43KGHdWCj2DzzbmWBJkQFC
 m0kvwkVVVoOiEIeaE6ECMVOUS06hRKd1Abgig3DKBA4Jx6dwXXD1NcwD6vBBQhYuznvv
 eAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885056; x=1704489856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMN6P6UkRFuIZLQOv+2lhjHpbohYNcYTosCGWfaizOs=;
 b=jcLzr9Ii2ASEwABV3YbR3QOe8m5aiHFKCfr3fYgNQUzn3dnYQ/SnGQfgb96SoXHtOr
 qkgiuJGqRjIiAHwnLmOKxBo9a99gZ591U/6872r7/WLkGhjIbjZGPZVz9slnLr9jj0XS
 9fkUZRKkVPUvfJ3hdSyMvRV1BUBPL/xTNRpkphZAX2NMpIQ7Azjres3cdrfzlcxIe0M9
 zDQPswHiWYtu3fDQ30w4qCOUD7ywSFwoOkQai62Nl7T28Bv8R7zofXy/KhhTvIvc03PP
 l41/Y0o/N0lpcapPB9xHYdmrlNotZ8b/E1g6VPi7/TYDQV3g/b+/swmRiifCN5YaGOr6
 WErw==
X-Gm-Message-State: AOJu0YwFiftScJSWpv6JhocynnJMws2sOjpWzDFxDEozcb/mT1CX6uq6
 +OSZ1ALER+BvjIfncnBA0UJqjEb6FhSQDGJDySip7nhekLf9JQ==
X-Google-Smtp-Source: AGHT+IGtctOgEMvx0b+glX7DxlawJ2VUOs9NXUUVQRD+UYNdj9aAJY/73gMq/DdDOs27ksAmz3pbQQ==
X-Received: by 2002:a05:6e02:1545:b0:35f:e71f:4c63 with SMTP id
 j5-20020a056e02154500b0035fe71f4c63mr9872127ilu.100.1703885056119; 
 Fri, 29 Dec 2023 13:24:16 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 09/71] target/loongarch: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:44 +1100
Message-Id: <20231229212346.147149-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231221031652.119827-10-richard.henderson@linaro.org>
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


