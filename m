Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46097C9978
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1uw-0001IU-AR; Sun, 15 Oct 2023 10:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qs1uu-0001IH-9N; Sun, 15 Oct 2023 10:16:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qs1us-0001X7-0L; Sun, 15 Oct 2023 10:16:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 604DB757253;
 Sun, 15 Oct 2023 16:15:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 219317456A7; Sun, 15 Oct 2023 16:15:17 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] MAINTANERS: Split vt82c686 out of fuloong2e
To: qemu-devel@nongnu.org,
    qemu-trivial@nongnu.org
Cc: philmd@linaro.org,
    Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20231015141517.219317456A7@zero.eik.bme.hu>
Date: Sun, 15 Oct 2023 16:15:17 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, PP_MIME_FAKE_ASCII_TEXT=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The VIA south bridgges are now mostly used by other machines not just
fuloong2e so split off into a separate section and take maintanership.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2:
- Rebase on master
- Take Philippe's offer and accept maintaining it (I hope Philippe can
  still help with review and pull requests)

 MAINTAINERS | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca405bc1bc..6b15de530c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1324,10 +1324,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/fuloong2e.c
-F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
-F: hw/usb/vt82c686-uhci-pci.c
-F: include/hw/isa/vt82c686.h
 F: include/hw/pci-host/bonito.h
 F: tests/avocado/machine_mips_fuloong2e.py
 
@@ -2491,6 +2488,15 @@ S: Maintained
 F: hw/isa/piix4.c
 F: include/hw/southbridge/piix.h
 
+VIA South Bridges (VT82C686B, VT8231)
+M: BALATON Zoltan <balaton@eik.bme.hu>
+S: Maintained
+R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
+F: hw/isa/vt82c686.c
+F: hw/usb/vt82c686-uhci-pci.c
+F: include/hw/isa/vt82c686.h
+
 Firmware configuration (fw_cfg)
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Gerd Hoffmann <kraxel@redhat.com>
-- 
2.30.9


