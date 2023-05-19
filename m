Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE18709257
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvv6-0002F3-UP; Fri, 19 May 2023 04:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvv4-0002EQ-AI
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvv2-0000Bl-Pe
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWnHqrDaDrc0Yt2ijn7nY1ZzzrQQlpfEkdayY9n7Fm8=;
 b=Z8thayzFELvO8l6Z11tkXuyyeEkG99ec6nJv+EY29aJE/YzhTHmMDKz1AgQ3y0Du8tmW+Y
 FtkvXtXYtQutKKDCBtd4J/TNNONuzQzFBAeJJ8tVG6Kz28C8nb7ti2Y64cSkj7PS3JofT9
 uRwiYMNLfmSeukfLyxVu+LvyXbIuWnw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-1yb-BZGMOnSAbze_Ww_alg-1; Fri, 19 May 2023 04:56:59 -0400
X-MC-Unique: 1yb-BZGMOnSAbze_Ww_alg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-969f24626fbso88304666b.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486617; x=1687078617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWnHqrDaDrc0Yt2ijn7nY1ZzzrQQlpfEkdayY9n7Fm8=;
 b=g2n/hMu2YEOH6vfxZs5lxiTUBDu2RTEKSYNsZEJ/K2BembG5zaDFfss5IX1F7c3aBP
 yAKx7iIMKy+svBpLEMNblEiesiaEJxm1Ctkyvj3joTVtdWWqsy0Yne/MHl1gZHXMytuz
 3j6H7CL9yz9fGRkVYinmVY8N5bxk/CebSftI+sDTPdOBDiB291GnOw9YWpO2wRoxXrIp
 UYqBVuOvkTdJNksCW5dvtbWxN6dQ2M60Fxcy3mGyDbaEAG5hKA47yDXvp4C6SQDJs93C
 NO3I24MKerC3UQ5iYNp0TcBb7iKWDGMVKTLxdvrItLtkG3JHcRrUtsgh4Xb3ADBLdGMa
 NWVA==
X-Gm-Message-State: AC+VfDzE0Gtd9XlMF2hcBcLdlZA66LSgtk9jnpw1jt4QVTU9ogcxPAwd
 mL8+aiuVa/IPh4j3jz41i3s0BBtdKLj5MlUMNJ2MfgKY788QIrnlWaKyRcx0PEwdtq8n3piu4om
 VWffMyxiinOIn8BU3nly8nFNggQBBpo7GysNe6wo4gOEdGyBB0OW27W1K7baSTf/+0ssOYaE6RJ
 A=
X-Received: by 2002:a17:907:7ea3:b0:966:399e:a5a5 with SMTP id
 qb35-20020a1709077ea300b00966399ea5a5mr1113946ejc.35.1684486617350; 
 Fri, 19 May 2023 01:56:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60IeLdyeZY3Q82G3GIe82pbRrtYEceMpGEAip2XIHVvNUPfAv81t59HzLsShhwTminXf5Qfw==
X-Received: by 2002:a17:907:7ea3:b0:966:399e:a5a5 with SMTP id
 qb35-20020a1709077ea300b00966399ea5a5mr1113926ejc.35.1684486616982; 
 Fri, 19 May 2023 01:56:56 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 j25-20020a170906095900b009584c5bcbc7sm1997474ejd.49.2023.05.19.01.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:56:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 5/6] configure: rename --enable-pypi to --enable-download,
 control subprojects too
Date: Fri, 19 May 2023 10:56:45 +0200
Message-Id: <20230519085647.1104775-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519085647.1104775-1-pbonzini@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
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

The behavior of --{enable,disable}-pypi is similar to that of
-Dwrapmode={default,nodownload} respectively.  In particular,
in both cases a feature needs to be explicitly enabled for the
dependency to be downloaded.

So, use a single option to control both cases.  Now, --enable-slirp
will trigger cloning and building of libslirp if the .pc file
is not found on the machine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore             |  2 --
 configure              | 17 +++++++----------
 subprojects/.gitignore |  3 +++
 3 files changed, 10 insertions(+), 12 deletions(-)
 create mode 100644 subprojects/.gitignore

diff --git a/.gitignore b/.gitignore
index 1ea59f481921..61fa39967b54 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,5 +20,3 @@ GTAGS
 *.swp
 *.patch
 *.gcov
-
-/subprojects/slirp
diff --git a/configure b/configure
index 2b6995e16756..43620b80c8df 100755
--- a/configure
+++ b/configure
@@ -267,7 +267,7 @@ bsd_user=""
 plugins="$default_feature"
 ninja=""
 python=
-pypi="enabled"
+download="enabled"
 bindir="bin"
 skip_meson=no
 vfio_user_server="disabled"
@@ -765,9 +765,9 @@ for opt do
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
@@ -978,7 +978,7 @@ python="$(command -v "$python")"
 # - venv is allowed to use system packages;
 # - all setup can be performed offline;
 # - missing packages may be fetched from PyPI,
-#   unless --disable-pypi is passed.
+#   unless --disable-download is passed.
 # - pip is not installed into the venv when possible,
 #   but ensurepip is called as a fallback when necessary.
 
@@ -995,7 +995,7 @@ python="$python -B"
 mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
 mkvenv_flags=""
-if test "$pypi" = "enabled" ; then
+if test "$download" = "enabled" ; then
     mkvenv_flags="--online"
 fi
 
@@ -1018,7 +1018,7 @@ meson="$(cd pyvenv/bin; pwd)/meson"
 # Conditionally ensure Sphinx is installed.
 
 mkvenv_flags=""
-if test "$pypi" = "enabled" -a "$docs" = "enabled" ; then
+if test "$download" = "enabled" -a "$docs" = "enabled" ; then
     mkvenv_flags="--online"
 fi
 
@@ -1960,11 +1960,8 @@ if test "$skip_meson" = no; then
 
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
index 000000000000..7560ebb0b1a0
--- /dev/null
+++ b/subprojects/.gitignore
@@ -0,0 +1,3 @@
+/packagecache
+
+/slirp
-- 
2.40.1


