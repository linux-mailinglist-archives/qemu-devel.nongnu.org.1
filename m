Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1447222A2
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tG-0002nM-SA; Mon, 05 Jun 2023 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t7-0002iO-Vs
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t6-0006kK-6B
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scYrryya8DVCdN5sXK97iWXrJtCRAUlwa7DP2urybps=;
 b=DOPaNND6iB7WdhDqWLnClxwYlMwJiisKkAkhrmjYVdWjUhipOq6WgTWRoC540wk1qrOxV4
 bxN7qJeFzjD1h0MXBSC+PH4raI4ix8jlPio7geb2APz/P13R2QKo+CyRD3QLev/EffVCAO
 Xmp4wnx9qsBQ82GYtRfzuCcLIGYD9fM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-ub7RGxmXNiq4XZ70yWThQA-1; Mon, 05 Jun 2023 05:52:30 -0400
X-MC-Unique: ub7RGxmXNiq4XZ70yWThQA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-514b8d2b21fso3050849a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958749; x=1688550749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scYrryya8DVCdN5sXK97iWXrJtCRAUlwa7DP2urybps=;
 b=K3rLcA/p3Wl+cdEA9k7U36tYwt2N/uTo4Fcww+xrEdsqkNV6mQEKlzLNyP8quB6AFq
 bAJHGbxuOf88t8geO8QQ4k1Y2Z2wpjQ0uwGjbrafP8ShyJ1wpiwyb9ItGSLqfXBnwmO+
 8pfVvrFNlLPNs4cnP7W/HcZ1tw3M7y3BBy9EBr1SckSMVM8ZSOrhBmyFw738LUUf0Zp8
 1eRoDHzz/3o84tyCGUJI5MarrdzK1f8e7rz/z4hnR9lUCbWYBE6X9RxeJnAgJYsHTQ7w
 bE1HF9csAOKjrSS6hr8cxDvqGN29J1oqFhpv5346HgLD9RCKJaXFsaoKiiduTpFfxpBu
 0JlA==
X-Gm-Message-State: AC+VfDzWEzt8YGcRXD1DO+dANqbbThmBrl3dBnLcjvyJB8KzH+fRhNfj
 RKoX6E8R/QI2Wwk+e+ZGTxwmFNDZNbcgADyO+qCauuYsmMQyhzLJy9fZV143G4B3yQWn+fEQPZt
 sWEe2niAPz8XoxvEoyKXmBVxSMIC2B6T0jtgWzRfJp0X4dEXoe/TuUgCpzl+Wrv0UDvGIo7ynOs
 s=
X-Received: by 2002:aa7:d590:0:b0:510:6ccf:84aa with SMTP id
 r16-20020aa7d590000000b005106ccf84aamr7532369edq.32.1685958748826; 
 Mon, 05 Jun 2023 02:52:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49WWG772l69zdngPxv4YDvSRbBQ9YpuM1dehKyYJoo9CGhdJIL1mKjoaA+BkOYz4bg8gjv8g==
X-Received: by 2002:aa7:d590:0:b0:510:6ccf:84aa with SMTP id
 r16-20020aa7d590000000b005106ccf84aamr7532356edq.32.1685958748509; 
 Mon, 05 Jun 2023 02:52:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a056402054d00b00510d110db58sm3702449edx.80.2023.06.05.02.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 02/10] configure: rename --enable-pypi to --enable-download,
 control subprojects too
Date: Mon,  5 Jun 2023 11:52:15 +0200
Message-Id: <20230605095223.107653-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The behavior of --{enable,disable}-pypi is similar to that of
-Dwrapmode={default,nodownload} respectively.  In particular,
in both cases a feature needs to be explicitly enabled for the
dependency to be downloaded.

So, use a single option to control both cases.  Now, --enable-slirp
will trigger cloning and building of libslirp if the .pc file
is not found on the machine.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore             |  2 --
 configure              | 17 +++++++----------
 subprojects/.gitignore |  3 +++
 3 files changed, 10 insertions(+), 12 deletions(-)
 create mode 100644 subprojects/.gitignore

diff --git a/.gitignore b/.gitignore
index 1ea59f48192..61fa39967b5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,5 +20,3 @@ GTAGS
 *.swp
 *.patch
 *.gcov
-
-/subprojects/slirp
diff --git a/configure b/configure
index 92bacc756c0..52274212310 100755
--- a/configure
+++ b/configure
@@ -266,7 +266,7 @@ bsd_user=""
 plugins="$default_feature"
 ninja=""
 python=
-pypi="enabled"
+download="enabled"
 bindir="bin"
 skip_meson=no
 vfio_user_server="disabled"
@@ -754,9 +754,9 @@ for opt do
   --with-git-submodules=*)
       git_submodules_action="$optarg"
   ;;
-  --disable-pypi) pypi="disabled"
+  --disable-download) download="disabled"
   ;;
-  --enable-pypi) pypi="enabled"
+  --enable-download) download="enabled"
   ;;
   --enable-plugins) if test "$mingw32" = "yes"; then
                         error_exit "TCG plugins not currently supported on Windows platforms"
@@ -960,7 +960,7 @@ python="$(command -v "$python")"
 # - venv is allowed to use system packages;
 # - all setup can be performed offline;
 # - missing packages may be fetched from PyPI,
-#   unless --disable-pypi is passed.
+#   unless --disable-download is passed.
 # - pip is not installed into the venv when possible,
 #   but ensurepip is called as a fallback when necessary.
 
@@ -977,7 +977,7 @@ python="$python -B"
 mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
 mkvenv_flags=""
-if test "$pypi" = "enabled" ; then
+if test "$download" = "enabled" ; then
     mkvenv_flags="--online"
 fi
 
@@ -1000,7 +1000,7 @@ meson="$(cd pyvenv/bin; pwd)/meson"
 # Conditionally ensure Sphinx is installed.
 
 mkvenv_flags=""
-if test "$pypi" = "enabled" -a "$docs" = "enabled" ; then
+if test "$download" = "enabled" -a "$docs" = "enabled" ; then
     mkvenv_flags="--online"
 fi
 
@@ -1940,11 +1940,8 @@ if test "$skip_meson" = no; then
 
   rm -rf meson-private meson-info meson-logs
 
-  # Prevent meson from automatically downloading wrapped subprojects when missing.
-  # You can use 'meson subprojects download' before running configure.
-  meson_option_add "--wrap-mode=nodownload"
-
   # Built-in options
+  test "$download" = "disabled" && meson_option_add "--wrap-mode=nodownload"
   test "$bindir" != "bin" && meson_option_add "-Dbindir=$bindir"
   test "$default_feature" = no && meson_option_add -Dauto_features=disabled
   test "$static" = yes && meson_option_add -Dprefer_static=true
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
new file mode 100644
index 00000000000..7560ebb0b1a
--- /dev/null
+++ b/subprojects/.gitignore
@@ -0,0 +1,3 @@
+/packagecache
+
+/slirp
-- 
2.40.1


