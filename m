Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBFC7441CE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIU1-0008IE-SJ; Fri, 30 Jun 2023 14:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITu-0008Gz-Ki
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITr-0006y8-N0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc244d386so17432945e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148266; x=1690740266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRLND/FsJP/7sFVhRXujI3BG1g81af0/qiaTT1E8hck=;
 b=oyBMZlpDSBxckYDa7f5eSaZ6VDlXW0xk6+XnXPl9sUWEJalNR0LgK3MwdRWZ9QiZ4P
 7klpbwwESHVP7g9Bl6oEvJZyUkH8I8vdCdE54+dit/8fb9tgmFAXKo23G+GQpnMhkCkM
 DUNBa8B7VC00GPTjK/jUsBXqfwZdD5LDFhWp/ekx4OKxA6cEhcRAAeEOexnqPnhpcfJ9
 S5FbGypbjKKr5oRPQWPGFXDRHMxyzyXE0uECckMps3KPer/Frrzsiz9zGzWqdCM5fJwb
 2+is+7c/izXRaVNXI2m2/wvjwiG2lcRp3LYGU3pgUu8OBVyAjjFhcIwJUEUF3qrb4XxK
 AwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148266; x=1690740266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRLND/FsJP/7sFVhRXujI3BG1g81af0/qiaTT1E8hck=;
 b=MVBBw0ijKKi3aOPGABe/sN8eU3VP7jYOx7aU05GBo12k8SuD9zil2aEKp4ba8mjgRs
 otlWhNWg2mF5ReApES4j65KAdoqQNpsXR+nmyhpHbeVflhb0yFUq1fv9kf6o7qoeN5TS
 +S6ak7b9wDiKzJjrK+eDi6FUvlKw6ZsuRyt4KjBN2Vw6fn/Hhvu7dQjyXSvKKI+MjB4U
 rHCLxXqJQ0QOG+7KajEMmwanapxYnGiKLvP1qzJWK5UFOevIpq+QFB9Es0vXBhFl4kMm
 pze0/CyTmW1ld/gEdcFrV9VhOvhB4iANRGz+ckOUpWdfNZ2w9DpXMRjLGm2dNeHoz0+C
 ad3Q==
X-Gm-Message-State: ABy/qLaTgrXn64dXDih9+U03VqnW4YKNrLOXh116Ma0Et+T2jLCwjOvJ
 UbpogsRCJAdVEZql2P6mFjiPAA==
X-Google-Smtp-Source: APBJJlFPySXZ7rcpZWXB9xr7u8t7L2EPtZp7eELOMCz6zC2k8wm5ACsBSV8/MT0fS88JefwyRBgQ7Q==
X-Received: by 2002:adf:e6cc:0:b0:30a:e9cb:1a2e with SMTP id
 y12-20020adfe6cc000000b0030ae9cb1a2emr2538200wrm.65.1688148266147; 
 Fri, 30 Jun 2023 11:04:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adff306000000b00311339f5b06sm18754525wro.57.2023.06.30.11.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:04:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F3B41FFBC;
 Fri, 30 Jun 2023 19:04:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 01/38] gitlab: explicit set artifacts publishing criteria
Date: Fri, 30 Jun 2023 19:03:46 +0100
Message-Id: <20230630180423.558337-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

If not set explicitly, gitlab assumes 'when: on_success" as the
publishing criteria for artifacts. This is reasonable if the
artifact is an output deliverable of the job. This is useless
if the artifact is a log file to be used for debugging job
failures.

This change makes the desired criteria explicit for every job
that publishes artifacts.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230623122100.1640995-2-alex.bennee@linaro.org>
Message-Id: <20230503145535.91325-2-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest-template.yml  | 4 +++-
 .gitlab-ci.d/buildtest.yml           | 2 ++
 .gitlab-ci.d/crossbuild-template.yml | 1 +
 .gitlab-ci.d/crossbuilds.yml         | 2 ++
 .gitlab-ci.d/opensbi.yml             | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 5da61f4277..f3e39b7eb1 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -25,6 +25,7 @@
 # rebuilding all the object files we skip in the artifacts
 .native_build_artifact_template:
   artifacts:
+    when: on_success
     expire_in: 2 days
     paths:
       - build
@@ -53,6 +54,7 @@
   extends: .common_test_job_template
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    when: always
     expire_in: 7 days
     paths:
       - build/meson-logs/testlog.txt
@@ -68,7 +70,7 @@
     policy: pull-push
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
-    when: on_failure
+    when: always
     expire_in: 7 days
     paths:
       - build/tests/results/latest/results.xml
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index aa833b62ca..24bba061cd 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -462,6 +462,7 @@ gcov:
   coverage: /^\s*lines:\s*\d+.\d+\%/
   artifacts:
     name: ${CI_JOB_NAME}-${CI_COMMIT_REF_NAME}-${CI_COMMIT_SHA}
+    when: on_success
     expire_in: 2 days
     reports:
       coverage_report:
@@ -587,6 +588,7 @@ pages:
     - make -C build install DESTDIR=$(pwd)/temp-install
     - mv temp-install/usr/local/share/doc/qemu/* public/
   artifacts:
+    when: on_success
     paths:
       - public
   variables:
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 6efb0d2a54..d97611053b 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -55,6 +55,7 @@
 .cross_test_artifacts:
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    when: always
     expire_in: 7 days
     paths:
       - build/meson-logs/testlog.txt
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index b6ec99ecd1..84ff2f6d2b 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -169,6 +169,7 @@ cross-win32-system:
     CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
                         microblazeel-softmmu mips64el-softmmu nios2-softmmu
   artifacts:
+    when: on_success
     paths:
       - build/qemu-setup*.exe
 
@@ -184,6 +185,7 @@ cross-win64-system:
                         or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
                         tricore-softmmu xtensaeb-softmmu
   artifacts:
+    when: on_success
     paths:
       - build/qemu-setup*.exe
 
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index b4d7eef688..fd293e6c31 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -63,6 +63,7 @@ build-opensbi:
   stage: build
   needs: ['docker-opensbi']
   artifacts:
+    when: on_success
     paths: # 'artifacts.zip' will contains the following files:
       - pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
       - pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
-- 
2.39.2


