Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F17161BD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNM-0006Yy-2A; Tue, 30 May 2023 09:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMV-0005UQ-9S; Tue, 30 May 2023 09:26:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMS-0001HF-Gs; Tue, 30 May 2023 09:26:06 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d41d8bc63so3485426b3a.0; 
 Tue, 30 May 2023 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685453162; x=1688045162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3QIScmuQzaIohfpWQFR3b/kC71cZ/yTRgUXd7XpV0w=;
 b=DvhgGNVVMopo2YrmQ9RsyETO/AnWpxPBYYkuUcAmXrdHQoQAOmOZ8GTx13oJK5S2Ql
 6xm+sk5TMsT6KcTNFqSD/UkmcqRbUTfMgzYPGgRJASDwMcr7gWW5nOk18Rt1xoqA3hHH
 3+LkaAl9PwKmcJYA4EAlUCByqBn6PszTRQug+bqn4ukSyiNz+dAMybYMqKrLIFgxJN1z
 noxmurxH1aYxMgWygWYeL9LoPAlUo+MEcctUouwivGDrgg1CFwbv/nmHFG94kwT0ufWz
 G50LGDpvFvttVGaenPql7rt0OlhQeKNzrgS3XZPgvCbVt8z3jPVnDBE7iuvKJTeR91a+
 Sq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453162; x=1688045162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3QIScmuQzaIohfpWQFR3b/kC71cZ/yTRgUXd7XpV0w=;
 b=jNtBJNtXfpmPH2W/CG1ScX7CWkJyZfoRB0z1Y00aF0qTPQLe16QihgRRcn1Vp0Z6a2
 RFw+LShyOOkmQSAnAh9erdIryCuwGBInxN5lw4vFEfaepIU3Yqc/wriutnT7b/3sDG8J
 AYTB7gTUYUJXBuoT/H1mF/EeW+NTpaew96fHRbZJD44H2dnZTM/WPad76Qs6wBnpErt2
 uHTl220F68w+kFzYrsuN2y+p1M0Om4LA7f1R70VMGpQhnlbrXWaYxbR5MznUlwB0wqbG
 zQHNlz8G5vw4cr2Ir3SAh4OjasX8S2bSpp1lgpk20TL1DUknOLFdlesU6/d6feNQgngj
 DATA==
X-Gm-Message-State: AC+VfDxwlANbqaPvVPp0+qcShtUcw9lOot5k+I4Dk61nlto3/vFnisc0
 wV+9mx7xpEVcGs7PEFtph+jT169MGnk=
X-Google-Smtp-Source: ACHHUZ6GtVYS5ZJ2ZwhKzda5jf5GLMe3ZIc2asLXmEx1HO9m2FIifO47iH2VslwaADwCZK/fQvWNuA==
X-Received: by 2002:a05:6a20:a208:b0:10d:1abb:e31 with SMTP id
 u8-20020a056a20a20800b0010d1abb0e31mr1823847pzk.50.1685453162213; 
 Tue, 30 May 2023 06:26:02 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 w32-20020a634920000000b0050927cb606asm8601514pga.13.2023.05.30.06.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 1/6] target/ppc: Fix instruction loading endianness in
 alignment interrupt
Date: Tue, 30 May 2023 23:25:38 +1000
Message-Id: <20230530132543.385138-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530132543.385138-1-npiggin@gmail.com>
References: <20230530132543.385138-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
after cpu_ldl_code(). This corrects DSISR bits in alignment
interrupts when running in little endian mode.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c13f2afa04..0274617b4a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
                   env->nip);
 }
 
+#ifdef CONFIG_TCG
+/* Return true iff byteswap is needed in a scalar memop */
+static inline bool need_byteswap(CPUArchState *env)
+{
+    /* SOFTMMU builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
+    return !!(env->msr & ((target_ulong)1 << MSR_LE));
+}
+
+static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
+{
+    uint32_t insn = cpu_ldl_code(env, addr);
+
+    if (need_byteswap(env)) {
+        insn = bswap32(insn);
+    }
+
+    return insn;
+}
+#endif
+
 static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
 {
     const char *es;
@@ -3100,7 +3120,7 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
 
     /* Restore state and reload the insn we executed, for filling in DSISR.  */
     cpu_restore_state(cs, retaddr);
-    insn = cpu_ldl_code(env, env->nip);
+    insn = ppc_ldl_code(env, env->nip);
 
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_4xx:
-- 
2.40.1


