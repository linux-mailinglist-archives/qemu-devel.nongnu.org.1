Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0B47BBFE5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 21:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoqsa-0002ck-1W; Fri, 06 Oct 2023 15:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoqsY-0002a1-1M
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoqsV-0007lo-H1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696621970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9u5s5k/Vlu/Eqbdd36ra04/gMkq5yE2Yd/0Hn7i/Ps=;
 b=PO0tZc31dormGurvDbCmEivVKet4poQiSuP2ijtRFk8dJDOc1qiUMvks8L00UPNaEMK8DC
 2ZwEzTsDrD9Ir/q5NzvI6kgzPNW04/4rQH2Ioy7spqBvApkDadWVmusz6/0IeGLceiMcAp
 wwpJCm6WblajhpgakxAIEUPbBM5csHg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-yAiDrEyOMe-WPxrB6js0Uw-1; Fri, 06 Oct 2023 15:52:47 -0400
X-MC-Unique: yAiDrEyOMe-WPxrB6js0Uw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D3BB3C108DD;
 Fri,  6 Oct 2023 19:52:47 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0CDF492C37;
 Fri,  6 Oct 2023 19:52:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] Python: Enable python3.12 support
Date: Fri,  6 Oct 2023 15:52:43 -0400
Message-ID: <20231006195243.3131140-5-jsnow@redhat.com>
In-Reply-To: <20231006195243.3131140-1-jsnow@redhat.com>
References: <20231006195243.3131140-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Python 3.12 has released, so update the test infrastructure to test
against this version. Update the configure script to look for it when an
explicit Python interpreter isn't chosen.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure                              | 3 ++-
 python/setup.cfg                       | 3 ++-
 tests/docker/dockerfiles/python.docker | 6 +++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index e9a921ffb0..b480a3d6ae 100755
--- a/configure
+++ b/configure
@@ -561,7 +561,8 @@ first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
-    for binary in python3 python python3.11 python3.10 python3.9 python3.8; do
+    for binary in python3 python python3.12 python3.11 \
+                          python3.10 python3.9 python3.8; do
         if has "$binary"; then
             python=$(command -v "$binary")
             if check_py_version "$python"; then
diff --git a/python/setup.cfg b/python/setup.cfg
index 8c67dce457..48668609d3 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -18,6 +18,7 @@ classifiers =
     Programming Language :: Python :: 3.9
     Programming Language :: Python :: 3.10
     Programming Language :: Python :: 3.11
+    Programming Language :: Python :: 3.12
     Typing :: Typed
 
 [options]
@@ -182,7 +183,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py38, py39, py310, py311
+envlist = py38, py39, py310, py311, py312
 skip_missing_interpreters = true
 
 [testenv]
diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
index 383ccbdc3a..a3c1321190 100644
--- a/tests/docker/dockerfiles/python.docker
+++ b/tests/docker/dockerfiles/python.docker
@@ -11,7 +11,11 @@ ENV PACKAGES \
     python3-pip \
     python3-tox \
     python3-virtualenv \
-    python3.10
+    python3.10 \
+    python3.11 \
+    python3.12 \
+    python3.8 \
+    python3.9
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.41.0


