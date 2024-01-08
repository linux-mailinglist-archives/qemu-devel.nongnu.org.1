Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0A82775F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:25:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIY-0002wM-I0; Mon, 08 Jan 2024 13:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIW-0002vR-Fh
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIU-0002o4-QF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tp3Y3qJNE0Res8y52eCRkco1Vwi5WgQje0lD3O6u3Gk=;
 b=DEjIcWcj0Za4ujgvzavBw+KnGS/Z9+wZZqINvvX3HwRIvBQUUDEXh+8SyqI70Zsil+DGPp
 bmMjtnvxL8Psmp9d+mOcko4k19g2mztWWfBGr7CuALG+9mNKbFHk1whTwGRS9F3LrrKZeH
 euNQgvDGThN2Fgb7p3xmiYxAPsMEXTA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-4-Jf5AQvOZme5QO5hWBHcw-1; Mon,
 08 Jan 2024 13:24:21 -0500
X-MC-Unique: 4-Jf5AQvOZme5QO5hWBHcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5FE229AB3E5;
 Mon,  8 Jan 2024 18:24:20 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA60C3C2E;
 Mon,  8 Jan 2024 18:24:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/29] include: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:46 +0000
Message-ID: <20240108182405.1135436-11-berrange@redhat.com>
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
 include/block/qdict.h     | 2 +-
 include/qobject/qbool.h   | 2 +-
 include/qobject/qdict.h   | 2 +-
 include/qobject/qlist.h   | 2 +-
 include/qobject/qnull.h   | 2 +-
 include/qobject/qnum.h    | 2 +-
 include/qobject/qobject.h | 2 +-
 include/qobject/qstring.h | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/block/qdict.h b/include/block/qdict.h
index b4c28d96a9..53c4df4cb2 100644
--- a/include/block/qdict.h
+++ b/include/block/qdict.h
@@ -10,7 +10,7 @@
 #ifndef BLOCK_QDICT_H
 #define BLOCK_QDICT_H
 
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 QObject *qdict_crumple(const QDict *src, Error **errp);
 void qdict_flatten(QDict *qdict);
diff --git a/include/qobject/qbool.h b/include/qobject/qbool.h
index 0d09726939..b348e17867 100644
--- a/include/qobject/qbool.h
+++ b/include/qobject/qbool.h
@@ -14,7 +14,7 @@
 #ifndef QBOOL_H
 #define QBOOL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QBool {
     struct QObjectBase_ base;
diff --git a/include/qobject/qdict.h b/include/qobject/qdict.h
index 82e90fc072..903e6e5462 100644
--- a/include/qobject/qdict.h
+++ b/include/qobject/qdict.h
@@ -13,7 +13,7 @@
 #ifndef QDICT_H
 #define QDICT_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qemu/queue.h"
 
 #define QDICT_BUCKET_MAX 512
diff --git a/include/qobject/qlist.h b/include/qobject/qlist.h
index e4e985d435..0377bf824e 100644
--- a/include/qobject/qlist.h
+++ b/include/qobject/qlist.h
@@ -13,7 +13,7 @@
 #ifndef QLIST_H
 #define QLIST_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qemu/queue.h"
 
 typedef struct QListEntry {
diff --git a/include/qobject/qnull.h b/include/qobject/qnull.h
index 7feb7c7d83..4423836a0c 100644
--- a/include/qobject/qnull.h
+++ b/include/qobject/qnull.h
@@ -13,7 +13,7 @@
 #ifndef QNULL_H
 #define QNULL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QNull {
     struct QObjectBase_ base;
diff --git a/include/qobject/qnum.h b/include/qobject/qnum.h
index e86788dd2e..1ce24b3668 100644
--- a/include/qobject/qnum.h
+++ b/include/qobject/qnum.h
@@ -15,7 +15,7 @@
 #ifndef QNUM_H
 #define QNUM_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 typedef enum {
     QNUM_I64,
diff --git a/include/qobject/qobject.h b/include/qobject/qobject.h
index 89b97d88bc..35f9693b84 100644
--- a/include/qobject/qobject.h
+++ b/include/qobject/qobject.h
@@ -34,7 +34,7 @@
 
 #include "qapi/qapi-builtin-types.h"
 
-/* Not for use outside include/qapi/qmp/ */
+/* Not for use outside include/qobject/ */
 struct QObjectBase_ {
     QType type;
     size_t refcnt;
diff --git a/include/qobject/qstring.h b/include/qobject/qstring.h
index 318d815d6a..1e2abe4032 100644
--- a/include/qobject/qstring.h
+++ b/include/qobject/qstring.h
@@ -13,7 +13,7 @@
 #ifndef QSTRING_H
 #define QSTRING_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QString {
     struct QObjectBase_ base;
-- 
2.43.0


