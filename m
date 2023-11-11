Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DB7E8B5F
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 16:30:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pve-0003yf-Ia; Sat, 11 Nov 2023 10:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvd-0003yS-A9
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvb-0008KO-I7
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699716582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kh8hHoHBgX/fTehaZ1B5Sfw7yk3YdWsOqVB7Mq6gH8Q=;
 b=e3sk4AAf0elZQjLXOpTQWH+IEvaXjjnePH9mfUeXhMhQyIi04rlhEgp5avqIkK3yGGaRu3
 WO6ZQwd48XKHViBkCEp5ovrW2cPHblHemI/QbQCMUSOp83kdUoGdNWeI0kUFbxLVnr0QTH
 1SGG+dA7y/UIyqNNmEhxBeHhqwqBgI4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-agDX8IXDM5KOylrViluFRA-1; Sat, 11 Nov 2023 10:29:41 -0500
X-MC-Unique: agDX8IXDM5KOylrViluFRA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9e293cd8269so227221266b.0
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 07:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716579; x=1700321379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kh8hHoHBgX/fTehaZ1B5Sfw7yk3YdWsOqVB7Mq6gH8Q=;
 b=fD3GLLQ4/N/iQRG8hfyMHKYNxLF6i6j7tYjhR54dhtCKn9SvmKbkXTtaN/dqei5ZWZ
 I4DArwfcmvDOmUZOGL5rraU2tcgM0kj7QIHFpXCaOIVyQvvCIKxIGIT8N/q/1w3xkIQT
 GHm8LkMImWsXlpa816nzTeoY4SeM+Hc3GgkPtjjArXNwDosa/Vtr6TKC9Z7sLkBzv5MF
 OYkoCUADKEVOu+UEFXLLfqPOI7ay2BzJY72Cz/xtfkCkT2hHDV6y8uWjJXy8Msl+H7uh
 1Q5hUPBHzcVTWnlACA9jArAKECoprpsf6cmVosQh/+XnBFLNyyzoEj9iJ6ryf/j5uLm5
 4doQ==
X-Gm-Message-State: AOJu0YwkVRFAjvkU51tUyL5zSxzL5m8HtHKgBnqbLGrvDDQHFpQHSnv2
 S6P0SB294uk64wH1v1Xri9iy4BH1pwdek41WwKylWLNMAZJezx84701DEVPqAtAj73sP3Yfh+q8
 m5lfZAdPWNVd3IsC+8gRyJuc/DG9kfjhiAETuWuBn41YR69hbP4gltWW9E/rnGkCbcWSuH7YJ2T
 k=
X-Received: by 2002:a17:906:4147:b0:9e6:59d5:71c4 with SMTP id
 l7-20020a170906414700b009e659d571c4mr1412389ejk.16.1699716579461; 
 Sat, 11 Nov 2023 07:29:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXoW04a5P0QOH+7XRoRD1Z73Y5lCd0C+An3u5Z+DeJ2DQgd6IoyTVNjwuXcmmAH8oSOKAHFA==
X-Received: by 2002:a17:906:4147:b0:9e6:59d5:71c4 with SMTP id
 l7-20020a170906414700b009e659d571c4mr1412378ejk.16.1699716579127; 
 Sat, 11 Nov 2023 07:29:39 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a170906a41600b0099d798a6bb5sm1209620ejz.67.2023.11.11.07.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:29:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/6] .gitlab-ci.d/cirrus: Add manual testing of macOS 14
 (Sonoma)
Date: Sat, 11 Nov 2023 16:29:23 +0100
Message-ID: <20231111152923.966998-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231111152923.966998-1-pbonzini@redhat.com>
References: <20231111152923.966998-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
index 2259f131b48..e11d0ba381f 100755
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


