Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC56800743
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:39:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8zwy-0003oh-5N; Fri, 01 Dec 2023 04:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwv-0003ny-OP
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:41 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zws-00045V-Hp
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:41 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c9caf896b7so21122191fa.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 01:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423397; x=1702028197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7oEpLW+aG0VhOA+9+YE1AjdRXhZYR6BB1KY1d7oEhc=;
 b=DBDbYknsL+vwpJywwk3OlLMLnQdZdsVNniKpXpG+WLvikZuxY9q99AkMRa8Lp0omwi
 cBmt8fyFLmTVorTHLykSUPS6OYxsgktX4F5YcAxkI8LXpY03hJbtMYacwQCPS1ml5Ok9
 Mewy1rNlGh7n0SF/W0FgmemRysbHCpq2jKDm5JXoOTxE2+ANImWqCMg6O87qPce2bXZY
 Jo0D8B7MhF7kxquYwXv7/sG3vtzQT39qGzYX00VWqHN7Q2wByl24defH7xbmG8Aat0OM
 MN9DVGOWRHGliOa/8RRicugsF+c76xf0W1/q4toctI7zOFQSf0CgCokFKu6tdPR6qrly
 XN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423397; x=1702028197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7oEpLW+aG0VhOA+9+YE1AjdRXhZYR6BB1KY1d7oEhc=;
 b=d9+jOOLV0cd4GdOt1sTdqCUOB7IBQjCVN/dqGrgIy2IuOpZfD2kh1aeGOCkEG6Z2CA
 qLomrBZYFDPFQk2onU0zNsZ+DZ03OLuVUgvsfraMlqhVPYr3qqPxCTIaaJlmijtTAwfR
 4Sz95up6mut67wW5ajz7OgtdpFslYPJ769Ueh10rHR2pVWHXvJ5lALgXnadC4+SxeIoe
 0AZu62xe/jsUWJaJSsd9VfUsx/r7QGyl8H6187IOqnk+K+WwYl3xKCB+ZbuLN4sMFICD
 x8bpBl5a6vN2gkA36v/41am09EPeYs3DWa+6YEpadiXB5f27pc1pyKc0/iCfgwaUdHgz
 z8FQ==
X-Gm-Message-State: AOJu0Yz5IRw6Z9/pWfU6ka7INPUm+QmtMw/alOr6M27v5LDZV6K5N4bJ
 Xi/9L1touakZbFjZO4WfB0sIIw==
X-Google-Smtp-Source: AGHT+IGmvDR/pJA8jbWHRGbcxkFNd7Smazt/f7h5RwxfdgOFaPxyfnx/DRq6voi7kiNtGwgLgQQwjw==
X-Received: by 2002:a2e:700b:0:b0:2c9:bcb7:5e33 with SMTP id
 l11-20020a2e700b000000b002c9bcb75e33mr612086ljc.44.1701423396843; 
 Fri, 01 Dec 2023 01:36:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o9-20020a5d58c9000000b00332e1c46dddsm3662260wrf.98.2023.12.01.01.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 01:36:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 51E915FB67;
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] tests/avocado: drop malta yamon tests
Date: Fri,  1 Dec 2023 09:36:30 +0000
Message-Id: <20231201093633.2551497-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201093633.2551497-1-alex.bennee@linaro.org>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
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

The assets are no longer available on the website so these are
blocking CI.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/machine_mips_malta.py | 37 -----------------------------
 1 file changed, 37 deletions(-)

diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 959dcf5602..3a1ec85c20 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -122,40 +122,3 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         :avocado: tags=mips:smp
         """
         self.do_test_i6400_framebuffer_logo(8)
-
-class MaltaMachine(QemuSystemTest):
-
-    def do_test_yamon(self):
-        rom_url = ('http://www.imgtec.com/tools/mips-tools/downloads/'
-                   'yamon/yamon-bin-02.22.zip')
-        rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
-        zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
-
-        archive.extract(zip_path, self.workdir)
-        yamon_path = os.path.join(self.workdir, 'yamon-02.22.bin')
-
-        self.vm.set_console()
-        self.vm.add_args('-bios', yamon_path)
-        self.vm.launch()
-
-        prompt =  'YAMON>'
-        pattern = 'YAMON ROM Monitor'
-        interrupt_interactive_console_until_pattern(self, pattern, prompt)
-        wait_for_console_pattern(self, prompt)
-        self.vm.shutdown()
-
-    def test_mipsel_malta_yamon(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        """
-        self.do_test_yamon()
-
-    def test_mips64el_malta_yamon(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        """
-        self.do_test_yamon()
-- 
2.39.2


