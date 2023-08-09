Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA577566F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:31:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfVr-0004YP-Rq; Wed, 09 Aug 2023 05:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVm-0004XS-6m
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVj-0003ac-Bv
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691573386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ScmLQ4Ae2VMYiNdEl36OkPh+svAFxf+aDqjUCJxBhac=;
 b=jCZv3WBq/hnx5r7Jzdzlkt8RFz5hP59gvxMRBYpHHnIw7VXGSLIzTCP9mvHdI79ie1BfPH
 nInk4efljnT1D9ohHMrM2SsK8U9JCrKOdkOsHHb0QAmYX0nCNjvKn/UBjZP+9e7zML2MeE
 +oq3BwAbU1lmNqEFO6y38DVNGo/EA4I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-R8jUBkVCOHWJOFZmdvbyrw-1; Wed, 09 Aug 2023 05:29:44 -0400
X-MC-Unique: R8jUBkVCOHWJOFZmdvbyrw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9ba719605so75073321fa.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573383; x=1692178183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ScmLQ4Ae2VMYiNdEl36OkPh+svAFxf+aDqjUCJxBhac=;
 b=l2Fz8vO4+46Pzfd2KMwtUbdj0STydCfryYZ0vmmyHKhXTBpkITJCeufEUDJA4uMLmi
 G7p4X6v6uB3Bo7VesyZc9Qvoh0RO8JhxpRgLiosr1njLPA2xG9XP5InDIfvpy7n7iCE8
 14/G4jt+I1zUpAO1d77ccpPi9b+C3roNa5kLKINtt3G3yNjnd0dXnFLmUxOG5BPvbMIX
 ZAvtPx5QCbgFLuz0BRJOpAmUAsV2MHWK/DGO9TkT2hNOhwcveaQTaXVpMnfjk9Ahxfo+
 2dL10yUl7Z+3+JdxJVNhzhrSJofZVqvscWXSc6GH85UyyrvPmdEfnpbE/wp0I85eoI6l
 gz4Q==
X-Gm-Message-State: AOJu0YzY560vMIT8FxChF3d1LnOVatUzxasA2srAHd8sg43y3uM1jHBW
 iWStdd56edV6fx8u5qhvCxZnEYgpsSVGZeQwalmm7JkuFC+S8ogv5irjX4z+8TzbGWPgN/BH+Sm
 Zgg2xmtz5cQg1O8cGx501vrZcxW34mR0fSt3dIflnGYxlYyaWECWYgiNjzyI178PKGYDzFp5sJL
 A=
X-Received: by 2002:a2e:b0fc:0:b0:2b9:ee3e:240c with SMTP id
 h28-20020a2eb0fc000000b002b9ee3e240cmr1508685ljl.24.1691573382825; 
 Wed, 09 Aug 2023 02:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHjdG0nh0ojTdLPXqYhbd9MRm06tAW74CyCJWioUtYGKSe9IDYcIpmQM66FI+Yfnn+WFfxSA==
X-Received: by 2002:a2e:b0fc:0:b0:2b9:ee3e:240c with SMTP id
 h28-20020a2eb0fc000000b002b9ee3e240cmr1508672ljl.24.1691573382402; 
 Wed, 09 Aug 2023 02:29:42 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a05600c0b4b00b003fe20db88ebsm1407471wmr.31.2023.08.09.02.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:29:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 4/9] lcitool: bump libvirt-ci submodule and regenerate
Date: Wed,  9 Aug 2023 11:29:28 +0200
Message-ID: <20230809092933.761524-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
References: <20230809092933.761524-1-pbonzini@redhat.com>
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

This brings in a newer version of the pipewire mapping, so rename it.

Python 3.9 and 3.10 do not seem to work in OpenSUSE LEAP 15.5 (weird,
because 3.9 persisted from 15.3 to 15.4) so bump the Python runtime
version to 3.11.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../dockerfiles/debian-amd64-cross.docker     |  2 +-
 .../dockerfiles/debian-arm64-cross.docker     |  2 +-
 .../dockerfiles/debian-armel-cross.docker     |  2 +-
 .../dockerfiles/debian-armhf-cross.docker     |  2 +-
 .../dockerfiles/debian-mips64el-cross.docker  |  2 +-
 .../dockerfiles/debian-mipsel-cross.docker    |  2 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |  2 +-
 .../dockerfiles/debian-riscv64-cross.docker   |  2 +-
 .../dockerfiles/debian-s390x-cross.docker     |  2 +-
 .../dockerfiles/fedora-win32-cross.docker     |  2 +-
 .../dockerfiles/fedora-win64-cross.docker     |  2 +-
 tests/docker/dockerfiles/opensuse-leap.docker | 22 +++++++++----------
 tests/lcitool/libvirt-ci                      |  2 +-
 tests/lcitool/mappings.yml                    | 12 +++++-----
 tests/lcitool/projects/qemu.yml               |  2 +-
 tests/lcitool/targets/opensuse-leap-15.yml    |  4 ++--
 16 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index b7bdc012431..b9871f9c8c7 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross x86_64 debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch x86_64 debian-11 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 68165c2f23e..3504c771a76 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross aarch64 debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch aarch64 debian-11 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index 2fb65308c7a..6d11c9510fd 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross armv6l debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch armv6l debian-11 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index df77ccb57bd..37ae575cf7e 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross armv7l debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-11 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 63a3d7aa3b9..26ed730165a 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mips64el debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-11 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index ac87bbb0956..ade2f37ed1d 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mipsel debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mipsel debian-11 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index def11f16933..08dcffa0a85 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross ppc64le debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch ppc64le debian-11 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index a2d879ee1fd..a26637ec4fb 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross riscv64 debian-sid qemu-minimal
