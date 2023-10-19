Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B653D7D0514
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 00:54:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtbtG-000865-3p; Thu, 19 Oct 2023 18:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtD-00085d-K7
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:15 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtA-0002cf-VW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 972EDCE329F;
 Thu, 19 Oct 2023 22:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA665C433C9;
 Thu, 19 Oct 2023 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697755980;
 bh=QuvczCn3RLJbeo3iUqPzOqzJLw+axCB8mDdxyL//0/Q=;
 h=From:To:Cc:Subject:Date:From;
 b=HEcddmMeAtX9gCfsptK6AoMBhleoZua94rtmpO+Dxvm0Jw6SRkZ69aukMxr6f+UBw
 2IDmy8bYzZxnoUive3Lf43OLPEXgH+WcT3FM0jQ8FPoBraLh84rtTrnKLeKqYUKqC+
 XzT6kce9ZbKkdvPawxvMFhYo5GkxOjKkDVG8kZpDoGizbBLO8lwFctzH6+lnz21zGS
 hTrFBuRzaV/xgI0CsPZ9ka8Q71rqX4xt+aVwbnVR2iZLvowq6vV4cg0WsYwwUYtigM
 r0FWQ/KsJ3+N7r6yQFUt60vFkXYh8ESaziXHtYXuZ0gUVn3J3vuDk5b1RhlYxrSOie
 S864yl4stEYJw==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/11] C3700 patches
Date: Fri, 20 Oct 2023 00:52:46 +0200
Message-ID: <20231019225257.383071-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

The following changes since commit 63011373ad22c794a013da69663c03f1297a5c56:

  Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/alistair23/qemu into staging (2023-10-12 10:24:44 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/C3700-pull-request

for you to fetch changes up to 2ed4faa03fa92e3ab9160c09f3eb866fbdd60ecc:

  hw/hppa: Add new HP C3700 machine (2023-10-20 00:47:38 +0200)

----------------------------------------------------------------
target/hppa: Add emulation of a C3700 HP-PARISC workstation

This series adds a new PA-RISC machine emulation for the HP-PARISC
C3700 workstation.

The physical HP C3700 machine has a PA2.0 (64-bit) CPU, in contrast to
the existing emulation of a B160L workstation which is a 32-bit only
machine and where it's Dino PCI controller isn't 64-bit capable.

With the HP C3700 machine emulation (together with the emulated Astro
Memory controller and the Elroy PCI bridge) it's now possible to
enhance the hppa CPU emulation to support the 64-bit instruction set
in upcoming patches.

Helge

v4 changes:
- Fix testsuite error in astro by adding a realize() implementation

v3 changes:
based on feedback from BALATON Zoltan <balaton@eik.bme.hu>:
- apply paches in different order to bring them logically closer to each other
- update comments in lasips2
- rephrased title and commit message of MAINTAINERS patch

v2 changes:
suggestions by BALATON Zoltan <balaton@eik.bme.hu>:
- merged pci_ids and tulip patch
- dropped comments in lasips2
- mention additional cleanups in patch "Require at least SeaBIOS-hppa version 10"
suggestions by Philippe Mathieu-Daudé <philmd@linaro.org>:
- dropped static pci_bus variable

----------------------------------------------------------------

Helge Deller (11):
  target/hppa: Update to SeaBIOS-hppa version 10
  hw/hppa: Require at least SeaBIOS-hppa version 10
  pci_ids/tulip: Add PCI vendor ID for HP and use it in tulip
  lasips2: LASI PS/2 devices are not user-createable
  hw/pci-host: Add Astro system bus adapter found on PA-RISC machines
  pci-host: Wire up new Astro/Elroy PCI bridge
  MAINTAINERS: Update HP-PARISC entries
  hw/hppa: Export machine name, BTLBs, power-button address via fw_cfg
  hw/hppa: Provide RTC and DebugOutputPort on CPU #0
  hw/hppa: Split out machine creation
  hw/hppa: Add new HP C3700 machine

 MAINTAINERS                 |   5 +-
 hw/hppa/Kconfig             |   1 +
 hw/hppa/hppa_hardware.h     |   1 -
 hw/hppa/machine.c           | 367 +++++++++++----
 hw/input/lasips2.c          |  10 +
 hw/net/tulip.c              |   2 +-
 hw/pci-host/Kconfig         |   4 +
 hw/pci-host/astro.c         | 885 ++++++++++++++++++++++++++++++++++++
 hw/pci-host/meson.build     |   1 +
 hw/pci-host/trace-events    |  11 +
 include/hw/pci-host/astro.h |  92 ++++
 include/hw/pci/pci_ids.h    |   2 +
 pc-bios/hppa-firmware.img   | Bin 732376 -> 755480 bytes
 roms/seabios-hppa           |   2 +-
 14 files changed, 1301 insertions(+), 82 deletions(-)
 create mode 100644 hw/pci-host/astro.c
 create mode 100644 include/hw/pci-host/astro.h

-- 
2.41.0


