Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE37790806
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEG-00017H-18; Sat, 02 Sep 2023 08:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEE-00013K-1L
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEB-0001hC-Q0
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdLsJG62Ze4MUY0tKyHT3F9g6F8Ou2/1hureqaW2AWw=;
 b=KYhGoFLe6z/0kXg2VPW2K0F9APWMezK8+pE2kbD59cUD6gvip9m5qq0XDAWmzfFmWSJT64
 3qHiL34VEr4zyTSW6zM3JFC8W3/DSh5Apm2uMXeB7fDxmGgq5nhIySxiaiPZW0GJ0RZ1C9
 6Chcr8cSSFNIaaO0GyPKXwXE/oXBxXE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-fnDC_Bd8Nxm_8mEU4J8t8g-1; Sat, 02 Sep 2023 08:59:49 -0400
X-MC-Unique: fnDC_Bd8Nxm_8mEU4J8t8g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c5c762f97so1647054f8f.1
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659588; x=1694264388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdLsJG62Ze4MUY0tKyHT3F9g6F8Ou2/1hureqaW2AWw=;
 b=HoUQhkJdfKKRgs0pWm5fXnSZOuM28f7sntLwv/mGjSnkQ6JqmXiBD3jTT9Pgx0rLzw
 dg+IczXDiTcMXCFp3epHDSeMBgCy+NnoeQNkcPxIuG0FJbwt06o4qIqukxJcAMbDyxsb
 V8iASMIxtYHa14azCx+/JwNLYK7FH0PGhUWRBC4Uq2dW4r73cOwx3QgmZp4X2fhyw0ru
 YLzYxIK5xHuJaUTKEtcofNupeQiOVZmMxRFln4nXjYlMrKqdL9V4Le6A1rvvM9Z5DkYF
 vSzqBUSAZyE9YXRpagmWbldA90ccnwJnFzm2POXOnxU2cIlgGecL8rxh9oHWboDTWS0r
 yS6w==
X-Gm-Message-State: AOJu0Yzm/5KIjSaDkvX7bNXGp8fWffS9uJbQ9Nox4fJhngXGezAW0OSb
 5m5T34R8zw9xa7Pwyh3PrKE60FSkAIyEdddC4izhnrNUFKz/RmiGelv8FSiEx5tOKmzc8Ij4IEy
 eU1anrmWEHxqHwBoyS+YxHcnX30SE+UHQfF4Gx7ULR2nM1rR6xkdTJ8hSl+jYkiE4fO2BKPFnaq
 4=
X-Received: by 2002:a05:6000:10cf:b0:314:748:d59d with SMTP id
 b15-20020a05600010cf00b003140748d59dmr3464620wrx.27.1693659587819; 
 Sat, 02 Sep 2023 05:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpWjliVqVheTHM/U1Me/RRj2jM8hR14tLqitVIefTS/sfPdRJhpsUSsVX+5FtaXaz2LH+WZw==
X-Received: by 2002:a05:6000:10cf:b0:314:748:d59d with SMTP id
 b15-20020a05600010cf00b003140748d59dmr3464609wrx.27.1693659587474; 
 Sat, 02 Sep 2023 05:59:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm4995496wra.116.2023.09.02.05.59.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/15] configure: remove boolean variables for targets
Date: Sat,  2 Sep 2023 14:59:25 +0200
Message-ID: <20230902125934.113017-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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


