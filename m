Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F324704B6C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysQ5-0002H9-9k; Tue, 16 May 2023 07:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPD-0001WQ-Jc
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP6-00087v-2d
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktxuVoeCftsXoioRTwebbxI5P4dwKOFzWaEcjYs2LFM=;
 b=coVAl7X/dD21tISw3utBKYOGjnN34VZkzGMnLthDGSqTo508ZbgPWlMQgCaSShe8XEU3sx
 Tjv+k9B+BlgLdANW+h0kx8JoYP0VNiHvlO/0Fj/XjHog5u6ijIcKdcaHEABdOd6urLVsL2
 q5phrr4vpiXGFzvA/BPYu2hZ1b9lDtk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-X9eAO-jZPxGyN6wlRACfLg-1; Tue, 16 May 2023 06:59:29 -0400
X-MC-Unique: X9eAO-jZPxGyN6wlRACfLg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08A37185A78B;
 Tue, 16 May 2023 10:59:29 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C01F492B00;
 Tue, 16 May 2023 10:59:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 16/27] configure: create a python venv unconditionally
Date: Tue, 16 May 2023 12:58:57 +0200
Message-Id: <20230516105908.527838-16-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

This patch changes the configure script so that it always creates and
uses a python virtual environment unconditionally.

Meson bootstrapping is temporarily altered to force the use of meson
from git or vendored source (as packaged in our source tarballs). A
subsequent commit restores the use of distribution-vendored Meson.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-16-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 243e2e0a0dbc..1d7db92ee3f9 100755
--- a/configure
+++ b/configure
@@ -625,7 +625,6 @@ check_py_version() {
 python=
 first_python=
 if test -z "${PYTHON}"; then
-    explicit_python=no
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
     for binary in python3 python python3.11 python3.10 python3.9 python3.8 python3.7 python3.6; do
@@ -644,7 +643,6 @@ else
     # Same as above, but only check the environment variable.
     has "${PYTHON}" || error_exit "The PYTHON environment variable does not point to an executable"
     python=$(command -v "$PYTHON")
-    explicit_python=yes
     if check_py_version "$python"; then
         # This one is good.
         first_python=
@@ -729,7 +727,7 @@ for opt do
   ;;
   --install=*)
   ;;
-  --python=*) python="$optarg" ; explicit_python=yes
+  --python=*) python="$optarg"
   ;;
   --skip-meson) skip_meson=yes
   ;;
@@ -1090,8 +1088,34 @@ if ! check_py_version "$python"; then
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
-# Resolve PATH + suppress writing compiled files
-python="$(command -v "$python") -B"
+# Resolve PATH
+python="$(command -v "$python")"
+explicit_python=yes
+
+# Create a Python virtual environment using our configured python.
+# The stdout of this script will be the location of a symlink that
+# points to the configured Python.
+# Entry point scripts for pip, meson, and sphinx are generated if those
+# packages are present.
+
+# Defaults assumed for now:
+# - venv is cleared if it exists already;
+# - venv is allowed to use system packages;
+# - all setup is performed **offline**;
+# - No packages are installed by default;
+# - pip is not installed into the venv when possible,
+#   but ensurepip is called as a fallback when necessary.
+
+echo "python determined to be '$python'"
+echo "python version: $($python --version)"
+
+python="$($python -B "${source_path}/python/scripts/mkvenv.py" create pyvenv)"
+if test "$?" -ne 0 ; then
+    error_exit "python venv creation failed"
+fi
+
+# Suppress writing compiled files
+python="$python -B"
 
 has_meson() {
   local python_dir=$(dirname "$python")
-- 
2.40.1



