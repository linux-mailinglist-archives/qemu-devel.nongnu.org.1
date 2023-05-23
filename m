Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E2970E1E9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V0l-0003s4-Ce; Tue, 23 May 2023 12:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0h-0003nO-4P
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0f-0001p4-CK
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3063433fa66so4845396f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859835; x=1687451835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVars2hcHXmfzOaUijNnjb/uP3QrA6j+f0+XOdMOWuA=;
 b=pIB+0FQclVihJoQQAR3rBWyPzHTIIQts36rTOrBW/T1AEVAk6ZfQq9LyMnJIGZKw2H
 uPmZAd7KHcbCyPEzSTnrwOuJDoorql8y+LMxEErZY6AGBZHFFaokV7rc02BBpX3m5+MC
 rTDVBB4SQS50eKcYozU0PZaDJ1Fy/ecVWsj5Lu/FTP4lkOdKM2J+Kj27vVgoK0z6jOSp
 3Xhmh+Uw3zpw/61KcNaEE+s5TnxgnXWZ15MRUlfewF1HBuRuySCzCIpA42PcEBG9nKvu
 CFASc5BXp8DTGq6QEPEVmgBXgvFJl4bDKzyTzDwm4+yKKFlenP9zmG0z/Jlv2AJSo0IB
 8z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859835; x=1687451835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVars2hcHXmfzOaUijNnjb/uP3QrA6j+f0+XOdMOWuA=;
 b=DMK7YI8SutmK/tzPM8IZXNjwMKAk8ecmSZYroJvOPh/Z9o5io8CIhFVGWfeWo1Jj6g
 bwVnYnJcOr3+5t+N2KVjLzGGxRs5APz0troObXlXx42/woscx0LFgaHedpx9qL1U/keD
 9aA5jG7Kp5PjfaDrtWud8ZtowEmiqAkMpbUa/fKw1l4p2DtxdfyBAgXfpW1Y5wEbYtvi
 OMuqgLO7RH4On2LnsHKAHMddoejMekESQQc4XQJuBoBpilbuL8Pcb0rvJZ9W939wu2XM
 4RC/QZrprbsEayXezcoyi5t+cWc+i5+0qnieJ7qkRc/TI3BUvuOmD90Z1ZlajWZMKkoO
 Id6A==
X-Gm-Message-State: AC+VfDxGvhKkWKAmnD5drCGmXcNLVrBJEnLq4NQI7kM/nzXXxy6MdYnk
 iKXngpfQr9lODJoTsV1h4VpRa/NGrpHneSPM+1Q=
X-Google-Smtp-Source: ACHHUZ5cKVjiBM2KucH1BkypxSUr9LtZNBUNs/mlDp3NJ+IGT7oHkpvOyvGG94Md7sUP6y0VxqGWdQ==
X-Received: by 2002:a5d:6a09:0:b0:309:48b9:977b with SMTP id
 m9-20020a5d6a09000000b0030948b9977bmr9886121wru.22.1684859835749; 
 Tue, 23 May 2023 09:37:15 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adfdb52000000b00307d20546e6sm11831219wrj.27.2023.05.23.09.37.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:37:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [RFC PATCH 11/11] hw/virtio: Make vhost-vdpa.c target-agnostic to
 build it once
Date: Tue, 23 May 2023 18:36:00 +0200
Message-Id: <20230523163600.83391-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Replace TARGET_PAGE_MASK -> qemu_target_page_mask() and
TARGET_PAGE_ALIGN() -> qemu_target_page_align() so we don't
need the target-specific "cpu.h" header.

These macros are used in the MemoryListener add/del handlers
(vhost_vdpa_listener_skipped_section is only called by
vhost_vdpa_listener_region_add) which are not hot-path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-vdpa.c | 16 ++++++++--------
 hw/virtio/meson.build  |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3c575a9a6e..a51497aaf1 100644
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
 
@@ -35,7 +35,7 @@ static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section)
 {
     Int128 llend = int128_make64(section->offset_within_address_space);
     llend = int128_add(llend, section->size);
-    llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
+    llend = int128_and(llend, int128_exts64(qemu_target_page_mask()));
 
     return llend;
 }
@@ -321,13 +321,13 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
-                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+    if (unlikely((section->offset_within_address_space & ~qemu_target_page_mask()) !=
+                 (section->offset_within_region & ~qemu_target_page_mask()))) {
         error_report("%s received unaligned region", __func__);
         return;
     }
 
-    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    iova = qemu_target_page_align(section->offset_within_address_space);
     llend = vhost_vdpa_section_end(section);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
@@ -403,13 +403,13 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         vhost_vdpa_iommu_region_del(listener, section);
     }
 
-    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
-                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+    if (unlikely((section->offset_within_address_space & ~qemu_target_page_mask()) !=
+                 (section->offset_within_region & ~qemu_target_page_mask()))) {
         error_report("%s received unaligned region", __func__);
         return;
     }
 
-    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    iova = qemu_target_page_align(section->offset_within_address_space);
     llend = vhost_vdpa_section_end(section);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 16e64e1cf1..c29be98ab0 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -18,7 +18,8 @@ if have_vhost
     specific_virtio_ss.add(files('vhost-user.c'))
   endif
   if have_vhost_vdpa
-    specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-virtqueue.c'))
+    softmmu_virtio_ss.add(files('vhost-vdpa.c'))
+    specific_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
 else
   softmmu_virtio_ss.add(files('vhost-stub.c'))
-- 
2.38.1


