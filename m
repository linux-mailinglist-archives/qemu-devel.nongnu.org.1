Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CF272461F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XjW-0006PW-SM; Tue, 06 Jun 2023 10:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xj5-0005iv-EQ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xj3-0001Lf-7V
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d41daTl/K9RG0QQvz7UtPuUgVUPwl1xrGxWNTb68ah8=;
 b=DyRUxE04vgN8NV0k0VBwX4nugsxKCBkudjCdrAm/RWsKdFi95ZXYIK04V75Evl+d4F8xWp
 BWkkQ2agPuubpb2ee745LqbfKk08TLplngK0goheA99+UEMi0cOPiJD0P2S8XgLc6MfOOa
 2uflyF9inHIGEZtuR0B1P8d2cIgwwnY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653--kOCQ2FwPF-k5KvCPpIOPg-1; Tue, 06 Jun 2023 10:31:54 -0400
X-MC-Unique: -kOCQ2FwPF-k5KvCPpIOPg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-97542592eb9so317438566b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061911; x=1688653911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d41daTl/K9RG0QQvz7UtPuUgVUPwl1xrGxWNTb68ah8=;
 b=G/TcD/xCoZMZrCP+pAUINhh7MEFb7ev9m1Iw60YnkfGtUtSu1SCBw7VxeoakIVrzCt
 g9f/csI37Xftf9fLNW9CaIyuc1NdmnKBGGE3V6HqUVVaA3eXVv3luizLZYx2fVC1/qHq
 9mrIgAMvvSzUCKuhcKX77CaAWPfaVSm4USnbtJSr/AzGWHlHnHOPoZbKqDu9vd+QBqic
 zX2vaHyG7nmR5az+aL005FOJ5u3xNtWS0EmIVSLj4teyoxs1oHJSE1KK1YuS/03fuSq6
 JKk3qBjHcGYcJox6DWY6+NFk9buIhn7vJst3Yutnsd0jNzQ3eqizGXZN/UVAs91GaZ2c
 Fcpg==
X-Gm-Message-State: AC+VfDzlZLnIxt2r2f3DS26UQ8mkEML7J49wx1N3Z9zFGplRc8PUEC7x
 gOy4ABzNd2kILgR/qkI9BnSB6XdEAVf4ARG/tmy7T8fIS5HPx8qh50/Msk/xy88P1//TSU+62Wp
 TRlAmjms9n/njiZg9letmHKrce9w3Os2IeOTuJI7v4J23XsYBxSkDUwUIx8fxsIEm0dzlNL3xuc
 o=
X-Received: by 2002:a17:907:7da0:b0:974:6176:2223 with SMTP id
 oz32-20020a1709077da000b0097461762223mr3076105ejc.13.1686061911716; 
 Tue, 06 Jun 2023 07:31:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5h5K6+a4e/GFp85D2rgIB8OGsSP6KuN83Zq3Hmufal2bFkbJ/SaCJ9f1+57GeX1MUdKqyBGQ==
X-Received: by 2002:a17:907:7da0:b0:974:6176:2223 with SMTP id
 oz32-20020a1709077da000b0097461762223mr3076088ejc.13.1686061911379; 
 Tue, 06 Jun 2023 07:31:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a170906a40e00b0095807ab4b57sm5725981ejz.178.2023.06.06.07.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 21/21] configure: remove --with-git-submodules=
Date: Tue,  6 Jun 2023 16:31:16 +0200
Message-Id: <20230606143116.685644-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reuse --enable/--disable-download to control git submodules as well.
Adjust the error messages of git-submodule.sh to refer to the new
option.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                     | 40 +++++--------------
 .../ci/org.centos/stream/8/x86_64/configure   |  1 -
 scripts/git-submodule.sh                      |  8 ++--
 3 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/configure b/configure
index bc0660f5a32..8765b88e12f 100755
--- a/configure
+++ b/configure
@@ -246,13 +246,7 @@ for opt do
 done
 
 
-if test -e "$source_path/.git"
-then
-    git_submodules_action="update"
-else
-    git_submodules_action="ignore"
-fi
-
+git_submodules_action="update"
 git="git"
 debug_tcg="no"
 docs="auto"
