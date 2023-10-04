Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 191557B7A94
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxTp-0002Nn-PZ; Wed, 04 Oct 2023 04:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTj-0002Gx-Jv
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTi-0000uZ-3N
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NW2NOMzgBdCNK5ZXMj4UrgviAiZWrBVJEYGFoltgO4I=;
 b=QA2Eu4CDBGQf94I+3GjtjkKIhJsk9zQOQxsu8O+aiRWPi9UKB5Ywn8FumMSV+n38kztjwz
 9WLEvHtJV+beKE/gZXApeSMR1F2BerFAr9Rhf66IeD3+SX4NOvuwlh1sHa4MG97JJEFxDF
 JxXZzStozYyuYouwNhX4tckvmahPA6M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-BPlVbzWpN3q9JfYcgFYjdA-1; Wed, 04 Oct 2023 04:43:31 -0400
X-MC-Unique: BPlVbzWpN3q9JfYcgFYjdA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-323306960e3so1345460f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409010; x=1697013810;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NW2NOMzgBdCNK5ZXMj4UrgviAiZWrBVJEYGFoltgO4I=;
 b=W7/RqWXR4mZkB05uIBGsmVjkTE32ZvjANy6NlbZ7wR5+w+HwaO4CEd9gzMoiJhSu/r
 Nq9Z4wxCUnuEOx7ds1OK1Yyo3w9w1i8QqQK1uT73/aPN0DlHZ1aRa1LVr+JZ2RbEz5lX
 d179GX6CP6YxISDf3l8+5y52yB08OJFu5KbU1T1yloMWJabqSjjDG7DhQBibWovXb8YG
 GkJxidJmmntHGIn2TCv5eLtFbHH3RVIUyYmj5RCUavjXi8sUcjokd/duDzQM7ZA58vvt
 Vm5LoJ1YyAurlQx8OUXeTJasMvRaFASEhxTTUazNO0XFaNcoKHxRSrvfeQiCAv2C9ECM
 ZhVA==
X-Gm-Message-State: AOJu0Yz83dsamD76yhGhPBvwnREvU084f2irG32e5RdU9X/BjYNB9LEK
 SejU06KtdQHge0ywmvjNb3/9ZNhNkqSHRr4lGVIK/bl0MQjN6iObewKDONQIplXmR5Ah3arTfyT
 79m4PNyv7OQ8Ty7gg2rX7uHsD6kNuLaDFY7YCiSz31yl8jqPlq7ykTXMSZ6B9boaLwrkZ
X-Received: by 2002:adf:f2d2:0:b0:321:6953:6ad6 with SMTP id
 d18-20020adff2d2000000b0032169536ad6mr1315527wrp.16.1696409009821; 
 Wed, 04 Oct 2023 01:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6OEhkAEg9tNSdvrpfOZsQz44LcohqHQmPktLMGUaZ1qFRDrGji2XhePOtoHKVXiSIXEY3/g==
X-Received: by 2002:adf:f2d2:0:b0:321:6953:6ad6 with SMTP id
 d18-20020adff2d2000000b0032169536ad6mr1315515wrp.16.1696409009552; 
 Wed, 04 Oct 2023 01:43:29 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 f16-20020adff590000000b0032326908972sm3441158wro.17.2023.10.04.01.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:28 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 06/63] hw/virtio: Build vhost-vdpa.o once
Message-ID: <3b8527dd1aa75330f3d7f937b828e75ebc66075b.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

The previous commit removed the dependencies on the
target-specific TARGET_PAGE_FOO macros. We can now
move vhost-vdpa.c to the 'softmmu_virtio_ss' source
set to build it once for all our targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710100432.84819-1-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 13e7c6c272..9737450afd 100644
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
MST


