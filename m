Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF58B03D0
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXWH-0004k5-R7; Wed, 24 Apr 2024 03:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWF-0004jc-Ge
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWC-00032S-Qc
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0B/2fzfvrMK4hG10tmFNVoHfT4l0uTlAMgv9txuxV24=;
 b=QNeDBh8xvlkScFzqZPRicnZ0zQR11QNVIMHsMr0XyrVBKlxkHRltMbFyNwqvuyo82HWk59
 gNF54DLNIsrhNxkQAw0OYPpDJqt8ObCyYev1UwUbISqbljPkn+37s1uAttNZEKCKAsQkXz
 KyIy9yiEv6IX8/AkAsjJYMpCTa3uvdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-r-njrWOYO0uOW6oAtb3OPg-1; Wed, 24 Apr 2024 03:58:12 -0400
X-MC-Unique: r-njrWOYO0uOW6oAtb3OPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94B3C1011A0F;
 Wed, 24 Apr 2024 07:58:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 621BE43FAD;
 Wed, 24 Apr 2024 07:58:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/17] tests: Update our CI to use CentOS Stream 9 instead of 8
Date: Wed, 24 Apr 2024 09:57:30 +0200
Message-ID: <20240424075735.248041-13-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

RHEL 9 (and thus also the derivatives) have been available since two
years now, so according to QEMU's support policy, we can drop the active
support for the previous major version 8 now.

Another reason for doing this is that Centos Stream 8 will go EOL soon:

https://blog.centos.org/2023/04/end-dates-are-coming-for-centos-stream-8-and-centos-linux-7/

  "After May 31, 2024, CentOS Stream 8 will be archived
   and no further updates will be provided."

Thus upgrade our CentOS Stream container to major version 9 now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240418101056.302103-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml                    | 16 ++++-----
 .gitlab-ci.d/container-core.yml               |  4 +--
 .../{centos8.docker => centos9.docker}        | 34 +++++++------------
 tests/lcitool/mappings.yml                    | 20 -----------
 tests/lcitool/refresh                         |  2 +-
 tests/vm/centos                               |  4 +--
 6 files changed, 26 insertions(+), 54 deletions(-)
 rename tests/docker/dockerfiles/{centos8.docker => centos9.docker} (82%)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index cfdff175c3..9f34c650d6 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -158,9 +158,9 @@ build-system-centos:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    job: amd64-centos8-container
+    job: amd64-centos9-container
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
     CONFIGURE_ARGS: --disable-nettle --enable-gcrypt --enable-vfio-user-server
       --enable-modules --enable-trace-backends=dtrace --enable-docs
     TARGETS: ppc64-softmmu or1k-softmmu s390x-softmmu
@@ -242,7 +242,7 @@ check-system-centos:
     - job: build-system-centos
       artifacts: true
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
     MAKE_CHECK_ARGS: check
 
 avocado-system-centos:
@@ -251,7 +251,7 @@ avocado-system-centos:
     - job: build-system-centos
       artifacts: true
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
     MAKE_CHECK_ARGS: check-avocado
     AVOCADO_TAGS: arch:ppc64 arch:or1k arch:s390x arch:x86_64 arch:rx
       arch:sh4 arch:nios2
@@ -327,9 +327,9 @@ avocado-system-flaky:
 build-tcg-disabled:
   extends: .native_build_job_template
   needs:
-    job: amd64-centos8-container
+    job: amd64-centos9-container
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
   script:
     - mkdir build
     - cd build
@@ -651,9 +651,9 @@ build-tci:
 build-without-defaults:
   extends: .native_build_job_template
   needs:
-    job: amd64-centos8-container
+    job: amd64-centos9-container
   variables:
-    IMAGE: centos8
+    IMAGE: centos9
     CONFIGURE_ARGS:
       --without-default-devices
       --without-default-features
diff --git a/.gitlab-ci.d/container-core.yml b/.gitlab-ci.d/container-core.yml
index 08f8450fa1..5459447676 100644
--- a/.gitlab-ci.d/container-core.yml
+++ b/.gitlab-ci.d/container-core.yml
@@ -1,10 +1,10 @@
 include:
   - local: '/.gitlab-ci.d/container-template.yml'
 
-amd64-centos8-container:
+amd64-centos9-container:
   extends: .container_job_template
   variables:
-    NAME: centos8
+    NAME: centos9
 
 amd64-fedora-container:
   extends: .container_job_template
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos9.docker
similarity index 82%
rename from tests/docker/dockerfiles/centos8.docker
rename to tests/docker/dockerfiles/centos9.docker
index ea618bf352..6cf47ce786 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -1,15 +1,14 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all centos-stream-8 qemu
+#  $ lcitool dockerfile --layers all centos-stream-9 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM quay.io/centos/centos:stream8
+FROM quay.io/centos/centos:stream9
 
 RUN dnf distro-sync -y && \
     dnf install 'dnf-command(config-manager)' -y && \
