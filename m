Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F17B9A43
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGG-0001D8-J1; Wed, 04 Oct 2023 23:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGE-0001Ch-2f
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGC-0007yd-MJ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3XainUJVMKa+Hs4fQFDx+vYokCoMuU5n+RMYZYnWdU=;
 b=CnO5siIQZFD+l3pBY2kYJBrw5BLyKycwGg8iqsuUSClU0/Dy06FWIPxfunb6NS6Ry/FTWY
 Q4qNBWePpHoNoewKUOio84F/dsWOfTaCzz98YKaiWm/oGZD7dOuXl2Z3+p2o4d7f+6jmXU
 +axfYsiUG/V683RXYubxCrWLenhAGdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-fnbvjn0bNjCYSit5ZEMirg-1; Wed, 04 Oct 2023 23:42:41 -0400
X-MC-Unique: fnbvjn0bNjCYSit5ZEMirg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso462436f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477359; x=1697082159;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3XainUJVMKa+Hs4fQFDx+vYokCoMuU5n+RMYZYnWdU=;
 b=cQr1rDJbS2idipLLdBLxlEDMOVycleCiN85IrcQJxIsV1ZNtlBtUtlA+PfMmeKIFvg
 9+g+WVWVY/CCFWxDtN1dwJ9zRZyXvcNoiQ4MBI31/mzlMpdXvMqWd0BFGV55J4kScSg7
 40/obFxetS1B3CmNceBeDCTrWQocq2XF9B5+ce4zv45/aXAbROnqqn/AyeInwR7YJNiG
 rgLuj21ZpjgMmCf25yrQ4qo6eGbgmZGsZpqRCYzKXoMQk5I61dzwA16W9W8rvEVVkTzj
 eYz40/xkAhIaLlY7Bv4TBE8j1cxo9AyW+G/URdzHk4S2WQ5sdxnXoK6v5Mq/nv3cHS+o
 5TWw==
X-Gm-Message-State: AOJu0YxvBLVoTU/T219lZ1bSd6e39b/bkJ76T8a2Ym9dm1O1EPrahLp6
 QzYLGJ01D0eN7/5GEwUedrECxe1w2GBSq9tX7B2O1SvkJOpiYA0ZJS6IOmMhCzEvA5rJ8feXQq8
 UVithWhfooJOqXenM5hNrYRgE2MpM1sSUf5JPaAlct57Z9tE+Xh1ynIKjSYnd+v6S/B3h
X-Received: by 2002:a5d:46cf:0:b0:31f:8e7c:6ebe with SMTP id
 g15-20020a5d46cf000000b0031f8e7c6ebemr3975115wrs.5.1696477359748; 
 Wed, 04 Oct 2023 20:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1KErItLpYI5ZGQJyQjJN7K6UQDBrD8SO6xnsj4FRVoDXkVEp4TU1JdldPrTmelJ1JszRtaQ==
X-Received: by 2002:a5d:46cf:0:b0:31f:8e7c:6ebe with SMTP id
 g15-20020a5d46cf000000b0031f8e7c6ebemr3975103wrs.5.1696477359540; 
 Wed, 04 Oct 2023 20:42:39 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 v2-20020a5d4b02000000b00326028b4dd5sm621110wrq.113.2023.10.04.20.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:42:38 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:42:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 04/53] hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
Message-ID: <1dca36fb3d4f07354c9f6bc38b6e5c72fe1e9855.1696477105.git.mst@redhat.com>
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

Use TARGET_PAGE_SIZE to calculate TARGET_PAGE_ALIGN
(see the rationale in previous commits).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710094931.84402-4-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3ab0dc0b5b..0e0ed6d7ac 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -331,7 +331,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
     llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
@@ -415,7 +415,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         return;
     }
 
-    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
     llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
-- 
MST


