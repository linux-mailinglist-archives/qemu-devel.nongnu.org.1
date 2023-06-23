Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9573B72B
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfoO-0005Yk-5M; Fri, 23 Jun 2023 08:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003kY-Pt
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:12 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmh-0003fz-Jd
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31121494630so674757f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522861; x=1690114861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14XP3klDtGmdL/A+tboDM4nxojyBPPw/sAoLndlO5fo=;
 b=i9zsfYZBvIzgFeP7qxWS5QB0nDa5FDAmiHdxir0lZclnW+GiJDK/e/GCA5rmXGI9av
 Gq6DSAT1KjnpNPryWxmtRMPaKHsgkAxZUViK5Mz1UTEZ5yg7l5b371nOiAdl/8AhTT4L
 AL/YnJ9mCBFwm6HXZ9HPgsEC2HX398ENBQQVIbvix4ijBf+1+v+ftVIPz/WQUSWTwh4p
 X0ahuSZEhjNEz6GHMFoqg6saytYp75p8UeRW6prRA8hy5J1XIx8EOfxBZHwUNrGP0/U4
 epQetrfP1SmCQBl0Yv6wJY8iZga1LOqplEN7OR104iQZojDAwOnf4Onwawmi0XXP8viJ
 PbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522861; x=1690114861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14XP3klDtGmdL/A+tboDM4nxojyBPPw/sAoLndlO5fo=;
 b=OaYjY8jwossUcrePVax8wmdR2q6QoeAcS9Hv4KXhJvV7aZ+yUTayxTgrVJqNtbi1BY
 5MHsrXFfzfwBcWI9gkDeOjohXlwnwvLEATK704k9vDnYS7tgUl4W+N61t7D1+g//ieWQ
 /e1EQZ+Sxrf3BZPv4BWN/MAoDNlRmf+fJJDBsgxNURUx529N4iPJLYqeprafvAhThzaC
 C4XafijKvXOHWS+bQdbbdjBg2KfFVLs/8KCZvE31Bfkxv99WMNHSQ/gaTAiRim5/vmfd
 5n0jPOjK1cS7B70wQgXLRrpPW+H7M12PTt1ifltgise+CqfTOqhkfPeTXvwEFI8UW+YM
 LjkA==
X-Gm-Message-State: AC+VfDw6YI3LeXEWbSBYRdamjSLdGYcnPfbDrSmAiq2sfX+gbtjlHplB
 y+Q63Y1SBmF9UivIPfZzrocCiw==
X-Google-Smtp-Source: ACHHUZ4fKjFIwTkMqpnQ24PWDmFdZwHy+XlzmMs3dGxrT9RNrXycJ0MEctu2/ag2Q4Hd1Nhf8E7szg==
X-Received: by 2002:a5d:4909:0:b0:30f:bf71:501b with SMTP id
 x9-20020a5d4909000000b0030fbf71501bmr17891794wrq.61.1687522861500; 
 Fri, 23 Jun 2023 05:21:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a5d4a8b000000b0030fb828511csm9372613wrq.100.2023.06.23.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A82981FFBC;
 Fri, 23 Jun 2023 13:21:00 +0100 (BST)
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
Subject: [PATCH 01/26] gitlab: explicit set artifacts publishing criteria
Date: Fri, 23 Jun 2023 13:20:35 +0100
Message-Id: <20230623122100.1640995-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
index 76ff1dfcb6..c1251e4805 100644
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
index 1922caf536..fcaa3869df 100644
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
index 4f93b9e4e5..a7e34e0145 100644
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


