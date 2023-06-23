Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047C73B714
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:24:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfo8-0005Be-QJ; Fri, 23 Jun 2023 08:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmu-0003o7-No
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003ia-LU
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f90b4ac529so7560935e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522867; x=1690114867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIzjiTDV01K3tkp9aXGFv1lByMVRceW6OmvT/ZDu2SA=;
 b=jhhD1kzf5GakGGS11o9Xgpc+TvzmOHE/Dhkelon8pHh7LnhjVSV1STLaDM8aePaa1M
 9KTEOloK7AwkYNphOeoU69nbmva/S+D+y8kj3YF66v3EMC37wNn+gFo9SfWZmzszeASy
 pvlAtwW6M3XykOKVXirNiehROQDZuT0rm73ahOD/2nsxtHm0LoaRhYVcK7SzYbLdMYuU
 y6f4owTMdEy9VvlraZeMccU5JVV4p7JZhmwrhA3yDxe/gT2tdw9fd/euPXsZpSa66hRf
 o5s3Z5DnkM493kKxHQ4PX2kLB/1DGjfLcwkqie952ESeZWAdyao7BQohqLUAzNBFQDtG
 qNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522867; x=1690114867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIzjiTDV01K3tkp9aXGFv1lByMVRceW6OmvT/ZDu2SA=;
 b=i8aSKJoLa/qwC8H1GSuSoXEtCCD4ywmDhaUNEuRYs71mN521qkKltM8O41Lng4gXl5
 2k37DOu4dAL41axytXBc+VczP9kPKGP7pQ4hBapke64SzGJx4P87us3/G351wVFA9NWo
 Cuj2STHTVB3+qHOgDdP8Z4TQw/qzc/pMizuN6kuZzVDik7VWCtBvOwGMgallNzmyIBw/
 O6y+NxDjBsCTCaCVxfrpH0yCgUvJz982MEKgnp6bkqprmDSkZFs9tivKFC5hXzLYx+UO
 UsbFLq6qjPwjX1dVOTYAQ2Kdovbooa78+SitKBL9BiUaDWGoqvopP5JFKbbD/QCdcTPL
 tc/w==
X-Gm-Message-State: AC+VfDzTCwgl+eo9tAI32dJlz87p+JjW+neYhAo2/R8R6tASt3ssd/OK
 qW2/OpALvc2hzbkyXMWx2uNOKw==
X-Google-Smtp-Source: ACHHUZ4Z9SL9K3C7Y0+azq+7hTMJ59bQiN2YtfMIcfYOedeRbz3KJalmgIF1NKiD/oIunTVug/XHIQ==
X-Received: by 2002:a05:600c:231a:b0:3f9:b430:199b with SMTP id
 26-20020a05600c231a00b003f9b430199bmr9968001wmo.15.1687522866933; 
 Fri, 23 Jun 2023 05:21:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a7bc4c7000000b003f7eeec829asm2259310wmk.10.2023.06.23.05.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9582C1FFBC;
 Fri, 23 Jun 2023 13:21:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 10/26] tests/docker: add test-fuzz
Date: Fri, 23 Jun 2023 13:20:44 +0100
Message-Id: <20230623122100.1640995-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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


