Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4D67E1A92
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 07:59:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZM-0004Ro-GZ; Mon, 06 Nov 2023 01:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZJ-0004RU-GQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:41 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZH-0001Nm-UD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:41 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc3bb32b5dso37757225ad.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253917; x=1699858717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGO4SKx+78nJlz7T7KRC0paS7HeJqQ6oQsF4iEBtiBw=;
 b=zczcnyDeYZecrf1y0leFpW88sIxEGt+YFnyl5Elz7La3153/cj6DFJOgmJikGDUuW0
 /BtZSItXAJAhM+FyoLD3RhhFn3g3zWwRxEl91jY3L8i2Lr6PFJVHJq8lsDnd1TWB6cfk
 D8WTsuAhcD88ppd52eBFvhFKbv7P0EtFrWNaq3BJ9qg4Kd6JVYy83W1s4PZBqfXe46Va
 06eeurtX9n5aoOgAhshL+ZsAgMdUbtrDaJp8C8bfoXNEMTZ1xV4q+QTsT3M6tBYmI0QH
 HgDroUnyl65Gk7mC73gYQfFSfK2P/Q4l/1dG/RqVUcXaJjbCKwfXuQolvJhHWhMRkBBF
 i2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253917; x=1699858717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGO4SKx+78nJlz7T7KRC0paS7HeJqQ6oQsF4iEBtiBw=;
 b=nbn0Y9S87WOp1eDb9hwkfixTkKt5VxWdq1qOKKHS55AcdWl+HxDraALEonZ1aAbz4r
 uAP6CalLflwKkgxuOT/c8+srt3OWBaLAxPYRAu7l785kWWR5pTgHsSfAcpJGoUCVGYYJ
 xIgykcGH+py8HwlSuNz/nIbmNkvB6ZqEBN7Fx6Jm03srX/CNm5pSmyaOGcUiUXeDUneo
 2y19iSpIFtZl7svtnlXnozgF4xr2BwJJXvSGpdIDJIDxlWNUu4SnwgnzxOrvAeZmr16v
 OLwkoBXSTr4xTRhUN6s7DmT9JDb1E1tqvkl1SwKvePcTIgV4zADEqYrX/StXykiPXJpn
 e8/w==
X-Gm-Message-State: AOJu0YyV8TGNpOUnsKB2HIuWcF3JmoqTpX/SkWb6ubHQYMVxpsagbrWI
 wL2PT4R7H4XqhfLLJMyXmCcqcTXhu73I+RdpnZg=
X-Google-Smtp-Source: AGHT+IE0ZR8uSGOoINAhKCirADuMONvEOgFawzNCuUIHJ5tq4SukHzP5FE4XmAvY4XO3HytViDnx3Q==
X-Received: by 2002:a17:902:d48a:b0:1cc:5168:688 with SMTP id
 c10-20020a170902d48a00b001cc51680688mr24284075plg.60.1699253916977; 
 Sun, 05 Nov 2023 22:58:36 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 09/71] target/loongarch: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:25 -0800
Message-Id: <20231106065827.543129-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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


