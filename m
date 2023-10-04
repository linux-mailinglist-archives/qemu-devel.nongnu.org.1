Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD07B7AF4
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:01:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxTt-0002Tq-3q; Wed, 04 Oct 2023 04:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTq-0002Ql-51
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTj-0000v3-MM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qziaif5jFzedGkKOEqZ/+iEupJFwfjmUm3vm30zmedI=;
 b=TlIC+9nwTsRQtzIxCBjOaxI5XDuNy+Ml8oX9GNUExelcv49Lr3KvSo2Uummf3W+tNP//69
 za+kStmDgnT1siynKCiqlyeweh2gjbY5QWN10aDVZ4gCxZ5/saipKBdQchRSZDLw6hrypS
 r4ZxXKMyuzNYxZ7/5mCyUCV/qJhMnXc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Ggog96xwOqqguAz5p6UiJQ-1; Wed, 04 Oct 2023 04:43:28 -0400
X-MC-Unique: Ggog96xwOqqguAz5p6UiJQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3233a13b47eso1468458f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409007; x=1697013807;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qziaif5jFzedGkKOEqZ/+iEupJFwfjmUm3vm30zmedI=;
 b=uFGKWIR4D2tNN8LazlC/I1jwTKYSuS1DGHtZ9gy8xGVJc3Cvzq9V6JeIgFf38guS0X
 7Nzat4yNckqaw/XA6HD/hrQjFcatw0beqQ7ETsEfiE1d64lLs7yaOVz25eJCZpILvoQ8
 5Vv/lspdtmh9Hf20ndCvjWGX0pvVjjQuPQL5YSRqB60CDhHudVkOvrs54qSZk6o4jd6b
 zjzRzxnGxDJiTARriMq8liKuuPON7GtDKDzoa3ZQ9njxl6iaWK/+6ROOqFd4M3XjKKq+
 0wZW6GGv1CJSOE5bt0oeBq6Z7ILNO5UTMgVtchpeZ4YDQpTgEf96wBNajM9DfiVO5KmF
 mB2A==
X-Gm-Message-State: AOJu0Yya7v1+Kamlp0IzbYiNXJKulGoSL7sZ5lfOvvcd63vfDQv72E6o
 yoIoO+IUfUxjngOrLl8dLTT3hcUqOVDbR/dIiw4uk8U5K7abWC9L0ngq/2/r5G3X6BMBS0UIYur
 uTN03pV+MSgXbdbJLihiuZqcPViS9ahYtI9ra7P8oijeH2eBVsv02QA7j0LZUe2FegvDs
X-Received: by 2002:a5d:664d:0:b0:31f:d3e3:a53d with SMTP id
 f13-20020a5d664d000000b0031fd3e3a53dmr1544506wrw.2.1696409006895; 
 Wed, 04 Oct 2023 01:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECV0oPG8mRN9BP49R6/Nwl/LmO5yyM/zZEOACQIL6Z+i23KbiHT7HXgkXubAUD74/iIvVVyw==
X-Received: by 2002:a5d:664d:0:b0:31f:d3e3:a53d with SMTP id
 f13-20020a5d664d000000b0031fd3e3a53dmr1544497wrw.2.1696409006568; 
 Wed, 04 Oct 2023 01:43:26 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 v8-20020adfe4c8000000b003247d3e5d99sm3449577wrm.55.2023.10.04.01.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:26 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/63] hw/virtio/vhost-vdpa: Use target-agnostic
 qemu_target_page_mask()
Message-ID: <44dc75dd15ca86317d9d892e0311f2721bfa4b41.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Similarly to commit e414ed2c47 ("virtio-iommu: Use
target-agnostic qemu_target_page_mask"), Replace the
target-specific TARGET_PAGE_SIZE and TARGET_PAGE_MASK
definitions by a call to the runtime qemu_target_page_size()
helper which is target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230710094931.84402-5-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 0e0ed6d7ac..50b932a930 100644
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
@@ -323,16 +325,16 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
-                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+    if (unlikely((section->offset_within_address_space & ~page_mask) !=
+                 (section->offset_within_region & ~page_mask))) {
         trace_vhost_vdpa_listener_region_add_unaligned(v, section->mr->name,
-                       section->offset_within_address_space & ~TARGET_PAGE_MASK,
-                       section->offset_within_region & ~TARGET_PAGE_MASK);
+                       section->offset_within_address_space & ~page_mask,
+                       section->offset_within_region & ~page_mask);
         return;
     }
 
-    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
-    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
+    iova = ROUND_UP(section->offset_within_address_space, page_size);
+    llend = vhost_vdpa_section_end(section, page_mask);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
     }
@@ -398,25 +400,27 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
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
         trace_vhost_vdpa_listener_region_del_unaligned(v, section->mr->name,
-                       section->offset_within_address_space & ~TARGET_PAGE_MASK,
-                       section->offset_within_region & ~TARGET_PAGE_MASK);
+                       section->offset_within_address_space & ~page_mask,
+                       section->offset_within_region & ~page_mask);
         return;
     }
 
-    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
-    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
+    iova = ROUND_UP(section->offset_within_address_space, page_size);
+    llend = vhost_vdpa_section_end(section, page_mask);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
         int128_get64(int128_sub(llend, int128_one())));
-- 
MST


