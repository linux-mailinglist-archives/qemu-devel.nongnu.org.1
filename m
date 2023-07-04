Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 296FC746A78
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:20:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaKC-0002yT-Tg; Tue, 04 Jul 2023 03:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qGaKA-0002xz-2m
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:19:46 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qGaK7-0007Dx-Mr
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:19:45 -0400
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MgwBv-1poglG0mFx-00hQuo; Tue, 04 Jul 2023 09:19:35 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, eric.auger@redhat.com, Peter Xu <peterx@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, mst@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 1/1] vhost-vdpa: mute unaligned memory error report
Date: Tue,  4 Jul 2023 09:19:31 +0200
Message-ID: <20230704071931.575888-2-lvivier@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704071931.575888-1-lvivier@redhat.com>
References: <20230704071931.575888-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:54YUGANrsbtkHLdfjXt7t/uO1C6lrSLmKqr0urMFkfWjh6f6ua+
 c6isQ4kD0Afgq/5/h+u/es4mJTem/D1RRxFcuqY2LWLvntQh8Uy0hpwMHtRz0fTGVYs2/1r
 yXgYAmwDJzIv/Lhn0ou0yJ8WCLqWz06VXdOYQszV6mnQQFSavZ0KkYSu1ZSB65/xrMYtmfC
 yjg2sbdZe6wq/XtUJgCwQ==
UI-OutboundReport: notjunk:1;M01:P0:9Aw8iZAil6E=;WGa+Mu3/c+iFj2Gu2bOPKJ9wcad
 nGh/JtyUPblyS7FrrDK2CDb/hLQiavihZxSHc42ezuVJu97CrnWeN97sBoyIDAN7aRB1r3f0r
 ndvS9zh8ZJcZP/5dwfZUDhBkaQrC7RJZ2PpVIhaI32pczPgYmfo2K0wqmGOU8bB97fdtMfS5E
 YkohyMUxi//hY2WAsmqTZWig6/RBwAgQzWLFxbSxuHjp6rh5z0BY7iATAjIcHKQfJFui4n7qZ
 3NK6CRRFKyejyoL+CNnsLI7Wek7a//vo4ShPeBn0VmUAx94hTdsnJp97x3SyEQrC0iUsldtUg
 eIHDvBNfRimIDowqkyb8EDWUYZ5gnoaKXor4HhlXBZxlm0QfrZqAvuBNI5NRcyfMu9mZW29oq
 Gc5rxfLrQYJuit1L/NzXabYE/G4H3Mq7XoT33jNXXjUrm6lbrdiKr2+UPH/MA9YCcNmCmfp4H
 F7+XIe+Ln2YI8chsXZ1+sLnWb1zXw9lGIJV8xQUXfcLNErjFrSO4qnzUjvjGQx/RKkI5NAyBA
 hZBsfto3iH/gUhlsmt9QzgGSfbLvYwL5kHbTHA9KP66x4ujLbnmM6BsR9g+JBIlflvX+S7cfc
 YOl0inEL8Es3HXJBJxDXiJ6YquHf+mic9zz14WDyTHGKRIOfMOvf7EGbYqpogPiTvnDraCZoQ
 GguRuhyLNcsTvalbyzsE+Pk0Vk9iVCYbPxFeXCUFtQ==
Received-SPF: permerror client-ip=212.227.17.10;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_FAIL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

With TPM CRM device, vhost-vdpa reports an error when it tries
to register a listener for a non aligned memory region:

  qemu-system-x86_64: vhost_vdpa_listener_region_add received unaligned region
  qemu-system-x86_64: vhost_vdpa_listener_region_del received unaligned region

This error can be confusing for the user whereas we only need to skip
the region (as it's already done after the error_report())

Rather than introducing a special case for TPM CRB memory section
to not display the message in this case, simply replace the
error_report() by a trace function (with more information, like the
memory region name).

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/trace-events | 2 ++
 hw/virtio/vhost-vdpa.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8f8d05cf9b01..9b0d643b9475 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -34,7 +34,9 @@ vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_
 vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type) "vdpa:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
 vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
 vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
+vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
 vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" vaddr: %p read-only: %d"
+vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
 vhost_vdpa_listener_region_del(void *vdpa, uint64_t iova, uint64_t llend) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64
 vhost_vdpa_add_status(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
 vhost_vdpa_init(void *dev, void *vdpa) "dev: %p vdpa: %p"
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3c575a9a6e9e..24d32f0d3728 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -323,7 +323,9 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
     if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
                  (section->offset_within_region & ~TARGET_PAGE_MASK))) {
-        error_report("%s received unaligned region", __func__);
+        trace_vhost_vdpa_listener_region_add_unaligned(v, section->mr->name,
+                       section->offset_within_address_space & ~TARGET_PAGE_MASK,
+                       section->offset_within_region & ~TARGET_PAGE_MASK);
         return;
     }
 
@@ -405,7 +407,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
     if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
                  (section->offset_within_region & ~TARGET_PAGE_MASK))) {
-        error_report("%s received unaligned region", __func__);
+        trace_vhost_vdpa_listener_region_del_unaligned(v, section->mr->name,
+                       section->offset_within_address_space & ~TARGET_PAGE_MASK,
+                       section->offset_within_region & ~TARGET_PAGE_MASK);
         return;
     }
 
-- 
2.41.0


