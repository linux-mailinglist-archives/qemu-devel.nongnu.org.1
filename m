Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC582AD03
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:11:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssl-0001ha-2Y; Thu, 11 Jan 2024 06:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssB-0001Mt-BL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:19 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss9-0004Ro-28
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-337874b8164so359078f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971116; x=1705575916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JW8YIe50LT4PZiM8mDHqQtLIGx6RzO+LKTb370XSXVc=;
 b=OhRz9XnMtL5LtnZ/EvexsRcx6g632WblfUwxHRXkDMdQ01bZSznU5dS3mjEKu1BmiZ
 xokdVl4cICVxSdtTq9IaGFL8wkU0UfZfjEkl2T0VcN+Rdq2B5rBIQAVObrBTFntChpak
 mjoUGcS4nUi6yF6Q34vJV2083YVITyDutytOg1v9iPbAtxJp7UwvKhoQgzjKHaVH4LeA
 /I75L9bWznEH8ugckVObt9aFOzFIoVtpbiOjM3fAEPw28NfTCmEyR8YvljVCQo5yBhqz
 rU/0BHaBMmzjJmgJC2uksCh96wAoyC9UeTpIocevA7CvciqAEq2gZkq3ciFRpl+buzn8
 OYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971116; x=1705575916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JW8YIe50LT4PZiM8mDHqQtLIGx6RzO+LKTb370XSXVc=;
 b=sNJXDPxJHF7MGN0Hh74BSlBTpV3KZDK8KCUcs6rfMhUFofPgpiQKZdFxPUbsGawARZ
 dXhBfxYb35RUz1u8HCadAP+vVnt6uqFsCX8MPfPRIi/byCyHhq+RD/g+Bng8NxtYKmQK
 C7JC5ftVCywBBydWqfImYOJnjrdgsIMEX/rMh+2DHpkvVUCmtkYx3FoH/gLzNNFlRgNs
 hDorDhPhpPnKNUZTo1Eca09x8dlaK5ZLfxRRSclCRlgMf6ZO/AQGGciG9GFh+OKzNHbS
 hnJ56sL1Vxjms3kHrWROOBZZrwvVUzYBN+3hZ2KaolgzUTSJoSPu1HG+ipmPStFWactF
 JWzw==
X-Gm-Message-State: AOJu0YzyCRhw033As6K9d+3bEpMWxAKBfSC/y49N5Firyx6uomeVskd1
 W2luM6kc5gZGIsd0uankMV9RLZVq60RA0yhWEVG5KcxhYQ0=
X-Google-Smtp-Source: AGHT+IFe4Uzeb3za8wxAvmRvBBt47ndGNkeHEDvETTGYDlajp/HZzE3/sxpEH6B8Mj7ECVcEwT9daQ==
X-Received: by 2002:adf:e812:0:b0:337:2e5d:4ac9 with SMTP id
 o18-20020adfe812000000b003372e5d4ac9mr534530wrm.81.1704971115813; 
 Thu, 11 Jan 2024 03:05:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/41] target/arm: Set SPSR_EL1.M correctly when nested virt is
 enabled
Date: Thu, 11 Jan 2024 11:04:45 +0000
Message-Id: <20240111110505.1563291-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

FEAT_NV requires that when HCR_EL2.{NV,NV1} == {1,0} and an exception
is taken from EL1 to EL1 then the reported EL in SPSR_EL1.M should be
EL2, not EL1.  Implement this behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7c7f92c16de..e48b03ba1d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11249,6 +11249,12 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         old_mode = pstate_read(env);
         aarch64_save_sp(env, arm_current_el(env));
         env->elr_el[new_el] = env->pc;
+
+        if (cur_el == 1 && new_el == 1 &&
+            ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == HCR_NV)) {
+            /* I_ZJRNN: report EL2 in the SPSR by setting M[3:2] to 0b10 */
+            old_mode = deposit32(old_mode, 2, 2, 2);
+        }
     } else {
         old_mode = cpsr_read_for_spsr_elx(env);
         env->elr_el[new_el] = env->regs[15];
-- 
2.34.1


