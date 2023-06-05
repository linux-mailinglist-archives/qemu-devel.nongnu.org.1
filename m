Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 203617224A9
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68SZ-0004QH-VL; Mon, 05 Jun 2023 07:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SS-0004LE-6Y
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:33:09 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SQ-0008Nh-JO
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dv2FTKxmkfHw2Qtwg4lbhGixm1rdRd+MteBWL4Oc5nc=; b=efeTOVGU2AgH88hfHFgEolKubg
 7pM7E/++r4PytB5Pa13FWeyqySuK3d5DrYx2pVW4b6l9gYQtgR2W8H4Rsyq0VYh23L0zczkFCYldq
 aL7AeS+ywaVmGB1xJYnyrGqfdYm5ldkNE2TKcxvOwmpkT7BKtn9xNqkY1WA3wRHkeljJp56JRHxtW
 m53PheymgI3BAGqdzo4MnKE9qMeaEoKX9VjvTZ8QwM0UUAUAe34BJv8Pqv070VwJHIsaJX4+wLO1E
 +ZgRyLA07JcJeGTO+HL90naZPIgmo+Mlu695CwGizyJ9SUD5iguO4+i0zFakMoZEZzLyDHRblxyTR
 0jjo3KowrPfhGs7VNupm4Qj+mPz5AUJveBb2uX5PhFJAR0NPS24PghS6yd/ftf3SUI+08wAS4Lop5
 +5itFT4h1BIVAiwXy4k2tX0PbxR1m/z6Gznc4yb2Z259KYAcOdWmrypO5WWieobYS1zdz8jxZgG55
 wyEtUp2cDbZ0yNxuX2+/GoD47r/TNYhJ/NTtzFsph+7o+IizZph20sz5RAxUo5HJilw2bFE58Ry+g
 r7i4Y1px+Wt/zZq/LkqyuvKdtlgfwnZnxoiG1+fX4tbSgNpPD49djyObcRr6ihnrIvqOU4eh7JGxx
 cPP8Y/PyjRW9SH8VcJKRWUkS86GdbQvLOhVovDJig=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q68SJ-0005fJ-AJ; Mon, 05 Jun 2023 12:33:03 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Mon,  5 Jun 2023 12:32:51 +0100
Message-Id: <20230605113253.455937-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
References: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 1/3] hw/timer/i8254_common: Share "iobase" property via base
 class
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Both TYPE_KVM_I8254 and TYPE_I8254 have their own but same implementation of
the "iobase" property. The storage for the property already resides in
PITCommonState, so also move the property definition there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230523195608.125820-2-shentey@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/i386/kvm/i8254.c     | 1 -
 hw/timer/i8254.c        | 6 ------
 hw/timer/i8254_common.c | 6 ++++++
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 191a26fa57..6a7383d877 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -301,7 +301,6 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
 }
 
 static Property kvm_pit_properties[] = {
-    DEFINE_PROP_UINT32("iobase", PITCommonState, iobase,  -1),
     DEFINE_PROP_LOSTTICKPOLICY("lost_tick_policy", KVMPITState,
                                lost_tick_policy, LOST_TICK_POLICY_DELAY),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index c8388ea432..c235496fc9 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -350,11 +350,6 @@ static void pit_realizefn(DeviceState *dev, Error **errp)
     pc->parent_realize(dev, errp);
 }
 
-static Property pit_properties[] = {
-    DEFINE_PROP_UINT32("iobase", PITCommonState, iobase,  -1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void pit_class_initfn(ObjectClass *klass, void *data)
 {
     PITClass *pc = PIT_CLASS(klass);
@@ -366,7 +361,6 @@ static void pit_class_initfn(ObjectClass *klass, void *data)
     k->get_channel_info = pit_get_channel_info_common;
     k->post_load = pit_post_load;
     dc->reset = pit_reset;
-    device_class_set_props(dc, pit_properties);
 }
 
 static const TypeInfo pit_info = {
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 050875b497..e4093e2904 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -240,6 +240,11 @@ static const VMStateDescription vmstate_pit_common = {
     }
 };
 
+static Property pit_common_properties[] = {
+    DEFINE_PROP_UINT32("iobase", PITCommonState, iobase,  -1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pit_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -252,6 +257,7 @@ static void pit_common_class_init(ObjectClass *klass, void *data)
      * done by board code.
      */
     dc->user_creatable = false;
+    device_class_set_props(dc, pit_common_properties);
 }
 
 static const TypeInfo pit_common_type = {
-- 
2.30.2


