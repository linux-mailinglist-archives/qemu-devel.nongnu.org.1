Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E774EAF5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ9sZ-00086e-VO; Tue, 11 Jul 2023 05:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJ9sX-00085Q-OF
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:41:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJ9sW-00034s-0E
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:41:53 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso6248853f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689068510; x=1691660510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BZXkeQgSJcU7RaDGsn6nsXak1POLNPn+cRWjRm4w9Qo=;
 b=QOHfToU6t+nGDvkf4NaUqt6l5IiflMI1R2Vyun/ut9GL/04WcMhTbIxwGE+jYOd6WC
 hQgldTN/nRN7Vg4OV7hrVFF5JMBSKCc5a8UQ+FQ7nDUkkLwScL4MpgtEIShnowCfojJe
 KIEmZl6K2t48CgZ55nWmD8a+7Htw+OfDZCGhzPW+MlsYm2+nEZSKN+FFWvWtdoC9Xq9Z
 NT+9pO82m8pti/f27tVG7aLYaGjuXNhZudWxSNHNdmhfiUV8W2kVNZhe8vFxwMYuMes0
 v9EBcn5jiuraJPmTVZ+Clyng/LHGzYJ9R1dsn19pqFOTGUgMxnytXlN+GUmhWU0sWp/U
 X9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689068510; x=1691660510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZXkeQgSJcU7RaDGsn6nsXak1POLNPn+cRWjRm4w9Qo=;
 b=UiVYZk1s5Viy01kCMGEEwT9ANYp50dKMsmruK9ojfUjxNXbTXBsuw4tg222+xmR7al
 IBlYIGTlVp0FgT6NNcy8mr0Dl/c+2I/WvG/3E6k/fAG3HrWmwnyyW8yVd4Frr0fql9HR
 4tVvrhsWATf/lVG8oom95Sbb6dVDfydcb8VxRzd4STgCXio7Yf/4ZY6MMvuIGQrRPHYf
 75uKP77MW6uf6Rtac9fj9c2lv7Wg/+yCimLFQaqbgeqBJPQPK5CzlxGNWJm6oixWfSHA
 B/6TG2NFU8IfbmPU+yGyUkmzfsYnE2bQhFS+wHTtikSm2Hz2Nk2DVota08Z2cCYe1rku
 Igzg==
X-Gm-Message-State: ABy/qLadg1kI8wRA5ErDrUWsSMPz3khgRYbFG/A0fiqetSB049cXVneC
 itz1urleuKVi2bUk8d+qxu02+7cFEIua7qHWiVeUYw==
X-Google-Smtp-Source: APBJJlHFdp4fQ7cky7BSvNLc9Z2Omz6Em8pGF2ZF2ljBWuhDDn1gkjSOVIRraZLjxHHovwwfHnH56Q==
X-Received: by 2002:adf:f3c6:0:b0:314:3b78:da77 with SMTP id
 g6-20020adff3c6000000b003143b78da77mr14023708wrp.29.1689068509872; 
 Tue, 11 Jul 2023 02:41:49 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 p8-20020adfe608000000b003141f3843e6sm1740689wrm.90.2023.07.11.02.41.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 02:41:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [hotfix PATCH-for-8.1 v3] meson: Fix cross-building for RISCV host
Date: Tue, 11 Jul 2023 11:41:47 +0200
Message-Id: <20230711094147.54985-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

When cross-compiling it is detected as "riscv". Meson handles
the cross-detection but displays a warning:

  WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new
  Host machine cpu family: riscv
  Host machine cpu: riscv
  Target machine cpu family: riscv
  Target machine cpu: riscv
  Found pkg-config: /usr/bin/riscv64-linux-gnu-pkg-config (1.8.1)

Commit 278c1bcef5 was tested on native host but not under
cross environment, and now we get on our cross-riscv64-system
Gitlab-CI job:

  WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new
  Host machine cpu family: riscv
  Host machine cpu: riscv
  Target machine cpu family: riscv
  Target machine cpu: riscv
  ../meson.build:684:6: ERROR: Problem encountered: Unsupported CPU riscv, try --enable-tcg-interpreter

As a kludge, re-introduce "riscv" in the supported_cpus[] array.

Fixes: 278c1bcef5 ("target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v3: include verbose Meson output
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


