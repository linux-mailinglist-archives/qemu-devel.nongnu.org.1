Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB8B7A9845
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcK-00020F-T1; Thu, 21 Sep 2023 13:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcG-0001z8-Ng
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcC-0007eb-TK
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32003aae100so1677806f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317843; x=1695922643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BZbCTchtAmwRVDvKdEjBs58VCEQ0x1aJxl/uBiCEFxU=;
 b=P96wq6l0D2QLOeFwsa0U/YEkOp83/xM1xJiPdBdyZ9L/wbPVFy1uXbJe34jEKnpKgg
 nGENmMLvn/zX0G2kV+6LnL2/7IE9kqkaUNTEbAccTqmgtojC69G1ZaB7pjj127KmEluM
 TzAmcE8L0smCp+1fkarx8DxZ5TPOYIf5w/lLsONu5ilTKJHZTEbAtF/XWoXLxJ8JUGdw
 wTzC6lGhHcofewuIdiA8AmUZNh9tkkYy7eFVK7Ub7F6xDTGESn1ZU+z7fs5l4Vr3E1ow
 YMkcgU4CZGfaTBb+E2bfyXGZ9fQt7iweqdOq+9Va70FHAEIQhqAdmycHa3f7OHjd1O7w
 2RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317843; x=1695922643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BZbCTchtAmwRVDvKdEjBs58VCEQ0x1aJxl/uBiCEFxU=;
 b=RjZkGesWpsXY351SIyKLokFqNIFCtsqkfCISh0vejwp4fQVlTQ71y7yV6iV0Ss1HVn
 MBWbVvulxDGMhRztbw28qZlpQR/CAU+A7Rf6MJ8LnsvXSekAGVgf54R8VWqqQE3latVu
 Ckj1+XWGeJvoeYUrUaPhtOs4/RqW3plIFWE49NSWnIXlkkaGVuEiZBIMxf4xbL9VEri0
 N/QfBLlveRIGZ4S1oQYrw3fvV4YKv9GyIc9JYJl27avH10dre2JFoID9W6D7WpiDqTJH
 gu7QB9BxDZlyaXBKJBTWeis1NgXZwELYxnOoFfwfKaVAWo78zjPMcrWNgQY5nZcvdAGH
 dbyQ==
X-Gm-Message-State: AOJu0Yxfnppc05Wzg2GkNuKSJse7gySAP1/bCzfJKAd0Ff+sshSRm31z
 8TWv0TOpndq8/4Adxi95WX2An3wsAl9c1qLfSUc=
X-Google-Smtp-Source: AGHT+IFQOJGQ00uWeow1opJxfAHenUxd1gvgAbBuXvEAw9ze0hjBHD96L8wN54GXZQZACnKwtFbw4A==
X-Received: by 2002:adf:cc8c:0:b0:320:2b29:7041 with SMTP id
 p12-20020adfcc8c000000b003202b297041mr199601wrj.24.1695317842645; 
 Thu, 21 Sep 2023 10:37:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] target-arm queue
Date: Thu, 21 Sep 2023 18:36:50 +0100
Message-Id: <20230921173720.3250581-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi; here's this week's arm pullreq. Mostly this is my
work on FEAT_MOPS and FEAT_HBC, but there are some
other bits and pieces in there too, including a recent
set of elf2dmp patches.

thanks
-- PMM

The following changes since commit 55394dcbec8f0c29c30e792c102a0edd50a52bf4:

  Merge tag 'pull-loongarch-20230920' of https://gitlab.com/gaosong/qemu into staging (2023-09-20 13:56:18 -0400)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230921

