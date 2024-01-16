Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F4782E826
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:21:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa0k-00066f-JC; Mon, 15 Jan 2024 22:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0W-00063e-9K
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0U-00036d-4m
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtTS+Q0RUBBpLuyF/zLHSS9yw/Hs9pS+4zGkT3k6AMs=;
 b=JIQWPYQWuHI7M9KY3eRE8+S4+fcSzjE/Ziz92bv5OeX1ETvafcxa5w6VLCRNbLH7cYEAos
 lSVqB+o8LZaThA4AaFKBRmJMANtMNiNvMBcpVXJ/FPhyg8qphwkX1T7Rczxu0JDSZNh+Ga
 I4DwrpgqEPQoxxgLbCUDR7cBYW2O/YM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-6xkgHTDNOhGR49rn8_QNag-1; Mon,
 15 Jan 2024 22:20:48 -0500
X-MC-Unique: 6xkgHTDNOhGR49rn8_QNag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E62903811F50;
 Tue, 16 Jan 2024 03:20:47 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 857103C25;
 Tue, 16 Jan 2024 03:20:44 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Yong Huang <yong.huang@smartx.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/20] docs/migration: Split "dirty limit"
Date: Tue, 16 Jan 2024 11:19:43 +0800
Message-ID: <20240116031947.69017-17-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

Split that into a separate file, put under "features".

Cc: Yong Huang <yong.huang@smartx.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240109064628.595453-8-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/dirty-limit.rst | 71 ++++++++++++++++++++++++++++
 docs/devel/migration/features.rst    |  1 +
 docs/devel/migration/main.rst        | 71 ----------------------------
 3 files changed, 72 insertions(+), 71 deletions(-)
 create mode 100644 docs/devel/migration/dirty-limit.rst

diff --git a/docs/devel/migration/dirty-limit.rst b/docs/devel/migration/dirty-limit.rst
new file mode 100644
index 0000000000..8f32329d5f
--- /dev/null
+++ b/docs/devel/migration/dirty-limit.rst
@@ -0,0 +1,71 @@
+Dirty limit
+===========
+
+The dirty limit, short for dirty page rate upper limit, is a new capability
+introduced in the 8.1 QEMU release that uses a new algorithm based on the KVM
+dirty ring to throttle down the guest during live migration.
+
+The algorithm framework is as follows:
+
+::
+
+  ------------------------------------------------------------------------------
+  main   --------------> throttle thread ------------> PREPARE(1) <--------
+  thread  \                                                |              |
+           \                                               |              |
+            \                                              V              |
+             -\                                        CALCULATE(2)       |
+               \                                           |              |
+                \                                          |              |
+                 \                                         V              |
+                  \                                    SET PENALTY(3) -----
+                   -\                                      |
+                     \                                     |
+                      \                                    V
+                       -> virtual CPU thread -------> ACCEPT PENALTY(4)
+  ------------------------------------------------------------------------------
+
+When the qmp command qmp_set_vcpu_dirty_limit is called for the first time,
+the QEMU main thread starts the throttle thread. The throttle thread, once
+launched, executes the loop, which consists of three steps:
+
+  - PREPARE (1)
+
+     The entire work of PREPARE (1) is preparation for the second stage,
+     CALCULATE(2), as the name implies. It involves preparing the dirty
+     page rate value and the corresponding upper limit of the VM:
+     The dirty page rate is calculated via the KVM dirty ring mechanism,
+     which tells QEMU how many dirty pages a virtual CPU has had since the
+     last KVM_EXIT_DIRTY_RING_FULL exception; The dirty page rate upper
+     limit is specified by caller, therefore fetch it directly.
+
+  - CALCULATE (2)
+
+     Calculate a suitable sleep period for each virtual CPU, which will be
+     used to determine the penalty for the target virtual CPU. The
+     computation must be done carefully in order to reduce the dirty page
+     rate progressively down to the upper limit without oscillation. To
+     achieve this, two strategies are provided: the first is to add or
+     subtract sleep time based on the ratio of the current dirty page rate
+     to the limit, which is used when the current dirty page rate is far
+     from the limit; the second is to add or subtract a fixed time when
+     the current dirty page rate is close to the limit.
+
+  - SET PENALTY (3)
+
+     Set the sleep time for each virtual CPU that should be penalized based
+     on the results of the calculation supplied by step CALCULATE (2).
+
+After completing the three above stages, the throttle thread loops back
+to step PREPARE (1) until the dirty limit is reached.
+
+On the other hand, each virtual CPU thread reads the sleep duration and
+sleeps in the path of the KVM_EXIT_DIRTY_RING_FULL exception handler, that
+is ACCEPT PENALTY (4). Virtual CPUs tied with writing processes will
+obviously exit to the path and get penalized, whereas virtual CPUs involved
+with read processes will not.
+
+In summary, thanks to the KVM dirty ring technology, the dirty limit
+algorithm will restrict virtual CPUs as needed to keep their dirty page
+rate inside the limit. This leads to more steady reading performance during
+live migration and can aid in improving large guest responsiveness.
diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 0054e0c900..e257d0d100 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -7,3 +7,4 @@ Migration has plenty of features to support different use cases.
    :maxdepth: 2
 
    postcopy
