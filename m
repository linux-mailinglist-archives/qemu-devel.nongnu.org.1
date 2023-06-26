Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282873EBCD
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 22:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDsmE-0005eB-Fp; Mon, 26 Jun 2023 16:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsm0-0005aP-Pe
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:22 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsly-000550-Kh
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313e12db357so4046618f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687811117; x=1690403117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lp6KR88j71QtkzhoL0VNQhU+0wKLrKZSfG0XhX5V00g=;
 b=YNUvfeAsZnV6/D+m7nIKOhHvM//ambdKCHNu2NuJLqSCW6R7qjNRtBh8+1Gbbju8je
 59akoxOgEOFIczhZCF5+VbHdwqnrEYHtPLAQkVcd8+1boQPAqo2RouW8Qw9Fq6zotyC+
 TLOzwMpx/6hrBqKeiqqp3gyJO5XyDfOUduBi7VhiVr7USBEZCFZXkASoO1FLaQp5zGOo
 aZFY7OD6J5kyuwO7TjQMUY1o8t42EOwP66Vr+1SWi3ghxfn9kJJ1LOc+ZNymLFWeK2kK
 3ypSMtE8kDpX1jaY57KCTDRryZuhgzixifvPbu5RzteEZh2kSemD0yhYTTl4qKRlzxRL
 NLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687811117; x=1690403117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lp6KR88j71QtkzhoL0VNQhU+0wKLrKZSfG0XhX5V00g=;
 b=EyRpdKxPB0T95ya3clLVxIziLbQLBdluhPWOGkEiLv9vdbII8K6rhIC+DwnEMkT3BO
 3DP3jMoTKbp1GYObB2L0uNp11pJov1DxK16mpE9wEnCavHES7p54mNGICb85K0cCmgJE
 BYa5+/LwAFomDY4N0BuT/GFne8a7mvXmw+9X7l35JLscjc24V5u8OQGFf/Q5///XlDvK
 5ZwcLvBq94BrWzabRAUCjBLivhiHVov9xcamaUOSROrBz0WI5kh7jvEytGZfABcPVDLl
 lSu1mu6fiWonAkbGqIyQwnAQX8qwnlUF/D5W+l/SCtzWRnfDMTJyewp+rJBS2aB/9ryR
 tRcw==
X-Gm-Message-State: AC+VfDyF3+wRaOkmgTnWgYe/pGLZAsBR61bb7aLnbaUVX1EBhTD8hx3v
 H3aY6SBRCxNUnBoMQUQEQmLyUg==
X-Google-Smtp-Source: ACHHUZ5417vKcdfoQDXWpn45rLUWM3KElM+aZCLyvqw37LblVv1hJGTKdujRMn7ebfnvK4HAjnLgGg==
X-Received: by 2002:adf:efca:0:b0:313:f6fc:1f48 with SMTP id
 i10-20020adfefca000000b00313f6fc1f48mr1804084wrp.14.1687811117190; 
 Mon, 26 Jun 2023 13:25:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d6102000000b003127a21e986sm8193795wrt.104.2023.06.26.13.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 13:25:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3FA4E1FFBC;
 Mon, 26 Jun 2023 21:25:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Qiuhao Li <Qiuhao.Li@outlook.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cleber Rosa <crosa@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 1/6] gitlab: explicit set artifacts publishing criteria
Date: Mon, 26 Jun 2023 21:25:10 +0100
Message-Id: <20230626202516.2507915-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626202516.2507915-1-alex.bennee@linaro.org>
References: <20230626202516.2507915-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
index 1e0e6c7f2c..34f9df2be9 100644
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


