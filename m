Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1508CC545
	for <lists+qemu-devel@lfdr.de>; Wed, 22 May 2024 19:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pLL-0000Rj-Gw; Wed, 22 May 2024 13:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLI-0000Py-FT
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pL8-0006GK-Dv
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716397280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zd1AqLvVL7wcYKVeJ4+z707gsI8ABGKG0N9STot3puE=;
 b=BSmj+cDN0SIvDCZbl1eWopwHnkAX62x9rp/2mP9efKIgxslBTx1rMhDxP/UYk55ORJWDU4
 qzEGZlfmpx/zqUQUh/U++Z2qDI9XEx9F1ekbf59lOK72C9hLN+FAkp/nX7glC9nAq4UrIM
 RgAGO/wRxmt6yJbQuBZRavAFy/gDivQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-cqFyCqcMOfq6tipHETMGDw-1; Wed, 22 May 2024 13:01:16 -0400
X-MC-Unique: cqFyCqcMOfq6tipHETMGDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7290800994;
 Wed, 22 May 2024 17:01:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E131561B;
 Wed, 22 May 2024 17:01:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/7] hw/s390x/ccw: Remove local Error variable from
 s390_ccw_realize()
Date: Wed, 22 May 2024 19:01:03 +0200
Message-ID: <20240522170107.289532-4-clg@redhat.com>
In-Reply-To: <20240522170107.289532-1-clg@redhat.com>
References: <20240522170107.289532-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Use the 'Error **errp' argument of s390_ccw_realize() instead and
remove the error_propagate() call.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/s390x/s390-ccw.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 4b8ede701df90949720262b6fc1b65f4e505e34d..b3d14c61d732880a651edcf28a040ca723cb9f5b 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -115,13 +115,12 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     DeviceState *parent = DEVICE(ccw_dev);
     SubchDev *sch;
     int ret;
-    Error *err = NULL;
 
-    if (!s390_ccw_get_dev_info(cdev, sysfsdev, &err)) {
-        goto out_err_propagate;
+    if (!s390_ccw_get_dev_info(cdev, sysfsdev, errp)) {
+        return;
     }
 
-    sch = css_create_sch(ccw_dev->devno, &err);
+    sch = css_create_sch(ccw_dev->devno, errp);
     if (!sch) {
         goto out_mdevid_free;
     }
@@ -132,12 +131,12 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     ccw_dev->sch = sch;
     ret = css_sch_build_schib(sch, &cdev->hostid);
     if (ret) {
-        error_setg_errno(&err, -ret, "%s: Failed to build initial schib",
+        error_setg_errno(errp, -ret, "%s: Failed to build initial schib",
                          __func__);
         goto out_err;
     }
 
-    if (!ck->realize(ccw_dev, &err)) {
+    if (!ck->realize(ccw_dev, errp)) {
         goto out_err;
     }
 
@@ -151,8 +150,6 @@ out_err:
     g_free(sch);
 out_mdevid_free:
     g_free(cdev->mdevid);
-out_err_propagate:
-    error_propagate(errp, err);
 }
 
 static void s390_ccw_unrealize(S390CCWDevice *cdev)
-- 
2.45.1


