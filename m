Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE87827768
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:26:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIv-0003EP-JN; Mon, 08 Jan 2024 13:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIt-00037l-Fx
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIq-00032D-6n
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjR5dCjPeNJ7af2OvlqIZZTxwXElsG/hpKk4bX/ri0A=;
 b=c1f5Eo7F8OIN1sJebsVWIzQsCO52dDzkHOW5vsj5Q+GPlchr1pbQD8pgDzFn4AL18iBMxk
 LXiUyvbO1/9SKkjrZwiOsFkRQ0x8VoVMxOVHF++iy4ZL95oCFV77swNJKLPhWyzgCUyWL7
 JBasIHJr+8+DLe3QDf4Pxiys4jN/pDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-vtuvQD-TMaWt8OjdE4-rsQ-1; Mon, 08 Jan 2024 13:24:44 -0500
X-MC-Unique: vtuvQD-TMaWt8OjdE4-rsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FA0F185A780;
 Mon,  8 Jan 2024 18:24:44 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 421063C2E;
 Mon,  8 Jan 2024 18:24:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 28/29] util: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:24:04 +0000
Message-ID: <20240108182405.1135436-29-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/block-helpers.c |  2 +-
 util/keyval.c        |  6 +++---
 util/qemu-config.c   |  4 ++--
 util/qemu-option.c   | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/util/block-helpers.c b/util/block-helpers.c
index c4851432f5..724c4ce8eb 100644
--- a/util/block-helpers.c
+++ b/util/block-helpers.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "block-helpers.h"
 
 /**
diff --git a/util/keyval.c b/util/keyval.c
index 66a5b4740f..a70629a481 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -91,9 +91,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/keyval.h"
 #include "qemu/help_option.h"
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 42076efe1e..7b8bda1645 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -2,8 +2,8 @@
 #include "block/qdict.h" /* for qdict_extract_subqdict() */
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/util/qemu-option.c b/util/qemu-option.c
index eedd08929b..9399314334 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -27,11 +27,11 @@
 
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
+#include "qobject/qerror.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"
-- 
2.43.0


