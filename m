Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0471983191C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:26:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRn-0003RU-Fu; Thu, 18 Jan 2024 07:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRj-0003ON-Sq
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRh-00063I-W7
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tswCvkz9OCIPGTjTnPUEmwbWgBnUuSxUc5oQe3+SP2Q=;
 b=gTfgibzWox37ZtAueeBLcECnVaMMbo2L45XT2Lx5JG4SOUD8mDbCYd6bZEDLH27Z5OokK9
 ogonCvIYIy/cTrr1cPT8W2x+CUS0NKYvL+bGhIsmTLpVpJv6kUeSccqLHG8PmxHB0m3zsO
 AJz9/O5CYsqxnVlu3gc22x/mHhIy/vk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-1jNWoqbNNkOuG_yhJIbmFw-1; Thu, 18 Jan 2024 07:24:31 -0500
X-MC-Unique: 1jNWoqbNNkOuG_yhJIbmFw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5591ff1072fso2853424a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580670; x=1706185470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tswCvkz9OCIPGTjTnPUEmwbWgBnUuSxUc5oQe3+SP2Q=;
 b=mxNM28QCG2fqd0zy7r4uKgN55vC+mIxnKgP0ZC6HKvnM2zYU+7CP8x0cT+rWIHdZbb
 cMQq+Zfbii63vmoN3o8+MQL5Spm2i0BfTS7+9ZBMNcyFNiNKfRnfTMF4iFrpPIvhUb4F
 BomlnALhgEiRaSxqW/grw6kETFgcGGoxyXqM60fHx7X24QFW4Z0WcsoCuI8FayEuBPrR
 6NN88pguL+xD+iy93vz9PGoAtnMEkLJOeuP0Xg1eBbp0Wh5NFa5TOTswIejNM4c80Rat
 OnFcZnFs4D6KLWEanxGEc/5rYYjEQf1OQbZMKz9q+AdpY5XUFn0M/atqkoL5zkqhm6cI
 c6aw==
X-Gm-Message-State: AOJu0YxEjg4zfVabfxDdrHBV/UrWWgaH+0oXsbaX1YDwJYafbJWg1RHs
 9pq1IbMxiKiGFiw25k27GfKmt2Gx9kbErNbYyy5nc+9YZ6hvhjD5Mtkg5Nrbq3u2ccHmUqyXIvN
 /g7g5ZQ10lIU925146t8QrevsVBpTpTXxdwjBAo2XZhiAjRMqJ67aQnhCHRLGr+2w/90kSUxWfV
 aHbWNw4cHmlQgB2+wOk9KKR+C932kKi0ynnJ6B
X-Received: by 2002:a17:906:841a:b0:a2f:1d0c:32f6 with SMTP id
 n26-20020a170906841a00b00a2f1d0c32f6mr189329ejx.171.1705580670104; 
 Thu, 18 Jan 2024 04:24:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyJencOmRQiO0L169oxOZ8GiKI96bdJB3OoXpujPkFZmILS6ZHYkooaF7TjiBSuaMcpQliqg==
X-Received: by 2002:a17:906:841a:b0:a2f:1d0c:32f6 with SMTP id
 n26-20020a170906841a00b00a2f1d0c32f6mr189324ejx.171.1705580669706; 
 Thu, 18 Jan 2024 04:24:29 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a170906399000b00a28a66028bcsm9072364eje.91.2024.01.18.04.24.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] vga: use latches in odd/even mode too
Date: Thu, 18 Jan 2024 13:24:07 +0100
Message-ID: <20240118122416.9209-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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
index f89409f8f2f..d1ef716642f 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -825,15 +825,12 @@ uint32_t vga_mem_readb(VGACommonState *s, hwaddr addr)
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
@@ -886,11 +883,12 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
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
@@ -902,26 +900,14 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
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


