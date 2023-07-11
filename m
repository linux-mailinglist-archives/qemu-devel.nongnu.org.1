Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE674EA5F
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ9ct-0003r2-9V; Tue, 11 Jul 2023 05:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJ9cq-0003qV-ER
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:25:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJ9cn-0006vg-CM
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:25:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3142a9ff6d8so5903568f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689067535; x=1691659535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qMBUsM5cV4dZcFt7kvbGUCTKHF8drcK6kogSoPu1EbE=;
 b=V0nYz8ZIx2KAPsz4kHkypFaPrQ+2nVNuJ0tfP0w/hL0sMGnp8ly/nIkOak1Dx/skAm
 4ZIFjBSBws/9+02HHa+qmhb8Ed63CHG11aqQSc/n2E9WSxOkbGg5SpKHZv71UNdc1eDN
 fr+Mhn5gPWRBaG00yaUIFP0/6GRTOEL/HI/kAsnYnKrisJ3a5hmGLx4x3/t6wpkC5x1A
 2ImKh3LzaW7w0vkehw/tmg0CPr30t7bDpxX6EWU9pALdZwiuCrQ4CnQIwEJnBwJO2kwj
 o9yvxT1otdEE87Hb7UNaCgzBWzAH3k0zIK3g6hieXXE3NIWB8juSSiJjXD2j0ZwKEpdQ
 h1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689067535; x=1691659535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMBUsM5cV4dZcFt7kvbGUCTKHF8drcK6kogSoPu1EbE=;
 b=axKbb2piI84ltgWR+f5zSgrBz2xnWLyyd7tODe+ZjqA7sYgDCia/cl3QECVgrp7/mF
 VuzTY11LdRMjrr823knte/Lzi+xp0JWm6qo+A8UBi9kOtxCgP0Ao3JRi8gX+Q+AYd6uU
 nnrKRmOpdE4GjCqLVqL8kK57ozhqd/FCv8Fs+A/wp+ZIboBO8Ng6evFNk9hoJIf2q6kG
 H+W0P0APX2nRV2b/26O5LbifR3tx8ElDajA5jQMFtHdPR43zmuOFz1xJDSannf1/bsMY
 w910sI/lgAcWBOxOuD2CjMQblm6orLodO/xjaSP2xW5SD3YhkSVHFim9VmlF3rFsim44
 HXzg==
X-Gm-Message-State: ABy/qLas1afhvBi0Y4wcCeJ0muGvtgxSlXFvvuasPECGXFvMpgcqr5A/
 xbcq0N5bIgAHzsjb9RcM0ri9HnTlDpBiyoRisrgq3Q==
X-Google-Smtp-Source: APBJJlHVR8JqaVCWUW9R/BI2wHxB1D2/QrMDJqh186VOuVGw/y3XTD6ugSIUXFJf0n4fSRpTE1QTbw==
X-Received: by 2002:adf:e5cb:0:b0:314:545b:4dd with SMTP id
 a11-20020adfe5cb000000b00314545b04ddmr16204551wrn.20.1689067535518; 
 Tue, 11 Jul 2023 02:25:35 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 j2-20020a5d4482000000b003143867d2ebsm1711469wrq.63.2023.07.11.02.25.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 02:25:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [hotfix PATCH-for-8.1 v2] meson: Fix cross-building for RISCV host
Date: Tue, 11 Jul 2023 11:25:32 +0200
Message-Id: <20230711092532.53929-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
is reported as "riscv32" or "riscv64", when cross-compiling
it is detected as "riscv". Meson handles the cross-detection
but displays a warning:

  WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new

Commit 278c1bcef5 was tested on native host but not under
cross environment, and now we get on our cross-riscv64-system
Gitlab-CI job:

  ../meson.build:684:6: ERROR: Problem encountered: Unsupported CPU riscv, try --enable-tcg-interpreter

Instead of:

  Found pkg-config: /usr/bin/riscv64-linux-gnu-pkg-config (1.8.1)

As a kludge, re-introduce "riscv" in the supported_cpus[] array.

Fixes: 278c1bcef5 ("target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 5fcdb37a71..58e35febb9 100644
--- a/meson.build
+++ b/meson.build
@@ -55,7 +55,7 @@ qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
-supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
+supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv', 'riscv32', 'riscv64', 'x86', 'x86_64',
   'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64']
 
 cpu = host_machine.cpu_family()
-- 
2.38.1


