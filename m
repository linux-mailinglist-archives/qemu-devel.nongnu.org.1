Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D1E718AD5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:10:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4S8T-0005Zd-DX; Wed, 31 May 2023 16:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S8R-0005ZO-Tc
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:09:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S8Q-0006rI-03
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:09:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f606a80d34so787435e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685563768; x=1688155768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuHFSUSInpdpLv4yrlAqMcIZx0noGMOR/r58BhLDlnk=;
 b=kHEmulJz7zguJPIb0tfqgna6W5xTT9unwp6HuqxHDUxC+w50keNoljGK2uVjB10YMV
 7LGydJo6azlGAZ+bO+9B99w1ouIWY7EO0mSFSCCPHSPYr5FbD4c2m0n3W70HMACi9Coz
 5P3IgTM2a/IHn0LXbz/6Ekj8RULPv/onoPuNuSA+udOg6CVhikZ5hkMzSHBtXdPF5uAD
 caPp5pTvgIrqESancQjhAIXbx3bb7muaTaF9aizJsRfa18JDZhF9ygtjopmFOJgeOcw/
 m00OxxxzRxZ2jdXLJfGZfCkLJammY4G4mrR4TJ7ScOYzBQQG5xh949TSjB6KV5i51pwp
 o7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685563768; x=1688155768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuHFSUSInpdpLv4yrlAqMcIZx0noGMOR/r58BhLDlnk=;
 b=hmqaGQ7USyymkueeKayfvJsRFSq/Yk56nwj7giRT4RscTm8jZ2VkfLGE7YnKZhJlqy
 /6RhgDTJ96WddQLpuBUx1W66uAV+ZlywCJNjTruA60NH2v2Eho8AIxIlS41kOnr9ZnXk
 boRhGjKAHoQtuOklu9q4UC3xQlyOkxvwKycasBMz1ksxtfAHM9edEe2pS7XPD8aaOxfX
 t1vdI7eZ20jBvSeyPzz4S6fDkAeny+JVpe8iJrtkVtjQpHRRLsLSLN6XUEThtN0cyBlS
 2i+YIEGxgj+qC33/4vkbj7bnaEl/Bs7iROXnvN7vE7bRTDc2trO+wOHgJm5pOyCev/Kj
 2Icw==
X-Gm-Message-State: AC+VfDw9AAAuoKGTAIVEsI+TkLRfa0N7krWxccx9yGUnoPJ/U5bN7WuY
 rtKe7UtrQ+OaRqOMwLkAQ1QqhQ==
X-Google-Smtp-Source: ACHHUZ4yu0KfBMhwhCYsX/7l3Z6J3Ae3ZwXxYNuQkQsnBT78y7Xtqm22Ig55kZUH8Pdr/Q0ZsMj4TQ==
X-Received: by 2002:a05:600c:28c:b0:3f6:148f:5867 with SMTP id
 12-20020a05600c028c00b003f6148f5867mr304334wmk.4.1685563768368; 
 Wed, 31 May 2023 13:09:28 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 u6-20020adfeb46000000b0030ae53550f5sm7736669wrn.51.2023.05.31.13.09.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:09:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>
Subject: [PATCH 3/3] tests/vm/freebsd: Get up-to-date package list from
 lcitool vars file
Date: Wed, 31 May 2023 22:09:06 +0200
Message-Id: <20230531200906.17790-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531200906.17790-1-philmd@linaro.org>
References: <20230531200906.17790-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

See previous commit for rationale on using lcitool vars file to
get an up-to-date package list. Since there is a such file generated
for FreeBSD 13 available in the repository, use it. That way we
don't need to manually keep this array in sync.

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/vm/freebsd | 44 ++++----------------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 6a0d7a4569..4f12878645 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -31,45 +31,7 @@ class FreeBSDVM(basevm.BaseVM):
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
+    lcitool_vars = ".gitlab-ci.d/cirrus/freebsd-13.vars"
 
     BUILD_SCRIPT = """
         set -e;
@@ -151,8 +113,10 @@ class FreeBSDVM(basevm.BaseVM):
         self.console_wait(prompt)
         self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\n")
 
+        vars_path = os.path.join(src_path, self.lcitool_vars)
+        pkgs = basevm.get_qemu_packages_from_lcitool_vars(vars_path)
         self.print_step("Installing packages")
-        self.ssh_root_check("pkg install -y %s\n" % " ".join(self.pkgs))
+        self.ssh_root_check("pkg install -y %s\n" % " ".join(pkgs))
 
         # shutdown
         self.ssh_root(self.poweroff)
-- 
2.38.1


