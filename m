Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA8C831C18
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:13:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTz0-0006ns-CI; Thu, 18 Jan 2024 10:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTyw-0006fq-GN; Thu, 18 Jan 2024 10:07:02 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTyt-0007q7-NF; Thu, 18 Jan 2024 10:07:01 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d480c6342dso93807945ad.2; 
 Thu, 18 Jan 2024 07:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590417; x=1706195217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wa+dYv9lvDBfH7qPUHAOpuOUqIsQNEiukHj46AhjG58=;
 b=l6cIkJl6So26qo1mQBuxbp8KPuggaOHg31LtykFiDDsMyquCLtr+Vf74Qhc5jApDNq
 EFtc92CR7+spq3bRsddsv5I1Qx4TShNun5h6nBDeQgYO8jPvUMErBlEKKU+UAMfXhQ0L
 4ClZEJXNz2+Je9YrrwBMPUiZ9XC3DOXqILPjsjSIyUHXbtE7VpR5ddZv8AfIjDO5PdKB
 UHN3H/gGKuP2C3vAOtH/RR6j1gqc7VYj4/2Pr3f58iF08qPEoLrLIKjqy72u3r4CIQ8h
 J9ltCfmiZFvL32PbF1aPBeHBgqGi214lhKYqYXjSNIgPfp1KYv2JcFxGcfbXh2wnLSRW
 iiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590417; x=1706195217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wa+dYv9lvDBfH7qPUHAOpuOUqIsQNEiukHj46AhjG58=;
 b=CUxKrUCZqshd8nrd1rb8I0aVNXANEsUeD3Bo6mcc7hxlRkliKgHjIjJYvvk812xRmQ
 uMpKberW1ogGIuBJlaDH0A16r7MtCvT3tNOv5rTUL+7Xs3Yt594ZyBXTphyu0ESlUIvM
 6XwmpREVUuNsobHcxgMGWvePI5AcRaSwdTkzACQArh4ROIu9pUuEM75jW8bmPKNh3b5l
 RT2kMxs/2hCvSV0g+ZKOBiXflKM0rqn27ZqcpdJwCE/rzlKsjvyy/xGr1K7QD0688QWe
 RV5+3IBkn2129N77sGXTKNEels3jPyd01Dm5SFyKnYm8cUqMnc9vYpPe5NSPSRkOjJED
 yVKA==
X-Gm-Message-State: AOJu0YzGH/jt3/axms2WVcZs6LCtRYZpJ1dH9a4ytWUZy8jff68hGwxE
 kFewdszeahIXxt65912Zka6wIvHq19d5yIOPxjQmU+MaaaYswwJYCpFQnIj9
X-Google-Smtp-Source: AGHT+IF0WB+h87zhLxnc6tMqQE17HEin7krBbXRqbDAVTxsIktLsKrNWhCu6stsDComrr55jve8JOQ==
X-Received: by 2002:a17:902:ea12:b0:1d5:a5ba:1c49 with SMTP id
 s18-20020a170902ea1200b001d5a5ba1c49mr988702plg.1.1705590417304; 
 Thu, 18 Jan 2024 07:06:57 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:06:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 00/26] target/ppc: TCG improvements and fixes
Date: Fri, 19 Jan 2024 01:06:18 +1000
Message-ID: <20240118150644.177371-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

This is mostly TCG core emulation improvements and fixes. I
got the chiptod model in there because it's intertwined with
TFMR SPR.

Other non-TCG patches are spapr MSR entry point change which
goes together with the other machine check / MSR[ME] fixes.
And Saif's gdb patches, as well as some SPR renaming.

Will probably a bit more similar patches too, e.g., Dan's SPR
patches, but I'll just get this out for review before
upstreaming it.

Thanks,
Nick

Glenn Miles (4):
  target/ppc: Add new hflags to support BHRB
  target/ppc: Add recording of taken branches to BHRB
  target/ppc: Add clrbhrb and mfbhrbe instructions
  target/ppc: Add migration support for BHRB

Nicholas Piggin (21):
  target/ppc: Fix crash on machine check caused by ifetch
  target/ppc: Prevent supervisor from modifying MSR[ME]
  spapr: set MSR[ME] and MSR[FP] on client entry
  target/ppc: Rename registers to match ISA
  target/ppc: Rename TBL to TB on 64-bit
  target/ppc: Improve timebase register defines naming
  target/ppc: Fix move-to timebase SPR access permissions
  pnv/chiptod: Add POWER9/10 chiptod model
  ppc/pnv: Wire ChipTOD model to powernv9 and powernv10 machines
  pnv/chiptod: Implement the ChipTOD to Core transfer
  target/ppc: Implement core timebase state machine and TFMR
  target/ppc: Add SMT support to time facilities
  target/ppc: BookE DECAR SPR is 32-bit
  target/ppc: Wire up BookE ATB registers for e500 family
  target/ppc: Add PPR32 SPR
  target/ppc: add helper to write per-LPAR SPRs
  target/ppc: Add SMT support to simple SPRs
  target/ppc: Add SMT support to PTCR SPR
  target/ppc: Implement LDBAR, TTR SPRs
  target/ppc: Implement SPRC/SPRD SPRs
  target/ppc: add SMT support to msgsnd broadcast

Saif Abrar (1):
  target/ppc: Update gdbstub to read SPR's CFAR, DEC, HDEC, TB-L/U

 include/hw/ppc/pnv.h                          |   2 +
 include/hw/ppc/pnv_chip.h                     |   3 +
 include/hw/ppc/pnv_chiptod.h                  |  53 ++
 include/hw/ppc/pnv_xscom.h                    |   9 +
 target/ppc/cpu.h                              |  97 ++-
 target/ppc/helper.h                           |  13 +-
 target/ppc/power8-pmu.h                       |  11 +-
 target/ppc/spr_common.h                       |   8 +
 target/ppc/insn32.decode                      |   8 +
 hw/ppc/pnv.c                                  |  45 ++
 hw/ppc/pnv_chiptod.c                          | 586 ++++++++++++++++++
 hw/ppc/spapr_cpu_core.c                       |   2 +
 target/ppc/cpu_init.c                         | 124 +++-
 target/ppc/excp_helper.c                      |  89 ++-
 target/ppc/gdbstub.c                          |  40 +-
 target/ppc/helper_regs.c                      |  83 ++-
 target/ppc/machine.c                          |  23 +-
 target/ppc/misc_helper.c                      | 132 +++-
 target/ppc/power8-pmu.c                       |  48 +-
 target/ppc/ppc-qmp-cmds.c                     |   4 +
 target/ppc/timebase_helper.c                  | 309 ++++++++-
 target/ppc/translate.c                        | 207 ++++++-
 target/ppc/power8-pmu-regs.c.inc              |   5 +
 target/ppc/translate/bhrb-impl.c.inc          |  43 ++
 target/ppc/translate/branch-impl.c.inc        |   2 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   |   2 +-
 hw/ppc/meson.build                            |   1 +
 hw/ppc/trace-events                           |   4 +
 28 files changed, 1855 insertions(+), 98 deletions(-)
 create mode 100644 include/hw/ppc/pnv_chiptod.h
 create mode 100644 hw/ppc/pnv_chiptod.c
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc

-- 
2.42.0


