Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F9D72ABB2
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhF-0004S9-9d; Sat, 10 Jun 2023 09:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhD-0004Rk-I2; Sat, 10 Jun 2023 09:31:59 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhB-0007ag-VD; Sat, 10 Jun 2023 09:31:59 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-392116b8f31so1084076b6e.2; 
 Sat, 10 Jun 2023 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403916; x=1688995916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOEa2w/fkURRqcuIxb/Ag8RczwbXIRPEzS5xPskCu5Y=;
 b=pZiaOOX384qzwVHzT6m7sdIMsyfNjDSVzGUW6PyMsfW2iRJt6syixSyJs4vxbYuzDc
 /Id/8rYMLeEGCDVzC5rNLtI+GEVtAkqb8MokFyHj7Medbw94/vLfwF6x4DPMueb0KcXa
 DeWdxd+xKkx34NTa9XEElzIf0KmU2YIXb6U3+nvqymOthj2xwRlJc6/RrlmbH/i1u37+
 gLcFPYQwMtO7a0ypldC4rpYk5sIobMYgtQXCHNcOlVSy/M6VgjDz2nxI8hnmxUFQaHoL
 zpYJbfn3hgQ7rjib//rGhf1g/7U2VfNNxGNMGXfZkKzOe+kC0gmV3vW4wZu8ZQ8cGSlu
 Oy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403916; x=1688995916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOEa2w/fkURRqcuIxb/Ag8RczwbXIRPEzS5xPskCu5Y=;
 b=Mv1vWUMBFTYkLaXj46DOY4Iyag9tkN6LMsFn2GWQkEAxzcGjJlN2iDyWA9OSksk5UY
 WlkDOYKXePQjUm9lS8XIoPyROjboneSChhORCzagLaja8vx0JCg8Uu9pb9qYbUkBNy4b
 PD9FbevSUSFjUdBOVgJ7urMmJkTmAfCRgnc4ke3YmXoujLPhTutmCmUa1hktuxFbWB/n
 QQA1fu4Xz0o+nVXjW0JuoYA6UWnhEvJMuZWLJ8w6tHol+xt4xVd3359XYZ2fGeK5e8dq
 4Ul6DtpzByrdA50dRrL+RKL/uVRKwe6MkunFKhUI82lByyrX8UEInYtXVRrwA392sTy2
 U4Kg==
X-Gm-Message-State: AC+VfDyXWUHj32cloBFH4DR6Y6GOlPhIiS0T4vWmiB752H6U1v+nNVVi
 EBL9KhkSqh/zn+g220e/CjBZ7o8I/H4=
X-Google-Smtp-Source: ACHHUZ41CkjvoOOtDDqL/U0nfY4HbEJve5cr6sM9eQGF070eWdWuk4qbpehcNslVVYqlB0Kx3ozYkA==
X-Received: by 2002:a05:6808:3087:b0:39c:785a:9751 with SMTP id
 bl7-20020a056808308700b0039c785a9751mr1075816oib.32.1686403916046; 
 Sat, 10 Jun 2023 06:31:56 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:31:55 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 balaton@eik.bme.hu, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 06/29] target/ppc: Fix nested-hv HEAI delivery
Date: Sat, 10 Jun 2023 10:31:09 -0300
Message-Id: <20230610133132.290703-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22b.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

ppc hypervisors turn HEAI interrupts into program interrupts injected
into the guest that executed the illegal instruction, if the hypervisor
doesn't handle it some other way.

The nested-hv implementation failed to account for this HEAI->program
conversion. The virtual hypervisor wants to see the HEAI when running
a nested guest, so that interrupt type can be returned to its KVM
caller.

Fixes: 7cebc5db2eba6 ("target/ppc: Introduce a vhyp framework for nested HV support")
Cc: balaton@eik.bme.hu
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230530132127.385001-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fea9221501..9ffcfe788a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1358,9 +1358,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     /*
      * We don't want to generate a Hypervisor Emulation Assistance
-     * Interrupt if we don't have HVB in msr_mask (PAPR mode).
+     * Interrupt if we don't have HVB in msr_mask (PAPR mode),
+     * unless running a nested-hv guest, in which case the L1
+     * kernel wants the interrupt.
      */
-    if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB)) {
+    if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB) &&
+            !books_vhyp_handles_hv_excp(cpu)) {
         excp = POWERPC_EXCP_PROGRAM;
     }
 
-- 
2.40.1


