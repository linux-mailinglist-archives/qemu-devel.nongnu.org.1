Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313937E2595
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:33:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzia-0005hL-IM; Mon, 06 Nov 2023 08:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziY-0005cg-3L
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziW-0003kX-LG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JLXt3y25QXXkvUo2bcTmGhWuiwFD6poKz6ytX9hJb0=;
 b=fcNewoSy8RO3wsDlqEZ/TS7oc1etzNU+KfpK5IutEmzeHmZv7wWo5Vds7To1z7PcWdc9Cj
 0iB+FdIICJQEWRyTK1CyOYkajf0TlyNBT2RQZxNw727f1+T5+kLEMRN9af6fOHGa94lUEN
 1NRD2R9QYXRPsMwc16ZrhEIJbyMzDuk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-54NB0XAYMyeNmi09ornZGw-1; Mon,
 06 Nov 2023 08:32:32 -0500
X-MC-Unique: 54NB0XAYMyeNmi09ornZGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20F462815E25;
 Mon,  6 Nov 2023 13:32:32 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0014F40C6EB9;
 Mon,  6 Nov 2023 13:32:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 02/10] ati-vga: Fix aperture sizes
Date: Mon,  6 Nov 2023 17:32:11 +0400
Message-ID: <20231106133219.2173660-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Apparently these should be half the memory region sizes confirmed at
least by Radeon FCocde ROM while Rage 128 Pro ROMs don't seem to use
these. Linux r100 DRM driver also checks for a bit in HOST_PATH_CNTL
so we also add that even though the FCode ROM does not seem to set it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <d077d4f90d19db731df78da6f05058db074cada1.1698871239.git.balaton@eik.bme.hu>
---
 hw/display/ati_regs.h | 1 +
 hw/display/ati.c      | 7 +++++--
 hw/display/ati_dbg.c  | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d6282b2ef2..c697b328da 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -56,6 +56,7 @@
 #define CONFIG_APER_SIZE                        0x0108
 #define CONFIG_REG_1_BASE                       0x010c
 #define CONFIG_REG_APER_SIZE                    0x0110
+#define HOST_PATH_CNTL                          0x0130
 #define MEM_CNTL                                0x0140
 #define MC_FB_LOCATION                          0x0148
 #define MC_AGP_LOCATION                         0x014C
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 6e38e00502..9a9ea754bd 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -349,14 +349,17 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
         break;
     case CONFIG_APER_SIZE:
-        val = s->vga.vram_size;
+        val = s->vga.vram_size / 2;
         break;
     case CONFIG_REG_1_BASE:
         val = pci_default_read_config(&s->dev,
                                       PCI_BASE_ADDRESS_2, size) & 0xfffffff0;
         break;
     case CONFIG_REG_APER_SIZE:
-        val = memory_region_size(&s->mm);
+        val = memory_region_size(&s->mm) / 2;
+        break;
+    case HOST_PATH_CNTL:
+        val = BIT(23); /* Radeon HDP_APER_CNTL */
         break;
     case MC_STATUS:
         val = 5;
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index bd0ecd48c7..4aec1c383a 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -38,6 +38,7 @@ static struct ati_regdesc ati_reg_names[] = {
     {"CONFIG_APER_SIZE", 0x0108},
     {"CONFIG_REG_1_BASE", 0x010c},
     {"CONFIG_REG_APER_SIZE", 0x0110},
+    {"HOST_PATH_CNTL", 0x0130},
     {"MEM_CNTL", 0x0140},
     {"MC_FB_LOCATION", 0x0148},
     {"MC_AGP_LOCATION", 0x014C},
-- 
2.41.0


