Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 371358B03CF
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:02:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXWH-0004k4-QP; Wed, 24 Apr 2024 03:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWE-0004jH-MG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWC-00032g-EJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5iLB26jzb73TFxjFBT1B59aiGF04L3Ws6vv7Ow8vZE=;
 b=jMWShpkoG9VmwdE1CumVtp2cH1YmrYtMbokHSEcUZHwoDEljydel87qlEeGrbhlPtv6Kpx
 rms2ogdFyZjsfAyXl1afAh008ymFcoYVRMIjmapLKy2vscFXrXusW+EB1TMsr18cQ3oB82
 OLCxAIXWIsG041lpH4wgsx9SAoVyQHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-Z5yqVLvLOlitjSFzF2XuTg-1; Wed, 24 Apr 2024 03:58:12 -0400
X-MC-Unique: Z5yqVLvLOlitjSFzF2XuTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 127A118065AF;
 Wed, 24 Apr 2024 07:58:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE94E43FAD;
 Wed, 24 Apr 2024 07:58:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/17] tests/docker/dockerfiles: Run lcitool-refresh after the
 lcitool update
Date: Wed, 24 Apr 2024 09:57:29 +0200
Message-ID: <20240424075735.248041-12-thuth@redhat.com>
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

This update adds the removing of the EXTERNALLY-MANAGED marker files
that has been added to the lcitool recently.

Quoting Daniel:
"For those who don't know, python now commonly blocks the ability to
run 'pip install' outside of a venv. This generally makes sense for
a precious installation environment. Our containers are disposable
though, so a venv has no benefit. Removing the 'EXTERNALLY-MANAGED'
allows the historical arbitrary use of 'pip' outside a venv.
lcitool just does this unconditionally given the containers are
not precious."

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240418101056.302103-4-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker                | 3 ++-
 tests/docker/dockerfiles/centos8.docker               | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-armel-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-i686-cross.docker     | 3 ++-
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 3 ++-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 3 ++-
 tests/docker/dockerfiles/debian-riscv64-cross.docker  | 3 ++-
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian.docker                | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 ++-
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 17 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 42f6928627..cd9d7af1ce 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -116,7 +116,8 @@ RUN apk update && \
         zlib-static \
         zstd \
         zstd-dev && \
-    apk list | sort > /packages.txt && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
+    apk list --installed | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index d97c30e96a..ea618bf352 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -123,6 +123,7 @@ RUN dnf distro-sync -y && \
         zstd && \
     dnf autoremove -y && \
     dnf clean all -y && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 00bdc06021..d0b0e9778e 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -64,7 +64,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 2dae3777f7..8cb225740e 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -64,7 +64,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 75342c09b0..e6f37418ed 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -65,7 +65,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 180ed836e6..407a014f57 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -64,7 +64,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 3fc4e15acd..bdc9566b67 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -65,7 +65,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 17d3e01ecc..4d995d0b12 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -65,7 +65,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 5fcd641f15..0cf803bda5 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -65,7 +65,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index d6be2f0cc5..6180ec08c3 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -64,7 +64,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index a26637ec4f..591572ae94 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -33,7 +33,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index ec0041d6aa..90c8d3c7b8 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -64,7 +64,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoremove -y && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index b5e642d5b6..5722482e4c 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -137,6 +137,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index f8e4cb70d3..d1a480fa71 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -64,7 +64,8 @@ exec "$@"\n' > /usr/bin/nosync && \
                xorriso \
                zstd && \
     nosync dnf autoremove -y && \
-    nosync dnf clean all -y
+    nosync dnf clean all -y && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 9e9c71fa94..7e6ab0308a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -137,6 +137,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                zstd && \
     nosync dnf autoremove -y && \
     nosync dnf clean all -y && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index cf753383a4..c4055bdd10 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -119,6 +119,7 @@ RUN zypper update -y && \
            zlib-devel-static \
            zstd && \
     zypper clean --all && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     rpm -qa | sort > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 2ca9cff79c..b8e78331db 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -137,6 +137,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get autoclean -y && \
     sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
     dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
     mkdir -p /usr/libexec/ccache-wrappers && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
-- 
2.44.0


