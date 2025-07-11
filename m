Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A99B012DD
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 07:42:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6WM-00060D-TM; Fri, 11 Jul 2025 01:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6W9-0004rl-OJ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6W4-0000SN-KK
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752212508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9ZS70U+GHaKttjnUDLWMMfe7y+zFJsE1E0/Js38Ylc=;
 b=M34ZhSGwqtbs7BVVmLQKTno6Nn/I7O2tSUpFmkn9PsyOV/hhbvRaYkQK+nVTwBe4WKt6pP
 WgmHlaHeuxsYaIVV8Se1KFGeX1kFK8JBa30WiuzX2laT41ek0rRSL/zcVTCty3mJpMijI7
 inlulfDMXhkvOD+LKcWzTQWEecqLyfM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-CvOX7uICO0Ktz7404OTtaQ-1; Fri,
 11 Jul 2025 01:41:44 -0400
X-MC-Unique: CvOX7uICO0Ktz7404OTtaQ-1
X-Mimecast-MFC-AGG-ID: CvOX7uICO0Ktz7404OTtaQ_1752212503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 322B21956087; Fri, 11 Jul 2025 05:41:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 092061800285; Fri, 11 Jul 2025 05:41:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 11/18] qapi: add cross-references to QOM
Date: Fri, 11 Jul 2025 01:39:58 -0400
Message-ID: <20250711054005.60969-12-jsnow@redhat.com>
In-Reply-To: <20250711054005.60969-1-jsnow@redhat.com>
References: <20250711054005.60969-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/qdev.json |  4 ++--
 qapi/qom.json  | 13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 5d18fb8e0e0..ff3f06a36d6 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -95,10 +95,10 @@
 #    from the guest.  Hot removal is an operation that requires guest
 #    cooperation.  This command merely requests that the guest begin
 #    the hot removal process.  Completion of the device removal
-#    process is signaled with a DEVICE_DELETED event.  Guest reset
+#    process is signaled with a `DEVICE_DELETED` event.  Guest reset
 #    will automatically complete removal for all devices.  If a
 #    guest-side error in the hot removal process is detected, the
-#    device will not be removed and a DEVICE_UNPLUG_GUEST_ERROR event
+#    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR` event
 #    is sent.  Some errors cannot be detected.
 #
 # Since: 0.14
diff --git a/qapi/qom.json b/qapi/qom.json
index c6fdce7f7bc..e8ba3ee4907 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -51,7 +51,7 @@
 # This command will list any properties of a object given a path in
 # the object model.
 #
-# @path: the path within the object model.  See @qom-get for a
+# @path: the path within the object model.  See `qom-get` for a
 #     description of this parameter.
 #
 # Returns: a list that describe the properties of the object.
@@ -129,12 +129,12 @@
 #
 # This command will set a property from a object model path.
 #
-# @path: see @qom-get for a description of this parameter
+# @path: see `qom-get` for a description of this parameter
 #
 # @property: the property name to set
 #
 # @value: a value who's type is appropriate for the property type.
-#     See @qom-get for a description of type mapping.
+#     See `qom-get` for a description of type mapping.
 #
 # Since: 1.2
 #
@@ -153,7 +153,7 @@
 ##
 # @ObjectTypeInfo:
 #
-# This structure describes a search result from @qom-list-types
+# This structure describes a search result from `qom-list-types`
 #
 # @name: the type name found in the search
 #
@@ -193,6 +193,7 @@
 #
 # @typename: the type name of an object
 #
+#
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
 #    properties are not included in the output of this command.
@@ -787,7 +788,7 @@
 #
 # Properties for x-remote-object objects.
 #
-# @fd: file descriptor name previously passed via 'getfd' command
+# @fd: file descriptor name previously passed via `getfd` command
 #
 # @devid: the id of the device to be associated with the file
 #     descriptor
@@ -816,7 +817,7 @@
 #
 # Properties for iommufd objects.
 #
-# @fd: file descriptor name previously passed via 'getfd' command,
+# @fd: file descriptor name previously passed via `getfd` command,
 #     which represents a pre-opened /dev/iommu.  This allows the
 #     iommufd object to be shared across several subsystems (VFIO,
 #     VDPA, ...), and the file descriptor to be shared with other
-- 
2.50.0


