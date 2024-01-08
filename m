Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC2282776E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:27:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIm-00032A-S3; Mon, 08 Jan 2024 13:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIc-0002y0-AF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIa-0002ry-Ht
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrTYwZDITDCBIGppvq9Rw6BNpuT428E6qOPMp/mcxOw=;
 b=dchE2WYWYwrByWdpSL2aJQQQtJQRspz4oRT66oAoitB2+6rnx/L9eteodxqGYXURKD+Jut
 6zemhVoecKqxmOSAz0GK3hBDeWY33PHMUFGimqVO7j9RDJeow3njckepkkLAxWOfH+sYVT
 1sFBX2dG8hZalu0it17cRj4INDI186s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-TgSK3mFEO_OVspFvDASejw-1; Mon,
 08 Jan 2024 13:24:28 -0500
X-MC-Unique: TgSK3mFEO_OVspFvDASejw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AB1F29AA38E;
 Mon,  8 Jan 2024 18:24:28 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 954F53C2E;
 Mon,  8 Jan 2024 18:24:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 16/29] qobject: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:52 +0000
Message-ID: <20240108182405.1135436-17-berrange@redhat.com>
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
 qobject/block-qdict.c      |  8 ++++----
 qobject/json-parser-int.h  |  2 +-
 qobject/json-parser.c      | 12 ++++++------
 qobject/json-writer.c      |  2 +-
 qobject/qbool.c            |  2 +-
 qobject/qdict.c            | 10 +++++-----
 qobject/qjson.c            | 16 ++++++++--------
 qobject/qlist.c            | 10 +++++-----
 qobject/qlit.c             | 14 +++++++-------
 qobject/qnull.c            |  2 +-
 qobject/qnum.c             |  2 +-
 qobject/qobject-internal.h |  2 +-
 qobject/qobject.c          | 12 ++++++------
 qobject/qstring.c          |  2 +-
 14 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 4a83bda2c3..d0e1c63cf6 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -9,10 +9,10 @@
 
 #include "qemu/osdep.h"
 #include "block/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index 16a25d00bb..8c01f23627 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -14,7 +14,7 @@
 #ifndef JSON_PARSER_INT_H
 #define JSON_PARSER_INT_H
 
-#include "qapi/qmp/json-parser.h"
+#include "qobject/json-parser.h"
 
 typedef enum json_token_type {
     JSON_ERROR = 0,             /* must be zero, see json_lexer[] */
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index d498db6e70..7483e582fe 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -16,12 +16,12 @@
 #include "qemu/cutils.h"
 #include "qemu/unicode.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "json-parser-int.h"
 
 struct JSONToken {
diff --git a/qobject/json-writer.c b/qobject/json-writer.c
index 309a31d57a..aac2c6ab71 100644
--- a/qobject/json-writer.c
+++ b/qobject/json-writer.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu/unicode.h"
 
 struct JSONWriter {
diff --git a/qobject/qbool.c b/qobject/qbool.c
index c7049c0c50..00d7066aae 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
+#include "qobject/qbool.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 8faff230d3..a90ac9ae2f 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qbool.h"
+#include "qobject/qnull.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 167fcb429c..c858dafb5e 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -13,14 +13,14 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/json-writer.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/json-parser.h"
+#include "qobject/json-writer.h"
+#include "qobject/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 typedef struct JSONParsingState {
     JSONMessageParser parser;
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 356ad946b0..41e6876d5b 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/queue.h"
 #include "qobject-internal.h"
 
diff --git a/qobject/qlit.c b/qobject/qlit.c
index be8332136c..2028cbffb5 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -15,13 +15,13 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qlit.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qlit.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
+#include "qobject/qnull.h"
 
 static bool qlit_equal_qdict(const QLitObject *lhs, const QDict *qdict)
 {
diff --git a/qobject/qnull.c b/qobject/qnull.c
index 445a5db7f3..0fb78cbd0a 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qobject-internal.h"
 
 QNull qnull_ = {
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 2bbeaedc7b..7df7a7418c 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qnum.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qobject-internal.h b/qobject/qobject-internal.h
index b310c8e1b5..0c7679fe98 100644
--- a/qobject/qobject-internal.h
+++ b/qobject/qobject-internal.h
@@ -10,7 +10,7 @@
 #ifndef QOBJECT_INTERNAL_H
 #define QOBJECT_INTERNAL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 static inline void qobject_init(QObject *obj, QType type)
 {
diff --git a/qobject/qobject.c b/qobject/qobject.c
index d7077b8f2a..78d1e057c1 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -8,12 +8,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 QEMU_BUILD_BUG_MSG(
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 794f8c9357..d316604914 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 /**
-- 
2.43.0


