Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 625437222AC
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tI-0002ne-2b; Mon, 05 Jun 2023 05:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t6-0002hk-St
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66t4-0006jw-MO
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pkJQaqVs7/v6zs3Q5Js7WY3TSr6oXP0gDufyu6jM/Mw=;
 b=VGbK0tmehmuB1+RJCUrkgdCUS/P6XbUClXPl4DNpAgN46HFRNLnE1YaWnDH3Mh8mcdwj/7
 1IApN1/ptZ69clPY+t1RJqArJwdzPE0j3hQ6mTeWFlHRDV34FJ4NZ5HSmz+1JL04zyH24n
 AOlHhfnFCZBx88KEaW4IdN+D/YTgkZQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-i4QD0BBZMJKqNblGGdbF-g-1; Mon, 05 Jun 2023 05:52:28 -0400
X-MC-Unique: i4QD0BBZMJKqNblGGdbF-g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso312518866b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958747; x=1688550747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkJQaqVs7/v6zs3Q5Js7WY3TSr6oXP0gDufyu6jM/Mw=;
 b=DfDV1j/Qauw3jw/Cq8cXDAXOLLVvLlKyYD+455GN2nSxK0xyElOHg25ZPoCL4TLslh
 jOq2qSowp08SOGiF01wCdllPyj8XUhp5o4qWnPToBuFW3wKFVGwQ0NuqkEuOjLfhcD7s
 dc0t2EP4HGbYqJKWRMuwGNkd/iFnkaR10FmrfapRpwH3uTfm0LTaKWJXPuehZ7Chaktf
 3UtMp63ynL22kozCV+JKFVWoOlIAc6/d7ON3eOihhfkR7/MF/YkzgX9BMCM4YQwa/fY9
 QyKORmCmHTCE7SLeTotd0mSclQD1xqXORj965YJTVj2HBSAIVT20pTQhWJYQd7NuB2d1
 wCIg==
X-Gm-Message-State: AC+VfDx7ZYmEWXmgTluUG7tk3rqzT0gOTyxdNHabIlYduCI9LHYbnPWW
 26kqaRpBAmai2AVJdVbKsSNgfHKy2XPK3zwVzf/sjAiibeZPX0n1UW6aWewlFECSG0+vFlxY4AA
 +en5/E+lZEo+ucf2Z7j7+ItUhexjFglhzoZAZhwg/d4Ho2xJn1Dq2gPWaJMDe/Y43oV4zi0kxSD
 I=
X-Received: by 2002:a17:907:3681:b0:96f:d6bd:390c with SMTP id
 bi1-20020a170907368100b0096fd6bd390cmr5747240ejc.67.1685958747152; 
 Mon, 05 Jun 2023 02:52:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Z1wzGqlX9BJNBv5qj2hlxRGtli8hNKrF6GmnfuuBJG+JGkIxMCu463QX1ChTTdMEX3uxk/g==
X-Received: by 2002:a17:907:3681:b0:96f:d6bd:390c with SMTP id
 bi1-20020a170907368100b0096fd6bd390cmr5747228ejc.67.1685958746895; 
 Mon, 05 Jun 2023 02:52:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a1709064f8900b0094e6a9c1d24sm4203158eju.12.2023.06.05.02.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 01/10] configure: remove --with-git= option
Date: Mon,  5 Jun 2023 11:52:14 +0200
Message-Id: <20230605095223.107653-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
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

The scenario for which --with-git= was introduced was to use a SOCKS proxy
such as tsocks.  However, this was back in 2017 when QEMU's submodules
used the git:// protocol, and it is not as important when using the
"smart HTTP" backend; for example, neither "meson subprojects download"
nor scripts/checkpatch.pl do not obey the GIT environment variable.

So remove the knob, but test for the presence of git in the configure and
git-submodule.sh scripts, and suggest using --with-git-submodules=validate
+ a manual invocation of git-submodule.sh when git does not work.  Hopefully
in the future the GIT environment variable will be supported by Meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                                      |  2 +-
 configure                                     |  8 ++------
 meson.build                                   |  1 -
 .../ci/org.centos/stream/8/x86_64/configure   |  2 --
 scripts/git-submodule.sh                      | 19 ++++++++++---------
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 08fb6a3b058..8005f1cc53e 100644
--- a/Makefile
+++ b/Makefile
@@ -53,7 +53,7 @@ Makefile: .git-submodule-status
 git-submodule-update:
 ifneq ($(GIT_SUBMODULES_ACTION),ignore)
 	$(call quiet-command, \
-		(GIT="$(GIT)" "$(SRC_PATH)/scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)), \
+		(GIT=git "$(SRC_PATH)/scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)), \
 		"GIT","$(GIT_SUBMODULES)")
 endif
 
