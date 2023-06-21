Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD1737DF2
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtd5-0004tI-O4; Wed, 21 Jun 2023 04:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcp-0004Po-OY
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtco-0005Jj-4l
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mEdEKrn8U4oFpRm6aYVrdum8IY3Swn/ona6HoA0rkf8=; b=jfgXiJUJGBoBqK7rh/22WmDxmx
 Q+umK9wPPbjjfy1BSLQXJixPh6L/TxBJWfpVI1jcnj57c8OPsck7ZFHVWQQlU+OBaBw/G54gbqTyE
 kfYMUW7y1uk/IFIrW47Mb112O7c1VQ0qKUBXyluvXLIJ+358ueXd59g35eMh7zRLmtmzfVakA86av
 Ct3Ngf6+K55lfwR2JeoY5Z1eimQlau422mSkYFdSEG3UqztfcS9QCgZ9KtLtQ/h1zcPKAUGqcmXoR
 j7ZDyoUZWw1U3LBomsBDYo7FkwFyJaREYqlxGx7u4qwhK9aZ+6iI3/F2QTcCRXdtRg8qpXEWbWsJp
 SoDLdmhHAU36l7kdulOAoMzMeZvwFWXuWvlA+LOY2eUXp6x+QlsqN/4JcP2001drd08BFf9XAAd7F
 vk4pBgQLYS1X/TeqgLgqUDsS5ghFj3CHLSW3NcxeFfK7TGLHGKbZXNMmRh7MkPI/moXpr8HLOBWMX
 o6/05baHtn9qy6Oe7eyzQpexVybDV/7Iu32uVL3LLoz/GSabnve7ZO/oUSqVmP6G8s9lFbQb75QOL
 HJutVXtGR3bNdGESjNd7bLtTA5j8jyOZ/UHgMwcNVEjJP4VXMmxs0F8N7J2WObPdyPxmyPOaKFieH
 ip51xKuDN0YPKmNpLI+DpqVvon/W5k62T6ZcXalT0=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcS-0001ZB-2U; Wed, 21 Jun 2023 09:55:19 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:52 +0100
Message-Id: <20230621085353.113233-24-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 23/24] mac_via: fix rtc command decoding from PRAM
 addresses 0x0 to 0xf
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

A comparison between the rtc command table included in the comment and the code
itself shows that the decoding for PRAM addresses 0x0 to 0xf is being done on
the raw command, and not the shifted version held in value.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 076d18e5fd..85c2e65856 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -399,7 +399,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
         } else if ((value & 0x1c) == 0x08) {
             /* RAM address 0x10 to 0x13 */
             return read | (REG_PRAM_ADDR + 0x10 + (value & 0x03));
-        } else if ((value & 0x43) == 0x41) {
+        } else if ((value & 0x10) == 0x10) {
             /* RAM address 0x00 to 0x0f */
             return read | (REG_PRAM_ADDR + (value & 0x0f));
         }
-- 
2.30.2


