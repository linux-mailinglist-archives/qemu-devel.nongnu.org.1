Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C75A911E2
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 05:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Fdr-0005zN-5Y; Wed, 16 Apr 2025 23:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1u5Fdh-0005tZ-PW; Wed, 16 Apr 2025 23:10:11 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1u5Fdf-0000B0-FK; Wed, 16 Apr 2025 23:10:09 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 17 Apr
 2025 11:09:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 17 Apr 2025 11:09:57 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 0/3] hw/misc/aspeed_otp: Introduce OTP memory and integrate
 with SBC
Date: Thu, 17 Apr 2025 11:09:52 +0800
Message-ID: <20250417030957.2586802-1-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Dear reviewers,

This patch series introduces a new model for the ASPEED OTP (One-Time
Programmable) memory and integrates it with the ASPEED Secure Boot
Controller (SBC) and SoC models such as AST1030 and AST2600.

The OTP memory is implemented as a QEMU device (`aspeed.otpmem`) and is
designed to simulate fuse-like behavior using a block backend. Programming
is restricted by irreversible bit-flip rules (e.g., 0->1 or 1->0 depending
on address parity). The memory content is persistent and can be passed via
`-drive id=otpmem`.

The SBC device (`aspeed.sbc`) accesses the OTP device through a QOM link
property. This decouples OTP handling from the SBC logic and allows
future extensibility such as secure configuration or key provisioning.

The SoC integration connects the OTP memory to the SBC and provides
device-tree-style infrastructure for future firmware use.

Any feedback or suggestions are appreciated!

Thanks,  
Kane

---

ChangeLog
---------
v2:
- Separated the OTP memory into a standalone QEMU device (`aspeed.otpmem`)
- Replaced ad-hoc file handling with standard `-drive` backend integration
- Linked OTP to SBC via QOM property for cleaner abstraction
- Improved memory bounds checking and irreversible programming logic

v1:
- Embedded OTP logic in the SBC model and created the backing file internally.

---

Kane-Chen-AS (3):
  hw/misc/aspeed_otp: Add Aspeed OTP memory device model
  hw/misc/aspeed_sbc: Connect Aspeed OTP memory device to SBC controller
  hw/arm: Integrate Aspeed OTP memory into AST10x0 and AST2600 SoCs

 hw/arm/aspeed_ast10x0.c         |  19 +++
 hw/arm/aspeed_ast2600.c         |  19 +++
 hw/misc/aspeed_otpmem.c         | 217 ++++++++++++++++++++++++++++++++
 hw/misc/aspeed_sbc.c            | 155 +++++++++++++++++++++++
 hw/misc/meson.build             |   1 +
 include/hw/arm/aspeed_soc.h     |   2 +
 include/hw/misc/aspeed_otpmem.h |  40 ++++++
 include/hw/misc/aspeed_sbc.h    |  15 +++
 8 files changed, 468 insertions(+)
 create mode 100644 hw/misc/aspeed_otpmem.c
 create mode 100644 include/hw/misc/aspeed_otpmem.h

-- 
2.43.0


