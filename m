Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3D832FFA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 21:47:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQvl8-0006U2-VG; Fri, 19 Jan 2024 15:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rQvl1-0006TP-UE
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:46:31 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rQvkz-0001ks-NW
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:46:31 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso808600a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705697186; x=1706301986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnKS2tclZ5bJf53FKgdfNiEv7tdESOK/QA8q3wd0prg=;
 b=C4gGc+uRowkfZdBkv3FU5lvCAnAaCQGda2t6nV9yE9kaWp1nwXPsRR5KqlmLL7h7ot
 Tue5Ngd9uFfnriSSxK2PzOkzevqDpFNl9pTo+zw1tm5UMExulos1TgEPu+b1Ta8L1ISC
 bz+YNJiT5+Msf/I5Wld/A6PlId94MD53DkxkR4sZ9c2BMGBpFkprRqQW7S9/0Zq8Od34
 ytmJij4ygubDYma7ZTELdRh3B3lp6SQOBFxW1DWaNppI+F69Sl4Ow9hTiyrayikC+LFZ
 JdKCk0M+ZCgLYI6/o5cb3of+bljGY5NaZwg5D8eW6kFnjj7EZMcdcwrAMqnGX7Qt1Ql1
 tCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705697186; x=1706301986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnKS2tclZ5bJf53FKgdfNiEv7tdESOK/QA8q3wd0prg=;
 b=thnwPYHLPsvL0qGRz4LuMhJL5PqS4MWLJKuUysjuEWFI27ttPugy18Z+HQENN5ME1v
 FwlVPbCNZ+0/Cjp28PMOjXvVk+lZSs1gh8vJ/28oKu34vbzxvStoMvozn5/wzm4GOVdr
 cRFNoUy3zwa3bmOjBPj+2+Lc/4guq2mUePKTTUzOfPi+IjucsEGp3hUvP/Ha0qv4NP1P
 ErSdPsT3pVLkhm7jm27QF3nXFez1YHzEwH6MptzGLp+13vV/mw7A7Y09Xwkb7ZCXqjJ3
 kuuhIO+vjtY3TpmSTRtkXxpe7h3WDIA2XUkq3qlw0kMrRzlPVwgg2hEdO2DlE5dJgpMM
 vUsA==
X-Gm-Message-State: AOJu0YwsJ/5ygtE5tlP5Ij5MLwU3NOSOkRlDBsZiWTHlEJ03Fk7UEu92
 cpwMpiyFuqS6fXc064YQHU7es9ASteNSdqzBm2u7R4LGRGcb7wmvXupi3Dl/
X-Google-Smtp-Source: AGHT+IEiR6RKbc7yoVRsZoHTEBAMYV+3NT1RUGDYEJotS76b1wK5KvtpzIrXvy9EIIsWsQ4C7CcN+Q==
X-Received: by 2002:a05:6a20:4323:b0:19b:21cb:cee4 with SMTP id
 h35-20020a056a20432300b0019b21cbcee4mr455266pzk.116.1705697186615; 
 Fri, 19 Jan 2024 12:46:26 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 kq9-20020a056a004b0900b006db85b12036sm5535228pfb.137.2024.01.19.12.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 12:46:26 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] target/xtensa: tidy TLB way variability logic
Date: Fri, 19 Jan 2024 12:46:08 -0800
Message-Id: <20240119204608.779541-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119204608.779541-1-jcmvbkbc@gmail.com>
References: <20240119204608.779541-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Whether TLB ways 5 and 6 are variable is not a property of the TLB
instance or a TLB entry instance, it's a property of the xtensa core
configuration.
Remove 'varway56' field from the xtensa_tlb structure and remove
'variable' field from the xtensa_tlb_entry structure. Add
'tlb_variable_way' array to the XtensaConfig and use it instead of
removed fields.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h          |  3 +--
 target/xtensa/mmu_helper.c   | 38 ++++++++++--------------------------
 target/xtensa/overlay_tool.h | 15 ++++++++++++--
 3 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 497325466397..24d3f15ea1bf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -316,13 +316,11 @@ typedef struct xtensa_tlb_entry {
     uint32_t paddr;
     uint8_t asid;
     uint8_t attr;
-    bool variable;
 } xtensa_tlb_entry;
 
 typedef struct xtensa_tlb {
     unsigned nways;
     const unsigned way_size[10];
-    bool varway56;
     unsigned nrefillentries;
 } xtensa_tlb;
 
