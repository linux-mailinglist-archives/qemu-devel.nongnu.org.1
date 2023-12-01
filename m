Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B139800741
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:39:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8zwy-0003po-D1; Fri, 01 Dec 2023 04:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwv-0003nl-L5
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwq-00044p-Om
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:41 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso17081005e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423395; x=1702028195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBPmW4w4M+av4eb0WryP3C6eoVDII09MJF71sUkUxZM=;
 b=iu6IKfpjF/zw3hnKI3Ahxe56B25p9mwBLSzmTpsw9b/YomLdxg8tV/Tl8itNGs8fxj
 rDlMWJjxI0/7GZDGMo1tf3iFWPDPe2e535Kjbi4V0xav6bCgM5LEtU5xwSBtQ2ian+5G
 TiJCvLjVrvXEB/ozDju9OyhETv5q/aB08rVSdjS5kJPhdgxYrSN3Wk4ZWkJ68xj+I0Cl
 7wxltHSm7rwu2/ySU1hBy/6mkzNkSuUuCVUndA5lB9YZCJieqesMCjZnH/1RtH7xc5+o
 uOkMfMoBKZ2Kx1bRGZU0RxgnZVda6VnO6nyE0FRcPWrzoMv3RytiE/J0NFPZj76KldJJ
 QnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423395; x=1702028195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBPmW4w4M+av4eb0WryP3C6eoVDII09MJF71sUkUxZM=;
 b=LBc+6+TPW0+XWFc5WfaCOD3R0BZ6lLF2ktUQqIMPoze36SYdn8H6XxIsG5RfZOxxwI
 j9/7SifwP0g6wztqxOAOCjYK5MyiWz5UCbjLjB2z7TBfhDEx2zvYs8cDKAk3708D7xZr
 OIFIGH6W6Vzs1gibmbcnHiCvQJFobBlKekpsbryKtlA6EONJDErPUShOF9dCy9jBUD5z
 VT3xag4hi3fu9oYm15ncpQ604B7p0DW2sMBllOwV8zqpG+AQ3Us9pegSYbKiLznHSGwh
 FJcLtbxKHct2cA6PjsAGl1YWTpNz7LcyCrl7EwO+kPPn6Sy0sFDZLHLLYX8ZesG5VEre
 TOqQ==
X-Gm-Message-State: AOJu0YxlJqblxuzSb+k9F7UUO0j7nfhlFSIKkHfDqaLBhC2i4eshUNVq
 Ku759HZS9tun09RLWoZ2mfZXBQ==
X-Google-Smtp-Source: AGHT+IGikc8WThGgoGRtDezXyAeY3e08eBimnDC+T8Jzl2oQiXxkf9PCgVjqYub0Dwf+ZBgL2C4kTw==
X-Received: by 2002:a05:600c:3143:b0:40b:2a69:6c37 with SMTP id
 h3-20020a05600c314300b0040b2a696c37mr395607wmo.4.1701423395100; 
 Fri, 01 Dec 2023 01:36:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c155100b004083729fc14sm8491006wmg.20.2023.12.01.01.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 01:36:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D5945FB65;
 Fri,  1 Dec 2023 09:36:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 3/7] tests/avocado: drop
 BootLinuxConsole.test_mips_malta_cpio test
Date: Fri,  1 Dec 2023 09:36:29 +0000
Message-Id: <20231201093633.2551497-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201093633.2551497-1-alex.bennee@linaro.org>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 231b4f68e5..5d978f6dd0 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -116,28 +116,6 @@ def test_x86_64_pc(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_mips_malta(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20130217T032700Z/pool/main/l/linux-2.6/'
-                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
-        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
-
-        self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
-- 
2.39.2


