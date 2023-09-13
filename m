Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1EB79F12B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 20:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgUil-00078C-Mt; Wed, 13 Sep 2023 14:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qgUiI-00070q-M0
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 14:35:49 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qgUiD-0007yC-A6
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 14:35:45 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 892201C0004;
 Wed, 13 Sep 2023 18:35:37 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v4 1/2] tests: bump libvirt-ci for libasan and libxdp
Date: Wed, 13 Sep 2023 20:34:36 +0200
Message-ID: <20230913183620.1278418-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913183620.1278418-1-i.maximets@ovn.org>
References: <20230913183620.1278418-1-i.maximets@ovn.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.197; envelope-from=i.maximets@ovn.org;
 helo=relay5-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This pulls in the fixes for libasan version as well as support for
libxdp that will be used for af-xdp netdev in the next commits.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 tests/docker/dockerfiles/debian-amd64-cross.docker   | 2 +-
 tests/docker/dockerfiles/debian-amd64.docker         | 2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker   | 2 +-
 tests/docker/dockerfiles/debian-armel-cross.docker   | 2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker   | 2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker | 2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker   | 2 +-
 tests/docker/dockerfiles/opensuse-leap.docker        | 2 +-
 tests/docker/dockerfiles/ubuntu2004.docker           | 2 +-
 tests/docker/dockerfiles/ubuntu2204.docker           | 2 +-
 tests/lcitool/libvirt-ci                             | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index b66b9cc191..0cf3ba6d60 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -84,7 +84,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-x86-64-linux-gnu \
                       gcc-x86-64-linux-gnu \
                       libaio-dev:amd64 \
-                      libasan5:amd64 \
+                      libasan6:amd64 \
                       libasound2-dev:amd64 \
                       libattr1-dev:amd64 \
                       libbpf-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 02262bc70e..e3e1de25dd 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -32,7 +32,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libaio-dev \
-                      libasan5 \
+                      libasan6 \
                       libasound2-dev \
                       libattr1-dev \
                       libbpf-dev \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index a0a968b8c6..d8cd4f87b6 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -84,7 +84,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-aarch64-linux-gnu \
                       gcc-aarch64-linux-gnu \
                       libaio-dev:arm64 \
-                      libasan5:arm64 \
+                      libasan6:arm64 \
                       libasound2-dev:arm64 \
                       libattr1-dev:arm64 \
                       libbpf-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index f1fc34a28a..75342c09b0 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -84,7 +84,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-arm-linux-gnueabi \
                       gcc-arm-linux-gnueabi \
                       libaio-dev:armel \
-                      libasan5:armel \
+                      libasan6:armel \
                       libasound2-dev:armel \
                       libattr1-dev:armel \
                       libbpf-dev:armel \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index a278578211..f45cfedd3f 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -84,7 +84,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-arm-linux-gnueabihf \
                       gcc-arm-linux-gnueabihf \
                       libaio-dev:armhf \
-                      libasan5:armhf \
+                      libasan6:armhf \
                       libasound2-dev:armhf \
                       libattr1-dev:armhf \
                       libbpf-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 30e5efa986..52f8c34814 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -84,7 +84,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-powerpc64le-linux-gnu \
                       gcc-powerpc64le-linux-gnu \
                       libaio-dev:ppc64el \
-                      libasan5:ppc64el \
+                      libasan6:ppc64el \
                       libasound2-dev:ppc64el \
                       libattr1-dev:ppc64el \
                       libbpf-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index ee6db7b526..208e57bcf2 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -84,7 +84,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       g++-s390x-linux-gnu \
                       gcc-s390x-linux-gnu \
                       libaio-dev:s390x \
-                      libasan5:s390x \
+                      libasan6:s390x \
                       libasound2-dev:s390x \
                       libattr1-dev:s390x \
                       libbpf-dev:s390x \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index fef8d5a2e4..ed04b4d6da 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -40,7 +40,7 @@ RUN zypper update -y && \
            libSDL2-devel \
            libSDL2_image-devel \
            libaio-devel \
-           libasan6 \
+           libasan8 \
            libattr-devel \
            libbpf-devel \
            libbz2-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 4180cd8674..d3e212060c 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -32,7 +32,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libaio-dev \
-                      libasan5 \
+                      libasan6 \
                       libasound2-dev \
                       libattr1-dev \
                       libbrlapi-dev \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 88493f00f6..94c2c16118 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -32,7 +32,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       git \
                       hostname \
                       libaio-dev \
-                      libasan5 \
+                      libasan6 \
                       libasound2-dev \
                       libattr1-dev \
                       libbpf-dev \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index bbd55b4d18..5f84a21881 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
+Subproject commit 5f84a21881577a5fb56cc956f6fe4e2abd6fcff0
-- 
2.41.0


