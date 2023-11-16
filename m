Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66817EDE96
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:34:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ZhN-0004HQ-BU; Thu, 16 Nov 2023 05:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhK-0004G6-TH; Thu, 16 Nov 2023 05:34:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhJ-0006KO-Bl; Thu, 16 Nov 2023 05:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=99JoRfo2bDLXfSmRKNCRIX4XbY16dpu/h8y4PDn1Mzw=; b=G1r+n2hxc1N9w/gBsgUnM42EYs
 vFkBKIkUy1MfhyvK8adqiLxVpa9Z+hFWe6OAA6WwLxZXtgF+qHHodqqy+1rhz5yQiFkR2iVBXIBwH
 TbWVMq3SttrGMv8eLAdv8Eh5P6o+gz5VWgcbtkGxNU3hP7Om3IbX6mWkuKW3sa0zuLe2yG5NVkrEN
 LCdZlIvm6wlJrA96Zd2xknSOLSh8LRKnD1NB/67yEGEPfJJl/IR5WTN3dnnESWnM2MImfrKjScM0d
 JREU/MSBoPjWo8X3TQo3oXFgRhNvy+ERjiJQa51bQr0do8IpPeRMO38K6GTaLuHJzfWaNLgmTbcX0
 YRl+Con8lXu8X/64WK0YF3SlNSGgAdzsq/N3m/ku5Q4JhkHHJRHQwpFgKdXPjbNlz1Dh06YxgMh96
 OyO2f1FLOPCxMA0u+BI8ga3uf36vx/FGUntGzSsL6suYZZrlrVAdySI9tzD7F0XXYtLAa+4jF/ck5
 opCXTNB3HRkIu5fNk8BmrDw3n1h6RSlkvwb5NgYPgc9HIqDd0B/UY7QjGQSTbMfLCBeAKcQu8ZveK
 30T1Egg8BxpGNKsgpwOE/piD2HY35VtFHwPjtAGrTvKTQiWeCRr54CKszQuvoF8gA2vRO/bHU2eHr
 XQHvl2TS+40qt8crQ9LBq31H+wn1jaeeueweDSWZc=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3Zh0-0001bP-Qb; Thu, 16 Nov 2023 10:33:54 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, balaton@eik.bme.hu, philmd@linaro.org,
 shentey@gmail.com
Date: Thu, 16 Nov 2023 10:33:52 +0000
Message-Id: <20231116103355.588580-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 1/4] ide/ioport: move ide_portio_list[] and
 ide_portio_list2[] definitions to IDE core
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

These definitions are present in ioport.c which is currently only available when
CONFIG_IDE_ISA is enabled. Move them to the IDE core so that they can be made
available to PCI IDE controllers that support switching to legacy mode.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/core.c             | 12 ++++++++++++
 hw/ide/ioport.c           | 12 ------------
 include/hw/ide/internal.h |  3 +++
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 63ba665f3d..8a0579bff4 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -81,6 +81,18 @@ static const char *IDE_DMA_CMD_str(enum ide_dma_cmd enval)
 
 static void ide_dummy_transfer_stop(IDEState *s);
 
+const MemoryRegionPortio ide_portio_list[] = {
+    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
+    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
+    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
+    PORTIO_END_OF_LIST(),
+};
+
+const MemoryRegionPortio ide_portio2_list[] = {
+    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
+    PORTIO_END_OF_LIST(),
+};
+
 static void padstr(char *str, const char *src, int len)
 {
     int i, v;
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index e2ecc6230c..0b283ac783 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -28,18 +28,6 @@
 #include "hw/ide/internal.h"
 #include "trace.h"
 
-static const MemoryRegionPortio ide_portio_list[] = {
-    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
-    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
-    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
-    PORTIO_END_OF_LIST(),
-};
-
-static const MemoryRegionPortio ide_portio2_list[] = {
-    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
-    PORTIO_END_OF_LIST(),
-};
-
 int ide_init_ioport(IDEBus *bus, ISADevice *dev, int iobase, int iobase2)
 {
     int ret;
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 2bfa7533d6..3bdcc75597 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -354,6 +354,9 @@ enum ide_dma_cmd {
 
 extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
 
+extern const MemoryRegionPortio ide_portio_list[];
+extern const MemoryRegionPortio ide_portio2_list[];
+
 #define ide_cmd_is_read(s) \
         ((s)->dma_cmd == IDE_DMA_READ)
 
-- 
2.39.2


