Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF574009C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGR-0008Sk-14; Tue, 27 Jun 2023 12:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGM-0008A4-6V
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGH-0005o2-LD
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:53 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so5543324f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882188; x=1690474188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOV9EOnx/XHsK7XQyMJxy5drdvS9UgZO7Cmh6YX5vFY=;
 b=Sxik2LxI19zvXfC/z+8skLdpHU43rdZVQ0urzjDrTjsQaZ97+R+dCAFTjyf432cIA9
 QY99hcRnYsL1ZS11MwbtrcdOOde1AXwTiuTD6wkwmvdpvYsZnOKThZ+AoQ8Dd+D6k3Pi
 FocCT05kinZCFYSjqqDcXQviLLMiapllf6g3EVhmNXwXvm23DinZhC6abJ7kNiFHi5Mg
 lzrzq7PS0vJ6cMM2A+ZflfnY2U+nMEbtEeP4zIwwUY+hjgGZ7CeA/coogAnTp6IStAYV
 bgjfI8iMsdYCFtDKUrN5z9fydxeEbomHwj7Hj2rkHX0WcWdbFULjkW+vLvpGwUhMLrf8
 iM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882188; x=1690474188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOV9EOnx/XHsK7XQyMJxy5drdvS9UgZO7Cmh6YX5vFY=;
 b=Rc/LiQqHSIcdBV6OTd8Kf+7reUhI2WMOLKMrNQo2Dgzv0bRZj/YKtBRkVi2qPJlnmf
 XwyNasmibPF/xcRyqoPH1XmelbuyzzRluw+SjUPt6QijlPdoIsX/nlRL41CPXLsT06kg
 4+6HERsBrlPAciQ6gzibX8apuy0uYAPNVkkpSgVmhg+ZuANOuh6VEiBVJ1WyysUXMPw3
 KJU4nSWbxs8jexfXJ+F6zrqOr6YjMaEFK6w0c5RJSLGxHgqsW3On4Z6hA6AK4Seyh2ZR
 rUjPXj0i2JZ8YjjeRR0Dek5UiqVNX71Q4/D7fx6ehXKmm0GyVNlWsF31b4lImKvlybho
 mn4w==
X-Gm-Message-State: AC+VfDxLuqDYZufMpF4TdZmSz/BIfNmUhGi2VFHhJ3G37OS/3wDwVedI
 htGH0h0TB3Jj101hOSxfsJnw3Q==
X-Google-Smtp-Source: ACHHUZ6+6j83vbLbqJBonBSFPk0AheDHA7srkqdKQBg0vPM613uGRg9hj49fUUhhhYsCjE3KIN+90g==
X-Received: by 2002:a5d:5269:0:b0:313:f124:349d with SMTP id
 l9-20020a5d5269000000b00313f124349dmr4998232wrc.17.1687882187491; 
 Tue, 27 Jun 2023 09:09:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a5d6986000000b003047dc162f7sm10825408wru.67.2023.06.27.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B9931FFBD;
 Tue, 27 Jun 2023 17:09:45 +0100 (BST)
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
Subject: [PATCH v3 11/36] tests/lcitool: update to latest version
Date: Tue, 27 Jun 2023 17:09:18 +0100
Message-Id: <20230627160943.2956928-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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


