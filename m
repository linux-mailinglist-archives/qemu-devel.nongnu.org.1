Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDF74F59C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGJK-0006NQ-2t; Tue, 11 Jul 2023 12:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJGJI-0006NH-9y
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:33:56 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJGJF-0002bj-Gg
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:33:56 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51e590a8ab5so3186668a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689093229; x=1691685229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RNp8d3beHsuV71moqKCCgFI5FUfk4k8uHBg+2vDvuX0=;
 b=X8+PCaEDv2CUDJaBJk06HyCxnzVVlWUMCLx0XRLOXW8JgYdEk9zQHwcjBnM4VBqDSF
 zqFt7quUENfPWbxFOeSp82cTnPKAh6PcmWrmmihMeygRGkY28cUiNE35UkavBdxC1P00
 bRDfELRgpsOKvjrW/NwdkN4lmrShHWcFZtQdJGkceMDK4iemuGQYkBBzDqXX2zI69SrB
 WiRrgUZEDNbQlgvRw49qtNuClmdY5XGcn+9f3ygklAG6kRfol+s8XhydMbT0nfevMJm4
 mQ/qL/3mKqzLHBEgF0PanFFLgKnXBkV1taD88NLzQOaX4kMX9mA61tTAC0GhgYAQ1S8E
 IyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689093229; x=1691685229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNp8d3beHsuV71moqKCCgFI5FUfk4k8uHBg+2vDvuX0=;
 b=aMdpZFiPHoZ4ex0TimuIC3Dt+58xGUFCOWnZrDeUknjomh8jSM/wMwY11WCg7+YcXW
 l8yL1hIwe/ssdSN3PAI2Q901wzRS4SFZKx7kWKNY1zvir5nHWu/Up4g5YiRihTNTKGyq
 ms5e8XOR9+pGBewn7rLzcjAn4EviidR+WMUXe1iQ+bYSO7OmadJBaYqnYxZEsdrOteqf
 la+0flxa4iWeKxz6ybvlEjdo74SIBdqCy+K2RN24FqADkR3PDbBNXJgDgBxVvfXufvL0
 +uOZcAek1ZNKDUcjZwLPiP13l20h4e7MzunNaoIj/RRmD7xDrJwx2lhllk+2GV5PikY0
 3hQQ==
X-Gm-Message-State: ABy/qLZy0wZuB4HoM/b9d2xJ9eqqc7nJis13Hi5apjSnsmKlKcnwJCVD
 l3oLbQ/nmBKop9DeavLAO0Bp7an4I2Affp9G5NY=
X-Google-Smtp-Source: APBJJlFBCqe0KlmC38xjj7GE2qtv9DiM0c1dww/ru4zYMg4OeHrPsgYzcwbcFiGHLJCOKr45i+hnXg==
X-Received: by 2002:a05:6402:135a:b0:51d:a124:62cb with SMTP id
 y26-20020a056402135a00b0051da12462cbmr16947935edw.28.1689093229306; 
 Tue, 11 Jul 2023 09:33:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a50ec83000000b0051e0ea53eaasm1450294edr.97.2023.07.11.09.33.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 09:33:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [hotfix PATCH-for-8.1 v5] configure: Fix cross-building for RISCV host
Date: Tue, 11 Jul 2023 18:33:46 +0200
Message-Id: <20230711163346.69409-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Update $linux_arch to keep using the shared linux-headers/asm-riscv/
include path.

Fixes: ba0e733362 ("configure: Merge riscv32 and riscv64 host architectures")
Fixes: 278c1bcef5 ("target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v5: fix linux-headers path
---
 configure | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 2b41c49c0d..26ec5e4f54 100755
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
@@ -1722,6 +1726,9 @@ if test "$linux" = "yes" ; then
   mips64)
     linux_arch=mips
     ;;
+  riscv32|riscv64)
+    linux_arch=riscv
+    ;;
   *)
     # For most CPUs the kernel architecture name and QEMU CPU name match.
     linux_arch="$cpu"
-- 
2.38.1


