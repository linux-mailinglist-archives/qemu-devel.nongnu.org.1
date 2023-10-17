Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D67CCABD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:36:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsotu-00023M-EI; Tue, 17 Oct 2023 14:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsotr-00022s-22
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:34:40 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsotp-0002sn-Cl
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:34:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D13E0615A4;
 Tue, 17 Oct 2023 18:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656FAC433C7;
 Tue, 17 Oct 2023 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697567675;
 bh=gdI5BbhN672b+PkBmQeBWOkJbDV/CDS10T80uV6bcyE=;
 h=From:To:Cc:Subject:Date:From;
 b=WQgVJkML72d7LCqGChDTItuEVtk8SyUn6PwOfALfuuCSRxNaO+Y+Xm50cQD0Wfd4q
 PzowPMIf0DvFWtqylNpytEg2FpsHmjQJHluZM4S1EP5zOHzQ01fFzNmn8+lr728OXI
 ZnoKrNt4x63hKsQJNsP6IOvn76bO1NwoU06L+TjfD5AhUtGqf+Xuj6ANyZPUKNQYrZ
 q3MnhSYEiJcW615D1FabwoBJ0CdxUY+ieczrWCGbfiiLRB1Vd4hxKjYAEYFs1UjwHD
 cdVrqucOCVlaDGlY0f2ti2hUFdnzDjejOZaVvlFceQSAocDJXUyX73oRQwbEm+yhK+
 nEGBLvIDIR3zQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 00/11] target/hppa: Add emulation of a C3700 HP-PARISC
 workstation
Date: Tue, 17 Oct 2023 20:34:21 +0200
Message-ID: <20231017183432.117243-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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


