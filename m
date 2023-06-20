Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA3736CCA
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBb8b-0007LU-L3; Tue, 20 Jun 2023 09:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8W-0007Kb-JZ; Tue, 20 Jun 2023 09:11:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8T-0000Ac-79; Tue, 20 Jun 2023 09:11:08 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-668689ce13fso1403140b3a.0; 
 Tue, 20 Jun 2023 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687266663; x=1689858663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1n1bZ+D44uedI4wYVe5liTwhxzhBDGrrNBpEgbZTtF8=;
 b=Xtac5LsgdvqhfjkJI8J4/Ejmq974PZKeNJllGKlm64XWw1S2Mbe1sdP/e+qcUdE0YT
 qIl7TLD5rCHZO+puQglhp4Q0ZYK2fMdd4+PjAo1YLuHa4q13TC/+a8zO/FBCLxjUp6Dr
 8S5Y3uQ6MjPSVwluSigG2+Rot5ZCrq2coRbVykYC44iQwb+K+hm7WQIbGb3tHcV49Pjx
 t//v3Ruy3T0OZRS2u/l1XaaevIHTws9GSAR5ocBytCdbttVR39Zi06k3QD1gzHbANV+V
 qXxD/hUua0BVZSQ33HbQEwdqkODDMgyBXUiKnU1sxRKJTmaCUPBSTwDr9TxU774dljDB
 EjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687266663; x=1689858663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1n1bZ+D44uedI4wYVe5liTwhxzhBDGrrNBpEgbZTtF8=;
 b=C0Aa7fs2pMj05LWbd73gNxsD3DmevUVp6P7J7VYwF7WMRSaVevAzHdH65bifw2zfQ2
 RZEs9zqFKVrLUEitkAgCp+ZsmWk1ZHPMxKXSHKN9iPcaFd2b0F1l4kVvWzenGR7w3ZyJ
 Pnxs/Dnm+2r9QbJAQTFkG+KaMtLR0G9yi3T/qgWQjSmGhdWlf9Vsa5fAcO98N52/T3Tw
 Oq2kJYxnrs2ogVodOj/D/xUioBgPoHvH5j62AU6qt1yALBbDxdj+pD1b3HiWfvW/BTcC
 mbVFE8AOFPP2wUiVXv1uKUa6dC97FMfzjB1KewWPzOPmrWlJOoAQA2R35XrDE1AcD+hp
 rqyg==
X-Gm-Message-State: AC+VfDz0fyLrEsnb8nYwcqZiGaHvFZ80j5gteuvnK3c3G3PM5C/7gynO
 3UIoqSUTU+X+oKrtCAmB3vyclQElxIc=
X-Google-Smtp-Source: ACHHUZ59mk1z7BmwZqVfS84RnPQZBDDRiPrHdvj6qovzfbHXPqfVnTlFDGTwkZCOqr/kyoL9yfmgmA==
X-Received: by 2002:a05:6a21:158c:b0:10f:1e5d:83ea with SMTP id
 nr12-20020a056a21158c00b0010f1e5d83eamr7159896pzb.25.1687266662833; 
 Tue, 20 Jun 2023 06:11:02 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 w5-20020aa78585000000b00652a72b89d1sm1353285pfn.170.2023.06.20.06.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:11:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/4] target/ppc: Fix instruction loading endianness in
 alignment interrupt
Date: Tue, 20 Jun 2023 23:10:41 +1000
Message-Id: <20230620131044.169110-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620131044.169110-1-npiggin@gmail.com>
References: <20230620131044.169110-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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
index 12d8a7257b..a2801f6e6b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
                   env->nip);
 }
 
+#ifdef CONFIG_TCG
+/* Return true iff byteswap is needed to load instruction */
+static inline bool insn_need_byteswap(CPUArchState *env)
+{
+    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
+    return !!(env->msr & ((target_ulong)1 << MSR_LE));
+}
+
+static uint32_t ppc_ldl_code(CPUArchState *env, hwaddr addr)
+{
+    uint32_t insn = cpu_ldl_code(env, addr);
+
+    if (insn_need_byteswap(env)) {
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
@@ -3104,7 +3124,7 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
 
     /* Restore state and reload the insn we executed, for filling in DSISR.  */
     cpu_restore_state(cs, retaddr);
-    insn = cpu_ldl_code(env, env->nip);
+    insn = ppc_ldl_code(env, env->nip);
 
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_4xx:
-- 
2.40.1


