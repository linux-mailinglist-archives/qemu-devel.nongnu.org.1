Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5193781479D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6wB-0001po-0v; Fri, 15 Dec 2023 07:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rE6w8-0001oz-M5; Fri, 15 Dec 2023 07:05:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rE6w4-0005Yc-Uw; Fri, 15 Dec 2023 07:05:00 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d03bcf27e9so1746025ad.0; 
 Fri, 15 Dec 2023 04:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702641893; x=1703246693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LKL7A/4y0EV0K9CdqxxQlXzAdjXSHdcVNW4RQjZQx1s=;
 b=GLmNIw85G11eqq1FBHNvwgQuRv1OypUl0vp3B6jDhScNsuq+02yfT6uBnmfJ+eFZeM
 yqEhHsaq+w/dCIGxDp9VF41L4G0gzYSxod1oD/PoKrQ3swD2EiCcfGNcvcXO5pg+ZVZ/
 sIoFohXCzIj0Sa/YIazy0ayeJNEpSWgjfztKVt6WtVXg2xbyz434P73X6UVCOYqLGRnp
 NOnk0IrxjxJxdveiCaPNGFb/fDd1RydSvJiX8izcHik7fLYdPclTxqkjanH7Y01VlcUT
 Kr6jKO4NO7WdoDQvPRCFS0XwdHm55rCLe6QjMEnkHUqpH56iaL7EOA7dWZkvYtBdsHNB
 aZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702641893; x=1703246693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKL7A/4y0EV0K9CdqxxQlXzAdjXSHdcVNW4RQjZQx1s=;
 b=SiUmThPwN/+x3cI8aEWEEa2b3/E8CHxPdIxzH12CTddccfdGrSLuG4zsh6fa1I9BNN
 g3nIR62HcFT6vuaRdM4Xuo2kJuMKJxMRA4rc9yLV3lgE9q2wI82rGHjs/VUXCCVpRkHq
 FmA64eOd/iWVHgn5QohznWmBmUgxlz1aEEEWZvwzKy4ynp1B0j4/VFDeUTY7tdCszRhs
 aV9MOfle6fV9x/HNKb6SCd731tGAhMS8JW7s4EsaVPk0TgJkLwBfJBDklkHILIrh+ZnD
 Oij7sdsiBMJr+aysZkae1qd4Oco3SUphtbZFZg0shnJukbn78lMR6rJGWXtq8qQOOMMm
 r4qQ==
X-Gm-Message-State: AOJu0Yy+6n4qIC4kppWUXPgUp9tuV5WDptTADKmPnke5UZGFuXiVNagg
 jPU/k0TrXs4pZGhCi/gy0y125HQ81u0=
X-Google-Smtp-Source: AGHT+IFvhMXbUjR7t45BiA614S26oKVE3sLU1EPo5skfAfmvNFr9kY1vuuze/CAMnAywbuvMDvmbiw==
X-Received: by 2002:a17:902:a58b:b0:1d0:8d57:482 with SMTP id
 az11-20020a170902a58b00b001d08d570482mr5952135plb.50.1702641893157; 
 Fri, 15 Dec 2023 04:04:53 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a170902f7c600b001d38cae83e9sm811032plw.104.2023.12.15.04.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 04:04:52 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH] target/xtensa: fix OOB TLB entry access
Date: Fri, 15 Dec 2023 04:03:07 -0800
Message-Id: <20231215120307.545381-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
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

r[id]tlb[01], [iw][id]tlb opcodes use TLB way index passed in a register
by the guest. The host uses 3 bits of the index for ITLB indexing and 4
bits for DTLB, but there's only 7 entries in the ITLB array and 10 in
the DTLB array, so a malicious guest may trigger out-of-bound access to
these arrays.

Change split_tlb_entry_spec return type to bool to indicate whether TLB
way passed to it is valid. Change get_tlb_entry to return NULL in case
invalid TLB way is requested. Add assertion to xtensa_tlb_get_entry that
requested TLB way and entry indices are valid. Add checks to the
[rwi]tlb helpers that requested TLB way is valid and return 0 or do
nothing when it's not.

Cc: qemu-stable@nongnu.org
Fixes: b67ea0cd7441 ("target-xtensa: implement memory protection options")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/mmu_helper.c | 47 ++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 12552a33470e..2fda4e887cce 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -224,22 +224,31 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
  * Split TLB address into TLB way, entry index and VPN (with index).
  * See ISA, 4.6.5.5 - 4.6.5.8 for the TLB addressing format
  */
-static void split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
-        uint32_t *vpn, uint32_t *wi, uint32_t *ei)
+static bool split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
+                                 uint32_t *vpn, uint32_t *wi, uint32_t *ei)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         *wi = v & (dtlb ? 0xf : 0x7);
-        split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
+        if (*wi < (dtlb ? env->config->dtlb.nways : env->config->itlb.nways)) {
+            split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
+            return true;
+        } else {
+            return false;
+        }
     } else {
         *vpn = v & REGION_PAGE_MASK;
         *wi = 0;
         *ei = (v >> 29) & 0x7;
+        return true;
     }
 }
 
 static xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
                                               unsigned wi, unsigned ei)
 {
+    const xtensa_tlb *tlb = dtlb ? &env->config->dtlb : &env->config->itlb;
+
+    assert(wi < tlb->nways && ei < tlb->way_size[wi]);
     return dtlb ?
         env->dtlb[wi] + ei :
         env->itlb[wi] + ei;
@@ -252,11 +261,14 @@ static xtensa_tlb_entry *get_tlb_entry(CPUXtensaState *env,
     uint32_t wi;
     uint32_t ei;
 
-    split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei);
-    if (pwi) {
-        *pwi = wi;
+    if (split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+        if (pwi) {
+            *pwi = wi;
+        }
+        return xtensa_tlb_get_entry(env, dtlb, wi, ei);
+    } else {
+        return NULL;
     }
-    return xtensa_tlb_get_entry(env, dtlb, wi, ei);
 }
 
 static void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
@@ -482,7 +494,12 @@ uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
         const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
+
+        if (entry) {
+            return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
+        } else {
+            return 0;
+        }
     } else {
         return v & REGION_PAGE_MASK;
     }
@@ -491,7 +508,12 @@ uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 uint32_t HELPER(rtlb1)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 {
     const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, NULL);
-    return entry->paddr | entry->attr;
+
+    if (entry) {
+        return entry->paddr | entry->attr;
+    } else {
+        return 0;
+    }
 }
 
 void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
@@ -499,7 +521,7 @@ void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
         xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        if (entry->variable && entry->asid) {
+        if (entry && entry->variable && entry->asid) {
             tlb_flush_page(env_cpu(env), entry->vaddr);
             entry->asid = 0;
         }
@@ -537,8 +559,9 @@ void HELPER(wtlb)(CPUXtensaState *env, uint32_t p, uint32_t v, uint32_t dtlb)
     uint32_t vpn;
     uint32_t wi;
     uint32_t ei;
-    split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei);
-    xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
+    if (split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+        xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
+    }
 }
 
 /*!
-- 
2.39.2


