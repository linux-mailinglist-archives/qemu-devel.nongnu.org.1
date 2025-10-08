Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D86BC336F
	for <lists+qemu-devel@lfdr.de>; Wed, 08 Oct 2025 05:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Kkv-0001kY-HB; Tue, 07 Oct 2025 23:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kks-0001jl-Ap; Tue, 07 Oct 2025 23:22:18 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kkp-0000T8-I2; Tue, 07 Oct 2025 23:22:17 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 8 Oct
 2025 11:22:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 8 Oct 2025 11:22:07 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 00/16] Introduce AspeedCoprocessor class and base
 implementation
Date: Wed, 8 Oct 2025 11:21:45 +0800
Message-ID: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
  1. Remove AspeedSoCState dependency from aspeed_uart_first, aspeed_uart_last,
     aspeed_soc_uart_set_chr, aspeed_soc_cpu_type, aspeed_mmio_map,
     aspeed_mmio_map_unimplemented, aspeed_soc_get_irq, and
     aspeed_soc_uart_realize APIs.
  2. Introduce AspeedCoprocessor class and base implementation

Jamin Lin (16):
  hw/arm/aspeed: Remove AspeedSoCState dependency from
    aspeed_uart_first() API
  hw/arm/aspeed: Remove AspeedSoCClass dependency from
    aspeed_uart_last() API
  hw/arm/aspeed: Remove AspeedSoCState dependency from
    aspeed_soc_uart_set_chr() API
  hw/arm/aspeed: Remove AspeedSoCClass dependency from
    aspeed_soc_cpu_type() API
  hw/arm/aspeed: Remove AspeedSoCState dependency from aspeed_mmio_map()
    API
  hw/arm/aspeed: Remove AspeedSoCState dependency from
    aspeed_mmio_map_unimplemented() API
  hw/arm/aspeed: Remove AspeedSoCState dependency from
    aspeed_soc_get_irq() API
  hw/arm/aspeed: Remove AspeedSoCState dependency from
    aspeed_soc_uart_realize() API
  hw/arm/aspeed: Introduce AspeedCoprocessor class and base
    implementation
  hw/arm/aspeed_ast27x0-ssp: Make AST27x0 SSP inherit from
    AspeedCoprocessor instead of AspeedSoC
  hw/arm/aspeed_ast27x0-tsp: Make AST27x0 TSP inherit from
    AspeedCoprocessor instead of AspeedSoC
  hw/arm/aspeed_ast27x0-ssp: Change to use Aspeed27x0CoprocessorState
  hw/arm/aspeed_ast27x0-tsp: Change to use Aspeed27x0CoprocessorState
  hw/arm/aspeed_ast27x0-ssp: Rename type to
    TYPE_ASPEED27X0SSP_COPROCESSOR
  hw/arm/aspeed_ast27x0-tsp: Rename type to
    TYPE_ASPEED27X0TSP_COPROCESSOR
  hw/arm/aspeed_ast27x0-{ssp,tsp}: Fix coding style

 include/hw/arm/aspeed_coprocessor.h |  62 ++++++++++++++
 include/hw/arm/aspeed_soc.h         |  51 ++++-------
 hw/arm/aspeed.c                     |  10 ++-
 hw/arm/aspeed_ast10x0.c             |  92 ++++++++++++--------
 hw/arm/aspeed_ast2400.c             |  97 ++++++++++++---------
 hw/arm/aspeed_ast2600.c             | 126 +++++++++++++++++-----------
 hw/arm/aspeed_ast27x0-fc.c          |  33 +++++---
 hw/arm/aspeed_ast27x0-ssp.c         |  73 ++++++++--------
 hw/arm/aspeed_ast27x0-tsp.c         |  73 ++++++++--------
 hw/arm/aspeed_ast27x0.c             | 109 +++++++++++++-----------
 hw/arm/aspeed_coprocessor_common.c  |  49 +++++++++++
 hw/arm/aspeed_soc_common.c          |  63 +++++++-------
 hw/arm/fby35.c                      |  10 ++-
 hw/arm/meson.build                  |   3 +-
 14 files changed, 522 insertions(+), 329 deletions(-)
 create mode 100644 include/hw/arm/aspeed_coprocessor.h
 create mode 100644 hw/arm/aspeed_coprocessor_common.c

-- 
2.43.0


