Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C87252FB
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 06:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6kxv-0001kM-P0; Wed, 07 Jun 2023 00:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5JAy=B3=kaod.org=clg@ozlabs.org>)
 id 1q6kxt-0001j9-4c; Wed, 07 Jun 2023 00:40:09 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5JAy=B3=kaod.org=clg@ozlabs.org>)
 id 1q6kxq-0003Sy-37; Wed, 07 Jun 2023 00:40:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QbZQ43WM1z4x42;
 Wed,  7 Jun 2023 14:39:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbZQ13c8Fz4x2c;
 Wed,  7 Jun 2023 14:39:53 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 00/12] aspeed: fixes and extensions
Date: Wed,  7 Jun 2023 06:39:31 +0200
Message-Id: <20230607043943.1837186-1-clg@kaod.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5JAy=B3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello,

This series fixes issues spotted by Coverity and adds a couple of
improvements for the machine definition.

The first is to offer the capability to define all CS of all SPI
controllers without introducing new machine types, using a blockdev on
the command line :

    -blockdev node-name=fmc0,driver=file,filename=./flash.img
    -device mx66u51235f,addr=0x0,bus=ssi.0,drive=fmc0

instead of using drives which relies on the command line order.
Ultimately, we will get rid of drive_get(IF_MTD, ...) but we are not
there yet. For this, SSIPeripheral is extended with an "addr"
property.

A second extension is the introduction of a "bmc-console" machine
option to let the user define the default UART device of the machine
from the QEMU command line :

    -M ast2500-evb,bmc-console=uart3

Last, a new "vfp-d32" CPU property is added to ARM CPUs to model FPUs
implementing VFPv4 without NEON support and with 16 64-bit FPU
registers (and not 32 registers). This is the case for the Cortex A7
of the Aspeed AST2600 SoC. I hope I got it right this time.

Thanks,

C.

Changes in v2:

  - changed "addr" property to a uint8_t
  - renamed "uart" machine option to "bmc-console" 

Cédric Le Goater (12):
  aspeed/hace: Initialize g_autofree pointer
  aspeed: Introduce a boot_rom region at the machine level
  aspeed: Use the boot_rom region of the fby35 machine
  hw/ssi: Add an "addr" property to SSIPeripheral
  hw/ssi: Introduce a ssi_get_cs() helper
  aspeed/smc: Wire CS lines at reset
  hw/ssi: Check for duplicate addresses
  aspeed: Create flash devices only when defaults are enabled
  m25p80: Introduce an helper to retrieve the BlockBackend of a device
  aspeed: Get the BlockBackend of FMC0 from the flash device
  aspeed: Introduce a "bmc-console" machine option
  target/arm: Allow users to set the number of VFP registers

 docs/system/arm/aspeed.rst          | 11 +++++
 include/hw/block/flash.h            |  4 ++
 include/hw/ssi/ssi.h                |  5 +++
 target/arm/cpu.h                    |  2 +
 hw/arm/aspeed.c                     | 69 ++++++++++++++++++++++-------
 hw/arm/aspeed_ast2600.c             |  2 +
 hw/arm/fby35.c                      | 29 ++++++------
 hw/arm/stellaris.c                  |  4 +-
 hw/arm/xilinx_zynq.c                |  1 +
 hw/arm/xlnx-versal-virt.c           |  1 +
 hw/arm/xlnx-zcu102.c                |  2 +
 hw/block/m25p80.c                   |  6 +++
 hw/microblaze/petalogix_ml605_mmu.c |  1 +
 hw/misc/aspeed_hace.c               |  2 +-
 hw/ssi/aspeed_smc.c                 |  8 ++++
 hw/ssi/ssi.c                        | 43 ++++++++++++++++++
 target/arm/cpu.c                    | 32 +++++++++++++
 17 files changed, 190 insertions(+), 32 deletions(-)

-- 
2.40.1


