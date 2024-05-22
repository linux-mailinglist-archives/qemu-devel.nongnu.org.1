Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7008CC54A
	for <lists+qemu-devel@lfdr.de>; Wed, 22 May 2024 19:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pLO-0000UG-Hv; Wed, 22 May 2024 13:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLL-0000St-8j
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLC-0006HP-0T
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716397285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d6An/0arX6uyYzYZ5CvpGfu7Aty966JfOgx/O3OFYOw=;
 b=JEJX4HaqL+OYj3ifiQfxVBvJzXFOQ3+6l+EoQa4t3dY/EXKPK8XwpBBqo5IgSuN6RkrbSS
 evlU7x/rgs9mGHqCTv41vItSyoKXiaLE6GOOn4jVhb7qR/vrfkbIYtd/R/75i1adkZ6amP
 mKH6bVSxdbpBsDYysdtq+pmBv/qbO0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-HKe4mZzGOt-RDRzk4WRGLA-1; Wed, 22 May 2024 13:01:22 -0400
X-MC-Unique: HKe4mZzGOt-RDRzk4WRGLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF0B68058D4;
 Wed, 22 May 2024 17:01:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85343561A;
 Wed, 22 May 2024 17:01:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 7/7] vfio/{ap,
 ccw}: Use warn_report_err() for IRQ notifier registration errors
Date: Wed, 22 May 2024 19:01:07 +0200
Message-ID: <20240522170107.289532-8-clg@redhat.com>
In-Reply-To: <20240522170107.289532-1-clg@redhat.com>
References: <20240522170107.289532-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

vfio_ccw_register_irq_notifier() and vfio_ap_register_irq_notifier()
errors are currently reported using error_report_err(). Since they are
not considered as failing conditions, using warn_report_err() is more
appropriate.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c  | 2 +-
 hw/vfio/ccw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index c12531a7886a2fe87598be0861fba5923bd2c206..0c4354e3e70169ec072e16da0919936647d1d351 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -172,7 +172,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
          */
-        error_report_err(err);
+        warn_report_err(err);
     }
 
     return;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 36f2677a448c5e31523dcc3de7d973ec70e4a13c..1f8e1272c7555cd0a770481d1ae92988f6e2e62e 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -616,7 +616,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
          */
-        error_report_err(err);
+        warn_report_err(err);
     }
 
     return;
-- 
2.45.1


