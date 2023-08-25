Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A578870D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 14:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZVp2-000417-Qh; Fri, 25 Aug 2023 08:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qZVoT-0003vw-Mo; Fri, 25 Aug 2023 08:21:22 -0400
Received: from relay3-d.mail.gandi.net ([2001:4b98:dc4:8::223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qZVoP-0004v8-Ib; Fri, 25 Aug 2023 08:21:17 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C14460003;
 Fri, 25 Aug 2023 12:21:06 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] Complete i.MX6UL and i.MX7 processor for bare metal
 application.
Date: Fri, 25 Aug 2023 14:20:50 +0200
Message-Id: <cover.1692964891.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jcd@tribudubois.net
Received-SPF: pass client-ip=2001:4b98:dc4:8::223;
 envelope-from=jcd@tribudubois.net; helo=relay3-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

Changes since v3:
* Add a specific patch to remove IOMUXC GPR device from i.MX6UL
* remove unimplemented IOMUXC GPR device frome i.MX7D
* move the initialisation of PWM devices 5 to 8 to 3rd patch
* put the init of i.MX7d devices in previous order to ease review
* Remove device memory size from header file when the device is actually
  implemented in QEMU (the device implementation defines the memory
  size it manages).

Changes since v2:
* use GiB, MiB, KiB constant defined in qemu/units.h after code review

Changes since v1:
* split the i.MX6UL patch into a refactor patch and an addon patch.
* Split the i.MX7 patch into a refactor patch and an addon patch.
* Fix SRC code after few comments in code review.

Jean-Christophe Dubois (6):
  Remove i.MX7 IOMUX GPR device from i.MX6UL
  Refactor i.MX6UL processor code
  Add i.MX6UL missing devices.
  Refactor i.MX7 processor code
  Add i.MX7 missing TZ devices and memory regions
  Add i.MX7 SRC device implementation

 hw/arm/fsl-imx6ul.c         | 174 ++++++++++++-------
 hw/arm/fsl-imx7.c           | 201 +++++++++++++++++-----
 hw/misc/imx7_src.c          | 276 +++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 hw/misc/trace-events        |   4 +
 include/hw/arm/fsl-imx6ul.h | 136 +++++++++++++--
 include/hw/arm/fsl-imx7.h   | 334 +++++++++++++++++++++++++++---------
 include/hw/misc/imx7_src.h  |  66 +++++++
 8 files changed, 995 insertions(+), 197 deletions(-)
 create mode 100644 hw/misc/imx7_src.c
 create mode 100644 include/hw/misc/imx7_src.h

-- 
2.34.1


