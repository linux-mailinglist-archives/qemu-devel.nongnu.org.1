Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B0820AD7
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:41:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsIc-0003cR-6G; Sun, 31 Dec 2023 04:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIO-0003NK-If
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIK-0001PS-RV
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704015582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CAhd/qb1pUqhE3rfgOgceUMVTexusP9ZyBq4WF7EC4Q=;
 b=OaG/OYkVmnEwkeNukGHKodqFqAqP07BqS1d26QSO6m4jVO1WjIyf07AMldSQZRhsJMTlN2
 vDtrBYsjSOdb1ehORCKtvmg/5SNSAH8m2+PlnT+1ZnYvB8M1b1ZJlFjr05Q2131wUTfWAi
 8t2Wu5uVuRVYouDIAou9OLRJs/xjWpo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-syPBKVY6PKGFPvXGE2afDA-1; Sun, 31 Dec 2023 04:39:40 -0500
X-MC-Unique: syPBKVY6PKGFPvXGE2afDA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d86184891so2719885e9.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 01:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704015578; x=1704620378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAhd/qb1pUqhE3rfgOgceUMVTexusP9ZyBq4WF7EC4Q=;
 b=RsRWFPh2gbsD395TAZLyPSE+WQYgQYF3XL5j8ePpaC4SUkQ5Qy7FpxHknTbOXJaRfP
 G2UfafYc+alZ6O7/qh60UwIWkmgr33ywM9GCxOaSBLuwQR8O2foSF+8Tghjyn+YO9aUh
 C8LK04sv+eB6fQEEQKK2+41Hq11HUV6YP+vTcReI2T8ZeMu1SS/f1Ux04QjUA9WtFUfw
 lyXSjQ7VdJa7jRsucf+CAtbJJihmrDnneBjqENafBKG8O4qCzaUmYKnOmKBTbuil/SSS
 ai+F+fTvtRAgUQjzer6D2tbXQ9skTfjpm6qAEhgADo6ajGVKnlVTJHotxFR6sYy5NlIz
 1yNQ==
X-Gm-Message-State: AOJu0YxroxCo+1I7AjL4f9BvZBOB+1jqnfFoW49qRVAeTrwRkw83jrSd
 F29fZBEF6HMgwNRstvih5Zg58DOg9Gxf9Pbro9NzqfyopgJeT6dEGwgTMi7fgTbgwnjQDPIYOF/
 uYsuAO997W3EF3Zi3ypr1rVkzt76wdp+R1QBg61uJovSj08S53ogbPN6CQWG6UJFKKYgDIcbwW3
 RNILCRnBw=
X-Received: by 2002:a05:600c:314c:b0:40d:6f01:c39d with SMTP id
 h12-20020a05600c314c00b0040d6f01c39dmr2494383wmo.186.1704015578524; 
 Sun, 31 Dec 2023 01:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGY/hHQEJlxs7prdCNeDzTH5Ku32v14821jCzoc4w3iY21TODhmLhJK5a/aHDfo0Q6toJtpg==
X-Received: by 2002:a05:600c:314c:b0:40d:6f01:c39d with SMTP id
 h12-20020a05600c314c00b0040d6f01c39dmr2494379wmo.186.1704015578167; 
 Sun, 31 Dec 2023 01:39:38 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b0040b37f1079dsm44531821wmq.29.2023.12.31.01.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 01:39:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 7/8] vga: use latches in odd/even mode too
Date: Sun, 31 Dec 2023 10:39:17 +0100
Message-ID: <20231231093918.239549-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231093918.239549-1-pbonzini@redhat.com>
References: <20231231093918.239549-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

Jazz Jackrabbit uses odd/even mode with 256-color graphics.  This is
probably so that it can do very fast blitting with a decent resolution
(two pixels, compared to four pixels for "regular" mode X).

Accesses still use all planes (reads go to the latches and the game uses
read mode 1 so that the CPU always gets 0xFF; writes use the plane mask
register because the game sets bit 2 of the sequencer's memory mode
register).  For this to work, QEMU needs to use the code for latched
memory accesses in odd/even mode.  The only difference between odd/even
mode and "regular" planar mode is how the plane is computed in read mode
0, and how the planes are masked if the aforementioned bit 2 is reset.

It is almost enough to fix the game.  You also need to honor byte/word
mode selection, which is done in the next patch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 08ba5bb1118..731501cb7af 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -842,15 +842,12 @@ uint32_t vga_mem_readb(VGACommonState *s, hwaddr addr)
     if (s->gr[VGA_GFX_MODE] & 0x10) {
         /* odd/even mode (aka text mode mapping) */
         plane = (s->gr[VGA_GFX_PLANE_READ] & 2) | (addr & 1);
-        addr = ((addr & ~1) << 1) | plane;
-        if (addr >= s->vram_size) {
-            return 0xff;
-        }
-        return s->vram_ptr[addr];
+        addr >>= 1;
+    } else {
+        /* standard VGA latched access */
+        plane = s->gr[VGA_GFX_PLANE_READ];
     }
 
-    /* standard VGA latched access */
-    plane = s->gr[VGA_GFX_PLANE_READ];
     if (addr * sizeof(uint32_t) >= s->vram_size) {
         return 0xff;
     }
@@ -903,11 +900,12 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
         break;
     }
 
+    mask = sr(s, VGA_SEQ_PLANE_WRITE);
     if (sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_CHN_4M) {
         /* chain 4 mode : simplest access */
         plane = addr & 3;
-        mask = (1 << plane);
-        if (sr(s, VGA_SEQ_PLANE_WRITE) & mask) {
+        mask &= (1 << plane);
+        if (mask) {
             assert(addr < s->vram_size);
             s->vram_ptr[addr] = val;
 #ifdef DEBUG_VGA_MEM
@@ -919,26 +917,14 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
         return;
     }
 
-    if (s->gr[VGA_GFX_MODE] & 0x10) {
-        /* odd/even mode (aka text mode mapping) */
-        plane = (s->gr[VGA_GFX_PLANE_READ] & 2) | (addr & 1);
-        mask = (1 << plane);
-        if (sr(s, VGA_SEQ_PLANE_WRITE) & mask) {
-            addr = ((addr & ~1) << 1) | plane;
-            if (addr >= s->vram_size) {
-                return;
-            }
-            s->vram_ptr[addr] = val;
-#ifdef DEBUG_VGA_MEM
-            printf("vga: odd/even: [0x" HWADDR_FMT_plx "]\n", addr);
-#endif
-            s->plane_updated |= mask; /* only used to detect font change */
-            memory_region_set_dirty(&s->vram, addr, 1);
-        }
-        return;
+    if ((sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_SEQ_MODE) == 0) {
+        mask &= (addr & 1) ? 0x0a : 0x05;
     }
 
-    mask = sr(s, VGA_SEQ_PLANE_WRITE);
+    if (s->gr[VGA_GFX_MODE] & 0x10) {
+        /* odd/even mode (aka text mode mapping) */
+        addr >>= 1;
+    }
 
     /* standard VGA latched access */
     write_mode = s->gr[VGA_GFX_MODE] & 3;
-- 
2.43.0


