Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E86BB7CDCEE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:15:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6Gp-0003tP-4j; Wed, 18 Oct 2023 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6Gk-0003nR-DR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6Gi-0007pm-IZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDpdfHt4mpsWTeEd+aXvHudq/DJQuDCQERgF2B0hWJc=;
 b=QILq7ni4kDDQSTGwQC3t1qrm6/wJd5v1pw9OWHPnGSroRVFP1Jxy1Yg7K2G59m4/h2nMI4
 DjWCX9E9o8wDtAGdFs7I/1jLE61VQ7qSvffJmH0VozldR9+OIdnxdj1BZsFRnHKq71DHl/
 TpE1uAZDxEEUAHg7R5ry8eph7rj/F+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-ReLYJGIhPjenUGdt-7uSXw-1; Wed, 18 Oct 2023 09:07:20 -0400
X-MC-Unique: ReLYJGIhPjenUGdt-7uSXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 518A8882398;
 Wed, 18 Oct 2023 13:07:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EE3020268C8;
 Wed, 18 Oct 2023 13:07:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 01/25] qapi: machine.json: change docs regarding CPU topology
Date: Wed, 18 Oct 2023 15:06:52 +0200
Message-ID: <20231018130716.286638-2-thuth@redhat.com>
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

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Clarify roles of different architectures.
Also change things a bit in anticipation of additional members being
added.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-2-nsg@linux.ibm.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
[thuth: Updated some comments according to suggestions from Markus]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/machine.json | 59 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a08b6576ca..f053245756 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -71,8 +71,7 @@
 #
 # @thread-id: ID of the underlying host thread
 #
-# @props: properties describing to which node/socket/core/thread
-#     virtual CPU belongs to, provided if supported by board
+# @props: properties associated with a virtual CPU, e.g. the socket id
 #
 # @target: the QEMU system emulation target, which determines which
 #     additional fields will be listed (since 3.0)
@@ -899,28 +898,35 @@
 # should be passed by management with device_add command when a CPU is
 # being hotplugged.
 #
+# Which members are optional and which mandatory depends on the
+# architecture and board.
+#
+# The ids other than the node-id specify the position of the CPU
+# within the CPU topology (as defined by the machine property "smp",
+# thus see also type @SMPConfiguration)
+#
 # @node-id: NUMA node ID the CPU belongs to
 #
-# @socket-id: socket number within node/board the CPU belongs to
+# @socket-id: socket number within CPU topology the CPU belongs to
 #
-# @die-id: die number within socket the CPU belongs to (since 4.1)
+# @die-id: die number within the parent container the CPU belongs to
+#    (since 4.1)
 #
-# @cluster-id: cluster number within die the CPU belongs to (since
-#     7.1)
+# @cluster-id: cluster number within the parent container the CPU
+#     belongs to (since 7.1)
 #
-# @core-id: core number within cluster the CPU belongs to
+# @core-id: core number within the parent container the CPU
+#     belongs to
 #
-# @thread-id: thread number within core the CPU belongs to
+# @thread-id: thread number within the core the CPU  belongs to
 #
-# Note: currently there are 6 properties that could be present but
-#     management should be prepared to pass through other properties
-#     with device_add command to allow for future interface extension.
-#     This also requires the filed names to be kept in sync with the
-#     properties passed to -device/device_add.
+# Note: management should be prepared to pass through additional
+#     properties with device_add.
 #
 # Since: 2.7
 ##
 { 'struct': 'CpuInstanceProperties',
+  # Keep these in sync with the properties device_add accepts
   'data': { '*node-id': 'int',
             '*socket-id': 'int',
             '*die-id': 'int',
@@ -1478,22 +1484,33 @@
 # Schema for CPU topology configuration.  A missing value lets QEMU
 # figure out a suitable value based on the ones that are provided.
 #
-# @cpus: number of virtual CPUs in the virtual machine
-#
-# @sockets: number of sockets in the CPU topology
+# The members other than @cpus and @maxcpus define a topology of
+# containers.
 #
-# @dies: number of dies per socket in the CPU topology
+# The ordering from highest/coarsest to lowest/finest is:
+# @sockets, @dies, @clusters, @cores, @threads.
 #
-# @clusters: number of clusters per die in the CPU topology (since
-#     7.0)
+# Different architectures support different subsets of topology
+# containers.
 #
-# @cores: number of cores per cluster in the CPU topology
+# For example, s390x does not have clusters and dies, and the socket
+# is the parent container of cores.
 #
-# @threads: number of threads per core in the CPU topology
+# @cpus: number of virtual CPUs in the virtual machine
 #
 # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
 #     machine
 #
+# @sockets: number of sockets in the CPU topology
+#
+# @dies: number of dies per parent container
+#
+# @clusters: number of clusters per parent container (since 7.0)
+#
+# @cores: number of cores per parent container
+#
+# @threads: number of threads per core
+#
 # Since: 6.1
 ##
 { 'struct': 'SMPConfiguration', 'data': {
-- 
2.41.0


