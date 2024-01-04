Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363F824AA2
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 23:00:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLVjd-0001dL-7V; Thu, 04 Jan 2024 16:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjZ-0001cx-Vb
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjY-0003PQ-4g
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704405515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQLcT9KTPjg2f3Hw+CbWFYTnjCtLhdth+T+FsYyXx/o=;
 b=Rrq0xfA9sFYbh00DaECwxEQfjxyZTIfSx9rcMVz+r4vFHwels6vhaO+nPK49KwMe/YADZZ
 AkDTwUqidlJr0Txr7fkEcSNpWH+GbF5nBKuW7LYNHc36sXE3uQMNjji/jDeF4C0A2Ff9DM
 B0ALtmNy4cDgNsLPQ7n2tKg7TUE3nhI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-yJCbwwYVMPWOZ7Sht5LguA-1; Thu, 04 Jan 2024 16:58:32 -0500
X-MC-Unique: yJCbwwYVMPWOZ7Sht5LguA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a28fd256e44so1097666b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704405510; x=1705010310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQLcT9KTPjg2f3Hw+CbWFYTnjCtLhdth+T+FsYyXx/o=;
 b=P4ycmSc7sohN7c1NmUV1EGDtu4ifV+szdYXArUYtD2MMa+rCdDo9zZfbbCs4c2+qvl
 WUrrkjhirKYUJ7hstEty73YV9tvt7beXoW6A2iBMwKOTXkBk89JZPFUZNmdc8ShiU/3i
 gqBw5rvSpDP6mVBqM35xIi6Xe65subOBEvHM/o/sSOFoS5Nje+9804YRYHIRYSY3cquI
 OSkdrNJXvN/J+N4PoxlDyXPpcxL8PR+s4kdFQbnpxysuZc3TDuxkFxMRrCKehBI8qC88
 7js55TcKONyLuTaXzdctYFjuf/JA5q3AfcGl/Vyp4eMrfR0NqvFGlvGslqib41YILBjd
 2GIA==
X-Gm-Message-State: AOJu0YwEpNqRlh72SGdcsyWm8QzTJyBasvdjJU7874w5ZVQnAmsHnQ0O
 4SCuGMMZXOrFy0Ns2TOANKt5kNUlAgD2IE9Wr6tnC0GBricnGxWmcFkep/MHggd3zIw4vUPIQO1
 XFMpU+27Mq1l2e7OcZehM8UyUhEdPuXQM5N3CpVntL3f09IxJcT1LjkcAJw5LuKfQ1cJFg/RC09
 g7Nmucjk4=
X-Received: by 2002:a17:906:8464:b0:a28:dd23:df92 with SMTP id
 hx4-20020a170906846400b00a28dd23df92mr1092389ejc.71.1704405510439; 
 Thu, 04 Jan 2024 13:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHUKayH2o6XBFSFah/dP/x96WDuInGbPSokl1PZ+vbBzJeDb6QimuQub3sx3ksShqQ1nW4Gw==
X-Received: by 2002:a17:906:8464:b0:a28:dd23:df92 with SMTP id
 hx4-20020a170906846400b00a28dd23df92mr1092380ejc.71.1704405510196; 
 Thu, 04 Jan 2024 13:58:30 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 kz9-20020a17090777c900b00a28d1d73654sm106025ejc.207.2024.01.04.13.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:58:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, balaton@eik.bme.hu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] vga: reindent memory access code
Date: Thu,  4 Jan 2024 22:58:09 +0100
Message-ID: <20240104215813.156153-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104215813.156153-1-pbonzini@redhat.com>
References: <20240104215813.156153-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

The next patch will reuse latched memory access in text modes.  Start with
a patch that moves the latched access code out of the "if".

Best reviewed with "git diff -b".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 211 ++++++++++++++++++++++++-----------------------
 1 file changed, 110 insertions(+), 101 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 2c7b8e54805..1ec1b5aa29f 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -813,37 +813,41 @@ uint32_t vga_mem_readb(VGACommonState *s, hwaddr addr)
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
 
@@ -893,7 +897,10 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
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
@@ -909,84 +916,86 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
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


