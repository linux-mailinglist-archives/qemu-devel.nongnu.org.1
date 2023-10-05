Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9EE7B9A74
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJL-0000Se-Oo; Wed, 04 Oct 2023 23:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJ8-0008Tl-AA
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJ6-0000oM-OE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+2AkEDFAeUGwi9xAK78UKYezxVoHbtT5EOiRdYvUo8=;
 b=XY0lpGaPkb2f39JLVQyl+6E14DWW707iNnHJCQ5GKoyykrylKSBQwxfjmjPTvvnVv3950u
 /CgkFmsBjl6vClk6MRoSIuncT8B/HmRCLKuRGc0YmjEMZc0Y8Q30t2mhNQqgw9Ij3uGvrv
 AV8pCFRF97UF/yrwchzRhwgH6SQbw1g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-Gbxv-NMMNJWqBnjiUdOapQ-1; Wed, 04 Oct 2023 23:45:41 -0400
X-MC-Unique: Gbxv-NMMNJWqBnjiUdOapQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso464204f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477540; x=1697082340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+2AkEDFAeUGwi9xAK78UKYezxVoHbtT5EOiRdYvUo8=;
 b=cXdGPHSUKZ3YBG+INWsoa/gEJy2/UBaTkhEcS5MCb4oJaWIUSQclZY1lT4sZenkhKx
 eXrbIrCEuo9vd8JdFB2pCGaCph6w5DLUibKyW8f6qgqxQeLexyERI0mhNKYy1SSX3vGB
 Gip5JzGVRr1WcN96FauxZIrbMEwDEdQ7WL9xWY8fqNNom0B0Nkkv9LhP2VeNDmQj2ZcZ
 i0FDjAfxtgY5ysla0fQBiotFWu1pUHdJjhna1alCUirOSkx3qyauaQgBaiGFsp677TnN
 haRZPvf1zsYqWlQjsVx93FUdc2JOM+m+qQvG8MKkiSwCtlXkQ7IKRsn21jEzzlGkFTAo
 GfNQ==
X-Gm-Message-State: AOJu0YyrsIQ6/uRPPKcqqSf7o39urj15AWGGCP6XgyNp3C3rIkiN+fRM
 QIpmZQRGPkSwpEUR702X/aLr8T2X/40hoTqG6+Qrj4WmQIVkV5jwhA2vkfRkktdhb+QQxWXd7sD
 C43hCntZTjHih4dSgVYd4W9bzTnNlwX33sJzJza583VVw+NRaBeVHR23Mgdpv5ziwRdi3
X-Received: by 2002:a5d:5187:0:b0:31f:ec06:20f with SMTP id
 k7-20020a5d5187000000b0031fec06020fmr3882918wrv.14.1696477539945; 
 Wed, 04 Oct 2023 20:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiXsXwMge9QP3zHGQIqLRPaKSzw4qbrQk0IQz0ke4JOb7bJRlPPDEmXTSBfiKe75xvvda/KA==
X-Received: by 2002:a5d:5187:0:b0:31f:ec06:20f with SMTP id
 k7-20020a5d5187000000b0031fec06020fmr3882907wrv.14.1696477539733; 
 Wed, 04 Oct 2023 20:45:39 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 q8-20020a05600000c800b00324ae863ac1sm635727wrx.35.2023.10.04.20.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:39 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 47/53] virtio: use shadow_avail_idx while checking number
 of heads
Message-ID: <850cd20b072cd330cb24aa1c92732b9722998d40.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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

From: Ilya Maximets <i.maximets@ovn.org>

We do not need the most up to date number of heads, we only want to
know if there is at least one.

Use shadow variable as long as it is not equal to the last available
index checked.  This avoids expensive qatomic dereference of the
RCU-protected memory region cache as well as the memory access itself.

The change improves performance of the af-xdp network backend by 2-3%.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Message-Id: <20230927135157.2316982-1-i.maximets@ovn.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c727e9201b..2058b838e9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -997,7 +997,12 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
 /* Called within rcu_read_lock().  */
 static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
 {
-    uint16_t num_heads = vring_avail_idx(vq) - idx;
+    uint16_t avail_idx, num_heads;
+
+    /* Use shadow index whenever possible. */
+    avail_idx = (vq->shadow_avail_idx != idx) ? vq->shadow_avail_idx
+                                              : vring_avail_idx(vq);
+    num_heads = avail_idx - idx;
 
     /* Check it isn't doing very strange things with descriptor numbers. */
     if (num_heads > vq->vring.num) {
@@ -1005,8 +1010,15 @@ static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
                      idx, vq->shadow_avail_idx);
         return -EINVAL;
     }
-    /* On success, callers read a descriptor at vq->last_avail_idx.
-     * Make sure descriptor read does not bypass avail index read. */
+    /*
+     * On success, callers read a descriptor at vq->last_avail_idx.
+     * Make sure descriptor read does not bypass avail index read.
+     *
+     * This is necessary even if we are using a shadow index, since
+     * the shadow index could have been initialized by calling
+     * vring_avail_idx() outside of this function, i.e., by a guest
+     * memory read not accompanied by a barrier.
+     */
     if (num_heads) {
         smp_rmb();
     }
-- 
MST


