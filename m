Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 959788671FD
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 11:51:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZF-0002lE-5v; Mon, 26 Feb 2024 05:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYe-0002bY-RP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYa-0003jB-9l
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2yzBnFOprxDw+Csx+aeQsNAM+XVPX1VtXlsW4CMXlo=;
 b=NRQ9p/EDMza1u6M+psuJvSawdOAV3WlihHxt/H0O50ND45Lczfq8KTnCcKOpQIG1f42yY+
 AdFdifUMBfQr1b+xqIehC068BOxINsecyjXdy9zw7iZTaGgXOw0atD9dxchUXgibwvZwIf
 Nh3PpkdorD5OA3vxJTyJ0iE9A0fgVW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554--AbrU9UnP4GBZ8YUv5avjQ-1; Mon, 26 Feb 2024 05:49:55 -0500
X-MC-Unique: -AbrU9UnP4GBZ8YUv5avjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB5B3882087;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88D2424D;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CB6621E6691; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/17] tests/qapi-schema: Cover duplicate 'Features:' line
Date: Mon, 26 Feb 2024 11:49:40 +0100
Message-ID: <20240226104954.3781985-4-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

We don't actually recognize the second 'Features:' line.  Instead, we
treat it as an untagged section.

If it was followed by feature description, we'd reject that like
"description of '@feat2:' follows a section".  Less than clear.

To be improved shortly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-3-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qapi-schema/doc-duplicate-features.err  |  0
 tests/qapi-schema/doc-duplicate-features.json | 11 ++++++++++
 tests/qapi-schema/doc-duplicate-features.out  | 22 +++++++++++++++++++
 tests/qapi-schema/meson.build                 |  1 +
 4 files changed, 34 insertions(+)
 create mode 100644 tests/qapi-schema/doc-duplicate-features.err
 create mode 100644 tests/qapi-schema/doc-duplicate-features.json
 create mode 100644 tests/qapi-schema/doc-duplicate-features.out

diff --git a/tests/qapi-schema/doc-duplicate-features.err b/tests/qapi-schema/doc-duplicate-features.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-duplicate-features.json b/tests/qapi-schema/doc-duplicate-features.json
new file mode 100644
index 0000000000..a4d559e740
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicate-features.json
@@ -0,0 +1,11 @@
+# Duplicate 'Features:' line
+
+##
+# @foo:
+#
+# Features:
+# @feat: mumble
+#
+# Features:
+##
+{ 'command': 'foo', 'features': ['feat'] }
diff --git a/tests/qapi-schema/doc-duplicate-features.out b/tests/qapi-schema/doc-duplicate-features.out
new file mode 100644
index 0000000000..43bfe1034b
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicate-features.out
@@ -0,0 +1,22 @@
+module ./builtin
+object q_empty
+enum QType
+    prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+module doc-duplicate-features.json
+command foo None -> None
+    gen=True success_response=True boxed=False oob=False preconfig=False
+    feature feat
+doc symbol=foo
+    body=
+
+    feature=feat
+mumble
+    section=None
+Features:
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 44a9385563..4c714c792f 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -66,6 +66,7 @@ schemas = [
   'doc-bad-union-member.json',
   'doc-before-include.json',
   'doc-before-pragma.json',
+  'doc-duplicate-features.json',
   'doc-duplicated-arg.json',
   'doc-duplicated-return.json',
   'doc-duplicated-since.json',
-- 
2.43.0


