Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51819741E1D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 04:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEhDF-0002z4-Dy; Wed, 28 Jun 2023 22:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEhDD-0002yk-Eq; Wed, 28 Jun 2023 22:16:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEhDB-0003rW-Ui; Wed, 28 Jun 2023 22:16:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-666e5f0d60bso135831b3a.3; 
 Wed, 28 Jun 2023 19:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688005004; x=1690597004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s4c7Sgx/93gSokEUelG5dbtuYQZty7ljPHE65dMHeeo=;
 b=AKmHBv0tWPd76R0mG1el44LnGzpUNrOtBVsm47uauzDqarQlZxtWusnYE89Gr5SHI7
 clKZGopDnr1j6ASmnvLAT/HJts6QefjPuH7LVQ9lUo1XeuUUtMj2jp81HzLPh+o1GltX
 Y4gtb6JmNnUcb40T3UEV1W9wg4WJYgPTOXDZRvY37PB/CtWCRFe2U+YJmaz/k6VFOq3e
 Ms9dyWq21tLl3Vhgd53S655wIUkjSnrhBYvZLzqomtx/U+83nQ80s3BVKOuRCJew8FTU
 ze5zORZFFClpyyhoUY8Pbt+QRD8Ph+MlVEEPu5fq64phMCn+GYNHOLUDNaLgaQUpoWiA
 IuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688005004; x=1690597004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4c7Sgx/93gSokEUelG5dbtuYQZty7ljPHE65dMHeeo=;
 b=EWrr0fHr3KLuyVTixirNKefBcYefMmtoGMK+aOW1p8er4SrsEvVuvivrodVyoHTCm6
 zmlxqXQh1Vc6TdMnsggSp3MBSye7bOKkHJ7Aluml/REYps51cpsCqjIgSWzU4CHJ5aKg
 IrZcLblZ3qBQqVjCtLhKRWIfSR/egpHS1DiLN5gepx0SDTiJucttpqNnlIq2QTr4OHsR
 HJaMsekiqq1rqm1mlybDHdvpvqYiKxSpAPLiweMjm5bb4i19FNNu7tHqCv7eJaVanJJ4
 QIK1YV3Du3IjirqRLeaDBAjRdZghAA7XvXofMIeibwz5y8F5b9f+fjpJTT9yVQ2WSxc5
 cv/g==
X-Gm-Message-State: AC+VfDxSnJ26Hi68RBnSHNre5yS0lFuab5u0FP8sGO87W2PLuKdbuoDx
 EWj6/jy6YAmnpR0QaT4+VNdLCmmplUw=
X-Google-Smtp-Source: ACHHUZ52dI7DLw7rrZYhFypLQYbDHUqqv7jEi1n+ijlJU1Yfmwz+64/JGee1G4jYCHlCyqYfUJhNHw==
X-Received: by 2002:a05:6a21:329e:b0:10e:d90f:35d5 with SMTP id
 yt30-20020a056a21329e00b0010ed90f35d5mr31881668pzb.51.1688005003770; 
 Wed, 28 Jun 2023 19:16:43 -0700 (PDT)
Received: from wheely.local0.net ([125.254.1.121])
 by smtp.gmail.com with ESMTPSA id
 5-20020aa79145000000b0063b96574b8bsm7480123pfi.220.2023.06.28.19.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 19:16:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [RFC PATCH 0/3] ppc/pnv: SMT support for powernv
Date: Thu, 29 Jun 2023 12:16:30 +1000
Message-Id: <20230629021633.328916-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

These patches implement enough to boot a SMT powernv machine to Linux
and boot a SMP KVM guest inside that.

There are a few more SPRs that need to be done, and per-LPAR SPRs are
mostly not annotated yet so it can't run in 1LPAR mode. But it is
enough to run skiboot/Linux with SMT so I'll just post the minimal
patches for RFC because the concept isn't really different to add
more SPRs and things.

Thanks,
Nick

Nicholas Piggin (3):
  target/ppc: Add LPAR-per-core vs per-thread mode flag
  target/ppc: SMT support for the HID SPR
  ppc/pnv: SMT support for powernv

 hw/ppc/pnv.c             | 12 ++++++++++++
 hw/ppc/pnv_core.c        | 13 +++++--------
 hw/ppc/spapr_cpu_core.c  |  2 ++
 target/ppc/cpu.h         |  3 +++
 target/ppc/cpu_init.c    | 14 +++++++++++++-
 target/ppc/helper.h      |  1 +
 target/ppc/misc_helper.c | 21 +++++++++++++++++++++
 target/ppc/spr_common.h  |  1 +
 target/ppc/translate.c   | 32 +++++++++++++++++++++++++++++---
 9 files changed, 87 insertions(+), 12 deletions(-)

-- 
2.40.1


