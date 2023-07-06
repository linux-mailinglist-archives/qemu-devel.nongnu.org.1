Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B116749D92
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOza-0004sg-2I; Thu, 06 Jul 2023 09:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzK-0004r0-5q
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOz8-0000sC-73
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso7497545e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649918; x=1691241918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VCXSlv9PBlqNWlv08FHro1sfFi0JArXLUvRt7UUYed4=;
 b=bncF3xl6HKSzdozLtx3UWPzc+sXVZ67RW9WYn/J5Mi/oeZnGdgOxGIhBX9a9CU1K06
 WF1rDOSDi2c99/eqIgVZQtPQKeW5kJMyY98iKROMU+kaZW1XXM0bEMFelTz20S2/GH6e
 B4fsmFgccHU+vWO72bjp9bGtZ2WHqdmWeIJGUeVGuqgcMk1tyX0Zwfe96Pp8WT1fV/wW
 R9aaw2VKMSxMk1unHZGZHS5hvp5ZxwzPcsTvbRUPG3zDSOdMwwnWHKfouPg7rzo30PgL
 UiZrOHL3iuigrSTH0h4TMjlvcENW0Tf4WakfJEX5tvvHBt7lJeXjPVeBqSUHyfOdp/MH
 FlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649918; x=1691241918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCXSlv9PBlqNWlv08FHro1sfFi0JArXLUvRt7UUYed4=;
 b=gjlqhfPYrOA4QfKiLoqMp7qb6Eqc0j+80SpeqrLQh+vLZ7K4bXB8lrlTF/fVqV26dY
 leTB6Ma5RAJxFCoSA3JSj4d/X6bLDo35HMDPIOfY2npt6bVNqZqgeRv14K27HTwRaDxe
 I+BNuxyKNH3X4h33wBKgngcSsLXy9ONJ262s6Rr0zneAAxUNstCp4cuvTQY5eSxiyX1a
 2wf5PQqlil13CpJmenulut+BIebdVDoo4B+TRz/YUOhQk8T9eNF0nlSbZbZpD77oA9zC
 AoQbv8xiMEFYjSJLoRAWQIzgdJclyJQo8mhuuWfasXzojSPgAMwNeqgg39VZ+6DY5RYf
 a0Yg==
X-Gm-Message-State: ABy/qLa2Mmv6o26yq8SGfCOYo8x4epmseouCmdJHgTjQQkDODCM9yHw9
 0JzUAHhwh3tC1EDsAOpdk3ytwL9l92GlPqhP8zE=
X-Google-Smtp-Source: APBJJlEBuinfFhPio00dKu+aJPEnXYN8pt3jQxQwh+EKksUbnKeLt0WHaCHwxpEszLliUnN8Q1w72Q==
X-Received: by 2002:a05:600c:ad2:b0:3fa:99d6:4798 with SMTP id
 c18-20020a05600c0ad200b003fa99d64798mr1470167wmr.37.1688649918155; 
 Thu, 06 Jul 2023 06:25:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/14] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
Date: Thu,  6 Jul 2023 14:25:07 +0100
Message-Id: <20230706132512.3534397-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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


