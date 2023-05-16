Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A095F704BAD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:04:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysQY-0004KX-D0; Tue, 16 May 2023 07:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPL-0001ch-Cg
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPC-0008BC-7r
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jc/DZTJO53ltzHnHfWoowuFnwuR2C2M5E+k0UgdTkwU=;
 b=P+dLN/9m4Bn0JK5/AXCq60UkTWa9lVyygMtZbAa1hLCbbObwHjfGzU2ABoo/4s0AHp1itS
 Lm+zWBnjlehMFaIfKiQdndoe4y92cOVRCNDdwsLdCKOa+/LNN2MHTAUpe9NpKX3HxxnTMh
 WZTB4HrQPrn/Xn8YXAchSY9GQx7LcxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-BkqgbSi4MjSNNyAda83vMQ-1; Tue, 16 May 2023 06:59:42 -0400
X-MC-Unique: BkqgbSi4MjSNNyAda83vMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2067487DC01;
 Tue, 16 May 2023 10:59:42 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41B6E492B00;
 Tue, 16 May 2023 10:59:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 22/27] configure: bootstrap sphinx with mkvenv
Date: Tue, 16 May 2023 12:59:03 +0200
Message-Id: <20230516105908.527838-22-pbonzini@redhat.com>
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

When docs are explicitly requested, require Sphinx>=1.6.0. When docs are
explicitly disabled, don't bother to check for Sphinx at all. If docs
are set to "auto", attempt to locate Sphinx, but continue onward if it
wasn't located.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-22-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 21 +++++++++++++++++++--
 docs/conf.py                  |  9 ---------
 docs/meson.build              |  2 +-
 meson_options.txt             |  2 --
 scripts/meson-buildoptions.sh |  3 ---
 5 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index f8308926bbc6..e8059bd5cb15 100755
--- a/configure
+++ b/configure
@@ -1115,9 +1115,9 @@ fi
 
 # Suppress writing compiled files
 python="$python -B"
+mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
-
-if ! $python "${source_path}/python/scripts/mkvenv.py" ensure \
+if ! $mkvenv ensure \
      --dir "${source_path}/python/wheels" \
      --diagnose "meson" \
      "meson>=0.61.5" ;
@@ -1132,6 +1132,23 @@ fi
 
 meson="$(cd pyvenv/bin; pwd)/meson"
 
+# Conditionally ensure Sphinx is installed.
+
+if test "$docs" != "disabled" ; then
+    if ! $mkvenv ensure \
+         --diagnose "sphinx-build" \
+         "sphinx>=1.6.0" sphinx_rtd_theme;
+    then
+        if test "$docs" = "enabled" ; then
+            exit 1
+        fi
+        echo "Sphinx not found/usable, disabling docs."
+        docs=disabled
+    else
+        docs=enabled
+    fi
+fi
+
 # Probe for ninja
 
 if test -z "$ninja"; then
diff --git a/docs/conf.py b/docs/conf.py
index 00767b0e24fb..c687ff266301 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -32,15 +32,6 @@
 from distutils.version import LooseVersion
 from sphinx.errors import ConfigError
 
-# Make Sphinx fail cleanly if using an old Python, rather than obscurely
-# failing because some code in one of our extensions doesn't work there.
-# In newer versions of Sphinx this will display nicely; in older versions
-# Sphinx will also produce a Python backtrace but at least the information
-# gets printed...
-if sys.version_info < (3,6):
-    raise ConfigError(
-        "QEMU requires a Sphinx that uses Python 3.6 or better\n")
-
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
 # otherwise set it here if this is an entire-manual-set build.
 # This is always the absolute path of the docs/ directory in the source tree.
diff --git a/docs/meson.build b/docs/meson.build
index 6d0986579e17..9040f860ae1a 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -1,4 +1,4 @@
-sphinx_build = find_program(get_option('sphinx_build'),
+sphinx_build = find_program(fs.parent(python.full_path()) / 'sphinx-build',
                             required: get_option('docs'))
 
 # Check if tools are available to build documentation.
diff --git a/meson_options.txt b/meson_options.txt
index d8330a1f71e7..a350520f6abf 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -12,8 +12,6 @@ option('pkgversion', type : 'string', value : '',
        description: 'use specified string as sub-version of the package')
 option('smbd', type : 'string', value : '',
        description: 'Path to smbd for slirp networking')
-option('sphinx_build', type : 'string', value : 'sphinx-build',
-       description: 'Use specified sphinx-build for building document')
 option('iasl', type : 'string', value : '',
        description: 'Path to ACPI disassembler')
 option('tls_priority', type : 'string', value : 'NORMAL',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 2805d1c14540..fedb93ada69e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -57,8 +57,6 @@ meson_options_help() {
   printf "%s\n" '  --localedir=VALUE        Locale data directory [share/locale]'
   printf "%s\n" '  --localstatedir=VALUE    Localstate data directory [/var/local]'
   printf "%s\n" '  --mandir=VALUE           Manual page directory [share/man]'
-  printf "%s\n" '  --sphinx-build=VALUE     Use specified sphinx-build for building document'
-  printf "%s\n" '                           [sphinx-build]'
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
@@ -425,7 +423,6 @@ _meson_option_parse() {
     --disable-sndio) printf "%s" -Dsndio=disabled ;;
     --enable-sparse) printf "%s" -Dsparse=enabled ;;
     --disable-sparse) printf "%s" -Dsparse=disabled ;;
-    --sphinx-build=*) quote_sh "-Dsphinx_build=$2" ;;
     --enable-spice) printf "%s" -Dspice=enabled ;;
     --disable-spice) printf "%s" -Dspice=disabled ;;
     --enable-spice-protocol) printf "%s" -Dspice_protocol=enabled ;;
-- 
2.40.1