diff --git a/configure b/configure
index d674a966731..92bacc756c0 100755
--- a/configure
+++ b/configure
@@ -751,8 +751,6 @@ for opt do
   ;;
   --enable-fdt=*) fdt="$optarg"
   ;;
-  --with-git=*) git="$optarg"
-  ;;
   --with-git-submodules=*)
       git_submodules_action="$optarg"
   ;;
@@ -791,7 +789,7 @@ fi
 
 case $git_submodules_action in
     update|validate)
-        if test ! -e "$source_path/.git"; then
+        if test ! -e "$source_path/.git" || ! has git; then
             echo "ERROR: cannot $git_submodules_action git submodules without .git"
             exit 1
         fi
@@ -892,7 +890,6 @@ Advanced options (experts only):
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
   --smbd=SMBD              use specified smbd [$smbd]
-  --with-git=GIT           use specified git [$git]
   --with-git-submodules=update   update git submodules (default if .git dir exists)
   --with-git-submodules=validate fail if git submodules are not up to date
   --with-git-submodules=ignore   do not update or check git submodules (default if no .git dir)
@@ -1699,7 +1696,7 @@ fi
 #######################################
 # generate config-host.mak
 
-if ! (GIT="$git" "$source_path/scripts/git-submodule.sh" "$git_submodules_action" "$git_submodules"); then
+if ! (GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" "$git_submodules"); then
     exit 1
 fi
 
@@ -1709,7 +1706,6 @@ echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo >> $config_host_mak
 
 echo all: >> $config_host_mak
-echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
 echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_host_mak
 
diff --git a/meson.build b/meson.build
index cabf36ec5e9..eb09af6ec82 100644
--- a/meson.build
+++ b/meson.build
@@ -4026,7 +4026,6 @@ summary(summary_info, bool_yn: true, section: 'Directories')
 
 # Host binaries
 summary_info = {}
-summary_info += {'git':               config_host['GIT']}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      sphinx_build}
 if config_host.has_key('HAVE_GDB_BIN')
diff --git a/scripts/ci/org.centos/stream/8/x86_64/configure b/scripts/ci/org.centos/stream/8/x86_64/configure
index 6e8983f39cd..de76510978f 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/configure
+++ b/scripts/ci/org.centos/stream/8/x86_64/configure
@@ -29,14 +29,12 @@
 --extra-cflags="-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection" \
 --with-suffix="qemu-kvm" \
 --firmwarepath=/usr/share/qemu-firmware \
---with-git=meson \
 --with-git-submodules=update \
 --target-list="x86_64-softmmu" \
 --block-drv-rw-whitelist="qcow2,raw,file,host_device,nbd,iscsi,rbd,blkdebug,luks,null-co,nvme,copy-on-read,throttle,gluster" \
 --audio-drv-list="" \
 --block-drv-ro-whitelist="vmdk,vhdx,vpc,https,ssh" \
 --with-coroutine=ucontext \
---with-git=git \
 --tls-priority=@QEMU,SYSTEM \
 --disable-attr \
 --disable-auth-pam \
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 7be41f59483..0ce1efc44e5 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -12,7 +12,7 @@ maybe_modules="$@"
 # if --with-git-submodules=ignore, do nothing
 test "$command" = "ignore" && exit 0
 
-test -z "$GIT" && GIT=git
+test -z "$GIT" && GIT=$(command -v git)
 
 cd "$(dirname "$0")/.."
 
@@ -21,19 +21,14 @@ update_error() {
     echo
     echo "Unable to automatically checkout GIT submodules '$modules'."
     echo "If you require use of an alternative GIT binary (for example to"
-    echo "enable use of a transparent proxy), then please specify it by"
-    echo "running configure by with the '--with-git' argument. e.g."
-    echo
-    echo " $ ./configure --with-git='tsocks git'"
-    echo
-    echo "Alternatively you may disable automatic GIT submodule checkout"
-    echo "with:"
+    echo "enable use of a transparent proxy), please disable automatic"
+    echo "GIT submodule checkout with:"
     echo
     echo " $ ./configure --with-git-submodules=validate"
     echo
     echo "and then manually update submodules prior to running make, with:"
     echo
-    echo " $ scripts/git-submodule.sh update $modules"
+    echo " $ GIT='tsocks git' scripts/git-submodule.sh update $modules"
     echo
     exit 1
 }
@@ -57,6 +52,12 @@ then
     exit 1
 fi
 
+if test -n "$maybe_modules" && test -z "$GIT"
+then
+    echo "$0: unexpectedly called with submodules but git binary not found"
+    exit 1
+fi
+
 modules=""
 for m in $maybe_modules
 do
-- 
2.40.1


