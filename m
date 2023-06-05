Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED16A7222A7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tk-0002xP-Ne; Mon, 05 Jun 2023 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tM-0002q8-At
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tK-0006ni-Ad
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXiIXtpt4ZHp6HRqfL2Ve/hGwW4tf6OUNnl3ecrHEGs=;
 b=IzByYDgJOC8Q9TWmFZwLN7tromFKoiNZL64jOts6ubo0jW5xqlxpLftcWc++L6Yj/Lqn1y
 7AP4OlMBfN0fapBk7A5JhwxkFoRQfG1TyBo1d7CH2uz7Z12i01D2QPYPVCt6WrImaVA+9Q
 I0SwjRmajYBxJA7JB3FPXL4gMCY9NBU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321--iRSwsigNf6kdihu3KP7AA-1; Mon, 05 Jun 2023 05:52:43 -0400
X-MC-Unique: -iRSwsigNf6kdihu3KP7AA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977cb73efe8so122470266b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958762; x=1688550762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXiIXtpt4ZHp6HRqfL2Ve/hGwW4tf6OUNnl3ecrHEGs=;
 b=kktmGadsIzMI9SvuWJcfgOzsEe8ffdhiibIWtz/VZP0ww8w7Zfeqa1JO8KDXM+wWN3
 RzyCSvVfU+e0wdojesGjEdPXlSm5K6oD51lv+HtWyVLaHwcvcNzItThRMfbLIsIeGXrH
 2kj1pV4f5cZCOhkBAc4hHEXMO0by4mQTz/dy6IoTtlyr4llmPK0mE66UZNdJej7UvTce
 DksAdxr/jQuLFMpyyiJadqn2fezjf4f2BDoAXJXsoY6c7rBuU7fOaEm62TRQpsGYORtk
 lWQ4nBECl03/AC03suvZWRErThsyy9NoGHM1pN3kb/B2mELUEirLKeqO4RK7sL2e+WlL
 ZbVw==
X-Gm-Message-State: AC+VfDyKfI6i/QPVkQIuOeoxlP3yMc8TeE8y2c3apZZIOtzOW7qe1MfA
 qm3CiurtTeXbQmQ3RQRFBgdfKJO3l0qhJQ9COPTSLo4Zg0+q2McE7hrgRIYay7ElY9T9zUYCLNA
 hZpF311n+O8aC6ZidItOnHO8q3UPwqPM8A+wZ/AD92kjyZ8KX+f16vmEYJaJ+Fx3BsZAcAj/g50
 o=
X-Received: by 2002:a17:906:6a21:b0:977:c8a7:bed5 with SMTP id
 qw33-20020a1709066a2100b00977c8a7bed5mr4975504ejc.47.1685958761893; 
 Mon, 05 Jun 2023 02:52:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sZHOa837upK7WOwO6BON3YxlHLqjTw4KyfC9DiwlYgZ+sr8TuFupMy45KbF/m+k5072IawQ==
X-Received: by 2002:a17:906:6a21:b0:977:c8a7:bed5 with SMTP id
 qw33-20020a1709066a2100b00977c8a7bed5mr4975492ejc.47.1685958761646; 
 Mon, 05 Jun 2023 02:52:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a170906590800b009596e7e0dbasm4039592ejq.162.2023.06.05.02.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 10/10] configure: remove --with-git-submodules=
Date: Mon,  5 Jun 2023 11:52:23 +0200
Message-Id: <20230605095223.107653-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
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

Reuse --enable/--disable-download to control git submodules as well.
Adjust the error messages of git-submodule.sh to refer to the new
option.

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


