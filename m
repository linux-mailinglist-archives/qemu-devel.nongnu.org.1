Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FE82B393
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:02:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQm-0004BE-SR; Thu, 11 Jan 2024 12:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQj-00048U-7k
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQh-0003m1-61
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FqK0TjfhvmsiSNe/HynuF3gunefj2YJ/P+y3XktSFdM=;
 b=OHAUGxhabg1tiCccwb27XHbGAHk1dzBhSrrzRBpf1qYiGG/L+nqYz0C1LxJUSKsuym/sU1
 Untp2uo+QICh/WDvBq+g8wHYw9mtUBvUxTxtENHOErZBzQVI7CO4PVdGX84kDtAzb96VBN
 la1Zr9mS588Ql3KCoofmixwVuJBxfQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-dMPIIMgBPwe-04FalHOu6g-1; Thu, 11 Jan 2024 12:01:13 -0500
X-MC-Unique: dMPIIMgBPwe-04FalHOu6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3924A108BF37;
 Thu, 11 Jan 2024 17:01:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A957D51D5;
 Thu, 11 Jan 2024 17:01:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 13/17] hw/s390x/ccw: Replace dirname() with g_path_get_dirname()
Date: Thu, 11 Jan 2024 18:00:42 +0100
Message-ID: <20240111170047.909117-14-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As commit 3e015d815b3f ("use g_path_get_basename instead of basename")
said, g_path_get_dirname() should be preferred over dirname() since
the former is a portable utility function that has the advantage of not
modifying the string argument.

Replace dirname() with g_path_get_dirname().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20231221171921.57784-3-zhao1.liu@linux.intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index ab7022a3ab..5261e66724 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -77,6 +77,7 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
 {
     unsigned int cssid, ssid, devid;
     char dev_path[PATH_MAX] = {0};
+    g_autofree char *tmp_dir = NULL;
     g_autofree char *tmp = NULL;
 
     if (!sysfsdev) {
@@ -93,7 +94,8 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
 
     cdev->mdevid = g_path_get_basename(dev_path);
 
-    tmp = g_path_get_basename(dirname(dev_path));
+    tmp_dir = g_path_get_dirname(dev_path);
+    tmp = g_path_get_basename(tmp_dir);
     if (sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid) != 3) {
         error_setg_errno(errp, errno, "Failed to read %s", tmp);
         return;
-- 
2.43.0


