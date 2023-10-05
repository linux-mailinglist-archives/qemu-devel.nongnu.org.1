Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A27B9A77
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFMQ-0008LT-WF; Wed, 04 Oct 2023 23:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFMJ-0007MC-Rx
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFMH-0001Pp-MD
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmbr6Yy0aSGhAeUFXnJnhooAueC1pSdc2KnGldQB5w4=;
 b=eO9d6D1RWSyolLo+qLeZRQEODlplkxCmiz546vgDrUuHzFe/8tLpNfMBFd+49sQlrar+aA
 15XfFlFY1spHrnT3SVJuvefc7JFwczj4xpmTACGQDumpSmiJI+WgyjgvAJSCew/ud/LrRa
 vmb2Azbb0QQRquQ1RCNnIdHn48i57sE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-1NM9B4DOO9-TGfKwglP-WQ-1; Wed, 04 Oct 2023 23:45:48 -0400
X-MC-Unique: 1NM9B4DOO9-TGfKwglP-WQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso464260f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477547; x=1697082347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmbr6Yy0aSGhAeUFXnJnhooAueC1pSdc2KnGldQB5w4=;
 b=dfh7eiRcOc8FyTfx7fT0iFhYLcNOdCVs7xgmUWajKpXMDoGRaaYrKDAW7nwqsiUsP/
 0fTsBrT9d0dsroCkMR8FKV6oqChTOdq+h+QwZkvXIjjVe4MewMP+wQeuLnbUie3Cymmi
 QMbcc+8SyeCCzT13jGiJBywekc/x7R0fp83jVJ+lVXGF8RZvalMWi2UGEUL4t8k4EWuS
 XLkoMNm8f3AHtfoezwiFnMcVpUUtIBRyIIE4t2qnc47q+w8vg9rJQbqmxk7oHLn5pwsG
 vqbuPJ/CipoG0amnr8sZGLD+HMVmz+89r8j9hvH5DKHX4T9PfVi+Sc2WCz5RjrxF3Va9
 S5IA==
X-Gm-Message-State: AOJu0Yw9n6sJRRhg5q6bKCyY20/fGq5KXvFPHkHz+CnbqE16yjut9P4t
 PFq2W5dU7iJ47Zu6YVMjOA2nLu9qutMzgaRcW8bcrAJzq99Z5PrwfpnHvAw5ly2Oe+KzYicg4IK
 jtup3ah5ypzFgihLJ6SOEDu/2E7oMmyUAmIZCls5H24BE9kpoPdfwU4SB8nUTiM0CE8kV
X-Received: by 2002:a5d:664a:0:b0:31f:f91c:d872 with SMTP id
 f10-20020a5d664a000000b0031ff91cd872mr4366733wrw.19.1696477547032; 
 Wed, 04 Oct 2023 20:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKR4+rGqD99tX0YIdLp8cA1/oUBQ/oFy50etu9i43M+/QwMCPL1uK4dAlBF26WaofK/Vn7ew==
X-Received: by 2002:a5d:664a:0:b0:31f:f91c:d872 with SMTP id
 f10-20020a5d664a000000b0031ff91cd872mr4366724wrw.19.1696477546814; 
 Wed, 04 Oct 2023 20:45:46 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c044a00b004063c9f68f2sm538641wmb.26.2023.10.04.20.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:46 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 49/53] virtio: remove unused next argument from
 virtqueue_split_read_next_desc()
Message-ID: <70f88436aa5a8aeddd33e4d06270146af5d5bb52.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Ilya Maximets <i.maximets@ovn.org>

The 'next' was converted from a local variable to an output parameter
in commit:
  412e0e81b174 ("virtio: handle virtqueue_read_next_desc() errors")

But all the actual uses of the 'i/next' as an output were removed a few
months prior in commit:
  aa570d6fb6bd ("virtio: combine the read of a descriptor")

Remove the unused argument to simplify the code.

Also, adding a comment to the function to describe what it is actually
doing, as it is not obvious that the 'desc' is both an input and an
output argument.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Message-Id: <20230927140016.2317404-3-i.maximets@ovn.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 87e8f990c5..6facd64fbc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1049,9 +1049,10 @@ enum {
     VIRTQUEUE_READ_DESC_MORE = 1,   /* more buffers in chain */
 };
 
+/* Reads the 'desc->next' descriptor into '*desc'. */
 static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
                                           MemoryRegionCache *desc_cache,
-                                          unsigned int max, unsigned int *next)
+                                          unsigned int max)
 {
     /* If this descriptor says it doesn't chain, we're done. */
     if (!(desc->flags & VRING_DESC_F_NEXT)) {
@@ -1059,14 +1060,12 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
     }
 
     /* Check they're not leading us off end of descriptors. */
-    *next = desc->next;
-
-    if (*next >= max) {
-        virtio_error(vdev, "Desc next is %u", *next);
+    if (desc->next >= max) {
+        virtio_error(vdev, "Desc next is %u", desc->next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-    vring_split_desc_read(vdev, desc, desc_cache, *next);
+    vring_split_desc_read(vdev, desc, desc_cache, desc->next);
     return VIRTQUEUE_READ_DESC_MORE;
 }
 
@@ -1146,7 +1145,7 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
                 goto done;
             }
 
-            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max, &i);
+            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -1601,7 +1600,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
 
-        rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max, &i);
+        rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -4055,8 +4054,7 @@ VirtioQueueElement *qmp_x_query_virtio_queue_element(const char *path,
             list = node;
 
             ndescs++;
-            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache,
-                                                max, &i);
+            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
         element->descs = list;
 done:
-- 
MST


