Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7552A7133B4
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 11:30:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2qEU-0007Zc-M9; Sat, 27 May 2023 05:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qES-0007ZG-Fr
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEQ-0007XZ-UP
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685179741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsEC+bnXG7c9EhA6CVMwfc/AZn72acKre62nNYxDEmQ=;
 b=En1XftqdrQ5IF/W9tY/LvXPSnLPYsjhtJRW2Hl3NJh7kW269uxcLm9ln6MflM6qdfq+FLo
 lhdRMY+oFyhn7d0bf2zXCsQnt8bFamZEvJq6TFx/LLwyjkLdrDWScWGh7H6NhUR3jEjAD7
 XKE9cpP8pFbifs5J+jeFLO2Sgjg7LII=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-H9mcmzj_OtKcRPnEIPyA9g-1; Sat, 27 May 2023 05:29:00 -0400
X-MC-Unique: H9mcmzj_OtKcRPnEIPyA9g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-513e9618214so1363114a12.0
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 02:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685179738; x=1687771738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GsEC+bnXG7c9EhA6CVMwfc/AZn72acKre62nNYxDEmQ=;
 b=U6Jxb1YoI35fbGhIzPh1ugMbPxY/Lt8QQOWT4c4LyAv7DAiy1ZB/kve2PgUqkfVuvt
 KG8GRKynV6/acaDOOoY29F32Ex+tew0xzmsdktny9bxpYEqcZ+X0N3gm1q48YdTp5Csy
 nswIqpakv21dwosmLmjz/jOejfZoG/6fwn4Xs/jeRf8CHUbszJZjYpLtAvPvsYd7KOxp
 iBznZ9PskAtVa0mLXnYaM2dFWBox12AQdtQtVwjuwr4flJjMMGzkzrwacm8ow4wbMZIO
 QQhETj5WAuqk5BNnPp1QEeNb+p6ny0l35CaZraLwi/JzcsNjuTg1qrec+cpy/5rkqR/a
 mR6g==
X-Gm-Message-State: AC+VfDyaOu/ccHxkFLPE9O4m8pYVxvdpN2Z4+i/M/tyVxdRA5cINW0th
 ziY2N4VTLawjhrsWO7DfaZIcr9SEbrSMB+JYf71+AFhwrJaPGm+ob/eZgaSPdezJu8KHXYGT9zk
 Ps2e4DexFl8v5mUR1X/AroUAn4Kv1TMJMNzhIfZ0x3NyTGvSHu5sKankQW1FJS++/R9vbn0NmGP
 Y=
X-Received: by 2002:a17:906:dac6:b0:96f:d6bd:390c with SMTP id
 xi6-20020a170906dac600b0096fd6bd390cmr4281402ejb.67.1685179738409; 
 Sat, 27 May 2023 02:28:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46wWcp6Kq1PzHB0xHWXkiVUvLJDdWd+HSmsu04Fdd3LTmryTCzsOrCrogwlIPzNKXry/WeoA==
X-Received: by 2002:a17:906:dac6:b0:96f:d6bd:390c with SMTP id
 xi6-20020a170906dac600b0096fd6bd390cmr4281386ejb.67.1685179738016; 
 Sat, 27 May 2023 02:28:58 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a170906160d00b0095342bfb701sm3252857ejd.16.2023.05.27.02.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 02:28:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 2/5] configure: rename --enable-pypi to --enable-download,
 control subprojects too
Date: Sat, 27 May 2023 11:28:48 +0200
Message-Id: <20230527092851.705884-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527092851.705884-1-pbonzini@redhat.com>
References: <20230527092851.705884-1-pbonzini@redhat.com>
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              | 17 +++++++----------
 subprojects/.gitignore |  3 +++
 2 files changed, 10 insertions(+), 10 deletions(-)
 create mode 100644 subprojects/.gitignore

diff --git a/configure b/configure
index 370e038e63d7..2f908660e4f1 100755
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
@@ -756,9 +756,9 @@ for opt do
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
@@ -962,7 +962,7 @@ python="$(command -v "$python")"
 # - venv is allowed to use system packages;
 # - all setup can be performed offline;
 # - missing packages may be fetched from PyPI,
-#   unless --disable-pypi is passed.
+#   unless --disable-download is passed.
 # - pip is not installed into the venv when possible,
 #   but ensurepip is called as a fallback when necessary.
 
@@ -979,7 +979,7 @@ python="$python -B"
 mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
 mkvenv_flags=""
-if test "$pypi" = "enabled" ; then
+if test "$download" = "enabled" ; then
     mkvenv_flags="--online"
 fi
 
@@ -1002,7 +1002,7 @@ meson="$(cd pyvenv/bin; pwd)/meson"
 # Conditionally ensure Sphinx is installed.
 
 mkvenv_flags=""
-if test "$pypi" = "enabled" -a "$docs" = "enabled" ; then
+if test "$download" = "enabled" -a "$docs" = "enabled" ; then
     mkvenv_flags="--online"
 fi
 
@@ -1942,11 +1942,8 @@ if test "$skip_meson" = no; then
 
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


