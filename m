Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA299A212B
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 13:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Opu-0000lc-18; Thu, 17 Oct 2024 07:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Om6-00042p-LB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Om2-0005vP-1I
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezyxCX/joe1lrrTV2aGJyVGHy4GseC4Ee1IkWlnZrG8=;
 b=I+0aBlTKICOKFx+a2JOCufbFC8tJ8F0Dw29kbgJzSqj49S4b0LYfiRziHsnopfxd94hsvM
 1nUBkxPq88/HtV0F9BcwEHp4vfjw2nHoRjIbRVn0qemnvkKGfTiAm3Wb73l0579RHCckis
 VWii8kXosK/KUkONFl+1GTvrD614Iuk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-XkO5soyNO5a8R2_eajFYMQ-1; Thu,
 17 Oct 2024 07:34:18 -0400
X-MC-Unique: XkO5soyNO5a8R2_eajFYMQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 172B21955D5E
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:18 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFEE319560A2; Thu, 17 Oct 2024 11:34:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 17/31] qom: adapt to new import path for qobject data type
 headers
Date: Thu, 17 Oct 2024 12:33:29 +0100
Message-ID: <20241017113344.883424-18-berrange@redhat.com>
In-Reply-To: <20241017113344.883424-1-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c            | 10 +++++-----
 qom/object_interfaces.c |  6 +++---
 qom/qom-hmp-cmds.c      |  4 ++--
 qom/qom-qmp-cmds.c      |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 11424cf471..f2fd40203e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -23,16 +23,16 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qjson.h"
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
index e0833c8bfe..c752d4f730 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -3,10 +3,10 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-qom.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qobject.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qjson.h"
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
index e91a235347..7880da3566 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -20,7 +20,7 @@
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qapi-visit-qom.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
-- 
2.46.0


