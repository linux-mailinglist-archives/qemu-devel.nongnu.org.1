Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E283704BAE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysQR-0003id-Gr; Tue, 16 May 2023 07:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPI-0001bj-MR
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP7-00088o-7a
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mbxl8QbqXsMqvYzVdZ6VdOCeDAaqOga28d8VP6vA3vI=;
 b=g7Go7HTsGNJKmlyhegy+/TXkzHHrW9n91rGBYnU6AlCKEWitr25ySlePTc5jDZTDUEeUT6
 1q3WAiysNeRVcjk7uOEuSUXCWEBjRXXB+9ehIGL9JnKUmL8BJiYVX6sAwA59VwRyJnp9TP
 QFAfhBs6UYjmMQiv5Aq/N/f/i7XAF84=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-B-KI18o_PY-DFx5z1Y-Y-w-1; Tue, 16 May 2023 06:59:37 -0400
X-MC-Unique: B-KI18o_PY-DFx5z1Y-Y-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B08D2808E61;
 Tue, 16 May 2023 10:59:37 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE1A8492B02;
 Tue, 16 May 2023 10:59:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 18/27] configure: use 'mkvenv ensure meson' to bootstrap
 meson
Date: Tue, 16 May 2023 12:58:59 +0200
Message-Id: <20230516105908.527838-18-pbonzini@redhat.com>
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

This commit changes how we detect and install meson. It notably removes
'--meson='.

Currently, configure creates a lightweight Python virtual environment
unconditionally using the user's configured $python that inherits system
packages. Temporarily, we forced the use of meson source present via git
submodule or in the release tarball.

With this patch, we restore the ability to use a system-provided meson:

If Meson is installed in the build venv and meets our minimum version
requirements, we will use that Meson. This includes a system provided
meson, which would be visible via system-site packages inside the venv.

In the event that Meson is installed but *not for the chosen Python
interpreter*, not found, or of insufficient version, we will attempt to
install Meson from vendored source into the newly created Python virtual
environment. This vendored installation replaces both the git submodule
and tarball source mechanisms for sourcing meson.

As a result of this patch, the Python interpreter we use for both our
own build scripts *and* Meson extensions are always known to be the
exact same Python. As a further benefit, there will also be a symlink
available in the build directory that points to the correct, configured
python and can be used by e.g. manual tests to invoke the correct,
configured Python unambiguously.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-18-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml |  4 +-
 configure                           | 65 +++++------------------------
 2 files changed, 13 insertions(+), 56 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index a6cfe9be970f..7edb50b76035 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -12,12 +12,12 @@
     - mkdir build
     - cd build
     - ../configure --enable-werror --disable-docs --enable-fdt=system
-          ${LD_JOBS:+--meson=git} ${TARGETS:+--target-list="$TARGETS"}
+          ${TARGETS:+--target-list="$TARGETS"}
           $CONFIGURE_ARGS ||
       { cat config.log meson-logs/meson-log.txt && exit 1; }
     - if test -n "$LD_JOBS";
       then
-        ../meson/meson.py configure . -Dbackend_max_links="$LD_JOBS" ;
+        pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
       fi || exit 1;
     - make -j"$JOBS"
     - if test -n "$MAKE_CHECK_ARGS";
diff --git a/configure b/configure
index 1d7db92ee3f9..4519c4d412f8 100755
--- a/configure
+++ b/configure
@@ -289,7 +289,6 @@ bsd_user=""
 pie=""
 coroutine=""
 plugins="$default_feature"
-meson=""
 ninja=""
 bindir="bin"
 skip_meson=no
@@ -731,8 +730,6 @@ for opt do
   ;;
   --skip-meson) skip_meson=yes
   ;;
-  --meson=*) meson="$optarg"
-  ;;
   --ninja=*) ninja="$optarg"
   ;;
   --smbd=*) smbd="$optarg"
@@ -1017,7 +1014,6 @@ Advanced options (experts only):
   --cross-prefix-ARCH=PREFIX cross compiler prefix when building ARCH guest test cases
   --make=MAKE              use specified make [$make]
   --python=PYTHON          use specified python [$python]
-  --meson=MESON            use specified meson [$meson]
   --ninja=NINJA            use specified ninja [$ninja]
   --smbd=SMBD              use specified smbd [$smbd]
   --with-git=GIT           use specified git [$git]
@@ -1090,7 +1086,6 @@ fi
 
 # Resolve PATH
 python="$(command -v "$python")"
-explicit_python=yes
 
 # Create a Python virtual environment using our configured python.
 # The stdout of this script will be the location of a symlink that
@@ -1102,7 +1097,6 @@ explicit_python=yes
 # - venv is cleared if it exists already;
 # - venv is allowed to use system packages;
 # - all setup is performed **offline**;
-# - No packages are installed by default;
 # - pip is not installed into the venv when possible,
 #   but ensurepip is called as a fallback when necessary.
 
@@ -1117,58 +1111,21 @@ fi
 # Suppress writing compiled files
 python="$python -B"
 
-has_meson() {
-  local python_dir=$(dirname "$python")
-  # PEP405: pyvenv.cfg is either adjacent to the Python executable
-  # or one directory above
-  if test -f $python_dir/pyvenv.cfg || test -f $python_dir/../pyvenv.cfg; then
-    # Ensure that Meson and Python come from the same virtual environment
-    test -x "$python_dir/meson" &&
-      test "$(command -v meson)" -ef "$python_dir/meson"
-  else
-    has meson
-  fi
-}
 
-if test -z "$meson"; then
-    if test "$explicit_python" = no && has_meson && version_ge "$(meson --version)" 0.61.5; then
-        meson=meson
-    elif test "$git_submodules_action" != 'ignore' ; then
-        meson=git
-    elif test -e "${source_path}/meson/meson.py" ; then
-        meson=internal
-    else
-        if test "$explicit_python" = yes; then
-            error_exit "--python requires using QEMU's embedded Meson distribution, but it was not found."
-        else
-            error_exit "Meson not found.  Use --meson=/path/to/meson"
-        fi
-    fi
-else
-    # Meson uses its own Python interpreter to invoke other Python scripts,
-    # but the user wants to use the one they specified with --python.
-    #
-    # We do not want to override the distro Python interpreter (and sometimes
-    # cannot: for example in Homebrew /usr/bin/meson is a bash script), so
-    # just require --meson=git|internal together with --python.
-    if test "$explicit_python" = yes; then
-        case "$meson" in
-            git | internal) ;;
-            *) error_exit "--python requires using QEMU's embedded Meson distribution." ;;
-        esac
-    fi
+if ! $python "${source_path}/python/scripts/mkvenv.py" ensure \
+     --dir "${source_path}/python/wheels" \
+     --diagnose "meson" \
+     "meson>=0.61.5" ;
+then
+    exit 1
 fi
 
-if test "$meson" = git; then
-    git_submodules="${git_submodules} meson"
-fi
+# At this point, we expect Meson to be installed and available.
+# We expect mkvenv or pip to have created pyvenv/bin/meson for us.
+# We ignore PATH completely here: we want to use the venv's Meson
+# *exclusively*.
 
-case "$meson" in
-    git | internal)
-        meson="$python ${source_path}/meson/meson.py"
-        ;;
-    *) meson=$(command -v "$meson") ;;
-esac
+meson="$(cd pyvenv/bin; pwd)/meson"
 
 # Probe for ninja
 
-- 
2.40.1



