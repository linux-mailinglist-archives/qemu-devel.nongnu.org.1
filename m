Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8DE7CE932
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDLZ-00075k-1L; Wed, 18 Oct 2023 16:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtDLW-00073d-23
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:40:50 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtDLR-0000zR-M9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:40:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 64F0FCE26B6;
 Wed, 18 Oct 2023 20:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A91DC433C7;
 Wed, 18 Oct 2023 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697661633;
 bh=ebWkMntNJKNKcYA0fbEiNZhEat48fX5rjN8BTaWy2R4=;
 h=From:To:Cc:Subject:Date:From;
 b=rMSAhr25/dhzDbqQzaNrNwJkrmHI0lINKNy4lPRNpkE16Apnfx4tuEvldGhA2G5aI
 k5gucQLfHvLznGncBPDcvs9RKTx07KOF54mvEndUh5Zwegu2BB4VEMa3Pf5hP+jyp8
 rh4cCZIeE1GalA3UFUtmn43D2sz83c4nOhlt+GQN8M3LWIpcUdDTM3IxLHu5/BQfrt
 +MfMbGiLZTd4gr4nKZ/CLDRec6WJDkYfWG2vM3HMjtc2ESwPqnV4IOPJu3Zw2ENocH
 2Q68NG1d6GcqrQikCVjkM8SwFVpkAkMrAaTU8jyU5bYuX2N1zEvOxlLzdYMLaT0Y0v
 HbK+/wUuBbE2g==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 00/11] C3700 patches
Date: Wed, 18 Oct 2023 22:40:19 +0200
Message-ID: <20231018204030.391572-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
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

for you to fetch changes up to 6120e493c9c5b7d2b122f2501ea1c2cc2b64d1e3:

  hw/hppa: Add new HP C3700 machine (2023-10-17 23:13:19 +0200)

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
- moved HP VENDOR PCI ID numerically into list (suggested by BALATON Zoltan)

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
 hw/pci-host/astro.c         | 876 ++++++++++++++++++++++++++++++++++++
 hw/pci-host/meson.build     |   1 +
 hw/pci-host/trace-events    |  11 +
 include/hw/pci-host/astro.h |  92 ++++
 include/hw/pci/pci_ids.h    |   2 +
 pc-bios/hppa-firmware.img   | Bin 732376 -> 755480 bytes
 roms/seabios-hppa           |   2 +-
 14 files changed, 1292 insertions(+), 82 deletions(-)
 create mode 100644 hw/pci-host/astro.c
 create mode 100644 include/hw/pci-host/astro.h

-- 
2.41.0


