Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C88A60E63
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Mar 2025 11:12:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20P-0006MG-7V; Fri, 14 Mar 2025 06:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20G-0006JK-Gs
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20C-00022t-TX
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHOavQHaN85j3yGCJ/6p70cICn1vQD2MyMqNz9D7VpQ=;
 b=Z8Tu54CJVUkE4oTItB3WfjDCSryQ2nht62Y5XwVw8hatkg5WrIfEkYl6wBlKSQM9YPaCbB
 j0+VA+PWRSO7HYpN27WIlRZdllJxuEfB7kaOcF5N84V6lyACoK7HTaIsS73Vh+EF7IugzC
 B0yOfT9AcZemA4Q1OHOI5eFgfK77P/w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-BRv48f8pObWT4GWV3iuflQ-1; Fri,
 14 Mar 2025 06:10:49 -0400
X-MC-Unique: BRv48f8pObWT4GWV3iuflQ-1
X-Mimecast-MFC-AGG-ID: BRv48f8pObWT4GWV3iuflQ_1741947049
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8E531955DDE
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A9DC1828AA7
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE1BF21E6562; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 10/12] docs: add QAPI namespace "QMP" to qemu-qmp-ref
Date: Fri, 14 Mar 2025 11:10:36 +0100
Message-ID: <20250314101038.2408751-11-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This also creates the qapi-qmp-index.html index and cross-reference
target.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-10-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/conf.py                  | 4 +++-
 docs/interop/qemu-qmp-ref.rst | 1 +
 qapi/qapi-schema.json         | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 175491148c..9a86e84a80 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -163,7 +163,9 @@
 
 # Due to a limitation in Sphinx, we need to know which indices to
 # generate in advance. Adding a namespace here allows that generation.
-qapi_namespaces = set()
+qapi_namespaces = {
+    "QMP",
+}
 
 # -- Options for HTML output ----------------------------------------------
 
diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
index e95eeac45e..ef8792b53f 100644
--- a/docs/interop/qemu-qmp-ref.rst
+++ b/docs/interop/qemu-qmp-ref.rst
@@ -8,3 +8,4 @@ QEMU QMP Reference Manual
 
 .. qapi-doc:: qapi/qapi-schema.json
    :transmogrify:
+   :namespace: QMP
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 4475e81cc3..c41c01eb2a 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -5,7 +5,7 @@
 #
 # This document describes all commands currently supported by QMP.
 #
-# For locating a particular item, please see the `qapi-index`.
+# For locating a particular item, please see the `qapi-qmp-index`.
 #
 # Most of the time their usage is exactly the same as in the user
 # Monitor, this means that any other document which also describe
-- 
2.48.1


