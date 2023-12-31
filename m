Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03E820AD3
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:40:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsId-0003dt-2D; Sun, 31 Dec 2023 04:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIO-0003N5-Hl
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIK-0001PJ-R8
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704015580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1Clt86qsanfkl/RbaWDlF4YfS1X9zhqhbxAVnCe+VA=;
 b=UBDHNi0lOxkrnMfJn0j9QBqLkrf0GuzZt6/XDhxPZBvCY7Ma0kbGPZ8fCN4CACIFe+CEZt
 9RfG9a+sJ8Dw48hXeLtHLyhCNFm4/tITBqzAxr7lIswBoGIB1oSaKp08kXQ/O5JaF8PAjx
 geyYbYqi/2WmDoFznHEUXOBeiLi/aY0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-c3mOKjm9MRO5thSHKTi9yA-1; Sun, 31 Dec 2023 04:39:38 -0500
X-MC-Unique: c3mOKjm9MRO5thSHKTi9yA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33677bbd570so5943695f8f.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 01:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704015576; x=1704620376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1Clt86qsanfkl/RbaWDlF4YfS1X9zhqhbxAVnCe+VA=;
 b=jX3D34lymPb1eVqXGYc8gjc2RpK/7molw8sdzZjze3mxcNXfNEEzgacQyg0jBYWsF5
 JyJS+64tkTeON8huokf8DYWWuRUuiTVIpxbYnIw/eeXxwweJNiZ1nQH1aGMzRcfPSW0J
 jPyIXFmwkt/hXvQUmT1Monh7IVh0w7KOihlP1nkuB+yJ8e+xlVz4u+xnAeP/WNXvrp8m
 FNSSwbLR2ICudLUT9Ll4w6+4aX6SFdNHWxAqmC7JDK0hZVDCHKrwxh2JeExOChbGQfH6
 2vvu3DDtD1kuS9cemYutTfGBVy1/+6kPtokGtYVInPuGjpBxXJGGshWPatNMUqA3hIcV
 Tzzg==
X-Gm-Message-State: AOJu0Yx7s6/VAAOKaceCK0W1fIrTIFKdfyg8CVAvnBEIFgOQ1V1E0emR
 lU2prlA3ode1/kVfRLza2QBTrtUaoJR1MhMxx4WChS88dPQ41CFAd104JCTP8exT8hghJYnQL0A
 Bibr7m/u6FMh1ZDcoragEWcB3NeL0D2jtc75X/5vCHUYgH5rN9UL0q34+WbDOHlDto1CkQQUlmY
 y4KFhJE7k=
X-Received: by 2002:a5d:5692:0:b0:336:67e9:ebe8 with SMTP id
 f18-20020a5d5692000000b0033667e9ebe8mr9281570wrv.90.1704015576581; 
 Sun, 31 Dec 2023 01:39:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2tFK7sUyg7wDGvXjjyi8geMiVbKY9vNMa6uu9CtDl9wZwS9RPXWNPemtQUJjKnvlCqPSEpg==
X-Received: by 2002:a5d:5692:0:b0:336:67e9:ebe8 with SMTP id
 f18-20020a5d5692000000b0033667e9ebe8mr9281565wrv.90.1704015576333; 
 Sun, 31 Dec 2023 01:39:36 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adffbd1000000b0033719111458sm6494110wrs.36.2023.12.31.01.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 01:39:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 6/8] vga: reindent memory access code
Date: Sun, 31 Dec 2023 10:39:16 +0100
Message-ID: <20231231093918.239549-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231093918.239549-1-pbonzini@redhat.com>
References: <20231231093918.239549-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

The next patch will reuse latched memory access in text modes.  Start with
a patch that moves the latched access code out of the "if".

