Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E906E89BA72
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Apr 2024 10:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkUS-0005n5-Q7; Mon, 08 Apr 2024 04:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkUQ-0005ma-2Z
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:36:30 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkUO-0002lk-8J
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:36:29 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a51d05c50b2so114769866b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712565386; x=1713170186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jCU1df9n+PO9XWHeO5IZQ9CHjWOsBfm5l6WMz/CJRw=;
 b=KoF0npzMTjBFYI+f6oRPuIhCtdI8zn/fLgw8ZBIapnFr3xxWFe3v7vEGOPSzQkERQ6
 sG/6R2fZd9ciKEoSEnD0nPJDw3Sd6ZPpCO/YKPUK5AA2Fb09damLiUuRkUO8/Q0dK2l/
 t+hxRtR5vz3ZDjDeb9tGk1tHFSy1AEglt0gMWZEXWFv9R2igwAS+Z13QveCKc33MNaqB
 qSv0elZ/r6/KFX6hCViiM/fxpQ/E3wm5Jhh1nswqrfH607W0hXxPvO4iKB8pz+mK0kng
 rNQlL+VWrG+OCQ+wEN7g6y/lBuZRnJPY4J8aHpoxJ7qjzS8cBuN3xO/TJcf1KgYVGfb5
 cF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712565386; x=1713170186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jCU1df9n+PO9XWHeO5IZQ9CHjWOsBfm5l6WMz/CJRw=;
 b=lPLXKxnfhn8R2R8t7yYuMUavRzdcoIFls5lrHt8LerVPYZGTCMqopC12bTfIt3I7dC
 KXMDfQ89BBP28+iZ+KkFPdBjq94LRoNcK/BPu5/Tq5qNlxYtZNywiitj4NySLXkn5PAD
 X2kxP+4f+Npbhx3ThIEVDv75DjUURN9ADLhVr6IJkdQVl8kAOGtUDZo6DG5oCjZo7x8v
 X5bf+IDa9E/Vd9cwQoxspQfJ2MyDUJ0TTiaydL6wlxgHclZuo95KlIl3wEYIbDAuJqAt
 PuiNkwdG8lQB54am41ar1o+lxh5uv5I6uX9kINUxtr1XfWWeTlclr436B41EaVHg98Il
 Rr0A==
X-Gm-Message-State: AOJu0Yzlr5YAiKlHd37UPO4LObnZdfJxzphVgia7N/yxnNeCrOasr89k
 pXktbd1+bbqkEC1xWsC+nmLTOVs5qZkPNJhL9WF4yaRZmRxYtsTSOAN738tITigpgxqzT/lkNS7
 O
X-Google-Smtp-Source: AGHT+IH4XEQiPsIzzu/VoKqIKJ0mFQvpmq/rta23HxnxZcCKXDAPA5b2snwrDyuF99PbMQdH14GQoQ==
X-Received: by 2002:a17:907:31c9:b0:a51:ddc6:edc1 with SMTP id
 xf9-20020a17090731c900b00a51ddc6edc1mr711411ejb.28.1712565386203; 
 Mon, 08 Apr 2024 01:36:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 qy47-20020a17090768af00b00a517995c070sm4131041ejc.33.2024.04.08.01.36.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 01:36:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 3/3] hw/block/nand: Fix out-of-bound access in NAND
 block buffer
Date: Mon,  8 Apr 2024 10:36:05 +0200
Message-ID: <20240408083605.55238-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408083605.55238-1-philmd@linaro.org>
References: <20240408083605.55238-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

nand_command() and nand_getio() don't check @offset points
into the block, nor the available data length (s->iolen) is
not negative.

In order to fix:

- check the offset is in range in nand_blk_load_NAND_PAGE_SIZE(),
- do not set @iolen if blk_load() failed.

