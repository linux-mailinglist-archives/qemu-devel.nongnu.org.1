Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF55824A94
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 23:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLVjc-0001dR-CZ; Thu, 04 Jan 2024 16:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVja-0001d7-Tj
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjZ-0003PU-76
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704405516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFQ9SU6iL9SY2TRWlknBYTXuZ0/vQTXHRHb+w2gtcmI=;
 b=bFJQ8MVFzyAu90hXhfhQA6OSUlXpA/7oiaaFsV1UC0xvqoNWzqNDYsh4NUQzy4YoJ0P94S
 DRpy2cDSCHi2xTXEgg6pSPxniXF+7TJ102ZtTg32s5bsbC/11nVaPe+H7nFgegCKt22b6I
 k/YYtxlv3QFhJVVWsM98he6KBClT81w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-de15viUiNtW1GD-ovrmAPA-1; Thu, 04 Jan 2024 16:58:35 -0500
X-MC-Unique: de15viUiNtW1GD-ovrmAPA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2801b68a97so41489766b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704405513; x=1705010313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFQ9SU6iL9SY2TRWlknBYTXuZ0/vQTXHRHb+w2gtcmI=;
 b=vve/GKRNv33zZnsTpZLtvcOu0eYEt+y56VFJBiT2jLvyMUYkERlr2UK3eynttIBqUA
 0FL+oIDqnv2dDvMmbaTVs7t3RcAQ6Cq5UlDPB4ZJQ1ogS29LKAYFoa0vbie45qyRtrC8
 6TwtX1MRWg6Mnd6whvuMvKwYtU2RF/N846JvJ1Zyl8O3rEBNYMe8Ohqv5jG0dH4Qx72p
 OHT8dPwf9Q0a5ffaYClv3cegMFzGsw5/V0URTzw9BNUcaniGFH4wEUCBz+lN8C3GYCZC
 FSEXqCg4Y/lA3MzqCk+51PDJ6dNuDumPmoZPDcZNEGTAu0yENKttsBMnnSggpgHwuTyr
 Yhhw==
X-Gm-Message-State: AOJu0YytGt+GWUKD12vYlRd1DAK9PGvBVX3x6dcJo6jFvu6AJ8LmYv49
 nbV3HfkI+REmIbMMqyLgkp6KKCIcHkguxBhULEJsQpYGaYLuycYK9hE+eqTG1Rp6SAjNOnWX3Bb
 9JtAYFdE2rzzPmqrO5iFa6Vi1LJHSUIkk6B+H+W2n9XsXkEEBEu942zooDhE+Z3GpQMXvpD1Fe7
 1fArOE1vY=
X-Received: by 2002:a17:906:a08b:b0:a23:46df:f449 with SMTP id
 q11-20020a170906a08b00b00a2346dff449mr567498ejy.55.1704405513212; 
 Thu, 04 Jan 2024 13:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcYD2LyTu1fUXw1uqYQQE/+gHiAi/QX5JPblHU/cGYlnT0OeiknM1IbCupqd7wQN3cpyDRqQ==
X-Received: by 2002:a17:906:a08b:b0:a23:46df:f449 with SMTP id
 q11-20020a170906a08b00b00a2346dff449mr567491ejy.55.1704405512890; 
 Thu, 04 Jan 2024 13:58:32 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a170906609400b00a28badcf367sm113645ejj.54.2024.01.04.13.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:58:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v2 7/8] vga: use latches in odd/even mode too
Date: Thu,  4 Jan 2024 22:58:10 +0100
Message-ID: <20240104215813.156153-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104215813.156153-1-pbonzini@redhat.com>
References: <20240104215813.156153-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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
index 1ec1b5aa29f..2be46cb1255 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -823,15 +823,12 @@ uint32_t vga_mem_readb(VGACommonState *s, hwaddr addr)
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
@@ -884,11 +881,12 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
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
@@ -900,26 +898,14 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
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


