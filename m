Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 932287B7ABA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXQ-0001Ji-4T; Wed, 04 Oct 2023 04:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWD-0008QT-IQ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxW7-0002Pz-Cr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fi0K9Am3IfJincw8VDTgn5xt0/GGjlt5fWIa13TNowA=;
 b=JNhp70IPlKBPN2X4qb+yafRDosq/mM9UcW1Aj1G0YsKY6r7jKV62mnTGka3FBMi1VTlOl9
 giNyay9My6nWIVSc7AhUh8zWum+mD8NGj7jnhNBfr4aQBHoT8kFyuvFy4fqCl4/c3fOAhG
 6072LJQDn7to7O33+O8yzHXPUCSRRQM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-bFZdRxTrO_CxgXi0tROAHA-1; Wed, 04 Oct 2023 04:45:55 -0400
X-MC-Unique: bFZdRxTrO_CxgXi0tROAHA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32320b9d671so1465887f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409153; x=1697013953;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fi0K9Am3IfJincw8VDTgn5xt0/GGjlt5fWIa13TNowA=;
 b=HeVgarF6d96FQ91S1cnrKOxEl/GGvvYQGWCwq84rBv16xEUpoKYfq6uxMqXG0G0KW5
 yiwSQ3K50Y8BcwW/hBCG9KirzVfgare++6oNM+glyvF+itC/sOyER5WCq5tUEbbOPu4W
 qcByIvjO6aRKYMlGoSz7pIEoV1e8DJ2HXkIQakIBfariigGedXXRnj0oa4EtT+FoDehX
 Bi+j6ph2IcqHYKcjhxB0PJMaq3XAvbpUJY2mfBirE56qmXLoliz17jPpmRXbU8Bm604I
 Axa1/cDvW2B9r2DHmGVymeS4ls7/m/RHDQKdW7XezNPyNRUpSu2YrwbPMsROADdnq+DU
 o4lQ==
X-Gm-Message-State: AOJu0YzQzY7OZvQ+dN24N8t+13LbJfTFt6lz/naKrGh7OLWB5ppihJTN
 r6zNBf94BPUV0/SdmzO4XsPkCxrYrzTqWRJY6IhRrK04TzngIxbtzivPK9ygqJGE2QIgVdVhniN
 NR0ZbabuQJkicxmN+6bcjjph9o8h5kFfJpLLLUYzgqAFoZEJ8uUSE+4ZESg5zaZ2WOm/X
X-Received: by 2002:a5d:60d1:0:b0:31f:d8ba:c997 with SMTP id
 x17-20020a5d60d1000000b0031fd8bac997mr1515489wrt.41.1696409153721; 
 Wed, 04 Oct 2023 01:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqBYfG1RTViHmBiZ3/PlNGYG/Cgx9xuFskgcR5+gldFH8yf5jV3atACG1RYu1OioOsXrz1Tw==
X-Received: by 2002:a5d:60d1:0:b0:31f:d8ba:c997 with SMTP id
 x17-20020a5d60d1000000b0031fd8bac997mr1515468wrt.41.1696409153425; 
 Wed, 04 Oct 2023 01:45:53 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 z17-20020a5d4d11000000b0032485046055sm3478494wrt.5.2023.10.04.01.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:52 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 50/63] vdpa net: fix error message setting virtio status
Message-ID: <181359e6cb42698753ec7dd1260b1c7a0b36a055.1696408966.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

It incorrectly prints "error setting features", probably because a copy
paste miss.

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230915170836.3078172-2-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index fe519d908d..650125bb0f 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1368,7 +1368,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
 
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
     if (unlikely(r)) {
-        error_setg_errno(errp, -r, "Cannot set device features");
+        error_setg_errno(errp, -r, "Cannot set status");
         goto out;
     }
 
-- 
MST


