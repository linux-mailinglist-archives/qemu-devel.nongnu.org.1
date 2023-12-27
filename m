Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 848DB81F065
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 17:28:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIWki-0000iI-Uf; Wed, 27 Dec 2023 11:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ukl@pengutronix.de>)
 id 1rIWkh-0000i9-TA
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 11:27:27 -0500
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ukl@pengutronix.de>)
 id 1rIWkf-0004k4-Dd
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 11:27:27 -0500
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1rIWk9-00059l-Ry; Wed, 27 Dec 2023 17:26:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1rIWjw-001tZH-HS; Wed, 27 Dec 2023 17:26:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
 (envelope-from <ukl@pengutronix.de>) id 1rIWjx-001Wmd-1d;
 Wed, 27 Dec 2023 17:26:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudeep Holla <sudeep.holla@arm.com>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, Thierry Reding <treding@nvidia.com>,
 Hao Ge <gehao@kylinos.cn>, Rob Herring <robh@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arnd Bergmann <arnd@arndb.de>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dinh Nguyen <dinguyen@kernel.org>,
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nava kishore Manne <nava.kishore.manne@amd.com>,
 Rajan Vaja <rajan.vaja@xilinx.com>, Dhaval Shah <dhaval.r.shah@amd.com>,
 Marek Vasut <marex@denx.de>
Cc: kernel@pengutronix.de, Cristian Marussi <cristian.marussi@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>, chrome-platform@lists.linux.dev,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-mediatek@lists.infradead.org, qemu-devel@nongnu.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 00/11] firmware: Convert to platform remove callback returning
 void
Date: Wed, 27 Dec 2023 17:26:24 +0100
Message-ID: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285;
 i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id;
 bh=tI3zkKx4Ui/NNKJl8C0bvrZtoud3+4uqGjgMG21LlTs=;
 b=owGbwMvMwMXY3/A7olbonx/jabUkhtSeAKNH8tevhnB8dlzNPIGlymlxs/6VfQ7Zsacbwi4eS
 m/jlu3vZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiCa/Z/9cn838+oXFr/z2L
 FyUtR2cw+haX73S48WmTZ9FOuTgxrrTr8lYvFvFx7OX2yc6QnvUtSviR/N5ft82FOnsDUv9/tlj
 eskLcWs9N+PqrufauLGUqGWY6t7dqca28cfdQXvW8eTafm1bPVv/j/rpm78XrGxiCbzm0Nz68YO
 xYtWSa6gaNrIybLSzGNhHeZXLT1Xi9D6/vOe708zk3d33rrux1X9LsXZa8jhJnuhPyVLryz8MFO
 mk27O+F0mfK/qlxOduSf3JesLWJY8PtiEbdO8E/TrfNvvdeuetgsmG4TjtXXIrBqWN7Lir2hcbv
 2R3tYjRPK7tZ8KNkyfbGmcUVh0wfbwlTWRz6K+jbg5pZAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=ukl@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Hello,

this series converts all platform drivers below drivers/firmware that
make use of .remove() to use .remove_new() instead.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.
The TL;DR; is to make it harder for driver authors to leak resources
without noticing. The drivers here get it right though and so can be
converted trivially.

This is merge window material. There doesn't seem to be a maintainer for
all of drivers/firmware and I don't know how patch application works
there usually.  All patches are pairwise independent, so they can be
applied individually.

Best regards
Uwe

Uwe Kleine-König (11):
  firmware: arm_scmi: Convert to platform remove callback returning void
  firmware: arm_scpi: Convert to platform remove callback returning void
  firmware: coreboot_table: Convert to platform remove callback returning void
  firmware: imx-dsp: Convert to platform remove callback returning void
  firmware: mtk-adsp-ipc: Convert to platform remove callback returning void
  firmware: qemu_fw_cfg: Convert to platform remove callback returning void
  firmware: raspberrypi: Convert to platform remove callback returning void
  firmware: stratix10-rsu: Convert to platform remove callback returning void
  firmware: stratix10-svc: Convert to platform remove callback returning void
  firmware: turris-mox-rwtm: Convert to platform remove callback returning void
  firmware: zynqmp: Convert to platform remove callback returning void

 drivers/firmware/arm_scmi/driver.c       | 6 ++----
 drivers/firmware/arm_scpi.c              | 6 ++----
 drivers/firmware/google/coreboot_table.c | 5 ++---
 drivers/firmware/imx/imx-dsp.c           | 6 ++----
 drivers/firmware/mtk-adsp-ipc.c          | 6 ++----
 drivers/firmware/qemu_fw_cfg.c           | 5 ++---
 drivers/firmware/raspberrypi.c           | 6 ++----
 drivers/firmware/stratix10-rsu.c         | 5 ++---
 drivers/firmware/stratix10-svc.c         | 6 ++----
 drivers/firmware/turris-mox-rwtm.c       | 6 ++----
 drivers/firmware/xilinx/zynqmp.c         | 6 ++----
 11 files changed, 22 insertions(+), 41 deletions(-)

base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
-- 
2.43.0


