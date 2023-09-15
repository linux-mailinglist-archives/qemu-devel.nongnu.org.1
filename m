Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F10947A2451
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCJF-00077O-Dn; Fri, 15 Sep 2023 13:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhCJD-00076L-Og
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhCJC-0001nV-FP
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694797725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bON1w5PA3ln6pLbIGRUYpGI1D/HYvjSUJSjiXHbZkfo=;
 b=cZzaX01WAmyOIUF2YqoOKOen/uP0u4c7iC7nGUdXo7CSuk2rC/Wa9TU1uaF6QbF8wWxYbT
 Ga6vpbU3S3N0rYjKC3zpo9+3ISjKrPaMsa6ADxyMkkzTe7GoQFD6XnqunBGugLQ+iUkP+X
 wr30DINgG0DKXpDa7btxZf8Bmum+0kg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-691-HqFxPBZXPEGiGecgX9KjuQ-1; Fri, 15 Sep 2023 13:08:41 -0400
X-MC-Unique: HqFxPBZXPEGiGecgX9KjuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02258945938;
 Fri, 15 Sep 2023 17:08:41 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B573C2026D4B;
 Fri, 15 Sep 2023 17:08:39 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hawkins Jiawei <yin31149@gmail.com>, qemu-stable@nongnu.org,
 si-wei.liu@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 1/3] vdpa net: fix error message setting virtio status
Date: Fri, 15 Sep 2023 19:08:34 +0200
Message-Id: <20230915170836.3078172-2-eperezma@redhat.com>
In-Reply-To: <20230915170836.3078172-1-eperezma@redhat.com>
References: <20230915170836.3078172-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It incorrectly prints "error setting features", probably because a copy
paste miss.

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 34202ca009..9845e2db9c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1293,7 +1293,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
 
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
     if (unlikely(r)) {
-        error_setg_errno(errp, -r, "Cannot set device features");
+        error_setg_errno(errp, -r, "Cannot set status");
         goto out;
     }
 
-- 
2.39.3


