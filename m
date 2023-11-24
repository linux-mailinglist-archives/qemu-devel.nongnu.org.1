Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 963587F77B9
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:25:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2f-0004go-Bj; Fri, 24 Nov 2023 10:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2d-0004gZ-N5
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2c-0004Ad-0d
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/20DDByM3Qsjva1Qthl5NkPrrLu3hCoWgmP4Oz1sqnY=;
 b=bVFbowtO+/Anhqqb/MO+r45LxJN3Ot2bM9s+OBhFz0XqoSa4dO2XQauz/4elWSZ7uOjK5S
 DmX1+/yCFPumOjbLauYnTvp/0jN1gbxM2wl6sMchPBxmgTIHNM6c4tOhPRWHyMOYyp+8Gp
 qCj9OvSJPtw+0UVlQ5EtuqG1d++0eAo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-P8Ox6sp-OzCRvj2q3AcBHQ-1; Fri, 24 Nov 2023 10:24:24 -0500
X-MC-Unique: P8Ox6sp-OzCRvj2q3AcBHQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-679f5ae0a7fso21307086d6.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839463; x=1701444263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/20DDByM3Qsjva1Qthl5NkPrrLu3hCoWgmP4Oz1sqnY=;
 b=Bm3prhl7RABdlgekT46PEnqh5I0O0zCKuPTXWkMd/Xf16Gr14SXiBenoLpLXDWGKoK
 B13/WbGpKwkA7TbtOXAVlMvSBoDEr5xp5bP0rkyxkfGlSHuUXytf0kfDZI7XoXpygMVY
 /nMBqTRfW7oitmwnXOl0Kr5rKTRR8LzlnhGVL6OekyH0bovYy3uzjpexi5OLl8kfENcz
 xYqX3+nXmmX2DrtBSgc5vDl1uRo7gGBcyHvSc+VedommHjO8zAzaLJOzJ1sguzYwiaFD
 mvs0qUwZUK0qbmsiwHmkB9GAvnNNEOjCEtxximH8Kq/CX0TD+HqJx9OHpBkZcmiKkl6S
 ZBOw==
X-Gm-Message-State: AOJu0YxJrr5vbZFyEnQ4o5uoW1cpVhZWnpa+qMyJ5VNqIRMy5KbYwj/W
 lg9OsPriNDEC5AzaGz8IqVxrCGcZgSBs0NLIHuRhfjiP1Bydr4LqOWt4/vgPEuaT3lBegH/1B79
 hkfcX7CX6fM6AFgdFqZBPv92fW8m7B4n06LScJ2gTXvX8ZOUu7iJcwEhN6zVh9yp/iHbyUej8A/
 Y=
X-Received: by 2002:a05:6214:1fd0:b0:679:e3e1:a9bd with SMTP id
 jh16-20020a0562141fd000b00679e3e1a9bdmr3184357qvb.33.1700839463094; 
 Fri, 24 Nov 2023 07:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTatovI0IVFac6zEM3R8n8R/S2Sgga+OzEfRxqzFLv7vLzcUSp/++ZlKlE0RX29rgyxldYzg==
X-Received: by 2002:a05:6214:1fd0:b0:679:e3e1:a9bd with SMTP id
 jh16-20020a0562141fd000b00679e3e1a9bdmr3184329qvb.33.1700839462665; 
 Fri, 24 Nov 2023 07:24:22 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a05621415c400b0067a17f65a9csm531040qvz.21.2023.11.24.07.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/10] .gitlab-ci.d/cirrus: Add manual testing of macOS 14
 (Sonoma)
Date: Fri, 24 Nov 2023 16:24:03 +0100
Message-ID: <20231124152408.140936-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Upgrade libvirt-ci so it covers macOS 14. Add a manual entry
(QEMU_JOB_OPTIONAL: 1) to test on Sonoma release. Refresh the
lci-tool generated files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231109160504.93677-3-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/cirrus.yml           | 16 ++++++++++++++++
 .gitlab-ci.d/cirrus/macos-14.vars | 16 ++++++++++++++++
 tests/lcitool/libvirt-ci          |  2 +-
 tests/lcitool/refresh             |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 07dc6edae1c..64f2e25afab 100644
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
index 00000000000..43070f4a265
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
index 36bc517161c..77c800186f3 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 36bc517161c45ead20224d47f2dc4fa428af6724
+Subproject commit 77c800186f34b21be7660750577cc5582a914deb
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 993683cf484..0c93557ad67 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -207,6 +207,7 @@ try:
     #
     generate_cirrus("freebsd-13")
     generate_cirrus("macos-13")
+    generate_cirrus("macos-14")
 
     #
     # VM packages lists
-- 
2.43.0


