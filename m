Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B08BA8B0417
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:18:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXpC-0001Fw-J6; Wed, 24 Apr 2024 04:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXod-0000Mz-TS
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoa-0006MS-SE
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+msAICXsvjcDlthJmm3X7WQUPEXlBOV+/3EZ10XoiM=;
 b=dCHc+Ozx8bRj9i8w5Q854vH3iH+Hijc69CKjWVVTrgjaSYP7cfiqwVwbp/gvleDtx0XXkM
 PurH27+dxkBezMPPS4JyF0DgKo78eYK2NzrTPkHguF2SRw8ORdBh1pjdh0ztO50yTlBrJt
 paIly2Gdx2ccjNaVfZS9oziJMKOadUY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-lAg7zbtUOSa4vAk3pS8S9A-1; Wed, 24 Apr 2024 04:17:13 -0400
X-MC-Unique: lAg7zbtUOSa4vAk3pS8S9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D151810BDC;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D9CDC13FA3;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E688021D49C2; Wed, 24 Apr 2024 10:17:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 12/25] qapi: Assert built-in types exist
Date: Wed, 24 Apr 2024 10:16:57 +0200
Message-ID: <20240424081710.2907748-13-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

QAPISchema.lookup_type('FOO') returns a QAPISchemaType when type 'FOO'
exists, else None.  It won't return None for built-in types like
'int'.

Since mypy can't see that, it'll complain that we assign the
Optional[QAPISchemaType] returned by .lookup_type() to QAPISchemaType
variables.

Add assertions to help it over the hump.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240315152301.3621858-13-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 67c7d89aae..4679b1bc2c 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
         # Map the various integer types to plain int
         if typ.json_type() == 'int':
-            typ = self._schema.lookup_type('int')
+            type_int = self._schema.lookup_type('int')
+            assert type_int
+            typ = type_int
         elif (isinstance(typ, QAPISchemaArrayType) and
               typ.element_type.json_type() == 'int'):
-            typ = self._schema.lookup_type('intList')
+            type_intList = self._schema.lookup_type('intList')
+            assert type_intList
+            typ = type_intList
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)
-- 
2.44.0


