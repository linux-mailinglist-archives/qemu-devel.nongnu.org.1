Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C67CDCB9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:08:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6H3-0004Cy-6z; Wed, 18 Oct 2023 09:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6H0-0004CD-6f
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6Gy-0007xt-LO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nt8FnL5/ofazqAvViAcI8m5iQGHQh0F8aBouRe2mRDQ=;
 b=h8IsjS0wdDKR/0YJddTSgT1nZf3SU4ys4XxXBpoTOOLWpe0YTQs5cMmDY202UhRgg/DmT8
 YGvWCOAxLEm/vmyif6bcmec7ahnwMv1FLh4qA138+sh8bP/nAuqs2sX2IYYoHYcD9OWxPD
 807wmBXaCGQyhsQPXMjlgzVgiBtcDTE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-RK3YWCQNMP2JHA8IYZdtxQ-1; Wed, 18 Oct 2023 09:07:36 -0400
X-MC-Unique: RK3YWCQNMP2JHA8IYZdtxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 304F01DD35CA;
 Wed, 18 Oct 2023 13:07:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3D3520268C8;
 Wed, 18 Oct 2023 13:07:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 10/25] machine: adding s390 topology to query-cpu-fast
Date: Wed, 18 Oct 2023 15:07:01 +0200
Message-ID: <20231018130716.286638-11-thuth@redhat.com>
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

S390x provides two more topology attributes, entitlement and dedication.

Let's add these CPU attributes to the QAPI command query-cpu-fast.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-11-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/machine.json  | 9 ++++++++-
 target/s390x/cpu.c | 9 +++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 17b69a6aea..b4bd26f716 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -57,9 +57,16 @@
 #
 # @cpu-state: the virtual CPU's state
 #
+# @dedicated: the virtual CPU's dedication (since 8.2)
+#
+# @entitlement: the virtual CPU's entitlement (since 8.2)
+#
 # Since: 2.12
 ##
-{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
+{ 'struct': 'CpuInfoS390',
+  'data': { 'cpu-state': 'CpuS390State',
+            '*dedicated': 'bool',
+            '*entitlement': 'CpuS390Entitlement' } }
 
 ##
 # @CpuInfoFast:
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index ba646461a1..6acfa1c91b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -38,6 +38,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
 #endif
+#include "hw/s390x/cpu-topology.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -146,6 +147,14 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
     S390CPU *s390_cpu = S390_CPU(cpu);
 
     value->u.s390x.cpu_state = s390_cpu->env.cpu_state;
+#if !defined(CONFIG_USER_ONLY)
+    if (s390_has_topology()) {
+        value->u.s390x.has_dedicated = true;
+        value->u.s390x.dedicated = s390_cpu->env.dedicated;
+        value->u.s390x.has_entitlement = true;
+        value->u.s390x.entitlement = s390_cpu->env.entitlement;
+    }
+#endif
 }
 
 /* S390CPUClass::reset() */
-- 
2.41.0


