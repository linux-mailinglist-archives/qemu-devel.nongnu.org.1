Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E77416C1
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYLI-0000IS-7c; Wed, 28 Jun 2023 12:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qEYLG-0000Gq-7C; Wed, 28 Jun 2023 12:48:30 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qEYLE-0006YF-EL; Wed, 28 Jun 2023 12:48:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EC3A2187A;
 Wed, 28 Jun 2023 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687970905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GKtSAjY/gybSB8YQ3UvrdFZTDzcvViwaB6S+q8mdJM4=;
 b=Qj5Am9D4o0JzWr9PCO/hJFW+Q7e3jTe1icbxvG5/zj4Q//fjLbpRngEyo8ZgXnY8F0Z4T9
 9OPcpelDUOBdU3/5kYMAysBJg2m7QLNy9ogn8wxfAw215wF1i4081/MQ7i4I4AJgSBOR8x
 H21wMRT5hJv28/2qM2qpLKOjjAEH65Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687970905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GKtSAjY/gybSB8YQ3UvrdFZTDzcvViwaB6S+q8mdJM4=;
 b=JCnH6XOQW2i4rzp8TpNJ1Fl/AiAPmYgx/6nB+tmf9VDWDcI5wEqj+DAPoBXIOy/3YAtxQG
 XSTuWR6Uo3e6BDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0F07138EF;
 Wed, 28 Jun 2023 16:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6d6vIldknGQjZAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 28 Jun 2023 16:48:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
Date: Wed, 28 Jun 2023 13:48:21 -0300
Message-Id: <20230628164821.16771-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
This is a respin of:
https://lore.kernel.org/r/20230313151058.19645-5-farosas@suse.de
---
 target/arm/gdbstub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 03b17c814f..f421c5d041 100644
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
2.35.3


