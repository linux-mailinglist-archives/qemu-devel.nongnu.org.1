Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E337E4A1A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:50:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Szr-0006Y9-LD; Tue, 07 Nov 2023 15:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szp-0006WV-I1; Tue, 07 Nov 2023 15:48:25 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szh-0006Rj-W3; Tue, 07 Nov 2023 15:48:25 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41cd6e1d4fbso36741641cf.1; 
 Tue, 07 Nov 2023 12:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699390096; x=1699994896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgDohQL10Kwza6gfUqiIwJVSkAbDVuDSCsqLlsvi+uQ=;
 b=Laf8ybW4nM1geZiXavmhuo8xknxIKuBquvwyiPr5903RGUitZoZKIuoF5MW1iqoFAE
 jkeQgrIqOQAyWjkdbNcg/9qx0jMdHEigQKHDD7AfbyFNdYSdbyD3nulThkjAmylPygO8
 3t/2BSInPi572XiXVYDxveThN4w4Auc0Sht0uqxeBIh/IlyLUfu4v7BpQEL/SGgNPDML
 5uzfkZtzKOaETh0qGH/sL0iP1WCfNB+2X1/mJIizDWkR3v0eMkhQ8HmOCiQ0AT26YDIE
 LwXT/ZTgyWTT//5QYKKZcfPabQsmGPsVeomn4XQ/+zZqe2kWcEWRYGdWHP9SLG9TExEi
 YKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390096; x=1699994896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgDohQL10Kwza6gfUqiIwJVSkAbDVuDSCsqLlsvi+uQ=;
 b=aZhGMqMNWhmBCE61D4Wda3A5ws+im0BxnZn1XXvaDUjxGqLKugNEL4N1LG0+kgELfz
 Z8HPJqFwuMEcw5uqHFKMJ9+KRzf4XIx5JnsdDmB1oPrig8IG/vloZKq3N8GzZF/rylxI
 fvUb2aCXYPGq9gf6uriSOLVMLRRyJNBYytKm0xwNztGoIsz/2dOOIVBMagoLZmYwa/Cd
 Q4NHK3Q/2ksF4dRIUQe16f54N+R6YtxhE4Jny8lmOEtfaFIxz9GgK2pOrMBnki8MAXfE
 i8KbUlcX6GWlhpZ3sJ/S856GQEzQbWgfc/JLCsMbdGSJtR6hVCa2nRbZrahDIov+UWvu
 umhw==
X-Gm-Message-State: AOJu0Yyis3kcHtJuXZFRpPswfttUyJgTTf7XG5CtGP38+lRIj9+/gbYN
 vezKv5FL2ZmCKHV3xnfbZCYGwBGPEG8=
X-Google-Smtp-Source: AGHT+IGfiGWFzLEMkneXrgfjmMI/yYIEHjo9jcyTEuqN0yjTretId1oZyftAyN8lyN9gJKLmo8yGTA==
X-Received: by 2002:a05:622a:1648:b0:418:af4c:1850 with SMTP id
 y8-20020a05622a164800b00418af4c1850mr35080289qtj.56.1699390096640; 
 Tue, 07 Nov 2023 12:48:16 -0800 (PST)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b0041eb13a8195sm48946qtq.61.2023.11.07.12.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:48:16 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 3/9] tests/avocado: Add test for amigaone board
Date: Tue,  7 Nov 2023 17:48:00 -0300
Message-ID: <20231107204806.8507-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107204806.8507-1-danielhb413@gmail.com>
References: <20231107204806.8507-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add an avocado test for the amigaone board that tests it with the
firmware.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <b1a0246840fcff1fe6bbd8685e2474a9231b34c5.1698406922.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/avocado/ppc_amiga.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 tests/avocado/ppc_amiga.py

diff --git a/tests/avocado/ppc_amiga.py b/tests/avocado/ppc_amiga.py
new file mode 100644
index 0000000000..b6f866f91d
--- /dev/null
+++ b/tests/avocado/ppc_amiga.py
@@ -0,0 +1,38 @@
+# Test AmigaNG boards
+#
+# Copyright (c) 2023 BALATON Zoltan
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado.utils import archive
+from avocado.utils import process
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern
+
+class AmigaOneMachine(QemuSystemTest):
+
+    timeout = 90
+
+    def test_ppc_amigaone(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:amigaone
+        :avocado: tags=device:articia
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
+        tar_url = ('https://www.hyperion-entertainment.com/index.php/'
+                   'downloads?view=download&format=raw&file=25')
+        tar_hash = 'c52e59bc73e31d8bcc3cc2106778f7ac84f6c755'
+        zip_file = self.fetch_asset(tar_name, locations=tar_url,
+                                    asset_hash=tar_hash)
+        archive.extract(zip_file, self.workdir)
+        cmd = f"tail -c 524288 {self.workdir}/floppy_edition/updater.image >{self.workdir}/u-boot-amigaone.bin"
+        process.run(cmd, shell=True)
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.workdir + '/u-boot-amigaone.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'FLASH:')
-- 
2.41.0


