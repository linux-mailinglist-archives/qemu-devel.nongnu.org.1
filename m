Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F38AFBCC
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 00:34:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOfx-0001FV-U7; Tue, 23 Apr 2024 18:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOfp-0001BC-3s; Tue, 23 Apr 2024 18:31:37 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOfm-0004eV-6M; Tue, 23 Apr 2024 18:31:36 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9E3934E6041;
 Wed, 24 Apr 2024 00:31:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id hFCN8lY1dhdw; Wed, 24 Apr 2024 00:31:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AFF044E603D; Wed, 24 Apr 2024 00:31:30 +0200 (CEST)
Message-Id: <ee789bbbb42581becf437c101be3b9fdc14ac5a2.1713907038.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1713907038.git.balaton@eik.bme.hu>
References: <cover.1713907038.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 19/24] target/ppc: Move mmu_ctx_t definition to mmu_common.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 24 Apr 2024 00:31:30 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This type is only used within mmu_common.c. Move its definition from
internal.h to there.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h   | 12 ------------
 target/ppc/mmu_common.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 3e4423ce0d..b835b2cba0 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -255,8 +255,6 @@ static inline int prot_for_access_type(MMUAccessType access_type)
 
 /* PowerPC MMU emulation */
 
-typedef struct mmu_ctx_t mmu_ctx_t;
-
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
@@ -264,16 +262,6 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 /* Software driven TLB helpers */
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code);
-/* Context used internally during MMU translations */
-struct mmu_ctx_t {
-    hwaddr raddr;      /* Real address              */
-    hwaddr eaddr;      /* Effective address         */
-    int prot;                      /* Protection bits           */
-    hwaddr hash[2];    /* Pagetable hash values     */
-    target_ulong ptem;             /* Virtual segment ID | API  */
-    int key;                       /* Access key                */
-    int nx;                        /* Non-execute area          */
-};
 
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 5ba8d2460d..244830c196 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -35,6 +35,17 @@
 
 /* #define DUMP_PAGE_TABLES */
 
+/* Context used internally during MMU translations */
+typedef struct {
+    hwaddr raddr;      /* Real address             */
+    hwaddr eaddr;      /* Effective address        */
+    int prot;          /* Protection bits          */
+    hwaddr hash[2];    /* Pagetable hash values    */
+    target_ulong ptem; /* Virtual segment ID | API */
+    int key;           /* Access key               */
+    int nx;            /* Non-execute area         */
+} mmu_ctx_t;
+
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-- 
2.30.9


