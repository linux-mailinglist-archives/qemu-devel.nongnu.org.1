Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEA70705C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:02:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLFL-0002IQ-Af; Wed, 17 May 2023 13:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEJ-0008Tk-EQ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEH-0004K0-Eo
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mbxl8QbqXsMqvYzVdZ6VdOCeDAaqOga28d8VP6vA3vI=;
 b=LDuZgMqkdp+BthHl7uQgZbp98tyl7MjjGXcGlTVoRdeawiUzj9CE9537e6YmnZ4F+8EGJd
 V5Schirl1+6rxu2vl6M7taMaSwYAbTrDf3GC7F3a2iUwDj8gfdnVGuKg/IGtulodIzO2yq
 /IZgctwpX0ekymaUFzeBVodHT3TDrTM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-nx8c8YbZNVukxsbDteRv-Q-1; Wed, 17 May 2023 13:46:22 -0400
X-MC-Unique: nx8c8YbZNVukxsbDteRv-Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3064d0b726fso442253f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345581; x=1686937581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mbxl8QbqXsMqvYzVdZ6VdOCeDAaqOga28d8VP6vA3vI=;
 b=fGkVW4akK85X1se6IrSMSUyBC9aO8JyXiDY3QIbKyBdnNtBVABG0ECF4XBf66Kck2o
 a5/YiIVcmjGA/2Za8Xdsv6Q+bsvmJEqpHi+o5gHPS6vgmAeH+xW674N8n9HJ5sgTihKb
 Y7UN4m/fSVA9xgvpi+C6/Sm94hPs57wkrFVdH1WQus3mSLSFF1qNrpvssNdDJBruu/lm
 msfAFGizftLOgMQ1C33XGfonWIl9GAoQIToakr1NZehxskr5NGUe//bnCNun8PNqqN11
 /pVfx5VKtQK3V0zbfORftAnRYth2vmvXcYco9Qv06mvaUWHoJn/65BLtolN2xtOx94d1
 T90g==
X-Gm-Message-State: AC+VfDwZ/v5pVoTL0Zao6bzdRnTd7wLS0KrEM1pqoOib1oimSFJsbv/k
 EUeAhjsajYmlGss0kMD+y6GhWiYqMHErnwa9kz13zH/tHDg5MLLT+bmIRxr3GbSz0MUELjwHwP4
 ngUmPa0c3QRwaPzJgVBAGFQIYJf5pB6HWp3gK+OEJkupSD1ID+YZf5/as6HmgA0/2DUQdaIaH7F
 A=
X-Received: by 2002:adf:f452:0:b0:2f4:4e1a:bea2 with SMTP id
 f18-20020adff452000000b002f44e1abea2mr1090839wrp.59.1684345581274; 
 Wed, 17 May 2023 10:46:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RA3EwZS9m8x0fOwAQBRZwGImnDMW1TeFi8nnQN9FLRzEEb7a4pELeY7u/IQxf9V0voIvQHg==
X-Received: by 2002:adf:f452:0:b0:2f4:4e1a:bea2 with SMTP id
 f18-20020adff452000000b002f44e1abea2mr1090825wrp.59.1684345580867; 
 Wed, 17 May 2023 10:46:20 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n14-20020adff08e000000b002fed865c55esm3343919wro.56.2023.05.17.10.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 35/68] configure: use 'mkvenv ensure meson' to bootstrap meson
Date: Wed, 17 May 2023 19:44:47 +0200
Message-Id: <20230517174520.887405-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


