Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB9A4F593
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 04:47:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfiH-0005KP-Po; Tue, 04 Mar 2025 22:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiF-0005KB-MR
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiD-0005zs-VK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSTcrgIm/gu5mC8r1knFzmlq8huuqEckgCBNTahOciY=;
 b=e073VoBra/+6BmQrXdGoxuVNXtrCz/omAMrAWC9x2FO+wrUsooItQKb9VyKVOzhdyXQdJG
 ruLsxeWasoyHy4q/gpu/nOG/FsAxK42Mv1TrJewwDVSbL2RZqtBSDcMhDZUEe6VVMoKxS6
 BqlLhOfaNG23XzEU4ONZqZ81UqFECns=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-2WtA5FHHM1KG2t0HGj1LhA-1; Tue,
 04 Mar 2025 22:46:20 -0500
X-MC-Unique: 2WtA5FHHM1KG2t0HGj1LhA-1
X-Mimecast-MFC-AGG-ID: 2WtA5FHHM1KG2t0HGj1LhA_1741146379
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A811B180025E; Wed,  5 Mar 2025 03:46:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9A961956095; Wed,  5 Mar 2025 03:46:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 01/57] do-not-merge
Date: Tue,  4 Mar 2025 22:45:10 -0500
Message-ID: <20250305034610.960147-2-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Ad-hoc linting scripts to scrub down the new docs/sphinx files. Should
work with a reasonably modern mypy/pylint/etc, and Sphinx 8.2.0. Older
versions of Sphinx ought to still work at runtime, but may not type
check correctly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi-lint.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 scripts/qapi-lint.sh

diff --git a/scripts/qapi-lint.sh b/scripts/qapi-lint.sh
new file mode 100755
index 00000000000..0e3ff002b69
--- /dev/null
+++ b/scripts/qapi-lint.sh
@@ -0,0 +1,55 @@
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
+if [[ -f ../docs/sphinx/qapi_domain.py ]]; then
+    files="qapi_domain.py"
+fi
+if [[ -f ../docs/sphinx/compat.py ]]; then
+    files="${files} compat.py"
+fi
+if [[ -f ../docs/sphinx/collapse.py ]]; then
+    files="${files} collapse.py"
+fi
+
+if [[ -f ../docs/sphinx/qapi_domain.py ]]; then
+    pushd ../docs/sphinx
+
+    set -x
+    mypy --strict $files
+    flake8 --max-line-length=80 $files qapidoc.py
+    isort -c $files qapidoc.py
+    black --line-length 80 --check $files qapidoc.py
+    PYTHONPATH=../../scripts/ pylint \
+        --rc-file ../../scripts/qapi/pylintrc \
+        $files qapidoc.py
+    set +x
+
+    popd
+fi
+
+pushd ../build
+make -j13
+make check-qapi-schema
+make docs
+make sphinxdocs
+popd
-- 
2.48.1


