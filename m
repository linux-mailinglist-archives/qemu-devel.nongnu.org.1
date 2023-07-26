Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C36763E6C
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:28:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjAT-0003vr-Pa; Wed, 26 Jul 2023 14:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOj9w-0003rP-R5; Wed, 26 Jul 2023 14:22:54 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOj9u-0008Rq-TT; Wed, 26 Jul 2023 14:22:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686efb9ee3cso103421b3a.3; 
 Wed, 26 Jul 2023 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690395769; x=1691000569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/FtV0fq+M1oqQhY61vaP0OZ0xzxbuzvQTaIIl0I9dk=;
 b=bcROapOsw4QK/wccgMPX5/ousDa0Cp0wIuWAFAxnCKfsVO7K3Ka+jRg01yG6EqaC/r
 YH43+79VmtBMHrBGZlxiH5Uj7Q6VzJFm2LkwCleIHT/lX4kUXr91a/BUJeAufX2nDtKc
 I5dPBWPjAKaorTp5rDtLAgc+7tjx8NGrXBlaH99c2UCT0lO/9/mtBPRKZLQk9CD+W4JN
 UcIqftbEfult6demAi9hY8p83+vgYQa52jzKleN0H7Kdl1pxA3brDWEl1h8T+QKYnH1U
 5WfHU/dM1L7427WbPfgNkxt+4mtUZx5/D01/c7FzrK2aXcIVLUtfi9ZTzuS1mJjHJHA2
 6e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690395769; x=1691000569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/FtV0fq+M1oqQhY61vaP0OZ0xzxbuzvQTaIIl0I9dk=;
 b=XSqU5ip5D/jrKGdcEF+4i+OACSNRxWdpa3DXR3mHB1kDmpP1n3kvAuWR8PRv6D6Ttg
 CwEtGRK2/+roAfjhcA6bnr5nryT1mHOb2+VxZB81k1iGtLufjiGio5c62U9ouzn3LBoS
 Cgjjv6NkQzgb7gT99XzByzbsgyT+qAhrn743ZSEXcuYdUGXjxwhLrPnCst69cKVb8iPg
 QHa99mL2XXb7ZeWtynxRU0LdfBIfvbS9npMtXGn2nhduVSafKfuko+8DgaAbVLHXo5z1
 +GY//A6G+jPykUa0Nj1FFc9sUmrNnfJYLiRJDoCnBJVgzpbA+9rjHqvuCX8Ggzf3uPdM
 ilnA==
X-Gm-Message-State: ABy/qLb6X3lxfZTQh/bacDJiZabo4BOPLYNC6mFKuo6vKmxHOP31869g
 oSnNKySDPAf6b34ZCQnudx8=
X-Google-Smtp-Source: APBJJlEO6bqyGRrcTqB1M0HhzpCuq5jdwJ3ImsYBb6Y07JOkFWomg+J2HbwwwVbRaoV8G7BM0DYcEg==
X-Received: by 2002:a05:6a21:3381:b0:134:4de4:d5e6 with SMTP id
 yy1-20020a056a21338100b001344de4d5e6mr3698310pzb.57.1690395769308; 
 Wed, 26 Jul 2023 11:22:49 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a639319000000b0055adced9e13sm360185pge.0.2023.07.26.11.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:22:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/ppc: Fix VRMA page size for ISA v3.0
Date: Thu, 27 Jul 2023 04:22:26 +1000
Message-Id: <20230726182230.433945-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726182230.433945-1-npiggin@gmail.com>
References: <20230726182230.433945-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

Until v2.07s, the VRMA page size (L||LP) was encoded in LPCR[VRMASD].
In v3.0 that moved to the partition table PS field.

The powernv machine can now run KVM HPT guests on POWER9/10 CPUs with
this fix and the patch to add ASDR.

Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash64.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index a0c90df3ce..7f8bbbbdb0 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -874,12 +874,41 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
     return rma_sizes[rmls];
 }
 
-static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
+/* Return the LLP in SLB_VSID format */
+static uint64_t get_vrma_llp(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
-    target_ulong lpcr = env->spr[SPR_LPCR];
-    uint32_t vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
-    target_ulong vsid = SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LLP_MASK);
+    uint64_t llp;
+
+    if (env->mmu_model == POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+        uint64_t ps;
+
+        /*
+         * ISA v3.0 removes the LPCR[VRMASD] field and puts the VRMA base
+         * page size (L||LP equivalent) in the PS field in the HPT partition
+         * table entry.
+         */
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            error_report("Bad VRMA with no partition table entry");
+            return 0;
+        }
+        ps = pate.dw0 >> (63 - 58);
+        llp = ((ps & 0x4) << (63 - 55 - 2)) | ((ps & 0x3) << (63 - 59));
+
+    } else {
+        uint64_t lpcr = env->spr[SPR_LPCR];
+        target_ulong vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
+
+        llp = (vrmasd << 4) & SLB_VSID_LLP_MASK;
+    }
+
+    return llp;
+}
+
+static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
+{
+    target_ulong vsid = SLB_VSID_VRMA | get_vrma_llp(cpu);
     int i;
 
     for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
@@ -897,8 +926,8 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
         }
     }
 
-    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=0x"
-                 TARGET_FMT_lx, lpcr);
+    error_report("Bad VRMA page size encoding 0x" TARGET_FMT_lx,
+                 get_vrma_llp(cpu));
 
     return -1;
 }
-- 
2.40.1


