Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A68740072
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:10:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBDp-0000HI-4G; Tue, 27 Jun 2023 12:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDm-0000F3-4B
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDf-00059V-TT
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso18785635e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882026; x=1690474026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOV9EOnx/XHsK7XQyMJxy5drdvS9UgZO7Cmh6YX5vFY=;
 b=m2UGK/LPjBVqZRqDoiLh/23KpnLshfWe0xR30ISl3pnrdG1HCeVgRdBmKFyeewWL3y
 5IRZHCXLJVad3Kj3GpO27m87K2f6CKBIZRA2uPW9MxA+Ypu5GEmxkL2cU1dtYUdanofV
 yP5e4qFeEHHvbKrICBoHo82rjaINN3AZEf6s4YrT3HQMXcHDOfzqGlsO9ScncM7cDbSn
 A3A8p2CZUkcEYF0fdL1+zPuVbqRGVMa/wbUkAJ2bkcIF+Hk4XiQAnYB6fBLAV7qMe6Wl
 gdBHv67UTV0I3tNyTUIQzwwBBxQEQ1dffyJVCFnCaMSIeRACWj1keJ/weMIiiouZ9nDe
 /q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882026; x=1690474026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOV9EOnx/XHsK7XQyMJxy5drdvS9UgZO7Cmh6YX5vFY=;
 b=iEp7c/dCZjXKI3uh8AdjNZSVsV3rmp40zHap8J8I7h3HWH3/3OivwQQGddZ1PAVrnT
 n8x5+cQJYXLVfwAjOTPTm/2ue0AxsKHr/oGQIRrGsWPWKQbnSopk/oNuZYnFi1UOOF9A
 AmV5OMVbwnXX3nJODjQwj0Gzp2uLyPp2jsBnhrrEAOQt85M3BZMQWRIYo/hKiJX6OuWT
 vR4hA2Zld/JVon4QtKQnNumzeKe7WRRNfjSAdTNE6NuaNWWf5NJtWFYaLvxZcRtK+u6e
 h+YTJAqWAnU+r4e67+th6V9qsUn1JaRdvh+z6PpAO334zMPmJIpVPbgIRcojwPSbJlN8
 62cQ==
X-Gm-Message-State: AC+VfDxoCRvgJqVosJdooY64InGNrL5FPcB8fsUKE6hE7mpXoyawYccc
 DGW9w1CRxJfk+CaeQMEvfleX6w==
X-Google-Smtp-Source: ACHHUZ6J9tPJGUER6lF3ti8eAeGu8rOx7qUnbhzcqmM/+b0tk+Y241FfgMr5VOA2d+Q6YmrAeVvN0Q==
X-Received: by 2002:adf:dc88:0:b0:313:ee3e:50c5 with SMTP id
 r8-20020adfdc88000000b00313ee3e50c5mr6467081wrj.20.1687882026330; 
 Tue, 27 Jun 2023 09:07:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a5d4579000000b003048477729asm10824061wrc.81.2023.06.27.09.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 009E91FFBC;
 Tue, 27 Jun 2023 17:07:02 +0100 (BST)
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
Subject: [PATCH v3 11/36] tests/lcitool: update to latest version
Date: Tue, 27 Jun 2023 17:06:35 +0100
Message-Id: <20230627160700.2955547-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
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

We need this for the riscv64 and gcc-native mappings. As the older
alpine release has been dropped from the mappings we also need to bump
the version of alpine we use.

Message-Id: <20230623122100.1640995-13-alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/alpine.docker | 4 ++--
 tests/lcitool/libvirt-ci               | 2 +-
 tests/lcitool/refresh                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 0097637dca..43370f7b36 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all alpine-316 qemu
+#  $ lcitool dockerfile --layers all alpine-318 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/alpine:3.16
+FROM docker.io/library/alpine:3.18
 
 RUN apk update && \
     apk upgrade && \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index c8971e90ac..b0f44f929a 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit c8971e90ac169ee2b539c747f74d96c876debdf9
+Subproject commit b0f44f929a81c0a604fb7fbf8afc34d37ab0eae9
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index f1570b54df..5d36a62b10 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -115,7 +115,7 @@ try:
     #
     # Standard native builds
     #
-    generate_dockerfile("alpine", "alpine-316")
+    generate_dockerfile("alpine", "alpine-318")
     generate_dockerfile("centos8", "centos-stream-8")
     generate_dockerfile("debian-amd64", "debian-11",
                         trailer="".join(debian11_extras))
-- 
2.39.2


