Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5527BCCA1
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpND1-0008AV-OJ; Sun, 08 Oct 2023 02:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCx-00088C-6a
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCv-0007oe-Ja
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:06 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1McYP5-1rSHKY3uBR-00cz7l; Sun, 08
 Oct 2023 08:24:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 17/20] mac_via: always clear ADB interrupt when switching to
 A/UX mode
Date: Sun,  8 Oct 2023 08:23:46 +0200
Message-ID: <20231008062349.2733552-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BMXWP8Q34Sevebo8reZLo4kp0iF+VOdKjvSubFk/7siirdb48rW
 TXD14h7xqEI75GQCstmIm/thKPUroHl+46tqSrH+6jWQChKd1fn1CtOtpEZWL1ErPFyQElZ
 Dr6dMcgm+B5wPutYsRWM+b1SYjyhss3SHPcn3UrcnoOYe0Jt4J7KW5vFlz1RHc0cS/r4UeV
 dgffNTAOq0NNAL24NY0iQ==
UI-OutboundReport: notjunk:1;M01:P0:U6M/anJJmTQ=;7B77d0RO5+zDTjLzu47e44auR6S
 w9ZinduBgCuPyl+C/IddLuCEpBh83T73S8eMfMzSyW1vnHd52kIBaVk0VxfFB4PmHfdeNBRpv
 LTsi16D4m/LWstLlmaUS8l5TETY1aAHbVkmPIfAIDMJkg7NBT4eoK0+rSIeWS0KzO2cLKna3O
 qBUAnYGOnuiyTR1w/VvNUZJRRFdby03UmnHyl9uckQnQZJR3KoEy1LUSSgSC0S45ydKyLsoG2
 2GqMtl8WHwIfBeutU2S5BzYUinoa3k798/13/li5bxse4HM+deRStRiBfudBrBZ96wRx4Ro34
 mNlvVNIEtH57LEPnpn31cr6gDG6qRNB57ZbqGZxIsucTH+R4+Ondr9bp7gV8JOteN18B8kcxq
 1rMogLhgb/zexGFUwKZmIl/mjWFejDiQG2tzdwgH+Dur5J6KIRQ45x7HP3Iw8fxX21qd/4elr
 s9PpPe4IBWFJB2li9FXJGDVVTqdKMTdB/02bdqlCiPEc2VN7nYo3Ml6YIphcgqsYX+3IOc0ZW
 69vKfErV16yUkwcsJflCqRtierGbORGuf9eMi2HI9J8RLdulm9x5Z6ee7UTs7T9MB8OmSmgSJ
 uumcG288xwnVOsZT5nuaRO5BoWQeBYo4GmVeKCRWau0plHVoqqq7gX9K5LUUb3gnNBgVbcLSl
 8ICTBeVUg4S6x1EO1rxy8XxCv254EEVvGj5Hqg/ebDMrawDu1YvOX2177ad5thLeVn/owQWr8
 8UOGZeKhj7CJkC8PMNRii/SqFEor4vxr4SWXKxJWxx05rNMNEvQ6ddpZLOyU6Pv0ZYAt1n752
 9obVd0ovLp8aCvkdCKYjJTZJNPGoYPp4iyMciEXjSelMMADAlgCSy2beuxsWyxarX7DCs1CVA
 j/IU8rt6RbQvniQ==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

When the NetBSD kernel initialises it can leave the ADB interrupt asserted
depending upon where in the ADB poll cycle the MacOS ADB interrupt handler
is when the NetBSD kernel disables interrupts.

The NetBSD ADB driver uses the ADB interrupt state to determine if the ADB
is busy and refuses to send ADB commands unless it is clear. To ensure that
this doesn't happen, always clear the ADB interrupt when switching to A/UX
mode to ensure that the bus enumeration always occurs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-18-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 3c41d6263d45..500ece5872bd 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -875,6 +875,15 @@ static void via1_auxmode_update(MOS6522Q800VIA1State *v1s)
     if (irq != oldirq) {
         trace_via1_auxmode(irq);
         qemu_set_irq(v1s->auxmode_irq, irq);
+
+        /*
+         * Clear the ADB interrupt. MacOS can leave VIA1B_vADBInt asserted
+         * (low) if a poll sequence doesn't complete before NetBSD disables
+         * interrupts upon boot. Fortunately NetBSD switches to the so-called
+         * "A/UX" interrupt mode after it initialises, so we can use this as
+         * a convenient place to clear the ADB interrupt for now.
+         */
+        s->b |= VIA1B_vADBInt;
     }
 }
 
-- 
2.41.0


