Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7F707066
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEa-0000Om-Qw; Wed, 17 May 2023 13:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLET-00005q-Gx
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEP-0004LJ-EC
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ra6PhvxA9OTVLts8tx91DcK1aYd+H54sTUC//9X5GXQ=;
 b=HrJWnAB7NvMtDjSNBnLY72OpE2/UBWwKkHDGsnza+MmZTogW7c6RzKBs4ZQ+9QjDRFNqfj
 1BoOkRpgS3yZgXi1FvKGvRYZDqsmN7WxfXo6EwcHdDQ5f8DaucdbgZgXV9wTgbgFA6mvx0
 BAVCzVDgZFxekzISQCCrsGAheLztTn4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-vjoYMZynNlKFVjyQqs2Q4Q-1; Wed, 17 May 2023 13:46:30 -0400
X-MC-Unique: vjoYMZynNlKFVjyQqs2Q4Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3079d15b51dso165837f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345589; x=1686937589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ra6PhvxA9OTVLts8tx91DcK1aYd+H54sTUC//9X5GXQ=;
 b=T+wJwUKSSjUwJFcS0g40qfzPuweEHJXV9hBt/5P3owvzQuT7OU9uzQ+NPX5Hik3Pb/
 tlGDoBUqiiZz5ku9x2JHBA4n0lQkFnYYuDAVQez/x9DYMxBt/qVBXRu785oP+lrUywlo
 vNKIriogJJAHHr3tZwHajih38DcFzeY1KdjSEIjUskVzl5gLoPet1cuO2dvyQ6TfIEiO
 RBM3SB0NP1yGKG61DHsQsK4f9QroWc8uxIE/ESZMMH4rV0tMEAgVZz194V8Jt/kNEnco
 FzofAzYGiA6eC8rGTkxA43xT1+Bnr7iu/yia/88qzQHykHWWnP28O2QCtYwP6yB3Jo3b
 JZng==
X-Gm-Message-State: AC+VfDy2yU+N56dQvBdapSmvAuta0yME5ab5TlNmfyVPWNeWXqpXjoe0
 2to+Pw4PcT6Hgg8lEmbwFpuka5CQ6KEdSzYTNQTuBZbW4bwGRpknXrm3GKx/VlVKCjt+2WXosV2
 KVrMfnokPGUCSbNYLenzeFGzPRc/tNqahH/2Pr26bvKxBuomZ4pE91Qb4zoqYhAAQaEG1YmHdC+
 8=
X-Received: by 2002:a5d:43c8:0:b0:306:c524:76cd with SMTP id
 v8-20020a5d43c8000000b00306c52476cdmr1174607wrr.27.1684345589079; 
 Wed, 17 May 2023 10:46:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LB8YmiJJmZzKDw0wpOM3n23qdDkUb/s55ddfCXYmDF4CT+ofzKH9ad+fjJw/N4PIHF2j7VA==
X-Received: by 2002:a5d:43c8:0:b0:306:c524:76cd with SMTP id
 v8-20020a5d43c8000000b00306c52476cdmr1174596wrr.27.1684345588766; 
 Wed, 17 May 2023 10:46:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 q15-20020adff50f000000b0030903d44dbcsm3350169wro.33.2023.05.17.10.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 40/68] configure: add --enable-pypi and --disable-pypi
Date: Wed, 17 May 2023 19:44:52 +0200
Message-Id: <20230517174520.887405-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

In the event that there's no vendored source present and no sufficient
version of $package can be found, we will attempt to connect to PyPI to
install the package if '--disable-pypi' was not passed.

This means that PyPI access is "enabled by default", but there are some
subtleties that make this action occur much less frequently than you
might imagine:

(1) While --enable-pypi is the default, vendored source will always be
    preferred when found, making PyPI a fallback. This should ensure
    that configure-time venv building "just works" for almost everyone
    in almost every circumstance.

(2) Because meson source is, at time of writing, vendored directly into
    qemu.git, PyPI will never be used for sourcing meson.

(3) Because Sphinx is an optional dependency, if docs are set to "auto",
    PyPI will not be used to obtain Sphinx source as a fallback and
    instead docs will be disabled. If PyPI sourcing of sphinx is
    desired, --enable-docs should be passed to force the lookup. I chose
    this as the default behavior to avoid adding new internet lookups to
    a "default" invocation of configure.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-23-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 411140a306ff..b92da9e6605b 100755
--- a/configure
+++ b/configure
@@ -623,6 +623,7 @@ check_py_version() {
 }
 
 python=
+pypi="enabled"
 first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
@@ -888,6 +889,10 @@ for opt do
   --with-git-submodules=*)
       git_submodules_action="$optarg"
   ;;
+  --disable-pypi) pypi="disabled"
+  ;;
+  --enable-pypi) pypi="enabled"
+  ;;
   --enable-plugins) if test "$mingw32" = "yes"; then
                         error_exit "TCG plugins not currently supported on Windows platforms"
                     else
@@ -1101,7 +1106,9 @@ python="$(command -v "$python")"
 # Defaults assumed for now:
 # - venv is cleared if it exists already;
 # - venv is allowed to use system packages;
-# - all setup is performed **offline**;
+# - all setup can be performed offline;
+# - missing packages may be fetched from PyPI,
+#   unless --disable-pypi is passed.
 # - pip is not installed into the venv when possible,
 #   but ensurepip is called as a fallback when necessary.
 
@@ -1117,7 +1124,13 @@ fi
 python="$python -B"
 mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
+mkvenv_flags=""
+if test "$pypi" = "enabled" ; then
+    mkvenv_flags="--online"
+fi
+
 if ! $mkvenv ensure \
+     $mkvenv_flags \
      --dir "${source_path}/python/wheels" \
      --diagnose "meson" \
      "meson>=0.61.5" ;
@@ -1134,8 +1147,14 @@ meson="$(cd pyvenv/bin; pwd)/meson"
 
 # Conditionally ensure Sphinx is installed.
 
+mkvenv_flags=""
+if test "$pypi" = "enabled" -a "$docs" = "enabled" ; then
+    mkvenv_flags="--online"
+fi
+
 if test "$docs" != "disabled" ; then
     if ! $mkvenv ensure \
+         $mkvenv_flags \
          --diagnose "sphinx-build" \
          "sphinx>=1.6.0" sphinx-rtd-theme;
     then
-- 
2.40.1


