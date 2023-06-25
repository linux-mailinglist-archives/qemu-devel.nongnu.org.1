Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C273D020
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDN7R-0001h3-Ro; Sun, 25 Jun 2023 06:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDN7N-0001gE-3q; Sun, 25 Jun 2023 06:37:17 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDN7K-0001h1-4B; Sun, 25 Jun 2023 06:37:16 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so1874477a12.1; 
 Sun, 25 Jun 2023 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687689432; x=1690281432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uELgOsvAtyEd8+qLxIMv+G6IGAcaUjPYJT8jTwUhjM0=;
 b=G7bD1sQRgGxhOe30/C0VNbea1Mp9avtU6LFic5ZT5JXHwdGNdVQOUu+FIgBL07a8Q2
 iSqKTQSW4bOOfh/lbwg4cFArXSWv75Hb9WrrLLC62cYcELLfU5RCtfUk5FD8+KyZlnWc
 UvYB9DHn+j7Dob4UidWejTGW1FuShJyd+EQo6ZrhLEs9lQmpDtY4HDgBFofuA4p1IElr
 dOyqVMIYXz96uLC0hQR//FqDChKiHLXwtncOIuSuz4eoSmPbF1BPcc7zPaEutaOgJaZ+
 MnzbrMIw4Futk1Vux7OjVv9GBWJxgg/g+bSjIH9lp7Ptw8lS0YYc21HptJqSOds5S3jG
 pRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687689432; x=1690281432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uELgOsvAtyEd8+qLxIMv+G6IGAcaUjPYJT8jTwUhjM0=;
 b=bsPDu6EspPfYxrGy8rS5hr/A7NnhG945k5M7BDattUEjtS/hzIx3gWCwkz3mHRpIVw
 Xx7cfZT4g6p5mSyWw3m3OTvLL/yhGjhmEeLfW4wC8jrQ16IgE/2h1FmoKPzUMoppQLsZ
 tg7OllcMUmKtDl3cBTAZ+N8X1buW9tdxADZWTKw5ag82hr300B7TYZ/ceYR7By7ZxuL9
 GGx8nYotG0w3/UTMB5dU5Mg1jM1QBMk3NyBXLFNaWoVciCRtnYScJu9yhOrnG34pYlSJ
 9iJA6oOIjNkapqj1PtN20o/Of20wFH17fRHCJFe72pBbJ/Xt+zk8ryWCvXJfEb/AoMTs
 D0RA==
X-Gm-Message-State: AC+VfDzaBggo8cbk3TWwMNZFplVXx1X/8R1FXSRRMMxfHoYyNNa0fuka
 JrCqgj+6d7BtsnwkO9KNcbvtSb5L/mg=
X-Google-Smtp-Source: ACHHUZ7HO0rJmhS7qg7MFdvKrsQG29nVjsJCwO81opOS2AkBKCny8HKsuVFYE7hxPb/6vEmfHTxP4g==
X-Received: by 2002:a17:90b:3611:b0:25e:91ef:8b1f with SMTP id
 ml17-20020a17090b361100b0025e91ef8b1fmr24457855pjb.3.1687689431754; 
 Sun, 25 Jun 2023 03:37:11 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 n91-20020a17090a5ae400b002471deb13fcsm2299115pji.6.2023.06.25.03.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 03:37:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 2/2] tests/avocado: record_replay test for ppc powernv machine
Date: Sun, 25 Jun 2023 20:37:00 +1000
Message-Id: <20230625103700.8992-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625103700.8992-1-npiggin@gmail.com>
References: <20230625103700.8992-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The powernv machine can boot Linux to VFS mount with icount enabled.
Add a test case for it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_kernel.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index a4dc8c0d6c..dc350fd781 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -258,6 +258,22 @@ def test_ppc64_pseries(self):
         console_pattern = 'VFS: Cannot open root device'
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
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=tty0 console=hvc0'
+        console_pattern = 'VFS: Cannot open root device'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
     def test_m68k_q800(self):
         """
         :avocado: tags=arch:m68k
-- 
2.40.1


