Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 544647C7FD2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:17:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCzI-00054m-UN; Fri, 13 Oct 2023 03:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCy6-00023K-UY
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxp-0005JN-O2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-323168869daso1723779f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183517; x=1697788317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKaenaxhvcb/0zcBEd882Zbx2bYRZ9oXgXyx2zzOlKY=;
 b=MuugSJy3rmtUbyBUktxXHRr3LkpBMBH9JtjHAfs8nLCfZ4/IRzbXSTkepTucBYWfIx
 +5NBUgmVY9V1KWCFcHC32z4+mKybBmJfH0v9vuLrMK0xmjbPrN7UJx+l5YFYaXN6sBxS
 4EXSfJBRJf0P0KqRQudG/zYhlsadOWQWcW4WSWyVhEKT54oCDGYFLANsLYMS6ys5v0Rk
 xm1xElFlgxIqh0mrU9w0vq+XcKbNlvK9VPoQz5OgS7/XbaTw3GjkzedlKBfrIv6A/vZk
 euetoooHZPJeHRlvyi8EMFQZQImHSadg8V1g3xY6F62ldgnOH8fRlsMx3lMT/MJYJZQO
 1jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183517; x=1697788317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKaenaxhvcb/0zcBEd882Zbx2bYRZ9oXgXyx2zzOlKY=;
 b=Rvz67fuuZRoEha5Y6Z/BobqAk9lIdMHErA8Xhpl1HRwSIuN+O9d+v/N1zm4XB1ytw/
 xOaDRDahgF8fpZlRpH5rAuDVwrSVi4bgcAqZOpren7k6IroRDHxnxHTXK89/HIZ8W8kH
 2U7acbLvc2zBYfwu4qsiyiu5XF7muwviXgwOfppptVA1BLRSlZolQ5EzMwNCkp3rsZMz
 RcI13VYnj35Qfm/SiCTD4S9nbEg4g9k5zF/O/VJVOEodZx6m8aCTzvNCv8K3UlRkL54B
 aUSUO+bWVNezc9Ow3u98Bn1UqvutF5pc+9cLsMU0ITydcYpeVXvVWPJWe++FoS/HVOQY
 5cHw==
X-Gm-Message-State: AOJu0Yxw7VVSxfTjobfl3z7+lFrwAQfb7Kh0SglIyon/RqTh22TJC6ME
 KOLA3I0TS7iZNnXz2Ee4aLvgoSII/IG5742b8YA=
X-Google-Smtp-Source: AGHT+IHj6Q0fd2+9sD2xWGQCNj1nLPEXmK83YM8WK0MgH/k6ANJ7jQrcYGbND/UC7J7jvSYEwU1UMw==
X-Received: by 2002:adf:fc0e:0:b0:32d:90f7:ce46 with SMTP id
 i14-20020adffc0e000000b0032d90f7ce46mr3284697wrr.16.1697183516939; 
 Fri, 13 Oct 2023 00:51:56 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:56 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH 53/75] hw/core: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:13 +0300
Message-Id: <2b1f19fcb93c79a455e09985d68d5f6b122e3b65.1697034504.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/core/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4dd5a71fb7..559d63a1e2 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -625,138 +625,138 @@ toosmall:
 /* Load a U-Boot image.  */
 static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
                                 hwaddr *loadaddr, int *is_linux,
                                 uint8_t image_type,
                                 uint64_t (*translate_fn)(void *, uint64_t),
                                 void *translate_opaque, AddressSpace *as)
 {
     int fd;
     ssize_t size;
     hwaddr address;
     uboot_image_header_t h;
     uboot_image_header_t *hdr = &h;
     uint8_t *data = NULL;
     int ret = -1;
     int do_uncompress = 0;
 
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0)
         return -1;
 
     size = read(fd, hdr, sizeof(uboot_image_header_t));
     if (size < sizeof(uboot_image_header_t)) {
         goto out;
     }
 
     bswap_uboot_header(hdr);
 
     if (hdr->ih_magic != IH_MAGIC)
         goto out;
 
     if (hdr->ih_type != image_type) {
         if (!(image_type == IH_TYPE_KERNEL &&
             hdr->ih_type == IH_TYPE_KERNEL_NOLOAD)) {
             fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
                     image_type);
             goto out;
         }
     }
 
     /* TODO: Implement other image types.  */
     switch (hdr->ih_type) {
     case IH_TYPE_KERNEL_NOLOAD:
         if (!loadaddr || *loadaddr == LOAD_UIMAGE_LOADADDR_INVALID) {
             fprintf(stderr, "this image format (kernel_noload) cannot be "
                     "loaded on this machine type");
             goto out;
         }
 
         hdr->ih_load = *loadaddr + sizeof(*hdr);
         hdr->ih_ep += hdr->ih_load;
-        /* fall through */
+        fallthrough;
     case IH_TYPE_KERNEL:
         address = hdr->ih_load;
         if (translate_fn) {
             address = translate_fn(translate_opaque, address);
         }
         if (loadaddr) {
             *loadaddr = hdr->ih_load;
         }
 
         switch (hdr->ih_comp) {
         case IH_COMP_NONE:
             break;
         case IH_COMP_GZIP:
             do_uncompress = 1;
             break;
         default:
             fprintf(stderr,
                     "Unable to load u-boot images with compression type %d\n",
                     hdr->ih_comp);
             goto out;
         }
 
         if (ep) {
             *ep = hdr->ih_ep;
         }
 
         /* TODO: Check CPU type.  */
         if (is_linux) {
             if (hdr->ih_os == IH_OS_LINUX) {
                 *is_linux = 1;
             } else if (hdr->ih_os == IH_OS_VXWORKS) {
                 /*
                  * VxWorks 7 uses the same boot interface as the Linux kernel
                  * on Arm (64-bit only), PowerPC and RISC-V architectures.
                  */
                 switch (hdr->ih_arch) {
                 case IH_ARCH_ARM64:
                 case IH_ARCH_PPC:
                 case IH_ARCH_RISCV:
                     *is_linux = 1;
                     break;
                 default:
                     *is_linux = 0;
                     break;
                 }
             } else {
                 *is_linux = 0;
             }
         }
 
         break;
     case IH_TYPE_RAMDISK:
         address = *loadaddr;
         break;
     default:
         fprintf(stderr, "Unsupported u-boot image type %d\n", hdr->ih_type);
         goto out;
     }
 
     data = g_malloc(hdr->ih_size);
 
     if (read(fd, data, hdr->ih_size) != hdr->ih_size) {
         fprintf(stderr, "Error reading file\n");
         goto out;
     }
 
     if (do_uncompress) {
         uint8_t *compressed_data;
         size_t max_bytes;
         ssize_t bytes;
 
         compressed_data = data;
         max_bytes = UBOOT_MAX_GUNZIP_BYTES;
         data = g_malloc(max_bytes);
 
         bytes = gunzip(data, max_bytes, compressed_data, hdr->ih_size);
         g_free(compressed_data);
         if (bytes < 0) {
             fprintf(stderr, "Unable to decompress gzipped image!\n");
             goto out;
         }
         hdr->ih_size = bytes;
     }
 
     rom_add_blob_fixed_as(filename, data, hdr->ih_size, address, as);
 
     ret = hdr->ih_size;
-- 
2.39.2