@@ -738,12 +732,9 @@ for opt do
   ;;
   --disable-cfi) cfi="false"
   ;;
-  --with-git-submodules=*)
-      git_submodules_action="$optarg"
+  --disable-download) download="disabled"; git_submodules_action=validate;
   ;;
-  --disable-download) download="disabled"
-  ;;
-  --enable-download) download="enabled"
+  --enable-download) download="enabled"; git_submodules_action=update;
   ;;
   --enable-plugins) if test "$mingw32" = "yes"; then
                         error_exit "TCG plugins not currently supported on Windows platforms"
@@ -765,6 +756,11 @@ for opt do
   esac
 done
 
+if ! test -e "$source_path/.git"
+then
+    git_submodules_action="ignore"
+fi
+
 # test for any invalid configuration combinations
 if test "$plugins" = "yes" -a "$tcg" = "disabled"; then
     error_exit "Can't enable plugins on non-TCG builds"
@@ -796,21 +792,6 @@ then
     exit 1
 fi
 
-case $git_submodules_action in
-    update|validate)
-        if test ! -e "$source_path/.git" || ! has git; then
-            echo "ERROR: cannot $git_submodules_action git submodules without .git"
-            exit 1
-        fi
-    ;;
-    ignore)
-    ;;
-    *)
-        echo "ERROR: invalid --with-git-submodules= value '$git_submodules_action'"
-        exit 1
-    ;;
-esac
-
 default_target_list=""
 mak_wilds=""
 
@@ -877,9 +858,6 @@ Advanced options (experts only):
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
   --smbd=SMBD              use specified smbd [$smbd]
-  --with-git-submodules=update   update git submodules (default if .git dir exists)
-  --with-git-submodules=validate fail if git submodules are not up to date
-  --with-git-submodules=ignore   do not update or check git submodules (default if no .git dir)
   --static                 enable static build [$static]
   --bindir=PATH            install binaries in PATH
   --with-suffix=SUFFIX     suffix for QEMU data inside datadir/libdir/sysconfdir/docdir [$qemu_suffix]
@@ -1024,7 +1002,7 @@ fi
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
-    if test "$git_submodules_action" != "ignore" && \
+    if test -e "$source_path/.git" && \
         { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
         werror="yes"
     else
diff --git a/scripts/ci/org.centos/stream/8/x86_64/configure b/scripts/ci/org.centos/stream/8/x86_64/configure
index de76510978f..d02b09a4b9b 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/configure
+++ b/scripts/ci/org.centos/stream/8/x86_64/configure
@@ -29,7 +29,6 @@
 --extra-cflags="-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection" \
 --with-suffix="qemu-kvm" \
 --firmwarepath=/usr/share/qemu-firmware \
---with-git-submodules=update \
 --target-list="x86_64-softmmu" \
 --block-drv-rw-whitelist="qcow2,raw,file,host_device,nbd,iscsi,rbd,blkdebug,luks,null-co,nvme,copy-on-read,throttle,gluster" \
 --audio-drv-list="" \
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 38b55c90e11..11fad2137cd 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -9,7 +9,7 @@ command=$1
 shift
 maybe_modules="$@"
 
-# if --with-git-submodules=ignore, do nothing
+# if not running in a git checkout, do nothing
 test "$command" = "ignore" && exit 0
 
 test -z "$GIT" && GIT=$(command -v git)
@@ -24,7 +24,7 @@ update_error() {
     echo "enable use of a transparent proxy), please disable automatic"
     echo "GIT submodule checkout with:"
     echo
-    echo " $ ./configure --with-git-submodules=validate"
+    echo " $ ./configure --disable-download"
     echo
     echo "and then manually update submodules prior to running make, with:"
     echo
@@ -39,9 +39,7 @@ validate_error() {
         echo "configured for validate only. Please run"
         echo "  scripts/git-submodule.sh update $maybe_modules"
         echo "from the source directory or call configure with"
-        echo "  --with-git-submodules=update"
-        echo "To disable GIT submodules validation, use"
-        echo "  --with-git-submodules=ignore"
+        echo "  --enable-download"
     fi
     exit 1
 }
-- 
2.40.1


