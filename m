Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE9974F2AA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEgc-0001HF-Jm; Tue, 11 Jul 2023 10:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgb-0001H7-5e
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgZ-0002og-FZ
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-993a37b79e2so733097666b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689086989; x=1691678989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2C3ulhpGXegeRpApeYEbk/7DUySfSH+Hku3qJHK2GJw=;
 b=i6XEWJ65wcJd9ZSZQpN7XjgapelcMRwQaGuqQw12NcxWXiLWX53oReXCxb115XYy9i
 o0aQ8pApGP/33HrryPU5ySGhq7DUTFHNIn9lOT6rCMh6Mkvhox0+y4coWZ2BwxzON+WF
 +Qn8ZyXYhx9s0oS64ACFGuX13lQxnR4Av+3qHuc4FqQYlrhBDU47n783gtYHpFqBHpmR
 ij6vy97y4n3Z4OEzrsHoedEvaEzj8qVehq3mKWdWereUTSIB1nAQ0g4AChIoQQh8kPVu
 VTjfmtC0PqTMRmuEHcQbd1paDB34titoVzWi/pZ79wRLMV1nxYcn6xu8oa8jTygYWgSi
 78Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689086989; x=1691678989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2C3ulhpGXegeRpApeYEbk/7DUySfSH+Hku3qJHK2GJw=;
 b=T2lmDR6v2s0Oudxd+fD0wX+UVg6Z3/+OofWf+WfcgUVe/YCSvdQtQkYHbffS4zTsEs
 IxgGQML+lOcmr084YwOFhzIvjiqc8oYK5lmjTpPpl/ZPfC+tTW6MZezCYKGCZcmm+/9T
 QHXmKe/a6U2FVj/VC2CfdtjsSE+lrt7z5Xrd/JcXUsikDkOqPCRIg5MIAc1lND3KOPmH
 TcI6icAbaVegDFjS3wMHyt2mqJ1Riaqw9OcJxQ3Z/vluMUBN+obqcS8zw52JZ7fOFxLt
 BIpxzFz6r54gyzwsngpCf48bFQh1nkRC4hCO2S/vHcI06tknOch/4gssVtvMzs/KzEMI
 p3UQ==
X-Gm-Message-State: ABy/qLYbYkegeRM3xVCvNGhZqFs/bAJbtlccmSzXUDcKoeaZY85ni20J
 whiE5kLA7aAaocQsTdbaUvgQX7rfMddz/J4+nvQ=
X-Google-Smtp-Source: APBJJlGulHDT3ZD1C3U0lhg+2BhP89SMya1kYw1QfIlvga6JP2ncATkfhFHrIeN4VGDiWpanizBgHg==
X-Received: by 2002:a17:907:908e:b0:96f:e5af:ac5f with SMTP id
 ge14-20020a170907908e00b0096fe5afac5fmr15865334ejb.47.1689086989778; 
 Tue, 11 Jul 2023 07:49:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 qt25-20020a170906ecf900b00992ab0262c9sm1258292ejb.147.2023.07.11.07.49.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:49:49 -0700 (PDT)
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
Subject: [PATCH v3 4/4] tests/vm/freebsd: Get up-to-date package list from
 lcitool vars file
Date: Tue, 11 Jul 2023 16:49:22 +0200
Message-Id: <20230711144922.67491-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711144922.67491-1-philmd@linaro.org>
References: <20230711144922.67491-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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
 tests/vm/freebsd | 42 ++----------------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

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


