Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFEAA58223
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:45:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC8x-0000zO-49; Sun, 09 Mar 2025 04:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC8m-0000wg-9o
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC8j-00020Y-Vs
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6J7XV2pz9K4lcnoMlwTmYafdmucGU2ELW90WE6iCAw=;
 b=BwfuKJYnRSXFNjt4Pgre6y1Za7g89lMqYXqEcg1px93S10brgMzM7zYpjT3i0eCsKaFGj9
 VJ0q49dNzJCHe4jfF6PY84wpbE4W5so0AeCWgRUyUieuKH1dT/oMWlDx7ctSoGAUzv6Tp2
 mIjebW5IXEEH8+9hzTxCzVilpMCPbMQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-NJZFoBGCN1WKTps1lZjl_Q-1; Sun,
 09 Mar 2025 04:35:58 -0400
X-MC-Unique: NJZFoBGCN1WKTps1lZjl_Q-1
X-Mimecast-MFC-AGG-ID: NJZFoBGCN1WKTps1lZjl_Q_1741509357
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 656B61956087; Sun,  9 Mar 2025 08:35:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A706719560AB; Sun,  9 Mar 2025 08:35:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 02/62] qapi: shush pylint up
Date: Sun,  9 Mar 2025 04:34:49 -0400
Message-ID: <20250309083550.5155-3-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Shhhhh!

This patch is RFC quality, I wasn't in the mood to actually solve
problems so much as I was in the mood to continue working on the Sphinx
rework. Plus, I don't think the code I am patching has hit origin/master
yet ...

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/backend.py | 2 ++
 scripts/qapi/main.py    | 8 +++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 14e60aa67af..49ae6ecdd33 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -13,6 +13,7 @@
 
 
 class QAPIBackend(ABC):
+    # pylint: disable=too-few-public-methods
 
     @abstractmethod
     def generate(self,
@@ -36,6 +37,7 @@ def generate(self,
 
 
 class QAPICBackend(QAPIBackend):
+    # pylint: disable=too-few-public-methods
 
     def generate(self,
                  schema: QAPISchema,
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 5b4679abcf1..01155373bd0 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -38,8 +38,7 @@ def create_backend(path: str) -> QAPIBackend:
     try:
         mod = import_module(module_path)
     except Exception as ex:
-        print(f"unable to import '{module_path}': {ex}", file=sys.stderr)
-        sys.exit(1)
+        raise QAPIError(f"unable to import '{module_path}': {ex}") from ex
 
     try:
         klass = getattr(mod, class_name)
@@ -51,9 +50,8 @@ def create_backend(path: str) -> QAPIBackend:
     try:
         backend = klass()
     except Exception as ex:
-        print(f"backend '{path}' cannot be instantiated: {ex}",
-              file=sys.stderr)
-        sys.exit(1)
+        raise QAPIError(
+            f"backend '{path}' cannot be instantiated: {ex}") from ex
 
     if not isinstance(backend, QAPIBackend):
         print(f"backend '{path}' must be an instance of QAPIBackend",
-- 
2.48.1


