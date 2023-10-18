Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D669B7CDD09
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6ID-0006DQ-2w; Wed, 18 Oct 2023 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HL-0004WY-78
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HI-00080g-Cd
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGr7yzMAsfCIGauWHDnaj33LfvaMY8LrxEiBP7N1Jp4=;
 b=VSvGjiiVkme9kXsLqsz6YcUke/YCHY/F4hOiTDNKsSHlk8g5u04AGXasJRNeVQry4Wdnu1
 p1pO680u0EQdp9+03zSVpI8f3WVqU4mLJA0IM/rNk0ZqNwVtLuxYvgwFcYoqLlj/BYAEwd
 Y/eeXMvtTj7QLDbisB/BI3nZxcQYJJY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-4T_5AAuwNBCec5V7AyfpCw-1; Wed, 18 Oct 2023 09:07:55 -0400
X-MC-Unique: 4T_5AAuwNBCec5V7AyfpCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B89358E4143;
 Wed, 18 Oct 2023 13:07:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D11F20268C8;
 Wed, 18 Oct 2023 13:07:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 21/25] tests/avocado: s390x cpu topology bad move
Date: Wed, 18 Oct 2023 15:07:12 +0200
Message-ID: <20231018130716.286638-22-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Pierre Morel <pmorel@linux.ibm.com>

This test verifies that QEMU refuses to move a CPU to an
nonexistent location.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231016183925.2384704-22-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/s390_topology.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index d3e6556c0f..9154ac8776 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -412,3 +412,28 @@ def test_dedicated_error(self):
         res = self.vm.qmp('set-cpu-topology',
                           {'core-id': 0, 'entitlement': 'medium', 'dedicated': False})
         self.assertEqual(res['return'], {})
+
+    def test_move_error(self):
+        """
+        This test verifies that QEMU refuses to move a CPU to an
+        nonexistent location
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
+        res = self.vm.qmp('set-cpu-topology', {'core-id': 0, 'drawer-id': 1})
+        self.assertEqual(res['error']['class'], 'GenericError')
+
+        res = self.vm.qmp('set-cpu-topology', {'core-id': 0, 'book-id': 1})
+        self.assertEqual(res['error']['class'], 'GenericError')
+
+        res = self.vm.qmp('set-cpu-topology', {'core-id': 0, 'socket-id': 1})
+        self.assertEqual(res['error']['class'], 'GenericError')
+
+        self.check_topology(0, 0, 0, 0, 'medium', False)
-- 
2.41.0


