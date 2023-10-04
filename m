Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1CE7B7A67
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:44:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxTn-0002IV-Kr; Wed, 04 Oct 2023 04:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTi-0002Eb-8J
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTg-0000uP-MF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0fAAn8UFyb8KBtfxAsFqqpol8c8vZQYpO/ekzLxr6g=;
 b=fWYmquRyTYk4Lt5GtfDpA/d+jtbUUdcI0pp8yn8YFvuO/LRu5KqOPdZMr383PbnfauJLZA
 649cRXv1C3x0e8IG3aHrlDZAA6Kqk2JGkITRAWj0mvX/U6Q9osuHv96QKuGBAWeSvFAyzw
 To9VybFYmUI8FClAitA84N30b40+XJM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-k9SFH9qzNDWlay_fFAgqmw-1; Wed, 04 Oct 2023 04:43:20 -0400
X-MC-Unique: k9SFH9qzNDWlay_fFAgqmw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3248ebee5f4so1305429f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696408999; x=1697013799;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0fAAn8UFyb8KBtfxAsFqqpol8c8vZQYpO/ekzLxr6g=;
 b=REyVPFFQfEWXUW7Huvtd9TxXaYo7dK6TUnWwgw//N+4zw06HckipdVxfr5jErXqZcM
 sNPw0moXW25y85HqKKSG3YCW+oO3wNuI7EQgmNKzMQcCi0QQoT+m0e9f8fjGxH7g5lcl
 db0mo9bT+sJJZwChHkhk6UQ/TCWg1Q8vIvKYp7++2ByiY5WwNiFF18b0vc2BtcKN9KyH
 cJtkHhM0B/6t3rWEsGHsMZc0PBkYAWOgNV28cEmRIF+CkhgOGdH7qG0raRoRB8y8wY3+
 Zyl3UlCdIWvJNILTOgwiKAgv1Z8cgqqZlGb5NyI8YEa/tutTg/0ufl++kMA9j06ieTm2
 Sl8A==
X-Gm-Message-State: AOJu0YzHTNH22dGpstMo9+6CoeSIHUMG9099MD6bfU0RUOoWikIB+xib
 zoB/8lKDNjMzAU1dPy6qO5RxLAEDL2NTNySAV2D7ip+/0NhO9/u1ZJBqWu5RtHAwZnM7ECQvYhe
 N7rY7Yi94VnzGMxU94guXCz4cXRIhi47+DPAMQvMzYxANs0mQnfJjhaMqc6Me98AkAkyh
X-Received: by 2002:a5d:6a4c:0:b0:31f:8a6d:e527 with SMTP id
 t12-20020a5d6a4c000000b0031f8a6de527mr1495199wrw.45.1696408998868; 
 Wed, 04 Oct 2023 01:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAWaOrDzS0FKbvpSKoYqtw1k6P4Pokk1OU7W5NugEJnx0E3R1O+6aeSAoYS9dzYC5No8rUTw==
X-Received: by 2002:a5d:6a4c:0:b0:31f:8a6d:e527 with SMTP id
 t12-20020a5d6a4c000000b0031f8a6de527mr1495182wrw.45.1696408998562; 
 Wed, 04 Oct 2023 01:43:18 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 r5-20020a5d4e45000000b003176c6e87b1sm3461288wrt.81.2023.10.04.01.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:18 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/63] hw/virtio: Propagate page_mask to
 vhost_vdpa_listener_skipped_section()
Message-ID: <ed054ee3d4194c20da06981407e2e0515e6467b2.1696408966.git.mst@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In order to make vhost-vdpa.c a target-agnostic source unit,
we need to remove the TARGET_PAGE_SIZE / TARGET_PAGE_MASK /
TARGET_PAGE_ALIGN uses. TARGET_PAGE_SIZE will be replaced by
the runtime qemu_target_page_size(). The other ones will be
deduced from TARGET_PAGE_SIZE.

Since the 3 macros are used in 3 related functions (sharing
the same call tree), we'll refactor them to only depend on
TARGET_PAGE_MASK.

Having the following call tree:

  vhost_vdpa_listener_region_del()
    -> vhost_vdpa_listener_skipped_section()
       -> vhost_vdpa_section_end()

The first step is to propagate TARGET_PAGE_MASK to
vhost_vdpa_listener_skipped_section().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710094931.84402-2-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 42f2a4bae9..118c588205 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -42,7 +42,8 @@ static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section)
 
 static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
                                                 uint64_t iova_min,
-                                                uint64_t iova_max)
+                                                uint64_t iova_max,
+                                                int page_mask)
 {
     Int128 llend;
 
@@ -313,7 +314,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     int ret;
 
     if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last)) {
+                                            v->iova_range.last, TARGET_PAGE_MASK)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
@@ -398,7 +399,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     int ret;
 
     if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last)) {
+                                            v->iova_range.last, TARGET_PAGE_MASK)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
-- 
MST


