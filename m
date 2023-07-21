Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E30675BD9D
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 07:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMiIf-0004Ze-VC; Fri, 21 Jul 2023 01:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMiIW-0004VO-MP; Fri, 21 Jul 2023 01:03:25 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMiIS-0004aw-Sp; Fri, 21 Jul 2023 01:03:23 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b9e478e122so1284315a34.1; 
 Thu, 20 Jul 2023 22:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689915799; x=1690520599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phXZeq9Ur7lbdALZ37vSJEfCXdyT8OPHeW6nkwT00e4=;
 b=HdfXT7IUun3OOPPOMNl8oFBze4tUUCqIBskpRiKsD0nKo86w8riGZGTr6Jwo60DDO6
 NixVZI5YHxwFnsENXRwHRvS8mAwE+bqfUeWZFmBNbifO39b656dCshiNqibIGb5ooe7i
 PrF9IaC+++v9jWXuuUubVyXKnvIM2Jvj9lw2/AUIdizOkMzWD/ry9tgRgdkXM0ZKQHgx
 wjfS409tJ99LmuLqWT045y6m/kmSBqmSmA37se1BPJQIM3bDTJiLh4c12VZOZatpCzru
 10c/8X8RXLeTt/8Y5/htU0YEqakqXLS2RbqWEV8XUdqZgRgJqz/m+WLlp6CFPUOueDZS
 w3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689915799; x=1690520599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phXZeq9Ur7lbdALZ37vSJEfCXdyT8OPHeW6nkwT00e4=;
 b=KceZofcFvgSPHvI6VkQOPqJSSc8tIFX/GrkY8r1PcsGh2fYBZhZFdIx/Nqj53nRjt/
 SFKLPP3zMvexqA3YliYkANV2oLOXyNHSNoWIzoTcRqqBM7vVN4zwd1pNX9u+F4WPdlzT
 gPyO0WQXrQnoeK/q8AonTawuNzJUGcDJ5JsD1wMethM40vpNsP+Z5e7r6jHV4Roev/2+
 87qS8sYwybuiElwLVLjdQyjDYQSVRziyEgPIdjmnN9Gz5SGGbt9+ZbXXFWzcceWGryN8
 BrrKhEMKoNqsOZjbZ93eztxx241QWa2Y8/bTMbGFB5ui+EZMdve8ulgKlHBeXtqZFGJx
 mStw==
X-Gm-Message-State: ABy/qLYjYsWFMJLAMDomnfI01fcbBmVmgvFx7gAm19IKvh+OH1ghs8Wr
 74xlyCGl/MRl/U5c3nelpU8=
X-Google-Smtp-Source: APBJJlE9xKsL8q3Yn4sJID7cXzG2crlMn4gHeIA3OTS+KNzIIG47RQLSsgRu4Nt4FRsIde2UA9YwvA==
X-Received: by 2002:a05:6358:2495:b0:133:c03:53c6 with SMTP id
 m21-20020a056358249500b001330c0353c6mr1040097rwc.14.1689915798976; 
 Thu, 20 Jul 2023 22:03:18 -0700 (PDT)
Received: from wheely.local0.net ([203.220.77.10])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a63330d000000b0056001f43726sm2129444pgz.92.2023.07.20.22.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 22:03:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 2/2] target/ppc: Fix VRMA page size for ISA v3.0
Date: Fri, 21 Jul 2023 15:02:55 +1000
Message-Id: <20230721050255.100090-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721050255.100090-1-npiggin@gmail.com>
References: <20230721050255.100090-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x334.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash64.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index a0c90df3ce..bda0ba90ea 100644
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
+            error_report("Bad VRMA with no partition table entry\n");
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


