Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC80C70701D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGG-0003nS-8y; Wed, 17 May 2023 13:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLER-000050-9J
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEN-0004LB-OE
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04MmlIKoOQC2vxWjCqSmC8U6PoC6qnjYxWljRrYw6JI=;
 b=G4cFkgQ+ZApvUocuz829tjuYA2QWl7L13WV8IAGACOtTK6BAiMtQscJ2hTRQiDF1HiEZd5
 ue8cFTRi0Q7IrReiEJA4SMbEsdSJzUY9ibhP7LBlt+Lj1U0OG11zNWTsrZPYJCn+EHlIXy
 EWNeHbwAYmWsrq0xv4LRjRAnH60u8R8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-mtQCqQONMOWv7nmpgY3hiQ-1; Wed, 17 May 2023 13:46:29 -0400
X-MC-Unique: mtQCqQONMOWv7nmpgY3hiQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f420742d40so4452355e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345587; x=1686937587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04MmlIKoOQC2vxWjCqSmC8U6PoC6qnjYxWljRrYw6JI=;
 b=GGv9CmfZljTavOYdHc413GApgps3rcL/DYBo/U4xvkxUfmY/VY6o8tWtGRGoE/KOPf
 GmZn+XH48EOTwZQqkiNqiCA/nnoZhaVtL1uj/wtqqPTPJ+h3PmU2SJYouHcg7sC0wde3
 RiBGRBrLNPmYvy3maW6AMVgBCirvmEz6/VtxaoaBIzEXedrL8KFv3bL3mq8v8OcLiuNY
 dCC0HNVyanfyyUAP5FklgbfesDyBZMrRYvLwpVYAgsccU3t23xWP/pc6b2NX05kRvyAt
 UGwZq5n92SqlXv+O0WUvaChuImQk47lH2s/49Fiz1XKxZGe5B7v6G1suXBFQXq+AVN8L
 Ka8w==
X-Gm-Message-State: AC+VfDzUPbEv58iUKKyfHwPVdMaoHswznqMxOviiNu+zqWmj7QWF1Lv7
 7A6iOuK90PRdp5LwggbUMTaoZI47LXNOBsCWMsk27H26INFRWmALtOVeoY3aTS5k5Rw0YuDfmr1
 T1YvJdOc68oOHsn6qrQFT0t04OBRjokVCj4n2bH4oHMp1HdgCY1fx+T5pJUdl7BOtRfx5lJ55JE
 0=
X-Received: by 2002:a05:600c:2190:b0:3f4:2b13:f0fb with SMTP id
 e16-20020a05600c219000b003f42b13f0fbmr22790339wme.13.1684345587600; 
 Wed, 17 May 2023 10:46:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IrYAKrofgknQzYm/T01ERVltDYL8Ph/Whs0cw9dBbFysDo33Czss0h031W0oPbuC+MQMTig==
X-Received: by 2002:a05:600c:2190:b0:3f4:2b13:f0fb with SMTP id
 e16-20020a05600c219000b003f42b13f0fbmr22790326wme.13.1684345587261; 
 Wed, 17 May 2023 10:46:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a1c7908000000b003f506e6ff83sm2873629wme.22.2023.05.17.10.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 39/68] configure: bootstrap sphinx with mkvenv
Date: Wed, 17 May 2023 19:44:51 +0200
Message-Id: <20230517174520.887405-40-pbonzini@redhat.com>
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
index f8308926bbc6..411140a306ff 100755
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
+         "sphinx>=1.6.0" sphinx-rtd-theme;
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


