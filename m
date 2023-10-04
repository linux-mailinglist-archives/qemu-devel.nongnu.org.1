Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC1F7B988C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 01:07:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoAw1-0003zg-LG; Wed, 04 Oct 2023 19:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoAw0-0003yb-4Y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 19:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoAvx-0002dN-Dr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 19:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696460735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KO7oBP2I1Uj/ILjl+BioKvTph+cZsBo9J5Glc3qcj2g=;
 b=MNmtry2swdJHSoU3My+8GhcP8Htt8faiLu/+aXeGhBNVrB5K9hTlYcz1EtjYqM7vQJgOHM
 Rcli5Wx1KQVDtCApZ5f2oBQX+HGI9wdoM1AFzcSmQ62P2+A4kMmOoRW6pF6Y9XnSE3lWHP
 S3pmmGGW9H0tcipXv3Qhps91FQEDBnw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-2gf85Jo9PyCscduPxgaPcw-1; Wed, 04 Oct 2023 19:05:34 -0400
X-MC-Unique: 2gf85Jo9PyCscduPxgaPcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFA09282380D;
 Wed,  4 Oct 2023 23:05:33 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB810C15BB8;
 Wed,  4 Oct 2023 23:05:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v5 2/3] [DO-NOT-MERGE]: Add some ad-hoc linting helpers.
Date: Wed,  4 Oct 2023 19:05:31 -0400
Message-ID: <20231004230532.3002201-3-jsnow@redhat.com>
In-Reply-To: <20231004230532.3002201-1-jsnow@redhat.com>
References: <20231004230532.3002201-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

These aren't ready for upstream inclusion, because they do not properly
manage version dependencies, execution environment and so on. These are
just the tools I use in my Own Special Environment :tm: for testing and
debugging.

They've been tested only on Fedora 38 for right now, which means:

Python 3.11.4-1.fc38
pylint 2.17.4-2.fc38
mypy 1.4.0-1.fc38
isort 5.12.0-1.fc38
flake8 5.0.3-2.fc38

The python packaging work does a more exhaustive treatment and
exploration of minimum (and maximum) package requirements; the hope is
that eventually these two series will converge and these dependencies
will all be handled by configuration in qemu.git/python/.

For now, this is just a baseline under one environment to give us some
guidance.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi-lint.sh  | 29 +++++++++++++++++++++++++++++
 scripts/qapi/Makefile |  5 +++++
 2 files changed, 34 insertions(+)
 create mode 100755 scripts/qapi-lint.sh
 create mode 100644 scripts/qapi/Makefile

diff --git a/scripts/qapi-lint.sh b/scripts/qapi-lint.sh
new file mode 100755
index 0000000000..6072f389a2
--- /dev/null
+++ b/scripts/qapi-lint.sh
@@ -0,0 +1,29 @@
+#!/usr/bin/env bash
+set -e
+
+if [[ -f qapi/.flake8 ]]; then
+    echo "flake8 --config=qapi/.flake8 qapi/"
+    flake8 --config=qapi/.flake8 qapi/
+fi
+if [[ -f qapi/pylintrc ]]; then
+    echo "pylint --rcfile=qapi/pylintrc qapi/"
+    pylint --rcfile=qapi/pylintrc qapi/
+fi
+if [[ -f qapi/mypy.ini ]]; then
+    echo "mypy --config-file=qapi/mypy.ini qapi/"
+    mypy --config-file=qapi/mypy.ini qapi/
+fi
+
+if [[ -f qapi/.isort.cfg ]]; then
+    pushd qapi
+    echo "isort -c ."
+    isort -c .
+    popd
+fi
+
+pushd ../build
+make -j13
+make check-qapi-schema
+make docs
+make sphinxdocs
+popd
diff --git a/scripts/qapi/Makefile b/scripts/qapi/Makefile
new file mode 100644
index 0000000000..314e8a5505
--- /dev/null
+++ b/scripts/qapi/Makefile
@@ -0,0 +1,5 @@
+check:
+	isort -c .
+	flake8 .
+	cd .. && pylint --rcfile=qapi/pylintrc qapi
+	cd .. && mypy -p qapi --config-file=qapi/mypy.ini
-- 
2.41.0


