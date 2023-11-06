Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF2A7E25B2
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:34:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzid-0005jR-11; Mon, 06 Nov 2023 08:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzib-0005j2-Gz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziZ-0003kh-Sz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5l06+SbSlvQrNpED/nkKOOn53nxrTicxHGor4Ux3drg=;
 b=Mun8fsfeDlvOIJL4imgBaeV0xTsvU9sG6iwH+1nbqJmxu45UJGFyeMmaQ6NMoUPZ63Fzaz
 jsxOoAOYnjSfyl8hUFH6qavCRbrJFvijmvwvt5fJt0dh1s5UKbqi0s6cizfmnfBkQ/5gXm
 h/p/ZBEhRBbK/YmLaX7LclK9PEagUZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-c8D875A2NbiQvtNOZrx6jQ-1; Mon, 06 Nov 2023 08:32:36 -0500
X-MC-Unique: c8D875A2NbiQvtNOZrx6jQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 287C889C662;
 Mon,  6 Nov 2023 13:32:36 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D8BD2026D66;
 Mon,  6 Nov 2023 13:32:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 03/10] ati-vga: Support unaligned access to GPIO DDC registers
Date: Mon,  6 Nov 2023 17:32:12 +0400
Message-ID: <20231106133219.2173660-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The GPIO_VGA_DDC and GPIO_DVI_DDC registers are used on Radeon for DDC
access. Some drivers like the PPC Mac FCode ROM uses unaligned writes
to these registers so implement this the same way as already done for
GPIO_MONID which is used the same way for the Rage 128 Pro.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <dff6ce16ccabdfd54ffda348bf57c6d8b810cd98.1698871239.git.balaton@eik.bme.hu>
---
 hw/display/ati.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 9a9ea754bd..538651c233 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -319,11 +319,13 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DAC_CNTL:
         val = s->regs.dac_cntl;
         break;
-    case GPIO_VGA_DDC:
-        val = s->regs.gpio_vga_ddc;
+    case GPIO_VGA_DDC ... GPIO_VGA_DDC + 3:
+        val = ati_reg_read_offs(s->regs.gpio_vga_ddc,
+                                addr - GPIO_VGA_DDC, size);
         break;
-    case GPIO_DVI_DDC:
-        val = s->regs.gpio_dvi_ddc;
+    case GPIO_DVI_DDC ... GPIO_DVI_DDC + 3:
+        val = ati_reg_read_offs(s->regs.gpio_dvi_ddc,
+                                addr - GPIO_DVI_DDC, size);
         break;
     case GPIO_MONID ... GPIO_MONID + 3:
         val = ati_reg_read_offs(s->regs.gpio_monid,
@@ -615,29 +617,34 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dac_cntl = data & 0xffffe3ff;
         s->vga.dac_8bit = !!(data & DAC_8BIT_EN);
         break;
-    case GPIO_VGA_DDC:
+    /*
+     * GPIO regs for DDC access. Because some drivers access these via
+     * multiple byte writes we have to be careful when we send bits to
+     * avoid spurious changes in bitbang_i2c state. Only do it when either
+     * the enable bits are changed or output bits changed while enabled.
+     */
+    case GPIO_VGA_DDC ... GPIO_VGA_DDC + 3:
         if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
             /* FIXME: Maybe add a property to select VGA or DVI port? */
         }
         break;
-    case GPIO_DVI_DDC:
+    case GPIO_DVI_DDC ... GPIO_DVI_DDC + 3:
         if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.gpio_dvi_ddc = ati_i2c(&s->bbi2c, data, 0);
+            ati_reg_write_offs(&s->regs.gpio_dvi_ddc,
+                               addr - GPIO_DVI_DDC, data, size);
+            if ((addr <= GPIO_DVI_DDC + 2 && addr + size > GPIO_DVI_DDC + 2) ||
+                (addr == GPIO_DVI_DDC && (s->regs.gpio_dvi_ddc & 0x30000))) {
+                s->regs.gpio_dvi_ddc = ati_i2c(&s->bbi2c,
+                                               s->regs.gpio_dvi_ddc, 0);
+            }
         }
         break;
     case GPIO_MONID ... GPIO_MONID + 3:
         /* FIXME What does Radeon have here? */
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            /* Rage128p accesses DDC via MONID(1-2) with additional mask bit */
             ati_reg_write_offs(&s->regs.gpio_monid,
                                addr - GPIO_MONID, data, size);
-            /*
-             * Rage128p accesses DDC used to get EDID via these bits.
-             * Because some drivers access this via multiple byte writes
-             * we have to be careful when we send bits to avoid spurious
-             * changes in bitbang_i2c state. So only do it when mask is set
-             * and either the enable bits are changed or output bits changed
-             * while enabled.
-             */
             if ((s->regs.gpio_monid & BIT(25)) &&
                 ((addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) ||
                  (addr == GPIO_MONID && (s->regs.gpio_monid & 0x60000)))) {
-- 
2.41.0


