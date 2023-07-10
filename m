Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D674D23D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInYE-00052r-Vg; Mon, 10 Jul 2023 05:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInYC-0004x8-6L
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:51:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInYA-0004Dz-GX
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:51:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so47709515e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688982680; x=1691574680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Te/381aYxXjbGwK91Z8xo75ztwPRV+rlNTVP8J6hqh8=;
 b=ajHaLvTjqb30kWmcJVPp8PfoJ+pgpSNcMU93ZXOfZVoG6hzI3aFCq/ffboNB6b93Gt
 oDvADTqmt3lZfhgVyxJtypq0+/186kopeuYYa1Gv6aeUpu/ULSGXCno2ODOyxaksO96P
 DslLgj5YZ2snWYzsjIlXg4TYun5yNDyPC3+cbVRW72lbBAS0LYD4SlQgIUogI7izs6Q+
 mkU9D1iTJGPJcLKc88hHH0eeNkKFFfHGlHUhH2X6phVz03ltrBOGNokcidOUpgBd0dMG
 qgyRYhtVlb/KMPN03T85mnwqPM5o35+diS9219DGQXp+7liBCmgDPACoF6RP8/njaVF6
 ZLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688982680; x=1691574680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Te/381aYxXjbGwK91Z8xo75ztwPRV+rlNTVP8J6hqh8=;
 b=DNYxvk1nesSw0AG1onHMiQ+Yf1UkpBtVicnjxkqNuB9YxOlnbrzvjbmJLYCjN8nkRs
 B40NQO2w/j2GLx8gqk+9QgPHc1mNVT0ZaV+HCyDwnpx/hgaRXAqQsjx3xeygc8OB0PXS
 PycNoPHAReVNOWzIKKVS7F40zpsCAOb9akzTQRqqPi5IbaZgfaCPC8c9JHsysnvV3ofq
 hMh5aHpUuuHoBHe7NRMhxYeIjGnQOkEkJwCzOc0IhoQWUZCE+naRUUkpAQGSBq19pAzm
 NMxIwI+yt0AINz++ZLwajAWRDekIj5xGknuROU/yTA2cTnVRtvsoahTqmlYH7Ij1uOEk
 9gvA==
X-Gm-Message-State: ABy/qLbj+aKF+ScwvwNzxvmu/2hXJBioL0YLH9xGCIMyic93kcI8Wl7a
 O5NwbepA02comgSxYxCu4PAs26fZPJabjl1V/R0z1w==
X-Google-Smtp-Source: APBJJlGX7VztpPozr9n/7yx3KPrmYivvYC5h6el0dvDpXI/ygGohoFoFyW79RgzHQsSq+c4WufDzYQ==
X-Received: by 2002:a7b:cc84:0:b0:3fc:a5:2c3a with SMTP id
 p4-20020a7bcc84000000b003fc00a52c3amr7729653wma.41.1688982680527; 
 Mon, 10 Jul 2023 02:51:20 -0700 (PDT)
Received: from localhost.localdomain (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 c13-20020a05600c0acd00b003fa96fe2bebsm9830608wmr.41.2023.07.10.02.51.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 02:51:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/6] hw/virtio/vhost-vdpa: Use target-agnostic
 qemu_target_page_mask()
Date: Mon, 10 Jul 2023 11:49:29 +0200
Message-Id: <20230710094931.84402-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710094931.84402-1-philmd@linaro.org>
References: <20230710094931.84402-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Similarly to commit e414ed2c47 ("virtio-iommu: Use
target-agnostic qemu_target_page_mask"), Replace the
target-specific TARGET_PAGE_SIZE and TARGET_PAGE_MASK
definitions by a call to the runtime qemu_target_page_size()
helper which is target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-vdpa.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index a3dd7c712a..2717edf51d 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -14,6 +14,7 @@
 #include <linux/vfio.h>
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
+#include "exec/target_page.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio-net.h"
@@ -23,7 +24,6 @@
 #include "migration/blocker.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
-#include "cpu.h"
 #include "trace.h"
 #include "qapi/error.h"
 
@@ -313,9 +313,11 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     Int128 llend, llsize;
     void *vaddr;
     int ret;
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
 
     if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last, TARGET_PAGE_MASK)) {
+                                            v->iova_range.last, page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
@@ -323,14 +325,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
-                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+    if (unlikely((section->offset_within_address_space & ~page_mask) !=
+                 (section->offset_within_region & ~page_mask))) {
         error_report("%s received unaligned region", __func__);
         return;
     }
 
-    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
-    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
+    iova = ROUND_UP(section->offset_within_address_space, page_size);
+    llend = vhost_vdpa_section_end(section, page_mask);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
     }
@@ -396,23 +398,25 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     hwaddr iova;
     Int128 llend, llsize;
     int ret;
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
 
     if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last, TARGET_PAGE_MASK)) {
+                                            v->iova_range.last, page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
         vhost_vdpa_iommu_region_del(listener, section);
     }
 
-    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
-                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+    if (unlikely((section->offset_within_address_space & ~page_mask) !=
+                 (section->offset_within_region & ~page_mask))) {
         error_report("%s received unaligned region", __func__);
         return;
     }
 
-    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
-    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
+    iova = ROUND_UP(section->offset_within_address_space, page_size);
+    llend = vhost_vdpa_section_end(section, page_mask);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
         int128_get64(int128_sub(llend, int128_one())));
-- 
2.38.1


