Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF1A581A6
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:36:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC8i-0000qO-Ks; Sun, 09 Mar 2025 04:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC8g-0000lZ-68
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC8e-000202-PK
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTnyTcBpC/OVMX6Bu6QPtWsGEQm0cp5L1qOn9B7o+U4=;
 b=EPl2zZ2xIPt+NDPoMNkTniKxGEjRomamZ4OtwPfF/b/z+kVM10md7ZvjW2zEBsrsOBHI07
 XWduYRcjDgIeiO3EinAevA6jSVDyj9H8sW8avwE9NoQFxDCEiTKmEAj7kpllS90K7QIKlh
 QEmvILqNzWRHC6WOdqZwtoh939/QAHY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-5sbeGjVsMequkd_m-vsvrw-1; Sun,
 09 Mar 2025 04:35:56 -0400
X-MC-Unique: 5sbeGjVsMequkd_m-vsvrw-1
X-Mimecast-MFC-AGG-ID: 5sbeGjVsMequkd_m-vsvrw_1741509355
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6926119560A3; Sun,  9 Mar 2025 08:35:55 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A928F19560AB; Sun,  9 Mar 2025 08:35:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 01/62] do-not-merge
Date: Sun,  9 Mar 2025 04:34:48 -0400
Message-ID: <20250309083550.5155-2-jsnow@redhat.com>
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

Ad-hoc linting scripts to scrub down the new docs/sphinx files. Should
work with a reasonably modern mypy/pylint/etc, and Sphinx 8.2.0. Older
versions of Sphinx ought to still work at runtime, but may not type
check correctly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi-lint.sh | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100755 scripts/qapi-lint.sh

diff --git a/scripts/qapi-lint.sh b/scripts/qapi-lint.sh
new file mode 100755
index 00000000000..738490352cd
--- /dev/null
+++ b/scripts/qapi-lint.sh
@@ -0,0 +1,57 @@
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
+#make -j13
+make check-qapi-schema
+rm -rf docs/
+#make docs
+#make sphinxdocs
+time pyvenv/bin/sphinx-build -v -j 8 -b html -d docs/manual.p/ ../docs/ docs/manual/;
+popd
-- 
2.48.1


