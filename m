Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F28831925
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:27:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRS3-00044Q-5k; Thu, 18 Jan 2024 07:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRm-0003Rl-MG
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRk-00069Y-K9
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iYFJ1omtBZXJlFu5GK/KyeFIiu1spB8a/9O+0pfZj4=;
 b=eb1oba14neaAoCmkO4kmxCvI95ghdfZLQjVFlJhXNl7H17U/FDbpC2Ih+BdVIPIlWPrp3C
 8+hSKt9fdUTGv9nLSw1mkKrEophvReEbEupGvN45j5Gm8DXP6uAeZv39u10MolADtX32VQ
 MhNYIjp/N/MHvSgIGCpCF51EcaErHuM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-FveHs_0CPPi30045ZaAiNA-1; Thu, 18 Jan 2024 07:24:34 -0500
X-MC-Unique: FveHs_0CPPi30045ZaAiNA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2b6c2a5fddso471079466b.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580672; x=1706185472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6iYFJ1omtBZXJlFu5GK/KyeFIiu1spB8a/9O+0pfZj4=;
 b=XjO9g8VOsv0h9H2ZMMfEiPDoPz3ucdJ9U1UdqKxmhUeVwELI6QxnOlumkVvpFYwesg
 d20HyE9ozNJyxQC1yuL8gzau4ERNs1oR9LSmgvEaCP2ROzFcAsPNw/TA0mOZAU4X3ySV
 TJz3DMECP8joDaZIDgTtnZP/DRCzbqoQ5d+VWGCgFDEuEZTzIVp8SieMe3Da78DdTCQU
 V7TUiM6s+ZJRrjbkjESj0KywINj495gFU+nASzrhczlFeVsNn235k0oygBtHqOhBELND
 g3KZ89LdFSsyWZRM3D9ZBBPwGvKp9cG1xHoyuwSbG+gjjvCZZvXJ55M8pcXWcrfEw7mi
 sblA==
X-Gm-Message-State: AOJu0Yzp2968V+v2KBR6NK9Zz4jrxTfqiEeq3uMvWcT+SOarg1CUEh+T
 2vaA993OocMeuBPp5kyAdxKW2hJsE0RkKuXbp72DmvnBKxRXp4d0EBZh7xfJXeFWjV9M//sB8LW
 UaI7U0Gn9rchjKH30i3NQrhhjlHqouvZXKq8hwhaqshPxvAhzLo2b1fMzP8jfPKA9MFe1URycHu
 BP69jEvnAsayOpSszJy61l1jkfgnIwA3kUL3un
X-Received: by 2002:a17:906:c147:b0:a2a:98d:d9ae with SMTP id
 dp7-20020a170906c14700b00a2a098dd9aemr587524ejc.84.1705580671995; 
 Thu, 18 Jan 2024 04:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3/tEtDNX9n/Eq/tbAS6ABeB9CBA8bgDMdwbnvGayArBJq7WPoRRT6MCJYODyabbkzSk99IQ==
X-Received: by 2002:a17:906:c147:b0:a2a:98d:d9ae with SMTP id
 dp7-20020a170906c14700b00a2a098dd9aemr587513ejc.84.1705580671567; 
 Thu, 18 Jan 2024 04:24:31 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 cw1-20020a170907160100b00a2dae4e408bsm5509381ejd.15.2024.01.18.04.24.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] vga: sort-of implement word and double-word access modes
Date: Thu, 18 Jan 2024 13:24:08 +0100
Message-ID: <20240118122416.9209-9-pbonzini@redhat.com>
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

Jazz Jackrabbit has a very unusual VGA setup, where it uses odd/even mode
with 256-color graphics.  Probably, it wants to use fast VRAM-to-VRAM
copies without having to store 4 copies of the sprites as needed in mode
X, one for each mod-4 alignment; odd/even mode simplifies the code a
lot if it's okay to place on a 160-pixels horizontal grid.

