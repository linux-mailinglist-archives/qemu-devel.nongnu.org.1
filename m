Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6573CAA8
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 13:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD1mU-00010L-Fs; Sat, 24 Jun 2023 07:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1mS-0000zg-PF
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:50:16 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1mM-0001AV-Cw
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687607408; x=1688212208; i=deller@gmx.de;
 bh=mmwc0+YeydBHhttdFF+mzdvUAK2itNPp02vAtTkY3c8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IZ8R8P4/QgF84YTYjEfAx/Ewy88vM+R5M8lsgFtVWvks4hsKTPKJcC9gENMm50U3LR+ARFl
 Lfuc3NHYA/stkRz5W9AlTAPD8nk6QTgzT3+7gIHhlItMkNVeviVi4mWMY7bNHmeJZGXvGidBj
 CpJE3uUBuICi5Ir9zD84gi+o4J4U71PCStbsXAvtzNEMsOOf6w+px1xouBJwTFU1fCJhtp2ks
 5bxc0p6w7PW7ShbfZs3NXMLjhzJNH6Ks/ZxkyQiFUYsgeUlniGEzOgJi3MpvMM/uBalDptfNn
 B+zQ4yo9t1WP2JEeLIrY0oFyKnDWRLJsOqCdsUZygzVYx6uhLLzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.156.152]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1pfst60fn6-00bcbI; Sat, 24
 Jun 2023 13:50:08 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL v2 2/3] target/hppa: Provide qemu version via fw_cfg to firmware
Date: Sat, 24 Jun 2023 13:50:06 +0200
Message-Id: <20230624115007.30332-3-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624115007.30332-1-deller@gmx.de>
References: <20230624115007.30332-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ctit7f49IfVbYy7T6IAX1AdDPEzSFO4v8ONRUyUj6JdmsZA7/QA
 Za2tkbwrLjLw3am6CwJ2xvWcewFF+N9T+BSY/2kOBlnFcXzU/qpM/HUEeSUSvsIGfRimejb
 OLauheNalDZw94GxPvVaKoHrXJCZs10rVawB97d5QOYiGrNNXFmh1fCahOPJo5oryG19buK
 mIWBGw1I4ubbkPQx4/2Ag==
UI-OutboundReport: notjunk:1;M01:P0:gTlhqC1qrN4=;q6O8HqkkTwWf16S9tC5zAigH3UI
 fQbwI3KKlg/tH+9vJoIr1KG74bKJf53Y1mPio6KB7kjA+geGycvEi0ZPC0JToBu5rkAZg7Xd5
 UApA2bulGMqreviIxss6tupRleYcgQOA9mGmbJ6JxEfp69d/yxh4jm+OLVLcMWbu7pXH25f9N
 WWqUZSi2QQ26au5eO1Ar8MUXcqFHRtsvWIepk/VUTT1uQfNytWD6uVQ1J+mUmcNTw+6m3+0Ue
 uoK8SI+B8QO7p1SInj+qigOS657eLrpDQkYg8/XAHplX3r2kXI+XYQlufS43Ow8XF1tgWBV/+
 tJXU0JwOfZvmFlyAF5aFdYRJEJfKxp5mSx1f5PjvqsoRIT/Y+dRDYqqp8251tHNGeluQjGjgY
 McfVG++pZytu8k1W/KEWuWLwke/xHaacrwTZmTujLyMuRHg2/Ud+Ni0ZYGAWfByr48Jga/him
 WYaFiJ7C9BwCtEVEguilXdH5GTOanhxkBmqsAXRVSuAcKeVxxJGQK+aR17FXnqxl8uXqGgIjn
 XYlf4jlmYQp9qO/8dWbnosMU4xWPRivZ48/Klw1qD/fB9gM/Y0aH5ydcrsSEnLHjoE/lu/omE
 gJ4ZDMcoDoOBdJdOV6mM98STQXDcpjR+U+OBlG12loTz/GpfaqfvCcSGdhay1Zinw+nveSJ7I
 M8F88JCxLJqf30XjQf6cBAZ9yRgtFquNJKiW43973OpDaBWLnKNgEdCoWyPVY0UirGuRucQpU
 y/zvESx3eUwRUcOQ3dH0V/B4Cq6lGcObca01BJqYSnAIKhJheDLoq140QgtGuvMxPcDp3FTAq
 rlDl8o3fuXQJDf1yeDK4nxgTEW2QTto/6VKrFvoJY9/rQKFQR5VL3S+wbwpTBGgA4ei40Z1HQ
 3A2s4WVoDh8AiK6i4OicgUYsrkSnr+bvrBKe/7jiHzySe5AErTj+USV71BpyADmBMS2yNYdyq
 4/erlJVTWRkVk5mAJichohY4b4o=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Give current QEMU version string to SeaBIOS-hppa via fw_cfg interface so
that the firmware can show the QEMU version in the boot menu info.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 9facef7f14..866e11d208 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -122,6 +122,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
 {
     FWCfgState *fw_cfg;
     uint64_t val;
+    const char qemu_version[] =3D QEMU_VERSION;

     fw_cfg =3D fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
@@ -147,6 +148,10 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_config.order[0]);
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);

+    fw_cfg_add_file(fw_cfg, "/etc/qemu-version",
+                    g_memdup(qemu_version, sizeof(qemu_version)),
+                    sizeof(qemu_version));
+
     return fw_cfg;
 }

=2D-
2.38.1


