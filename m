Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D782F11C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:13:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7E-0006br-Mw; Tue, 16 Jan 2024 10:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7C-0006ad-QH
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:34 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl79-0005pG-IK
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:34 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-337b71a0240so558992f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417950; x=1706022750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lyk6QQmr4+f48XXsn9e/gGz8ajxtDEBuGo1mBRWlXr0=;
 b=jHlL0ADA9jMSCFpOT/EZDnQ82XI2MHM4XmY8rNoZJsNfpT4ZBQP6aU3P+ikBe9nIr3
 DNP3xBVYPbgu56VvGf+lMvpwibf67F+aKDWREPJOnoAHHMb1wVzwHnKD53eQhPk8llIZ
 ZrNcAwXwxcrmVI8gqfeis2ZM+GrxsMHg19uKg/yiik73W9/Fb14DW5oJ+Ex5I3pRp/12
 +ds4UP4VoBDe/bJGKexCoem2OWQhNYeUJjGd3V6sJiPebMCEdOdyOtcvhjh8R/eDtPfC
 MynyB+ScfH7U78r1tHDf4eSpW4CVSsR1RklaQOXIyCEPB2CR8dUipz95SmbEOs/Miy6R
 o4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417950; x=1706022750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lyk6QQmr4+f48XXsn9e/gGz8ajxtDEBuGo1mBRWlXr0=;
 b=UzH5bkkIIEfr0+TVt2dGGWXLgNBIlE12v7zVU44ig5RHiqhdKrgO/cqORCiudjh1Sj
 SQIPXHavQV47om6YigOlqUwDbsrkE19JSASKHVgKZf8uDtfKVNvX6FqbrUnEwf0YcFNI
 k1RuASRf8KixSJmoGfadlc5XhT3CdgnvzP+dEJCm2SMgvnDz/N895FR7GV9Nh45yZuqE
 VFFY1v+S5lRk+3xG+lFpr1wKf5IxIxfbVa1uUIIH+U1y86hbKoWGDmMQGWRiKjrUPqnA
 C4KSHS8Ls7dbiNQhD8SXhjeuy3aQE8t8CESDs0SVcomp3HLvo6DqB+nhN+8gCskmZSy4
 LvDg==
X-Gm-Message-State: AOJu0YyhzBbDeIKh557JHAJ0jB6IlIg1UjHZ9h4eMoAzw7RDDk5yExXh
 XqS9ru64y7iZQIKXXfqV4rkTar3hPEVoFLpZE453DhxlFC8=
X-Google-Smtp-Source: AGHT+IHGBiGv8/WCIahKglytkKEuRbWCvhZFP6xPLsnnU9l8X2XKk2y4TjBD7oRSUKbKbdMzQVv8wg==
X-Received: by 2002:a05:6000:1145:b0:336:7051:8400 with SMTP id
 d5-20020a056000114500b0033670518400mr4245059wrx.23.1705417950081; 
 Tue, 16 Jan 2024 07:12:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] target/arm: arm_pamax() no longer needs to do feature
 propagation
Date: Tue, 16 Jan 2024 15:12:09 +0000
Message-Id: <20240116151228.2430754-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

In arm_pamax(), we need to cope with the virt board calling this
function on a CPU object which has been inited but not realize.
We used to do propagation of feature-flag implications (such as
"V7VE implies LPAE") at realize, so we have some code in arm_pamax()
which manually checks for both V7VE and LPAE feature flags.

In commit b8f7959f28c4f36 we moved the feature propagation for
almost all features from realize to post-init. That means that
now when the virt board calls arm_pamax(), the feature propagation
has been done. So we can drop the manual propagation handling
and check only for the feature we actually care about, which
is ARM_FEATURE_LPAE.

Retain the comment that the virt board is calling this function
with a not completely realized CPU object, because that is a
potential beartrap for later changes which is worth calling out.

(Note that b8f7959f28c4f36 actually fixed a bug in the arm_pamax()
handling: arm_pamax() was missing a check for ARM_FEATURE_V8, so it
incorrectly thought that the qemu-system-arm 'max' CPU did not have
LPAE and turned off 'highmem' support in the virt board.  Following
b8f7959f28c4f36 qemu-system-arm 'max' is treated the same as
'cortex-a15' and other v7 LPAE CPUs, because the generic feature
propagation code does correctly propagate V8 -> V7VE -> LPAE.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240109143804.1118307-1-peter.maydell@linaro.org
---
 target/arm/ptw.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2d4fa8dbcaf..5eb3577bcd5 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -95,7 +95,10 @@ static const uint8_t pamax_map[] = {
     [6] = 52,
 };
 
-/* The cpu-specific constant value of PAMax; also used by hw/arm/virt. */
+/*
+ * The cpu-specific constant value of PAMax; also used by hw/arm/virt.
+ * Note that machvirt_init calls this on a CPU that is inited but not realized!
+ */
 unsigned int arm_pamax(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
@@ -110,13 +113,8 @@ unsigned int arm_pamax(ARMCPU *cpu)
         return pamax_map[parange];
     }
 
-    /*
-     * In machvirt_init, we call arm_pamax on a cpu that is not fully
-     * initialized, so we can't rely on the propagation done in realize.
-     */
-    if (arm_feature(&cpu->env, ARM_FEATURE_LPAE) ||
-        arm_feature(&cpu->env, ARM_FEATURE_V7VE)) {
-        /* v7 with LPAE */
+    if (arm_feature(&cpu->env, ARM_FEATURE_LPAE)) {
+        /* v7 or v8 with LPAE */
         return 40;
     }
     /* Anything else */
-- 
2.34.1


