Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A85274AFDB
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgs-00025d-HJ; Fri, 07 Jul 2023 07:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgq-00024n-Ep; Fri, 07 Jul 2023 07:31:56 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgn-0006Z4-FJ; Fri, 07 Jul 2023 07:31:56 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b7484cbc5dso1741313a34.1; 
 Fri, 07 Jul 2023 04:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729508; x=1691321508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1St5pdmkMLUqW1JqQazoj2YyEkLRSI9cJCfT0l7pHQ=;
 b=KXS61NiAVCduJpgI9TqDsIQp1zk7KzgtoP0V2XEBgIffpOxHf5+R96ZzCagV8ciC7K
 X+R9oPTAh+qljqJdaA3un/LbwY5K+DxCudNyJ1NUSn9V0/jHljx4iAhuWwQaZpIEHy3M
 4Wq1NiSP12hnHIRX86CfSuRW9mhCs3osZBWRTs/7om9Ty/OMRJ6k7xBCaIL610uWNJqo
 pbet1QHsc3Ol9aXwtgMkvS/sUdWdfWU6FNs2QM6M9f5FnHtwETRdOBOX5BGBsU1QdC97
 fgH8Z88tY0VZmD801ktYXRAnNI6BpTh/TBqN65cPa6QrrL9wxxWlpRhP1NN5hQFgPK8K
 +Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729508; x=1691321508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1St5pdmkMLUqW1JqQazoj2YyEkLRSI9cJCfT0l7pHQ=;
 b=Agl7tL+g/8vRlf0hB+WumTzQS633EyBo5KGIAVMzlrXS7jRihyR3q4ijKZ7NcAUHK2
 QnhMv9n25HLwWwUajq9AgHc3V2BcVPKP7AVSdS4sPqXDwJ5uZR5+JUuUTs2GHIJQnzBl
 yKfaqHzNpRZQ6VVD9sqJ6/7io7r2fQ4Upk4UdPl0F6tCEojzo6VvGqrWrzGg9hvN8kH3
 nTZG3h0T/afopxcivnhQfDTEJijcXWLYIWkhljKNc11LKd4AbskczPasD4u3eWG8pUGS
 e92PPv9mSb3CXB1IgTixmRis6UiC5aVy5MPC/RETm58zqj/jnKdOSKqkagjhPO0IlnHE
 yTGw==
X-Gm-Message-State: ABy/qLYQzeWawNjr1E1DE5epcI4f4mE0bOLvR+qaKy58FYHbQZ/DcGW5
 6OPLFG1cmfxHAxkwaV7kKPNTFsw+Acw=
X-Google-Smtp-Source: APBJJlGEwLCVTjQyOYwFXHfYd8FayGoVD9uN86XK4ZdQ9WU1zDVcaCxZVFdKGqqAZufZSWNFi56XOw==
X-Received: by 2002:a05:6830:6206:b0:6b4:7239:49f7 with SMTP id
 cd6-20020a056830620600b006b4723949f7mr4463908otb.13.1688729508370; 
 Fri, 07 Jul 2023 04:31:48 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:48 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 10/60] tests/avocado: record_replay test for ppc powernv machine
Date: Fri,  7 Jul 2023 08:30:18 -0300
Message-ID: <20230707113108.7145-11-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32f.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

The powernv machine can boot Linux to VFS mount with icount enabled.
Add a test case for it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230625103700.8992-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/avocado/replay_kernel.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index fe1e901f4b..79c607b0e7 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -259,6 +259,23 @@ def test_ppc64_pseries(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
 
+    def test_ppc64_powernv(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
+                      '/ppc/ppc64/vmlinuz')
+        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + \
+                              'console=tty0 console=hvc0'
+        console_pattern = 'VFS: Cannot open root device'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
     def test_m68k_q800(self):
         """
         :avocado: tags=arch:m68k
-- 
2.41.0


