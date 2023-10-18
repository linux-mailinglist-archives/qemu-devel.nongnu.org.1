Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D87E7CDCCB
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:10:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6IF-0006an-LQ; Wed, 18 Oct 2023 09:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HK-0004WV-Cc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HI-0007zg-C8
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Do/PwRqeCEm3ANy5UbQG7J904WrxlWULcocZn9hPvoE=;
 b=M+OCuHIcaBTk5QPae5NIC83EoZGJ6Jxk35OHGnictNreyAcz5t/Uq0JTmv+4cRYH8G+WCw
 gs55qQDFWzMBokamMVz13UjGOvwS/TVhbX2ZNd0SfbGqJAJWWNn+hLoVny5scQVH+q6tmA
 rZaPvChLohjpWMSNe9mZRZ55ZERk1pY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-DeNshjyJPpiNUrvVJj4E_Q-1; Wed, 18 Oct 2023 09:07:41 -0400
X-MC-Unique: DeNshjyJPpiNUrvVJj4E_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28F37185A78E;
 Wed, 18 Oct 2023 13:07:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 206FA20268CC;
 Wed, 18 Oct 2023 13:07:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 13/25] qapi/s390x/cpu topology: add
 query-s390x-cpu-polarization command
Date: Wed, 18 Oct 2023 15:07:04 +0200
Message-ID: <20231018130716.286638-14-thuth@redhat.com>
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

The query-s390x-cpu-polarization qmp command returns the current
CPU polarization of the machine.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-14-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/machine-target.json | 30 ++++++++++++++++++++++++++++++
 hw/s390x/cpu-topology.c  |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index ac93a5f82c..4e55adbe00 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -452,3 +452,33 @@
   'features': [ 'unstable' ],
   'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
 }
+
+##
+# @CpuPolarizationInfo:
+#
+# The result of a CPU polarization query.
+#
+# @polarization: the CPU polarization
+#
+# Since: 8.2
+##
+{ 'struct': 'CpuPolarizationInfo',
+  'data': { 'polarization': 'CpuS390Polarization' },
+  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+}
+
+##
+# @query-s390x-cpu-polarization:
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Returns: the machine's CPU polarization
+#
+# Since: 8.2
+##
+{ 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
+  'features': [ 'unstable' ],
+  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+}
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index 327bccea4f..f16bdf65fa 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -459,3 +459,11 @@ void qmp_set_cpu_topology(uint16_t core,
                          has_drawer, drawer, has_entitlement, entitlement,
                          has_dedicated, dedicated, errp);
 }
+
+CpuPolarizationInfo *qmp_query_s390x_cpu_polarization(Error **errp)
+{
+    CpuPolarizationInfo *info = g_new0(CpuPolarizationInfo, 1);
+
+    info->polarization = s390_topology.polarization;
+    return info;
+}
-- 
2.41.0