@@ -493,6 +491,7 @@ typedef struct XtensaConfig {
 
     xtensa_tlb itlb;
     xtensa_tlb dtlb;
+    bool tlb_variable_way[16];
 
     uint32_t mpu_align;
     unsigned n_mpu_fg_segments;
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index d9f845e7fb6f..414c2f5ef669 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -105,23 +105,19 @@ static uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
                                          bool dtlb, uint32_t way)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        bool varway56 = dtlb ?
-            env->config->dtlb.varway56 :
-            env->config->itlb.varway56;
-
         switch (way) {
         case 4:
             return 0xfff00000 << get_page_size(env, dtlb, way) * 2;
 
         case 5:
-            if (varway56) {
+            if (env->config->tlb_variable_way[5]) {
                 return 0xf8000000 << get_page_size(env, dtlb, way);
             } else {
                 return 0xf8000000;
             }
 
         case 6:
-            if (varway56) {
+            if (env->config->tlb_variable_way[6]) {
                 return 0xf0000000 << (1 - get_page_size(env, dtlb, way));
             } else {
                 return 0xf0000000;
@@ -150,11 +146,8 @@ static uint32_t get_vpn_mask(const CPUXtensaState *env, bool dtlb, uint32_t way)
         return xtensa_tlb_get_addr_mask(env, dtlb, way) << 2;
     } else if (way <= 6) {
         uint32_t mask = xtensa_tlb_get_addr_mask(env, dtlb, way);
-        bool varway56 = dtlb ?
-            env->config->dtlb.varway56 :
-            env->config->itlb.varway56;
 
-        if (varway56) {
+        if (env->config->tlb_variable_way[5]) {
             return mask << (way == 5 ? 2 : 3);
         } else {
             return mask << 1;
@@ -172,10 +165,6 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
                                      bool dtlb, uint32_t *vpn,
                                      uint32_t wi, uint32_t *ei)
 {
-    bool varway56 = dtlb ?
-        env->config->dtlb.varway56 :
-        env->config->itlb.varway56;
-
     if (!dtlb) {
         wi &= 7;
     }
@@ -195,7 +184,7 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
             break;
 
         case 5:
-            if (varway56) {
+            if (env->config->tlb_variable_way[5]) {
                 uint32_t eibase = 27 + get_page_size(env, dtlb, wi);
                 *ei = (v >> eibase) & 0x3;
             } else {
@@ -204,7 +193,7 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
             break;
 
         case 6:
-            if (varway56) {
+            if (env->config->tlb_variable_way[6]) {
                 uint32_t eibase = 29 - get_page_size(env, dtlb, wi);
                 *ei = (v >> eibase) & 0x7;
             } else {
@@ -290,7 +279,7 @@ static void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
     xtensa_tlb_entry *entry = xtensa_tlb_get_entry(env, dtlb, wi, ei);
 
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        if (entry->variable) {
+        if (env->config->tlb_variable_way[wi]) {
             if (entry->asid) {
                 tlb_flush_page(cs, entry->vaddr);
             }
@@ -338,29 +327,25 @@ static void reset_tlb_mmu_all_ways(CPUXtensaState *env,
     for (wi = 0; wi < tlb->nways; ++wi) {
         for (ei = 0; ei < tlb->way_size[wi]; ++ei) {
             entry[wi][ei].asid = 0;
-            entry[wi][ei].variable = true;
         }
     }
 }
 
 static void reset_tlb_mmu_ways56(CPUXtensaState *env,
-                                 const xtensa_tlb *tlb,
                                  xtensa_tlb_entry entry[][MAX_TLB_WAY_SIZE])
 {
-    if (!tlb->varway56) {
+    if (!env->config->tlb_variable_way[5]) {
         static const xtensa_tlb_entry way5[] = {
             {
                 .vaddr = 0xd0000000,
                 .paddr = 0,
                 .asid = 1,
                 .attr = 7,
-                .variable = false,
             }, {
                 .vaddr = 0xd8000000,
                 .paddr = 0,
                 .asid = 1,
                 .attr = 3,
-                .variable = false,
             }
         };
         static const xtensa_tlb_entry way6[] = {
@@ -369,13 +354,11 @@ static void reset_tlb_mmu_ways56(CPUXtensaState *env,
                 .paddr = 0xf0000000,
                 .asid = 1,
                 .attr = 7,
-                .variable = false,
             }, {
                 .vaddr = 0xf0000000,
                 .paddr = 0xf0000000,
                 .asid = 1,
                 .attr = 3,
-                .variable = false,
             }
         };
         memcpy(entry[5], way5, sizeof(way5));
@@ -401,7 +384,6 @@ static void reset_tlb_region_way0(CPUXtensaState *env,
         entry[0][ei].paddr = ei << 29;
         entry[0][ei].asid = 1;
         entry[0][ei].attr = 2;
-        entry[0][ei].variable = true;
     }
 }
 
@@ -414,8 +396,8 @@ void reset_mmu(CPUXtensaState *env)
         env->mmu.autorefill_idx = 0;
         reset_tlb_mmu_all_ways(env, &env->config->itlb, env->mmu.itlb);
         reset_tlb_mmu_all_ways(env, &env->config->dtlb, env->mmu.dtlb);
-        reset_tlb_mmu_ways56(env, &env->config->itlb, env->mmu.itlb);
-        reset_tlb_mmu_ways56(env, &env->config->dtlb, env->mmu.dtlb);
+        reset_tlb_mmu_ways56(env, env->mmu.itlb);
+        reset_tlb_mmu_ways56(env, env->mmu.dtlb);
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
         unsigned i;
 
@@ -521,7 +503,7 @@ void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
         xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        if (entry && entry->variable && entry->asid) {
+        if (entry && env->config->tlb_variable_way[wi] && entry->asid) {
             tlb_flush_page(env_cpu(env), entry->vaddr);
             entry->asid = 0;
         }
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 701c00eed20a..268a7fe1823f 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -351,7 +351,6 @@
             (refill_way_size), (refill_way_size), \
             4, (way56) ? 4 : 2, (way56) ? 8 : 2, 1, 1, 1, \
         }, \
-        .varway56 = (way56), \
         .nrefillentries = (refill_way_size) * 4, \
     }
 
@@ -363,7 +362,19 @@
 
 #define TLB_SECTION \
     .itlb = ITLB(XCHAL_HAVE_SPANNING_WAY), \
-    .dtlb = DTLB(XCHAL_HAVE_SPANNING_WAY)
+    .dtlb = DTLB(XCHAL_HAVE_SPANNING_WAY), \
+    .tlb_variable_way = { \
+        true, \
+        XCHAL_HAVE_PTP_MMU, \
+        XCHAL_HAVE_PTP_MMU, \
+        XCHAL_HAVE_PTP_MMU, \
+        XCHAL_HAVE_PTP_MMU, \
+        XCHAL_HAVE_PTP_MMU && XCHAL_HAVE_SPANNING_WAY, \
+        XCHAL_HAVE_PTP_MMU && XCHAL_HAVE_SPANNING_WAY, \
+        XCHAL_HAVE_PTP_MMU, \
+        XCHAL_HAVE_PTP_MMU, \
+        XCHAL_HAVE_PTP_MMU, \
+    }
 
 #ifndef XCHAL_SYSROM0_PADDR
 #define XCHAL_SYSROM0_PADDR 0xfe000000
-- 
2.39.2


