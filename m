Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD2B11465
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Jul 2025 01:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf5BP-0002iR-F3; Thu, 24 Jul 2025 19:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uf5BK-0002gR-Fn
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 19:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uf5BH-0006yX-N1
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 19:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753399012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TkyBv1MpbJDZgBO9SChPj8lFjZ+sxQq6VnJGF/7U1ys=;
 b=gxDzW1ybLFI7fsY4mgVGmDWTgHjjjmpTXzEi8rkO9uGMNGAM3id9JRghBpz9hCRw0oWKrv
 yl76hSUV22l5ug1XGiZIAlbc8L2JlvIeFfHDQhenNyGg12kQXpCTyom80VSCJHCmlxa41R
 71rof1HyttlttM5CokawQpT9av7E1fw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-LWNXuWbkPNijx9BMzx0AHQ-1; Thu,
 24 Jul 2025 19:16:49 -0400
X-MC-Unique: LWNXuWbkPNijx9BMzx0AHQ-1
X-Mimecast-MFC-AGG-ID: LWNXuWbkPNijx9BMzx0AHQ_1753399009
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA54A195608F; Thu, 24 Jul 2025 23:16:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A19861800242; Thu, 24 Jul 2025 23:16:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH] docs/qapi-code-gen: change recommendations for
 cross-reference syntax
Date: Thu, 24 Jul 2025 19:16:46 -0400
Message-ID: <20250724231646.390181-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The blurb about @foo style references in qapi-code-gen.rst is out of
date now, update it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 11 ++++++++---
 docs/devel/qapi-domain.rst   |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index dfdbeac5a5a..51993a6eb0c 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -943,9 +943,14 @@ The usual ****strong****, *\*emphasized\** and ````literal```` markup
 should be used.  If you need a single literal ``*``, you will need to
 backslash-escape it.
 
-Use ``@foo`` to reference a name in the schema.  This is an rST
-extension.  It is rendered the same way as ````foo````, but carries
-additional meaning.
+Use ```foo``` to reference a name in the schema and generate a
+cross-reference link. In the event that a cross-reference is ambiguous
+and the manual compilation fails, `QAPI cross-reference roles
+<QAPI-XREF>` can be used to narrow the cross-reference results.
+
+Use ``@foo`` to reference members, which do not currently have a
+cross-reference target. This is an rST extension.  It is rendered the
+same way as ````foo````, but carries additional meaning.
 
 Example::
 
diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index b71890f6609..8d9fc866bc3 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -375,6 +375,7 @@ Will allow you to add arbitrary field lists in QAPI directives::
 
       :see also: Lorem ipsum, dolor sit amet ...
 
+.. _QAPI-XREF:
 
 Cross-references
 ================
-- 
2.50.1


