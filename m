Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E7974E1C8
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvj-0000Zu-4R; Mon, 10 Jul 2023 19:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvg-0000WS-VH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvf-0004WC-A6
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WlMuDt1UzJVVupSGICrVYy9F98jUJydJxkhHG86yxjs=;
 b=IIRQMQ55HYUcwq+ji/w36Hq+FxxJDPbU0xJV4oBuE6oV5sLg/DfsxLRO8FW7PIoG1HyhJ/
 07PyHU2OehmNl7eWTRGTUIay1o2ZMMAREHaZ9gXNP8jmQAm3gOdy5sHkBg5q/545hqujx7
 8c5mZjnsKLLMrDgK4ulDgGEGNuh5ky0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ca-WBvGfOcy0v4u1r9Xwog-1; Mon, 10 Jul 2023 19:04:25 -0400
X-MC-Unique: ca-WBvGfOcy0v4u1r9Xwog-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdd5d09b8so34284225e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030263; x=1691622263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlMuDt1UzJVVupSGICrVYy9F98jUJydJxkhHG86yxjs=;
 b=MRtru5qiUYECAQp+kAFGzA/dzOHoPAiHrapt5pJCTtgJOIIWB5XK7n558zDb34a6Rl
 S6gqol1UKcayIY6wfct9gMLKcXgzs1LGyf3O+ADcdMO2j0H+W6mUn8IouT4n/BqApZQP
 dQDVeXPYYTpN24DPTjvq1LRMicbUpIa9tVNo6i35SThFo3FtWyleBk2wlAElQ3FD0m/a
 QtsnnMnd5Ul9btrc86+se1OSkfhgl4jQx83lHm9zJ7Qfq0udiPkVL1+SAZDRr7i1cl7x
 I/+Qx8u3OyZZTRF67WibWfeybmuziHq+Lel3S/K1Z56S4ku9A/8GAUmHd0XFcYm6YiLS
 fiUQ==
X-Gm-Message-State: ABy/qLbVsocrNH+YP6Pcw7In2E6gHM8sGdlzzMoka0DnSX4luJPVfT28
 T3PpwLOQdoP3JEIUswz53vA0qOvaBcgyXB51pyO/SvO6l0DBnA7cyDtqKQRaKbXKNvBOSDnFskg
 8tq4bwCyssyNg0A0htnY6+xEj6+A6xKLXnlekbsZAu3O798wmBdNohDEbyqKTg36FGrzL
X-Received: by 2002:a7b:c019:0:b0:3fb:b2c0:fcec with SMTP id
 c25-20020a7bc019000000b003fbb2c0fcecmr13116297wmb.24.1689030263358; 
 Mon, 10 Jul 2023 16:04:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOzKrdn1qXH7uBvRC8Ir3P4H9t9VZqzEpChA9PQiOQgWllevscHn7x3tAmf/PGJUWhr+YZ9g==
X-Received: by 2002:a7b:c019:0:b0:3fb:b2c0:fcec with SMTP id
 c25-20020a7bc019000000b003fbb2c0fcecmr13116283wmb.24.1689030263095; 
 Mon, 10 Jul 2023 16:04:23 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 f18-20020a7bcd12000000b003fa999cefc0sm919011wmj.36.2023.07.10.16.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:22 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 40/66] vhost-vdpa: mute unaligned memory error report
Message-ID: <77812aa7b1fdf8f547c35a7f9a4eb1cbf3a073db.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

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
Message-Id: <20230704071931.575888-2-lvivier@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 8 ++++++--
 hw/virtio/trace-events | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 6246e5b9bf..42f2a4bae9 100644
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
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 6265231683..4e39ed8a95 100644
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
-- 
MST


