Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 879D1800E2F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:14:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95CY-00050R-EC; Fri, 01 Dec 2023 10:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95Bz-0004qj-7n
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95Bv-0003so-GD
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40838915cecso21272695e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701443550; x=1702048350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxGGSJ63Zm4VVOM52878zzwTuRazNRD8JON/droSv9Q=;
 b=uIkYsq9y9CCiTgWBsobFrWlsdq0TfKDz3GMb+fj9hlG+Yfpu8mmcE9/TKhFWwCMVlD
 kyHQ70D+GrEHQe5VRr76SACk664AvQp9mSjwtZdhB/n01aO7s4nvirl+GRVupYcoHues
 ytaZjhdqlfNiZcYAHCSQawIUmWswvi7NVBGz4h4dBvdQSunnkUMr6KNGCO/fqozeZSQV
 1eeSb2JIq4oTfb+MfYbdL3Enz+Zwq5jcSaNk7qBTTggwZloLyHbJq2YpixmmVe6qrovX
 Xn3YS8zNOneX91I7y/285iQthW//rRqt9o4bOVG4GyjdIIFh6xlk68YfWUREsZarmehn
 XG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701443550; x=1702048350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxGGSJ63Zm4VVOM52878zzwTuRazNRD8JON/droSv9Q=;
 b=iXuZ5TqhgLdUkMuHTPwsMGKc10lt4S9VqrqNdkU1WPHyTZjxzjldPa3VivAy9Swsrf
 xDgMu0OjfVNB51GckdIdMZhAy1CTagJa5M89KH6VPL2Bon8vV0ks08Air02OrltikrRR
 PTjbqH+vpWIDyRFWWRi6xPoY8KVAR+bGgo4rXWSo4+bNXDQitE+ius1CVsYGR02RospH
 2lnKy4o9x3CtyaayBATmeYk8MAsZUdLYLM8uaCxbi5ekVgk7ooYaQoc/DYZn44LbWoB5
 0a+STEBsDWi9BoCgzCG7W5nBicE1a3ABz8QioBMgfOTx/SEHFJjdBgFFkaHKZQtKp+bu
 u1Vg==
X-Gm-Message-State: AOJu0YyLAYLR+bn+sqfZr3AMBTFQItMfDMOMYgeXvtg4+CbKA5vedxQ5
 7j9hExc3Wm6UMD8pHczl9B7qpA==
X-Google-Smtp-Source: AGHT+IEz+ed1qN3UiQ8+6xcESqLyfNeUWW8mMYrB+Z1SPk14j8FOh5qPy1RHOo1CeeOP4eY+RSwv2w==
X-Received: by 2002:a05:600c:4296:b0:40b:5e59:daa9 with SMTP id
 v22-20020a05600c429600b0040b5e59daa9mr453832wmc.188.1701443549806; 
 Fri, 01 Dec 2023 07:12:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t3-20020adfe443000000b00332fcdafc22sm4466794wrm.70.2023.12.01.07.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:12:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 33A5A5FB65;
 Fri,  1 Dec 2023 15:12:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 3/6] tests/avocado: drop BootLinuxConsole.test_mips_malta_cpio
 test
Date: Fri,  1 Dec 2023 15:12:25 +0000
Message-Id: <20231201151228.2610209-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201151228.2610209-1-alex.bennee@linaro.org>
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

The assets are no longer archived by Debian so we can't run this on
CI. While some people may still have the test in their cache we do
have more recent images from tuxrun so this isn't a great loss.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231201093633.2551497-4-alex.bennee@linaro.org>

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 231b4f68e5..ba2f99b53a 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -191,47 +191,6 @@ def test_mips64el_fuloong2e(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_mips_malta_cpio(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20160601T041800Z/pool/main/l/linux/'
-                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
-        deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
-                      'mips/rootfs.cpio.gz')
-        initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = self.workdir + "rootfs.cpio"
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
-                               + 'console=ttyS0 console=tty '
-                               + 'rdinit=/sbin/init noreboot')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'BogoMIPS')
-        exec_command_and_wait_for_pattern(self, 'uname -a',
-                                                'Debian')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_mips64el_malta_5KEc_cpio(self):
         """
-- 
2.39.2


