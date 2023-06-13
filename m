Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC1372E1CC
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90VL-0005lh-VQ; Tue, 13 Jun 2023 05:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90VB-0005l0-AE
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:50 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90V2-0005h5-JX
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51492ae66a4so7516164a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649177; x=1689241177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Fjis3842wl6k6Jb8zbXdSMkjzpqKuYtbmTIrMzfnM0=;
 b=OUkVQgen/DpXQjJCyv+7Wc21rqOVVrYEtLKIei3XPNpqNBDPdYo5WgOqt0X6qZxuFe
 uiTWNJE6azCgrmwocOiwQai8TCt32TlQcWldN40ZOsyWLybmV1b3OSqcZbHK66RvSu+e
 XFl8OzphodCT/t3t7ELWzdyXqsfnZeZY8NvTOzRk7yZCJE3N9cGvb2vjkIthOMvWn9vZ
 HO+ccKtETR+nRbndECWZUbsgcNQGxZqLk05lmO4s/ULitYbsp3BhtpbLmiq8mwzcPmCN
 EHP9wF9UEE2KtTy1VFOyEUXsi9c2wIY/AnWfplFp4jVwwIcbv6wHsRfrf9d8B8KPvfbw
 yHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649177; x=1689241177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Fjis3842wl6k6Jb8zbXdSMkjzpqKuYtbmTIrMzfnM0=;
 b=fItBDqDTr+FBIH0d+vES/9BWB32NAMyJXFU9k+N8cTpX7g9akRW9r3H8ntHT8YMeft
 VDeY+CI86mi+UHZdF2sKQOAwpg2UDENosVwrywmhlQp9bxHDxyV2kUwD4ek2ZKqEpLXI
 0ulddSSsSbCHBwEAh9LBc2+vncHYFjJv1ylEcXVR7ZBiGh/QDRZe6z0puj8XwUiu4VKm
 MIaBqFD4UvltK36SbZIg4ZPMf2WbCsTOC1BBhdHxAQwkfneSI0vAtd72aAD8OBvaUQVO
 AnLBD3aO1fAqqzVwWv6M1XnH4Zc/ZXzmv3fB8Ew4MbufoM0iQLS/is0GF4wsbQgMVxyx
 OQ3A==
X-Gm-Message-State: AC+VfDxMIroR5ay96NVP7m/Yxwo6sHZMo78UZYA8LAaYUgX8bKCAJ/m4
 mtbXTmF0zs/EoqYzWHR+VPOokZgDvAnnP+taiEYkHQ==
X-Google-Smtp-Source: ACHHUZ4fbAKwIzd8b/1+pZq+02UA/c2J2hhhUSl5cZeNUJ5BRhudzWfZ00blMMHT8zKM0AsWogkLAg==
X-Received: by 2002:aa7:cfcc:0:b0:514:bc92:8e1d with SMTP id
 r12-20020aa7cfcc000000b00514bc928e1dmr5755920edy.14.1686649177550; 
 Tue, 13 Jun 2023 02:39:37 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056402038700b00514a6d05de9sm6169282edv.88.2023.06.13.02.39.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PULL 16/17] hw/vfio: Add number of dirty pages to
 vfio_get_dirty_bitmap tracepoint
Date: Tue, 13 Jun 2023 11:38:21 +0200
Message-Id: <20230613093822.63750-17-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Joao Martins <joao.m.martins@oracle.com>

Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
These are fetched from the newly added return value in
cpu_physical_memory_set_dirty_lebitmap().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <20230530180556.24441-3-joao.m.martins@oracle.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/common.c     | 7 ++++---
 hw/vfio/trace-events | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 78358ede27..fa8fd949b1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
 {
     bool all_device_dirty_tracking =
         vfio_devices_all_device_dirty_tracking(container);
+    uint64_t dirty_pages;
     VFIOBitmap vbmap;
     int ret;
 
@@ -1772,11 +1773,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
         goto out;
     }
 
-    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
-                                           vbmap.pages);
+    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
+                                                         vbmap.pages);
 
     trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
-                                ram_addr);
+                                ram_addr, dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 646e42fd27..cfb60c354d 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
 vfio_dma_unmap_overflow_workaround(void) ""
-vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
+vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # platform.c
-- 
2.38.1


