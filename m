Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF06F74006E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:10:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBDn-0000FU-TX; Tue, 27 Jun 2023 12:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDi-0000AP-4j
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDd-00057t-Qc
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31297125334so12624f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882024; x=1690474024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoH/DOZFZDe6ZD+LHfFvG2TjLm3SJ3G2i0MfunKyFLs=;
 b=HAXvgYVQj2aKDGxr/IBoeMC/673IqY3UyaMYpy1khbhfutpblQDEXBXTT4NiIIujFh
 z6ni3z7fPvio4+65wfSn2GpY/YovvOJ1VfmyKKyNfwL8/W/Uwcbxr2/iDuW1vy+vLYJZ
 CL0ZtNLsaogPzhEe+70qbgrrWSv08GeGefu5kmWa7VsQc6CNWShZb/E6IgeY9BwiN3Dv
 IHzbWdRciWoqV4uiSmypf622q4OHybxzw4mfK6louRtiAacJ4Mnm7s1SQq5i+om2kSl5
 qELZE1EB3uLoc2ENG6rqEep4zcgAhHvrnBkeYIsr8eiMCc2vTuojT1yFBUDlxLMsxqWt
 89cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882024; x=1690474024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OoH/DOZFZDe6ZD+LHfFvG2TjLm3SJ3G2i0MfunKyFLs=;
 b=gE9G7c/Hb0VAGHGW8BKTyVZrcAF9CImJAv9tIClRzg7RIQbKSaFM3/iV6xNN8lRMCC
 1VQVUx8CvLYISqx4tpfMv2caGSyUGuhoMz5s6BN7gbiXgrpDI09NMtF+scpStPAHPPk4
 JQVDctdb+zX+nqm/yvJ7MAPe1AXng5QDH5m6TtIOEC/rc7jdkGsxijRTGAbO/clv3/sY
 P6OBx6kHToeHT6WOKmzCUGk4W9WtJMkCSW52T22NhQwH20s6BOiGvoQZXa+yj1PRqEFV
 iV+VFE7Gu/s2+RMmXJ6yzkYhRllWqNeWcBXOsaGGLL5WAuO8xwdd9JLme4aGGYwUnhF8
 Y3og==
X-Gm-Message-State: AC+VfDxWqk9sjztICuyiz10vW1mrgYqMTwabgNrKrIKfxRmslt/O+wFq
 qQrhDGOls/AVFo+8bcWhrjG20g==
X-Google-Smtp-Source: ACHHUZ5YUf9Pc2z7Ru43a/ga3iT6wg7eVySD1P1/WZZhe4mC/RKmOBI4W7nLzILe8rLTfbO/V9FttQ==
X-Received: by 2002:adf:edd1:0:b0:311:3ce9:c9fa with SMTP id
 v17-20020adfedd1000000b003113ce9c9famr24936345wro.3.1687882024100; 
 Tue, 27 Jun 2023 09:07:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a7bc3cc000000b003f604793989sm13855945wmj.18.2023.06.27.09.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD5531FFBB;
 Tue, 27 Jun 2023 17:07:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 09/36] tests/docker: add test-fuzz
Date: Tue, 27 Jun 2023 17:06:33 +0100
Message-Id: <20230627160700.2955547-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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


