Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D97DDA911E5
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 05:12:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Ffo-0000m9-97; Wed, 16 Apr 2025 23:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u5Ffj-0000lb-Po; Wed, 16 Apr 2025 23:12:15 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u5Ffh-0000cO-MV; Wed, 16 Apr 2025 23:12:15 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 17 Apr
 2025 11:12:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 17 Apr 2025 11:12:09 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>
Subject: [PATCH v4 00/10] Support vbootrom for AST2700
Date: Thu, 17 Apr 2025 11:11:57 +0800
Message-ID: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

v1:
  Add initial support for AST27x0
  The purpose of vbootrom here is to simulate the work of BootMCU SPL (riscv)
  in AST2700, because QEMU doesn't support heterogenous architecture yet.

  ast27x0_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for
  ASPEED AST27x0 BMC SOC. It currently implements the bare minimum to
  load, parse, initialize and run boot images stored in SPI flash, but may grow
  more features over time as needed. The source code is available at:
  https://github.com/google/vbootrom

v2:
  Add "Introduced ASPEED_DEV_VBOOTROM in the device enumeration" patch to fix
  build failed.

v3:
  1. Supports both vbootrom and device loader boot methods, with vbootrom used as
  the default.
  2. Fix review and QTEST test failed issues. 

v4: 
  Adjust the patch order.

Jamin Lin (10):
  hw/arm/aspeed_ast27x0: Rename variable sram_name to name in ast2700
    realize
  hw/arm/aspeed_ast27x0 Introduce vbootrom memory region
  hw/arm/aspeed: Add vbootrom support on AST2700 EVB machines
  hw/arm/aspeed: Reuse rom_size variable for vbootrom setup
  pc-bios: Add AST27x0 vBootrom
  hw/arm/aspeed: Add support for loading vbootrom image via "-bios"
  tests/functional/aspeed: Move I2C test into shared helper for AST2700
    reuse
  tests/functional/aspeed: Update test ASPEED SDK v09.06
  tests/functional/aspeed: Add to test vbootrom for AST2700
  docs/system/arm/aspeed: Support vbootrom for AST2700

 MAINTAINERS                             |   1 +
 docs/system/arm/aspeed.rst              |  29 +++++++++++-
 include/hw/arm/aspeed.h                 |   2 +
 include/hw/arm/aspeed_soc.h             |   3 ++
 hw/arm/aspeed.c                         |  41 +++++++++++++++-
 hw/arm/aspeed_ast27x0.c                 |  20 ++++++--
 pc-bios/README                          |   6 +++
 pc-bios/ast27x0_bootrom.bin             | Bin 0 -> 15464 bytes
 pc-bios/meson.build                     |   1 +
 tests/functional/test_aarch64_aspeed.py |  59 +++++++++++++++---------
 10 files changed, 135 insertions(+), 27 deletions(-)
 create mode 100644 pc-bios/ast27x0_bootrom.bin

-- 
2.43.0


