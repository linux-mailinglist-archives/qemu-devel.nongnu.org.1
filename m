Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A4A82777D
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:28:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIj-00030D-Gu; Mon, 08 Jan 2024 13:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIg-0002yl-SM
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIc-0002sP-3F
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2SmQ6oyqkWLOf2BpYupFP6G+/WBNFmeJ8OdwlOEfV8=;
 b=BhCt2+q4XQkNzkTF37zdSIGz791QQS9CIHR1nPvtfYWWhMwIv5/tQ2Iqm/S8a1byLbLpFV
 Bo3Ca6LcxmkC7lHDaZOgjofzTtrUAMky8jV+abMPCLiECgz2mAN9r5mcjgH36huOiBXKZW
 rsBu+E7LAqqezKQOu1YXL1yrXPgp5AU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-mS3BRYo6OaWzbCRjgfUieQ-1; Mon,
 08 Jan 2024 13:24:30 -0500
X-MC-Unique: mS3BRYo6OaWzbCRjgfUieQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D709C386914A;
 Mon,  8 Jan 2024 18:24:29 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B219E3C2E;
 Mon,  8 Jan 2024 18:24:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 17/29] qom: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:53 +0000
Message-ID: <20240108182405.1135436-18-berrange@redhat.com>
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
 qom/object.c            | 12 ++++++------
 qom/object_interfaces.c |  8 ++++----
 qom/qom-hmp-cmds.c      |  4 ++--
 qom/qom-qmp-cmds.c      |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 654e1afaf2..16c2b467fc 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -23,17 +23,17 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qerror.h"
+#include "qobject/qjson.h"
 #include "trace.h"
 
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
  * of the QOM core on QObject?  */
 #include "qom/qom-qobject.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/error-report.h"
 
 #define MAX_INTERFACES 32
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e0833c8bfe..756edd04d6 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -3,10 +3,10 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-qom.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qobject.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
+#include "qobject/qjson.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qom/object_interfaces.h"
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 6e3a2175a4..a00a564b1e 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -11,8 +11,8 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qom.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 #include "qemu/readline.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 7c087299de..1e36d4a8ce 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -20,8 +20,8 @@
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qapi-visit-qom.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/cutils.h"
-- 
2.43.0


