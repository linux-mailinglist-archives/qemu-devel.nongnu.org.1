Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C782719B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:40:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqlv-0006aJ-UO; Mon, 08 Jan 2024 09:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqlf-0006TR-TM
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:20 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqlb-0007ij-Sq
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:19 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BDAB2CE097C;
 Mon,  8 Jan 2024 14:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D01C433C7;
 Mon,  8 Jan 2024 14:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704724685;
 bh=6jOj6dSE98cfylHT36n9ykwncpljpQB0jEaip0HHbqE=;
 h=From:To:Cc:Subject:Date:From;
 b=ogpdEdqxAucze+1357EofZkhKOjdEwFdOBKADL7nNXWekpfP13jng26btGRe3DzUt
 DndMIq3Io70c80/pWAwsJBEVLTrEC8O3gctGKdH1G8/RyUgDfgx29Yv0svyXja0Ggz
 tqhVUfa5cZ9ph32a4J7jpnWoXwRb1dlkMF/S92VxhAhmPteySWT7ecXxdEQXHgpB7i
 bb/hMbIZ84upvtB67i4A2NdY2zB91dZvolpO9pp7E9ynSmpC9fex8XzpOPgaIn54rv
 2S8KANq08/LtJvSL/S3NtieCYkeiixynBIdL/aBXQtFxFYl1XrE1ohD2QTi1kA3N9w
 eWmYMIYB95fXg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/9] Hppa fixes 8.2 patches
Date: Mon,  8 Jan 2024 15:37:53 +0100
Message-ID: <20240108143802.50256-1-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

The following changes since commit 7425b6277f12e82952cede1f531bfc689bf77fb1:

  Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-12-27 05:15:32 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-fixes-8.2-pull-request

for you to fetch changes up to 282abfd5ea2c489aec7276a50c39029de55bcd85:

  target/hppa: Update SeaBIOS-hppa to version 15 (2024-01-07 09:13:07 +0100)

----------------------------------------------------------------
target/hppa qemu v8.2 regression fixes

There were some regressions introduced with Qemu v8.2 on the hppa/hppa64
target, e.g.:

- 32-bit HP-UX crashes on B160L (32-bit) machine
- NetBSD boot failure due to power button in page zero
- NetBSD FPU detection failure
- OpenBSD 7.4 boot failure

This small patch series fixes those known regressions and
additionally:

- allows usage of the max. 3840MB of memory (instead of 3GB),
- adds support for the qemu --nodefaults option (to debug other devices)

This patch set will not fix those known (non-regression) bugs:
- HP-UX and NetBSD still fail to boot on the new 64-bit C3700 machine
- Linux kernel will still fail to boot on C3700 as long as kernel modules are used.

----------------------------------------------------------------

Helge Deller (9):
  hw/hppa/machine: Allow up to 3840 MB total memory
  hw/hppa/machine: Disable default devices with --nodefaults option
  hw/pci-host/astro: Add missing astro & elroy registers for NetBSD
  target/hppa: Fix PDC address translation on PA2.0 with PSW.W=0
  target/hppa: Strip upper 32-bits of IOR on error in probe
  target/hppa: Strip upper 32-bits of IOR on unaligned access error
  hw/hppa: Move software power button address back into PDC
  target/hppa: Avoid accessing %gr0 when raising exception
  target/hppa: Update SeaBIOS-hppa to version 15

 hw/hppa/machine.c         |  33 ++++++++++++++++++++-------------
 hw/pci-host/astro.c       |  26 +++++++++++++++++++++++---
 pc-bios/hppa-firmware.img | Bin 681388 -> 163324 bytes
 roms/seabios-hppa         |   2 +-
 target/hppa/cpu.c         |   2 +-
 target/hppa/mem_helper.c  |   4 ++--
 target/hppa/op_helper.c   |   2 +-
 7 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.43.0


