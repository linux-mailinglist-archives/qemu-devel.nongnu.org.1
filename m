Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C15F3797280
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdJ-000399-0G; Thu, 07 Sep 2023 09:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdG-00035b-Lg
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdE-0007MX-8Q
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdLsJG62Ze4MUY0tKyHT3F9g6F8Ou2/1hureqaW2AWw=;
 b=GHPzgwbdhGcVjJsd4KSyb2pHxPKPVQTdFGMWLey5ltG8hTtiXehM3v5mm39LaN/7Aa0Qx9
 u3C4ST5y10r3P5k4i933IBbAPJK7G6yk1Ubth3yqovN+ghVACLS/XXJTunl8OaFlP6TmGA
 QzGjJ+vRFy/OhT6PfS+4gCC9X/H/+UQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-JDz9IDv4PISQlR11pg67vA-1; Thu, 07 Sep 2023 09:01:07 -0400
X-MC-Unique: JDz9IDv4PISQlR11pg67vA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso7403235e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091665; x=1694696465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdLsJG62Ze4MUY0tKyHT3F9g6F8Ou2/1hureqaW2AWw=;
 b=M9DojuDXYrcb5pMN2XA4pi007j7n+KpykrU1KUnz3hPY2dsDWSrqkW78Qzmkj3ZbsO
 gerkLSxQQQq8Ld8Mwb5Tt+0+dgVKpHJEfm2AXQ5xZ5pWOw31tJl/jt+XOsoVeMFrvVSp
 b+58LU/zgK6UkXymQkemM5YwJn3TQpwekhpWqr5xbNqlo466H+DNYdxNkJpTxgvkwssZ
 hD/Lc6MOzHB0W/Sf23SsIJ6SkfAVBX2VnkefYwLBoAX8YuxKznTKs9gNSyU77jsGvF+F
 WN4JqebasWjZjW0l5S8Gs6VO+82iZo4ECC6TNeuUU2aYf4oGS89OFgmX6Ys/pBhviL0A
 DqfQ==
X-Gm-Message-State: AOJu0YyQlAjHcbBktE1v0E1vKUduJ0bYtMszTDH6etZQsLTzW9x9xFt7
 UE9272usXecxavWxPZtGdBouenCa9c0CRYkBKNzqlfCIuMz5KaPYKRwrbqpqhwCfFAtgPJqxd/k
 P5oJeWZOnS3hsoHWxdCdv5gR3vmHghqmAfPZc2zd5wjFmDnp0uFfhUxLTO0CLJ9/O7JKdMe47b5
 I=
X-Received: by 2002:a5d:4b87:0:b0:315:964b:89b9 with SMTP id
 b7-20020a5d4b87000000b00315964b89b9mr4721515wrt.52.1694091664878; 
 Thu, 07 Sep 2023 06:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDDlKG4fLa0mQ1N5Ze/m8kgUyChtZBloth/2zn81MSIP99BvAGljmV10e+b4Ju9xmuSWH8Rw==
X-Received: by 2002:a5d:4b87:0:b0:315:964b:89b9 with SMTP id
 b7-20020a5d4b87000000b00315964b89b9mr4721493wrt.52.1694091664538; 
 Thu, 07 Sep 2023 06:01:04 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 r17-20020a05600c299100b003fe26244858sm2424084wmd.46.2023.09.07.06.01.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/51] configure: remove boolean variables for targets
Date: Thu,  7 Sep 2023 14:59:34 +0200
Message-ID: <20230907130004.500601-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Just use $targetos always.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 55 +++++++++++++------------------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

diff --git a/configure b/configure
index 378a0de9fb6..f96f7359a83 100755
--- a/configure
+++ b/configure
@@ -374,45 +374,14 @@ fi
 
 # OS specific
 
-mingw32="no"
-bsd="no"
-linux="no"
-solaris="no"
 case $targetos in
 windows)
-  mingw32="yes"
   plugins="no"
   pie="no"
 ;;
-gnu/kfreebsd)
-  bsd="yes"
-;;
-freebsd)
-  bsd="yes"
-  # needed for kinfo_getvmmap(3) in libutil.h
-;;
-dragonfly)
-  bsd="yes"
-;;
-netbsd)
-  bsd="yes"
-;;
-openbsd)
-  bsd="yes"
-;;
-darwin)
-  bsd="yes"
-  darwin="yes"
-;;
-sunos)
-  solaris="yes"
-;;
 haiku)
   pie="no"
 ;;
-linux)
-  linux="yes"
-;;
 esac
 
 if test ! -z "$cpu" ; then
@@ -627,7 +596,7 @@ do
     fi
 done
 
-if test "$mingw32" = "yes" ; then
+if test "$targetos" = "windows" ; then
   EXESUF=".exe"
   prefix="/qemu"
   bindir=""
@@ -809,7 +778,7 @@ for opt do
   ;;
   --enable-download) download="enabled"; git_submodules_action=update;
   ;;
-  --enable-plugins) if test "$mingw32" = "yes"; then
+  --enable-plugins) if test "$targetos" = "windows"; then
                         error_exit "TCG plugins not currently supported on Windows platforms"
                     else
                         plugins="yes"
@@ -1080,7 +1049,7 @@ fi
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
     if test -e "$source_path/.git" && \
-        { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
+        { test "$targetos" = linux || test "$targetos" = "windows"; }; then
         werror="yes"
     else
         werror="no"
@@ -1718,7 +1687,7 @@ echo all: >> $config_host_mak
 if test "$debug_tcg" = "yes" ; then
   echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
 fi
-if test "$mingw32" = "yes" ; then
+if test "$targetos" = "windows"; then
   echo "CONFIG_WIN32=y" >> $config_host_mak
   echo "QEMU_GA_MANUFACTURER=${QEMU_GA_MANUFACTURER-QEMU}" >> $config_host_mak
   echo "QEMU_GA_DISTRO=${QEMU_GA_DISTRO-Linux}" >> $config_host_mak
@@ -1727,24 +1696,26 @@ else
   echo "CONFIG_POSIX=y" >> $config_host_mak
 fi
 
-if test "$linux" = "yes" ; then
+if test "$targetos" = "linux" ; then
   echo "CONFIG_LINUX=y" >> $config_host_mak
 fi
 
-if test "$darwin" = "yes" ; then
+if test "$targetos" = "darwin" ; then
   echo "CONFIG_DARWIN=y" >> $config_host_mak
 fi
 
-if test "$solaris" = "yes" ; then
+if test "$targetos" = "sunos" ; then
   echo "CONFIG_SOLARIS=y" >> $config_host_mak
 fi
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 
 # XXX: suppress that
-if [ "$bsd" = "yes" ] ; then
-  echo "CONFIG_BSD=y" >> $config_host_mak
-fi
+case $targetos in
+  gnu/kfreebsd | freebsd | dragonfly | netbsd | openbsd | darwin)
+    echo "CONFIG_BSD=y" >> $config_host_mak
+    ;;
+esac
 
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
@@ -1774,7 +1745,7 @@ echo "CC=$cc" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers for KVM architectures
-if test "$linux" = "yes" && test -n "$linux_arch"; then
+if test "$targetos" = "linux" && test -n "$linux_arch"; then
   symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
 fi
 
-- 
2.41.0


