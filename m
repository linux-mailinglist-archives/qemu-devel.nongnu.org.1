Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EA272ABCE
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:40:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yh8-0004N8-4v; Sat, 10 Jun 2023 09:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7ygz-0004M6-Tn; Sat, 10 Jun 2023 09:31:45 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7ygy-0007YQ-28; Sat, 10 Jun 2023 09:31:45 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-39cc64e4a44so23254b6e.0; 
 Sat, 10 Jun 2023 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403902; x=1688995902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FD54A2CQMoPOBvUvSal4XxhuKyLO9IjgKkFlRLNNTEA=;
 b=qp30MgRLI+lQ9GuejTowTUAZr/NDOABlh1J6ngTmGD2ARGIpAf34tETniaA5ULJjqn
 38BNFfX1v99BR0n29MJuNEVERxgsUa6f1phodKq8mMYVgeq9/X0MKWTGmfbdXrUhY528
 YMp2EZAcf8EULv5UIiIw8+KZrM6L/H92H8FNAz9h1WaSqC5nDsifkLhGE8q8StOe2pab
 BauEm+g0OoWpG4UpOlDkqvVRuMnymbzcrw5gQfB+bBmjp/9GLNpCraFBflBFCUsHW64P
 zz2cd7uyb7qTB0llYjVnyB6SwmF+jDYr7s6E4ct8UG9elh+qpXkWSZBBYdxarTa2MmWB
 i7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403902; x=1688995902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FD54A2CQMoPOBvUvSal4XxhuKyLO9IjgKkFlRLNNTEA=;
 b=TNZcWwAZq5Ih3op7of/nRa1eLZclP67oZKWoKTBIpkCRe9ocO9AZoYFrcs92uwp5bZ
 PY9KoewYDGhrI1GP2tkyNqye9uf+epBpZhnp9CS/oKqY2wMNRcglS75NiLR5WVDwVbbO
 j5LdyETVMoMTGwPFEZ6AALQyGahGE2JkAfFf9NntB40tiK9xQpQXly8O/H9blNLLXST0
 0psvMCafSXADM2ykqw7LYv+fbkVG/JD4keEXz8RsqxIlZbIXjkNaTSKJmpTRMpzmIRLV
 ZuQ//v0/CNmhzvFBZUdhi6uHTdEKEj3Z4YWyNY2YkWRC0LIIqmmQWwVFMUIfoTs5Cwy/
 JYXQ==
X-Gm-Message-State: AC+VfDzLrSIddHlrwk6L/CQZlImbYj9MyQpYwUnhmQ+Rn7UDoIJEojBu
 YSzqZLbipE3S4Sl0Z/EYCHmqavRLC0U=
X-Google-Smtp-Source: ACHHUZ5UhPaiiemNxJoc406KLYk71nE59LoI/ebQEPGVmwL8ORIsetvMYFSjL07mFDaUggkuaCd1iw==
X-Received: by 2002:a05:6808:1785:b0:39a:ad7c:dec7 with SMTP id
 bg5-20020a056808178500b0039aad7cdec7mr1034697oib.15.1686403901918; 
 Sat, 10 Jun 2023 06:31:41 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:31:41 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: [PULL 00/29] ppc queue
Date: Sat, 10 Jun 2023 10:31:03 -0300
Message-Id: <20230610133132.290703-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22a.google.com
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

The following changes since commit 3673ad389622d9ef4d2743101253c642def7935a:

  tcg/tci: Fix MemOpIdx operand index for 3-operand memops (2023-06-09 08:30:56 -0700)

are available in the Git repository at:

  https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230610

for you to fetch changes up to 9ec08f3569be3bc8bfd4d9b8b0445b9136910661:

  hw/ppc/Kconfig: MAC_NEWWORLD should always select USB_OHCI_PCI (2023-06-10 10:19:24 -0300)

----------------------------------------------------------------
ppc patch queue for 2023-06-10:

This queue includes several assorted fixes for target/ppc emulation and
XIVE2. It also includes an openpic fix, an avocado fix for ppc64
binaries without slipr and a Kconfig change for MAC_NEWWORLD.

----------------------------------------------------------------
BALATON Zoltan (8):
      target/ppc: Remove single use function
      target/ppc: Remove "ext" parameter of ppcemb_tlb_check()
      target/ppc: Move ppcemb_tlb_search() to mmu_common.c
      target/ppc: Remove some unneded line breaks
      target/ppc: Simplify ppcemb_tlb_search()
      target/ppc: Change ppcemb_tlb_check() to return bool
      target/ppc: Eliminate goto in mmubooke_check_tlb()
      target/ppc: Implement gathering irq statistics

Frederic Barrat (6):
      pnv/xive2: Add definition for TCTXT Config register
      pnv/xive2: Add definition for the ESB cache configuration register
      pnv/xive2: Allow writes to the Physical Thread Enable registers
      pnv/xive2: Introduce macros to manipulate TIMA addresses
      pnv/xive2: Handle TIMA access through all ports
      pnv/xive2: Quiet down some error messages

Nicholas Piggin (12):
      target/ppc: Fix nested-hv HEAI delivery
      target/ppc: Fix PMU hflags calculation
      target/ppc: PMU do not clear MMCR0[FCECE] on performance monitor alert
      target/ppc: Fix msgclrp interrupt type
      target/ppc: Support directed privileged doorbell interrupt (SDOOR)
      target/ppc: PMU implement PERFM interrupts
      target/ppc: Fix lqarx to set cpu_reserve
      target/ppc: Ensure stcx size matches larx
      target/ppc: Remove larx/stcx. memory barrier semantics
      target/ppc: Rework store conditional to avoid branch
      target/ppc: Fix decrementer time underflow and infinite timer loop
      target/ppc: Decrementer fix BookE semantics

Philippe Mathieu-Daudé (1):
      hw/ppc/openpic: Do not open-code ROUND_UP() macro

Thomas Huth (2):
      tests/avocado/tuxrun_baselines: Fix ppc64 tests for binaries without slirp
      hw/ppc/Kconfig: MAC_NEWWORLD should always select USB_OHCI_PCI

 hw/intc/pnv_xive2.c               | 24 ++++++++++-
 hw/intc/pnv_xive2_regs.h          |  8 ++++
 hw/intc/xive.c                    | 16 +++----
 hw/ppc/Kconfig                    |  1 +
 hw/ppc/ppc.c                      | 11 ++---
 include/hw/ppc/openpic.h          |  2 +-
 include/hw/ppc/xive_regs.h        | 16 +++++++
 target/ppc/cpu.h                  | 19 ++++----
 target/ppc/cpu_init.c             | 24 +++++++++--
 target/ppc/excp_helper.c          | 14 +++---
 target/ppc/helper_regs.c          | 73 +++++++++++++++++++++++--------
 target/ppc/helper_regs.h          |  1 +
 target/ppc/machine.c              |  8 ++--
 target/ppc/mmu_common.c           | 91 ++++++++++++++++++++++-----------------
 target/ppc/mmu_helper.c           | 32 +-------------
 target/ppc/power8-pmu.c           | 60 +++++++++++++++-----------
 target/ppc/power8-pmu.h           |  4 +-
 target/ppc/translate.c            | 80 ++++++++++++++++------------------
 tests/avocado/tuxrun_baselines.py |  1 +
 19 files changed, 289 insertions(+), 196 deletions(-)

