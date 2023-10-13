Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4ED7C7F4C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4x-00042Z-FZ; Fri, 13 Oct 2023 03:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4j-0002Io-6G
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4Y-0006xF-DG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso18658525e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183939; x=1697788739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6QeJL4Wo8y/3eJ5tOXyyC3SVwifvmBvfOxaBUO5XBE=;
 b=wcmlTeqaKEoPP6Ujo4/pZvgD4PuP11Ljxcpuy1M5EG5ptILanfeKlOm66V9RPzKz2b
 rTxe0a+9OZvayB9Fd7IGL23VAOnpcnJnVBl7Cpn1I3mfDk9MnBrKNq5lPgJlyVsropGx
 5rftLZ5SwI4BnK2qXS9A5BBohgjNYueAUvXo7IyO4kGRjxli4AxdnVHj09jUz0NOQTP9
 2Gym/ogNoz8ZjAZQaCHKOaKG1orcFDFO3glTE1zDq/7K6ohwr6ZWDmjeACQdxt4ASlNd
 +2ONyCE/3S2ZAkuJWpGO5BTtNJZsHj7aT70/iGr3wEZFOKjfM0Py6/hUSd3ux2k1O/zJ
 cCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183939; x=1697788739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6QeJL4Wo8y/3eJ5tOXyyC3SVwifvmBvfOxaBUO5XBE=;
 b=MQQWzyY3tXIA14AoqGubjpBdlKKnWWZvf5Y+9ZLkcjvt5HziOn4XNr1yN08HcCJ3eS
 ywUA0du5HAg6+j8gS8YahFp+o6ZjWwdbk0VkAlSLiHd2U3JhhoPTK0yOfYrU+JV0Qkso
 HbPPvBnh121+0RNapxPhd8cRVg3nH4b4s1T+7FLCxrX6qk/eWcWL6ZEQUKYt7WuID3DY
 ZsjfhD8IlouahV1aJY6VfEQyGngetqJB/DbkBe2C/XW4ACez8oBidODJFLUSQgQxOoDU
 +3RHMWI1O1apEBsa5r4TYud+XAWz34kij+Q8MQ+DjzKDIZO8uMGFc8kL8rMLZ2u1mAuv
 +18w==
X-Gm-Message-State: AOJu0Yy5v/rhy5YDvttxM++nrTvCgr8OEbtP6ETktXSwOYOAuOdN+17j
 tvgaDv+BaD3qSWysh3kC807qw828E+RIhJE3Two=
X-Google-Smtp-Source: AGHT+IFcMAAwpRr5p2ElYd0aR9XMpCsJJvY56jab6NmlXyh1LLBn9hPY0vccMxGyvZYar45qz3wf6g==
X-Received: by 2002:a7b:cd85:0:b0:406:599f:f92c with SMTP id
 y5-20020a7bcd85000000b00406599ff92cmr23162824wmj.20.1697183938980; 
 Fri, 13 Oct 2023 00:58:58 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:58 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [RFC PATCH v2 36/78] target/openrisc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:03 +0300
Message-Id: <2961833b638056d4af03da7531f085ea618e45a6.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/openrisc/mmu.c       | 2 +-
 target/openrisc/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 603c26715e..7ed744e81b 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -141,38 +141,38 @@ bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     int prot, excp, sr = cpu->env.sr;
     hwaddr phys_addr;
 
     switch (sr & (SR_DME | SR_IME)) {
     case SR_DME | SR_IME:
         /* The mmu is definitely enabled.  */
         excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
                             PAGE_READ,
                             (sr & SR_SM) != 0);
         if (!excp) {
             return phys_addr;
         }
         excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
                             PAGE_EXEC,
                             (sr & SR_SM) != 0);
         return excp ? -1 : phys_addr;
 
     default:
         /* The mmu is partially enabled, and we don't really have
            a "real" access type.  Begin by trying the mmu, but if
            that fails try again without.  */
         excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
                             PAGE_EXEC | PAGE_READ | PAGE_WRITE,
                             (sr & SR_SM) != 0);
         if (!excp) {
             return phys_addr;
         }
-        /* fallthru */
+        fallthrough;
 
     case 0:
         /* The mmu is definitely disabled; lookups never fail.  */
         get_phys_nommu(&phys_addr, &prot, addr);
         return phys_addr;
     }
 }
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ecff4412b7..de77014d60 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1588,53 +1588,53 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong jmp_dest;
 
     /* If we have already exited the TB, nothing following has effect.  */
     if (dc->base.is_jmp == DISAS_NORETURN) {
         return;
     }
 
     /* Adjust the delayed branch state for the next TB.  */
     if ((dc->tb_flags & TB_FLAGS_DFLAG ? 1 : 0) != (dc->delayed_branch != 0)) {
         tcg_gen_movi_i32(cpu_dflag, dc->delayed_branch != 0);
     }
 
     /* For DISAS_TOO_MANY, jump to the next insn.  */
     jmp_dest = dc->base.pc_next;
     tcg_gen_movi_tl(cpu_ppc, jmp_dest - 4);
 
     switch (dc->base.is_jmp) {
     case DISAS_JUMP:
         jmp_dest = dc->jmp_pc_imm;
         if (jmp_dest == -1) {
             /* The jump destination is indirect/computed; use jmp_pc.  */
             tcg_gen_mov_tl(cpu_pc, jmp_pc);
             tcg_gen_discard_tl(jmp_pc);
             tcg_gen_lookup_and_goto_ptr();
             break;
         }
         /* The jump destination is direct; use jmp_pc_imm.
            However, we will have stored into jmp_pc as well;
            we know now that it wasn't needed.  */
         tcg_gen_discard_tl(jmp_pc);
-        /* fallthru */
+        fallthrough;
 
     case DISAS_TOO_MANY:
         if (translator_use_goto_tb(&dc->base, jmp_dest)) {
             tcg_gen_goto_tb(0);
             tcg_gen_movi_tl(cpu_pc, jmp_dest);
             tcg_gen_exit_tb(dc->base.tb, 0);
             break;
         }
         tcg_gen_movi_tl(cpu_pc, jmp_dest);
         tcg_gen_lookup_and_goto_ptr();
         break;
 
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


