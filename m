Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C3831915
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:25:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRr-0003U9-D6; Thu, 18 Jan 2024 07:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRi-0003LU-DU
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRf-0005uZ-P9
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+rShe1zzqsjwl4vUlHMrqQonvixWh+vpAlDDZieUAE=;
 b=TtuWOR6xUUKStGHtlaD0VOiIX6cktrCZkto/UqdOaUpvuz9oYfrbhu8DdMww1Z7Su/9Jk8
 DkGciHPpsL9t4Hur8c2TunL21m21QWCLMmz7DfwUkpwgrQZH4RcrTLXpGNOudTj8YEtWnx
 EXZ+tCq9IGbrQZ0kySt7rqAmVTVAcnU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-y1obnYEjOAas01cinbpoqw-1; Thu, 18 Jan 2024 07:24:29 -0500
X-MC-Unique: y1obnYEjOAas01cinbpoqw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2d4d231f77so173903166b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580668; x=1706185468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+rShe1zzqsjwl4vUlHMrqQonvixWh+vpAlDDZieUAE=;
 b=U9gTNdWNhH+oMCE9aWxmF1ta3CkdCS678l3SQaApPPO1tpy76Az6J2CifjHm09h/GY
 LzyuRk6QV/zuCfYwG0gkhUqG21Ykju0T7yo9GsOv/yC86uxRHudUJfpJn6eLVGgD/0tg
 oNWupIrRKOlbWSHB7msrELWzYsG4u3ybc48lfkIVE2Cdd6eRINL5NDFcPlDKF9SV++nu
 6D2sdxWGtu3HV/cQMUWtfVcRlvrr0Rlrn3ZFAD7NqqfDD6byKWBlANv4ROsYOwEMSqk3
 YFa1xnwgxl24aLRoPLLxrp2f5HeaJGs0RvcjyxRNMGK5rRrZPfmPDf/VLhyB7DcT4MMB
 vLcg==
X-Gm-Message-State: AOJu0YwtLyfnSCgB94ZCWJff9uZMU3FtN6ra0zCO0YgmCigU9ZOWhaZg
 e4zd5IeopFqQFEefvKico6t6BU2cp5YtJCegxXl7K3EOgmzmp8Vr4LtpiTEcVdIFBbt7NTfYL2p
 n3J4ppjYDxY77yL9dNFXycdfWwkPMvuy1PubbChDJhcujQzVVoAAd6RIMz0Y0Oiqw5lmyba5Hf2
 RBL7dHMrVftWe1eG2DvhX5aSFfTABg1nFJBeEK
X-Received: by 2002:a17:906:f2da:b0:a27:d1c5:906 with SMTP id
 gz26-20020a170906f2da00b00a27d1c50906mr452923ejb.60.1705580667755; 
 Thu, 18 Jan 2024 04:24:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETBLaeSi7ChbA14wSSDLSgU0Y8P4P1COwhIZFAPrMbqG6m+OS2QdGkkrj1y95iWwjpVRNF1w==
X-Received: by 2002:a17:906:f2da:b0:a27:d1c5:906 with SMTP id
 gz26-20020a170906f2da00b00a27d1c50906mr452919ejb.60.1705580667410; 
 Thu, 18 Jan 2024 04:24:27 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 vk6-20020a170907cbc600b00a2dbc664e2asm5257179ejc.89.2024.01.18.04.24.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] vga: reindent memory access code
Date: Thu, 18 Jan 2024 13:24:06 +0100
Message-ID: <20240118122416.9209-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 211 ++++++++++++++++++++++++-----------------------
 1 file changed, 110 insertions(+), 101 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index a39f802ab7e..f89409f8f2f 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -815,37 +815,41 @@ uint32_t vga_mem_readb(VGACommonState *s, hwaddr addr)
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
 
@@ -895,7 +899,10 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
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
@@ -911,84 +918,86 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
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


