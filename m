Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCABA7C7FFF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:22:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD56-0005ML-V1; Fri, 13 Oct 2023 03:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD53-000565-Om
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4z-0007DK-To
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so18747905e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183968; x=1697788768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwY+jPg9vgqKQupdoqD0AmL9+Yk7tkyiChWnCwkiopM=;
 b=p9UNFUW5OsibYfWfGVI8Ed3AEZ3qrcv640gHYZ3Gs90HI4VKv7ytwM8tEj9AFrMBF3
 QceUC6O4boTlAqQuHi4J+Go38ln4NNqiaP7y2SzYR93JAqpnn+f/49UzIXhdfs2YX0FX
 OcNa6OKpbg+0pwXzdbZlZSPaS2H7iQdRtZ5+oCKCMActOKAWC+pe9fzp4TTo2Sho34Tp
 /xkUCtYBe6N9IIgYfOS3a+zBOl/uXmSlb9N+5RGZsiV0irTS+rEcokIXUtKge5A1Q4e8
 if7oBSbXWeBPgoYsoBY9GAxe8vsoRV9CYpufBgq2m6V6sIf4wuOu1Dz91mk+n9KRyeCq
 K44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183968; x=1697788768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwY+jPg9vgqKQupdoqD0AmL9+Yk7tkyiChWnCwkiopM=;
 b=E6lFdG0wc0h3HFlaPHU+ip7gjh1fmA1oAJ8ZcjQEKGVvVKO9JEk3R33Ii6EXqIxFIM
 GFNX4W/otiFCsTH2v811tppS0o3H8tB+3Dar6SStgcPMgI2kBy4ycXhbv9Eb81KDeoua
 7HeNx4OhsEAnY5IsyzTj5dMf+usKP/fn9ewV/Tddfd6/zAARCz645cL0sJ07D4AMUyjI
 W7nz/hjVtV6zAiaI6FEi+tUlXAFWpwtXFfUMm+JTm421zYD6dC8KZEEupi1zIhcXkqG/
 C3kNo0nRe1epYxNmZNvbL1vsGUeeUsxLWMl5fSgp5XDo0gp0nFvLgoB79hwsn037P4WY
 kT+g==
X-Gm-Message-State: AOJu0YzbJoXM1vIoPQsO+oYs7kPQQoshr3wXoAfLsnM7NFBrh7jJq6bD
 tdy2eruDoqd4M6wUmFDbRy3ljkWGkGKHCKONgLE=
X-Google-Smtp-Source: AGHT+IHb1sq05fjWGbRLS4tBWuCQjFz3MrPELHMa1EmJYBHs/jK5aqzCf8gPflB2Rs3bNbLoztClNA==
X-Received: by 2002:a05:600c:2197:b0:405:514d:eb0e with SMTP id
 e23-20020a05600c219700b00405514deb0emr22913649wme.19.1697183968288; 
 Fri, 13 Oct 2023 00:59:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:27 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v2 54/78] hw/core: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:21 +0300
Message-Id: <f385cf09b449507eb3f7ad6ab2d9b57f0f9fe7a8.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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


