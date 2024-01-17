Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC8830952
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:13:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7b8-0004zr-Bi; Wed, 17 Jan 2024 10:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7b5-0004xu-QW; Wed, 17 Jan 2024 10:12:55 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7b4-0005b0-9h; Wed, 17 Jan 2024 10:12:55 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6d98ce84e18so9758218b3a.3; 
 Wed, 17 Jan 2024 07:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705504372; x=1706109172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEhUYaEQJBc9PWX41kqCw81BgFMu9+E/EpRKvxYNTOM=;
 b=CdFBZfxb0aYzGtQFCL11hyJW59KN/8/jMwXe+6Eic7Idq7f/X8W8Bfx7d+r4QSMNb5
 2tOOzARcU53BYnMFhRDOF6Q2EXEiXiFsliSaoQU3lAidel0uQVmy9L0rU6DSmmSE1i9o
 A+RSjshA+5kX6zGuz0z72L+TyKpBhmC5PXlfNtQ+qbaYAD4BubuscOiqvX+5K1KsixXi
 +6FgXEhSF49I8Vm7H5c8wIuoCLYLTJc2xgRufuJ25JGWFdgSeP01zTm6cUdpIxg0H2PJ
 dqxFZhhQHRrkxFLDkebfl59l1kKyrrb76m4dF9vcOQnu9oP5Z7Fuqxphon+k8IhWm2Jm
 1AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504372; x=1706109172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEhUYaEQJBc9PWX41kqCw81BgFMu9+E/EpRKvxYNTOM=;
 b=MMZTKx/0cf854ncijjkf9cQY3NZOqvnvBKwiWBbor0yXFPl1jvyYgRG4vHSsTQpZT4
 8BUaYlq94qQDKZ5RwTfz3s0oz9x7fFtQEAlHqrpuT5Cq8YjejI2wU4pdv3lsZTn5e39g
 rrFuuwaXt83/VWLfpPzCYUrAY7lGFM9H7awlMVt8dVDMsPiGJI0oRxsJ0zMYswjn832G
 BS37QymFh38Qpu1Lmv51fL3Kg5ouI2kxMoUioGRj+J+8Y8L3qd83elc1KR/loQ2yQDyy
 fS6KCrTcwTgupmDQciEiGtA18RqHzu6VJUj5ta1XEz0B383Pz7Y1tYfJaCNrGPlhR37d
 HePg==
X-Gm-Message-State: AOJu0YyVtyOQTlGAxKElRdGTfrWQ0TFKYj2OOxHqd4uO47pn3KbNUzsK
 AFWMQfEqoLiWB6WEsG+1SBhKjVLebx4=
X-Google-Smtp-Source: AGHT+IEKmc7rOMxQM71qSOe5RhQ7LGRQL41HuqX1KEMwDQxlEIjA/IfNYlHGfydOIQ8N1yJDf1IpZg==
X-Received: by 2002:a05:6a00:2d9b:b0:6db:7543:6952 with SMTP id
 fb27-20020a056a002d9b00b006db75436952mr8056193pfb.52.1705504371895; 
 Wed, 17 Jan 2024 07:12:51 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 fb42-20020a056a002daa00b006d9aa4b65fasm1586976pfb.98.2024.01.17.07.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:12:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/ppc: Factor out 4xx ppcemb_tlb_t flushing
Date: Thu, 18 Jan 2024 01:12:34 +1000
Message-ID: <20240117151238.93323-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117151238.93323-1-npiggin@gmail.com>
References: <20240117151238.93323-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

Flushing the TCG TLB pages that cache a software TLB is a common
operation, factor it into its own function.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c140f3c96d..949ae87f4f 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -749,12 +749,20 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
     return ret;
 }
 
+static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
+{
+    target_ulong ea;
+
+    for (ea = tlb->EPN; ea < tlb->EPN + tlb->size; ea += TARGET_PAGE_SIZE) {
+        tlb_flush_page(cs, ea);
+    }
+}
+
 void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     ppcemb_tlb_t *tlb;
-    target_ulong page, end;
 
     qemu_log_mask(CPU_LOG_MMU, "%s entry %d val " TARGET_FMT_lx "\n",
                   __func__, (int)entry,
@@ -763,13 +771,10 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
     tlb = &env->tlb.tlbe[entry];
     /* Invalidate previous TLB (if it's valid) */
     if (tlb->prot & PAGE_VALID) {
-        end = tlb->EPN + tlb->size;
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate old TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
-                      (int)entry, tlb->EPN, end);
-        for (page = tlb->EPN; page < end; page += TARGET_PAGE_SIZE) {
-            tlb_flush_page(cs, page);
-        }
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
     }
     tlb->size = booke_tlb_to_page_size((val >> PPC4XX_TLBHI_SIZE_SHIFT)
                                        & PPC4XX_TLBHI_SIZE_MASK);
@@ -805,13 +810,10 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
     /* Invalidate new TLB (if valid) */
     if (tlb->prot & PAGE_VALID) {
-        end = tlb->EPN + tlb->size;
         qemu_log_mask(CPU_LOG_MMU, "%s: invalidate TLB %d start "
                       TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
-                      (int)entry, tlb->EPN, end);
-        for (page = tlb->EPN; page < end; page += TARGET_PAGE_SIZE) {
-            tlb_flush_page(cs, page);
-        }
+                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
+        ppcemb_tlb_flush(cs, tlb);
     }
 }
 
-- 
2.42.0


