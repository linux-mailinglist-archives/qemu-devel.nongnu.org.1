Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA38A5EABC
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Mar 2025 05:45:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQX-0008QO-0o; Thu, 13 Mar 2025 00:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQQ-0008N6-8k
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQO-00072E-Mq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcbFhXDLAUEl+yi8uNwfpLWr5+use9NWad5DOVyM68k=;
 b=WqQUyCWlAf1J3Y21lQNX6/gQHMfovtoL6pXzHnbpi7C1tDrBmmgghnE6PiaxWKOZ2FLnRc
 ifp0ImVqI6EadgPLQIUe6y9Q7yrbwOOb0HXTv1FXZbc3VRSlSjOXAuvMMabKReaAImlogP
 7rPMmgWtEveGoewMcanuyogfdG4Gejc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-oIdFeQhqMSaSV2aTbScFJQ-1; Thu,
 13 Mar 2025 00:44:01 -0400
X-MC-Unique: oIdFeQhqMSaSV2aTbScFJQ-1
X-Mimecast-MFC-AGG-ID: oIdFeQhqMSaSV2aTbScFJQ_1741841040
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 325C3180025B; Thu, 13 Mar 2025 04:44:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 478021955BCB; Thu, 13 Mar 2025 04:43:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 11/11] docs: enable transmogrifier for QSD and QGA
Date: Thu, 13 Mar 2025 00:43:12 -0400
Message-ID: <20250313044312.189276-12-jsnow@redhat.com>
In-Reply-To: <20250313044312.189276-1-jsnow@redhat.com>
References: <20250313044312.189276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

This also creates the `qapi-qsd-index` and `qapi-qga-index` QMP indices.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py                                 | 2 ++
 docs/interop/qemu-ga-ref.rst                 | 2 ++
 docs/interop/qemu-storage-daemon-qmp-ref.rst | 2 ++
 qga/qapi-schema.json                         | 3 +++
 storage-daemon/qapi/qapi-schema.json         | 8 ++++++++
 5 files changed, 17 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index 9a86e84a804..7b5712e122f 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -164,7 +164,9 @@
 # Due to a limitation in Sphinx, we need to know which indices to
 # generate in advance. Adding a namespace here allows that generation.
 qapi_namespaces = {
+    "QGA",
     "QMP",
+    "QSD",
 }
 
 # -- Options for HTML output ----------------------------------------------
diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
index 032d4924552..19b5c7a5498 100644
--- a/docs/interop/qemu-ga-ref.rst
+++ b/docs/interop/qemu-ga-ref.rst
@@ -5,3 +5,5 @@ QEMU Guest Agent Protocol Reference
    :depth: 3
 
 .. qapi-doc:: qga/qapi-schema.json
+   :transmogrify:
+   :namespace: QGA
diff --git a/docs/interop/qemu-storage-daemon-qmp-ref.rst b/docs/interop/qemu-storage-daemon-qmp-ref.rst
index 9fed68152f5..d0228d63b8d 100644
--- a/docs/interop/qemu-storage-daemon-qmp-ref.rst
+++ b/docs/interop/qemu-storage-daemon-qmp-ref.rst
@@ -5,3 +5,5 @@ QEMU Storage Daemon QMP Reference Manual
    :depth: 3
 
 .. qapi-doc:: storage-daemon/qapi/qapi-schema.json
+   :transmogrify:
+   :namespace: QSD
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 995594aaf43..35ec0e7db31 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -3,6 +3,9 @@
 
 ##
 # = QEMU guest agent protocol commands and structs
+#
+# For a concise listing of all commands, events, and types in the QEMU
+# guest agent, please consult the `qapi-qga-index`.
 ##
 
 { 'pragma': { 'doc-required': true } }
diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qapi-schema.json
index f10c9494906..2a562ee32e5 100644
--- a/storage-daemon/qapi/qapi-schema.json
+++ b/storage-daemon/qapi/qapi-schema.json
@@ -13,6 +13,14 @@
 # the array type in the main schema, even if it is unused outside of the
 # storage daemon.
 
+##
+# = QEMU storage daemon protocol commands and structs
+#
+# For a concise listing of all commands, events, and types in the QEMU
+# storage daemon, please consult the `qapi-qsd-index`.
+##
+
+
 { 'include': '../../qapi/pragma.json' }
 
 # Documentation generated with qapi-gen.py is in source order, with
-- 
2.48.1


