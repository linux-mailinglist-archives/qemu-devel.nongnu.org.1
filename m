Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515D785715
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:49:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJN-0001Wq-Hn; Wed, 23 Aug 2023 07:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJK-0001V9-Mh
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJH-0001U2-4P
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjR5bu7zj9PvPOnk1lPS9Xpd0n5telhvG0HDeL5s1OM=;
 b=SZM4VvJB8hltSht+cWMUWGmG77auqtk6rqbz10mIVYIyt6H6WJn5SMJBJsvvzxuPbA46ed
 IebnZuyJWF6lMojmX1Ec6jOrgIzZ47KlbsgpdFDIUDGcCBN6n1ObDzXkFrgOWeNXznOchH
 n0mmvgh/a3WhkFp6jTinj3W4nnFopF4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-Mt-rwB2pNrmIhe5jRuP1XA-1; Wed, 23 Aug 2023 07:46:00 -0400
X-MC-Unique: Mt-rwB2pNrmIhe5jRuP1XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 272DF380670D
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 11:46:00 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 447B5C15E7F;
 Wed, 23 Aug 2023 11:45:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 09/12] include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob
 on big endian hosts
Date: Wed, 23 Aug 2023 13:45:41 +0200
Message-Id: <20230823114544.216520-10-thuth@redhat.com>
In-Reply-To: <20230823114544.216520-1-thuth@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Using "-device virtio-gpu,blob=true" currently does not work on big
endian hosts (like s390x). The guest kernel prints an error message
like:

 [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x10c)

and the display stays black. When running QEMU with "-d guest_errors",
it shows an error message like this:

 virtio_gpu_create_mapping_iov: nr_entries is too big (83886080 > 16384)

which indicates that this value has not been properly byte-swapped.
And indeed, the virtio_gpu_create_blob_bswap() function (that should
swap the fields in the related structure) fails to swap some of the
entries. After correctly swapping all missing values here, too, the
virtio-gpu device is now also working with blob=true on s390x hosts.

Fixes: e0933d91b1 ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2230469
Message-Id: <20230815122007.928049-1-thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/virtio/virtio-gpu-bswap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/virtio-gpu-bswap.h
index 9124108485..637a0585d0 100644
--- a/include/hw/virtio/virtio-gpu-bswap.h
+++ b/include/hw/virtio/virtio-gpu-bswap.h
@@ -63,7 +63,10 @@ virtio_gpu_create_blob_bswap(struct virtio_gpu_resource_create_blob *cblob)
 {
     virtio_gpu_ctrl_hdr_bswap(&cblob->hdr);
     le32_to_cpus(&cblob->resource_id);
+    le32_to_cpus(&cblob->blob_mem);
     le32_to_cpus(&cblob->blob_flags);
+    le32_to_cpus(&cblob->nr_entries);
+    le64_to_cpus(&cblob->blob_id);
     le64_to_cpus(&cblob->size);
 }
 
-- 
2.39.3


