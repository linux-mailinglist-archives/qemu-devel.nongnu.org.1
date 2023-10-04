Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1647B7ADD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxY3-00036Y-PK; Wed, 04 Oct 2023 04:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWo-0000X3-8I
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWf-0002Y5-N5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+2AkEDFAeUGwi9xAK78UKYezxVoHbtT5EOiRdYvUo8=;
 b=OUmxw6l6aOuuDJ5xzJYQvrdytMZ62r6swS7oUQadm8flScFjv80d95cujDCYt/PUVF7WmW
 LxJ5GV190XhW2VJhcMjXcf3TzaDfSwpUVg5OYERZoMWGeQEoiUkN3+FTxgqPMyNeV7csIi
 eR2PtvXCIyhOtKiqG95/B4quRPokkag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546--dVpBUf4PW6se-EkEHh4RQ-1; Wed, 04 Oct 2023 04:46:17 -0400
X-MC-Unique: -dVpBUf4PW6se-EkEHh4RQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so13529555e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409175; x=1697013975;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+2AkEDFAeUGwi9xAK78UKYezxVoHbtT5EOiRdYvUo8=;
 b=W6ztXHQDICTu43eDVHhe9SdxHkTAXUblvg/pD2xxX2uNAfmzZPf76sjGvc+tqdFX6B
 nxFC2Drmu26lfwKF0hs0s+R8hgO0+gFS5PoOrDl+U+pbQUUkFf7aunyli5+3I5/000l+
 YcBOc411ErmLd2RvYIV7Q5OauS4gBoW9NSNQI0EKJgSjxga7+n3zNISqmG6WpiAN86Y6
 E6arJ6qR9aEOgQn0v10JpqQEXjLKzs6XCcB3zda5c4h7VstHsb7MH46Afe53C0DZelXZ
 gDoAfe9l7nTSjz3khyaca+hHyZtcsIjnolsYtoTDHz0B0E0W+8ti1RqLU9CGud+hDnHJ
 Iw8Q==
X-Gm-Message-State: AOJu0Yw1z7FAEs9j1rXHJCBlIwGDuVX+yabR370ELmYopNjzEPFai8Pa
 MJDmIO92Kbb5byWPCpcgwvRM629JWEgD9XDNSZsD1dBfdkAC5lkD7CFGIuF2J9WebrSBlpnUo1W
 X464KYTuSTT+Fg6PpbNsWs8JGSa1QiVbFWn+/MZpmbDg50d8eBusLDREJNf1glcedr9MN
X-Received: by 2002:a1c:f710:0:b0:404:746e:c601 with SMTP id
 v16-20020a1cf710000000b00404746ec601mr1456955wmh.9.1696409175252; 
 Wed, 04 Oct 2023 01:46:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElZuTU/jh4AqyPDwYm/2wp0AJxG7XvEvIFMd7rP5k3h4SE02T/GO5D/a/6WU+Vs8lJIfohEQ==
X-Received: by 2002:a1c:f710:0:b0:404:746e:c601 with SMTP id
 v16-20020a1cf710000000b00404746ec601mr1456935wmh.9.1696409174822; 
 Wed, 04 Oct 2023 01:46:14 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 u10-20020a05600c210a00b004063c9f68f2sm938651wml.26.2023.10.04.01.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:46:14 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:46:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 57/63] virtio: use shadow_avail_idx while checking number of
 heads
Message-ID: <99eb1f8a5d8f2a58479141a6155bbc786df05720.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


