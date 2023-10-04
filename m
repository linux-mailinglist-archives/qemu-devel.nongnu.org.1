Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BD7B7A4F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxOo-0003gq-8Q; Wed, 04 Oct 2023 04:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxOm-0003fN-9q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxOd-0007TS-Ft
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q4mmGHnfiavEqSDdzInQ/yDZyYd5aVbeL7az8KljSZE=; b=QySo1Rgl630IcT1pHswOmbvLE9
 Kc45anPH9i/jQBf7YsVsoNqZBk/X0RnKfiuLOyikIwmoVXN6JFX3gCd2kv8VwxPzNKPC2R2RzB2Kx
 6Pu5Cj+OxBi3yQklrZ2TRGu2wNlHjnd8jEZEiWhN4puUK1QuCAWKFRdUxooTUEfRBf4a5UBiyYRIz
 N5Rkc55aIwUE/E9JnDws0+wjGO1fi3J5SwKJ1MDiKt2BZfAZgIntDDGz/UWXqelUfy4hlaRppVYss
 +yeG8vwJi+WbZP5ubBgjPqFHiUcgJV3Wne6iOKYCy7d3IEnSgtZItcaEv/8zQKpI8MKzww8GQ48+D
 p2h9/VpSITWOM2msWJcAZ7KeEPz7JkqPaHMy7v8X3QnDdyDCqij1vpzxMEJo5xmOaEeLVT8h7RnLm
 TYZbvvqOg5lYZ1677IVNFIVgqW1LA6DPXhEy/PMPx0bBQ7cDVxtVuaLkVFifjASqMqxtuc5vDz/0Q
 LlRoUYSbXsufkjR5nsbzSn/I2K8O08kO0tE8IehmQZrZ48D2mGBiG7/Gu5XpTO3KEmXJP8r2EPANs
 wBkGBG+9e6kqL9jAnETGMv2/DI6RCtTZwMyaJE85D/u8FerKgMCZwwxIhMMNAqNKjkajNvc1CmUUD
 cZJ2QkuECSHuI3g0A0CNqPy4tIJT0Hgttkcb5MYZk=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxON-0006za-MI; Wed, 04 Oct 2023 09:38:08 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:37:47 +0100
Message-Id: <20231004083806.757242-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 01/20] q800-glue.c: convert to Resettable interface
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert the GLUE device to 3-phase reset. The legacy method
doesn't do anything that's invalid in the hold phase, so the
conversion is simple and not a behaviour change.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800-glue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 34c4f0e987..710a5c331e 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -166,9 +166,9 @@ static void glue_nmi_release(void *opaque)
     GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 0);
 }
 
-static void glue_reset(DeviceState *dev)
+static void glue_reset_hold(Object *obj)
 {
-    GLUEState *s = GLUE(dev);
+    GLUEState *s = GLUE(obj);
 
     s->ipr = 0;
     s->auxmode = 0;
@@ -223,11 +223,12 @@ static void glue_init(Object *obj)
 static void glue_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     NMIClass *nc = NMI_CLASS(klass);
 
     dc->vmsd = &vmstate_glue;
-    dc->reset = glue_reset;
     device_class_set_props(dc, glue_properties);
+    rc->phases.hold = glue_reset_hold;
     nc->nmi_monitor_handler = glue_nmi;
 }
 
-- 
2.39.2


