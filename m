Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BB75638A
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNcd-0006Ko-LI; Mon, 17 Jul 2023 08:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcZ-0006Fz-M9
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcX-0008IB-GC
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689597992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TxPD72r1VF9f8XKugMnfp1PJeyYlHWXDCpSi6pCqFsc=;
 b=CPz72fqg4odepOH4JB9fPRSz1UoNFmonxzHM1wZKxFPlZG3jHEqBxYXFwtOePlHqFldkaI
 Y8nnzwpkj7Mpe5WlvoZpXrlJhiFzR5Wvp1r7Q9TQ3GlscRHz2N+/Ei0Pypordi+00QN3Qt
 OfLGt5yf1zUOMS7fomewDgwNGANn6bI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-WneXG20PMMqof9rZodiTHA-1; Mon, 17 Jul 2023 08:46:29 -0400
X-MC-Unique: WneXG20PMMqof9rZodiTHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B8158D168D;
 Mon, 17 Jul 2023 12:46:29 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E750C1121314;
 Mon, 17 Jul 2023 12:46:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 09/19] tests/lcitool: add pipewire
Date: Mon, 17 Jul 2023 16:45:34 +0400
Message-ID: <20230717124545.177236-10-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230506163735.3481387-3-marcandre.lureau@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker                | 1 +
 tests/docker/dockerfiles/centos8.docker               | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-amd64.docker          | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 15 files changed, 15 insertions(+)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 43370f7b36..fa455f1474 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -77,6 +77,7 @@ RUN apk update && \
         numactl-dev \
         openssh-client \
         pcre-dev \
+        pipewire-dev \
         pixman-dev \
         pkgconf \
         pulseaudio-dev \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index 78f454b782..da7dc818fb 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -90,6 +90,7 @@ RUN dnf distro-sync -y && \
         openssh-clients \
         pam-devel \
         pcre-static \
+        pipewire-devel \
         pixman-devel \
         pkgconfig \
         pulseaudio-libs-devel \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 016c2321f1..b7bdc01243 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -116,6 +116,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:amd64 \
                       libnuma-dev:amd64 \
                       libpam0g-dev:amd64 \
+                      libpipewire-0.3-dev:amd64 \
                       libpixman-1-dev:amd64 \
                       libpmem-dev:amd64 \
                       libpng-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index e39871c7bb..6d2fa38e3e 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -69,6 +69,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnuma-dev \
                       libpam0g-dev \
                       libpcre2-dev \
+                      libpipewire-0.3-dev \
                       libpixman-1-dev \
                       libpmem-dev \
                       libpng-dev \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 3c114efa11..68165c2f23 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -116,6 +116,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:arm64 \
                       libnuma-dev:arm64 \
                       libpam0g-dev:arm64 \
+                      libpipewire-0.3-dev:arm64 \
                       libpixman-1-dev:arm64 \
                       libpng-dev:arm64 \
                       libpulse-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index dfbd47db89..2fb65308c7 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -116,6 +116,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:armel \
                       libnuma-dev:armel \
                       libpam0g-dev:armel \
+                      libpipewire-0.3-dev:armel \
                       libpixman-1-dev:armel \
                       libpng-dev:armel \
                       libpulse-dev:armel \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 4e0084e896..df77ccb57b 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -116,6 +116,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:armhf \
                       libnuma-dev:armhf \
                       libpam0g-dev:armhf \
+                      libpipewire-0.3-dev:armhf \
                       libpixman-1-dev:armhf \
                       libpng-dev:armhf \
                       libpulse-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 88adf333e9..63a3d7aa3b 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -115,6 +115,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:mips64el \
                       libnuma-dev:mips64el \
                       libpam0g-dev:mips64el \
+                      libpipewire-0.3-dev:mips64el \
                       libpixman-1-dev:mips64el \
                       libpng-dev:mips64el \
                       libpulse-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 256e8b5dfe..ac87bbb095 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -115,6 +115,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:mipsel \
                       libnuma-dev:mipsel \
                       libpam0g-dev:mipsel \
+                      libpipewire-0.3-dev:mipsel \
                       libpixman-1-dev:mipsel \
                       libpng-dev:mipsel \
                       libpulse-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 4d19cd2bd7..def11f1693 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -116,6 +116,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:ppc64el \
                       libnuma-dev:ppc64el \
                       libpam0g-dev:ppc64el \
+                      libpipewire-0.3-dev:ppc64el \
                       libpixman-1-dev:ppc64el \
                       libpng-dev:ppc64el \
                       libpulse-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 642bbde3d1..80028e1eea 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -116,6 +116,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnfs-dev:s390x \
                       libnuma-dev:s390x \
                       libpam0g-dev:s390x \
+                      libpipewire-0.3-dev:s390x \
                       libpixman-1-dev:s390x \
                       libpng-dev:s390x \
                       libpulse-dev:s390x \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 8a35a17617..c5b6c96943 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -98,6 +98,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                openssh-clients \
                pam-devel \
                pcre-static \
+               pipewire-devel \
                pixman-devel \
                pkgconfig \
                pulseaudio-libs-devel \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 185abe57d8..37c83e5e4e 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -88,6 +88,7 @@ RUN zypper update -y && \
            openssh \
            pam-devel \
            pcre-devel-static \
+           pipewire-devel \
            pkgconfig \
            python39-base \
            python39-pip \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 1d442cdfe6..8f939870ae 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -69,6 +69,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libnuma-dev \
                       libpam0g-dev \
                       libpcre2-dev \
+                      libpipewire-0.3-dev \
                       libpixman-1-dev \
                       libpmem-dev \
                       libpng-dev \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 21fd3d2cf9..d452a891ee 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -85,6 +85,7 @@ packages:
  - pam
  - pcre-static
  - pixman
+ - pipewire
  - pkg-config
  - pulseaudio
  - python3
-- 
2.41.0


