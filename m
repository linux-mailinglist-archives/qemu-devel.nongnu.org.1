Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 674ECA5EAB9
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Mar 2025 05:45:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQT-0008OR-Ll; Thu, 13 Mar 2025 00:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQ9-0008G2-E4
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQ4-0006z8-Rr
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IICSAYKQIi99dXWuXBN3zvFG8LiPpwH6D24NOhrJ2CU=;
 b=O75T9q0hflBLSaCAEPb0eNH4gyXjQEryPcf2s+PUuZ15GWasVtHTOJDb6fb5JpRiON7/60
 TWdN7OdgxhJlLCadiHO+3CD7t7Tss4D6gU5XgenVGqoRXcUCDuztNkGmjvnvXVmzZGnAHc
 5Q86agmZ2+FCGghTtGOrDS4HOcnDKfQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-eAUhapwjPl-ssBO7w3gfSg-1; Thu,
 13 Mar 2025 00:43:41 -0400
X-MC-Unique: eAUhapwjPl-ssBO7w3gfSg-1
X-Mimecast-MFC-AGG-ID: eAUhapwjPl-ssBO7w3gfSg_1741841020
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 365E3180035C; Thu, 13 Mar 2025 04:43:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD43A1955BCB; Thu, 13 Mar 2025 04:43:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 04/11] docs/qapi-domain: add :namespace: override option
Date: Thu, 13 Mar 2025 00:43:05 -0400
Message-ID: <20250313044312.189276-5-jsnow@redhat.com>
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

Akin to the :module: override option, the :namespace: options allows you
to forcibly override the contextual namespace associatied with a
definition.

We don't necessarily actually need this, but I felt compelled to stick
close to how the Python domain works that offers context overrides.

As of this commit, it is possible to add e.g. ":namespace: QMP" to any
QAPI directive to forcibly associate that definition with a given
namespace.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-domain.rst | 2 ++
 docs/sphinx/qapi_domain.py | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index 1475870ca6c..51b283277e1 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -466,6 +466,8 @@ QAPI standard options
 
 All QAPI directives -- *except* for module -- support these common options.
 
+* ``:namespace: name`` -- This option allows you to override the
+  namespace association of a given definition.
 * ``:module: modname`` -- Borrowed from the Python domain, this option allows
   you to override the module association of a given definition.
 * ``:since: x.y`` -- Allows the documenting of "Since" information, which is
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 48a082d489a..6485c432063 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -294,8 +294,9 @@ class QAPIObject(QAPIDescription):
     )
     option_spec.update(
         {
-            # Borrowed from the Python domain:
-            "module": directives.unchanged,  # Override contextual module name
+            # Context overrides:
+            "namespace": directives.unchanged,
+            "module": directives.unchanged,
             # These are QAPI originals:
             "since": directives.unchanged,
             "ifcond": directives.unchanged,
-- 
2.48.1


