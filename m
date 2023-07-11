Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B26D74E986
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 10:54:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ98U-0003XG-KI; Tue, 11 Jul 2023 04:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJ98S-0003Wp-EC
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:54:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJ98P-0007SK-SE
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:54:16 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3142970df44so5214958f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689065652; x=1691657652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7fnnFNWYr3hPr5DNLTnD5gyE0kFtGqKbSLcOTRKOYOs=;
 b=IylcwWqOt1ARVNpLhZwJJFjFNjZ3Zebg/lcfWlcfHigvba+QyFCdEXtDAkn9NtDcCu
 Ti/Ko7Sf3xNFe2x06ScYfJrlEcHiZITt1r3dNCi7NU4NhC9oAr2o6vIZq/CQKQPoBC+L
 UfNnp19rBbiRdq+nZaqq2fF87LoybarKdGYJHNSQJS52gYpo3lx6mcm6x+eKtYjqQ/Xr
 it1W+TfeLUlN0pCoG4IIiCq7L1FDAIbTwAl2onBNJInW2tQ/L1L2wz2CdlSOYUoYo3QL
 vM0mBYFitXCzDdaN0PrY62zceWGJvpJvABSD6MrhN6oGfxN7DUqVBR9y+LNgT4yTIZXd
 CZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689065652; x=1691657652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7fnnFNWYr3hPr5DNLTnD5gyE0kFtGqKbSLcOTRKOYOs=;
 b=V57vvOKmmUr4iprRKSSjBjlo3CQxR6NDOBsN0XlartbMnoRD42azRBjpchhQ0dW+U1
 xQg2vMALQdnzVAtw+ZmyaL/Exi0dCQzW1FqZVdQC8/+6m+iujEDBdoVUsZvbEk2agPde
 IpoIs+fpKUzP4OWLqWdgM/7JIIQEto0sFv4OJPcNWZa+o49noZNamy1I3kfTQbCHvfey
 RmwOAYDGQ43klRxizNnCqm7j6bKmsHD/vaaaiMbfHpHxmybi3/h12MrVBdgw/FAA6wxT
 c42GEejclgBvVAqKH23ceZZlwF6/KupYGZ/xKjTvDdB6EGAFtCdSocqxpoRMyRj7BsMi
 6CXg==
X-Gm-Message-State: ABy/qLauDuRYTaSNl/5umF2zQrnVVS5DpWmwv9vto003HoImgShXQDyN
 I8M4mdNL6AhCu3nJN6A8QGBRTS+Nq6PID6Q3WFNlcw==
X-Google-Smtp-Source: APBJJlFuv0jQosv24sznVaXCF0cEJeyVBnHdR8kxYOoVKCH3cbCJ+dQK1a2o8Xif/vi1F/pglfDzIQ==
X-Received: by 2002:a5d:51cc:0:b0:314:121d:8cbf with SMTP id
 n12-20020a5d51cc000000b00314121d8cbfmr9166498wrv.25.1689065651836; 
 Tue, 11 Jul 2023 01:54:11 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 t12-20020a5d6a4c000000b00314329f7d8asm1658986wrw.29.2023.07.11.01.54.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 01:54:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [hotfix PATCH-for-8.1] meson: Fix cross-building for RISCV host
Date: Tue, 11 Jul 2023 10:54:09 +0200
Message-Id: <20230711085409.53309-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
cross environment, and now we get there [*]:

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


