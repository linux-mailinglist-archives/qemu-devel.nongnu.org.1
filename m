Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99237737E7
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTECd-0006Ba-FJ; Tue, 08 Aug 2023 00:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECb-0006B5-EB; Tue, 08 Aug 2023 00:20:13 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECZ-0007Ly-AO; Tue, 08 Aug 2023 00:20:12 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-54290603887so3051092a12.1; 
 Mon, 07 Aug 2023 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468409; x=1692073209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BJ+bBJFKSJAPMb8cGeEnj0cyazcUESGNGfgyO3MTSwk=;
 b=dcKBZy2xh/0+LawitTRvbOVRdv25qo4NCIHUniiP16MrLu4X4p++9G3VuPlUNsMMne
 pJHO1uEBpvEDFWyhP5wO1ZuyrSq8xecEx/DGh/V1T+FDm8JTyUNxh8mX801CHlyPiCEt
 agCZUwjddetJCVudWQDQrado434dwjjaDaGQslMQOxucmpBIUGGv/sHS9AJ6IfRYfQbS
 Ye88xx/MMYFw89reVLua3ddyiSFpHyS3Qfy3ywzhnqdkUpL+AeBRDKiKVTwLomW5IpTJ
 ZcSLHmi1lovMqTmaIllnoA20hkmYZ1EfhLQPUMN80jdsy5eum5oADPtPxcygd88HWV0H
 ivXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468409; x=1692073209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJ+bBJFKSJAPMb8cGeEnj0cyazcUESGNGfgyO3MTSwk=;
 b=JDfe8D/JOadXAAx/y4mLS4xHINeaYoyhKoKl+d4Tb6NZa4xlYAdOpJWxoqASKZu0oX
 THEHp71ozEh48CA2EFOHvm6NqPWb1J1XbKa63PhVq7ThfeJuH4Bbvro0H8CcVqorXcul
 5hzXk0RofjAXNZYZQA/BDGjvyi/NgRVK4RqAN/2s41tkbd6m3iTBdHtTlFmtwfmlOSyl
 1VzU3nyqe1NTrwwEdkFI1zWdPqtBsW0DAIrJv6QmVFm4W6JrLTTY8iGTNJZdoGIjRn9u
 GPDxegaJfcOdmtyalsXJorL0rORJlef9WwnJKmrWTFBm2CuwDpAeuwZvJLRS7hCnmItp
 EXkQ==
X-Gm-Message-State: AOJu0YwVtwLnfr3wLnE01L6JbmpOxi18KWdq9e6gQ1FvU7L9tfjsC2+a
 ZC88gBTMNBWpuDE0hpEMSS4=
X-Google-Smtp-Source: AGHT+IHTkQmC2HhbbBBe1s6lqCzgujYlVdDiLk8785itRCK4B2rEGHG/WLW8BfIml/tupXPpKA+QUQ==
X-Received: by 2002:a05:6a20:5494:b0:130:d5a:e40e with SMTP id
 i20-20020a056a20549400b001300d5ae40emr11692394pzk.7.1691468409406; 
 Mon, 07 Aug 2023 21:20:09 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 for-8.2 00/19] ppc: record-replay enablement and fixes
Date: Tue,  8 Aug 2023 14:19:42 +1000
Message-Id: <20230808042001.411094-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

The patches in this series has been seen a few times in various
iterations.

There are two main pieces, some assorted small fixes and tests for
record-replay, plus a large set of decrementer fixes. I merged these
into one series rather than send decrementer fixes alone first, because
record-replay has been very good at uncovering timer problems, so it's
good to have those test cases in at the same time IMO.

Some of the fixes we might take to stable, but unclear which.
Decrementer fixes were a bit of a tangle so maybe we just leave those
alone since they work okay.

The decrementer is not emulated perfectly still. Underflow from -ve
to +ve is not implemented, for one. I started doing that but it's not
trivial so better stop here for now.

For record-replay, pseries is now quite solid with rr. Surely some
issues to iron out but it is becoming usable.

powernv record-replay has some known problems migrating edge-triggered
decrementer, and edge triggered msgsnd. Also it seems to get stuck in
xive init somewhere when replaying from checkpoint, so there is probably
some state in xive not being reset. But at least it runs the avocado
test and seems close to working, so I've added that test case so we
don't go backwards (ha!).

Other machine types might not be too far off if there is interest. I
found it quite difficult to find these problems though, reverse
debugging will sometimes just lock up, stop at wrong location, or abort
with wrong event. Difficult understand what went wrong. Worst case I had
to basically bisect the replay of the trace, and find the minimum length
of replay that hit the problem -- that sometimes would land near a
mtDEC or timer interrupt or similar.

Thanks,
Nick

Nicholas Piggin (19):
  ppc/vhyp: reset exception state when handling vhyp hcall
  ppc/vof: Fix missed fields in VOF cleanup
  hw/ppc/ppc.c: Tidy over-long lines
  hw/ppc: Introduce functions for conversion between timebase and
    nanoseconds
  host-utils: Add muldiv64_round_up
  hw/ppc: Round up the decrementer interval when converting to ns
  hw/ppc: Avoid decrementer rounding errors
  target/ppc: Sign-extend large decrementer to 64-bits
  hw/ppc: Always store the decrementer value
  target/ppc: Migrate DECR SPR
  hw/ppc: Reset timebase facilities on machine reset
  hw/ppc: Read time only once to perform decrementer write
  target/ppc: Fix CPU reservation migration for record-replay
  target/ppc: Fix timebase reset with record-replay
  spapr: Fix machine reset deadlock from replay-record
  spapr: Fix record-replay machine reset consuming too many events
  tests/avocado: boot ppc64 pseries replay-record test to Linux VFS
    mount
  tests/avocado: reverse-debugging cope with re-executing breakpoints
  tests/avocado: ppc64 reverse debugging tests for pseries and powernv

 hw/ppc/mac_oldworld.c              |   1 +
 hw/ppc/pegasos2.c                  |   1 +
 hw/ppc/pnv_core.c                  |   2 +
 hw/ppc/ppc.c                       | 236 +++++++++++++++++++----------
 hw/ppc/prep.c                      |   1 +
 hw/ppc/spapr.c                     |  32 +++-
 hw/ppc/spapr_cpu_core.c            |   2 +
 hw/ppc/vof.c                       |   2 +
 include/hw/ppc/ppc.h               |   3 +-
 include/hw/ppc/spapr.h             |   2 +
 include/qemu/host-utils.h          |  21 ++-
 target/ppc/compat.c                |  19 +++
 target/ppc/cpu.h                   |   3 +
 target/ppc/excp_helper.c           |   3 +
 target/ppc/machine.c               |  40 ++++-
 target/ppc/translate.c             |   4 +
 tests/avocado/replay_kernel.py     |   3 +-
 tests/avocado/reverse_debugging.py |  54 ++++++-
 18 files changed, 330 insertions(+), 99 deletions(-)

-- 
2.40.1


