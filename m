Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F15D672ABBC
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhe-0004kR-AS; Sat, 10 Jun 2023 09:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yha-0004jn-7f; Sat, 10 Jun 2023 09:32:22 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhY-0007eE-K8; Sat, 10 Jun 2023 09:32:21 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-55b77d50465so93865eaf.0; 
 Sat, 10 Jun 2023 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403939; x=1688995939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhjrjAHVfDmMP6keqerIsH20Muxa9kDhjH4N6Qa7GQQ=;
 b=n0qzAksFXImeqbALnp4yBMtBIgMevm+g3+SmiuwZyZdbV0+0UBUL2Q1lSR339aL4+U
 F4/44VYsFx7O+eyli5y7pmK8AFDfyYdW2RdWsH4BZGgIgqcfYKn2C+JRuCg4TQ3rniXG
 iU3po+D61EXWjmsXTDZpdQ9/oJaqQQE5gsGcYCHjJfESZfKraYWwMZDNp5zP19Gw8uFf
 kJdQ4jPD6cN6DYZbeg/iyLnvAGhs4fBoz0L+wszUyLzSGvTn5Aqgb6Mr6Rdp4sGlKbrV
 TtyaZM4E+RsFMoNLeRbF7yDmsPJlenMnY6ygcjuTzhusjxEGI6eB0hO5y1He6e3Vws20
 Kjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403939; x=1688995939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhjrjAHVfDmMP6keqerIsH20Muxa9kDhjH4N6Qa7GQQ=;
 b=EgXOHla301EJP0cO33gLjRDlfLdYI/FC4Ygwg0BmYeTS4O+IsgtPC13zjXA3xpiDgq
 7RSAczsI6X64/FUkUNg88ScFrmuPklwe2k3occJ9U/rV+y71lNWgEE7vj5ZUiVG2BEAC
 rIE38y8xOHkuIpm070O+BVSINAHkZLwcvwp3aaRwrbEXPlJBCyrpxgo5JUvBGaN14TET
 ShQLSUAfh+bJF5c01irTJizkDqwG+mekSevilZ30XaDEW8xPjT5X7o8LF61+ZQ+1b+78
 LPtpOGkOilgLQvhWdbU/VNld0sk6PV33g5gVjLtlvpFMrg20XLu5i2uStkcTXS6fcdR5
 8SMQ==
X-Gm-Message-State: AC+VfDx7Nxtgq0eV6Dp82D55MNmiIm72MFSOx3r6pErNBfMiLIjzfHno
 04NxPdT7FQDvsTBDzW/hnHjme5FwxHg=
X-Google-Smtp-Source: ACHHUZ4nvLdqyuu7rj82pK8pTZDK7K3mT/LqfU6eECIBVW8pqBBH4rqHfrCG+Q5+VkKnES4e6GwCZQ==
X-Received: by 2002:a05:6808:1598:b0:39a:bde6:3eed with SMTP id
 t24-20020a056808159800b0039abde63eedmr855886oiw.10.1686403938955; 
 Sat, 10 Jun 2023 06:32:18 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:18 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 16/29] target/ppc: Remove some unneded line breaks
Date: Sat, 10 Jun 2023 10:31:19 -0300
Message-Id: <20230610133132.290703-17-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Make lines shorter and fix indentation in some functions prototypes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <70952ba2d82141db1cf5cfcf4b227402be575874.1685448535.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu.h        | 8 +++-----
 target/ppc/mmu_common.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8001582d52..c7c2a5534c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1424,12 +1424,10 @@ void store_booke_tsr(CPUPPCState *env, target_ulong val);
 void ppc_tlb_invalidate_all(CPUPPCState *env);
 void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
-int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
-                            hwaddr *raddrp, target_ulong address,
-                            uint32_t pid);
+int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
+                     target_ulong address, uint32_t pid);
 int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
-hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
-                                        ppcmas_tlb_t *tlb);
+hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
 #endif
 
 void ppc_store_fpscr(CPUPPCState *env, target_ulong val);
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 845eee4c6f..a84bc7de88 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -694,8 +694,7 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     return ret;
 }
 
-hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
-                                        ppcmas_tlb_t *tlb)
+hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb)
 {
     int tlbm_size;
 
@@ -705,9 +704,8 @@ hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
 }
 
 /* TLB check function for MAS based SoftTLBs */
-int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
-                            hwaddr *raddrp, target_ulong address,
-                            uint32_t pid)
+int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
+                     target_ulong address, uint32_t pid)
 {
     hwaddr mask;
     uint32_t tlb_pid;
-- 
2.40.1


