Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6F7C503C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXF-0001Tz-B9; Wed, 11 Oct 2023 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX4-0001IU-MX
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX0-0005AS-Iw
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405524e6769so4807975e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020411; x=1697625211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYNRmoxNI53oOIjLqN4U1LCzFirqfr049WCu+bQeo6Q=;
 b=ErkbigTCTo/1gZ7vUGft2RWzZJa5lEheVzkp3zoN16RmMIiaWCcz5vMFZc9O+7362O
 gDlgBzetu8bBxFnbvT4k98ObHkSljGVF+1w+TRyHlh5Pu22DTNd8e3npQxKjr4owSelj
 Ht2Lpjg79kJfe3Ap0mwUD1RnQSyAuT6U2/japPTL1bkgVB0XcET0TADfJRrgxiJxJ/yL
 rSjbwXyQUN1URqkq2ISEJt6pwHFB3hwbpCCQ0GmvQIqzSKEQT1tbFEM+2mFG7vHwXGOo
 30YNAuHGwpL0UQdTuHOMD/W9PUblk6+rpG69Q4c57A1K82Aj6fawJU6LwYH8BkbYIhIf
 93Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020411; x=1697625211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYNRmoxNI53oOIjLqN4U1LCzFirqfr049WCu+bQeo6Q=;
 b=oVST2TSsSo2pgteLvjKk6UIs/EU/BBtuRLhDLJxXeW366CFtBsWfptSOkOD4exRjbg
 EIUx4RAG6t+RaSo+RfOif1hB5zXynypZZXq8OC5MI/6TzDP89j/f+4p8tpY7bJEJzVKq
 Nh1hmhbbtuJm2AMlRUmEQZIOiGp5UL+XFZ7k/vkwkuaXnkPe3dcQ6rDKLRZNiP3RDVmn
 9SPaubGbB3OBC8kFwLfPjy90RqMftGhIlPVdcVgtkGSKZpqm9lgm2fV+19J7PbwjL/yt
 465xpLxMS7KYCRTVz4XmVQmCVfYeb+PIXORuDakHcWsI6jyubbu5OAcqcMaXeLzbt6et
 oTCw==
X-Gm-Message-State: AOJu0YyjPrCTs7v7mSzVMUxrdgGn2NC+IjonDoViUWcALbzIVkjwz2+G
 +aDDsaVe/zMeRm8+RyVndHMvgQ==
X-Google-Smtp-Source: AGHT+IFbJxRnxS37fJS8SmyT91t+08/ZLTwxaP0tQsja5KoVtGRM4cqxx3WSxzjo7FmFY5bcHiIRFQ==
X-Received: by 2002:a05:600c:220a:b0:405:251f:8455 with SMTP id
 z10-20020a05600c220a00b00405251f8455mr13973069wml.7.1697020411322; 
 Wed, 11 Oct 2023 03:33:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b00406447b798bsm18773359wmj.37.2023.10.11.03.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:31 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4BB7D1FFBD;
 Wed, 11 Oct 2023 11:33:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 02/25] tests/avocado: remove flaky test marking for
 test_sbsaref_edk2_firmware
Date: Wed, 11 Oct 2023 11:33:06 +0100
Message-Id: <20231011103329.670525-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

After testing locally I decided to revert a5754847e0 (tests/avocado: Disable the
test_sbsaref_edk2_firmware by default) as the test seems pretty
stable:

   env QEMU_TEST_FLAKY_TESTS=1 retry.py -n 50 -c -- \
     ./tests/venv/bin/avocado run \
     ./tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware

yields:

  Results summary:
  0: 50 times (100.00%), avg time 2.064 (0.04 varience/0.19 deviation)
  Ran command 50 times, 50 passes

Maybe f0ec14c78c (tests/avocado: Fix console data loss) has made it
more reliable?

Cc: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-3-alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index b272053eaf..bdd1efc768 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -75,7 +75,6 @@ def fetch_firmware(self):
             "sbsa-ref",
         )
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is not reliable')
     def test_sbsaref_edk2_firmware(self):
         """
         :avocado: tags=cpu:cortex-a57
-- 
2.39.2


