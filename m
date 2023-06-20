Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F83736CC8
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:12:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBb8e-0007MY-Ef; Tue, 20 Jun 2023 09:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8Z-0007L9-AG; Tue, 20 Jun 2023 09:11:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8X-0000BT-13; Tue, 20 Jun 2023 09:11:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-666683eb028so2603231b3a.0; 
 Tue, 20 Jun 2023 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687266667; x=1689858667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGD4jDYB/Ab8J80PqrqMHdSvac+MGxjnb+U7C/k+OH0=;
 b=c0KD1bIqTza+UE7k7vT6m6WU41rIOo1COetHiYWK57N2SoQyK+cxZ9vFovWjE/HQE7
 N9PqwPpgpEW6mN+fAYU/6HpaKhG4nPKToxpf06hhAgRJivBYMKRyCPbSw78rpWaD0TAE
 G2+mJhYGwEFXP9l2sSaLm7W3nUWyqw5ccoiszh0lZjt2ap6alHIfx8T2e5sHKagL39Yc
 e0ezYftzLVcxGpBLt5Ys1nuQt8nMHmeckY8azdCgaDXUFt7NNRds/6+67YTdCxTY+mqk
 VtjFckgjLW74x1sXccDJut+5sM2ph9FocAiqwj9wSZPUY1kg3gcuCpoDJ71UecYlNWTr
 NhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687266667; x=1689858667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGD4jDYB/Ab8J80PqrqMHdSvac+MGxjnb+U7C/k+OH0=;
 b=bL4mXpDyBGhtNWJkmOJxur8o8A3YXkV62hcvf+kJOoFj6XvhKz4j2Tw5mxPWa9gY9Q
 qpvaxDmXotWFxcAMeGd8k4YRfPqhJV2ACpq5zjLC3cWWSpo6dcvCul4coOpOfyhUsU5q
 /hbrZqXkvyiaqaiEcQ37XfSYBBjy7HFTk/yA2LtO9MDI67cMBzoyZVhHp0xq2PFMJmIx
 Urh3hggPQgRyf8ZTboyJgNrWgPTCS79ePbQlgUnmNVmJ7zVX0aCw8eC8BQV3sNnWCJOt
 HA0+88AdFHCPaj6Ysmng9S/FWl1cGJnMbHBsYqY1NRilwB7lFI0kvBZABK7f41joMr9P
 bP8Q==
X-Gm-Message-State: AC+VfDwei/ASK23X3sbbajYCZQPT2dwTLGuR2QGY4lCgsbgW+2Dha9cb
 /n9vsf/KtEWohe7nI5RSyj4c/CQDuRk=
X-Google-Smtp-Source: ACHHUZ7KqnVlMpAH49YPkKOe+7eHQwrLSoMbJvzH/1OgeiQSAkEeRo4MBz6Msis0MwvCCfJezgzfwg==
X-Received: by 2002:a05:6a00:1355:b0:668:7209:1866 with SMTP id
 k21-20020a056a00135500b0066872091866mr4952185pfu.3.1687266666426; 
 Tue, 20 Jun 2023 06:11:06 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 w5-20020aa78585000000b00652a72b89d1sm1353285pfn.170.2023.06.20.06.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:11:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PATCH 2/4] target/ppc: Change partition-scope translate interface
Date: Tue, 20 Jun 2023 23:10:42 +1000
Message-Id: <20230620131044.169110-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620131044.169110-1-npiggin@gmail.com>
References: <20230620131044.169110-1-npiggin@gmail.com>
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

Rather than always performing partition scope page table translation
with access type of 0 (MMU_DATA_LOAD), pass through the processor
access type which first initiated the translation sequence. Process-
scoped page table loads are then set to MMU_DATA_LOAD access type in
the xlate function.

This will allow more information to be passed to the exception
handler in the next patch.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-radix64.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 031efda0df..1fc1ba3ecf 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -380,6 +380,14 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu,
     hwaddr pte_addr;
     uint64_t pte;
 
+    if (pde_addr) {
+        /*
+         * Translation of process-scoped tables/directories is performed as
+         * a read-access.
+         */
+        access_type = MMU_DATA_LOAD;
+    }
+
     qemu_log_mask(CPU_LOG_MMU, "%s for %s @0x%"VADDR_PRIx
                   " mmu_idx %u 0x%"HWADDR_PRIx"\n",
                   __func__, access_str(access_type),
@@ -477,10 +485,10 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
          * is only used to translate the effective addresses of the
          * process table entries.
          */
-        ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_addr,
-                                                 pate, &h_raddr, &h_prot,
-                                                 &h_page_size, true,
-            /* mmu_idx is 5 because we're translating from hypervisor scope */
+        /* mmu_idx is 5 because we're translating from hypervisor scope */
+        ret = ppc_radix64_partition_scoped_xlate(cpu, access_type, eaddr,
+                                                 prtbe_addr, pate, &h_raddr,
+                                                 &h_prot, &h_page_size, true,
                                                  5, guest_visible);
         if (ret) {
             return ret;
@@ -519,11 +527,11 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
          * translation
          */
         do {
-            ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pte_addr,
-                                                     pate, &h_raddr, &h_prot,
-                                                     &h_page_size, true,
             /* mmu_idx is 5 because we're translating from hypervisor scope */
-                                                     5, guest_visible);
+            ret = ppc_radix64_partition_scoped_xlate(cpu, access_type, eaddr,
+                                                     pte_addr, pate, &h_raddr,
+                                                     &h_prot, &h_page_size,
+                                                     true, 5, guest_visible);
             if (ret) {
                 return ret;
             }
-- 
2.40.1


