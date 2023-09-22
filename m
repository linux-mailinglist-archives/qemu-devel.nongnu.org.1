Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A326D7AB4D9
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiAT-00021K-6T; Fri, 22 Sep 2023 11:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjiAR-00020Z-4g
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjiAP-00019W-Ed
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695396842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xAROy4rscibRoy0ug736eJRU/vMrIOMiS1KgMaikhik=;
 b=VO8IZXODbvP+9qi6pE0Gwxp4KtgArcA9E9w+mzjj27RA6WTpPvyv8fTN2HLm+XKLj+PSEI
 0s000TVywzhgfc+ZL3GvTtXlsSi2T5a3i16E+pBYJzkPvv9xYSLDPLIxyMOwsqRNiUWWK6
 KDgqDndT5XFXs0Wdvm4Oorezn1tm7yU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-35xv0uGCOfuPrfqqjkH3AA-1; Fri, 22 Sep 2023 11:33:08 -0400
X-MC-Unique: 35xv0uGCOfuPrfqqjkH3AA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BCB91C00D0F;
 Fri, 22 Sep 2023 15:33:00 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28090C15BB8;
 Fri, 22 Sep 2023 15:32:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] qapi: provide a friendly string representation of QAPI
 classes
Date: Fri, 22 Sep 2023 16:32:57 +0100
Message-ID: <20230922153257.352911-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

If printing a QAPI schema object for debugging we get the classname and
a hex value for the instance:

  <qapi.schema.QAPISchemaEnumType object at 0x7f0ab4c2dad0>
  <qapi.schema.QAPISchemaObjectType object at 0x7f0ab4c2dd90>
  <qapi.schema.QAPISchemaArrayType object at 0x7f0ab4c2df90>

With this change we instead get the classname and the human friendly
name of the QAPI type instance:

  <QAPISchemaEnumType:CpuS390State>
  <QAPISchemaObjectType:CpuInfoS390>
  <QAPISchemaArrayType:CpuInfoFastList>

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

v1 was two & half years ago:

  https://mail.gnu.org/archive/html/qemu-devel/2021-03/msg01645.html

 scripts/qapi/schema.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 231ebf61ba..20ffacbdf0 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -73,6 +73,12 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
         self.features = features or []
         self._checked = False
 
+    def __repr__(self):
+        if self.name is not None:
+            return "<%s:%s>" % (type(self).__name__, self.name)
+        else:
+            return "<%s>" % type(self).__name__
+
     def c_name(self):
         return c_name(self.name)
 
-- 
2.41.0


