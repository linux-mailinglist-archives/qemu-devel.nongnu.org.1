Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697447A66C5
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 16:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qibki-00029k-Em; Tue, 19 Sep 2023 10:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luca.Wei@verisilicon.com>)
 id 1qiUkV-00055V-0X; Tue, 19 Sep 2023 03:02:19 -0400
Received: from shasxm03.verisilicon.com ([101.89.135.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <Luca.Wei@verisilicon.com>)
 id 1qiUkS-0007vD-A4; Tue, 19 Sep 2023 03:02:18 -0400
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=Verisilicon.com; s=default;
 c=simple/simple; t=1695106588; h=from:subject:to:date:message-id;
 bh=AcqL0GPwR8yVgYjpwTXOYquzOfSzOhx0HrKi6AZ/J+U=;
 b=SrzK9l2eE/eZ1V4UufOAh/byTJaYRzVhMsILusWHY4K4FfDJYkmZfuv0U35fq3QBv+DsHv43urf
 th0j5JSJvdi36M7FsMbQ9hshFrPjRHrZ141VzpQB0EJEILSEktnko4a0Dp9D/sSyrdcZlpo7JnOnn
 Wrp27KFt7ckLO0UQ6OY=
Received: from SHASXM06.verisilicon.com ([fe80::59a8:ce34:dc14:ddda]) by
 SHASXM03.verisilicon.com ([::1]) with mapi id 14.03.0408.000; Tue, 19 Sep
 2023 14:56:28 +0800
From: Luca Wei <Luca.Wei@verisilicon.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
CC: "eric.auger@linaro.org" <eric.auger@linaro.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, Luca Wei <Luca.Wei@verisilicon.com>, Zijian Wang
 <Zijian.Wang@verisilicon.com>, Zhe Pan <Zhe.Pan@verisilicon.com>
Subject: [PATCH] hw/intc/arm_gicv3_kvm.c: Set the qemu_irq/gsi mapping for
 VFIO platform
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm.c: Set the qemu_irq/gsi mapping
 for VFIO platform
Thread-Index: AdnqxmktPrHVh4ILQ0GyPV2lkqMP1Q==
Date: Tue, 19 Sep 2023 06:56:28 +0000
Message-ID: <2FDAC4096138FA4DB2F2BDCE0F9521C00182151E@SHASXM06.verisilicon.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.91.89]
MIME-Version: 1.0
Received-SPF: pass client-ip=101.89.135.44;
 envelope-from=Luca.Wei@verisilicon.com; helo=shasxm03.verisilicon.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Sep 2023 10:30:57 -0400
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

Eric added the qemu_irq/gsi hash table to let VFIO platform device
setup irqfd when kvm enabled [1]. And he setup the qemu_irq/gsi
mapping in arm_gic_kvm.c [2]. But this mapping is not setting up in
arm_gicv3_kvm.c. When VM use VFIO platform device with gicv3,
the irqfd setup will fail and fallback to userspace handled eventfd
in `vfio_start_irqfd_injection`.

This patch will setup the qemu_irq/gsi mapping for gicv3, so that
VFIO platform device with gicv3 can use kvm irqfd to accelerate.

[1] https://lore.kernel.org/qemu-devel/20150706183506.15635.61812.stgit@gim=
li.home/
[2] https://lore.kernel.org/qemu-devel/20150706183512.15635.915.stgit@gimli=
.home/

Signed-off-by: Luca Wei <Luca.Wei@verisilicon.com>
---
 hw/intc/arm_gicv3_kvm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 72ad916d3d..7e90f8b723 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -807,6 +807,11 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Er=
ror **errp)

     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);

+    for (i =3D 0; i < s->num_irq - GIC_INTERNAL; i++) {
+        qemu_irq irq =3D qdev_get_gpio_in(dev, i);
+        kvm_irqchip_set_qemuirq_gsi(kvm_state, irq, i);
+    }
+
     for (i =3D 0; i < s->num_cpu; i++) {
         ARMCPU *cpu =3D ARM_CPU(qemu_get_cpu(i));

--
2.41.0.windows.3

