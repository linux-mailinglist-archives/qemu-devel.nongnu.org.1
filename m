Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BFA7CC7ED
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:49:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmHh-0005xg-4h; Tue, 17 Oct 2023 11:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsmHe-0005wV-4h
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:47:02 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsmHc-00032H-Bd
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:47:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 38D61CE1F9C;
 Tue, 17 Oct 2023 15:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2A0C433C7;
 Tue, 17 Oct 2023 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697557609;
 bh=gstNqH2tB++BOmG34L0bZTZoFcKvYl0zGNHwopbPQ+w=;
 h=From:To:Cc:Subject:Date:From;
 b=Rd887k4M7s3KwNeCtF7sL/yXFglBb+sUXLP4TbfS8xeKTaoh6e+CDbxUCjLm8kqm6
 RxiO2sc7anw7JTd+hYY9V3G0LEiVtYwtnk180VweQBf17KjdxcC/k/Z39Vcf4Go6+p
 Hea8F2C8lQwaBVSdZO7Fah8xcbAJm8aeU1Tbk0RRW56EgZdtkv2UXCnH4/HnA7Ecal
 RUdmyJ5tzHzXlTwc4ynM4Ihe2rgG8FqBm1q0Toy3TFQatCxM+CQ8Gqqgc3ir+aK4dD
 Slnuzsprx5ENdv0ufPXfp3U8dB3tvBfH8XNURrFDT/PARyO0LNLRa52S35aEulr7Ny
 y1PiZqHF0KRvw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 00/11] target/hppa: Add emulation of a C3700 HP-PARISC
 workstation
Date: Tue, 17 Oct 2023 17:46:34 +0200
Message-ID: <20231017154645.95844-1-deller@kernel.org>
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

Helge

V2 changes:
suggestions by BALATON Zoltan <balaton@eik.bme.hu>:
- merged pci_ids and tulip patch
- dropped comments in lasips2
- mention additional cleanups in patch "Require at least SeaBIOS-hppa version 10"
suggestions by Philippe Mathieu-Daudé <philmd@linaro.org>:
- dropped static pci_bus variable

Helge Deller (11):
  target/hppa: Update to SeaBIOS-hppa version 10
  pci_ids/tulip: Add PCI vendor ID for HP and use it in tulip
  hw/pci-host: Add Astro system bus adapter found on PA-RISC machines
  MAINTAINERS: Add Astro PCI host for hppa machines
  lasips2: LASI PS/2 devices are not user-createable
  pci-host: Wire up new Astro/Elroy PCI bridge
  hw/hppa: Require at least SeaBIOS-hppa version 10
  hw/hppa: Export machine name, BTLBs, power-button address via fw_cfg
  hw/hppa: Provide RTC and DebugOutputPort on CPU #0
  hw/hppa: Split out machine creation
  hw/hppa: Add new HP C3700 machine

 MAINTAINERS                 |   5 +-
 hw/hppa/Kconfig             |   1 +
 hw/hppa/hppa_hardware.h     |   1 -
 hw/hppa/machine.c           | 367 +++++++++++----
 hw/input/lasips2.c          |   2 +
 hw/net/tulip.c              |   2 +-
 hw/pci-host/Kconfig         |   4 +
 hw/pci-host/astro.c         | 876 ++++++++++++++++++++++++++++++++++++
 hw/pci-host/meson.build     |   1 +
 hw/pci-host/trace-events    |  11 +
 include/hw/pci-host/astro.h |  92 ++++
 include/hw/pci/pci_ids.h    |   2 +
 pc-bios/hppa-firmware.img   | Bin 732376 -> 755480 bytes
 roms/seabios-hppa           |   2 +-
 14 files changed, 1284 insertions(+), 82 deletions(-)
 create mode 100644 hw/pci-host/astro.c
 create mode 100644 include/hw/pci-host/astro.h

-- 
2.41.0