Reproducer:

  $ cat << EOF | qemu-system-arm -machine tosa \
                                 -monitor none -serial none \
                                 -display none -qtest stdio
  write 0x10000111 0x1 0xca
  write 0x10000104 0x1 0x47
  write 0x1000ca04 0x1 0xd7
  write 0x1000ca01 0x1 0xe0
  write 0x1000ca04 0x1 0x71
  write 0x1000ca00 0x1 0x50
  write 0x1000ca04 0x1 0xd7
  read 0x1000ca02 0x1
  write 0x1000ca01 0x1 0x10
  EOF

=================================================================
==15750==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61f000000de0
 at pc 0x560e61557210 bp 0x7ffcfc4a59f0 sp 0x7ffcfc4a59e8
READ of size 1 at 0x61f000000de0 thread T0
    #0 0x560e6155720f in mem_and hw/block/nand.c:101:20
    #1 0x560e6155ac9c in nand_blk_write_512 hw/block/nand.c:663:9
    #2 0x560e61544200 in nand_command hw/block/nand.c:293:13
    #3 0x560e6153cc83 in nand_setio hw/block/nand.c:520:13
    #4 0x560e61a0a69e in tc6393xb_nand_writeb hw/display/tc6393xb.c:380:13
    #5 0x560e619f9bf7 in tc6393xb_writeb hw/display/tc6393xb.c:524:9
    #6 0x560e647c7d03 in memory_region_write_accessor softmmu/memory.c:492:5
    #7 0x560e647c7641 in access_with_adjusted_size softmmu/memory.c:554:18
    #8 0x560e647c5f66 in memory_region_dispatch_write softmmu/memory.c:1514:16
    #9 0x560e6485409e in flatview_write_continue softmmu/physmem.c:2825:23
    #10 0x560e648421eb in flatview_write softmmu/physmem.c:2867:12
    #11 0x560e64841ca8 in address_space_write softmmu/physmem.c:2963:18
    #12 0x560e61170162 in qemu_writeb tests/qtest/videzzo/videzzo_qemu.c:1080:5
    #13 0x560e6116eef7 in dispatch_mmio_write tests/qtest/videzzo/videzzo_qemu.c:1227:28

0x61f000000de0 is located 0 bytes to the right of 3424-byte region [0x61f000000080,0x61f000000de0)
allocated by thread T0 here:
    #0 0x560e611276cf in malloc /root/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x7f7959a87e98 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e98)
    #2 0x560e64b98871 in object_new qom/object.c:749:12
    #3 0x560e64b5d1a1 in qdev_new hw/core/qdev.c:153:19
    #4 0x560e61547ea5 in nand_init hw/block/nand.c:639:11
    #5 0x560e619f8772 in tc6393xb_init hw/display/tc6393xb.c:558:16
    #6 0x560e6390bad2 in tosa_init hw/arm/tosa.c:250:12

SUMMARY: AddressSanitizer: heap-buffer-overflow hw/block/nand.c:101:20 in mem_and
==15750==ABORTING

Broken since introduction in commit 3e3d5815cb ("NAND Flash memory
emulation and ECC calculation helpers for use by NAND controllers").

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1446
Reported-by: Qiang Liu <cyruscyliu@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/nand.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index 3627c799b5..d90dc965a1 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -255,7 +255,9 @@ static int nand_load_block(NANDFlashState *s, int offset)
 {
     int iolen;
 
-    s->blk_load(s, s->addr, offset);
+    if (!s->blk_load(s, s->addr, offset)) {
+        return 0;
+    }
 
     iolen = (1 << s->page_shift) - offset;
     if (s->gnd) {
@@ -780,6 +782,10 @@ static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
         return false;
     }
 
+    if (offset > NAND_PAGE_SIZE + OOB_SIZE) {
+        return false;
+    }
+
     if (s->blk) {
         if (s->mem_oob) {
             if (blk_pread(s->blk, SECTOR(addr) << BDRV_SECTOR_BITS,
-- 
2.41.0


