Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D677CFB74
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCT-0002Rh-Et; Thu, 19 Oct 2023 09:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBy-000252-0X
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:04 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBw-0001EZ-0o
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:01 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507a0907896so7795362e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722547; x=1698327347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HT7bwggZNgShOlxGo+72AKdKpJoofzjD5SXuqPfjmCI=;
 b=E0h1guCiEynbvll+RRgI2QYntFI58bNqODf61TVNgGT+OBNZLoAGLAwEv+X1dAZBAb
 HR7BB8/v9WBX7X+6bxA3xKxArOmdzR7dQFmP7opQ+GWd+sNTXk+ci7gEw/25q4WHMahW
 9K/5ih21gmZq3HFc/7MS10bQHZ4HrX47zwPVqa9UvP1lzIjJr+CNqMFitRqDansKgdV4
 bZijVoXlfE4Cum7lhqANlXo98WNFGu5hfD7DdBQQcV9g9PXSpPmdoI2A1vrE9qJ+/PJE
 n+E46LzIvjWAImmyHwI7DK9FeT9p9YJDt9+nzdlvhFHQts5zmanIeDD2FXm5knRQF2xa
 wvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722547; x=1698327347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HT7bwggZNgShOlxGo+72AKdKpJoofzjD5SXuqPfjmCI=;
 b=r7GL8OQNJ8igqBNIgPn3wugT870J+H3aO/ADJXmpdrop2mGuxtw2WEdRhlU559qO7y
 JcjqOyPTQ4/Lm5JfjFkjpVfDl9fvGedEebmkOjxfEFLYxCwZJrqbOv0PNmbXwB4ZwU+H
 B2FOTR/Q2eUvTrw9sdpepmsx0DbVFZHTJzsZTjad83PaxBG4foYOdGA7x6xvWuDa+t/x
 QfgPQvbFAXFSZw1qoQNEsMW6VKzfvzAh2oCpz6gK8RPd72S3t5amfkI7fIh9AY8RH5y1
 oJ205UOjgPqsTNSntMyPfRdjgrPnqXRH19X0Rw0E1KhyKRwgyKH9dxMJK1OjIqFQekGL
 j+HQ==
X-Gm-Message-State: AOJu0YxPhzNRVNtDJxR7NI350U0+xeCITbDrhZs7vCOtJhEwz9pM5tS2
 TM3Ce7HH1uMJ+/zEIJHyU8u75wKCjF9GbgvNaL0=
X-Google-Smtp-Source: AGHT+IHgR8V8SItTpy3G6vfmM8UYT1+mjDYXTyPb9uU+78WBqhJgBf3SvpNDmw9YfYw5uovCIYQc6g==
X-Received: by 2002:a19:9118:0:b0:507:9787:6779 with SMTP id
 t24-20020a199118000000b0050797876779mr1499985lfd.3.1697722547535; 
 Thu, 19 Oct 2023 06:35:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/24] target/arm: Implement FEAT_HPMN0
Date: Thu, 19 Oct 2023 14:35:32 +0100
Message-Id: <20231019133537.2114929-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

FEAT_HPMN0 is a small feature which defines that it is valid for
MDCR_EL2.HPMN to be set to 0, meaning "no PMU event counters provided
to an EL1 guest" (previously this setting was reserved). QEMU's
implementation almost gets HPMN == 0 right, but we need to fix
one check in pmevcntr_is_64_bit(). That is enough for us to
advertise the feature in the 'max' CPU.

(We don't need to make the behaviour conditional on feature
presence, because the FEAT_HPMN0 behaviour is within the range
of permitted UNPREDICTABLE behaviour for a non-FEAT_HPMN0
implementation.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230921185445.3339214-1-peter.maydell@linaro.org
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/helper.c           | 2 +-
 target/arm/tcg/cpu32.c        | 4 ++++
 target/arm/tcg/cpu64.c        | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 965cbf84c51..47fd648035f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -46,6 +46,7 @@ the following architecture extensions:
 - FEAT_HCX (Support for the HCRX_EL2 register)
 - FEAT_HPDS (Hierarchical permission disables)
 - FEAT_HPDS2 (Translation table page-based hardware attributes)
+- FEAT_HPMN0 (Setting of MDCR_EL2.HPMN to zero)
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
 - FEAT_IESB (Implicit error synchronization event)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 01cd1474565..b29edb26af8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1283,7 +1283,7 @@ static bool pmevcntr_is_64_bit(CPUARMState *env, int counter)
         bool hlp = env->cp15.mdcr_el2 & MDCR_HLP;
         int hpmn = env->cp15.mdcr_el2 & MDCR_HPMN;
 
-        if (hpmn != 0 && counter >= hpmn) {
+        if (counter >= hpmn) {
             return hlp;
         }
     }
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 1f918ff5375..0d5d8e307dd 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -89,6 +89,10 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_DFR0, COPSDBG, 9);       /* FEAT_Debugv8p4 */
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
     cpu->isar.id_dfr0 = t;
+
+    t = cpu->isar.id_dfr1;
+    t = FIELD_DP32(t, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
+    cpu->isar.id_dfr1 = t;
 }
 
 /* CPU models. These are not needed for the AArch64 linux-user build. */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 68928e51272..d978aa5f7ad 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1109,6 +1109,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = cpu->isar.id_aa64dfr0;
     t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 9);  /* FEAT_Debugv8p4 */
     t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
+    t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
     cpu->isar.id_aa64dfr0 = t;
 
     t = cpu->isar.id_aa64smfr0;
-- 
2.34.1


