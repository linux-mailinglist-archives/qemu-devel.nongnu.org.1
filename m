Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12605766FCF
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPORt-0002vr-2E; Fri, 28 Jul 2023 10:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORq-0002vP-NS
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPORp-0006yB-8A
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690554484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AUsO605mo1yE4/sLbpmZd3dIaRAPYWrlG6fvmbl5hE=;
 b=Wtg5WWT/xhN4s9oT/2Y1alf/f+lqE4og3mgshg0NDScmEK/XeK71rYNHK6qPKs9/9//yV0
 Xu4rb5Ef8UsQLu53SBsuIOh9imaIJQ4TiH9j0utx9iFGnRGyMznCGOSOlAwu2lVaQhCr9C
 PvqQBHVhr93LmKXRMo5FVPuPqdTe6p8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-raNa4HQINYWv5cCDK50Vmg-1; Fri, 28 Jul 2023 10:28:01 -0400
X-MC-Unique: raNa4HQINYWv5cCDK50Vmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CFDB80027F;
 Fri, 28 Jul 2023 14:28:00 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69A2340C2063;
 Fri, 28 Jul 2023 14:27:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 6/6] gitlab-ci.d/windows: Use Clang for compiling in the
 64-bit MSYS2 job
Date: Fri, 28 Jul 2023 16:27:48 +0200
Message-Id: <20230728142748.305341-7-thuth@redhat.com>
In-Reply-To: <20230728142748.305341-1-thuth@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We are struggeling with timeouts in the 64-bit MSYS2 job. Clang seems
to be a little bit faster, so let's use this compiler now instead.

There is a problem with compiling the spice headers with Clang, though,
so we can only test this in the 32-bit builds with GCC now. And we have
to disable dbus-display - otherwise the compilation aborts in the CI.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f086540e40..ff9e9af4bb 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -43,7 +43,6 @@
       $MINGW_TARGET-curl
       $MINGW_TARGET-cyrus-sasl
       $MINGW_TARGET-dtc
-      $MINGW_TARGET-gcc
       $MINGW_TARGET-glib2
       $MINGW_TARGET-gnutls
       $MINGW_TARGET-gtk3
@@ -63,9 +62,9 @@
       $MINGW_TARGET-SDL2
       $MINGW_TARGET-SDL2_image
       $MINGW_TARGET-snappy
-      $MINGW_TARGET-spice
       $MINGW_TARGET-usbredir
-      $MINGW_TARGET-zstd "
+      $MINGW_TARGET-zstd
+      $EXTRA_PACKAGES "
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
   - mkdir build
@@ -77,13 +76,15 @@
 msys2-64bit:
   extends: .shared_msys2_builder
   variables:
-    MINGW_TARGET: mingw-w64-x86_64
-    MSYSTEM: MINGW64
+    MINGW_TARGET: mingw-w64-clang-x86_64
+    MSYSTEM: CLANG64
+    EXTRA_PACKAGES: binutils mingw-w64-clang-x86_64-clang
     # do not remove "--without-default-devices"!
     # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
     # changed to compile QEMU with the --without-default-devices switch
     # for the msys2 64-bit job, due to the build could not complete within
-    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices
+    CONFIGURE_ARGS: --target-list=x86_64-softmmu --without-default-devices
+                    --cc=clang --disable-dbus-display
     # qTests don't run successfully with "--without-default-devices",
     # so let's exclude the qtests from CI for now.
     TEST_ARGS: --no-suite qtest
@@ -93,5 +94,6 @@ msys2-32bit:
   variables:
     MINGW_TARGET: mingw-w64-i686
     MSYSTEM: MINGW32
+    EXTRA_PACKAGES: mingw-w64-i686-gcc mingw-w64-i686-spice
     CONFIGURE_ARGS:  --target-list=ppc64-softmmu
     TEST_ARGS: --no-suite qtest
-- 
2.39.3


