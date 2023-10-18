Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D93827CDCE1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:12:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6IB-0005at-CR; Wed, 18 Oct 2023 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HJ-0004WR-Tt
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HG-000809-VP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEV5envu16podH3PMj/I1hV+YFwgWMYWr4XFxGu6cXk=;
 b=dMsoAtFTTSCjJ4PjGW/YVI5DVptRUBP2GDr2O6n71yZE1EMQAoFw46lhC7IJB5Rnp34cBA
 xS3l+2X4SO82oPkjmg5qNXEd9PIBDb+HOtCT8AcaSICIVpRRETihOQW4AX/8p8jFOYyZcY
 ritWt57WG6lPBTvZHdBA4HqXG65WMGY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-n5Mxs1DGOU-jz6iIr7pgBg-1; Wed, 18 Oct 2023 09:07:52 -0400
X-MC-Unique: n5Mxs1DGOU-jz6iIr7pgBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AB8A88B7B1;
 Wed, 18 Oct 2023 13:07:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2CD420268C8;
 Wed, 18 Oct 2023 13:07:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 18/25] tests/avocado: s390x cpu topology test dedicated CPU
Date: Wed, 18 Oct 2023 15:07:09 +0200
Message-ID: <20231018130716.286638-19-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

From: Pierre Morel <pmorel@linux.ibm.com>

A dedicated CPU in vertical polarization can only have
a high entitlement.
Let's check this from both host and guest point of view.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-19-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/s390_topology.py | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index 24fac9a54d..3661048f4c 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -305,3 +305,36 @@ def test_entitlement(self):
         self.guest_set_dispatching('0');
         self.check_polarization("horizontal")
         self.check_topology(0, 0, 0, 0, 'high', False)
+
+
+    def test_dedicated(self):
+        """
+        This test verifies that QEMU adjusts the entitlement correctly when a
+        CPU is made dedicated.
+        QEMU retains the entitlement value when horizontal polarization is in effect.
+        For the guest, the field shows the effective value of the entitlement.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.system_init()
+
+        self.check_polarization("horizontal")
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'dedicated': True})
+        self.assertEqual(res['return'], {})
+        self.check_topology(0, 0, 0, 0, 'high', True)
+        self.check_polarization("horizontal")
+
+        self.guest_set_dispatching('1');
+        self.check_topology(0, 0, 0, 0, 'high', True)
+        self.check_polarization("vertical:high")
+
+        self.guest_set_dispatching('0');
+        self.check_topology(0, 0, 0, 0, 'high', True)
+        self.check_polarization("horizontal")
-- 
2.41.0


