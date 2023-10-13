Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD27C7F25
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:59:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCzE-0004aS-3k; Fri, 13 Oct 2023 03:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCy2-0001xg-Qr
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxo-0005KB-WE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:18 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32d9cb5e0fcso304885f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183520; x=1697788320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwY+jPg9vgqKQupdoqD0AmL9+Yk7tkyiChWnCwkiopM=;
 b=Nfpqfoy1JoO6rsK+1LMzuTD+Xkz3UaG+bGycwBWpmQotV9MKk8WwQrMP4fCMQ3BByS
 3HMeJgLicqySdK0fXZbf2HGKwp2/8HczoxjBFVhSB7MQqggafvwtRfVar8CXRKW12mIj
 xQKXvtlgx/3IghPkomfgjqUALz+KYwEa2RgagSsIMadl5rjPBGVH+aiaPExuZor52hkz
 1BBDMkzu5uR1L/9aAdz4PfJfL8ZOTZcGcSbkcwgka6a8OaHmQArciGaN+BuIQiHKybcK
 8pvzavZIMsr0Bi7JzLTryWxcZUpH7cOsCHvxcv2db54eBhZLoqUc5mE+ihyUvjAF0bg6
 4L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183520; x=1697788320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwY+jPg9vgqKQupdoqD0AmL9+Yk7tkyiChWnCwkiopM=;
 b=KmMkX493TVTt6VaTupF3VhvJIK41AvZzEFN0suhCu7apUXRcdl2pgaylOSnbP/TTKK
 CG2uTU+JGj/nr9nd8K4bGvjpAFDgLz6d4UJfPjLlrpasdrHPczQq/O7CsjHfpgn/CxGr
 iM6gq8CLtoyL5CixoafPMf8B5UClDGYDjAg0bPGWguaJF5cPttp/xYhYOUxqYRKzaiK5
 E/QOaYCTMNLOBgmFc/zApLuDnU1GUzKcyjKe68PxSITVWCmHeHD2y9PZEdfZOgsKmK3v
 9Q6kBX43/AKGI/Fc64nJ12XGq/QX8pKqKdyDD1bT02Oo+Z1flKVpX6yES+DTJkHC/AZN
 hIjA==
X-Gm-Message-State: AOJu0YwdqwgD0iHLWDBinNRKxotm7vHYKHQjrEO/uCQh/ENFLt3/rYZ/
 ogPihsYbcRK0U58mX89TV1L68Yvn4InNLUt2Wq0=
X-Google-Smtp-Source: AGHT+IEwyFFSNWYQZ2XtYoA1M0Kp6Xn2M4bTeHWxgEB41pfbRP6r2HPsSIRAFsYdhrCWSwDYzxZ0+Q==
X-Received: by 2002:a5d:5b1d:0:b0:32c:f401:997b with SMTP id
 bx29-20020a5d5b1d000000b0032cf401997bmr10083584wrb.50.1697183520094; 
 Fri, 13 Oct 2023 00:52:00 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:59 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH 54/78] hw/core: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:15 +0300
Message-Id: <f385cf09b449507eb3f7ad6ab2d9b57f0f9fe7a8.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

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


