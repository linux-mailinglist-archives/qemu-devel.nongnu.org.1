Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC187EC87
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Mar 2024 16:48:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDt-0006jX-1T; Mon, 18 Mar 2024 11:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDd-0006KQ-TP
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDW-0007wM-75
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:07 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e032fc60a0so5410305ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776879; x=1711381679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eazafKsUh9Gq+1jlyAtlIIMsQVJTUKsjooFoPTkUTU=;
 b=R8IeFrKxuFwRJ/kTx4UEwWrSHwE0M1cNS55u6O3svHS2C1yZ653YYSgmmdo/EbXtpd
 Ul29jCiIkOQXjeZPyfq+kHmykYGYJgvCf6mNTvfQpuFiqBH5W/j8A+xeeID8FrIEkvFi
 dRFBS+HllnF5cIsMjI9b2bnlqZ+vZI3PRAqtGG+o9BmS7j9zmNxYXfQqTLtBi7+Wzucy
 LdIbnAokKtltqqex3nf2T24jczf1jmk+incFgojq6nJJ4V/DYm+GZVREz1zzuq4Zdhpw
 cGW0E8LX1zjUMczHKFQwlSSn7pOYfpbm/rvWug1WZ+DX9VNMdfTVpSkFoA5OVfQpvIHk
 TYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776879; x=1711381679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/eazafKsUh9Gq+1jlyAtlIIMsQVJTUKsjooFoPTkUTU=;
 b=LAF7Q9zE7Pi/nzn7zHBGT5XOwN1MjQgMPok9Xl4A2QjHfk8ukwzqkB6zwoNU4QTY1y
 IjDMXTmVSBk5V0Oe+wMy9/KguIfm2cL9jQYKpkwDaDo9LY+FQeyxxp2wKPwdNNqc3qlR
 v3jzj36eXkIRd3QHEfGqgpr6zXtdwY6vDgd20ZDhNG8BvbX8YL9rIJizF8XBM16xtB0Q
 NWfUu43X2WlTGo26RBDzTJ19Pz0RLYXkTaamq+dJxS877sAiP9YkqNo0cIy21G+CVk6/
 k3BzDGNibircoomkDOPAE7BWfUWZwNJ3AWKCmxlxXC403y1zl0XBNUD1WwW1CAqFXl60
 c+nA==
X-Gm-Message-State: AOJu0YyV9nON9e4WPdJM0nN6/dOKI48y/DYl+Mwu/7/LlxtYnvYEn7CD
 EhiGlX+lCRJ3wVGIehkTE/KydiYSavNjA78L1hwDqRXGrP69cImpq8R4UOM9IlI=
X-Google-Smtp-Source: AGHT+IEldDi+kzSyGX2FTxnZL2NKuXBRp+NetXJ5SBlesdRVyO99lzJwGhmc5Iv0zsLdcwIYk0LGbA==
X-Received: by 2002:a17:903:2292:b0:1e0:185d:16e0 with SMTP id
 b18-20020a170903229200b001e0185d16e0mr5868482plh.24.1710776879349; 
 Mon, 18 Mar 2024 08:47:59 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 15/24] tests/avocado: reverse_debugging.py add test for
 x86-64 q35 machine
Date: Tue, 19 Mar 2024 01:46:12 +1000
Message-ID: <20240318154621.2361161-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

The x86-64 pc machine has a problem with record/replay. q35 seems
to work well. Add a new q35 test and update the flaky message for
pc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 8fe76ff921..e76cf54ad7 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -206,8 +206,7 @@ def get_pc(self, g):
             + self.get_reg_le(g, self.REG_CS) * 0x10
 
     # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'pc machine is unstable with replay')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -216,6 +215,14 @@ def test_x86_64_pc(self):
         # start with BIOS only
         self.reverse_debugging()
 
+    def test_x86_64_q35(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:q35
+        """
+        # start with BIOS only
+        self.reverse_debugging()
+
 class ReverseDebugging_AArch64(ReverseDebugging):
     """
     :avocado: tags=accel:tcg
-- 
2.42.0


