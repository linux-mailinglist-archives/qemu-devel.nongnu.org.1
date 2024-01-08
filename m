Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F0827761
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:25:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIv-0003E1-GW; Mon, 08 Jan 2024 13:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIs-00034i-Lx
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIq-00031y-3Y
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vpYPBks6eKPtj/ihRQfTyAH5/xAvDDip4pfSvLENTc=;
 b=JW40xWRR6+qEdQIh2+XpucgGLj/T1fS7RZywcSp455neP+xn/vWiE46Rjo4p4pBHfo/eYF
 /7W6krl8uOylB6PbwvexqksVUZkNfUca4C7Col+6DAO0izZTnzRhwsqV11bWyqek+erCid
 fhENBzm7wxuwYdQCHsP6R4oECS4Zlqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-D2tV1BVUOgSaEdFO8zmkbg-1; Mon, 08 Jan 2024 13:24:45 -0500
X-MC-Unique: D2tV1BVUOgSaEdFO8zmkbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 538C283DE2B;
 Mon,  8 Jan 2024 18:24:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 617643C2E;
 Mon,  8 Jan 2024 18:24:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 29/29] qapi: remove header file compatibility symlinks
Date: Mon,  8 Jan 2024 18:24:05 +0000
Message-ID: <20240108182405.1135436-30-berrange@redhat.com>
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

All code is converted to the new 'qobject/' import path, so
the temporary header file compatibility symlinks are now
redundant.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/qmp/dispatch.h    | 1 -
 qapi/qmp/json-parser.h | 1 -
 qapi/qmp/json-writer.h | 1 -
 qapi/qmp/qbool.h       | 1 -
 qapi/qmp/qdict.h       | 1 -
 qapi/qmp/qerror.h      | 1 -
 qapi/qmp/qjson.h       | 1 -
 qapi/qmp/qlist.h       | 1 -
 qapi/qmp/qlit.h        | 1 -
 qapi/qmp/qnull.h       | 1 -
 qapi/qmp/qnum.h        | 1 -
 qapi/qmp/qobject.h     | 1 -
 qapi/qmp/qstring.h     | 1 -
 13 files changed, 13 deletions(-)
 delete mode 120000 qapi/qmp/dispatch.h
 delete mode 120000 qapi/qmp/json-parser.h
 delete mode 120000 qapi/qmp/json-writer.h
 delete mode 120000 qapi/qmp/qbool.h
 delete mode 120000 qapi/qmp/qdict.h
 delete mode 120000 qapi/qmp/qerror.h
 delete mode 120000 qapi/qmp/qjson.h
 delete mode 120000 qapi/qmp/qlist.h
 delete mode 120000 qapi/qmp/qlit.h
 delete mode 120000 qapi/qmp/qnull.h
 delete mode 120000 qapi/qmp/qnum.h
 delete mode 120000 qapi/qmp/qobject.h
 delete mode 120000 qapi/qmp/qstring.h

diff --git a/qapi/qmp/dispatch.h b/qapi/qmp/dispatch.h
deleted file mode 120000
index ffedc3971d..0000000000
--- a/qapi/qmp/dispatch.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qapi/qmp-registry.h
\ No newline at end of file
diff --git a/qapi/qmp/json-parser.h b/qapi/qmp/json-parser.h
deleted file mode 120000
index 059cb73fa8..0000000000
--- a/qapi/qmp/json-parser.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/json-parser.h
\ No newline at end of file
diff --git a/qapi/qmp/json-writer.h b/qapi/qmp/json-writer.h
deleted file mode 120000
index 3e952f4c97..0000000000
--- a/qapi/qmp/json-writer.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/json-writer.h
\ No newline at end of file
diff --git a/qapi/qmp/qbool.h b/qapi/qmp/qbool.h
deleted file mode 120000
index 443c881cf8..0000000000
--- a/qapi/qmp/qbool.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qbool.h
\ No newline at end of file
diff --git a/qapi/qmp/qdict.h b/qapi/qmp/qdict.h
deleted file mode 120000
index 8183614eae..0000000000
--- a/qapi/qmp/qdict.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qdict.h
\ No newline at end of file
diff --git a/qapi/qmp/qerror.h b/qapi/qmp/qerror.h
deleted file mode 120000
index cf210737a3..0000000000
--- a/qapi/qmp/qerror.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qerror.h
\ No newline at end of file
diff --git a/qapi/qmp/qjson.h b/qapi/qmp/qjson.h
deleted file mode 120000
index 85b48c5bfd..0000000000
--- a/qapi/qmp/qjson.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qjson.h
\ No newline at end of file
diff --git a/qapi/qmp/qlist.h b/qapi/qmp/qlist.h
deleted file mode 120000
index d40db0a12b..0000000000
--- a/qapi/qmp/qlist.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qlist.h
\ No newline at end of file
diff --git a/qapi/qmp/qlit.h b/qapi/qmp/qlit.h
deleted file mode 120000
index 5dd5ac8ccb..0000000000
--- a/qapi/qmp/qlit.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qlit.h
\ No newline at end of file
diff --git a/qapi/qmp/qnull.h b/qapi/qmp/qnull.h
deleted file mode 120000
index 944769d44b..0000000000
--- a/qapi/qmp/qnull.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qnull.h
\ No newline at end of file
diff --git a/qapi/qmp/qnum.h b/qapi/qmp/qnum.h
deleted file mode 120000
index 8038e2f4d6..0000000000
--- a/qapi/qmp/qnum.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qnum.h
\ No newline at end of file
diff --git a/qapi/qmp/qobject.h b/qapi/qmp/qobject.h
deleted file mode 120000
index 89d9118cfd..0000000000
--- a/qapi/qmp/qobject.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qobject.h
\ No newline at end of file
diff --git a/qapi/qmp/qstring.h b/qapi/qmp/qstring.h
deleted file mode 120000
index 24f48de18a..0000000000
--- a/qapi/qmp/qstring.h
+++ /dev/null
@@ -1 +0,0 @@
-../../include/qobject/qstring.h
\ No newline at end of file
-- 
2.43.0


