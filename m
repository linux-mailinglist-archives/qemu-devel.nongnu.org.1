Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0EB042EA
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 17:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKnM-0006B4-Iw; Mon, 14 Jul 2025 11:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUl-0000NP-RB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUW-0003d2-Sw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1qX+mpYmZpUc+5wPTF7mRZVR+Q4ffPDdQeCnNltIEk=;
 b=Db+OmPdyJHHp5fmvGHZKgylPunMUi+icMLHlkDB6vsziCoyBtlre2h3VqimqwFzKGAyvgM
 m7L6J6uf88GhdzOVR+0LWGGR5FDXxJ6xOk7U36WmKFawCrYYzFSa5OJtkuJdostlMI0wwy
 g5La894PgvzVLrykT0pHvpnFu9KsBnU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-NWIY2ZLHPPmOCjfrFPd27Q-1; Mon,
 14 Jul 2025 09:45:09 -0400
X-MC-Unique: NWIY2ZLHPPmOCjfrFPd27Q-1
X-Mimecast-MFC-AGG-ID: NWIY2ZLHPPmOCjfrFPd27Q_1752500708
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 935CF195605C
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 478671803AF2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A4C421E65CE; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 22/32] qapi: add cross-references to QOM
Date: Mon, 14 Jul 2025 15:44:48 +0200
Message-ID: <20250714134458.2991097-23-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-12-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qdev.json |  4 ++--
 qapi/qom.json  | 13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 6441357e00..e14a0c9259 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -97,10 +97,10 @@
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
index aa09eddbf9..4e85baae47 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -52,7 +52,7 @@
 #
 # List properties of a object given a path in the object model.
 #
-# @path: the path within the object model.  See @qom-get for a
+# @path: the path within the object model.  See `qom-get` for a
 #     description of this parameter.
 #
 # Returns: a list that describe the properties of the object.
@@ -129,12 +129,12 @@
 #
 # Set a property value.
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
2.49.0


