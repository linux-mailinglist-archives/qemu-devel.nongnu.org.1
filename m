Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D51816C91
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsD-0006rv-33; Mon, 18 Dec 2023 06:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs9-0006eo-2z
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:21 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs3-0003Jy-9Q
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:20 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d05ebe642so7730615e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899193; x=1703503993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O3/6wYv4hHy3/SVN/FzEmGqjPHnS90udBu+7RZANlgE=;
 b=LT0YULsWsHv19LQp4YQGVpMxKj9IUSaser+QMmzXygofDvowlENUCZY9tXbgrtbJ7R
 iFBa8fqzEgNZXbs7sqrUZoqu8vHcDvhMzSAIYFpE653CBDviiw6GJ+eXjITjwB/wJEsO
 a654G7+gPBCAtLT5PPPu3wYS0jI79IYXQl3IVrQes7v0xzv9DgpbTlqMmNSkFUqOkmH4
 E56h7oSWnW8v3KmPZ+lDAtw2qj1XqSmpTQFGQcEeMQ0VwMM+TUXqygwjm53+KZIfnjf/
 gewOHfdROBaKHT9Tt4PzkLUlacNpWhDfvbMbxOTcvZjwTYLBfYcfWRd/2gswS45X70ux
 vI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899193; x=1703503993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3/6wYv4hHy3/SVN/FzEmGqjPHnS90udBu+7RZANlgE=;
 b=DrwIzJCQtHBGHgOXfJ5AJx3Z8ivDnhVe+isGCnYXOsFvLApcQX7LwSdduKST0h72Hg
 A2hf/8cLlTj9oVrgZIVpNuyWphtbKngoGKVaXv5NDTuPMCn+8ylS5nsGRkEV/58n4lT8
 lcZuFaEyhAYJPMIeYBk5TyodslLqxe0HK/uw5/ErwPLsjbie+FjWRoviHH+81k9oAL9Q
 qJIz4yyAc574aOmhEONteK+SknEAub5dVAahjr3NmeBeZONX/pLRFHXmdh9x8dlfwmab
 1VS21NSLQqJ8Wih5ADjui0zrInTtOxKwD2QyvBt7C0M+0JKZtgB7YvDJBh7pPxZ8G+Tq
 qcRg==
X-Gm-Message-State: AOJu0YzTFX0qWG5Dch3dd/1OrK157fSuVSUk4s+bFtXRdTlg76LlMRbp
 kYGN8mcCGo1Umm+eODzEofifdA==
X-Google-Smtp-Source: AGHT+IGyAlMO5nLyL2Y2guZOlQU924njXhUZh5Fhgr06gaJ/oKYxtIsXoUgvUpqpJ3Lhxk7lL9lLDw==
X-Received: by 2002:a05:600c:3107:b0:40c:2c65:a156 with SMTP id
 g7-20020a05600c310700b0040c2c65a156mr7538135wmo.6.1702899193699; 
 Mon, 18 Dec 2023 03:33:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 15/35] target/arm: Set SPSR_EL1.M correctly when nested virt
 is enabled
Date: Mon, 18 Dec 2023 11:32:45 +0000
Message-Id: <20231218113305.2511480-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 44005665d12..220ee64df0d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11327,6 +11327,12 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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


