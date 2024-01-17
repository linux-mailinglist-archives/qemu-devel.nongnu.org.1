Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DEB8307B0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:13:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6fI-0005PU-DX; Wed, 17 Jan 2024 09:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6fE-0005Kg-UT; Wed, 17 Jan 2024 09:13:08 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6fA-0002oW-5j; Wed, 17 Jan 2024 09:13:08 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7bf2a5cf9cbso159561839f.1; 
 Wed, 17 Jan 2024 06:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500780; x=1706105580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBSkXRxSZoelpdPAumnSWtIKBOY3tYds/IcNxS81yBo=;
 b=S+Bp+cCxxJpjOn7eNBPj+x9MTuOwjXka0eEk09jr9zLqQhlhhQqnSTeUukJuPtyd+L
 RTGJQBjPC/dClDKiK/8bjRlUb+nfXLmBINSmgZlryLdy9VqFGC+F2OInqVf7hrQ8P0eS
 TEJPrV9hYnMY/B6sIkgndFoVA7NgAkF0Ti7bThM/OREjdJM2qhqpOCkFk3p7HwNlIeGr
 YH48z5g6uR1lcL6V4ihPiI+yiWeUrjJc7YKcsxrnKOWFYkkYZ6XSeYi3A9Hp4gH+BZsR
 sTp7qkYPyVg7bHoLbmlkg4UD03UF/fPTTPPagvuI4CilLslUmHUMgbDkLSQjgd6nJH4W
 E5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500780; x=1706105580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBSkXRxSZoelpdPAumnSWtIKBOY3tYds/IcNxS81yBo=;
 b=LoSizSC0z7AtXpU6rxy1yHtF1Es5QNjRF8dCwVFKVmg9IneYemvpxtabna+xoSvuK8
 Pri4pvVOKHrhW0dW2f5pzW32LfMYdXl4DgFkkDd36Y7+GLNGrAqm1MplHixSaHh7jLLx
 +W817Ynkme87JKav95IctlsZKQdp+vy1DwMrfDB6EByiQQOPbUfpemYgJbGtTMQ+tKZL
 YxluSm8RcqFNtMUc8FQHFFgt13zdr4XPyaxhc6oszBCoiSjs2U4NSC2if2bc59shCXrE
 1lc6aWW9PmCl3IxCei6g15CfwpCQ5UFd/cejxWfTX3xSm0tH+p+bL42puTLx+D5mBuII
 OHJg==
X-Gm-Message-State: AOJu0Yyh8laBTgJYkDiAsP2gb5C1qyzaNumm0P6/S+pum9exmJn0luJh
 skWh0+Um/dvoYQGgHKDHoPPxKqt196k=
X-Google-Smtp-Source: AGHT+IE7mn85vvH2j8Zg2s84zIbQSXYGhBpJov+eTaupqAEWapC2Ca04zCUuAAvxN/Km78pZ9O/MLA==
X-Received: by 2002:a05:6e02:68b:b0:360:e6b:bc44 with SMTP id
 o11-20020a056e02068b00b003600e6bbc44mr8719219ils.3.1705500780273; 
 Wed, 17 Jan 2024 06:13:00 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 i136-20020a636d8e000000b005cebb10e28fsm11812428pgc.69.2024.01.17.06.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:13:00 -0800 (PST)
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
Subject: [PATCH v2 4/8] tests/avocado: ppc add powernv10 boot_linux_console
 test
Date: Thu, 18 Jan 2024 00:12:19 +1000
Message-ID: <20240117141224.90462-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117141224.90462-1-npiggin@gmail.com>
References: <20240117141224.90462-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd2a.google.com
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

Add test for POWER10.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 3f0180e1f8..4f05bb7441 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1386,6 +1386,14 @@ def test_ppc_powernv9(self):
         """
         self.do_test_ppc64_powernv('P9')
 
+    def test_ppc_powernv10(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv10
+        :avocado: tags=accel:tcg
+        """
+        self.do_test_ppc64_powernv('P10')
+
     def test_ppc_g3beige(self):
         """
         :avocado: tags=arch:ppc
-- 
2.42.0