At the same time, because it wants to use double buffering (a la "mode X")
it uses byte mode, not word mode as is the case in text modes.  In order
to implement the combination of odd/even mode (plane number comes from
bit 0 of the address) and byte mode (use all bytes of VRAM, whereas word
mode only uses bytes 0, 2, 4,... on each of the four planes), we need
to separate the effect on the plane number from the effect on the address.

Implementing the modes properly is a mess in QEMU, because it would
change the layout of VRAM and break migration.  As an approximation,
shift right when the CPU accesses memory instead of shifting left when
the CRT controller reads it.  A hack is needed in order to write font data
properly (see comment in the code), but it works well enough for the game.

Because doubleword and chain4 modes are now independent, chain4 does not
assert anymore that the address is in range.  Instead it just returns
all ones and discards writes, like other modes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga_regs.h |  4 ++
 hw/display/vga.c      | 89 +++++++++++++++++++++++++++++++------------
 2 files changed, 69 insertions(+), 24 deletions(-)

diff --git a/hw/display/vga_regs.h b/hw/display/vga_regs.h
index 7fdba34b9b1..40e673f164d 100644
--- a/hw/display/vga_regs.h
+++ b/hw/display/vga_regs.h
@@ -100,7 +100,9 @@
 
 /* VGA CRT controller bit masks */
 #define VGA_CR11_LOCK_CR0_CR7   0x80 /* lock writes to CR0 - CR7 */
+#define VGA_CR14_DW             0x40
 #define VGA_CR17_H_V_SIGNALS_ENABLED 0x80
+#define VGA_CR17_WORD_BYTE      0x40
 
 /* VGA attribute controller register indices */
 #define VGA_ATC_PALETTE0        0x00
@@ -154,6 +156,8 @@
 #define VGA_GFX_BIT_MASK        0x08
 
 /* VGA graphics controller bit masks */
+#define VGA_GR05_HOST_ODD_EVEN  0x10
 #define VGA_GR06_GRAPHICS_MODE  0x01
+#define VGA_GR06_CHAIN_ODD_EVEN 0x02
 
 #endif /* HW_VGA_REGS_H */
diff --git a/hw/display/vga.c b/hw/display/vga.c
index d1ef716642f..bc5b83421bf 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -815,25 +815,40 @@ uint32_t vga_mem_readb(VGACommonState *s, hwaddr addr)
     }
 
     if (sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_CHN_4M) {
-        /* chain 4 mode : simplest access (but it should use the same
-         * algorithms as below; see e.g. vga_mem_writeb's plane mask check).
-         */
-        assert(addr < s->vram_size);
-        return s->vram_ptr[addr];
-    }
-
-    if (s->gr[VGA_GFX_MODE] & 0x10) {
+        /* chain4 mode */
+        plane = addr & 3;
+        addr &= ~3;
+    } else if (s->gr[VGA_GFX_MODE] & VGA_GR05_HOST_ODD_EVEN) {
         /* odd/even mode (aka text mode mapping) */
         plane = (s->gr[VGA_GFX_PLANE_READ] & 2) | (addr & 1);
-        addr >>= 1;
     } else {
         /* standard VGA latched access */
         plane = s->gr[VGA_GFX_PLANE_READ];
     }
 
+    if (s->gr[VGA_GFX_MISC] & VGA_GR06_CHAIN_ODD_EVEN) {
+        addr &= ~1;
+    }
+
+    /* Doubleword/word mode.  See comment in vga_mem_writeb */
+    if (s->cr[VGA_CRTC_UNDERLINE] & VGA_CR14_DW) {
+        addr >>= 2;
+    } else if ((s->gr[VGA_GFX_MODE] & VGA_GR05_HOST_ODD_EVEN) &&
+               (s->cr[VGA_CRTC_MODE] & VGA_CR17_WORD_BYTE) == 0) {
+        addr >>= 1;
+    }
+
     if (addr * sizeof(uint32_t) >= s->vram_size) {
         return 0xff;
     }
