Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 777007B7ACA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxYP-0003yG-Ra; Wed, 04 Oct 2023 04:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWt-0000hz-Ql
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWs-0002hI-6b
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmbr6Yy0aSGhAeUFXnJnhooAueC1pSdc2KnGldQB5w4=;
 b=dWGkSLJAy+YXoz33RFf/PryRvSRZ/Anon+1vN6Xl30rPBxnXatQuPcUZPi06fs+VSfyT18
 lKM+RETk7DrRQfxGhTGXdTX8QsuVK5ad5x54lOPDtHrRQ8SNMhLUb/MsBLWXVHbGiZRSy1
 7pYPlIcBMoyWm0Z6oJ90N2p7cYm5Yhs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-U_nmHhQMO_ClA8q-LZMGOQ-1; Wed, 04 Oct 2023 04:46:48 -0400
X-MC-Unique: U_nmHhQMO_ClA8q-LZMGOQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso14570685e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409207; x=1697014007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmbr6Yy0aSGhAeUFXnJnhooAueC1pSdc2KnGldQB5w4=;
 b=e0w79Qt527RGMXlmkw9ExioBQzb77/f3XZzphpK56ovjcWNCDhs9j1iHF4OeuLZIkI
 tYotoiM4h9+iKBIde2EEBrMW7E1FZLn8Ms+rkqmXoBE+9Jf6250a2f++qdCxOiLHnVY7
 PbgEfz9RLeqj4WFeIx9S98kCNpGzM3cgV6A02cJw7b8sEUvXKh+5+Q9VzpKMXMuqujey
 yE1gYD8dGRBdxzbpQt+CDijZUrpaqlhGamtuZV33cr2FdMxt9KLNC+DKrz6MPx5tEaVU
 KMQlRoDOFszzNJ/TDkgdn7BO1Qo7lICWWMspr9RDyXCcztW4ZUXV50rsRnOeCe0lCDDX
 BySg==
X-Gm-Message-State: AOJu0YxF1K5zBVjH8OGGxXMGKai6MrJdBdWtbo5u99LYi8kRGp1XXdP8
 UGkxqpWSpFxZuAqby5l4U45wNeHXOfVOppodfZMztACg7yKJnhE5+ytIidUwLCBZcM3YSKYSmMW
 pJgWAcipVVOOlwlzHuE5zwK+CW062qgvDxsisesucE8Qn/tyBBlv1hjnKRzZzid4D3XVs
X-Received: by 2002:a1c:7c04:0:b0:406:5b73:b6f9 with SMTP id
 x4-20020a1c7c04000000b004065b73b6f9mr1698075wmc.35.1696409206201; 
 Wed, 04 Oct 2023 01:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJHcaByy/RGYk+AEdnBiD7uj37VE+BX0M2sKTn1llcF3kflJh+qDR+7Ld0MVNNaXb5AmaR7w==
X-Received: by 2002:a5d:494f:0:b0:31a:d266:3d62 with SMTP id
 r15-20020a5d494f000000b0031ad2663d62mr1485623wrs.54.1696409181248; 
 Wed, 04 Oct 2023 01:46:21 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 f14-20020adff44e000000b0032318649b21sm3469604wrp.31.2023.10.04.01.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:46:20 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:46:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 59/63] virtio: remove unused next argument from
 virtqueue_split_read_next_desc()
Message-ID: <e3bf9117bbe9789aee5f841f87d6afdaf8fb6afe.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


