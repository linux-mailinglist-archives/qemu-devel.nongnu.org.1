Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5407C8D9C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYJ-0006vK-Mf; Fri, 13 Oct 2023 15:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNXz-0006am-Tq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNXs-0001cp-S2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S55iOiMBHLn7mCEBQzBqeCldmVsvG97z++Q+ZUFBvvA=;
 b=YVrBwxrSjY/d59+iyerBhQuTij3oKDWAMI8cYT7GDSzuEvs0u25XCi621mLUMtQ6t+otlB
 qy+AEnqyoXLSwdCgI0hoQnyiCpJpSwhW9/TV4y2GMQR7/OYcJuxtYTd0NdyK997k0VJeQd
 oI1x7YiqKLY9rOkn+8YMAnntn6KTAwk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-PEWdQaN_ODmPQDXEChByeg-1; Fri, 13 Oct 2023 15:09:58 -0400
X-MC-Unique: PEWdQaN_ODmPQDXEChByeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C3CE3C17128;
 Fri, 13 Oct 2023 19:09:56 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 240B940C6CA0;
 Fri, 13 Oct 2023 19:09:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 10/25] Python: Enable python3.12 support
Date: Fri, 13 Oct 2023 15:09:25 -0400
Message-ID: <20231013190941.3699288-11-jsnow@redhat.com>
In-Reply-To: <20231013190941.3699288-1-jsnow@redhat.com>
References: <20231013190941.3699288-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-id: 20231006195243.3131140-5-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure                              | 3 ++-
 python/setup.cfg                       | 3 ++-
 tests/docker/dockerfiles/python.docker | 6 +++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a49fc7b7e7..96d0dd5ffc 100755
--- a/configure
+++ b/configure
@@ -562,7 +562,8 @@ first_python=
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