+
+    if (s->sr[VGA_SEQ_MEMORY_MODE] & VGA_SR04_CHN_4M) {
+        /* chain 4 mode: simplified access (but it should use the same
+         * algorithms as below, see e.g. vga_mem_writeb's plane mask check).
+         */
+        return s->vram_ptr[(addr << 2) | plane];
+    }
+
     s->latch = ((uint32_t *)s->vram_ptr)[addr];
     if (!(s->gr[VGA_GFX_MODE] & 0x08)) {
         /* read mode 0 */
@@ -853,8 +868,9 @@ uint32_t vga_mem_readb(VGACommonState *s, hwaddr addr)
 /* called for accesses between 0xa0000 and 0xc0000 */
 void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
 {
-    int memory_map_mode, plane, write_mode, b, func_select, mask;
+    int memory_map_mode, write_mode, b, func_select, mask;
     uint32_t write_mask, bit_mask, set_mask;
+    int plane = 0;
 
 #ifdef DEBUG_VGA_MEM
     printf("vga: [0x" HWADDR_FMT_plx "] = 0x%02x\n", addr, val);
@@ -888,9 +904,46 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
         /* chain 4 mode : simplest access */
         plane = addr & 3;
         mask &= (1 << plane);
+        addr &= ~3;
+    } else {
+        if ((sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_SEQ_MODE) == 0) {
+            mask &= (addr & 1) ? 0x0a : 0x05;
+        }
+        if (s->gr[VGA_GFX_MISC] & VGA_GR06_CHAIN_ODD_EVEN) {
+            addr &= ~1;
+        }
+    }
+
+    /* Doubleword/word mode.  These should be honored when displaying,
+     * not when reading/writing to memory!  For example, chain4 modes
+     * use double-word mode and, on real hardware, would fetch bytes
+     * 0,1,2,3, 16,17,18,19, 32,33,34,35, etc.  Text modes use word
+     * mode and, on real hardware, would fetch bytes 0,1, 8,9, etc.
+     *
+     * QEMU instead shifted addresses on memory accesses because it
+     * allows more optimizations (e.g. chain4_alias) and simplifies
+     * the draw_line handlers. Unfortunately, there is one case where
+     * the difference shows.  When fetching font data, accesses are
+     * always in consecutive bytes, even if the text/attribute pairs
+     * are done in word mode.  Hence, doing a right shift when operating
+     * on font data is wrong.  So check the odd/even mode bits together with
+     * word mode bit.  The odd/even read bit is 0 when reading font data,
+     * and the odd/even write bit is 1 when writing it.
+     */
+    if (s->cr[VGA_CRTC_UNDERLINE] & VGA_CR14_DW) {
+        addr >>= 2;
+    } else if ((sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_SEQ_MODE) == 0 &&
+               (s->cr[VGA_CRTC_MODE] & VGA_CR17_WORD_BYTE) == 0) {
+        addr >>= 1;
+    }
+
+    if (addr * sizeof(uint32_t) >= s->vram_size) {
+        return;
+    }
+
+    if (sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_CHN_4M) {
         if (mask) {
-            assert(addr < s->vram_size);
-            s->vram_ptr[addr] = val;
+            s->vram_ptr[(addr << 2) | plane] = val;
 #ifdef DEBUG_VGA_MEM
             printf("vga: chain4: [0x" HWADDR_FMT_plx "]\n", addr);
 #endif
@@ -900,15 +953,6 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
         return;
     }
 
-    if ((sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_SEQ_MODE) == 0) {
-        mask &= (addr & 1) ? 0x0a : 0x05;
-    }
-
-    if (s->gr[VGA_GFX_MODE] & 0x10) {
-        /* odd/even mode (aka text mode mapping) */
-        addr >>= 1;
-    }
-
     /* standard VGA latched access */
     write_mode = s->gr[VGA_GFX_MODE] & 3;
     switch(write_mode) {
@@ -973,9 +1017,6 @@ do_write:
     /* mask data according to sr[2] */
     s->plane_updated |= mask; /* only used to detect font change */
     write_mask = mask16[mask];
-    if (addr * sizeof(uint32_t) >= s->vram_size) {
-        return;
-    }
     ((uint32_t *)s->vram_ptr)[addr] =
         (((uint32_t *)s->vram_ptr)[addr] & ~write_mask) |
         (val & write_mask);
-- 
2.43.0


