Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3597FBDCB70
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 08:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8uuK-0000s9-KB; Wed, 15 Oct 2025 02:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuB-0000rg-El; Wed, 15 Oct 2025 02:22:37 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uu6-0002tw-VC; Wed, 15 Oct 2025 02:22:34 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Oct
 2025 14:22:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Oct 2025 14:22:10 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 00/12] Coprocessor and memory mapping improvements for
 AST2700
Date: Wed, 15 Oct 2025 14:21:55 +0800
Message-ID: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
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
  1. Improved memory mapping
  2. Added SRAM support and increased SDRAM size to 512MB to fix
     coprocessor crash observed in SDK v09.08
  3. Updated coprocessor functional tests for SDK v09.08
  4. Added VBOOTROM support
  5. Shared a single SCU instance among PSP, SSP, and TSP
  6. Shared UART set among PSP, SSP, and TSP

Jamin Lin (12):
  hw/arm/aspeed_ast27x0-ssp: Add SDRAM region and fix naming and size to
    512MB
  hw/arm/aspeed_ast27x0-tsp: Add SDRAM region and fix naming and size to
    512MB
  hw/arm/ast27x0: Add SRAM link and alias mapping for SSP coprocessor
  hw/arm/ast27x0: Add SRAM link and alias mapping for TSP coprocessor
  hw/arm/ast27x0: Share single SCU instance across PSP, SSP, and TSP
  hw/arm/ast27x0: Share single UART set across PSP, SSP, and TSP
  hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents into CA35 boot ROM
  hw/arm/aspeed_ast27x0-fc: Add VBOOTROM support
  tests/functional/aarch64/ast2700fc: Update test ASPEED SDK v09.08
  tests/functional/aarch64/ast2700fc: Add eth2 network interface check
    in PCIe test
  tests/functional/aarch64/ast2700fc: Move coprocessor image loading to
    common function
  tests/functional/aarch64/ast2700fc: Add vbootrom test

 include/hw/arm/aspeed_coprocessor.h           | 14 ++--
 hw/arm/aspeed_ast27x0-fc.c                    | 55 +++++++++++----
 hw/arm/aspeed_ast27x0-ssp.c                   | 69 +++++++++----------
 hw/arm/aspeed_ast27x0-tsp.c                   | 69 +++++++++----------
 hw/arm/aspeed_coprocessor_common.c            |  7 ++
 .../aarch64/test_aspeed_ast2700fc.py          | 51 ++++++++++----
 6 files changed, 160 insertions(+), 105 deletions(-)

-- 
2.43.0


