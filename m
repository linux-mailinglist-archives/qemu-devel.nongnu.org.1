Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F986FA19
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Mar 2024 07:34:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1sc-0005Xg-8C; Mon, 04 Mar 2024 01:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sS-0005XB-Lw
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sR-00007Y-0y
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfE/bEdPvuajNPHkFQIHTUt/Ptrgpq+oPHT+0UHMa2c=;
 b=VlXy4rFsfgnwzZWySbf7ezHevzlq0httJHGMiAZEw5AMw1OzdZgPC2zNSj/wNeycIgmZZ6
 UlizifEr9YeEwPmz+js7vpRGOfWPjeuEp0yK4/jxSqzCJ+h4lzQ+aN1MG0KD5bOAWBXFkj
 NzedPFD1ejjEzvuzhUgldylvZgSTI/A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-IzhuNUV7MKa4qORbYQW6_w-1; Mon,
 04 Mar 2024 01:32:38 -0500
X-MC-Unique: IzhuNUV7MKa4qORbYQW6_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D645C3C14943;
 Mon,  4 Mar 2024 06:32:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 943BB28D;
 Mon,  4 Mar 2024 06:32:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6DB8221E6A28; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 01/18] qapi: Memorize since & returns sections
Date: Mon,  4 Mar 2024 07:32:19 +0100
Message-ID: <20240304063236.213955-2-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is chiefly to make code that looks up these sections easier to
read.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-2-armbru@redhat.com>
---
 scripts/qapi/parser.py | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 11707418fb..bfc47cf3cb 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -639,6 +639,10 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # dicts mapping parameter/feature names to their description
         self.args: Dict[str, QAPIDoc.ArgSection] = {}
         self.features: Dict[str, QAPIDoc.ArgSection] = {}
+        # a command's "Returns" section
+        self.returns: Optional[QAPIDoc.Section] = None
+        # "Since" section
+        self.since: Optional[QAPIDoc.Section] = None
         # sections other than .body, .args, .features
         self.sections: List[QAPIDoc.Section] = []
 
@@ -660,14 +664,17 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
         self.all_sections.append(section)
 
     def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
-        if tag in ('Returns', 'Since'):
-            for section in self.all_sections:
-                if isinstance(section, self.ArgSection):
-                    continue
-                if section.tag == tag:
-                    raise QAPISemError(
-                        info, "duplicated '%s' section" % tag)
         section = self.Section(info, tag)
+        if tag == 'Returns':
+            if self.returns:
+                raise QAPISemError(
+                    info, "duplicated '%s' section" % tag)
+            self.returns = section
+        elif tag == 'Since':
+            if self.since:
+                raise QAPISemError(
+                    info, "duplicated '%s' section" % tag)
+            self.since = section
         self.sections.append(section)
         self.all_sections.append(section)
 
@@ -708,13 +715,9 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
         self.features[feature.name].connect(feature)
 
     def check_expr(self, expr: QAPIExpression) -> None:
-        if 'command' not in expr:
-            sec = next((sec for sec in self.sections
-                        if sec.tag == 'Returns'),
-                       None)
-            if sec:
-                raise QAPISemError(sec.info,
-                                   "'Returns:' is only valid for commands")
+        if self.returns and 'command' not in expr:
+            raise QAPISemError(self.returns.info,
+                               "'Returns:' is only valid for commands")
 
     def check(self) -> None:
 
-- 
2.44.0


