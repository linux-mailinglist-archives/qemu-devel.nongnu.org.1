Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 820BCB4FBFB
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Sep 2025 15:02:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvxzU-0001SL-VU; Tue, 09 Sep 2025 09:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250909125107fd9fc1512a000207d7-sK_0XD@rts-flowmailer.siemens.com>)
 id 1uvxyi-0000cR-CT
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:01:47 -0400
Received: from mta-64-225.siemens.flowmailer.net ([185.136.64.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250909125107fd9fc1512a000207d7-sK_0XD@rts-flowmailer.siemens.com>)
 id 1uvxyV-0003qL-Fg
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:01:44 -0400
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20250909125107fd9fc1512a000207d7 for <qemu-devel@nongnu.org>;
 Tue, 09 Sep 2025 14:51:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kkRpO//T+PjJhy9IHmFuzLKzxO29OnKYQ61ApxkJLd4=;
 b=cppVG3SYnx1gbNidV0d7rFT1Big6jN4ditx2ykWBT0OSZB0dOJvqH0WHp9UHGI7wUet63L
 R8lKAsBSbH8Fs3SbS7K/AfGbjxvxyIU0L7WSTlmfDE5any6gM/N2FCoImKgDZQJb8DOQtRGV
 l+D5jezcbbnRfg4jzdYU2EhT+8W61CNif5uEYoGxoc+qspTzOTnBoh1p356P04ng8avZPO9a
 RMtLJeSVIkxL1GBLWh9vG9xWPsS2TmDd4wGNzqqcMCGG1GVGsTUbz+qGYtYgprKucRWQ+ND8
 p+CmgmKSD3XrRJk3glbMwdGPAutdJzla90sAdNg9Tw63ruP9QM7v72aQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>
Subject: [PATCH v3 6/6] docs: Add eMMC device model description
Date: Tue,  9 Sep 2025 14:50:56 +0200
Message-ID: <2a8d6226903d8dcf9615b5ac5a40522b6bf2f7c3.1757422256.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757422256.git.jan.kiszka@siemens.com>
References: <cover.1757422256.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.225;
 envelope-from=fm-294854-20250909125107fd9fc1512a000207d7-sK_0XD@rts-flowmailer.siemens.com;
 helo=mta-64-225.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 docs/system/device-emulation.rst |  1 +
 docs/system/devices/emmc.rst     | 52 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 docs/system/devices/emmc.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 911381643f..36429b1d17 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -101,3 +101,4 @@ Emulated Devices
    devices/canokey.rst
    devices/usb-u2f.rst
    devices/igb.rst
+   devices/emmc.rst
diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
new file mode 100644
index 0000000000..3bd70c0e94
--- /dev/null
+++ b/docs/system/devices/emmc.rst
@@ -0,0 +1,52 @@
+==============
+eMMC Emulation
+==============
+
+Besides SD card emulation, QEMU also offers an eMMC model as found on many
+embedded boards. An eMMC, just like an SD card, is connected to the machine
+via an SDHCI controller.
+
+Create eMMC Images
+==================
+
+A recent eMMC consists of 4 partitions: 2 boot partitions, 1 Replay protected
+Memory Block (RPMB), and the user data area. QEMU expects backing images for
+the eMMC to contain those partitions concatenated in exactly that order.
+However, the boot partitions as well as the RPMB might be absent if their sizes
+are configured to zero.
+
+The eMMC specification defines alignment constraints for the partitions. The
+two boot partitions must be of the same size. Furthermore, boot and RPMB
+partitions must be multiples of 128 KB with a maximum of 32640 KB for each
+boot partition and 16384K for the RPMB partition.
+
+The alignment constrain of the user data area depends on its size. Up to 2
+GByte, the size must be a power of 2. From 2 GByte onward, the size has to be
+multiples of 512 byte.
+
+QEMU is enforcing those alignment rules before instantiating the device.
+Therefore, the provided image has to strictly follow them as well. The helper
+script `scripts/mkemmc.sh` can be used to create compliant images, with or
+without pre-filled partitions. E.g., to create an eMMC image from a firmware
+image and an OS image with an empty 2 MByte RPMB, use the following command:
+
+.. code-block:: console
+
+    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
+
+This will take care of rounding up the partition sizes to the next valid value
+and will leave the RPMB and the second boot partition empty (zeroed).
+
+Adding eMMC Devices
+===================
+
+An eMMC is either automatically created by a machine model (e.g. Aspeed boards)
+or can be user-created when using a PCI-attached SDHCI controller. To
+instantiate the eMMC image form the example above while assuming that the
+firmware needs a boot partitions of 1 MB, use the following options:
+
+.. code-block:: console
+
+    -drive file=emmc.img,if=none,format=raw,id=emmc-img
+    -device sdhci-pci
+    -device emmc,drive=emmc-img,boot-partition-size=1048576 rpmb-partition-size=2097152
-- 
2.51.0


