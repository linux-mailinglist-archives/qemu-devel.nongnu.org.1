Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 801857476DE
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1G-0001ME-VM; Tue, 04 Jul 2023 12:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1E-0001Jx-6i
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1B-0001pJ-6z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3143b70d6easo1964283f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488599; x=1691080599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VCXSlv9PBlqNWlv08FHro1sfFi0JArXLUvRt7UUYed4=;
 b=m4etLuyCJXHo8lsBDWWsCkVfJNGu5WCznPshiCzz32kHKxiPnaOGNUcuK55flcCzWl
 WJy5PfnXm6Fb5Rn1XhBTnUA+VVJfB435B59wVt7QtVN4HDwmIx2AXtVuEEphVi1+wK5C
 UCgL5llciq/MAT9XQ5wluppk6XzVCKGKJikpXdPNErhbR298uuK8n2Hh1edBJMQmSClY
 kbrp2uzeCexialr0DTKrmiypCP3Yb7hQy4Xp3A4ZG+/uY4so/KeLEmUeiRvDZ6AI1zxd
 ZS8zfF/botD4dTZ/q//Gg9zFgYFHsZzbUgYpgnfzBe8KzYVon3Ew2wu8mIKuKWFf4GHK
 p0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488599; x=1691080599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCXSlv9PBlqNWlv08FHro1sfFi0JArXLUvRt7UUYed4=;
 b=kfiisAEB5z6swM6kWcTYkdSSVniEcfy+OGezkbtWGmm/h7LgGVDKrsIZPgXIU7LTh/
 H8VztuS1AqJihBxtMkwStZ2mvdaM5wdv3VOUsBqgFRPe8Yq7Xc4bJGe7p5YDaYDfaznm
 Su5ZX2N79xgizTj6kEe07BZXAJ8zldsLEqIEeYUVOj182pJfWHapsPxxbO4awJIfPYNl
 lg+AZbhHiBspeUoV4PBUr4+Uf4YkxcZMttHOiswafWdylCs9RtmT+hfaBq5UT7DggdyW
 DIzW6BDIAmN1vtVnBNms7kdRAIP8DfcWCOTfGingBsxty8Cxb88suf04QF9tvUUXLDgG
 jYJQ==
X-Gm-Message-State: ABy/qLYdaR2dzkEkPmBfe/bdAWudwq8MYp5S9moud7zmcvlsG7P9f5BQ
 HUVTrZupUF7fjVJ2JXGK2BsdEpGQ4vmbQWGCWxw=
X-Google-Smtp-Source: APBJJlGDj86lO/74E5DZ+KK/ZHsk2VH2UWzSvl5stCtsA7Bon6+A9hQNm3p2TJzC28stIHtKnV2pUw==
X-Received: by 2002:adf:e483:0:b0:30a:f030:8637 with SMTP id
 i3-20020adfe483000000b0030af0308637mr11570491wrm.22.1688488599547; 
 Tue, 04 Jul 2023 09:36:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
Date: Tue,  4 Jul 2023 17:36:32 +0100
Message-Id: <20230704163634.3188465-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
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

From: Fabiano Rosas <farosas@suse.de>

This code is only relevant when TCG is present in the build. Building
with --disable-tcg --enable-xen on an x86 host we get:

$ ../configure --target-list=x86_64-softmmu,aarch64-softmmu --disable-tcg --enable-xen
$ make -j$(nproc)
...
libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `m_sysreg_ptr':
 ../target/arm/gdbstub.c:358: undefined reference to `arm_v7m_get_sp_ptr'
 ../target/arm/gdbstub.c:361: undefined reference to `arm_v7m_get_sp_ptr'

libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `arm_gdb_get_m_systemreg':
../target/arm/gdbstub.c:405: undefined reference to `arm_v7m_mrs_control'

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-id: 20230628164821.16771-1-farosas@suse.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/gdbstub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 03b17c814f6..f421c5d041c 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -324,6 +324,7 @@ static int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
     return cpu->dyn_sysreg_xml.num;
 }
 
+#ifdef CONFIG_TCG
 typedef enum {
     M_SYSREG_MSP,
     M_SYSREG_PSP,
@@ -481,6 +482,7 @@ static int arm_gen_dynamic_m_secextreg_xml(CPUState *cs, int orig_base_reg)
     return cpu->dyn_m_secextreg_xml.num;
 }
 #endif
+#endif /* CONFIG_TCG */
 
 const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
 {
@@ -561,6 +563,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                              arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
                              "system-registers.xml", 0);
 
+#ifdef CONFIG_TCG
     if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) {
         gdb_register_coprocessor(cs,
             arm_gdb_get_m_systemreg, arm_gdb_set_m_systemreg,
@@ -575,4 +578,5 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
         }
 #endif
     }
+#endif /* CONFIG_TCG */
 }
-- 
2.34.1


