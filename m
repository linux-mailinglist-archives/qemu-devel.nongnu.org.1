Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C944C73EE2D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFK-0002fm-M4; Mon, 26 Jun 2023 17:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFE-0002ac-Vf
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:36 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFA-0004rv-Da
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:36 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fb5bcb9a28so2594030e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816771; x=1690408771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIzjiTDV01K3tkp9aXGFv1lByMVRceW6OmvT/ZDu2SA=;
 b=arsa3zJuB8XBMBg8nGs4O26+56wGfrTF05JJULFWLegP/UbPUp1dzrkKU3xmkWUR1H
 vCJ5I+LjvoEEeSIKXcmc+M0xMRzqUxwfI2BPZd8joL/WsfSt6IOy9o2G3Uq3j7rMLM23
 SbWHwKRoiIrw3j1PTVWRVTmLF1xBjN3mkbahkCzKIWmrbnaDVdaw3YiOUR9ej1H2/E3z
 dt+otFq/xYP0quS3t/nos/ebclahFp+37WGJ4jxcABoQmq1ZfLlgmC5s+cDHq1C5XuHr
 GXbJboXAkRUuA7CFkcx8brYK4VAXyy4zJ71IkRbVl5rsyuzAgtp+/ix6D1+KvyqiXX9a
 YvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816771; x=1690408771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIzjiTDV01K3tkp9aXGFv1lByMVRceW6OmvT/ZDu2SA=;
 b=GN5osk0VYiIgAM9klAG0Wk0y6bG5K7UoT/BPD8EpJBevB71Vg7rqJ8xSzLA3pFa7P8
 Vn/r0DfUK5UC9veOd1cI7erWPdCxTusV/c12kg7SoNvzArqXXiXNE+j4IVyQpJcyI60I
 WVEwG/eTXCvitahP+XzMTpCFnyN8/F2ESzom6WJytF4bjH0bnf1e/UIsMGU0xreLjz8U
 VhWMcwfOAwGUyHdJnfBPRiHnb+BSVwwa0N6JoVFitDtYwp2ewU802pKpigTcoYsV3zJq
 mbKvUvhh82tb1gQF2ZPMOOdTs8LZCX2E2onYxpH50JHjr1JVrRHCMF45S2jxfQlkvkiv
 jktw==
X-Gm-Message-State: AC+VfDzjpPFJ/ylE/1IOfdwFtYSoX1WwX3G3o23m9bD9YgIckbSxJF1K
 2fXvc2FxLG6QIWaBSTvhAj1y+w==
X-Google-Smtp-Source: ACHHUZ4Y2ZM6Ok2ayZEcu7/Tj0vPqMjOUD0ErtWJjRrEDdHHtoJr+8NNfDlRu9IQgOL2VEfk/Se58g==
X-Received: by 2002:a05:6512:ba9:b0:4fb:83fd:f6a9 with SMTP id
 b41-20020a0565120ba900b004fb83fdf6a9mr82631lfv.7.1687816770751; 
 Mon, 26 Jun 2023 14:59:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003f50d6ee334sm8708659wmi.47.2023.06.26.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D0D571FFC4;
 Mon, 26 Jun 2023 22:59:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 09/26] tests/docker: add test-fuzz
Date: Mon, 26 Jun 2023 22:59:09 +0100
Message-Id: <20230626215926.2522656-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/test-fuzz | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100755 tests/docker/test-fuzz

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


