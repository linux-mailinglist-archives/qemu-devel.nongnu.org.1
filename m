Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44174007B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:11:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGS-00007n-0K; Tue, 27 Jun 2023 12:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGN-0008Hb-Ny
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGH-0005oC-Qb
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-313e714342cso3812898f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882188; x=1690474188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoH/DOZFZDe6ZD+LHfFvG2TjLm3SJ3G2i0MfunKyFLs=;
 b=GZDB24tUP16+wbjP14G/r3MTxXacPNS1ryHB55f7dww87AElnA5OMgA+A/IHe73dsG
 crD1e0SXM7zIDZXo6LWHxx6/xj+zTQAdVRP3uZ9E7n/NvIYpdeWY3vkJ0DkuWEUY3Ss/
 Ngyjm/grXi0UYBjdf59JpbF8WZN9cRR/9g7ssuoKnI6h3i3GbFIOEXxI9EPw3hF8hw0d
 zlfS/DyQl+uorChPjjC0hhxfOqn9k0LngzH2T1xcKwMzhmo/P+KEWBRuo6ZoDNerGCgH
 dvrB+eZTTYq1NNt/RXL/d4AX3zSjfTVswlXRubVZ6X5VcZzsCL+MfZlMAS7jJRwlaMkm
 B8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882188; x=1690474188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OoH/DOZFZDe6ZD+LHfFvG2TjLm3SJ3G2i0MfunKyFLs=;
 b=QbV0ZjLTSGM2YXqDfcNMkwBGJhYBnJE31soAhhbYAYJMGspAPfMctskFiM26I77Old
 5FouElMrUtUnfWY/3FCY/vs+AR/GHvHflme0/Zk3IQpYhsI0d72OkxWhyYvgPHkgYRHi
 4jx3eruFnYssZoI3IFHdNyM6+CdWdcEZYoSN7VonTOolvaq8ENldt6iBHGjROlNI9YfD
 Nq9i/3WmC2PDWA2H8dRNWUNG/+xKdUA1+qBhwP2Bkp12CjRSIXvRUJsNef8jrmlg18JH
 MA0WV+cgU0DYcfxaVfn8pVXx0Axpi+BT98opJ0oH7ShGmNUNqXLvn+meRooIjXdbxL2G
 QnoA==
X-Gm-Message-State: AC+VfDzdZx8tpZdCye4Qylo+q2F7yPrJgZwCmVZ459rsAGotmzgvtV5P
 ibs8Q6RhrSvSeJpJibiqV8Ujqg==
X-Google-Smtp-Source: ACHHUZ4tODe2u9L9D4/sqnZJ5dx3/Fd/bisKwCXYS6xZp8NulWJieYAFkfYHSrD44BdRCrAC9RN2sQ==
X-Received: by 2002:adf:da45:0:b0:312:8e63:71c with SMTP id
 r5-20020adfda45000000b003128e63071cmr15491827wrl.32.1687882188292; 
 Tue, 27 Jun 2023 09:09:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a5d4bc7000000b003113dc327fbsm10833942wrt.22.2023.06.27.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D88D01FFC5;
 Tue, 27 Jun 2023 17:09:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 09/36] tests/docker: add test-fuzz
Date: Tue, 27 Jun 2023 17:09:16 +0100
Message-Id: <20230627160943.2956928-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Running the fuzzer requires some hoop jumping and some problems only
show up in containers. This basically replicates the build-oss-fuzz
job from our CI so we can run in the same containers we use in CI.

Message-Id: <20230626215926.2522656-10-alex.bennee@linaro.org>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
 - checkpatch cleanups
---
 MAINTAINERS            |  1 +
 tests/docker/test-fuzz | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100755 tests/docker/test-fuzz

diff --git a/MAINTAINERS b/MAINTAINERS
index e07746ac7d..3cfc389db0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3106,6 +3106,7 @@ R: Qiuhao Li <Qiuhao.Li@outlook.com>
 S: Maintained
 F: tests/qtest/fuzz/
 F: tests/qtest/fuzz-*test.c
+F: tests/docker/test-fuzz
 F: scripts/oss-fuzz/
 F: hw/mem/sparse-mem.c
 F: docs/devel/fuzzing.rst
diff --git a/tests/docker/test-fuzz b/tests/docker/test-fuzz
new file mode 100755
index 0000000000..7e506ae1f6
--- /dev/null
+++ b/tests/docker/test-fuzz
@@ -0,0 +1,28 @@
+#!/bin/bash -e
+#
+# Compile and check with oss-fuzz.
+#
+# Copyright (c) 2023 Linaro Ltd.
+#
+# Authors:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+. common.rc
+
+requires_binary clang
+
+# the build script runs out of $src so we need to copy across
+cd "$BUILD_DIR"
+cp -a $QEMU_SRC .
+cd src
+mkdir build-oss-fuzz
+export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
+env CC="clang" CXX="clang++" CFLAGS="-fsanitize=address" ./scripts/oss-fuzz/build.sh
+export ASAN_OPTIONS="fast_unwind_on_malloc=0"
+for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f | grep -v slirp); do
+        grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
+        echo Testing ${fuzzer} ... ;
+        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
+done
-- 
2.39.2