+   dirty-limit
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 051ea43f0e..00b9c3d32f 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -573,74 +573,3 @@ path.
      Return path  - opened by main thread, written by main thread AND postcopy
      thread (protected by rp_mutex)
 
-Dirty limit
-=====================
-The dirty limit, short for dirty page rate upper limit, is a new capability
-introduced in the 8.1 QEMU release that uses a new algorithm based on the KVM
-dirty ring to throttle down the guest during live migration.
-
-The algorithm framework is as follows:
-
-::
-
-  ------------------------------------------------------------------------------
-  main   --------------> throttle thread ------------> PREPARE(1) <--------
-  thread  \                                                |              |
-           \                                               |              |
-            \                                              V              |
-             -\                                        CALCULATE(2)       |
-               \                                           |              |
-                \                                          |              |
-                 \                                         V              |
-                  \                                    SET PENALTY(3) -----
-                   -\                                      |
-                     \                                     |
-                      \                                    V
-                       -> virtual CPU thread -------> ACCEPT PENALTY(4)
-  ------------------------------------------------------------------------------
-
-When the qmp command qmp_set_vcpu_dirty_limit is called for the first time,
-the QEMU main thread starts the throttle thread. The throttle thread, once
-launched, executes the loop, which consists of three steps:
-
-  - PREPARE (1)
-
-     The entire work of PREPARE (1) is preparation for the second stage,
-     CALCULATE(2), as the name implies. It involves preparing the dirty
-     page rate value and the corresponding upper limit of the VM:
-     The dirty page rate is calculated via the KVM dirty ring mechanism,
-     which tells QEMU how many dirty pages a virtual CPU has had since the
-     last KVM_EXIT_DIRTY_RING_FULL exception; The dirty page rate upper
-     limit is specified by caller, therefore fetch it directly.
-
-  - CALCULATE (2)
-
-     Calculate a suitable sleep period for each virtual CPU, which will be
-     used to determine the penalty for the target virtual CPU. The
-     computation must be done carefully in order to reduce the dirty page
-     rate progressively down to the upper limit without oscillation. To
-     achieve this, two strategies are provided: the first is to add or
-     subtract sleep time based on the ratio of the current dirty page rate
-     to the limit, which is used when the current dirty page rate is far
-     from the limit; the second is to add or subtract a fixed time when
-     the current dirty page rate is close to the limit.
-
-  - SET PENALTY (3)
-
-     Set the sleep time for each virtual CPU that should be penalized based
-     on the results of the calculation supplied by step CALCULATE (2).
-
-After completing the three above stages, the throttle thread loops back
-to step PREPARE (1) until the dirty limit is reached.
-
-On the other hand, each virtual CPU thread reads the sleep duration and
-sleeps in the path of the KVM_EXIT_DIRTY_RING_FULL exception handler, that
-is ACCEPT PENALTY (4). Virtual CPUs tied with writing processes will
-obviously exit to the path and get penalized, whereas virtual CPUs involved
-with read processes will not.
-
-In summary, thanks to the KVM dirty ring technology, the dirty limit
-algorithm will restrict virtual CPUs as needed to keep their dirty page
-rate inside the limit. This leads to more steady reading performance during
-live migration and can aid in improving large guest responsiveness.
-
-- 
2.43.0


