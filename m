Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D336D98CE58
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 10:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuKr-0005JI-NA; Wed, 02 Oct 2024 04:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svuKp-0005J2-3y
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svuKn-00024o-2c
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727856223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lWt1lxbmGSEaf5N17C85jaIM52GOiYmDXZOZi0HS9m4=;
 b=YyFHaIJc7PLFZIWXOaXRB9sIwHCOhnPq1eNARGDEhoNB7D3yJnGJMySl6+oFoh0vaDzXB5
 8sWv6uaadN3AL9qjSqaXFYVH7urJw+97YKfUkdGyEHEVDa+VxRFjDjHIbygKbISqWHAyco
 IZvX9wpaMK7bApK7oZ37OUG6enu0VNs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-nGpONR4PNN2TTYPFpUMq1g-1; Wed,
 02 Oct 2024 04:03:40 -0400
X-MC-Unique: nGpONR4PNN2TTYPFpUMq1g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B386319560BF; Wed,  2 Oct 2024 08:03:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.239])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5C8E1956086; Wed,  2 Oct 2024 08:03:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5] testing: bump mips64el cross to bookworm and fix package
 list
Date: Wed,  2 Oct 2024 10:03:33 +0200
Message-ID: <20241002080333.127172-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

The mips64el cross setup is very broken for bullseye which has now
entered LTS support so is unlikely to be fixed. While we still can't
build the container with all packages for bookworm due to a single
missing dependency that will hopefully get fixed in due course. For
the sake of keeping the CI green we disable the problematic packages
via the lcitool's mappings.yml file.

See also: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081535

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[thuth: Disable the problematic packages via lcitool's mappings.yml]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v5: Adjust the patch subject

 .../dockerfiles/debian-mips64el-cross.docker  | 18 +++----------
 tests/lcitool/mappings.yml                    | 26 +++++++++++++++++++
 tests/lcitool/refresh                         |  2 +-
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 2862785692..bfa96cb507 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -48,16 +48,15 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
@@ -69,8 +68,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -97,17 +94,13 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcmocka-dev:mips64el \
                       libcurl4-gnutls-dev:mips64el \
                       libdaxctl-dev:mips64el \
-                      libdrm-dev:mips64el \
-                      libepoxy-dev:mips64el \
                       libfdt-dev:mips64el \
                       libffi-dev:mips64el \
                       libfuse3-dev:mips64el \
-                      libgbm-dev:mips64el \
                       libgcrypt20-dev:mips64el \
                       libglib2.0-dev:mips64el \
                       libglusterfs-dev:mips64el \
                       libgnutls28-dev:mips64el \
-                      libgtk-3-dev:mips64el \
                       libibverbs-dev:mips64el \
                       libiscsi-dev:mips64el \
                       libjemalloc-dev:mips64el \
@@ -126,8 +119,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       librbd-dev:mips64el \
                       librdmacm-dev:mips64el \
                       libsasl2-dev:mips64el \
-                      libsdl2-dev:mips64el \
-                      libsdl2-image-dev:mips64el \
                       libseccomp-dev:mips64el \
                       libselinux1-dev:mips64el \
                       libslirp-dev:mips64el \
@@ -141,8 +132,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libusb-1.0-0-dev:mips64el \
                       libusbredirhost-dev:mips64el \
                       libvdeplug-dev:mips64el \
-                      libvirglrenderer-dev:mips64el \
-                      libvte-2.91-dev:mips64el \
+                      libxdp-dev:mips64el \
                       libzstd-dev:mips64el \
                       nettle-dev:mips64el \
                       systemtap-sdt-dev:mips64el \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 03b974ad02..0ab3a89013 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -2,6 +2,20 @@ mappings:
   flake8:
     OpenSUSELeap15:
 
+  # Due to https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081535 we
+  # have to disable all packages that depend on libgl1-mesa-dri:mips64el
+  gtk3:
+    mips64el-deb:
+
+  libdrm:
+    mips64el-deb:
+
+  libepoxy:
+    mips64el-deb:
+
+  mesa-libgbm:
+    mips64el-deb:
+
   meson:
     OpenSUSELeap15:
 
@@ -60,6 +74,18 @@ mappings:
   python3-wheel:
     OpenSUSELeap15: python311-pip
 
+  sdl2:
+    mips64el-deb:
+
+  sdl2-image:
+    mips64el-deb:
+
+  virglrenderer:
+    mips64el-deb:
+
+  vte:
+    mips64el-deb:
+
 pypi_mappings:
   # Request more recent version
   meson:
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 92381f3c46..a78219f7bc 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -166,7 +166,7 @@ try:
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
-    generate_dockerfile("debian-mips64el-cross", "debian-11",
+    generate_dockerfile("debian-mips64el-cross", "debian-12",
                         cross="mips64el",
                         trailer=cross_build("mips64el-linux-gnuabi64-",
                                             "mips64el-softmmu,mips64el-linux-user"))
-- 
2.46.1


