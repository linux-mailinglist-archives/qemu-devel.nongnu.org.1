Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678D71620B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOa-0000a3-QM; Tue, 30 May 2023 09:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMZ-0005Vm-DN; Tue, 30 May 2023 09:26:22 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMW-0001IQ-QV; Tue, 30 May 2023 09:26:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d41763796so3249486b3a.2; 
 Tue, 30 May 2023 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685453165; x=1688045165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGD4jDYB/Ab8J80PqrqMHdSvac+MGxjnb+U7C/k+OH0=;
 b=V6YV+i6kB4ve7ZCRIFcdQlkQWjybLIR5dptE4kbuJP79y0zSJH76QP8vj/DRK0bXWB
 Z3AGt0gilTZXaSorjaS1eU3BkBm7XyxD0QORJgXe2oMn1QQG70Vc47UtSfu8JRWiIW4H
 kYvcxsdfMrIz5vzXM7yaupaUEN+KpRGftuknOmkBSjtXY4SRBwYv1Ys3BO3ZMCjt+ex7
 u1mrZAWotIa3yAkWk7StjmsZgf3KWXd5qVVpm7Eyxf8tWJmKh880q1CVwoB5NtPb+HcX
 lNWAUkXPBHKD2UXI8bjEboN4msidmaTUcElCpLueioVbme9mJ5jfAE7pnNFLfE8b8Rjm
 stug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453165; x=1688045165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGD4jDYB/Ab8J80PqrqMHdSvac+MGxjnb+U7C/k+OH0=;
 b=bq15oaRRX9RqUybV/YtY4or5S9vuGof5P5NBKpyrEzYvAtofY4fdyvBgqXiGx34t5u
 OKGD4h871Q1j6T94/IIZFkN5nIay8O0rNO5Z9M4aJZfcncg2MuBbubqtWbLXXR1pFLwl
 ra3TiAPzHSm0t5X/dMFUzBTJFmfbTUUTWOjRKOlWQ5cAecS7Mwt/Ahje2eOXgcC9UrrA
 qDoAxsGx/4dPivTS9HI0ebf9U2SmvaN2e39X9I46Y9OFOrLW1I/C+64fplwugMr6hl46
 sSrmUa3pUJqLau/80l0dSSIOocV4bhfNB9bvMx4ZQQz+PWFUNh98bZgqzaHVZeQaEf0a
 HxoQ==
X-Gm-Message-State: AC+VfDy7pwXwnOssNKcc/8t5mzUUo0AX4DUr2VJJjwXIYCHDAoxSFUtG
 Veq4RXQlqT9KHfjilmlJScHmYmfoQl4=
X-Google-Smtp-Source: ACHHUZ4ntiQryWDXE6FS7cPZ4jxCiLS1I59S6WrHI5XVyRbdOl1DCftNKXKk2AnMOzD5vU54gLT6ag==
X-Received: by 2002:a05:6a20:9c8f:b0:10e:d4fb:b034 with SMTP id
 mj15-20020a056a209c8f00b0010ed4fbb034mr2339702pzb.28.1685453165332; 
 Tue, 30 May 2023 06:26:05 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 w32-20020a634920000000b0050927cb606asm8601514pga.13.2023.05.30.06.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 2/6] target/ppc: Change partition-scope translate interface
Date: Tue, 30 May 2023 23:25:39 +1000
Message-Id: <20230530132543.385138-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530132543.385138-1-npiggin@gmail.com>
References: <20230530132543.385138-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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