Best reviewed with "git diff -b".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 211 ++++++++++++++++++++++++-----------------------
 1 file changed, 110 insertions(+), 101 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 2467f3f6c65..08ba5bb1118 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -832,37 +832,41 @@ uint32_t vga_mem_readb(VGACommonState *s, hwaddr addr)
     }
 
     if (sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_CHN_4M) {
-        /* chain 4 mode : simplest access */
+        /* chain 4 mode : simplest access (but it should use the same
+         * algorithms as below; see e.g. vga_mem_writeb's plane mask check).
+         */
         assert(addr < s->vram_size);
-        ret = s->vram_ptr[addr];
-    } else if (s->gr[VGA_GFX_MODE] & 0x10) {
+        return s->vram_ptr[addr];
+    }
+
+    if (s->gr[VGA_GFX_MODE] & 0x10) {
         /* odd/even mode (aka text mode mapping) */
         plane = (s->gr[VGA_GFX_PLANE_READ] & 2) | (addr & 1);
         addr = ((addr & ~1) << 1) | plane;
         if (addr >= s->vram_size) {
             return 0xff;
         }
-        ret = s->vram_ptr[addr];
-    } else {
-        /* standard VGA latched access */
-        if (addr * sizeof(uint32_t) >= s->vram_size) {
-            return 0xff;
-        }
-        s->latch = ((uint32_t *)s->vram_ptr)[addr];
-
-        if (!(s->gr[VGA_GFX_MODE] & 0x08)) {
-            /* read mode 0 */
-            plane = s->gr[VGA_GFX_PLANE_READ];
-            ret = GET_PLANE(s->latch, plane);
-        } else {
-            /* read mode 1 */
-            ret = (s->latch ^ mask16[s->gr[VGA_GFX_COMPARE_VALUE]]) &
-                mask16[s->gr[VGA_GFX_COMPARE_MASK]];
-            ret |= ret >> 16;
-            ret |= ret >> 8;
-            ret = (~ret) & 0xff;
-        }
+        return s->vram_ptr[addr];
     }
+
+    /* standard VGA latched access */
+    plane = s->gr[VGA_GFX_PLANE_READ];
+    if (addr * sizeof(uint32_t) >= s->vram_size) {
+        return 0xff;
+    }
+    s->latch = ((uint32_t *)s->vram_ptr)[addr];
+    if (!(s->gr[VGA_GFX_MODE] & 0x08)) {
+        /* read mode 0 */
+        ret = GET_PLANE(s->latch, plane);
+    } else {
+        /* read mode 1 */
+        ret = (s->latch ^ mask16[s->gr[VGA_GFX_COMPARE_VALUE]]) &
+            mask16[s->gr[VGA_GFX_COMPARE_MASK]];
+        ret |= ret >> 16;
+        ret |= ret >> 8;
+        ret = (~ret) & 0xff;
+    }
+
     return ret;
 }
 
@@ -912,7 +916,10 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
             s->plane_updated |= mask; /* only used to detect font change */
             memory_region_set_dirty(&s->vram, addr, 1);
         }
-    } else if (s->gr[VGA_GFX_MODE] & 0x10) {
+        return;
+    }
+
+    if (s->gr[VGA_GFX_MODE] & 0x10) {
         /* odd/even mode (aka text mode mapping) */
         plane = (s->gr[VGA_GFX_PLANE_READ] & 2) | (addr & 1);
         mask = (1 << plane);
@@ -928,84 +935,86 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
             s->plane_updated |= mask; /* only used to detect font change */
             memory_region_set_dirty(&s->vram, addr, 1);
         }
-    } else {
-        /* standard VGA latched access */
-        write_mode = s->gr[VGA_GFX_MODE] & 3;
-        switch(write_mode) {
-        default:
-        case 0:
-            /* rotate */
-            b = s->gr[VGA_GFX_DATA_ROTATE] & 7;
-            val = ((val >> b) | (val << (8 - b))) & 0xff;
-            val |= val << 8;
-            val |= val << 16;
-
-            /* apply set/reset mask */
-            set_mask = mask16[s->gr[VGA_GFX_SR_ENABLE]];
-            val = (val & ~set_mask) |
-                (mask16[s->gr[VGA_GFX_SR_VALUE]] & set_mask);
-            bit_mask = s->gr[VGA_GFX_BIT_MASK];
-            break;
-        case 1:
-            val = s->latch;
-            goto do_write;
-        case 2:
-            val = mask16[val & 0x0f];
-            bit_mask = s->gr[VGA_GFX_BIT_MASK];
-            break;
-        case 3:
-            /* rotate */
-            b = s->gr[VGA_GFX_DATA_ROTATE] & 7;
-            val = (val >> b) | (val << (8 - b));
-
-            bit_mask = s->gr[VGA_GFX_BIT_MASK] & val;
-            val = mask16[s->gr[VGA_GFX_SR_VALUE]];
-            break;
-        }
-
-        /* apply logical operation */
-        func_select = s->gr[VGA_GFX_DATA_ROTATE] >> 3;
-        switch(func_select) {
-        case 0:
-        default:
-            /* nothing to do */
-            break;
-        case 1:
-            /* and */
-            val &= s->latch;
-            break;
-        case 2:
-            /* or */
-            val |= s->latch;
-            break;
-        case 3:
-            /* xor */
-            val ^= s->latch;
-            break;
-        }
-
-        /* apply bit mask */
-        bit_mask |= bit_mask << 8;
-        bit_mask |= bit_mask << 16;
-        val = (val & bit_mask) | (s->latch & ~bit_mask);
-
-    do_write:
-        /* mask data according to sr[2] */
-        mask = sr(s, VGA_SEQ_PLANE_WRITE);
-        s->plane_updated |= mask; /* only used to detect font change */
-        write_mask = mask16[mask];
-        if (addr * sizeof(uint32_t) >= s->vram_size) {
-            return;
-        }
-        ((uint32_t *)s->vram_ptr)[addr] =
-            (((uint32_t *)s->vram_ptr)[addr] & ~write_mask) |
-            (val & write_mask);
-#ifdef DEBUG_VGA_MEM
-        printf("vga: latch: [0x" HWADDR_FMT_plx "] mask=0x%08x val=0x%08x\n",
-               addr * 4, write_mask, val);
-#endif
-        memory_region_set_dirty(&s->vram, addr << 2, sizeof(uint32_t));
+        return;
     }
