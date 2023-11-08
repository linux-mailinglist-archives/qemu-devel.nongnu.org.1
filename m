Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B027E5D4C
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 19:34:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0nMX-0007SZ-Jw; Wed, 08 Nov 2023 13:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0nMU-0007Ro-T2
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:33:10 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0nMS-0002yE-Tn
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:33:10 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507962561adso9609173e87.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 10:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699468387; x=1700073187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sjGHTrxzwEAUajPpIMG7q/DAjj1XmmdYO7Mb2TzPag=;
 b=IVepP0JN3ISndaaTaC7CIsxgkEKErrkrjep7NKlNUmFPdfRTlWViyRWYBiouQ3wwab
 2xKBGvf87xSjFbfRXDX2xqh2RNZp36MikYylqR14gWtACrJkvYSwXxRnW2x+94jfpTQw
 jQFlTc2mNgUKeHX2TamSGTmA2W+WSQ+pvvl0xqysoN62KoFvm88//cK/WY6aGL14fiVK
 CyIpwLdp3w+yqY4XeuI6EXunyjqk9pvlCmxe0lVJzCWBkryL0i02i2Ujx4THSV0Hwonj
 Duqmp/mnnucPe1r7BYKIQjJ+g3CNSp4HMyfW3FNtFNeXabIKMLsBg9AQESUIQKHphg7R
 hkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699468387; x=1700073187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7sjGHTrxzwEAUajPpIMG7q/DAjj1XmmdYO7Mb2TzPag=;
 b=DvxOxT9cwg8ZW/abw+tYH91eku1Vqgy0KFR4B8eNakY936Dja54Lcn0I2scnUTlL4t
 vqFdlHWfqZXRht3WrvAA8hDuomI39goPwo1Ww1rOixRpXnBdTgW1n6cifH1Pk9Z93FuA
 XbP+ZlBQw0xz/diRT/kL+/U5Pdr7TyE0jAydinxFTOP9cpI4y2w+cKbtvSn+/Dl+VYTA
 BR09vDlGL9fn13p5/Whj2u1h2vHcrK5bVs3Vzd7w7MNg3w7fXv00DwzMZFAvnD8NkRs3
 jjTKgBWQmUbnu0BxDZp4mdaFbh4jff8B22NyLHbCp+vM553g9XW+ZzQa2WqhBvYIZ7b2
 aEFg==
X-Gm-Message-State: AOJu0Yx+/xOEMYYxeEGDjiAi0by6N1hQ9GiQNpwB3/MfF7dMnWWR/RTH
 yOO8XSyeXR+Debrny7IaKrndIE1aaSPRmQCEJzU=
X-Google-Smtp-Source: AGHT+IHHcvbOaEIgt4FKpWg34KW+1xW91R2jQ7HoSFocUF02HdMGlSeclTp2ZYPqtM+DmIi9lLM2tQ==
X-Received: by 2002:a19:c215:0:b0:503:333e:b387 with SMTP id
 l21-20020a19c215000000b00503333eb387mr1936956lfc.41.1699468387012; 
 Wed, 08 Nov 2023 10:33:07 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 a11-20020adfed0b000000b0032d9337e7d1sm5534286wro.11.2023.11.08.10.33.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Nov 2023 10:33:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Subject: [PATCH 2/2] .gitlab-ci.d/cirrus: Add manual testing of macOS 14
 (Sonoma)
Date: Wed,  8 Nov 2023 19:32:51 +0100
Message-ID: <20231108183251.80572-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108183251.80572-1-philmd@linaro.org>
References: <20231108183251.80572-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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
Docs are disabled due to:

  Collecting sphinx
    Downloading sphinx-7.2.6-py3-none-any.whl.metadata (5.9 kB)
  Collecting sphinx-rtd-theme
    Downloading sphinx_rtd_theme-1.3.0-py2.py3-none-any.whl.metadata (4.5 kB)
  ...
  Installing collected packages ...
  ...
  python determined to be '/opt/homebrew/bin/python3'
  python version: Python 3.11.6
  mkvenv: Creating non-isolated virtual environment at 'pyvenv'
  mkvenv: checking for sphinx>=1.6
  mkvenv: checking for sphinx_rtd_theme>=0.5
  ...
  Program /opt/homebrew/opt/python@3.12/bin/sphinx-build found: NO
  ../docs/meson.build:1:15: ERROR: Program '/opt/homebrew/opt/python@3.12/bin/sphinx-build' not found or not executable

¯\_(ツ)_/¯
---
 .gitlab-ci.d/cirrus.yml           | 17 +++++++++++++++++
 .gitlab-ci.d/cirrus/macos-14.vars | 16 ++++++++++++++++
 tests/lcitool/libvirt-ci          |  2 +-
 tests/lcitool/refresh             |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 07dc6edae1..84ce143509 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -74,6 +74,23 @@ aarch64-macos-13-base-build:
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
+    CONFIGURE_ARGS: --disable-docs
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


