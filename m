Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506F7A244F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCJG-00077r-Av; Fri, 15 Sep 2023 13:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhCJE-000773-KA
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhCJD-0001nc-5x
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694797726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6/TWVZNb46HVrJ7JdQHD8nhipsqo+5pDj4h5xUtPBk=;
 b=Moxc+VEil1oSAtf2A+8wfYFcWBMLcjwNIziZG6Da5CfmAnTShqom3vxnltz8gsseukF6TF
 l81S7ZOogwXqJAhwoj0KLGMwa7N6rbpC26nEIKEtFDWFwNvLjtfEVfp6arJ3EeKNyfgflN
 VzaxZDyKi6RNcIZu41bLaVMvpqNAc/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-u1WX9bciPJuqJlTPY5OlBQ-1; Fri, 15 Sep 2023 13:08:42 -0400
X-MC-Unique: u1WX9bciPJuqJlTPY5OlBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82D5494592A;
 Fri, 15 Sep 2023 17:08:42 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41BBD2026D4B;
 Fri, 15 Sep 2023 17:08:41 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hawkins Jiawei <yin31149@gmail.com>, qemu-stable@nongnu.org,
 si-wei.liu@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 2/3] vdpa net: stop probing if cannot set features
Date: Fri, 15 Sep 2023 19:08:35 +0200
Message-Id: <20230915170836.3078172-3-eperezma@redhat.com>
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

Otherwise it continues the CVQ isolation probing.

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9845e2db9c..51d8144070 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1289,6 +1289,7 @@ static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
     r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
     if (unlikely(r)) {
         error_setg_errno(errp, errno, "Cannot set features");
+        goto out;
     }
 
     r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
-- 
2.39.3


