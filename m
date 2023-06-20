Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E933736CD0
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:14:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbBE-0002QE-N9; Tue, 20 Jun 2023 09:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBbAq-0002MN-3q; Tue, 20 Jun 2023 09:13:39 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBbAo-0000XQ-IZ; Tue, 20 Jun 2023 09:13:31 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-54fb23ff7d3so2205915a12.0; 
 Tue, 20 Jun 2023 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687266808; x=1689858808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A2Ryqj2jihkuku8uREInvaCHeFWX9x4zXtyu+izeImA=;
 b=rb3GiyvGRXCioJeoLpoCoLet0b10I/shyQ+sIk50qYVLEA5xbqnOni70PPoAzWfI7R
 cDnjmGJ48gwTEfGZF+IvN2vzhqrNvhxNu3IbAryqDmaxfGRvg1K206vq9clpE+Zy+4Vt
 woGksn7HYjKW5sqQlP6qBSKaKOk1RO6wMcpdx0Jy2OtUT2M08fs5iZ2/RsFWZPO0vOth
 F/QS5LASOyGajBWZzPPA5e/pB9dZQBBDuCyGyU9q/ENDOln9ZywfftgWtXibk92GyhAa
 d1hFG7UqrE2MHBw8tMCESpfMqSkmy9RpTvl6lfj7IOOTiA9Qm2+MJlV+5ZcNhSMOlLX9
 RlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687266808; x=1689858808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A2Ryqj2jihkuku8uREInvaCHeFWX9x4zXtyu+izeImA=;
 b=lx39d0tYVT8XwBAUjm1cAh+/zGdRou4qdBoHokSW8TdDE2daDF4Rfl7yb+ou/r0Cp7
 6SiNmLn5fJS+OwlPaUT+KUvW3N6Z01kt0qWroyGz0+4LO7f/YRZaxZVn6j2mNQV/fo01
 qkPRkHcvbqmBvlQPl4fjq+jcSjWBvHLOEQQDs4yNYhsdDCAet6h+Z9ZSuYrmqvOw5/qT
 TYy+h+IJe5wSnFp5aM0Vuc0ce5PnzsCSMewNzSSiN/YKz83Q8JTOQkEy3dmDQwJhf5uj
 IbgtKBjMRC2gfP+Kx6ibSCGpR7agLMWU0ToKmTOjGJ2DKgpiYPZv53rat7oviUNh25p8
 /FHQ==
X-Gm-Message-State: AC+VfDyU6UDDBrVwIO92/tmw/FnDf6jD/0Wp4vbcU874Ctoa1MxaIIfY
 cuut/ojianYI3JwrtvYNkgudLloJ3Ig=
X-Google-Smtp-Source: ACHHUZ6YwmaLkYP6tG/l+mzdk6cN2Qgsrn/SH+exkMfOl3lwpwFOzcjFFphPdTm7sfJukiCCcyJBrw==
X-Received: by 2002:a17:903:11c7:b0:1ae:7631:7fa9 with SMTP id
 q7-20020a17090311c700b001ae76317fa9mr8791403plh.37.1687266808338; 
 Tue, 20 Jun 2023 06:13:28 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 jo10-20020a170903054a00b001a183ade911sm1611325plb.56.2023.06.20.06.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:13:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH] target/ppc: Add ISA v3.1 LEV indication in SRR1 for system
 call interrupts
Date: Tue, 20 Jun 2023 23:13:21 +1000
Message-Id: <20230620131321.169261-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
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

System call interrupts in ISA v3.1 CPUs add a LEV indication in SRR1
that corresponds with the LEV field of the instruction that caused the
interrupt.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This is unchanged, just taken out of the bigger series since it is
independent.

Thanks,
Nick

 target/ppc/excp_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 77bfc18734..c7550fea13 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1591,6 +1591,10 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             vhc->hypercall(cpu->vhyp, cpu);
             return;
         }
+        if (env->insns_flags2 & PPC2_ISA310) {
+            /* ISAv3.1 puts LEV into SRR1 */
+            msr |= lev << 20;
+        }
         if (lev == 1) {
             new_msr |= (target_ulong)MSR_HVB;
         }
-- 
2.40.1


