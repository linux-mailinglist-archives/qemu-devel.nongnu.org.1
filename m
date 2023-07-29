Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B7768206
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 23:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPrKH-0002hR-KB; Sat, 29 Jul 2023 17:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qPrKD-0002gT-PE; Sat, 29 Jul 2023 17:18:09 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qPrKB-0001fE-Uj; Sat, 29 Jul 2023 17:18:09 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 094B41C0004;
 Sat, 29 Jul 2023 21:18:01 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] Complete i.MX6UL and i.MX7 processor for bare metal
 application.
Date: Sat, 29 Jul 2023 23:17:55 +0200
Message-Id: <cover.1690663106.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jcd@tribudubois.net
Received-SPF: pass client-ip=217.70.183.197; envelope-from=jcd@tribudubois.net;
 helo=relay5-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds a few unimplemented TZ devices (TZASC and CSU) to
i.MX6UL and i.MX7 processors to avoid bare metal application to
experiment "bus error" when acccessing these devices.

It also adds some internal memory segments (OCRAM) to the i.MX7 to
allow bare metal application to use them.

Last, it adds the SRC device to the i.MX7 processor to allow bare
metal application to start the secondary Cortex-A7 core.

Note: When running Linux inside Qemu, the secondary core is started
by calling PSCI API and Qemu is emulating PSCI without needing access
to the SRC device. This is why Linux is using the 2 cores in Qemu
even if the SRC is not implemented. This is not the case when running
bare metal application (like u-boot itself) that do not rely on the
PSCI service being available.

Changes since v1:
* split the i.MX6UL patch into a refactor patch and an addon patch.
* Split the i.MX7 patch into a refactor patch and an addon patch.
* Fix SRC code after few comments in code review.

Jean-Christophe Dubois (5):
  Refactor i.MX6UL processor code
  Add i.MX6UL TZ missing devices.
  Refactor i.MX7 processor code
  Add i.MX7 missing TZ devices and memory regions
  Add i.MX7 SRC device implementation

 hw/arm/fsl-imx6ul.c         | 161 ++++++++++++-----
 hw/arm/fsl-imx7.c           | 205 ++++++++++++++++-----
 hw/misc/imx7_src.c          | 276 ++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 hw/misc/trace-events        |   4 +
 include/hw/arm/fsl-imx6ul.h | 149 +++++++++++++--
 include/hw/arm/fsl-imx7.h   | 348 +++++++++++++++++++++++++++---------
 include/hw/misc/imx7_src.h  |  66 +++++++
 8 files changed, 1026 insertions(+), 184 deletions(-)
 create mode 100644 hw/misc/imx7_src.c
 create mode 100644 include/hw/misc/imx7_src.h

-- 
2.34.1


