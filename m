Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7667B9A75
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGI-0001Dd-Ji; Wed, 04 Oct 2023 23:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGF-0001D7-7U
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGD-0007yr-R3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPz4GnJfkENcst/YvbRzP3MUYaB7CKMx8l9nJBdXF6s=;
 b=UKy/ksWekDirJnj5y2rG8YFQsfDO0qn+i6iVQ1DxYn6kcFLrE8Lt7OYa/4SHbfp0pH/zFc
 gei2OyPDYZDALU3CPstRyk3OEFmiY5cqYp8pqytdUgpGfGWQ25dgvAoyEOqhbj206nhLrC
 YPNpG5vY7qBYLukbh0uup3fKylVOaG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-FSkK6sFWPy-HU0h3q1V0Aw-1; Wed, 04 Oct 2023 23:42:37 -0400
X-MC-Unique: FSkK6sFWPy-HU0h3q1V0Aw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so478398f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477356; x=1697082156;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPz4GnJfkENcst/YvbRzP3MUYaB7CKMx8l9nJBdXF6s=;
 b=Vyg7uPOMm7eIewO0qpull5mlxTktenTBvYPKfZiDXcQIv3DmXZPpCzP8TKCvRE/rfZ
 cwp8pK/ZgHGFCdBKYtlSBa6gjNwhZOgZSaDKSYYSffOJRSiCJI88MFIW8+INwi+s2vzK
 kjllrc7LJ8oB9xqIARAfz1fDDUCYTfHx0V7kEU9alDqm0qA7/f/SvUytotbQPs3/it0f
 YJ8Iq3z07Sb6kBE8xUAo3BZRMDSKwm6/fbk+EJ3CANBpfQgNYjOvJRHXueH/L/1Hwz4K
 6nNhOel+Dg9Dt1ze1A5BvfR8Tpy+58CziPkQnxTgPUuZ4amjbCHzH0jYVJjdOM1o8+/0
 9NlQ==
X-Gm-Message-State: AOJu0YyCRzrfeBIubbboOat8cqkPwXzOP3GcGQIC1Q5UYl9uultDFenv
 TSAUo9AOH4amL9j+5Io+8sWIziiNRTVAgZp3x2ENcVkPtSnm+mUUC4KdEWXQIavzKnueJMQ67Oa
 MlvM3alF4RJuB4fgYAtq7Ko+vm5SAM5M4+6SvDjBMTmdm/N/7y27uIQhX9gRsklRJ4DA4
X-Received: by 2002:a5d:6991:0:b0:320:976:f940 with SMTP id
 g17-20020a5d6991000000b003200976f940mr3665981wru.13.1696477356160; 
 Wed, 04 Oct 2023 20:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCI4zHIPwYLi9l+0QDcbzylXUhu64LG4WWlqXfS6EU7OnZ8TVAokrqG2PfE5iktRV0ChxjvQ==
X-Received: by 2002:a5d:6991:0:b0:320:976:f940 with SMTP id
 g17-20020a5d6991000000b003200976f940mr3665970wru.13.1696477355843; 
 Wed, 04 Oct 2023 20:42:35 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4f07000000b00317e77106dbsm628436wru.48.2023.10.04.20.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:42:35 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:42:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 03/53] hw/virtio: Propagate page_mask to
 vhost_vdpa_section_end()
Message-ID: <8b1a8884c6aacd9a35863d18a757be17ec7b1369.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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

Propagate TARGET_PAGE_MASK (see the previous commit for
rationale).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710094931.84402-3-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 118c588205..3ab0dc0b5b 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -31,11 +31,12 @@
  * Return one past the end of the end of section. Be careful with uint64_t
  * conversions!
  */
-static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section)
+static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section,
+                                     int page_mask)
 {
     Int128 llend = int128_make64(section->offset_within_address_space);
     llend = int128_add(llend, section->size);
-    llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
+    llend = int128_and(llend, int128_exts64(page_mask));
 
     return llend;
 }
@@ -69,7 +70,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
      */
 
     if (!memory_region_is_iommu(section->mr)) {
-        llend = vhost_vdpa_section_end(section);
+        llend = vhost_vdpa_section_end(section, page_mask);
         if (int128_gt(llend, int128_make64(iova_max))) {
             error_report("RAM section out of device range (max=0x%" PRIx64
                          ", end addr=0x%" PRIx64 ")",
@@ -331,7 +332,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     }
 
     iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
-    llend = vhost_vdpa_section_end(section);
+    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
     }
@@ -415,7 +416,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     }
 
     iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
-    llend = vhost_vdpa_section_end(section);
+    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
         int128_get64(int128_sub(llend, int128_one())));
-- 
MST


