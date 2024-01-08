Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9923C82777C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIl-00031B-9i; Mon, 08 Jan 2024 13:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIg-0002yk-SP
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuId-0002sk-7H
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiOIifNLXJoIoxrBEDzBR1eoAcvEIjE0TwerFbeGfSc=;
 b=LeqTDI2IQSsLGgjnKjy19aEJEHXyc+LTibI2iRf4LOv3S/V8Qew97JFxhElOktAA+LgYKF
 tVhTnS8TDsWvrAeFyFY5jYn9QEl4GWjzCw8vnpzy96RdRXza5BE3KgKA2gU1FccNhHN25K
 CY6azXfU3n1ydaKgGOqGs4ndImAqKss=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-Da-RImxMMr2_PrOgptVTKg-1; Mon,
 08 Jan 2024 13:24:32 -0500
X-MC-Unique: Da-RImxMMr2_PrOgptVTKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8305A1C06507;
 Mon,  8 Jan 2024 18:24:32 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 921D83C2E;
 Mon,  8 Jan 2024 18:24:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 19/29] scripts: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:55 +0000
Message-ID: <20240108182405.1135436-20-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/commands.py   | 6 +++---
 scripts/qapi/events.py     | 2 +-
 scripts/qapi/introspect.py | 2 +-
 scripts/qapi/visit.py      | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index d1fdf4182c..c2b1eec144 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -320,7 +320,7 @@ def _begin_user_module(self, name: str) -> None:
 #include "qemu/osdep.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/dealloc-visitor.h"
 #include "qapi/error.h"
 #include "%(visit)s.h"
@@ -330,7 +330,7 @@ def _begin_user_module(self, name: str) -> None:
 
         if self._gen_tracing and commands != 'qapi-commands':
             self._genc.add(mcgen('''
-#include "qapi/qmp/qjson.h"
+#include "qobject/qjson.h"
 #include "trace/trace-%(nm)s_trace_events.h"
 ''',
                                  nm=c_name(commands, protect=False)))
@@ -346,7 +346,7 @@ def _begin_user_module(self, name: str) -> None:
     def visit_begin(self, schema: QAPISchema) -> None:
         self._add_module('./init', ' * QAPI Commands initialization')
         self._genh.add(mcgen('''
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 3cf01e96b6..10044ba4b0 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -194,7 +194,7 @@ def _begin_user_module(self, name: str) -> None:
 #include "%(visit)s.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp-event.h"
 ''',
                              events=events, visit=visit,
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 67c7d89aae..bcd2402d82 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -196,7 +196,7 @@ def visit_end(self) -> None:
         # generate C
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
         self._genh.add(mcgen('''
-#include "qapi/qmp/qlit.h"
+#include "qobject/qlit.h"
 
 extern const QLitObject %(c_name)s;
 ''',
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index c56ea4d724..ec0638acdf 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -356,7 +356,7 @@ def _begin_user_module(self, name: str) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "%(visit)s.h"
 ''',
                                       visit=visit))
-- 
2.43.0


