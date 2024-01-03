Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF60823337
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:29:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL52a-0000wY-2c; Wed, 03 Jan 2024 12:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rL52X-0000v8-0d; Wed, 03 Jan 2024 12:28:25 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rL52U-0000WM-RU; Wed, 03 Jan 2024 12:28:24 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id 3A59C80024;
 Wed,  3 Jan 2024 18:28:19 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Peter Maydell <peter.maydell@linaro.org>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH] docs: use "buses" rather than "busses"
Date: Wed,  3 Jan 2024 18:28:17 +0100
Message-ID: <20240103172817.2197737-1-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

If "busses" might be encountered as a plural of "bus" (5 instances),
the correct spelling is "buses" (26 instances). Fixing those 5
instances makes the doc more consistent.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 docs/system/arm/palm.rst    | 2 +-
 docs/system/arm/xscale.rst  | 2 +-
 docs/system/devices/can.rst | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/palm.rst b/docs/system/arm/palm.rst
index 47ff9b36d4..61bc8d34f4 100644
--- a/docs/system/arm/palm.rst
+++ b/docs/system/arm/palm.rst
@@ -14,7 +14,7 @@ following elements:
 -  On-chip Real Time Clock
 
 -  TI TSC2102i touchscreen controller / analog-digital converter /
-   Audio CODEC, connected through MicroWire and |I2S| busses
+   Audio CODEC, connected through MicroWire and |I2S| buses
 
 -  GPIO-connected matrix keypad
 
diff --git a/docs/system/arm/xscale.rst b/docs/system/arm/xscale.rst
index d2d5949e10..e239136c3c 100644
--- a/docs/system/arm/xscale.rst
+++ b/docs/system/arm/xscale.rst
@@ -32,4 +32,4 @@ The clamshell PDA models emulation includes the following peripherals:
 
 -  Three on-chip UARTs
 
--  WM8750 audio CODEC on |I2C| and |I2S| busses
+-  WM8750 audio CODEC on |I2C| and |I2S| buses
diff --git a/docs/system/devices/can.rst b/docs/system/devices/can.rst
index 0af3d9912a..09121836fd 100644
--- a/docs/system/devices/can.rst
+++ b/docs/system/devices/can.rst
@@ -1,12 +1,12 @@
 CAN Bus Emulation Support
 =========================
 The CAN bus emulation provides mechanism to connect multiple
-emulated CAN controller chips together by one or multiple CAN busses
-(the controller device "canbus"  parameter). The individual busses
+emulated CAN controller chips together by one or multiple CAN buses
+(the controller device "canbus"  parameter). The individual buses
 can be connected to host system CAN API (at this time only Linux
 SocketCAN is supported).
 
-The concept of busses is generic and different CAN controllers
+The concept of buses is generic and different CAN controllers
 can be implemented.
 
 The initial submission implemented SJA1000 controller which
-- 
2.42.0


