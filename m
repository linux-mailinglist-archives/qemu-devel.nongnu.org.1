Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AC17C9629
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:58:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrklb-0003sY-Q2; Sat, 14 Oct 2023 15:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklW-0003s3-4A
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:38 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklT-0004Ya-G4
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:37 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A8B7ECE022B;
 Sat, 14 Oct 2023 19:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDF7C433C8;
 Sat, 14 Oct 2023 19:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697313442;
 bh=y24mDVImIH9F1NyeT6+ma2MuYqmKAcu36abyViwhkas=;
 h=From:To:Cc:Subject:Date:From;
 b=p5D6l8avzwFA8hzrJPg8wbhdX95+R6GG97uXP2VQurMK1tBtNB1FOBI5CBeqqx84b
 EO5+5xw+vdsncUdL6NSXRR4CzSLXQcCj8dVqotN4/RXSpe9YXIO2M9tUgRtkPs4irv
 ZRPWPb1+rgn84KrmIfEn4XRc0P2s+ai2U/Nk3TzEnPHihyGrERWp8vwAECR/QuPX6h
 LgjLRRUJ4vt0JD4ujnOgWOsMBy1vtJgdedEIy5Lc1qsS2agbjBw+XjCrKsRUnsAXVK
 ltblS91ZZfVHI3/sh4j/ST8C6t5qyyvoYKsQaM0b+W8UfTcAnS67U1Ko2hA6JXh3pR
 gPTVC+OvuNGyg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 00/12] target/hppa: Add emulation of a C3700 HP-PARISC
 workstation
Date: Sat, 14 Oct 2023 21:57:07 +0200
Message-ID: <20231014195719.151397-1-deller@kernel.org>
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

This series adds a new PA-RISC machine emulation for the HP-PARISC
C3700 workstation.

The physical HP C3700 machine has a PA2.0 (64-bit) CPU, in contrast to
the existing emulation of a B160L workstation which is a 32-bit only
machine and where it's Dino PCI controller isn't 64-bit capable.

With the HP C3700 machine emulation (together with the emulated Astro
Memory controller and the Elroy PCI bridge) it's now possible to
enhance the hppa CPU emulation to support the 64-bit instruction set
in upcoming patches.

Please review.

Helge

Helge Deller (12):
  target/hppa: Update to SeaBIOS-hppa version 10
  pci_ids: Add PCI vendor ID for HP
  hw/pci-host: Add Astro system bus adapter found on PA-RISC machines
  MAINTAINERS: Add Astro PCI host for hppa machines
  lasips2: LASI PS/2 devices are not user-createable
  tulip: Use the HP PCI vendor ID instead of number
  pci-host: Wire up new Astro/Elroy PCI bridge
  hw/hppa: Require at least SeaBIOS-hppa version 10
  hw/hppa: Export machine name, BTLBs, power-button address via fw_cfg
  hw/hppa: Provide RTC and DebugOutputPort on CPU #0
  hw/hppa: Split out machine creation
  hw/hppa: Add new HP C3700 machine

 MAINTAINERS                 |   5 +-
 hw/hppa/Kconfig             |   1 +
 hw/hppa/hppa_hardware.h     |   1 -
 hw/hppa/machine.c           | 364 +++++++++++----
 hw/input/lasips2.c          |   4 +
 hw/net/tulip.c              |   2 +-
 hw/pci-host/Kconfig         |   4 +
 hw/pci-host/astro.c         | 876 ++++++++++++++++++++++++++++++++++++
 hw/pci-host/meson.build     |   1 +
 hw/pci-host/trace-events    |  11 +
 include/hw/pci-host/astro.h |  92 ++++
 include/hw/pci/pci_ids.h    |   2 +
 pc-bios/hppa-firmware.img   | Bin 732376 -> 755480 bytes
 roms/seabios-hppa           |   2 +-
 14 files changed, 1284 insertions(+), 81 deletions(-)
 create mode 100644 hw/pci-host/astro.c
 create mode 100644 include/hw/pci-host/astro.h

-- 
2.41.0


