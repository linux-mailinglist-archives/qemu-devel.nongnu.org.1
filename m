Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52641822051
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 18:24:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKiTy-0003rl-NN; Tue, 02 Jan 2024 12:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKiTe-0003rH-Es
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 12:22:55 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKiTb-0007mN-FJ
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 12:22:54 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-556275957ccso1966575a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704216169; x=1704820969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAoj0TA4KqBMNcpSaaSjXBSSHdPTkOJM7O7ccsF3S+M=;
 b=t8MjPiUmqrAbP1+XM+OGyi7HRCU7kyU+xsNtjX5OgyDYhDz3ODtGWQkScBhjuIEiPm
 DlFRFK4PgYbqOcMlD1Wt0Z2yJ1Vvu9SNht2pNBR5zbUoCujI8ldxDHCxk3+LoOtL3fWh
 Nf3afZcFkYcqyNEpuBNlQUCnSK4/JilSteBgB6NLpSEbUxmGPRvInx7iCp1ckMOUlFWS
 ORTjaTikbTyG1gAJVTb301x5m0Lno/r2PJnifw9hJCuH91trOAxSHJxrAY7DcQZGzhZT
 wOh34mTFVIhzohhqvC73lYPLhyMKBPRSzdrXyDYmiwJE59zyNxCAsmvS3wuEIBAihCfN
 VP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704216169; x=1704820969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAoj0TA4KqBMNcpSaaSjXBSSHdPTkOJM7O7ccsF3S+M=;
 b=fwNSt9DILfh/kKyR9jCU0wuJCESoebgUem3G4Z467phQ3zuka0rlLFKQ6SIu+YksvW
 DdEzDesFk1oRXbZMjUrxLZWMV7AP0OkSRwmPi84sAlmoDk8VPNo2diGHy1pq+YYX260s
 Kfj7LK17ghWQ/er4y9bwTKo+mWqGeD9ZV7RC10V92fBQ3OlvD8Q3Gl4RjIa5m/p3uR+7
 AmKYu4EeH6WIPOfpp2bExNvzJCTVhBUfoQzi/QYmoxSEuAMdEnvn8HLJyrlwwcmetAwS
 xwa7FzJD0i9qJ+9R7cb3AKVLp49j9VoMKKOccWkG+coeuH6xWvcAEFbExz+vvNJ3Tes7
 NtNg==
X-Gm-Message-State: AOJu0Ywj/ySU7rYezH+1br5hciQ6YIlGz4CerEB5jLIN8eFA1Z7Cyz6e
 19fjIG5Gail2DE6BwIXMHYZO0Va6EQ+Wv5vmVs6Vhcrz9Ro=
X-Google-Smtp-Source: AGHT+IH7qCwiEfi6NLNQXPinXjj0XPypl3KAAt0Ia/O6sccWpZ6AFiGDYllof/wSrRYnMk28r44Shg==
X-Received: by 2002:a50:9fcd:0:b0:556:6abd:c301 with SMTP id
 c71-20020a509fcd000000b005566abdc301mr1026365edf.68.1704216169436; 
 Tue, 02 Jan 2024 09:22:49 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 s20-20020a056402015400b005530cb1464bsm16098188edu.15.2024.01.02.09.22.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 09:22:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>
Subject: [PATCH 1/2] gitlab: Introduce Loongarch64 runner
Date: Tue,  2 Jan 2024 18:22:38 +0100
Message-ID: <20240102172239.69452-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102172239.69452-1-philmd@linaro.org>
References: <20240102172239.69452-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Full build config to run CI tests on a Loongarch64 host.

Forks might enable this by setting LOONGARCH64_RUNNER_AVAILABLE
in their CI namespace settings, see:
https://www.qemu.org/docs/master/devel/ci.html#maintainer-controlled-job-variables

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/ci-jobs.rst.inc                    |  6 ++++++
 .gitlab-ci.d/custom-runners.yml               |  1 +
 .../openeuler-22.03-loongarch64.yml           | 21 +++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 .gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml

diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index 4c39cdb2d9..b821a33112 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -189,6 +189,12 @@ used as a gitlab-CI runner, you can set this variable to enable the
 tests that require this kind of host. The runner should be tagged with
 both "centos_stream_8" and "x86_64".
 
+LOONGARCH64_RUNNER_AVAILABLE
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+If you've got access to a Loongarch64 host that can be used as a gitlab-CI
+runner, you can set this variable to enable the tests that require this
+kind of host. The runner should be tagged with "loongarch64".
+
 CCACHE_DISABLE
 ~~~~~~~~~~~~~~
 The jobs are configured to use "ccache" by default since this typically
diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 8e5b9500f4..152ace4492 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -32,3 +32,4 @@ include:
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
   - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
+  - local: '/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml'
diff --git a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
new file mode 100644
index 0000000000..86d18f820e
--- /dev/null
+++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
@@ -0,0 +1,21 @@
+openeuler-22.03-loongarch64-all:
+ extends: .custom_runner_template
+ needs: []
+ stage: build
+ tags:
+ - oe2203
+ - loongarch64
+ rules:
+ - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+   when: manual
+   allow_failure: true
+ - if: "$LOONGARCH64_RUNNER_AVAILABLE"
+   when: manual
+   allow_failure: true
+ script:
+ - mkdir build
+ - cd build
+ - ../configure
+   || { cat config.log meson-logs/meson-log.txt; exit 1; }
+ - make --output-sync -j`nproc --ignore=40`
+ - make --output-sync -j`nproc --ignore=40` check
-- 
2.41.0


