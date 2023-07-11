Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCADD74F2AC
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEgS-0001GE-2X; Tue, 11 Jul 2023 10:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgP-0001Fz-Qe
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:41 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgO-0002nT-5n
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:41 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso733725966b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689086977; x=1691678977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJlBlsN50lnGlgulpATju4N8RnhzQCtwxBch73Vn4hk=;
 b=s4UANqLsS0bbwcyDFUBec/S2GJgPnADcdbi2TnLEWB14Yrm4oH9AuncIkR0uVVGRWT
 2RaKOTWBx6d3ZqgfOMDIBNsFr3pb9T7l23Jz7xk4bkn8O7f3o9Vgo07riDSUwfvkpFyz
 j9q+N4zmgX9SmGHve/jvvmZVTUsK0lMiC3Sf83ObLOPYKnog3p9OHEVZhVhZp6u2jVPv
 +s5JL2N/ftY0oW6mJxCuN4uE3z6cucpPkEPsbJkCJdSpv5DI3MGIgc9sfI+SJTic43EV
 mNiOwkpSt1MAAGX9Y7E3LlqDTTGhlhrzqpolJ8Q6QagBX2Q3+Ou63RQ6hmpI9t/srL1w
 nhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689086977; x=1691678977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJlBlsN50lnGlgulpATju4N8RnhzQCtwxBch73Vn4hk=;
 b=IHkQ6A3VasBz9QEFT+aZ9hogus+X2WGt/vYK1acBomzHHRkU+B9nEe0YdpPEkV7Rwh
 aE9TQvMZ9vQRPQubOt6qVzgHeaXyeIj6zd4au9ITmJg5FaSpvZER5uwH18fbdbbCYzdZ
 epNP8w7cWH7ARzcKI4QWwrJXFhXCHCLY30Gp+Bbe+HbhmStmrvp4gKD03ziRtDXY69PI
 MKCHNh5qVi0GmjQqilEPqKb1cXThZq3lPgusOLK2Of2MhbaU2Tqun1UBCZXfXiOxjS9v
 6qH/aK6AqZimYtWViCW7JWNwxvpfuC4oM7ThT+OHmvOmHx1vXw4MijFYzKdRO/Lp/khe
 fwUw==
X-Gm-Message-State: ABy/qLYd0VghvlZ5XDQWecqrRYDWA8VwRG94asiNSlIhTeJ7FDggV6sS
 j7ulw+mjFS13GxWijrxCl9rSgVPycychKwS+b3E=
X-Google-Smtp-Source: APBJJlGUzaq1GsDnCNDfRzu/SB089sFjOEME6Fh5T+gOvovkG1jliYZL55I/FElOJ7bgWa/MPSj7Ig==
X-Received: by 2002:a17:906:100b:b0:992:bc8:58e4 with SMTP id
 11-20020a170906100b00b009920bc858e4mr16978966ejm.20.1689086977604; 
 Tue, 11 Jul 2023 07:49:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 um26-20020a170906cf9a00b0098e17ea781csm1263296ejb.94.2023.07.11.07.49.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:49:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 2/4] tests/lcitool: Refresh generated files
Date: Tue, 11 Jul 2023 16:49:20 +0200
Message-Id: <20230711144922.67491-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711144922.67491-1-philmd@linaro.org>
References: <20230711144922.67491-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Refresh the generated files by running:

  $ make lcitool-refresh

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/docker/dockerfiles/debian-amd64.docker |  2 -
 tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
 tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
 tests/vm/generated/freebsd.json              | 77 ++++++++++++++++++++
 4 files changed, 77 insertions(+), 6 deletions(-)
 create mode 100644 tests/vm/generated/freebsd.json

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index e39871c7bb..8f7521fdc2 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -70,7 +70,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libpam0g-dev \
                       libpcre2-dev \
                       libpixman-1-dev \
-                      libpmem-dev \
                       libpng-dev \
                       libpulse-dev \
                       librbd-dev \
@@ -96,7 +95,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvdeplug-dev \
                       libvirglrenderer-dev \
                       libvte-2.91-dev \
-                      libxen-dev \
                       libzstd-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index 8f864d19e6..7f60143cbb 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -69,7 +69,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libpam0g-dev \
                       libpcre2-dev \
                       libpixman-1-dev \
-                      libpmem-dev \
                       libpng-dev \
                       libpulse-dev \
                       librbd-dev \
@@ -94,7 +93,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvdeplug-dev \
                       libvirglrenderer-dev \
                       libvte-2.91-dev \
-                      libxen-dev \
                       libzstd-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 1d442cdfe6..5162927016 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -70,7 +70,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libpam0g-dev \
                       libpcre2-dev \
                       libpixman-1-dev \
-                      libpmem-dev \
                       libpng-dev \
                       libpulse-dev \
                       librbd-dev \
@@ -96,7 +95,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libvdeplug-dev \
                       libvirglrenderer-dev \
                       libvte-2.91-dev \
-                      libxen-dev \
                       libzstd-dev \
                       llvm \
                       locales \
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
new file mode 100644
index 0000000000..7c435cf23e
--- /dev/null
+++ b/tests/vm/generated/freebsd.json
@@ -0,0 +1,77 @@
+{
+  "ccache": "/usr/local/bin/ccache",
+  "cpan_pkgs": [],
+  "cross_pkgs": [],
+  "make": "/usr/local/bin/gmake",
+  "ninja": "/usr/local/bin/ninja",
+  "packaging_command": "pkg",
+  "pip3": "/usr/local/bin/pip-3.8",
+  "pkgs": [
+    "alsa-lib",
+    "bash",
+    "bison",
+    "bzip2",
+    "ca_root_nss",
+    "capstone4",
+    "ccache",
+    "cmocka",
+    "ctags",
+    "curl",
+    "cyrus-sasl",
+    "dbus",
+    "diffutils",
+    "dtc",
+    "flex",
+    "fusefs-libs3",
+    "gettext",
+    "git",
+    "glib",
+    "gmake",
+    "gnutls",
+    "gsed",
+    "gtk3",
+    "json-c",
+    "libepoxy",
+    "libffi",
+    "libgcrypt",
+    "libjpeg-turbo",
+    "libnfs",
+    "libslirp",
+    "libspice-server",
+    "libssh",
+    "libtasn1",
+    "llvm",
+    "lzo2",
+    "meson",
+    "mtools",
+    "ncurses",
+    "nettle",
+    "ninja",
+    "opencv",
+    "pixman",
+    "pkgconf",
+    "png",
+    "py39-numpy",
+    "py39-pillow",
+    "py39-pip",
+    "py39-sphinx",
+    "py39-sphinx_rtd_theme",
+    "py39-yaml",
+    "python3",
+    "rpm2cpio",
+    "sdl2",
+    "sdl2_image",
+    "snappy",
+    "sndio",
+    "socat",
+    "spice-protocol",
+    "tesseract",
+    "usbredir",
+    "virglrenderer",
+    "vte3",
+    "xorriso",
+    "zstd"
+  ],
+  "pypi_pkgs": [],
+  "python": "/usr/local/bin/python3"
+}
-- 
2.38.1


