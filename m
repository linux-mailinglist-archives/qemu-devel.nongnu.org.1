Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4187A816C8C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsf-0007e3-PC; Mon, 18 Dec 2023 06:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsP-00078j-2I
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:38 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsB-0003Oy-RQ
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:36 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336353782efso1991317f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899202; x=1703504002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rUb284RLcdGQfWf93deJoRyDRaWXUjDKOWFu048BNus=;
 b=XuWxc7EGvIn6Upc9E8Sb6LgH0Td+GZtvdIMYrEAJNDfJfMgF8LGAiLtxuqMfSvk9a3
 FiiMshbApzx1mQJlCf4NsgEkh4vrtffJ3D6PwkGiq/UMffFOB8XgDznGFnjbdgvPHIwC
 yv3T1cAuqwT8CsGaAJnmFkoQYLSz8Ib0mSyxnOrBRdxjsV/r2JuPqYJZ7g2/hseaYMS/
 9ReFRwbd5PXDr8EP3WsK4ysKn5hCb3MTtluDOzwAlM+BAM6G8sWqva+VcFZwMbyzylQB
 wH3hKVrtrlmM35OzxLloxts1ozn259ew+n9C2Ilj2HrbDm/qGY57B3KTDzkDXjLxezq4
 Oiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899202; x=1703504002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUb284RLcdGQfWf93deJoRyDRaWXUjDKOWFu048BNus=;
 b=ZaUR1cJt3Wkb31oHm6Paeh2Y9Ha0lyLFRjCjyfC/GHGVrmL7f4zP8V1HDEbl8iANdJ
 aTwzT328jFE4V2T89oM/AyObexFkHeaPwnolAcyVt2Y+s+HWX1JYb7xMpiuN6eLMNYtV
 nAhNyv3NR60wlWjdJ8Wa40zI6/rcSt+sDn7q4aC3WqGoUMbDlF4F8UY/LuC/3cLuoepq
 diUypXri3/9O63g7mPl7WFq5gjYBQZdfqjnad59SImndV60VKZy64OcqcZbjLtPGgVeV
 AJXzrEPnqJGdBSA6CtJVna4ZTcBmHt6L0jtLHsuz7O4M/Omm33j0FXRme34jl29o/oVu
 c2hg==
X-Gm-Message-State: AOJu0YwQkC9nkjlOjvEYnQd5MV45BV4zcc/GFu38BJTqPwxudP0HsD8T
 KpmM01FBm8tHNFy1r28YO6ETBytxLWSye1zLli8=
X-Google-Smtp-Source: AGHT+IGSjDjFyi/5epUv2TdM6HLRiKOx7qPB8AHXmb22M5uiA8NznYjvzBsrnE0RxkyFr95iAjoZGg==
X-Received: by 2002:adf:e8ca:0:b0:336:668b:d1ed with SMTP id
 k10-20020adfe8ca000000b00336668bd1edmr1166994wrn.118.1702899202578; 
 Mon, 18 Dec 2023 03:33:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 33/35] target/arm: Report HCR_EL2.{NV,NV1,NV2} in cpu dumps
Date: Mon, 18 Dec 2023 11:33:03 +0000
Message-Id: <20231218113305.2511480-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

When interpreting CPU dumps where FEAT_NV and FEAT_NV2 are in use,
it's helpful to include the values of HCR_EL2.{NV,NV1,NV2} in the CPU
dump format, as a way of distinguishing when we are in EL1 as part of
executing guest-EL2 and when we are just in normal EL1.

Add the bits to the end of the log line that shows PSTATE and similar
information:

PSTATE=000003c9 ---- EL2h  BTYPE=0 NV NV2

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index da0c02f850b..d1d592609eb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1059,6 +1059,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     uint32_t psr = pstate_read(env);
     int i, j;
     int el = arm_current_el(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
     const char *ns_status;
     bool sve;
 
@@ -1096,6 +1097,10 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     if (cpu_isar_feature(aa64_bti, cpu)) {
         qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
     }
+    qemu_fprintf(f, "%s%s%s",
+                 (hcr & HCR_NV) ? " NV" : "",
+                 (hcr & HCR_NV1) ? " NV1" : "",
+                 (hcr & HCR_NV2) ? " NV2" : "");
     if (!(flags & CPU_DUMP_FPU)) {
         qemu_fprintf(f, "\n");
         return;
-- 
2.34.1


