Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3045A2E69F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 09:40:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPKr-0000gx-0B; Mon, 10 Feb 2025 03:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thPKf-0000gG-Vq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:39:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thPKe-0003EJ-Ay
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739176795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lU5iBJmaBkwDwhbv4E1UItgxk5NwBV93HL/h6G/NcaM=;
 b=fgTESL92kK6VBldolt4LfeEfAb0396kStKpFBBM4NZUeDtgKp6ASvMENoEX0fDiesDvczb
 BCjigWdB0E3owkigjdShxTiwXgZw+szv4k11ImKhv2T81B8rqFw1HKR1HlO0DxJVvYKBib
 B+zFT8TrA/k6v8/nrZhm8XruIRLH9gs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-3l45JAuPOoWkkdpgNmNgsg-1; Mon,
 10 Feb 2025 03:39:53 -0500
X-MC-Unique: 3l45JAuPOoWkkdpgNmNgsg-1
X-Mimecast-MFC-AGG-ID: 3l45JAuPOoWkkdpgNmNgsg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D08B71956086
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:39:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B8F819560A3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:39:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B38D021E6939; Mon, 10 Feb 2025 09:39:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/6] qapi: rename 'special_features' to 'features'
Date: Mon, 10 Feb 2025 09:39:45 +0100
Message-ID: <20250210083946.3553415-6-armbru@redhat.com>
In-Reply-To: <20250210083946.3553415-1-armbru@redhat.com>
References: <20250210083946.3553415-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This updates the QAPI code generation to refer to 'features' instead
of 'special_features', in preparation for generalizing their exposure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250205123550.2754387-4-berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Imports tidied up with isort]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py |  4 ++--
 scripts/qapi/gen.py      |  8 ++++----
 scripts/qapi/types.py    | 14 +++++---------
 scripts/qapi/visit.py    | 18 +++++++-----------
 4 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79951a841f..d629d2d97e 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -25,7 +25,7 @@
     QAPIGenC,
     QAPISchemaModularCVisitor,
     build_params,
-    gen_special_features,
+    gen_features,
     ifcontext,
 )
 from .schema import (
@@ -298,7 +298,7 @@ def gen_register_command(name: str,
 ''',
                 name=name, c_name=c_name(name),
                 opts=' | '.join(options) or 0,
-                feats=gen_special_features(features))
+                feats=gen_features(features))
     return ret
 
 
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index c53ca72950..b51f8d955e 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -41,10 +41,10 @@
 from .source import QAPISourceInfo
 
 
-def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
-    special_features = [f"1u << {c_enum_const('qapi', feat.name)}"
-                        for feat in features if feat.is_special()]
-    return ' | '.join(special_features) or '0'
+def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
+    featenum = [f"1u << {c_enum_const('qapi', feat.name)}"
+                for feat in features if feat.is_special()]
+    return ' | '.join(featenum) or '0'
 
 
 class QAPIGen:
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 7bc3f8241f..e4a1bb9f85 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -16,11 +16,7 @@
 from typing import List, Optional
 
 from .common import c_enum_const, c_name, mcgen
-from .gen import (
-    QAPISchemaModularCVisitor,
-    gen_special_features,
-    ifcontext,
-)
+from .gen import QAPISchemaModularCVisitor, gen_features, ifcontext
 from .schema import (
     QAPISchema,
     QAPISchemaAlternatives,
@@ -61,12 +57,12 @@ def gen_enum_lookup(name: str,
                      index=index, name=memb.name)
         ret += memb.ifcond.gen_endif()
 
-        special_features = gen_special_features(memb.features)
-        if special_features != '0':
+        features = gen_features(memb.features)
+        if features != '0':
             feats += mcgen('''
-        [%(index)s] = %(special_features)s,
+        [%(index)s] = %(features)s,
 ''',
-                           index=index, special_features=special_features)
+                           index=index, features=features)
 
     if feats:
         ret += mcgen('''
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 12f92e429f..928273b9bb 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -21,11 +21,7 @@
     indent,
     mcgen,
 )
-from .gen import (
-    QAPISchemaModularCVisitor,
-    gen_special_features,
-    ifcontext,
-)
+from .gen import QAPISchemaModularCVisitor, gen_features, ifcontext
 from .schema import (
     QAPISchema,
     QAPISchemaAlternatives,
@@ -103,15 +99,15 @@ def gen_visit_object_members(name: str,
 ''',
                          name=memb.name, has=has)
             indent.increase()
-        special_features = gen_special_features(memb.features)
-        if special_features != '0':
+        features = gen_features(memb.features)
+        if features != '0':
             ret += mcgen('''
-    if (visit_policy_reject(v, "%(name)s", %(special_features)s, errp)) {
+    if (visit_policy_reject(v, "%(name)s", %(features)s, errp)) {
         return false;
     }
-    if (!visit_policy_skip(v, "%(name)s", %(special_features)s)) {
+    if (!visit_policy_skip(v, "%(name)s", %(features)s)) {
 ''',
-                         name=memb.name, special_features=special_features)
+                         name=memb.name, features=features)
             indent.increase()
         ret += mcgen('''
     if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
@@ -120,7 +116,7 @@ def gen_visit_object_members(name: str,
 ''',
                      c_type=memb.type.c_name(), name=memb.name,
                      c_name=c_name(memb.name))
-        if special_features != '0':
+        if features != '0':
             indent.decrease()
             ret += mcgen('''
     }
-- 
2.48.1


