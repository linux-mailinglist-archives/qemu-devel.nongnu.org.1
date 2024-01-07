Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB382653B
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWY0-00026V-JX; Sun, 07 Jan 2024 12:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXx-0001te-RQ; Sun, 07 Jan 2024 12:02:50 -0500
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXw-0007bQ-CG; Sun, 07 Jan 2024 12:02:49 -0500
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7bc32b04dc9so50398639f.2; 
 Sun, 07 Jan 2024 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646966; x=1705251766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAKkyryfCUAfxunLLdX5d5FTICFxv2rzMH9pkmW1uJ0=;
 b=eSpf1800Kfcp8t60JQqbTQxPweB1U3XC3+csh2JIeN2dMbTZ4Au1YqKPW8joR0lb8O
 QWga9yda/M2D3nEH1Qy0OzcyuhMOLxE2bCol8LAEN6pbvjIAtul0dHc9Mt+SxpYGUkET
 KXqmelHCCtDWfrlaOQgskvPaG98DQhjQ5Ko55mAZxGbDMxq111koRHCkIhTKHwhaO8yG
 SEsqRWMOseB3GAlOTheM6lxQB06XLsd+gfsMPKvjBYVkM1eSImIBKp8YKU8ZSDJXFv9N
 P5UphTPzixXB30OrRcZQ9elOQhGR3tHELZsH4dvJdlUzX+4eRDbWUGWIxvZZHa81MVRq
 2lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646966; x=1705251766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAKkyryfCUAfxunLLdX5d5FTICFxv2rzMH9pkmW1uJ0=;
 b=HnvhUGeU0Hwdcc7Ph9y4/Y8Vang979sG2Sdqe1QFOicJUAeAAn7VbFlRVBCIUJSo7I
 mu4fx6FHxqL7TRDvkWddw+n+PUhztD3zgUhebHGJhd5w+jmPawgNE1EOU00TveS7qByb
 HM2iMStD1vHVeVZX/p88licXPSq+G7jjNs+uuC8ViqN54Nxk6Yx1MQIaorMvvNmj+Z9q
 hP1Enqwp2sVeNIP4EGr5k7nvLo0XJFc4dDWrYoxHN08ES1V4GkpgP2b1oxRB2ZLUt+BF
 XuJdhvcMJysoGehG8uqP/o0c2sHrfCcZPoMinmiGPo5/JvGF6ixiclnzPET2lGLP3uAw
 fpxQ==
X-Gm-Message-State: AOJu0Yzb9dJEmmNBXUV7jeXZLX09DkuVpA0o8+OPeNTMuHZXd9fNAL+F
 e858yefHv5JZzk8EMdnlP3pXigisYSA=
X-Google-Smtp-Source: AGHT+IH5lKJg61zBBpzag+BI2AJKoCsgjAzcC+wmL+9yaeK/NJ255eL/PROyi+IrEUMcO4fhlS/hCQ==
X-Received: by 2002:a05:6e02:1c45:b0:35f:d8fd:8ecc with SMTP id
 d5-20020a056e021c4500b0035fd8fd8eccmr4706666ilg.0.1704646966091; 
 Sun, 07 Jan 2024 09:02:46 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:02:42 -0800 (PST)
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
Subject: [PATCH 7/9] tests/avocado: Add pseries KVM boot_linux test
Date: Mon,  8 Jan 2024 03:01:17 +1000
Message-ID: <20240107170119.82222-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd2f.google.com
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
index a4a78122ac..b20b2fc620 100644
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


