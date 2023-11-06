Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636C7E2596
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:33:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzii-0005lT-2I; Mon, 06 Nov 2023 08:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzig-0005ka-BG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzie-0003ky-NT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wrw1TLwcieyZj3PYYiGWOE6P3VGmBO15YjosPs/JHdI=;
 b=HxylOwhrk/IlPBEizu4EardlcBYh47Zwc6eC7RdhUv5kpEWu4qmb6IX2+8+LvVJJOnMH+d
 8GlKvNeMlWcVCuaVQkmZ6aTSQElnKmWMWpMdYeExjyEq1Rwg5mR7NAGaGwCSXlIoYxGQXP
 AA03cWb4Re+re/4vQozEKu+R/PSAAxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-YBxKm97oNOO2gF-rS6tcfg-1; Mon, 06 Nov 2023 08:32:40 -0500
X-MC-Unique: YBxKm97oNOO2gF-rS6tcfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53450185A78F;
 Mon,  6 Nov 2023 13:32:40 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79B83502B;
 Mon,  6 Nov 2023 13:32:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 04/10] ati-vga: Add 30 bit palette access register
Date: Mon,  6 Nov 2023 17:32:13 +0400
Message-ID: <20231106133219.2173660-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Radeon cards have a 30 bit DAC and corresponding palette register to
access it. We only use 8 bits but let the guests use 10 bit color
values for those that access it through this register.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <9fa19eec95d1563cc65853cf26912f230c702b32.1698871239.git.balaton@eik.bme.hu>
---
 hw/display/ati_int.h  | 1 +
 hw/display/ati_regs.h | 1 +
 hw/display/ati.c      | 9 +++++++++
 hw/display/ati_dbg.c  | 1 +
 4 files changed, 12 insertions(+)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index e8d3c7af75..8abb873f01 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -44,6 +44,7 @@ typedef struct ATIVGARegs {
     uint32_t gpio_dvi_ddc;
     uint32_t gpio_monid;
     uint32_t config_cntl;
+    uint32_t palette[256];
     uint32_t crtc_h_total_disp;
     uint32_t crtc_h_sync_strt_wid;
     uint32_t crtc_v_total_disp;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index c697b328da..d7127748ff 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -48,6 +48,7 @@
 #define AMCGPIO_EN_MIR                          0x00a8
 #define PALETTE_INDEX                           0x00b0
 #define PALETTE_DATA                            0x00b4
+#define PALETTE_30_DATA                         0x00b8
 #define CNFG_CNTL                               0x00e0
 #define GEN_RESET_CNTL                          0x00f0
 #define CNFG_MEMSIZE                            0x00f8
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 538651c233..4868f95cf2 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -339,6 +339,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case PALETTE_DATA:
         val = vga_ioport_read(&s->vga, VGA_PEL_D);
         break;
+    case PALETTE_30_DATA:
+        val = s->regs.palette[vga_ioport_read(&s->vga, VGA_PEL_IR)];
+        break;
     case CNFG_CNTL:
         val = s->regs.config_cntl;
         break;
@@ -673,6 +676,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         data >>= 8;
         vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
         break;
+    case PALETTE_30_DATA:
+        s->regs.palette[vga_ioport_read(&s->vga, VGA_PEL_IW)] = data;
+        vga_ioport_write(&s->vga, VGA_PEL_D, (data >> 22) & 0xff);
+        vga_ioport_write(&s->vga, VGA_PEL_D, (data >> 12) & 0xff);
+        vga_ioport_write(&s->vga, VGA_PEL_D, (data >> 2) & 0xff);
+        break;
     case CNFG_CNTL:
         s->regs.config_cntl = data;
         break;
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 4aec1c383a..3ffa7f35df 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -30,6 +30,7 @@ static struct ati_regdesc ati_reg_names[] = {
     {"AMCGPIO_EN_MIR", 0x00a8},
     {"PALETTE_INDEX", 0x00b0},
     {"PALETTE_DATA", 0x00b4},
+    {"PALETTE_30_DATA", 0x00b8},
     {"CNFG_CNTL", 0x00e0},
     {"GEN_RESET_CNTL", 0x00f0},
     {"CNFG_MEMSIZE", 0x00f8},
-- 
2.41.0


