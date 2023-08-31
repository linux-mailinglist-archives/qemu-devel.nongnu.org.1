Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A117B78ED72
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 14:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbgxn-0007w3-Gu; Thu, 31 Aug 2023 08:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org>)
 id 1qbgxX-0007n3-6E; Thu, 31 Aug 2023 08:39:42 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org>)
 id 1qbgxU-0008BZ-7c; Thu, 31 Aug 2023 08:39:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rc1295R06z4x09;
 Thu, 31 Aug 2023 22:39:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rc1270sk2z4wZJ;
 Thu, 31 Aug 2023 22:39:26 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 0/7] aspeed: Add blockdev support for flash device
 definition
Date: Thu, 31 Aug 2023 14:39:15 +0200
Message-ID: <20230831123922.105200-1-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a respin of series [1] without the patches merged in 8.1.
Since I renamed a property as suggested, I though people might want to
see the result before the next aspeed PR.

It offers the capability to define all CS of all SPI controllers
without introducing new machine types, using blockdev on the command
line :

    -blockdev node-name=fmc0,driver=file,filename=./flash-ast2600-evb \
    -device mx66u51235f,bus=ssi.0,cs=0x0,drive=fmc0 \
    -blockdev node-name=fmc1,driver=file,filename=./flash-ast2600-evb-alt \
    -device mx66u51235f,bus=ssi.0,cs=0x1,drive=fmc1 \
    -blockdev node-name=spi1,driver=file,filename=./ast2600-evb.pnor \
    -device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \

With these changes, it is now possible :

 - to define block backends out of order instead relying on the command
   line order when using drives.
   
 - to define *all* devices backends. Some machines support up to 8.
 
 - to use different flash models without adding new boards. Machine
   options "spi-model" and "fmc-model" could be deprecated.
   
 - to start the machine with -nodefaults to let it fetch instructions
   from the FMC0 device, as HW does. Machine option "execute-in-place"
   could be deprecated.

Ultimately, we will get rid of drive_get(IF_MTD, ...) but we are not
there yet.

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20230607043943.1837186-1-clg@kaod.org/

Changes in v3:

  - renamed "addr" property to "cs"

Changes in v2:

  - changed "addr" property to a uint8_t
  - renamed "uart" machine option to "bmc-console" 

Cédric Le Goater (7):
  hw/ssi: Add a "cs" property to SSIPeripheral
  hw/ssi: Introduce a ssi_get_cs() helper
  aspeed/smc: Wire CS lines at reset
  hw/ssi: Check for duplicate CS indexes
  aspeed: Create flash devices only when defaults are enabled
  m25p80: Introduce an helper to retrieve the BlockBackend of a device
  aspeed: Get the BlockBackend of FMC0 from the flash device

 include/hw/block/flash.h            |  4 +++
 include/hw/ssi/ssi.h                |  5 ++++
 hw/arm/aspeed.c                     | 19 +++++++------
 hw/arm/stellaris.c                  |  4 ++-
 hw/arm/xilinx_zynq.c                |  1 +
 hw/arm/xlnx-versal-virt.c           |  1 +
 hw/arm/xlnx-zcu102.c                |  2 ++
 hw/block/m25p80.c                   |  6 ++++
 hw/microblaze/petalogix_ml605_mmu.c |  1 +
 hw/ssi/aspeed_smc.c                 |  8 ++++++
 hw/ssi/ssi.c                        | 43 +++++++++++++++++++++++++++++
 11 files changed, 84 insertions(+), 10 deletions(-)

-- 
2.41.0


