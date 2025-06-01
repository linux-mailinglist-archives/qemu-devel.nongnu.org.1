Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00228AC9F2B
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Jun 2025 17:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkjO-0004Tu-Ai; Sun, 01 Jun 2025 11:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkjA-0004I5-S0
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkiv-0005bm-2Q
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748792138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKEH6Z9JCQimLJL8lPwV9KIkJSWOuDTn31SzP3o0in0=;
 b=glS9+XTQkat2uzwCtLf0Vna8AA/r0QMl9cOiPQzB66efpVEFrmzgVwv/GW9Q66yDwAjTVn
 BVT8tbBheL1SUtS1EH2+VHt8A1AX53HhQIlGgGrAeIOcmbVdLPz03ocBh9txyc84tNE3Ul
 qMgONcDmLPQpVEiGknewsEF2fAI5XTs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-TB5h96x0MiWmahhCZMJlpA-1; Sun, 01 Jun 2025 11:35:37 -0400
X-MC-Unique: TB5h96x0MiWmahhCZMJlpA-1
X-Mimecast-MFC-AGG-ID: TB5h96x0MiWmahhCZMJlpA_1748792136
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-55324bc26dcso1698209e87.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748792136; x=1749396936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKEH6Z9JCQimLJL8lPwV9KIkJSWOuDTn31SzP3o0in0=;
 b=fTx8uHw+2zDcJSwEd8ZEaBxcU2Y1lusMmgZyy7kXnrsdiqQfIsQj6a/32k41buu38M
 sRKXO4K7IamUyQ52G76bZfWuPeSrNtzIOWUeXryAf7vHYqU5hsgqFLPlg1JcPfZ3udhc
 VEvMUsuXlz3omj+xtk8Rh32KTyavECg1ib5t1idVg1OkhzdQlwn+RTIt4wAdUG6afMcE
 Zp6xhOSxVNQ5U9YeHq+5IwxiHzqRdunErpU7qeEDNv4iGQswzDrUHZKyhDh87BE7fXvC
 P/hy8b4y+Lget73MxMj+/ZDSJcNe217fr2vf/UX9aWwaRCilqaaLvBaK3fch9Y3Oc4Ud
 HTIQ==
X-Gm-Message-State: AOJu0Yz5C5iuUucgoJ0uOvVhJNzjq7YnKORQRI4dlZqFC0MlD3lW0Q6t
 8F0IQyifU/XGBhLa60XzpFv2tZ/p4e+tnmJo7In+ryEBgJbZ5fZ5MdgABE9shZ7A369Jd5Q8GNI
 XMh3bR6v3k+LSvrqyjc/aYTE0xc6ski8bYFBYel75W2qo2X4PnlFl+ef+2sgQQwMWGGAn85qe8U
 26ZZQMouLuB0skFLzvb43mDB2Jq+sDmQViQA==
X-Gm-Gg: ASbGncvx1Jdy/hKfh56YvUJGkMD5Jm3IrdBD2QwEr9n8sPadGau0vFe+J3yst8opl0i
 N2GzNsjtn4AUKvwWqJNWo4XmSRzLT2Nr98vHdacpzvhef+nQaFNafco6TCOw/nLDCH3kyevt/Dm
 8nCx57+gGx88sY1Sownos63m0NoIj0ysTktRLUAij2cL0SVRlP4Wx3kHubaZmrF4hfAz/HPBm9c
 DToRsAcoUkQUg7rALldbdGDBCZxWfIBs6qTqo5BRVbDwt9Nhy7Pb89um4lfLSZtUtSSm6Bv5KGX
 Nx4L3D41kBR/sqmn
X-Received: by 2002:a05:600c:3f92:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-450d6b5999bmr95833935e9.6.1748791487749; 
 Sun, 01 Jun 2025 08:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmKWDFQhl1SCz6HHk2dYVS/WFA74r7SfcWFfZWGmgNxihnFEFlOEzISUoCOe0f5IwNy5AWvw==
X-Received: by 2002:a05:600c:3f92:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-450d6b5999bmr95833705e9.6.1748791487265; 
 Sun, 01 Jun 2025 08:24:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b89dsm11909055f8f.19.2025.06.01.08.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:24:46 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:24:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PULL 01/31] virtio: check for validity of indirect descriptors
Message-ID: <ac8fc4ccacd8a77d8d56dc3990bfb221c1f48fcd.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Yuri Benditovich <yuri.benditovich@daynix.com>

virtio processes indirect descriptors even if the respected
feature VIRTIO_RING_F_INDIRECT_DESC was not negotiated.
If qemu is used with reduced set of features to emulate the
hardware device that does not support indirect descriptors,
the will probably trigger problematic flows on the hardware
setup but do not reveal the  mistake on qemu.
Add LOG_GUEST_ERROR for such case. This will issue logs with
'-d guest_errors' in the command line

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20250515063237.808293-1-yuri.benditovich@daynix.com>
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/virtio/virtio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2e98cecf64..5534251e01 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -205,6 +205,15 @@ static const char *virtio_id_to_name(uint16_t device_id)
     return name;
 }
 
+static void virtio_check_indirect_feature(VirtIODevice *vdev)
+{
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Device %s: indirect_desc was not negotiated!\n",
+                      vdev->name);
+    }
+}
+
 /* Called within call_rcu().  */
 static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
 {
@@ -1733,6 +1742,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
+        virtio_check_indirect_feature(vdev);
 
         /* loop over the indirect descriptor table */
         len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
@@ -1870,6 +1880,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
+        virtio_check_indirect_feature(vdev);
 
         /* loop over the indirect descriptor table */
         len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
-- 
MST


