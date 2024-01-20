Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72F833367
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 10:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR82n-00083J-Ce; Sat, 20 Jan 2024 04:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rR82k-00082J-Ob
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:53:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rR82h-00063J-22
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705744414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQA1DRO6iI9twls7npaDRRxrXTtaWLpraltdDpbY+9A=;
 b=fMoL+QMwz9F2ZStexUF93RPlSpOycgP2QgoVHjqPTKsKAOPy6wm5ns+7bEHRGMymQnRZsv
 JTQgwieV89Lm911zLHgNZyFe9ClLR4TVe2N/W2P7N3T5hmefm/c/qzwUEvb9VX7ldUM00H
 i/bOqlZiqis+JSCQopbU5P/Msf+hkcs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-S_H-PmVbPyeWqokdtRA0KA-1; Sat,
 20 Jan 2024 04:53:29 -0500
X-MC-Unique: S_H-PmVbPyeWqokdtRA0KA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A2BC1C06D06;
 Sat, 20 Jan 2024 09:53:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 736742166B35;
 Sat, 20 Jan 2024 09:53:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B2A021E6682; Sat, 20 Jan 2024 10:53:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	peter.maydell@linaro.org,
	jsnow@redhat.com
Subject: [PATCH 4/7] docs/interop/bitmaps: Clean up a reference to qemu-qmp-ref
Date: Sat, 20 Jan 2024 10:53:24 +0100
Message-ID: <20240120095327.666239-5-armbru@redhat.com>
In-Reply-To: <20240120095327.666239-1-armbru@redhat.com>
References: <20240120095327.666239-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

docs/interop/bitmaps.rst uses references like

    `qemu-qmp-ref <qemu-qmp-ref.html>`_
    `query-block <qemu-qmp-ref.html#index-query_002dblock>`_

to refer to and into docs/interop/qemu-qmp-ref.rst.

Clean up the former: use :doc:`qemu-qmp-ref`.

I don't know how to clean up the latter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/bitmaps.rst | 4 ++--
 qapi/introspect.json     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
index c731be2f01..ddf8947d54 100644
--- a/docs/interop/bitmaps.rst
+++ b/docs/interop/bitmaps.rst
@@ -167,8 +167,8 @@ Basic QMP Usage
 
 The primary interface to manipulating bitmap objects is via the QMP
 interface. If you are not familiar, see the :doc:`qmp-spec` for the
-protocol, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full
-reference of all QMP commands.
+protocol, and :doc:`qemu-qmp-ref` for a full reference of all QMP
+commands.
 
 Supported Commands
 ~~~~~~~~~~~~~~~~~~
diff --git a/qapi/introspect.json b/qapi/introspect.json
index ebc4e199d2..8df1ce85ed 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -260,8 +260,8 @@
 # Additional SchemaInfo members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
-#     members' wire encoding is distinct, see :doc:`qapi-code-gen`
-#     section Alternate types.
+#     members' wire encoding is distinct, see
+#     :doc:`/devel/qapi-code-gen` section Alternate types.
 #
 # On the wire, this can be any of the members.
 #
-- 
2.43.0


