Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F417E1AD4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:13:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZN-0004U9-Mb; Mon, 06 Nov 2023 01:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZF-0004PX-6u
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:37 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZD-0001NB-OS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:36 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso29645015ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253914; x=1699858714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zm1Pc5wJxkaNSpGGoncfVHQXzuhJXGIo2lnnoud0ql8=;
 b=I0xcQxou3sHalPm3+QoW6rZSCNryB7IY7k8bXw7qNNRmdgCtxwJTOCymfYHorP9DRc
 51y/TwZL4SACVHeBg4SCCI19dIdaKvbV+Al3Si2x/kzhpBGVGcWtc4bJ/P2o/vwjA8Ii
 lS45KIpCyBduPtTnIDTlZGeWvnemB/0u4rkXUxpCM4MWh7TTcDdpKbU+c1boHxRbHCJK
 m5tjLJS8OqTRHYqn1bXnVFEwC7IyrHB4YyL6inR5TTpmKBhsaV55CZmnZgxssA6Gw+zS
 gQJkXqFSSFtBNWDLG+npfu9fIlQAR/Lsg419npmDEqeL2Zx4aq6hKK66aBBnn+LyO1J9
 vQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253914; x=1699858714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zm1Pc5wJxkaNSpGGoncfVHQXzuhJXGIo2lnnoud0ql8=;
 b=OE2b+MnYPmj7h4qvsIW05FF1ZBTOSyJ/YccaZOCBffDxa9FPjbdr/T0Fi79o2bmZG0
 SOZMFtq7bo4FOok+Sw3lL8+ut5OsHhhiJcKGEtc5cYeC3pdXbFvsDPpfty+XsoTo49Ea
 80FW4nsIChN4pOncJxYYhkKaxbyKMTGGEaxNXboZFmIwUM7C8Nhqab/LPH21N4TOzU3e
 HsP8SgINRcASztaEabaaecE2/UdrZ03ZNcugo4tPf+hvCcfmXj6+3yxLDFWN8ex7uOSe
 q8xwNO62nIlJiOX188jQncuk5TmYEAPdfV/0B01YhZlt5sk9vDcyax7ucHzT0dizc7Hu
 1Mnw==
X-Gm-Message-State: AOJu0YzYUnAnA9ADeg1qQAJU5yjcWqHyVG6TueUz5/OFVGVR9JT7tYM9
 MZ48bOgYHSwc1/B++PAWRDneutlS4nOr2o1hSRw=
X-Google-Smtp-Source: AGHT+IEWJhXOd3lGKPkvOVbncagZVGyh0pLeKFqqxz1feJ31fMfOrWSMtis0+ezf2fBH8mG0JaxF+w==
X-Received: by 2002:a17:902:ea10:b0:1cc:56b3:efc5 with SMTP id
 s16-20020a170902ea1000b001cc56b3efc5mr19367152plg.21.1699253914123; 
 Sun, 05 Nov 2023 22:58:34 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 06/71] target/cris: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:22 -0800
Message-Id: <20231106065827.543129-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/cris/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/cris/machine.c b/target/cris/machine.c
index f370f33486..7b9bde872a 100644
--- a/target/cris/machine.c
+++ b/target/cris/machine.c
@@ -26,7 +26,7 @@ static const VMStateDescription vmstate_tlbset = {
     .name = "cpu/tlbset",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(lo, TLBSet),
         VMSTATE_UINT32(hi, TLBSet),
         VMSTATE_END_OF_LIST()
@@ -37,7 +37,7 @@ static const VMStateDescription vmstate_cris_env = {
     .name = "env",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CPUCRISState, 16),
         VMSTATE_UINT32_ARRAY(pregs, CPUCRISState, 16),
         VMSTATE_UINT32(pc, CPUCRISState),
@@ -85,7 +85,7 @@ const VMStateDescription vmstate_cris_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CPU(),
         VMSTATE_STRUCT(env, CRISCPU, 1, vmstate_cris_env, CPUCRISState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


