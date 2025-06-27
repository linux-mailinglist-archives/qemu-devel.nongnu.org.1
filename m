Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F03FAEAD0F
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Jun 2025 04:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUzGG-0007ed-Fo; Thu, 26 Jun 2025 22:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUzGC-0007dX-Ug; Thu, 26 Jun 2025 22:56:16 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUzGA-0006B6-Gd; Thu, 26 Jun 2025 22:56:16 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 27 Jun
 2025 10:56:06 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 27 Jun 2025 10:56:06 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 0/3] Add QEMU model for ASPEED OTP memory and integrate
 with SoC
Date: Fri, 27 Jun 2025 10:56:02 +0800
Message-ID: <20250627025606.631167-1-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

This patch series introduces a QEMU model for the ASPEED OTP (One-Time
Programmable) memory, along with its integration into the Secure Boot
Controller (SBC) and supported SoC (AST2600).

The OTP model emulates a simple fuse array used for secure boot or
device configuration, implemented with internal buffers; external
file/device support not included in this version. It exposes an
AddressSpace to support transaction-based access from controllers
like the SBC.

This series includes:
  - OTP memory device implementation
  - SBC integration with command decoding (READ/PROG)
  - Direct integration in AST2600 SoC without requiring user parameters

Any feedback or suggestions are appreciated!

Kane
---

ChangeLog
---------
v2:
- Rename device from 'aspeed_otpmem' to 'aspeed_otp' and move it to hw/nvram/
- Move OTP device realization from instance_init to the realize function
- Improve error logging with qemu_log_mask() and remove unused error propagation

v1:
- Initial version

---

Kane-Chen-AS (3):
  hw/misc/aspeed_otp: Add ASPEED OTP memory device model
  hw/misc/aspeed_sbc: Connect ASPEED OTP memory device to SBC
  hw/arm: Integrate ASPEED OTP memory support into AST2600 SoCs

 include/hw/misc/aspeed_sbc.h  |   5 ++
 include/hw/nvram/aspeed_otp.h |  30 +++++++++
 hw/arm/aspeed_ast2600.c       |   2 +-
 hw/misc/aspeed_sbc.c          | 119 ++++++++++++++++++++++++++++++++++
 hw/nvram/aspeed_otp.c         |  94 +++++++++++++++++++++++++++
 hw/misc/trace-events          |   5 ++
 hw/nvram/meson.build          |   4 ++
 7 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/nvram/aspeed_otp.h
 create mode 100644 hw/nvram/aspeed_otp.c

-- 
2.43.0


