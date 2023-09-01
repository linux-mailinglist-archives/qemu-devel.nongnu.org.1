Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE578FB42
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc0gE-00024p-22; Fri, 01 Sep 2023 05:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0g1-0001u1-Dg; Fri, 01 Sep 2023 05:42:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc0fy-0002wb-TD; Fri, 01 Sep 2023 05:42:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RcY3p4rFXz4x3D;
 Fri,  1 Sep 2023 19:42:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RcY3m4hFGz4x2D;
 Fri,  1 Sep 2023 19:42:44 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 11/26] m25p80: Introduce an helper to retrieve the BlockBackend
 of a device
Date: Fri,  1 Sep 2023 11:41:59 +0200
Message-ID: <20230901094214.296918-12-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901094214.296918-1-clg@kaod.org>
References: <20230901094214.296918-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=SnXb=ER=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

It will help in getting rid of some drive_get(IF_MTD) calls by
retrieving the BlockBackend directly from the m25p80 device.

Cc: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/block/flash.h | 4 ++++
 hw/block/m25p80.c        | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 7198953702b7..de93756cbe8f 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -76,4 +76,8 @@ uint8_t ecc_digest(ECCState *s, uint8_t sample);
 void ecc_reset(ECCState *s);
 extern const VMStateDescription vmstate_ecc_state;
 
+/* m25p80.c */
+
+BlockBackend *m25p80_get_blk(DeviceState *dev);
+
 #endif
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index dc5ffbc4ff52..afc3fdf4d60b 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -25,6 +25,7 @@
 #include "qemu/units.h"
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
+#include "hw/block/flash.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
@@ -1830,3 +1831,8 @@ static void m25p80_register_types(void)
 }
 
 type_init(m25p80_register_types)
+
+BlockBackend *m25p80_get_blk(DeviceState *dev)
+{
+    return M25P80(dev)->blk;
+}
-- 
2.41.0


