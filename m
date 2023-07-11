Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D674F103
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJDwV-000350-Mx; Tue, 11 Jul 2023 10:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJDwP-00033M-2B
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:02:09 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJDwM-00085b-6s
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:02:08 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9928abc11deso723664866b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689084124; x=1691676124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/go/SNx7o3UmNqsJvS9SSRzBMvZWAoewv5X6oINpyQ=;
 b=QNs9+fRrs4QwmB1sBBcm+T+TXTATax+LNfmXcF08vexYlZgrNJdOM6iTkLpZiYSr7z
 dFN8p19jhw4lNLs782AjLyjHIOBlDdPb49qRT5WAAKG7SOHD4fu9tQvvgD1+tW1invjS
 VKm73NyAr78ol5IyvAQo24sNGd+07vpsjF9L23kzG0DMZ9k/rA/CYMiHiXkAeU4d08eI
 tHNhNr2SbNOs397ZmYVzViYmpL+QtA8ZgR5dI4qEsREVTL2Oasr3hcSeijsjNHuAjFim
 EgQCgrabxC0QBYvQRZ9/MwVXn5Xu2fZeJ3xYxHoY99A9Dox63y819Ndgi352Sg73v/K8
 7muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689084124; x=1691676124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/go/SNx7o3UmNqsJvS9SSRzBMvZWAoewv5X6oINpyQ=;
 b=QfULxA97tfDEy5nJ3cm8Tlcy+VobaQNqZ9oUq7+NDj+70bqrIFMlMPqH7VlrNmDu1j
 Jy9aPR1qCOINPVkdEZ8cDYPnL2avdzBfxwVuw2eaD5kucZsGlkn6g23EL881qULPgosk
 l7TxW0nCp3OVOSB8BYG4WKHUSTSs/DU7yD0z8PXpn7dqM9nhDRIDxok6DF1prUR+mHva
 4ALBzO27S581hxVkZvxMZbDW4qECayeYyJN+V7U+LAtIU6xe+P5VACN2r0ClQEMwLwaE
 Dftknny+zpYSkqEfl7gtZCAaA/edJ7JoHp3IZqW3fvoPt0fOgXpQE0DppWCnNmWcDTb4
 9kyw==
X-Gm-Message-State: ABy/qLYG8sIuHcVTStXO7XS5ZKaNaiJ1WbTi1c8m3HsInPVTAL7ZOY9C
 KJ3COufo7WZ2xmm9l1lE2nC9YsapSg1pKZf9lCo=
X-Google-Smtp-Source: APBJJlEYZ/P475wyHHz0B1fhO0sPOVesS+1XBTnvWCr8dUAwlsOKCfUyVH0ZZlm/uXbmAqQqXF0/FQ==
X-Received: by 2002:a17:906:6c87:b0:957:2e48:5657 with SMTP id
 s7-20020a1709066c8700b009572e485657mr14525061ejr.68.1689084124562; 
 Tue, 11 Jul 2023 07:02:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a17090638cb00b00992f309cfe8sm1211839ejd.178.2023.07.11.07.02.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:02:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
Subject: [PATCH v2 3/3] tests/vm/freebsd: Get up-to-date package list from
 lcitool vars file
Date: Tue, 11 Jul 2023 16:01:43 +0200
Message-Id: <20230711140143.65818-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711140143.65818-1-philmd@linaro.org>
References: <20230711140143.65818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Get an up-to-date package list from lcitool, that way we
don't need to manually keep this array in sync.

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/vm/Makefile.include |  2 ++
 tests/vm/freebsd          | 42 ++-------------------------------------
 2 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index b021b344b5..84b8ad5222 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -110,6 +110,8 @@ $(SRC_PATH)/tests/vm/%.json:
 	$(call quiet-command, \
 		make lcitool-refresh)
 
+vm-build-freebsd: $(SRC_PATH)/tests/vm/freebsd.json
+
 # Build in VM $(IMAGE)
 vm-build-%: $(IMAGES_DIR)/%.img $(VM_VENV)
 	$(call quiet-command, \
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 11de6473f4..ac51376c82 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -31,45 +31,6 @@ class FreeBSDVM(basevm.BaseVM):
     link = "https://download.freebsd.org/releases/CI-IMAGES/13.2-RELEASE/amd64/Latest/FreeBSD-13.2-RELEASE-amd64-BASIC-CI.raw.xz"
     csum = "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
     size = "20G"
-    pkgs = [
-        # build tools
-        "git",
-        "pkgconf",
-        "bzip2",
-        "python39",
-        "ninja",
-
-        # gnu tools
-        "bash",
-        "gmake",
-        "gsed",
-        "gettext",
-
-        # libs: crypto
-        "gnutls",
-
-        # libs: images
-        "jpeg-turbo",
-        "png",
-
-        # libs: ui
-        "sdl2",
-        "gtk3",
-        "libxkbcommon",
-
-        # libs: opengl
-        "libepoxy",
-        "mesa-libs",
-
-        # libs: migration
-        "zstd",
-
-        # libs: networking
-        "libslirp",
-
-        # libs: sndio
-        "sndio",
-    ]
 
     BUILD_SCRIPT = """
         set -e;
@@ -151,8 +112,9 @@ class FreeBSDVM(basevm.BaseVM):
         self.console_wait(prompt)
         self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\n")
 
+        pkgs = self.get_qemu_packages_from_lcitool_json()
         self.print_step("Installing packages")
-        self.ssh_root_check("pkg install -y %s\n" % " ".join(self.pkgs))
+        self.ssh_root_check("pkg install -y %s\n" % " ".join(pkgs))
 
         # shutdown
         self.ssh_root(self.poweroff)
-- 
2.38.1