+#  $ lcitool dockerfile --layers all --cross-arch riscv64 debian-sid qemu-minimal
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 80028e1eeab..48a2c10fdbd 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross s390x debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch s390x debian-11 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
index e3dfd68bede..afa988574f9 100644
--- a/tests/docker/dockerfiles/fedora-win32-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mingw32 fedora-38 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mingw32 fedora-38 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 0e15c9643a7..cf93a0ca600 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross mingw64 fedora-38 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-38 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 37c83e5e4ef..fef8d5a2e45 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -4,7 +4,7 @@
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.opensuse.org/opensuse/leap:15.4
+FROM registry.opensuse.org/opensuse/leap:15.5
 
 RUN zypper update -y && \
     zypper install -y \
@@ -90,9 +90,9 @@ RUN zypper update -y && \
            pcre-devel-static \
            pipewire-devel \
            pkgconfig \
-           python39-base \
-           python39-pip \
-           python39-setuptools \
+           python311-base \
+           python311-pip \
+           python311-setuptools \
            rdma-core-devel \
            sed \
            snappy-devel \
@@ -125,18 +125,18 @@ RUN zypper update -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3.9 install \
-                    PyYAML \
-                    meson==0.63.2 \
-                    pillow \
-                    sphinx \
-                    sphinx-rtd-theme
+RUN /usr/bin/pip3.11 install \
+                     PyYAML \
+                     meson==0.63.2 \
+                     pillow \
+                     sphinx \
+                     sphinx-rtd-theme
 
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3.9"
+ENV PYTHON "/usr/bin/python3.11"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 9bff3b763b5..bbd55b4d18c 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb
+Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 454963f07b8..3c554099ed6 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -9,7 +9,7 @@ mappings:
 
   python3:
     CentOSStream8: python38
-    OpenSUSELeap15: python39-base
+    OpenSUSELeap15: python311-base
 
   python3-PyYAML:
     CentOSStream8: python38-PyYAML
@@ -17,7 +17,7 @@ mappings:
 
   python3-devel:
     CentOSStream8: python38-devel
-    OpenSUSELeap15: python39-devel
+    OpenSUSELeap15: python311-devel
 
   python3-docutils:
     CentOSStream8:
@@ -37,7 +37,7 @@ mappings:
 
   python3-pip:
     CentOSStream8: python38-pip
-    OpenSUSELeap15: python39-pip
+    OpenSUSELeap15: python311-pip
 
   python3-pillow:
     CentOSStream8:
@@ -49,7 +49,7 @@ mappings:
 
   python3-setuptools:
     CentOSStream8: python38-setuptools
-    OpenSUSELeap15: python39-setuptools
+    OpenSUSELeap15: python311-setuptools
 
   python3-sphinx:
     CentOSStream8:
@@ -61,11 +61,11 @@ mappings:
 
   python3-venv:
     CentOSStream8: python38
-    OpenSUSELeap15: python39-base
+    OpenSUSELeap15: python311-base
 
   python3-wheel:
     CentOSStream8: python38-wheel
-    OpenSUSELeap15: python39-pip
+    OpenSUSELeap15: python311-pip
 
 pypi_mappings:
   # Request more recent version
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index d452a891eec..2d31cf792ae 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -85,7 +85,7 @@ packages:
  - pam
  - pcre-static
  - pixman
- - pipewire
+ - libpipewire-dev
  - pkg-config
  - pulseaudio
  - python3
diff --git a/tests/lcitool/targets/opensuse-leap-15.yml b/tests/lcitool/targets/opensuse-leap-15.yml
index 683016e0077..c2d87f6cb4d 100644
--- a/tests/lcitool/targets/opensuse-leap-15.yml
+++ b/tests/lcitool/targets/opensuse-leap-15.yml
@@ -1,3 +1,3 @@
 paths:
-  pip3: /usr/bin/pip3.9
-  python: /usr/bin/python3.9
+  pip3: /usr/bin/pip3.11
+  python: /usr/bin/python3.11
-- 
2.41.0