+
+    mask = sr(s, VGA_SEQ_PLANE_WRITE);
+
+    /* standard VGA latched access */
+    write_mode = s->gr[VGA_GFX_MODE] & 3;
+    switch(write_mode) {
+    default:
+    case 0:
+        /* rotate */
+        b = s->gr[VGA_GFX_DATA_ROTATE] & 7;
+        val = ((val >> b) | (val << (8 - b))) & 0xff;
+        val |= val << 8;
+        val |= val << 16;
+
+        /* apply set/reset mask */
+        set_mask = mask16[s->gr[VGA_GFX_SR_ENABLE]];
+        val = (val & ~set_mask) |
+            (mask16[s->gr[VGA_GFX_SR_VALUE]] & set_mask);
+        bit_mask = s->gr[VGA_GFX_BIT_MASK];
+        break;
+    case 1:
+        val = s->latch;
+        goto do_write;
+    case 2:
+        val = mask16[val & 0x0f];
+        bit_mask = s->gr[VGA_GFX_BIT_MASK];
+        break;
+    case 3:
+        /* rotate */
+        b = s->gr[VGA_GFX_DATA_ROTATE] & 7;
+        val = (val >> b) | (val << (8 - b));
+
+        bit_mask = s->gr[VGA_GFX_BIT_MASK] & val;
+        val = mask16[s->gr[VGA_GFX_SR_VALUE]];
+        break;
+    }
+
+    /* apply logical operation */
+    func_select = s->gr[VGA_GFX_DATA_ROTATE] >> 3;
+    switch(func_select) {
+    case 0:
+    default:
+        /* nothing to do */
+        break;
+    case 1:
+        /* and */
+        val &= s->latch;
+        break;
+    case 2:
+        /* or */
+        val |= s->latch;
+        break;
+    case 3:
+        /* xor */
+        val ^= s->latch;
+        break;
+    }
+
+    /* apply bit mask */
+    bit_mask |= bit_mask << 8;
+    bit_mask |= bit_mask << 16;
+    val = (val & bit_mask) | (s->latch & ~bit_mask);
+
+do_write:
+    /* mask data according to sr[2] */
+    s->plane_updated |= mask; /* only used to detect font change */
+    write_mask = mask16[mask];
+    if (addr * sizeof(uint32_t) >= s->vram_size) {
+        return;
+    }
+    ((uint32_t *)s->vram_ptr)[addr] =
+        (((uint32_t *)s->vram_ptr)[addr] & ~write_mask) |
+        (val & write_mask);
+#ifdef DEBUG_VGA_MEM
+    printf("vga: latch: [0x" HWADDR_FMT_plx "] mask=0x%08x val=0x%08x\n",
+           addr * 4, write_mask, val);
+#endif
+    memory_region_set_dirty(&s->vram, addr << 2, sizeof(uint32_t));
 }
 
 typedef void *vga_draw_line_func(VGACommonState *s1, uint8_t *d,
-- 
2.43.0


