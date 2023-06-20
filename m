Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A69736CC6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBb8V-0007Jt-J5; Tue, 20 Jun 2023 09:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8U-0007JT-7W; Tue, 20 Jun 2023 09:11:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8P-0000AI-Ff; Tue, 20 Jun 2023 09:11:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6686a05bc66so1805536b3a.1; 
 Tue, 20 Jun 2023 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687266659; x=1689858659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dq9QLHk3SCarxrgZcKKe0CkJMeecWY83BLaEKFPBBJA=;
 b=Kwzx3LIP4g5E2andKzT3weOFZ1q98L31nMD1Oc3JLVN2iSgb/8ILVgYN3gSMZDiv0W
 8tiudb6c/3zFNJzfnuRYNlPyVvAxFCLwaLp075vL2L3rldJEa6ddYohT3+/+2KQUgUKq
 /KGWy2OKJlrRZaXNbg7MiR0XVjQAdvk0wdpcCYBT0f1EHHs9L6w8sNuBnm5BDjmi9s38
 3I3u1P/nr/C9IK9BkI6M7TgFjy/2ThFM4AFqGU4Awe+0Et7zDLLutl8sUdOuDDeJifmc
 zanI1qJK9kaqE2Yy3p65QYE4TIeMTkUa6BjH/cKbP8Hg6eSuFh5G6yXBzR+3KqcZKcqX
 4ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687266659; x=1689858659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dq9QLHk3SCarxrgZcKKe0CkJMeecWY83BLaEKFPBBJA=;
 b=hrRRvaT5c11trH1So6hzd/WSe8roTDn6FePoV8dFBIzzFZn+HyivM2sHkBz/Hc40uv
 op0cFrPHf48Uf8dFEMOCQ1Dv76yP042xuqlALOC8sIWEaZ2Zb6NmceaTW5q317D9fNiv
 AoWZ19P7KhiYwCjAV3GyX3ugA89sNFChjMTOTLnShaWQ1zZT6Em6jXvXFBMghOLS0qRi
 p1N+eIZrmnl/jLdWRFK43qABIUcf6JUu+UcSuMKhpwsWUEg18yB1ZGOQKTVpJmLYBstj
 NU1VTG/vDpYDcPF1iql/twhbK7GLVWTYzzYi7Lh/erg2g3ZtqoEApLM4t8CCUSgeyy4W
 3HbA==
X-Gm-Message-State: AC+VfDwh2f4UIJkBYzLTvFZ/e0MMx9j6++EWr0ghu6962R+nPUoXRNso
 +wjJZaV72xCRNS+BppphPDqFQptN4xc=
X-Google-Smtp-Source: ACHHUZ6mWBQJD4sfJMHX6aI1mUFNT/qfFWOcr9B0PLkAsttrgITMYX99BTMAQ/g78z4KfeFqfcwbMw==
X-Received: by 2002:a05:6a00:2d8c:b0:668:95c1:b4f7 with SMTP id
 fb12-20020a056a002d8c00b0066895c1b4f7mr2210168pfb.27.1687266659184; 
 Tue, 20 Jun 2023 06:10:59 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 w5-20020aa78585000000b00652a72b89d1sm1353285pfn.170.2023.06.20.06.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:10:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PATCH 0/4] target/ppc: Fixes for instruction-related
Date: Tue, 20 Jun 2023 23:10:40 +1000
Message-Id: <20230620131044.169110-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

Because they got more complexities than I first thought, these patches
are broken out from the bigger series here:

https://lists.gnu.org/archive/html/qemu-ppc/2023-05/msg00425.html

Since then I fixed the --disable-tcg compile bug reported by Anushree
hopefully. Also added a workaround for KVM so injected interrupts
wouldn't attempt to find the prefix bit setting. I don't know how much
that is really needed, but injection callers would have to set it one
way or anohter if we need to add it.

Thanks,
Nick

Nicholas Piggin (4):
  target/ppc: Fix instruction loading endianness in alignment interrupt
  target/ppc: Change partition-scope translate interface
  target/ppc: Add SRR1 prefix indication to interrupt handlers
  target/ppc: Implement HEIR SPR

 target/ppc/cpu.h         |   1 +
 target/ppc/cpu_init.c    |  23 ++++++++
 target/ppc/excp_helper.c | 110 ++++++++++++++++++++++++++++++++++++++-
 target/ppc/mmu-radix64.c |  38 ++++++++++----
 4 files changed, 159 insertions(+), 13 deletions(-)

-- 
2.40.1


