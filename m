Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB16A73B71B
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfoO-0005Z9-BH; Fri, 23 Jun 2023 08:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCfnZ-00040s-Av; Fri, 23 Jun 2023 08:21:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCfnX-0004YH-1s; Fri, 23 Jun 2023 08:21:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-666e6541c98so401746b3a.2; 
 Fri, 23 Jun 2023 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687522913; x=1690114913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3+DHoao4gFcoVl7axpVb1gNGax6mcgeLFhXC4dMUOUI=;
 b=kljtc0xjZ/aPUJFLq1EdUIMj0kllpIp+CFurH8rN7uGSas1r72cYsDJBOO6mHiNqvO
 skqKvzY5Rw7S4G8ySmzPhJYAJ0pS+xcPsYeQmW7m5BZYLhR4B4EFG+1Dz8rXhcBwVJ0I
 eF/xpNuRI4fx4KKrYHOtKQrx0GPHp6W8FsLraHgNMjgo1/zfqUB5I08KzVE7/nm26+Ah
 EloSOLgb+JjkwIYFn2pCLZN2K+yQWconR9HKExa8g1Nb0+CUYW+OzSjYZpMI3jwXeERP
 +X0Mb0S05PBcwFoTWqM5ZZAzj2Kf4dxPBqmOuCoXsB+LqcbQB51GsXnKU3U+9k7oyTA2
 g5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522913; x=1690114913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+DHoao4gFcoVl7axpVb1gNGax6mcgeLFhXC4dMUOUI=;
 b=FnikS6QfHUOT7YvVEWJ4CgRKLNK42vLIc/kkEjJMxxR2Lg0CsYn94WtkrO4oXYI88p
 hlnVHoOv47KTspM3YCQ8SDOdFdeb0oFG3ksbmUweTNSGEa0UugKyGHIq2lU4rDWiK/n7
 fGBiv+IzBYnmXHIfEFu1AqgDdLkKSIi7OXa2REaFikCrworxtQLchTPp8VjZtrYMU4VB
 7u6dI8fkdTj6/uNu60xuqxkfJw0L+UFttuXAJiMguCj2FagvhRNbf6/mTrqURsqZjRvD
 eEVwzt/aojHZPftA+SRq0QjeO2wXuC2uiLsHXwZ6QY9lVSGjBCHvnqM3P99wTO4yiUwX
 PBfQ==
X-Gm-Message-State: AC+VfDxddkHVvQMw7JNqZLTOKRLU4Uo3yiCWbcBbKHkk3j5/+T7yrP4A
 Urn/UZfirM/n3Mo0LyqR5MNLNE5qa8M=
X-Google-Smtp-Source: ACHHUZ44ma9f0MTPbsYY3PjG/BrQ3Y/NFDCTUxDmW4sOz6aNXMhUvl0AS5HOGhNdUqNQyB8mpP8jOg==
X-Received: by 2002:a05:6a00:2384:b0:667:e17e:85b7 with SMTP id
 f4-20020a056a00238400b00667e17e85b7mr22164854pfc.1.1687522912638; 
 Fri, 23 Jun 2023 05:21:52 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 x19-20020a62fb13000000b006328ee1e56csm6015370pfm.2.2023.06.23.05.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH] tests/avocado: ppc test VOF bios Linux boot
Date: Fri, 23 Jun 2023 22:21:35 +1000
Message-Id: <20230623122135.320261-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

VOF is the new lightweight fast pseries bios. Add a Linux boot test
using VOF.

More tests could be moved to use VOF becasue it's much faster, but
just dip one toe in the water first here. SLOF should continue to be
tested too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

This applies on top of the SMP/SMT avocado test I sent. Just
thought it would be a nice addition.

Thanks,
Nick

 tests/avocado/ppc_pseries.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
index ff42c770f2..a8311e6555 100644
--- a/tests/avocado/ppc_pseries.py
+++ b/tests/avocado/ppc_pseries.py
@@ -29,6 +29,17 @@ def do_test_ppc64_linux_boot(self):
                          '-append', kernel_command_line)
         self.vm.launch()
 
+    def test_ppc64_vof_linux_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+
+        self.vm.add_args('-machine', 'x-vof=on')
+        self.do_test_ppc64_linux_boot()
+        console_pattern = 'VFS: Cannot open root device'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+
     def test_ppc64_linux_boot(self):
         """
         :avocado: tags=arch:ppc64
-- 
2.40.1