-    dnf config-manager --set-enabled -y powertools && \
-    dnf install -y centos-release-advanced-virtualization && \
+    dnf config-manager --set-enabled -y crb && \
     dnf install -y epel-release && \
     dnf install -y epel-next-release && \
     dnf install -y \
@@ -42,7 +41,6 @@ RUN dnf distro-sync -y && \
         glib2-static \
         glibc-langpack-en \
         glibc-static \
-        glusterfs-api-devel \
         gnutls-devel \
         gtk3-devel \
         hostname \
@@ -82,6 +80,7 @@ RUN dnf distro-sync -y && \
         lzo-devel \
         make \
         mesa-libgbm-devel \
+        meson \
         mtools \
         ncurses-devel \
         nettle-devel \
@@ -95,25 +94,25 @@ RUN dnf distro-sync -y && \
         pixman-devel \
         pkgconfig \
         pulseaudio-libs-devel \
-        python38 \
-        python38-PyYAML \
-        python38-numpy \
-        python38-pip \
-        python38-setuptools \
-        python38-wheel \
+        python3 \
+        python3-PyYAML \
+        python3-numpy \
+        python3-pillow \
+        python3-pip \
+        python3-sphinx \
+        python3-sphinx_rtd_theme \
+        python3-tomli \
         rdma-core-devel \
         sed \
         snappy-devel \
         socat \
         spice-protocol \
-        spice-server-devel \
         swtpm \
         systemd-devel \
         systemtap-sdt-devel \
         tar \
         usbredir-devel \
         util-linux \
-        virglrenderer-devel \
         vte291-devel \
         which \
         xfsprogs-devel \
@@ -132,18 +131,11 @@ RUN dnf distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3.8 install \
-                    meson==0.63.2 \
-                    pillow \
-                    sphinx \
-                    sphinx-rtd-theme \
-                    tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3.8"
+ENV PYTHON "/usr/bin/python3"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 407c03301b..03b974ad02 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -1,66 +1,50 @@
 mappings:
   flake8:
-    CentOSStream8:
     OpenSUSELeap15:
 
   meson:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3:
-    CentOSStream8: python38
     OpenSUSELeap15: python311-base
 
   python3-PyYAML:
-    CentOSStream8: python38-PyYAML
     OpenSUSELeap15:
 
   python3-devel:
-    CentOSStream8: python38-devel
     OpenSUSELeap15: python311-devel
 
   python3-docutils:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-numpy:
-    CentOSStream8: python38-numpy
     OpenSUSELeap15:
 
   python3-opencv:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-pillow:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-pip:
-    CentOSStream8: python38-pip
     OpenSUSELeap15: python311-pip
 
   python3-pillow:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-selinux:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-setuptools:
-    CentOSStream8: python38-setuptools
     OpenSUSELeap15: python311-setuptools
 
   python3-sphinx:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-sphinx-rtd-theme:
-    CentOSStream8:
     OpenSUSELeap15:
 
   python3-sqlite3:
-    CentOSStream8: python38
     OpenSUSELeap15: python311
 
   python3-tomli:
@@ -69,15 +53,11 @@ mappings:
     Fedora:
     Debian12:
     OpenSUSELeap15:
-    # Not available for Python 3.8
-    CentOSStream8:
 
   python3-venv:
-    CentOSStream8: python38
     OpenSUSELeap15: python311-base
 
   python3-wheel:
-    CentOSStream8: python38-wheel
     OpenSUSELeap15: python311-pip
 
 pypi_mappings:
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 692752a3df..24a735a3f2 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -125,7 +125,7 @@ try:
     # Standard native builds
     #
     generate_dockerfile("alpine", "alpine-318")
-    generate_dockerfile("centos8", "centos-stream-8")
+    generate_dockerfile("centos9", "centos-stream-9")
     generate_dockerfile("debian", "debian-12",
                         trailer="".join(debian12_extras))
     generate_dockerfile("fedora", "fedora-38")
diff --git a/tests/vm/centos b/tests/vm/centos
index 097a9ca14d..d25c8f8b5b 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -26,8 +26,8 @@ class CentosVM(basevm.BaseVM):
         export SRC_ARCHIVE=/dev/vdb;
         sudo chmod a+r $SRC_ARCHIVE;
         tar -xf $SRC_ARCHIVE;
-        make docker-test-block@centos8 {verbose} J={jobs} NETWORK=1;
-        make docker-test-quick@centos8 {verbose} J={jobs} NETWORK=1;
+        make docker-test-block@centos9 {verbose} J={jobs} NETWORK=1;
+        make docker-test-quick@centos9 {verbose} J={jobs} NETWORK=1;
     """
 
     def build_image(self, img):
-- 
2.44.0


