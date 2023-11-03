Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2EB7E027E
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 13:06:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qysvk-0007dO-9r; Fri, 03 Nov 2023 08:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qysvG-0007UH-07
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qysvC-0001aG-0b
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699013105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuumQ6CMhzFrUiWF8J0EXQY2x/d5itSYYSukSJVzVFw=;
 b=BuP1yjAyXDG3+9qPNQnZcOzyqDb58EFFd1FqqSOTsfVsu1piLpZuCJJvfCqhxlicTL7a/R
 PrjT3SQcp8hYQo2AyELkqyV3tiZVWev0LjiSi9GAsHhOATXOXQ9l2KeLVBJmmxvuXrDx55
 bDpdMnkmPyDSiFhEcXZw9HKgNrEm1MM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-LB7Hzr_wOI-Llf_vhby0Og-1; Fri, 03 Nov 2023 08:05:03 -0400
X-MC-Unique: LB7Hzr_wOI-Llf_vhby0Og-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDAB288D287;
 Fri,  3 Nov 2023 12:05:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A95C492BE0;
 Fri,  3 Nov 2023 12:05:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 6/7] docs/migration: Add the dirty limit section
Date: Fri,  3 Nov 2023 13:04:47 +0100
Message-ID: <20231103120448.58428-7-quintela@redhat.com>
In-Reply-To: <20231103120448.58428-1-quintela@redhat.com>
References: <20231103120448.58428-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

From: Hyman Huang <yong.huang@smartx.com>

The dirty limit feature has been introduced since the 8.1
QEMU release but has not reflected in the document, add a
section for that.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <0f2b2c63fec22ea23e4926cdeb567b7a0ebd8152.1698847223.git.yong.huang@smartx.com>
---
 docs/devel/migration.rst | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 240eb16d90..5adf4f12f7 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -594,6 +594,77 @@ path.
      Return path  - opened by main thread, written by main thread AND postcopy
      thread (protected by rp_mutex)
 
+Dirty limit
+=====================
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
+
 Postcopy
 ========
 
-- 
2.41.0


