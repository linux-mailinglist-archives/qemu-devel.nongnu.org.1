Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5EF82CA20
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:59:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOX1X-0007NI-MW; Sat, 13 Jan 2024 00:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1V-0007Mx-6f
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1S-00080G-Vv
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:36 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2B33A60B5C;
 Sat, 13 Jan 2024 05:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2E0C433C7;
 Sat, 13 Jan 2024 05:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705125452;
 bh=uXlukxkpON1mrtc6AJx/Whcxly+Kzw1zLyFZWySFvQQ=;
 h=From:To:Cc:Subject:Date:From;
 b=TVYIvCgQlLH/+JphskwpQCHSD0j/5IFv9miLxAa9T91F326dit+il5TpClXaLb5U1
 Ncgly9AtRU0qIw6F53ybxnu3+wv7cAWh8ydoLztkWjEqpQqhrv7qoju+o/FK80fAMq
 9cU8/3vCY+hnw6OCnY2QxLYLSHNxu7D5/w9+ppMkghdhtLqoPLfFf5d0+A3d/NqmjV
 k28UD76qurOoNl6H0mrfcGlJp7JMJAoM5kOebOYtygo8YyKVi2JOqZaeohMN5cIB05
 a9jrOIcV7hbex7kgAw9Q54J3aquQnIwcX0KE0+JjkbFKm/bfoVk2YLsjU2RbnFzlBc
 ELHI/gs6JqPHw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/10] Hppa fixes 8.2 patches
Date: Sat, 13 Jan 2024 06:57:18 +0100
Message-ID: <20240113055729.4480-1-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -91
X-Spam_score: -9.2
X-Spam_bar: ---------
X-Spam_report: (-9.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

for you to fetch changes up to 4bda8224fa89ab28958644c5f1a4117886fe8418:

  target/hppa: Update SeaBIOS-hppa to version 15 (2024-01-13 06:49:18 +0100)

----------------------------------------------------------------
target/hppa qemu v8.2 regression fixes

There were some regressions introduced with Qemu v8.2 on the hppa/hppa64
target, e.g.:

- 32-bit HP-UX crashes on B160L (32-bit) machine
- NetBSD boot failure due to power button in page zero
- NetBSD FPU detection failure
- OpenBSD 7.4 boot failure

This patch series fixes those known regressions and additionally:

- allows usage of the max. 3840MB of memory (instead of 3GB),
- adds support for the qemu --nodefaults option (to debug other devices)

This patch set will not fix those known (non-regression) bugs:
- HP-UX and NetBSD still fail to boot on the new 64-bit C3700 machine
- Linux kernel will still fail to boot on C3700 as long as kernel modules are used.

Changes v2->v3:
- Added comment about Figures H-10 and H-11 in the parisc2.0 spec
  in patch which calculate PDC address translation if PSW.W=0
- Introduce and use hppa_set_ior_and_isr()
- Use drive_get_max_bus(IF_SCSI), nd_table[] and serial_hd() to check
  if default devices should be created
- Added Tested-by and Reviewed-by tags

Changes v1->v2:
- fix OpenBSD boot with SeaBIOS v15 instead of v14
- commit message enhancements suggested by BALATON Zoltan
- use uint64_t for ram_max in patch #1

----------------------------------------------------------------

Helge Deller (10):
  hw/hppa/machine: Allow up to 3840 MB total memory
  hw/hppa/machine: Disable default devices with --nodefaults option
  hw/pci-host/astro: Add missing astro & elroy registers for NetBSD
  target/hppa: Fix PDC address translation on PA2.0 with PSW.W=0
  hw/hppa: Move software power button address back into PDC
  target/hppa: Avoid accessing %gr0 when raising exception
  target/hppa: Export function hppa_set_ior_and_isr()
  target/hppa: Fix IOR and ISR on unaligned access trap
  target/hppa: Fix IOR and ISR on error in probe
  target/hppa: Update SeaBIOS-hppa to version 15

 hw/hppa/machine.c         |  28 +++++++++++++++++-----------
 hw/pci-host/astro.c       |  26 +++++++++++++++++++++++---
 pc-bios/hppa-firmware.img | Bin 681388 -> 163324 bytes
 roms/seabios-hppa         |   2 +-
 target/hppa/cpu.c         |   6 +-----
 target/hppa/cpu.h         |   1 +
 target/hppa/mem_helper.c  |  35 +++++++++++++++++++++--------------
 target/hppa/op_helper.c   |   6 +-----
 8 files changed, 65 insertions(+), 39 deletions(-)

-- 
2.43.0


