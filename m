Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860E7B9A40
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:43:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFG3-0001AE-7O; Wed, 04 Oct 2023 23:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFG1-0001A5-Gs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFG0-0007xF-0Z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0fAAn8UFyb8KBtfxAsFqqpol8c8vZQYpO/ekzLxr6g=;
 b=JWXR5qL4UWo7BZTOvmocW8YzgwkBEenZbYRhpiPpr2MZZVVeDdSDjx/yFs6GCPkzUz094c
 qJATvfhcHjBoxo4PDdBF7TZtMn65bgpYL65TjXzETJrLPDhVSLI90jWsYo9i+CZzPiVp/d
 g+4Ybf2CVLgfSxeq9B56GDSzj0zC2Xs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-Hkojnh9GNYKQkDE35m5k2Q-1; Wed, 04 Oct 2023 23:42:33 -0400
X-MC-Unique: Hkojnh9GNYKQkDE35m5k2Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32588c87716so430461f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477351; x=1697082151;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0fAAn8UFyb8KBtfxAsFqqpol8c8vZQYpO/ekzLxr6g=;
 b=CMFWN5RlBmOwU6XqCPOLSzofybEsS6Ge6Of6nUkXrvKurDLYN0rOUbB3qxVkdErM2P
 gU2zJuuz5njbkJa0IoyaQBkGgLKyRro82HvrbwiMN8OBHZxFssqZwu+VQ/3xpAihOKH+
 LWSaIK4f9YU56aJA2V/AV3P5HXQMbywxZ/iyUSRrIc069JsQpkq1GSb3Z7xaSCyvFLdX
 IAdje/kEwVQQTooC0n9KbUSzZG9hdsi69pFZM5Dn2kjUNFkU9IigJh7a2O4wZ3KhP2UT
 F1nIkP/5GJ5mQhYL/501iPRcX5d6A/WfpONP263ZVak2MUv5WDMMixRRikDrwP2TqOp8
 mjDw==
X-Gm-Message-State: AOJu0YwNxZNjcdwdOkklWpGdfDVFbwgoG0DjfjQoc5QblIz67N6RKO2q
 tM9u3lX6Cn5AsgObawZNLGGwlDC9p63njLmRoaw7cX31+iHRoLRFZE67QyUqfGL1o++FSJAR8EV
 Ov9SNBMwq/oc/13TJAkQ1u5gvIDR1+QEgdY83UwZH38MHVuO1AgP8kk8rRlt+WEkcmXiY
X-Received: by 2002:adf:f546:0:b0:317:634c:46e9 with SMTP id
 j6-20020adff546000000b00317634c46e9mr3908353wrp.43.1696477351812; 
 Wed, 04 Oct 2023 20:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFsJQquQ+V5syOPO0SSiz4lL198OwfkGojX68SrafA6ntH9Ta6NOiTqkdxT6NSG/iXu65jJA==
X-Received: by 2002:adf:f546:0:b0:317:634c:46e9 with SMTP id
 j6-20020adff546000000b00317634c46e9mr3908343wrp.43.1696477351504; 
 Wed, 04 Oct 2023 20:42:31 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 e13-20020a5d500d000000b003259b068ba6sm634352wrt.7.2023.10.04.20.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:42:30 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:42:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 02/53] hw/virtio: Propagate page_mask to
 vhost_vdpa_listener_skipped_section()
Message-ID: <961d60e934e793a6065fb17d2312d5bced25031e.1696477105.git.mst@redhat.com>
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


