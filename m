Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7464773761
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:12:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8K-0008KA-0e; Mon, 07 Aug 2023 23:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8F-0008F3-5i; Mon, 07 Aug 2023 23:11:39 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8D-0008VN-08; Mon, 07 Aug 2023 23:11:38 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-56d455462c2so2573860eaf.2; 
 Mon, 07 Aug 2023 20:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464294; x=1692069094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/ZvPprF7EhR5iTohUEXU14+rKjINMUPIVmqhU8o4NA=;
 b=KybHgjr9YY0nmjrsqlXrNYSNhubjDJcjLeWkok2kNHVGXtq6SiG0Ld8SVXvJWSSzNR
 JoGEY627Qm7DXhVCt7KSV9JgG7v1lC6dYm0VFv7LwY2U25pSFjUpZGQuVwQaMB1i5s+C
 ywbb5MHT0yXx3nRfjGadsHmo8cRezeO2c9PgA3t3+0F/V0pEcGEEifIGLw4ohyxw71oI
 OmNfIXaKiX22VyLqJrQxRQzEpUsvklfjN1X+dqkNlE3Tx45zR4tJxIwyEmheMnuw9W2+
 IbNMqOMR3Zutc//QICHY9mkegEek65enpRSSw+au6O5Gg4ogbu/Q80zoFEgeHG/6yXje
 Xf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464294; x=1692069094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/ZvPprF7EhR5iTohUEXU14+rKjINMUPIVmqhU8o4NA=;
 b=GfEenxDIJU+z1vGldEAYSXBpp8Un7H211e7bNDE7AwatcSYlBWp2u+Xc+Y+yclq0pt
 K61NCuzIM39WaSkE6GG2Tp9qxOO0vrvpfNiN3TnHyy50Su8C+ESvNCS1sO9z33fvHa1c
 nXeI01Ff+h10OUFgpXXB+C8PujEz0Lpeb3LlGUyvUDp7Wm5RQuq4eXNPDg5DrAh5T0Hq
 86fNxa+xjDdVBrZdLNEJHokOcP3Zzt/6Rc8bf4Tug4su3qCwYZkLP+7UXUUqggC+sFNb
 9ZSzr3+yRV9+jj/lMoztdgAjLHbVosGojXqFvu4H7GZP6D0b2/ePZdRQxcFFvLoFbVVi
 uvEA==
X-Gm-Message-State: AOJu0YxPGLXME8+OgwJiyZ8jkIbsWxvYQJosW7k2XBGqPAGvLl1tEI0w
 pOtJQtOV0Y97cN0Pe7EQPIs=
X-Google-Smtp-Source: AGHT+IHFe4W/qhAWBKmQlJs5xTxZTlp+6fepkC2aKR3kdmcbbUXgL/OHVtmrznyid32bGD6NjZeupA==
X-Received: by 2002:a05:6808:213:b0:3a7:56a1:9bbe with SMTP id
 l19-20020a056808021300b003a756a19bbemr10872463oie.45.1691464294384; 
 Mon, 07 Aug 2023 20:11:34 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa79095000000b00687ce7c6540sm482642pfa.99.2023.08.07.20.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/ppc: Improve book3s branch trace interrupt for
 v2.07S
Date: Tue,  8 Aug 2023 13:11:12 +1000
Message-Id: <20230808031116.398205-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808031116.398205-1-npiggin@gmail.com>
References: <20230808031116.398205-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Improve the emulation accuracy of the single step and branch trace
interrupts for v2.07S. Set SRR1[33]=1, and set SIAR to completed
instruction address.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 16 +++++++++++++++-
 target/ppc/helper.h      |  1 +
 target/ppc/translate.c   | 21 +++++++++++----------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9aa8e46566..2d6aef5e66 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1571,9 +1571,11 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             }
         }
         break;
+    case POWERPC_EXCP_TRACE:     /* Trace exception                          */
+        msr |= env->error_code;
+        /* fall through */
     case POWERPC_EXCP_DSEG:      /* Data segment exception                   */
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
-    case POWERPC_EXCP_TRACE:     /* Trace exception                          */
     case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
     case POWERPC_EXCP_PERFM:     /* Performance monitor interrupt            */
         break;
@@ -3168,6 +3170,18 @@ void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 }
 #endif /* TARGET_PPC64 */
 
+/* Single-step tracing */
+void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
+{
+    uint32_t error_code = 0;
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        /* Load/store reporting, SRR1[35, 36] and SDAR, are not implemented. */
+        env->spr[SPR_POWER_SIAR] = prev_ip;
+        error_code = PPC_BIT(33);
+    }
+    raise_exception_err(env, POWERPC_EXCP_TRACE, error_code);
+}
+
 void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
                                  int mmu_idx, uintptr_t retaddr)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index abec6fe341..f4db32ee1a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -32,6 +32,7 @@ DEF_HELPER_2(read_pmc, tl, env, i32)
 DEF_HELPER_2(insns_inc, void, env, i32)
 DEF_HELPER_1(handle_pmc5_overflow, void, env)
 #endif
+DEF_HELPER_2(book3s_trace, void, env, tl)
 DEF_HELPER_1(check_tlb_flush_local, void, env)
 DEF_HELPER_1(check_tlb_flush_global, void, env)
 #endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 06530dd782..5051596670 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -338,8 +338,9 @@ static void gen_ppc_maybe_interrupt(DisasContext *ctx)
  * The exception can be either POWERPC_EXCP_TRACE (on most PowerPCs) or
  * POWERPC_EXCP_DEBUG (on BookE).
  */
-static uint32_t gen_prep_dbgex(DisasContext *ctx)
+static void gen_debug_exception(DisasContext *ctx)
 {
+#if !defined(CONFIG_USER_ONLY)
     if (ctx->flags & POWERPC_FLAG_DE) {
         target_ulong dbsr = 0;
         if (ctx->singlestep_enabled & CPU_SINGLE_STEP) {
@@ -352,16 +353,16 @@ static uint32_t gen_prep_dbgex(DisasContext *ctx)
         gen_load_spr(t0, SPR_BOOKE_DBSR);
         tcg_gen_ori_tl(t0, t0, dbsr);
         gen_store_spr(SPR_BOOKE_DBSR, t0);
-        return POWERPC_EXCP_DEBUG;
+        gen_helper_raise_exception(cpu_env,
+                                   tcg_constant_i32(POWERPC_EXCP_DEBUG));
+        ctx->base.is_jmp = DISAS_NORETURN;
     } else {
-        return POWERPC_EXCP_TRACE;
+        TCGv t0 = tcg_temp_new();
+        tcg_gen_movi_tl(t0, ctx->cia);
+        gen_helper_book3s_trace(cpu_env, t0);
+        ctx->base.is_jmp = DISAS_NORETURN;
     }
-}
-
-static void gen_debug_exception(DisasContext *ctx)
-{
-    gen_helper_raise_exception(cpu_env, tcg_constant_i32(gen_prep_dbgex(ctx)));
-    ctx->base.is_jmp = DISAS_NORETURN;
+#endif
 }
 
 static inline void gen_inval_exception(DisasContext *ctx, uint32_t error)
@@ -4184,7 +4185,7 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 static void gen_lookup_and_goto_ptr(DisasContext *ctx)
 {
     if (unlikely(ctx->singlestep_enabled)) {
-        gen_debug_exception(ctx);
+        gen_debug_exception(ctx, false);
     } else {
         /*
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
-- 
2.40.1


