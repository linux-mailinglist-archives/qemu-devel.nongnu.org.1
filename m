Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F6A763CA0
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 18:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhHN-000330-0q; Wed, 26 Jul 2023 12:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOhEu-0001Pu-Sx
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOhEs-0006Bf-Bq
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690388388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fkrC9xx/iOOdNJzYzj+RdPgJsAuMdIqXJYlmNbYsnz4=;
 b=SY3ZFS86uH/reorJO0lLGUABY5TTZaY2XSkphZ2EWpbRYxc+iaC3NiRo2/or8vn4tZPPIj
 47jlROvWa01oaxbD5/Ur06pf2+LXBZZOfQ8FZQxHIXjR9twqa3imhRhYKI52Ayk62GpU8Z
 PWNsqXta41JiD5P8Nw0g3CDzy+Pv7Vw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-fJJozFhiPXONDfcDaX02rw-1; Wed, 26 Jul 2023 12:19:45 -0400
X-MC-Unique: fJJozFhiPXONDfcDaX02rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF3FA856506;
 Wed, 26 Jul 2023 16:19:44 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFECB4094DC0;
 Wed, 26 Jul 2023 16:19:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab: remove duplication between msys jobs
Date: Wed, 26 Jul 2023 17:19:42 +0100
Message-ID: <20230726161942.229093-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Although they share a common parent, the two msys jobs still have
massive duplication in their script definitions that can easily be
collapsed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/windows.yml | 132 +++++++++++++++------------------------
 1 file changed, 49 insertions(+), 83 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f889a468b5..f086540e40 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -35,97 +35,63 @@
   - .\msys64\usr\bin\bash -lc 'pacman --noconfirm -Syuu'  # Core update
   - .\msys64\usr\bin\bash -lc 'pacman --noconfirm -Syuu'  # Normal update
   - taskkill /F /FI "MODULES eq msys-2.0.dll"
-
-msys2-64bit:
-  extends: .shared_msys2_builder
   script:
   - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
       bison diffutils flex
       git grep make sed
-      mingw-w64-x86_64-capstone
-      mingw-w64-x86_64-curl
-      mingw-w64-x86_64-cyrus-sasl
-      mingw-w64-x86_64-dtc
-      mingw-w64-x86_64-gcc
-      mingw-w64-x86_64-glib2
-      mingw-w64-x86_64-gnutls
-      mingw-w64-x86_64-gtk3
-      mingw-w64-x86_64-libgcrypt
-      mingw-w64-x86_64-libjpeg-turbo
-      mingw-w64-x86_64-libnfs
-      mingw-w64-x86_64-libpng
-      mingw-w64-x86_64-libssh
-      mingw-w64-x86_64-libtasn1
-      mingw-w64-x86_64-libusb
-      mingw-w64-x86_64-lzo2
-      mingw-w64-x86_64-nettle
-      mingw-w64-x86_64-ninja
-      mingw-w64-x86_64-pixman
-      mingw-w64-x86_64-pkgconf
-      mingw-w64-x86_64-python
-      mingw-w64-x86_64-SDL2
-      mingw-w64-x86_64-SDL2_image
-      mingw-w64-x86_64-snappy
-      mingw-w64-x86_64-spice
-      mingw-w64-x86_64-usbredir
-      mingw-w64-x86_64-zstd "
+      $MINGW_TARGET-capstone
+      $MINGW_TARGET-curl
+      $MINGW_TARGET-cyrus-sasl
+      $MINGW_TARGET-dtc
+      $MINGW_TARGET-gcc
+      $MINGW_TARGET-glib2
+      $MINGW_TARGET-gnutls
+      $MINGW_TARGET-gtk3
+      $MINGW_TARGET-libgcrypt
+      $MINGW_TARGET-libjpeg-turbo
+      $MINGW_TARGET-libnfs
+      $MINGW_TARGET-libpng
+      $MINGW_TARGET-libssh
+      $MINGW_TARGET-libtasn1
+      $MINGW_TARGET-libusb
+      $MINGW_TARGET-lzo2
+      $MINGW_TARGET-nettle
+      $MINGW_TARGET-ninja
+      $MINGW_TARGET-pixman
+      $MINGW_TARGET-pkgconf
+      $MINGW_TARGET-python
+      $MINGW_TARGET-SDL2
+      $MINGW_TARGET-SDL2_image
+      $MINGW_TARGET-snappy
+      $MINGW_TARGET-spice
+      $MINGW_TARGET-usbredir
+      $MINGW_TARGET-zstd "
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
-  - $env:MSYSTEM = 'MINGW64'     # Start a 64-bit MinGW environment
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
   - mkdir build
   - cd build
