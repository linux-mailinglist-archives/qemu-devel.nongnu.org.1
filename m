Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0718A9705
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Apr 2024 12:12:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOjf-0001KN-So; Thu, 18 Apr 2024 06:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxOjX-0001HX-LA
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxOjV-0004o0-Li
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713435068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtnFarnwo5zb+o632vTXAwSiWspak2JMrBeGC1XvQW4=;
 b=clrBwFJdz9K5P3Eftwvxli+HvujDVy9HAacyUAvQr51pBvmfY2StCMGL6oU16mHjPXXN0X
 XlF5CbNGIu3LnEYKUUrmNcPJfRf4U6rk1dbzDJuYaTE9IJKS2riP306NPpLXiGwxb/jo2I
 3IUYijtbAC+ybkYgI1L6I1IYkrId5wE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-LRuV9ls5MQerGkDaOu-wyg-1; Thu, 18 Apr 2024 06:11:04 -0400
X-MC-Unique: LRuV9ls5MQerGkDaOu-wyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52EF218A2BE1;
 Thu, 18 Apr 2024 10:11:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5A2DC1A225;
 Thu, 18 Apr 2024 10:11:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@dlhnet.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v3 01/13] tests: Remove Ubuntu 20.04 container
Date: Thu, 18 Apr 2024 12:10:44 +0200
Message-ID: <20240418101056.302103-2-thuth@redhat.com>
In-Reply-To: <20240418101056.302103-1-thuth@redhat.com>
References: <20240418101056.302103-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since Ubuntu 22.04 is now available since two years, we can stop
actively supporting the previous LTS version of Ubuntu now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/dockerfiles/ubuntu2004.docker | 157 ---------------------
 tests/lcitool/refresh                      |   1 -
 2 files changed, 158 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/ubuntu2004.docker

diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
deleted file mode 100644
index d3e212060c..0000000000
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ /dev/null
@@ -1,157 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all ubuntu-2004 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/ubuntu:20.04
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bison \
-                      bsdmainutils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      clang \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      g++ \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libaio-dev \
-                      libasan6 \
-                      libasound2-dev \
-                      libattr1-dev \
-                      libbrlapi-dev \
-                      libbz2-dev \
-                      libc6-dev \
-                      libcacard-dev \
-                      libcap-ng-dev \
-                      libcapstone-dev \
-                      libcmocka-dev \
-                      libcurl4-gnutls-dev \
-                      libdaxctl-dev \
-                      libdrm-dev \
-                      libepoxy-dev \
-                      libfdt-dev \
-                      libffi-dev \
-                      libfuse3-dev \
-                      libgbm-dev \
-                      libgcrypt20-dev \
-                      libglib2.0-dev \
-                      libglusterfs-dev \
-                      libgnutls28-dev \
-                      libgtk-3-dev \
-                      libibumad-dev \
-                      libibverbs-dev \
-                      libiscsi-dev \
-                      libjemalloc-dev \
-                      libjpeg-turbo8-dev \
-                      libjson-c-dev \
-                      liblttng-ust-dev \
-                      liblzo2-dev \
-                      libncursesw5-dev \
-                      libnfs-dev \
-                      libnuma-dev \
-                      libpam0g-dev \
-                      libpcre2-dev \
-                      libpixman-1-dev \
-                      libpmem-dev \
-                      libpng-dev \
-                      libpulse-dev \
-                      librbd-dev \
-                      librdmacm-dev \
-                      libsasl2-dev \
-                      libsdl2-dev \
-                      libsdl2-image-dev \
-                      libseccomp-dev \
-                      libselinux1-dev \
-                      libslirp-dev \
-                      libsnappy-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
-                      libspice-server-dev \
-                      libssh-dev \
-                      libsystemd-dev \
-                      libtasn1-6-dev \
-                      libubsan1 \
-                      libudev-dev \
-                      libusb-1.0-0-dev \
-                      libusbredirhost-dev \
-                      libvdeplug-dev \
-                      libvirglrenderer-dev \
-                      libvte-2.91-dev \
-                      libxen-dev \
-                      libzstd-dev \
-                      llvm \
-                      locales \
-                      make \
-                      mtools \
-                      multipath-tools \
-                      ncat \
-                      nettle-dev \
-                      ninja-build \
-                      openssh-client \
-                      pkgconf \
-                      python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
-                      python3-pip \
-                      python3-setuptools \
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-venv \
-                      python3-wheel \
-                      python3-yaml \
-                      rpm2cpio \
-                      sed \
-                      socat \
-                      sparse \
-                      systemtap-sdt-dev \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      xfslibs-dev \
-                      xorriso \
-                      zlib1g-dev \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
-
-RUN /usr/bin/pip3 install \
-                            meson==0.63.2 \
-                            tomli
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index fe7692c500..692752a3df 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -130,7 +130,6 @@ try:
                         trailer="".join(debian12_extras))
     generate_dockerfile("fedora", "fedora-38")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
-    generate_dockerfile("ubuntu2004", "ubuntu-2004")
     generate_dockerfile("ubuntu2204", "ubuntu-2204")
 
     #
-- 
2.44.0


