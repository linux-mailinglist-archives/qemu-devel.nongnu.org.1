Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F21E737DDF
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:56:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtcW-0003Vf-LQ; Wed, 21 Jun 2023 04:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcS-0003O4-An
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcQ-00055n-GO
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4IL1GZjuekZgVUgNf/eYQgnMiGylOKscGLf22vZHKTI=; b=HND2W/y5LQs/Kp8E9ATh5WBed7
 qujp9bOU4M/mB71QVmNzseaNAB12b10/hzprAjSvRoj31L1PaMynwtNyfvmhr/4NQa9DjLisMpyAd
 otL1XzUjb+DQuH59XpQYxqvDl9dO2yswLlho3madH9jilaz5bLIqthfbBH8EbGdoBpdMOWGG4xxoq
 yf6u9ZWVo5uhzeylv8s+BNUptQ0DnG0cialBtxNSIyNGj6NYC+IY7VomA2k6hTYqYFZhkRVuydVTv
 v7f3w8oBxSLkhFa63gZrKPaPx2rS5IEHV2ffjNZDYlUqkfuzW3oePow+oehJ0gaKynKEiclh65um5
 pcxpklnsSyh+LwHjNDQHxJfVFB1HYhOiQm8M+biQsG9D6/UGGOQ7KIK7ju+cG0QnlBV0KZ6rt8LyH
 FWfJq1eSinc43RhmGIjRBUWaPQwgg6sIRESsTO2I4PQ/4FKCI6GwnMEAdg7jnHjsRSy5z7VCK+/CX
 jNmjcB/7OlMB32wTbae4bDkSBp1rnk4PAMGQipx0nlipH4LXwaqBKXLejfPP85q339xCGCm3ch3R+
 GQWNzzskS0yyBo8DUUL/+Nsj6bp/nmd4zq9MIf8/XBnx0mUqRQZTRkE0HUJSDWUs7I2TofQD989/3
 XYpWfVGCG0eS/mzJW+aJzIdtHNUKFxME1hk3KFCu8=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtc5-0001ZB-H0; Wed, 21 Jun 2023 09:54:57 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:45 +0100
Message-Id: <20230621085353.113233-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 16/24] q800: move ESCC device to Q800MachineState
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

Also change the instantiation of the ESCC device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 6 ++++--
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 13806613fa..8bf94b2511 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -346,7 +346,9 @@ static void q800_machine_init(MachineState *machine)
 
     /* SCC */
 
-    dev = qdev_new(TYPE_ESCC);
+    object_initialize_child(OBJECT(machine), "escc", &m->escc,
+                            TYPE_ESCC);
+    dev = DEVICE(&m->escc);
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", MAC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -356,7 +358,7 @@ static void q800_machine_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "chnBtype", 0);
     qdev_prop_set_uint32(dev, "chnAtype", 0);
     sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
 
     /* Logically OR both its IRQs together */
     escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index d11bc020ed..9e76a3fe7c 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -30,6 +30,7 @@
 #include "hw/m68k/q800-glue.h"
 #include "hw/misc/mac_via.h"
 #include "hw/net/dp8393x.h"
+#include "hw/char/escc.h"
 
 /*
  * The main Q800 machine
@@ -44,6 +45,7 @@ struct Q800MachineState {
     MOS6522Q800VIA1State via1;
     MOS6522Q800VIA2State via2;
     dp8393xState dp8393x;
+    ESCCState escc;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


