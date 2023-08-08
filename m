Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B6D77375E
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD88-0008D9-SL; Mon, 07 Aug 2023 23:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD84-0008Ca-Bx; Mon, 07 Aug 2023 23:11:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD82-0008U9-SZ; Mon, 07 Aug 2023 23:11:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso3761834b3a.3; 
 Mon, 07 Aug 2023 20:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464285; x=1692069085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TZyf5+UX5gxHs9CMMTgdol4anCPni50GyS0r2QCvvIo=;
 b=oyXVG0EYDfuvAnVeNRst75fgqsxVg5sRMnkTA2v7cKyBfDcGGSHRSr8oLbTcnPaDd5
 YpxQ+C3o81qDYmYuloMANcrlt306azBIppLfZHJ+8fvqVyQHDPa/m1RhAah36uoYVJU1
 8Me+10Av9HxRThAactvbF2mflqaphrwFrAUz3/0sbOK7FwrMa3Bj1t5ODBMfSr7ZkMhe
 TNd8cPXszRmrfHd7Qradn3rQYmIYZYv0EL9n1BMgSmbDroYbeY+oVUIVcyif/dkSkis2
 Bd7EB+8x0rLMyQm7dp1CSTL5mHIRZTn49IJirnV+i++k7Br8SOraiSmWaXVcXpbScxs4
 8hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464285; x=1692069085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZyf5+UX5gxHs9CMMTgdol4anCPni50GyS0r2QCvvIo=;
 b=FID6vChp2P4kuTnwHseCyCx3v3aUTaQsuVVQS6oPWu99cNBWy1RRYZsB4Ksj9W01VX
 ZRm49YTxnYq3fCIV9sQxrNZrhdpEJc1ohGpyiCUr52o34gydPtrKwYHyJRJ1r4X9wfC/
 coqLL3xjxL0aaCjwMd+iIQ1sunFH7VuLA0Yp9kQXddL+VAakFQHQjptojFGSOautjs5+
 c1GFJdKmTQt0hjNt79doZRZ4sHIav8OZbwdiHGf2LbZLbqmDmmO/jZk0hEHBmZCf6xLJ
 jGA6M9P5GpzIxKieYrD7kETr7Y+DN4EyzBQGNAbVny1lF3NSrmhBhxpaql2lwLv+8TRH
 v1TQ==
X-Gm-Message-State: AOJu0Yx7diD+yZdTdEGJgXLM2p1moUf7MGjJ6Vxv1M9Rfquu5rr6p+PM
 OfBmLlFvuJjNSqsSyzKfNblvN+fm41w=
X-Google-Smtp-Source: AGHT+IEdH/eqDXsqMooI1fzH69sytwwGzJM85M+oH9S1TDykYRoCTHjNnNy0h7tdu27MS1TiT/mSUg==
X-Received: by 2002:a05:6a20:196:b0:133:bf9a:dd16 with SMTP id
 22-20020a056a20019600b00133bf9add16mr10546245pzy.35.1691464285232; 
 Mon, 07 Aug 2023 20:11:25 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa79095000000b00687ce7c6540sm482642pfa.99.2023.08.07.20.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH for-8.2 0/6] ppc: debug facility improvements
Date: Tue,  8 Aug 2023 13:11:10 +1000
Message-Id: <20230808031116.398205-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I started out looking at this to reduce divergence of TCG and KVM
machines with 2nd DAWR. The divergence already exists with first
DAWR, so I don't want to tie the KVM 2nd DAWR enablement to this,
but it would be nice to ensure the caps and such for the 2nd DAWR
will also work for TCG.

I don't know that we have great test cases for this, it does work
with some of the Linux selftests ptrace debug tests (although those
tests seem to have a few issues in upstream kernels), some basic
Linux xmon and gdb tests by hand, and I've started working on some
kvm unit tests.

Thanks,
Nick 

Nicholas Piggin (6):
  target/ppc: Remove single-step suppression inside 0x100-0xf00
  target/ppc: Improve book3s branch trace interrupt for v2.07S
  target/ppc: Suppress single step interrupts on rfi-type instructions
  target/ppc: Implement breakpoint debug facility for v2.07S
  target/ppc: Implement watchpoint debug facility for v2.07S
  spapr: implement H_SET_MODE debug facilities

 hw/ppc/spapr_hcall.c     |  57 +++++++++++++++++++++
 target/ppc/cpu.c         |  86 +++++++++++++++++++++++++++++++
 target/ppc/cpu.h         |   7 +++
 target/ppc/cpu_init.c    |  11 ++--
 target/ppc/excp_helper.c | 108 ++++++++++++++++++++++++++++++++++++++-
 target/ppc/helper.h      |   4 ++
 target/ppc/internal.h    |   3 ++
 target/ppc/machine.c     |   5 ++
 target/ppc/misc_helper.c |  15 ++++++
 target/ppc/spr_common.h  |   3 ++
 target/ppc/translate.c   |  60 +++++++++++++++++-----
 11 files changed, 341 insertions(+), 18 deletions(-)

-- 
2.40.1


