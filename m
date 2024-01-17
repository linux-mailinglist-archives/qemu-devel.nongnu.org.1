Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 928808307B2
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:14:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6fN-0005id-CI; Wed, 17 Jan 2024 09:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6fK-0005bd-MV; Wed, 17 Jan 2024 09:13:15 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6fJ-0002pK-4U; Wed, 17 Jan 2024 09:13:14 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6daf9d5f111so8980885b3a.0; 
 Wed, 17 Jan 2024 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500791; x=1706105591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YutzPG8zZ0lU+po8EJCck+iZJ2Ot/PSkmFSXXLP8+Zw=;
 b=Zg8h6IuN+bqAecHdti52o8jS/0dpH5cHKTQmqCZhiksOS8Dtwia7GTMjXBHyi2du3f
 +Jf1hYsvTUA0zX3cCYJ0YHQogWKHRqw1PHcKOo+EUj0uPNHkrs1GxiZxFs/3GVHw3H8/
 U5Fg4HqUWrzaRgXNIVUlagW2xnky1En7z6R6JyAsFmGDw77rL4eM2IbFhpO0WVgJ+opC
 jLvIM/tJ+GD9MkcLRqwcybwkNTXOd5OYXblP023hmaQPpVZJaGDF4axSdK6H0PAY51BT
 GAM6q1+NUHWozBxo36RUp8EwJK/eElWJSTZDkm87CkQCynfpjAMkAJFPkn4r+ZgFClmg
 jiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500791; x=1706105591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YutzPG8zZ0lU+po8EJCck+iZJ2Ot/PSkmFSXXLP8+Zw=;
 b=devY6d8Z3gtcPmLu9lBeX1GwBnSfnMXdwV/NbmduKmqqMT/YIPBacbj+BmugEbm8rP
 F6/qs/8MVlCNVfrKiNCHitIifDKOFkmEjzb9r3ChpufQHxsbWo5vXCXXpcuqopHs6vcf
 TTfcz6BTrwkZxGcRT1CVrW/AAC5gx0kOuRhF7IPZAluZGrPJCGyLFtzRZo3Cmtdf6WEb
 GsCipmaxyisoZpfDwWEwn11jK4FNgiCqIdqrh4VNe2rYGZH4W6pGz6MkQcT8bYjIrNr7
 4vZ5zJ81t6TC8xg/7DvKEs/qZhcYlmC0vwEU4zn//zUmO7rsOsnc7ang8QJf6LVZbDe9
 QGKw==
X-Gm-Message-State: AOJu0YyOA3CTk13iB8qoZnHLu9jdBUM59rS9tWwev+IQide2g7TNUq4j
 krUyZ22Fg2pjigCQCJul2vad0K/f/0o=
X-Google-Smtp-Source: AGHT+IGBW/6Kn/G5y0+9KHW9PonH5+xAh8KAEDhuU6Td9GCdzhmvS2c8MvyRaTAEk5IxQw2fr+p9Dg==
X-Received: by 2002:a05:6a20:94cc:b0:19a:e0cc:7e25 with SMTP id
 ht12-20020a056a2094cc00b0019ae0cc7e25mr6591916pzb.0.1705500790742; 
 Wed, 17 Jan 2024 06:13:10 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 i136-20020a636d8e000000b005cebb10e28fsm11812428pgc.69.2024.01.17.06.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:13:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 6/8] tests/avocado: Add pseries KVM boot_linux test
Date: Thu, 18 Jan 2024 00:12:21 +1000
Message-ID: <20240117141224.90462-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117141224.90462-1-npiggin@gmail.com>
References: <20240117141224.90462-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

ppc has no avocado tests for the KVM backend. Add a KVM boot_linux.py
test for pseries.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index 7c9cf6ae15..4c9b15ba06 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -102,6 +102,14 @@ def test_pseries_tcg(self):
         self.vm.add_args("-accel", "tcg")
         self.launch_and_wait(set_up_ssh_connection=False)
 
+    def test_pseries_kvm(self):
+        """
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.vm.add_args("-accel", "kvm")
+        self.launch_and_wait(set_up_ssh_connection=False)
 
 class BootLinuxS390X(LinuxTest):
     """
-- 
2.42.0


