Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8B8010ED
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:16:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977S-00037o-48; Fri, 01 Dec 2023 12:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977F-0002vU-1H
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977D-0007mH-1G
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1JMOyu2nTSDqoh4LCBRYQLr+2pQDRCpjv4f4k1WD7I=;
 b=FUs5PpJbL/lFbebA9MNa/d4QwnODtoZxuHB1KeNNfdblL0cm8Aw3d0NyJmx4pheYKI8Kbf
 lw9b1gMSQpNTGeIW6mUmlqjg2InMIIbMJSoijfktqUVVU3+OVAymZkCQt2XjTMQA5F6gBu
 d173bqVgs9kVFVXci1cDw4PJJxALpmU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-bGV302caOYqMmumOAwUbTA-1; Fri, 01 Dec 2023 12:15:43 -0500
X-MC-Unique: bGV302caOYqMmumOAwUbTA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40b5482879cso19266655e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450941; x=1702055741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1JMOyu2nTSDqoh4LCBRYQLr+2pQDRCpjv4f4k1WD7I=;
 b=ZT1GjptMe/8jAERitd3tvVwhya2VjFT+rMGA6NELlDvAOv3RQW3NZWJpyx93g5Hdsd
 0u9Jgzh3aTeTFlgY/icqC2zLQSZ3DNO3DoeeaaZxNRJP3PMNRM84zeHeEWmwtxaGpZw2
 5K1hqZzpi5P7qMIp3AmGF9rTHDDITg7uv1e7PFCtUpUzcRAFDG2Py4ciw99FMjuxjJiw
 C0S8A9QK8JGvU3nIfuZdK4u6M2+Vmw66p+4hYV+miB6PsYzYTWN3VVTXh6qFDO5ZQ+nR
 9wGClTmz1QYJHJliTMecyCO/KeTMk0nyeDpDJ53YRDuHGWIAhvQRaF9LgxVimUTlfL/i
 t11w==
X-Gm-Message-State: AOJu0YxAevgeYKO4Zntv7R2qMwlL7wZQZbPbuVeNDJaKcjFIPTcZISep
 4vTXIN1Qwo53mzN/SY3Eq2j2lbojh2+hcsjOAQc4hJbogHFInWW5D/bm0aKqBM2gmbN4HjyaGuw
 zf7cHYjfJ3RSuT3h3AdVtD7MC9cPhCU60LgtdixqUrIIfR72WJz07dVE8sBO/EM9RKsDn
X-Received: by 2002:a05:600c:4ec8:b0:40b:5e4a:2347 with SMTP id
 g8-20020a05600c4ec800b0040b5e4a2347mr863555wmq.73.1701450941355; 
 Fri, 01 Dec 2023 09:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBVeKqZaDS0Tuvk4V63o6BSfAwFyjV8aMvhmkVTesM+TNPi9AzShGDVBPDDZi1+dgfes5EKA==
X-Received: by 2002:a05:600c:4ec8:b0:40b:5e4a:2347 with SMTP id
 g8-20020a05600c4ec800b0040b5e4a2347mr863549wmq.73.1701450941043; 
 Fri, 01 Dec 2023 09:15:41 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a05600c4f8a00b0040b4b2a15ebsm5953424wmq.28.2023.12.01.09.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:40 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 12/15] virtio-iommu: Remove useless !sdev check in
 virtio_iommu_probe()
Message-ID: <d7babe2f892ddd555503cf846ac82a7752ffa78b.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

The code already checks iommu_mr is not NULL so there is no
need to check container_of() is not NULL. Remove the check.

Fixes: CID 1523901
Fixes: 09b4c3d6a2 ("virtio-iommu: Record whether a probe request has
been issued")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Coverity (CID 1523901)
Message-Id: <20231109170715.259520-1-eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 89fb5767d1..9d463efc52 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -698,9 +698,6 @@ static int virtio_iommu_probe(VirtIOIOMMU *s,
     }
 
     sdev = container_of(iommu_mr, IOMMUDevice, iommu_mr);
-    if (!sdev) {
-        return -EINVAL;
-    }
 
     count = virtio_iommu_fill_resv_mem_prop(sdev, ep_id, buf, free);
     if (count < 0) {
-- 
MST


