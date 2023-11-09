Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2B7E6E3A
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:07:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17Yc-0002oY-2r; Thu, 09 Nov 2023 11:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r17YR-0002m5-PU
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:06:52 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r17YN-00025Z-I6
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:06:50 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso1631318a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699546004; x=1700150804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5o8mNcW0P9nWHGHroQIQNN8g8hfA+Kb5OXgqjRnAp0=;
 b=hZ1+9stlySaEX8dpU3GJdNU4CQ4qm8Iwzb2Xyu8+vefAItjy9UFDNsHBlpLl2+Scq0
 24QdhcubbOsIUWkqt4sXCMAGRfkeUWqKmG71Dr/qMAp5v/5MFo20ma9Rg2vpf9sgXriW
 cjKwHrLXPYf7ybX1jRoDKqOVZeyBcpZjpi/2jgcg6c77G3HBtcVKrMPk04fTHVdxoYHu
 tMZ96468xwkK7wIHlz09YX74JGF4YCjLweJm6f3ApWCd2NjZ4JkVBjy6dGZNhFOyAKSf
 EnF8VNktBa/x3xXKC+lyY9jK778GLEeWWseQ04z7mU4BAPq3MYvumsczPeKc8W7tI+Pn
 esDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699546004; x=1700150804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5o8mNcW0P9nWHGHroQIQNN8g8hfA+Kb5OXgqjRnAp0=;
 b=U+uxOrpdHMbzm6op9DH9gKFZRqb1UtQhBg8ZPYEgMujXtqfw4TmZmWtaZZCQmRG3J5
 Sh0J7t19/Bo8tftKqWbHpxhzOkdEfmGn29T9XyRXfZJFmzeWoAcTbPNFC/ykJmwhQxjN
 wlLLYpuoJuIibWiA5KcZWLcnkdwjOqdB5w1YN6cLm2KAdrQ0ET3K2HLwoZWKiitQRbX+
 qol6KmNpH1vaodCjeoMGV73VWA7tk1FoqgSqnXZQTpZVQ4UM04CwK4M/a0XmSAGngxDu
 t46xXeJomVD0znud0V1O+MHzcePUFIAd36OoV1L72c6H0qQy6umHNzSb4Bp6DstXNCDB
 IWQQ==
X-Gm-Message-State: AOJu0Yz1v50tMzTvR30EsqlN4w3oc9Y8xKkUNMrb25C4AVljVYqn0kew
 A/ZRcEuujkWJe7uI1EldbDI4/A==
X-Google-Smtp-Source: AGHT+IFWC+lwuFStcE/VP2T2NI++VdFd8n+ZjI5aWNKrClU2VG+NP7RKqQXI4hHhST2st84rv7anaw==
X-Received: by 2002:a17:907:720b:b0:9dd:f00d:c4e5 with SMTP id
 dr11-20020a170907720b00b009ddf00dc4e5mr4672111ejc.53.1699546004429; 
 Thu, 09 Nov 2023 08:06:44 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 vj14-20020a170907d48e00b009e5c644e34dsm32409ejc.82.2023.11.09.08.06.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 08:06:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/2] .gitlab-ci.d/cirrus: Add manual testing of macOS 14
 (Sonoma)
Date: Thu,  9 Nov 2023 17:05:03 +0100
Message-ID: <20231109160504.93677-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109160504.93677-1-philmd@linaro.org>
References: <20231109160504.93677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Upgrade libvirt-ci so it covers macOS 14. Add a manual entry
(QEMU_JOB_OPTIONAL: 1) to test on Sonoma release. Refresh the
lci-tool generated files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .gitlab-ci.d/cirrus.yml           | 16 ++++++++++++++++
 .gitlab-ci.d/cirrus/macos-14.vars | 16 ++++++++++++++++
 tests/lcitool/libvirt-ci          |  2 +-
 tests/lcitool/refresh             |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 07dc6edae1..64f2e25afa 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -74,6 +74,22 @@ aarch64-macos-13-base-build:
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
 
+aarch64-macos-14-base-build:
+  extends: .cirrus_build_job
+  variables:
+    NAME: macos-14
+    CIRRUS_VM_INSTANCE_TYPE: macos_instance
+    CIRRUS_VM_IMAGE_SELECTOR: image
+    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
+    CIRRUS_VM_CPUS: 12
+    CIRRUS_VM_RAM: 24G
+    UPDATE_COMMAND: brew update
+    INSTALL_COMMAND: brew install
+    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
+    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
+    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
+    QEMU_JOB_OPTIONAL: 1
+
 
 # The following jobs run VM-based tests via KVM on a Linux-based Cirrus-CI job
 .cirrus_kvm_job:
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
new file mode 100644
index 0000000000..43070f4a26
--- /dev/null
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -0,0 +1,16 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool variables macos-14 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+CCACHE='/opt/homebrew/bin/ccache'
+CPAN_PKGS=''
+CROSS_PKGS=''
+MAKE='/opt/homebrew/bin/gmake'
+NINJA='/opt/homebrew/bin/ninja'
+PACKAGING_COMMAND='brew'
+PIP3='/opt/homebrew/bin/pip3'
+PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
+PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 36bc517161..77c800186f 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 36bc517161c45ead20224d47f2dc4fa428af6724
+Subproject commit 77c800186f34b21be7660750577cc5582a914deb
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 2259f131b4..e11d0ba381 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -197,6 +197,7 @@ try:
     #
     generate_cirrus("freebsd-13")
     generate_cirrus("macos-13")
+    generate_cirrus("macos-14")
 
     #
     # VM packages lists
-- 
2.41.0


