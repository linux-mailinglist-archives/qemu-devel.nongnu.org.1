Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03455A971FA
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 18:08:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G7Q-0001b9-Np; Tue, 22 Apr 2025 12:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6J-00083i-TV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6I-00058D-3O
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08RV1blFRaesv5PCa7AC1o8eJjnYpUcvTJueH1eeh0E=;
 b=OmL70UZBk+xMT/oV6losy0aejdefqE3K9nzTNYScxxNawzrSBIDBkECVDmYZaZir1pivnv
 JT8xPxrfTvkFtGLi3J1dtTPty4kdMymqTB0Hw2GqfaR9ibakZ2ucFnBN1t5FINfJ4j7qh/
 /W+C6skdqe2fsqdNn6b3vjBW41qkobA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-luNWR7ldO4OBYxxEkuHZ0Q-1; Tue,
 22 Apr 2025 12:03:52 -0400
X-MC-Unique: luNWR7ldO4OBYxxEkuHZ0Q-1
X-Mimecast-MFC-AGG-ID: luNWR7ldO4OBYxxEkuHZ0Q_1745337831
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F0891955DCD; Tue, 22 Apr 2025 16:03:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C9FA18001DA; Tue, 22 Apr 2025 16:03:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 23/37] vfio: Move vfio_device_list into device.c
Date: Tue, 22 Apr 2025 18:02:10 +0200
Message-ID: <20250422160224.199714-24-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

'vfio_device_list' is VFIODevice related. Move its definitions into
"device.c".

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-23-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-24-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 3 ---
 hw/vfio/device.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 91ffc5e1a37a3ba7ab50cb5f14cbe5d56f78949d..f16d679e71244e225b831b2cc39c49ee2b1cd940 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -47,9 +47,6 @@
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
 
-VFIODeviceList vfio_device_list =
-    QLIST_HEAD_INITIALIZER(vfio_device_list);
-
 /*
  * Device state interfaces
  */
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 21c6824430c49170b8d1b9a69ff51272f48096a4..25fdba10a882e35392f26a107509f80e4b1c880a 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -31,6 +31,9 @@
 #include "monitor/monitor.h"
 #include "vfio-helpers.h"
 
+VFIODeviceList vfio_device_list =
+    QLIST_HEAD_INITIALIZER(vfio_device_list);
+
 /*
  * Common VFIO interrupt disable
  */
-- 
2.49.0