-  # Note: do not remove "--without-default-devices"!
-  # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
-  # changed to compile QEMU with the --without-default-devices switch
-  # for the msys2 64-bit job, due to the build could not complete within
-  # the project timeout.
-  - ..\msys64\usr\bin\bash -lc '../configure --target-list=x86_64-softmmu
-      --without-default-devices --enable-fdt=system'
-  - ..\msys64\usr\bin\bash -lc 'make'
-  # qTests don't run successfully with "--without-default-devices",
-  # so let's exclude the qtests from CI for now.
-  - ..\msys64\usr\bin\bash -lc 'make check MTESTARGS=\"--no-suite qtest\" || { cat meson-logs/testlog.txt; exit 1; } ;'
+  - ..\msys64\usr\bin\bash -lc "../configure --enable-fdt=system $CONFIGURE_ARGS"
+  - ..\msys64\usr\bin\bash -lc "make"
+  - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
+
+msys2-64bit:
+  extends: .shared_msys2_builder
+  variables:
+    MINGW_TARGET: mingw-w64-x86_64
+    MSYSTEM: MINGW64
+    # do not remove "--without-default-devices"!
+    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
+    # changed to compile QEMU with the --without-default-devices switch
+    # for the msys2 64-bit job, due to the build could not complete within
+    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices
+    # qTests don't run successfully with "--without-default-devices",
+    # so let's exclude the qtests from CI for now.
+    TEST_ARGS: --no-suite qtest
 
 msys2-32bit:
   extends: .shared_msys2_builder
-  script:
-  - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
-      bison diffutils flex
-      git grep make sed
-      mingw-w64-i686-capstone
-      mingw-w64-i686-curl
-      mingw-w64-i686-cyrus-sasl
-      mingw-w64-i686-dtc
-      mingw-w64-i686-gcc
-      mingw-w64-i686-glib2
-      mingw-w64-i686-gnutls
-      mingw-w64-i686-gtk3
-      mingw-w64-i686-libgcrypt
-      mingw-w64-i686-libjpeg-turbo
-      mingw-w64-i686-libnfs
-      mingw-w64-i686-libpng
-      mingw-w64-i686-libssh
-      mingw-w64-i686-libtasn1
-      mingw-w64-i686-libusb
-      mingw-w64-i686-lzo2
-      mingw-w64-i686-nettle
-      mingw-w64-i686-ninja
-      mingw-w64-i686-pixman
-      mingw-w64-i686-pkgconf
-      mingw-w64-i686-python
-      mingw-w64-i686-SDL2
-      mingw-w64-i686-SDL2_image
-      mingw-w64-i686-snappy
-      mingw-w64-i686-spice
-      mingw-w64-i686-usbredir
-      mingw-w64-i686-zstd "
-  - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
-  - $env:MSYSTEM = 'MINGW32'     # Start a 32-bit MinGW environment
-  - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
-  - mkdir build
-  - cd build
-  - ..\msys64\usr\bin\bash -lc '../configure --target-list=ppc64-softmmu
-                                --enable-fdt=system'
-  - ..\msys64\usr\bin\bash -lc 'make'
-  - ..\msys64\usr\bin\bash -lc 'make check MTESTARGS=\"--no-suite qtest\" ||
-                                { cat meson-logs/testlog.txt; exit 1; }'
+  variables:
+    MINGW_TARGET: mingw-w64-i686
+    MSYSTEM: MINGW32
+    CONFIGURE_ARGS:  --target-list=ppc64-softmmu
+    TEST_ARGS: --no-suite qtest
-- 
2.41.0


