Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F374EC44
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 13:06:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJBCO-0000Kt-Qr; Tue, 11 Jul 2023 07:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJBCM-0000Ki-K7
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 07:06:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJBCK-0000OT-Rc
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 07:06:26 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so13132964a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689073583; x=1691665583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=khAIgfvJszKXaZe97jz/vSTn0ZRK4fOzAnwv01G4SEA=;
 b=Go8fpyDYbuHwSo9D5saSpqHCaEBBGeSRltXSZzTEfzBTN7ORs50jw4JHzVYUVzwgkF
 L0zi7M4cR/jziZvP2uaUblnT0jeNTwwU3gAHDCmEQescQutgOBSlHXa3a1/B3rGPmOSM
 WyKbgROYj4z+uapCJJ8L045CP6FqDFvCyD+q85WLkpu/Jx8DilsBaXYvG3i26mOvaitH
 gLCw/P11Hd4ObrdBkAHpSpffhlG9kLNEX8fFAiGJ34NT8sP4myR10vnM4T9+lrfUCNLk
 swNkWd5Y4yxss7vBjmDPTdJSPBWygNjjnPzAzd1OKif7hriT+flLeVFfHPjX5SDTlUth
 X6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689073583; x=1691665583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=khAIgfvJszKXaZe97jz/vSTn0ZRK4fOzAnwv01G4SEA=;
 b=JrMDTmaOrpI0zA/MnzsAuhvh60iNemR13k5DjlxtSuaZLsCgVKSROg4Xkn4u4T4qxL
 im+Z5gnIdp1LtkLaByVkOiXov5xFRfggm8ju3vj/q/S5j/ddFJJKeFK1gU3ySsG06hxj
 4h1HQ47YQCV2G7KiArjLglqA0dFgyLrcsZvU4r1Zml7PcqDys+4uosErPrsLXqEC5w1y
 Uu4CoA6f+Bb842WeffPMUwTMJROTrsbuvKzO5TvC3YeLeN4vBq1HPE3pjbvEoPkL6r7g
 GUNpqTHtSrngyWKjKC2ckbcpKmSPEqpnT73bG2X39FduRvjPm6T0Nm/7MWh3xfd3uOrU
 733g==
X-Gm-Message-State: ABy/qLbjQcspEoXVPgFChMnoHRPyo6xkK6ZmwXdyYwx27bIu/i5MmaMu
 cWZhXKOTDkXGSjZPXObzcMco+3bFxs2ihktGIaw=
X-Google-Smtp-Source: APBJJlHTzO7ZvioMX5oEMdVfHKrxo1y8BN49izCP/eCExBaHwz0AT58DsjJ5CgId7K/7n7KEXbfB+g==
X-Received: by 2002:a05:6402:40cb:b0:51e:5898:a23d with SMTP id
 z11-20020a05640240cb00b0051e5898a23dmr10199737edb.5.1689073582964; 
 Tue, 11 Jul 2023 04:06:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 y19-20020aa7ccd3000000b0051dd4daf13fsm1101512edt.30.2023.07.11.04.06.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 04:06:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [hotfix PATCH-for-8.1 v4] configure: Fix cross-building for RISCV host
Date: Tue, 11 Jul 2023 13:06:19 +0200
Message-Id: <20230711110619.56588-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

While when building on native Linux the host architecture
is reported as "riscv32" or "riscv64":

  Host machine cpu family: riscv64
  Host machine cpu: riscv64
  Found pkg-config: /usr/bin/pkg-config (0.29.2)

Since commit ba0e733362 ("configure: Merge riscv32 and riscv64
host architectures"), when cross-compiling it is detected as
"riscv". Meson handles the cross-detection but displays a warning:

  WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new
  Host machine cpu family: riscv
  Host machine cpu: riscv
  Target machine cpu family: riscv
  Target machine cpu: riscv
  Found pkg-config: /usr/bin/riscv64-linux-gnu-pkg-config (1.8.1)

Now since commit 278c1bcef5 ("target/riscv: Only unify 'riscv32/64'
-> 'riscv' for host cpu in meson") Meson expects the cpu to be in
[riscv32, riscv64]. So when cross-building (for example on our
cross-riscv64-system Gitlab-CI job) we get:

  WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new
  Host machine cpu family: riscv
  Host machine cpu: riscv
  Target machine cpu family: riscv
  Target machine cpu: riscv
  ../meson.build:684:6: ERROR: Problem encountered: Unsupported CPU riscv, try --enable-tcg-interpreter

Fix by partially revert commit ba0e733362 so when cross-building
the ./configure script passes the proper host architecture to meson.

Fixes: ba0e733362 ("configure: Merge riscv32 and riscv64 host architectures")
Fixes: 278c1bcef5 ("target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v4: pass from configure
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 2b41c49c0d..dffd44c059 100755
--- a/configure
+++ b/configure
@@ -451,7 +451,11 @@ elif check_define __s390__ ; then
     cpu="s390"
   fi
 elif check_define __riscv ; then
-  cpu="riscv"
+  if check_define _LP64 ; then
+    cpu="riscv64"
+  else
+    cpu="riscv32"
+  fi
 elif check_define __arm__ ; then
   cpu="arm"
 elif check_define __aarch64__ ; then
-- 
2.38.1


