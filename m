Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A9F7BF4E6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7YI-0004eH-Kp; Tue, 10 Oct 2023 03:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Y8-0004dB-MX; Tue, 10 Oct 2023 03:53:04 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Y5-0005HA-5W; Tue, 10 Oct 2023 03:53:04 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-69fc829d7b1so2321962b3a.1; 
 Tue, 10 Oct 2023 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924379; x=1697529179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFyMnwFgzOm/mAvbUFxth7p6TWc0PhYI/tCOyvFn+Sc=;
 b=a3ESwaVW32mmYUz688o+kNMVF0LQNcin97ZQan53BptSWFse5XapTPcOW5bhOulyjB
 ET7+1E8AkYPioybPpaaISPeW78gTLCQGmbsHwTtpAJI1v/j0Lh+e1VbltpmvBo6+uwsm
 hjMjGQxMKf8rjH5BKdUu0+LuCMVFFBjAXSTOccN2oyrGm4/4GPdhsT7e1HAHWiqLHhmM
 +6V9tPQaY9v2MPYIh4wdujcrAx4otY/aGEquE4cSTYV9mBYjN+8hpwNIq5aoY5mwW9BG
 nw7Ict4tYh3sXMopj4A1ypMrI0hXcwk1edJuziD9GQ+psFftQNo8bIVQN9BDEKmwUUpy
 L3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924379; x=1697529179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rFyMnwFgzOm/mAvbUFxth7p6TWc0PhYI/tCOyvFn+Sc=;
 b=m+l4XJUFwl94K9HQvN8XxNMgBiJs+qLAqlAjhUum3OTwwUxMwk26AkRZTcWSp2LLN0
 xxUGQsE9ilQW8d85D5ZRqenV+ns+wDn82MyKA7vOI/IAy1cgPMgLIMZREfiaccUMVZiC
 CNkHeKDz7pVC/J/MdA38j2lc7gjgqri1pCYlUTVHS3ScAwi7HqiM99w09ecDuL/DJhyu
 8D2UvhELPZTW1s67l69oKynEevoA0u+Exna0GoqO6yWCL7ddX0B3p48t9M1klZZ1KrCe
 vunmT0kDAAylBKPX6nAIunnjLzrmK61pCTpDf0PSeloO9Vwi1wdsGD/rZs7X507F9cZr
 3jAg==
X-Gm-Message-State: AOJu0Yy4L9EXbulej13ptLYpE9NwBlsLwqcBYOL+DOgoMVZ6bC+fYrSd
 eWFNfXiMaym5S+zbm8O4vXx2FecrS4k=
X-Google-Smtp-Source: AGHT+IGqMe0ujA9jOeuIqfPkAtJwIOYlW0rrMPtBwdxvoXbsTbVGUwFsnxSPsr5JMODQkgfdWjJKJQ==
X-Received: by 2002:a05:6a00:230c:b0:68a:6305:a4cc with SMTP id
 h12-20020a056a00230c00b0068a6305a4ccmr20504911pfh.5.1696924379268; 
 Tue, 10 Oct 2023 00:52:59 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:52:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 03/11] tests/avocado: Add pseries KVM boot_linux test
Date: Tue, 10 Oct 2023 17:52:30 +1000
Message-ID: <20231010075238.95646-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is not much support for KVM backend. Add a KVM boot_linux.py
test for pseries.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index be30dcbd58..6ce08ff6aa 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -103,6 +103,15 @@ def test_pseries_tcg(self):
         self.vm.add_args("-accel", "tcg")
         self.launch_and_wait(set_up_ssh_connection=False)
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
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


