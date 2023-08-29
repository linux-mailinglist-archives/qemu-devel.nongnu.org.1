Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7335778C048
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau74-0002qQ-Ej; Tue, 29 Aug 2023 04:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6p-0002nq-D3
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6l-000064-83
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fEPE6imw9pNRhe5WjUmgvjA1HD5DJ/ZMykyxx3rt30=;
 b=f+gi8sIpJZ1YozMomtEsmwHjMyL3Vl0eYeX2kYWy+aHULd7kYU7edNj1b4FrFmD3d+4Zgq
 bo/VWY+3gctyX44NTeTmcG5POEiAsX3cr0UMh9B5KI3ONpg3GcZptcQqTEkITrQ82TwOIX
 6BfoDjNudGcjvt8bz1WsR1MJaWnjl5Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-B1Kuom3DP8aOQt-03p796A-1; Tue, 29 Aug 2023 04:29:51 -0400
X-MC-Unique: B1Kuom3DP8aOQt-03p796A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so30397325e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297790; x=1693902590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fEPE6imw9pNRhe5WjUmgvjA1HD5DJ/ZMykyxx3rt30=;
 b=Q8AAn0pNrEMQUAtdomcX40PRqWxAMlH8xByacZC5+bFFs6AtIrsnOeiE30OD+D6bNy
 q5zH5N3TR+QT8yTsqe4E0qL4XfWU6xXX0Pmh6q3Wv/tC/0zp3bFGDNqDg22XPIvwbqAW
 uiRo2fqLhbyPy2aX2scEz04FZQhe/2HlKL6Gc70dzxUYtt3eBbHsAOmOE0DmeHFtAeT3
 /sdKQKsTc+26jJG/LkvemTg7NFBbiTu4Uj9mBRPG2KbFpSLY8YLuNEhsWh/SrQJk+Zdm
 Ksjjnv5M8Z71UVbllSxugqnDCUwtHBhzb08hzunCwbInfA6nruuJUg6lHwemH/DZK1bW
 UaMA==
X-Gm-Message-State: AOJu0YxVstEwhKTiZFawPYcsgvCLAugGDUJoeZeJR4ke/Z32lIZDgfHA
 DdtYBIcze02lQ1qpRC+1q4WjLSkGEvI7OWzqo0M7tzDb9jt3z5SX11RTGC/8ZBB0h2YT6LQlI0+
 G3yLoY1m6la/mlO8vnPrG5zdL2vcC0Jwag1mi1Ret6fDTE+b0ARPZDLgumjZaGfttgy5+jjP6E1
 s=
X-Received: by 2002:a1c:f304:0:b0:3fe:4900:db95 with SMTP id
 q4-20020a1cf304000000b003fe4900db95mr22395818wmq.37.1693297790130; 
 Tue, 29 Aug 2023 01:29:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW7pYsc38pVgh9dfzULYGDsZyGaVx6wch6m+ki9+BSUvmy+FugDPJGiOSPxICxBLxc9cnbJA==
X-Received: by 2002:a1c:f304:0:b0:3fe:4900:db95 with SMTP id
 q4-20020a1cf304000000b003fe4900db95mr22395802wmq.37.1693297789737; 
 Tue, 29 Aug 2023 01:29:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a5d508e000000b0031ad2f9269dsm12972481wrt.40.2023.08.29.01.29.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] configure: remove $linux and $mingw32 variables
Date: Tue, 29 Aug 2023 10:29:30 +0200
Message-ID: <20230829082931.67601-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829082931.67601-1-pbonzini@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
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
 configure | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index eba5befa2cf..aed48db68fd 100755
--- a/configure
+++ b/configure
@@ -374,12 +374,9 @@ fi
 
 # OS specific
 
-mingw32="no"
 bsd="no"
-linux="no"
 case $targetos in
 windows)
-  mingw32="yes"
   plugins="no"
   pie="no"
 ;;
@@ -405,9 +402,6 @@ darwin)
 haiku)
   pie="no"
 ;;
-linux)
-  linux="yes"
-;;
 esac
 
 if test ! -z "$cpu" ; then
@@ -622,7 +616,7 @@ do
     fi
 done
 
-if test "$mingw32" = "yes" ; then
+if test "$targetos" = "windows" ; then
   EXESUF=".exe"
   prefix="/qemu"
   bindir=""
@@ -805,7 +799,7 @@ for opt do
   ;;
   --enable-download) download="enabled"; git_submodules_action=update;
   ;;
-  --enable-plugins) if test "$mingw32" = "yes"; then
+  --enable-plugins) if test "$targetos" = "windows"; then
                         error_exit "TCG plugins not currently supported on Windows platforms"
                     else
                         plugins="yes"
@@ -1070,7 +1064,7 @@ fi
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
     if test -e "$source_path/.git" && \
-        { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
+        { test "$targetos" = linux || test "$targetos" = "windows"; }; then
         werror="yes"
     else
         werror="no"
@@ -1708,7 +1702,7 @@ echo all: >> $config_host_mak
 if test "$debug_tcg" = "yes" ; then
   echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
 fi
-if test "$mingw32" = "yes" ; then
+if test "$targetos" = "windows"; then
   echo "CONFIG_WIN32=y" >> $config_host_mak
   echo "QEMU_GA_MANUFACTURER=${QEMU_GA_MANUFACTURER-QEMU}" >> $config_host_mak
   echo "QEMU_GA_DISTRO=${QEMU_GA_DISTRO-Linux}" >> $config_host_mak
@@ -1717,7 +1711,7 @@ else
   echo "CONFIG_POSIX=y" >> $config_host_mak
 fi
 
-if test "$linux" = "yes" ; then
+if test "$targetos" = "linux" ; then
   echo "CONFIG_LINUX=y" >> $config_host_mak
 fi
 
@@ -1755,7 +1749,7 @@ echo "NINJA=$ninja" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers for KVM architectures
-if test "$linux" = "yes" && test -n "$linux_arch"; then
+if test "$targetos" = "linux" && test -n "$linux_arch"; then
   symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
 fi
 
-- 
2.41.0