for you to fetch changes up to 231f6a7d66254a58bedbee458591b780e0a507b1:

  elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining (2023-09-21 16:13:54 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/m68k: Add URL to semihosting spec
 * docs/devel/loads-stores: Fix git grep regexes
 * hw/arm/boot: Set SCR_EL3.FGTEn when booting kernel
 * linux-user: Correct SME feature names reported in cpuinfo
 * linux-user: Add missing arm32 hwcaps
 * Don't skip MTE checks for LDRT/STRT at EL0
 * Implement FEAT_HBC
 * Implement FEAT_MOPS
 * audio/jackaudio: Avoid dynamic stack allocation
 * sbsa-ref: add non-secure EL2 virtual timer
 * elf2dmp: improve Win2022, Win11 and large dumps

----------------------------------------------------------------
Fabian Vogt (1):
      hw/arm/boot: Set SCR_EL3.FGTEn when booting kernel

Marcin Juszkiewicz (1):
      sbsa-ref: add non-secure EL2 virtual timer

Peter Maydell (23):
      target/m68k: Add URL to semihosting spec
      docs/devel/loads-stores: Fix git grep regexes
      linux-user/elfload.c: Correct SME feature names reported in cpuinfo
      linux-user/elfload.c: Add missing arm and arm64 hwcap values
      linux-user/elfload.c: Report previously missing arm32 hwcaps
      target/arm: Update AArch64 ID register field definitions
      target/arm: Update user-mode ID reg mask values
      target/arm: Implement FEAT_HBC
      target/arm: Remove unused allocation_tag_mem() argument
      target/arm: Don't skip MTE checks for LDRT/STRT at EL0
      target/arm: Implement FEAT_MOPS enable bits
      target/arm: Pass unpriv bool to get_a64_user_mem_index()
      target/arm: Define syndrome function for MOPS exceptions
      target/arm: New function allocation_tag_mem_probe()
      target/arm: Implement MTE tag-checking functions for FEAT_MOPS
      target/arm: Implement the SET* instructions
      target/arm: Define new TB flag for ATA0
      target/arm: Implement the SETG* instructions
      target/arm: Implement MTE tag-checking functions for FEAT_MOPS copies
      target/arm: Implement the CPY* instructions
      target/arm: Enable FEAT_MOPS for CPU 'max'
      audio/jackaudio: Avoid dynamic stack allocation in qjack_client_init
      audio/jackaudio: Avoid dynamic stack allocation in qjack_process()

Viktor Prutyanov (5):
      elf2dmp: replace PE export name check with PDB name check
      elf2dmp: introduce physical block alignment
      elf2dmp: introduce merging of physical memory runs
      elf2dmp: use Linux mmap with MAP_NORESERVE when possible
      elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining

 docs/devel/loads-stores.rst    |  40 +-
 docs/system/arm/emulation.rst  |   2 +
 contrib/elf2dmp/addrspace.h    |   1 +
 contrib/elf2dmp/pdb.h          |   2 +-
 contrib/elf2dmp/qemu_elf.h     |   2 +
 target/arm/cpu.h               |  35 ++
 target/arm/internals.h         |  55 +++
 target/arm/syndrome.h          |  12 +
 target/arm/tcg/helper-a64.h    |  14 +
 target/arm/tcg/translate.h     |   4 +-
 target/arm/tcg/a64.decode      |  38 +-
 audio/jackaudio.c              |  21 +-
 contrib/elf2dmp/addrspace.c    |  31 +-
 contrib/elf2dmp/main.c         | 154 ++++----
 contrib/elf2dmp/pdb.c          |  15 +-
 contrib/elf2dmp/qemu_elf.c     |  68 +++-
 hw/arm/boot.c                  |   4 +
 hw/arm/sbsa-ref.c              |   2 +
 linux-user/elfload.c           |  72 +++-
 target/arm/helper.c            |  39 +-
 target/arm/tcg/cpu64.c         |   5 +
 target/arm/tcg/helper-a64.c    | 878 +++++++++++++++++++++++++++++++++++++++++
 target/arm/tcg/hflags.c        |  21 +
 target/arm/tcg/mte_helper.c    | 281 +++++++++++--
 target/arm/tcg/translate-a64.c | 164 +++++++-
 target/m68k/m68k-semi.c        |   4 +
 tests/tcg/aarch64/sysregs.c    |   4 +-
 27 files changed, 1768 insertions(+), 200 deletions(-)

