Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D13825B15
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 20:32:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLpuW-0000Mq-1d; Fri, 05 Jan 2024 14:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rLpuO-0000Jn-1r; Fri, 05 Jan 2024 14:31:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rLpuL-00031a-Na; Fri, 05 Jan 2024 14:31:07 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4482240D31;
 Fri,  5 Jan 2024 22:30:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DC8235B1F1;
 Fri,  5 Jan 2024 22:30:39 +0300 (MSK)
Received: (nullmailer pid 116622 invoked by uid 1000);
 Fri, 05 Jan 2024 19:30:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/6] docs: use "buses" rather than "busses"
Date: Fri,  5 Jan 2024 22:30:38 +0300
Message-Id: <20240105193038.116576-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105193038.116576-1-mjt@tls.msk.ru>
References: <20240105193038.116576-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Samuel Tardieu <sam@rfc1149.net>

If "busses" might be encountered as a plural of "bus" (5 instances),
the correct spelling is "buses" (26 instances). Fixing those 5
instances makes the doc more consistent.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.39.2


