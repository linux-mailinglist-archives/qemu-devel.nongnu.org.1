Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3037ED900
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQN-0005It-Qm; Wed, 15 Nov 2023 20:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQI-0005Eq-3x
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQD-0001zZ-P9
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEsxYWL/rvlUKgzze2QNRGRzTzXyfu0i4Gw01lfJ6SI=;
 b=PFBRti6wz4m0gzQAuAJX77ReKO8cidd19RwtQ1TdtVkzn0HoynzWxxhF9cLVAbT2FFpW/O
 j+ezATN8fxCbxMhpHdUEcxWb2y7puILrac6E/rnU/uqt8Z8TGvfrZqgN1qRf9DJMWhkKkc
 gLTD2Move7ovah1M/ujXQsGAkv7OaSs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-F_tLtw9RN768TLHrAPfXtQ-1; Wed,
 15 Nov 2023 20:43:54 -0500
X-MC-Unique: F_tLtw9RN768TLHrAPfXtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A43773813F24;
 Thu, 16 Nov 2023 01:43:53 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FDB3C15881;
 Thu, 16 Nov 2023 01:43:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 07/19] qapi/introspect: assert schema.lookup_type did not fail
Date: Wed, 15 Nov 2023 20:43:38 -0500
Message-ID: <20231116014350.653792-8-jsnow@redhat.com>
In-Reply-To: <20231116014350.653792-1-jsnow@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

lookup_type() is capable of returning None, but introspect.py isn't
prepared for that. (And rightly so, if these built-in types are absent,
something has gone hugely wrong.)

RFC: This is slightly cumbersome as-is, but a patch at the end of this series
tries to address it with some slightly slicker lookup functions that
don't need as much hand-holding.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 67c7d89aae0..42981bce163 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
         # Map the various integer types to plain int
         if typ.json_type() == 'int':
-            typ = self._schema.lookup_type('int')
+            tmp = self._schema.lookup_type('int')
+            assert tmp is not None
+            typ = tmp
         elif (isinstance(typ, QAPISchemaArrayType) and
               typ.element_type.json_type() == 'int'):
-            typ = self._schema.lookup_type('intList')
+            tmp = self._schema.lookup_type('intList')
+            assert tmp is not None
+            typ = tmp
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)
-- 
2.41.0


