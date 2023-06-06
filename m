Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B5724639
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:34:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xis-0005MK-6p; Tue, 06 Jun 2023 10:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xip-0005Hv-Jk
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xin-0001J7-PJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LglmaneiM/Lbpcn+O0faPg/sVlbIK7inueVGywwXhgc=;
 b=bW1+hr2EO2FFSxl83mpQd5Q5Wv57HtevieV3t0f74A2IQlaWCsxVDJYzIG9WKTbpDsP9Fb
 hGjLEH9z1v9yZEJH9JumjImfYtGY92AFwtSdDA+bEu1JRU+sWBJ0lt5rviRBS50Q3/60OO
 RJSH2+FmPtEbtd5od0pCohQITodtSr4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-dcobVCyHOvm7rVkiVgS3yg-1; Tue, 06 Jun 2023 10:31:39 -0400
X-MC-Unique: dcobVCyHOvm7rVkiVgS3yg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5149e1bd242so4120598a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061898; x=1688653898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LglmaneiM/Lbpcn+O0faPg/sVlbIK7inueVGywwXhgc=;
 b=dU22JyX2l/8BjGy+DGjqql7YTmO46JvKfVM9YmoN76RCIdKip4wFqHh/MXiBIkKYWe
 g+QZK9RY9LL5khY+9QTSCdUHSENYFt7nLW2W1W8YGXx8mTRo6/Gfvmawjdtx/FYUvaOB
 s1/QxTyHlV3MHX5QlG90w0x9Fu1QXznNbd738jPH2Le7X11lUchGRIUeun/gzndiqgSZ
 NGE2FjTBgnkA61md+JflYv/DcAE8GCfAZpVBEfpT1UH1fs9vJL6wm5ba8C5RxKPuRx6t
 KNTFm+r+NlOs9aE0sxuZKTpG0Xrx83aoQKBWK8NQ5nuLGt+2EDjwAEA6SFl0B0JJeck5
 6cLg==
X-Gm-Message-State: AC+VfDybB0E+hqUk4JIcBCT2ayl3W37hZnY9BOq0qwruUGLlLPBwbE84
 FEh5jC+ctT4eHzsMzjf+ZhpASQNfxCDgIzZ5guGLVEm2z5J+yHTUOIuxHQz4Ez84BK3SK8qUD+5
 HyEwuRgc2y4eVoehmiz5RodXrSxLMbZv3PKXCM/fen8NXS6jF8ipa81+ePjLIce8RSw8qSv5eKR
 E=
X-Received: by 2002:a17:907:6d0c:b0:977:d932:cde2 with SMTP id
 sa12-20020a1709076d0c00b00977d932cde2mr2915771ejc.62.1686061898157; 
 Tue, 06 Jun 2023 07:31:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5PBBSiXnbPpeYC1peKcjCaeEQxp6LGTtAdR9wXe90aEtAoWcYKuYOlhjPqhzz19QNiNlrI9Q==
X-Received: by 2002:a17:907:6d0c:b0:977:d932:cde2 with SMTP id
 sa12-20020a1709076d0c00b00977d932cde2mr2915753ejc.62.1686061897870; 
 Tue, 06 Jun 2023 07:31:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 bv13-20020a170906b1cd00b00978743b54bdsm486595ejb.78.2023.06.06.07.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 13/21] configure: rename --enable-pypi to --enable-download,
 control subprojects too
Date: Tue,  6 Jun 2023 16:31:08 +0200
Message-Id: <20230606143116.685644-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore             |  2 --
 configure              | 17 +++++++----------
 meson.build            | 12 ++++++++----
 subprojects/.gitignore |  3 +++
 4 files changed, 18 insertions(+), 16 deletions(-)
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
diff --git a/meson.build b/meson.build
index 4302c019237..f8af4b02e44 100644
--- a/meson.build
+++ b/meson.build
@@ -3985,8 +3985,15 @@ endif
 # Configuration summary #
 #########################
 
-# Directories
+# Build environment
 summary_info = {}
+summary_info += {'Build directory':   meson.current_build_dir()}
+summary_info += {'Source path':       meson.current_source_dir()}
+summary_info += {'GIT submodules':    config_host['GIT_SUBMODULES']}
+summary_info += {'Download dependencies': get_option('wrap_mode') != 'nodownload'}
+summary(summary_info, bool_yn: true, section: 'Build environment')
+
+# Directories
 summary_info += {'Install prefix':    get_option('prefix')}
 summary_info += {'BIOS directory':    qemu_datadir}
 pathsep = targetos == 'windows' ? ';' : ':'
@@ -4004,9 +4011,6 @@ else
   summary_info += {'local state directory': 'queried at runtime'}
 endif
 summary_info += {'Doc directory':     get_option('prefix') / get_option('docdir')}
-summary_info += {'Build directory':   meson.current_build_dir()}
-summary_info += {'Source path':       meson.current_source_dir()}
-summary_info += {'GIT submodules':    config_host['GIT_SUBMODULES']}
 summary(summary_info, bool_yn: true, section: 'Directories')
 
 # Host binaries
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


