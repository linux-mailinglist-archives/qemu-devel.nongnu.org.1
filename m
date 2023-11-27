Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77F7FA81D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:34:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7fU6-0003uN-CK; Mon, 27 Nov 2023 12:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7fU3-0003tr-Ew
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:33:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7fU1-0000r9-Jc
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:33:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40b31232bf0so36544155e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701106400; x=1701711200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VTmP2SfuKtFGsLKLcYsU/86EziA+M1ZnG6uDYIkwoU0=;
 b=fs8oG/5oyyCJQTu8Ht66+THWnjlOz/oWCiQ4ImnzRGyAQTvllqCkgwX2VkaPL95X7V
 4ItBcc1aJiAYuBBz8JaFGFi1xAUtoVJbr/IGwHguhD45cRQLyRWOnqGAE6jzsfV2+gbu
 XggGKDT8x35ezVACgoalSocDlXpF3wtqyzdrE8PUWQ205wwrBoVfSnMQ2qQh43JFvFv1
 Gb3gwE5Avxcua/5kP60Z76X2mn3eHudD4ND4MjozY7YXTfy1lYv2kpVGh825Qcw6JMF/
 lUvFQvocGIxcBR7mGU1QFEtkI7uu37TgVWLhpUHUOVchvlp0Y6AO3G4J50gB1HvdFMx6
 BxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701106400; x=1701711200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VTmP2SfuKtFGsLKLcYsU/86EziA+M1ZnG6uDYIkwoU0=;
 b=Dl4aEphv9xEyUlHdGMmMWmE9ANmjKSJ+wMmdR5etsK9yuwSowQ1tq8r5sp/Rrsjh44
 7dt7lAPZnKzguivXWtWVJDvVJ+5mphMEE/I9Iw5vW7OOHRuvVLEMiCVjXWT4xvuX5bAh
 NfSyxkKZeCjfo4xgoZZ/AoG7S5zQfgjZwHxlpP8O82B/DkjXVMzSXWY8myFaadUqeFIK
 NyhcpJnX12ae58L4gkSIqK4ZSaBlOANJbratNxZoeDroJ6//fImTINofVzXQMDPXiI3J
 NZxpEcnwGY8XhcHSY64L/PgNBZqYkgoQ2CSG9i53fbgVE1QKwTADSw0x9QzcaPaxTPYp
 6ySQ==
X-Gm-Message-State: AOJu0Yy0/8M4sXSabJWhHxnbG7KL2s2NJm4ulgNJvsSiWPcCJezEdzk5
 Tk/6If6+0kL/2MbnZTL6JJucfA==
X-Google-Smtp-Source: AGHT+IH411Nyg7yP8L/cR/J1QT0JlX0NGhaja9cy/gYV/i1a4InFknzOZCfmW77NdlL1ZxAo3tPqjw==
X-Received: by 2002:a05:600c:190a:b0:40b:3fed:cbeb with SMTP id
 j10-20020a05600c190a00b0040b3fedcbebmr5769424wmq.32.1701106399879; 
 Mon, 27 Nov 2023 09:33:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 iv8-20020a05600c548800b004063ea92492sm14712187wmb.22.2023.11.27.09.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:33:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PATCH for-8.2] target/arm: Disable SME if SVE is disabled
Date: Mon, 27 Nov 2023 17:33:18 +0000
Message-Id: <20231127173318.674758-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

There is no architectural requirement that SME implies SVE, but
our implementation currently assumes it. (FEAT_SME_FA64 does
imply SVE.) So if you try to run a CPU with eg "-cpu max,sve=off"
you quickly run into an assert when the guest tries to write to
SMCR_EL1:

#6  0x00007ffff4b38e96 in __GI___assert_fail
    (assertion=0x5555566e69cb "sm", file=0x5555566e5b24 "../../target/arm/helper.c", line=6865, function=0x5555566e82f0 <__PRETTY_FUNCTION__.31> "sve_vqm1_for_el_sm") at ./assert/assert.c:101
#7  0x0000555555ee33aa in sve_vqm1_for_el_sm (env=0x555557d291f0, el=2, sm=false) at ../../target/arm/helper.c:6865
#8  0x0000555555ee3407 in sve_vqm1_for_el (env=0x555557d291f0, el=2) at ../../target/arm/helper.c:6871
#9  0x0000555555ee3724 in smcr_write (env=0x555557d291f0, ri=0x555557da23b0, value=2147483663) at ../../target/arm/helper.c:6995
#10 0x0000555555fd1dba in helper_set_cp_reg64 (env=0x555557d291f0, rip=0x555557da23b0, value=2147483663) at ../../target/arm/tcg/op_helper.c:839
#11 0x00007fff60056781 in code_gen_buffer ()

Avoid this unsupported and slightly odd combination by
disabling SME when SVE is not present.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2005
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
'-cpu sve=off,sme=on,sme_fa64=off' crashes in the same way, so just
turning off FA64 isn't sufficient.  Maybe we should support
SME-no-SVE, but for 8.2 at least turning off SME is better than
letting users hit an assertion.
---
 target/arm/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 25e9d2ae7b8..0fe268ac785 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1743,6 +1743,15 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
 
+        /*
+         * FEAT_SME is not architecturally dependent on FEAT_SVE (unless
+         * FEAT_SME_FA64 is present). However our implementation currently
+         * assumes it, so if the user asked for sve=off then turn off SME also.
+         */
+        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
+            object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
+        }
+
         arm_cpu_sme_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.34.1


