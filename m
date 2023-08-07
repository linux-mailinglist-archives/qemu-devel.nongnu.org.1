Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD84772761
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT12d-0002QR-Ub; Mon, 07 Aug 2023 10:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT118-0000Ax-UT
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-0005V9-Dg
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe426b86a8so37493745e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417724; x=1692022524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cr23TIsFZ3PjCpnV8UZBDI6iYURVIWjSxhQhgKrusGQ=;
 b=giZh0fYhUvDjCGYQSXSlD0We98uOeWc4tt1dJ0qBDzDSupVTUrhUQL2YfxLJfAfCIM
 R0L4fzFykUtfElyEqEcyy4QDh2Te8HPOCVD5a5L8kiWruqC9eW4chsfcQiJsu4StL+39
 fhX29I1ZfpQrOKDYqjaAclKUhI/gxkzqqf/4T5EceihvZrOGlFeFfbY1ETXfowmuDbcI
 bDL8fXyBWTzeOzTdwMU+K2M4kiejDLkvpf08fimFAHaFgqKf2tfYNpK7Ch14swTKDhx+
 qm4lCpI7e5ouj4m0wedBRCs7qyPefcqCBS4ywIUmV+O11htddSEix4/R4+IlAEH0jn4C
 z0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417724; x=1692022524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cr23TIsFZ3PjCpnV8UZBDI6iYURVIWjSxhQhgKrusGQ=;
 b=aMi6zkXX9LZK2uv0MhSVSP+VVbTr3SoPsfaysbl7We2GejygHWRGEB4XPV5326qKTk
 AcejAaoWA60O+7bC8NtTYPDMhhi8FekMWPK+IHLD83t79EG/6s7ZmtTY3/KMHkYYD1VD
 CyS5J3NyZJ4mPd/4jpCrEpILa59nSFDdJ929yi3YZGorrWjOmIFNzFA6ZnAJfOqNHM1I
 ddFzekbIHzr56GIolFJq2+4E36/9IA7ogzWcFgejQi+ynLZF9grBTI1VMedFz6S394M8
 SPjLpKRjcymJgpoMsuyQ5/hvkhtVwVcBIkampQzFwDZ+yv65N63gaSvtjukkF1tkrwxE
 M6xQ==
X-Gm-Message-State: AOJu0YxDeNBF6hfG1QXsvVUHwf/QxcefyLNiWIo8aO6/THEHHujX0wVu
 0sDvpSyj1pknuFH15O2JtT82u/OH39iysoD7ESg=
X-Google-Smtp-Source: AGHT+IE4dCtXE2aQsHZkpJWin6gFmEpdgQ4CeUO7evcmbc4qC9hfg6RRdtyqmpaFio8zCyoCFix8gA==
X-Received: by 2002:a7b:cbc7:0:b0:3fb:bc6d:41f1 with SMTP id
 n7-20020a7bcbc7000000b003fbbc6d41f1mr7496434wmi.17.1691417723922; 
 Mon, 07 Aug 2023 07:15:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 14/15] target/arm/ptw: Report stage 2 fault level for stage
 2 faults on stage 1 ptw
Date: Mon,  7 Aug 2023 15:15:13 +0100
Message-Id: <20230807141514.19075-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When we report faults due to stage 2 faults during a stage 1
page table walk, the 'level' parameter should be the level
of the walk in stage 2 that faulted, not the level of the
walk in stage 1. Correct the reporting of these faults.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index fbb0f8a0bf2..07832eb8f76 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2048,9 +2048,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
  do_translation_fault:
     fi->type = ARMFault_Translation;
  do_fault:
-    fi->level = level;
-    /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
-    fi->stage2 = fi->s1ptw || regime_is_stage2(mmu_idx);
+    if (fi->s1ptw) {
+        /* Retain the existing stage 2 fi->level */
+        assert(fi->stage2);
+    } else {
+        fi->level = level;
+        fi->stage2 = regime_is_stage2(mmu_idx);
+    }
     fi->s1ns = fault_s1ns(ptw->in_space, mmu_idx);
     return true;
 }
-- 
2.34.1


