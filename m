Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B6745DB9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:50:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrC-0007cl-3w; Mon, 03 Jul 2023 09:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr4-0007TP-DZ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr1-0005hE-K5
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so41218455e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391872; x=1690983872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/2/UjZO5LVZdyjze7eK8CMBEgeqrfQyTKhD3ann+Ss=;
 b=aL4tMX547vLMqwHdyU2m767D1bE9axJA1AapZmOp64ZNnVPqDmGzZSFvcGL7iA7F2o
 Nnw1+lSqJfkqU4+3wUdErfCuggOskKnKS6qGyGSEznkgkq2QU6QZ8OW0vOfyiVrpJUHd
 QZOdjA5+b6+2DhQG/CLIBsFCE5rF3CkXlldCnUE5cRa4jrd5rSWJ1f+RMO08E/C5dbxA
 X0zh7XDOb/Vz7MwpLu9WUoic20/+dyF4IuhS4KjQzB/HLa+1gfXxA75LeZ5y4I9vclaf
 /Vw2QevodEcg1nFS5Skfzd1XMX7bpSfVadN4UGY0rzthC6MDtzn9PypDdPmLoUIQRcUY
 PnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391872; x=1690983872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/2/UjZO5LVZdyjze7eK8CMBEgeqrfQyTKhD3ann+Ss=;
 b=XAbE7rl5Ma+t9dRhpVGXmOSMD4RvGLVhSe2GIbjWvbM0yrOoPt0BgayU7z77JuukRk
 XtdDcvWMna9HQVeBBVno+nHQpXR8OdRcmUuzuQnLyIolMZR/UEdhkAJLcWDykiH0hCN2
 78yH41y3T26C0oIkPRQvoNtu4X/C7I7Oa5oES5I9TrP1we0xQwimQ+tsKkwkDu9JRI3Q
 IdpKQBH6TdAYkLBDaq4CC9qzbwdo/MAaXUxdi5ZFGaWvRrjyKegHDDbC6ksPzgx6QB+x
 9JoB9A5YLCnNBqAWjszoBME1Bzx54d4Pcc/I5H2FI8WBg5K5x0saFwFyCNnKz45P2huY
 ShSQ==
X-Gm-Message-State: AC+VfDw4DHWcVVR8Mp2ed9oZ/sLGMWR5Ab17l+R6j68UKzQa6M1inms1
 NZs/fGdO6avRyIezE4RwBpMV1A==
X-Google-Smtp-Source: ACHHUZ5JAuMCsDBTPZ//efmJh2gUcB44JuKBgiW28vPBIwVoGGPVH6W0dG3DnfhfhMpOrhIaUxJhLQ==
X-Received: by 2002:a05:600c:241:b0:3f8:fc96:6bfd with SMTP id
 1-20020a05600c024100b003f8fc966bfdmr8033857wmj.17.1688391872299; 
 Mon, 03 Jul 2023 06:44:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 cs7-20020a056000088700b0030ada01ca78sm25629348wrb.10.2023.07.03.06.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF49C1FFC3;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 09/38] tests/docker: add test-fuzz
Date: Mon,  3 Jul 2023 14:43:58 +0100
Message-Id: <20230703134427.1389440-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Running the fuzzer requires some hoop jumping and some problems only
show up in containers. This basically replicates the build-oss-fuzz
job from our CI so we can run in the same containers we use in CI.

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-10-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 4feea49a6e..7164cf55a1 100644
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


