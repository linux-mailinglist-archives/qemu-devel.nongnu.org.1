Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9F27BE6C6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptM1-0000pe-G0; Mon, 09 Oct 2023 12:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptJx-0005IS-FE
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:41:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptJe-0001Uc-4W
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:41:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-406618d080eso45689115e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696869668; x=1697474468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zh7N0HFTIxBax5KXX0zczKhvUC5xK1l1PfGLSBYFHwc=;
 b=PwcDzxltD5YR3ShAQzhz1eilmfTYm+45rVXlqOy5QEK22HJ6XkKQg6F/fwvpa0lFhQ
 r4EnyvkmDC0sEQcNLlpbpOFo5Ucb+AnkUbfTfCfpEA7lbpmwTNdzb2uUlCsFiL6H06cf
 4g3XWhP9r6dlYIeJimRqK2FuXmfr/QQ3mluXWvgGflcH7f9F/gerNLzzD7BfdqGKwDa0
 vxCynn1Hf0BCWK8mvwkjt/wiWdQAQWvh3g3pmXMbYvDL7jpRNGt0t/lee76Ahw78N/SA
 YPmoQ60Ce5N0OYuPjULpVZmd0fNE2WPqxXEpYvE1OGj2tXHuz47wrl6CbWsNUX3+fJ3N
 JPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696869668; x=1697474468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zh7N0HFTIxBax5KXX0zczKhvUC5xK1l1PfGLSBYFHwc=;
 b=P65HRzrgfs3PT2EgvLh/KbOGb94FGSrykHiySqf8nk3d+VP+B4QU6JmxsTWaYJcWtW
 pb9ffyi44qNc+bTAnTDl2GABjEE2SrK5yICpAiv9BKCIh9OZSXuJaskpRP6u8zqlTbyy
 9JAXG90q3SMlKauZzwS5mjcKHpHu68U7cl8m0MUyq74DLMw57mEpVpHZlwJXjrD9b9aH
 9BKLBmEdLJB8X1T6DUcnEu6v//a2fQKvf9AP2AigWEtQA2Gi7JT1/HCJ0LOSJqyPCRRs
 ILmx2O/7Uc9aO23s3PdzIDugzrW8PAXk3HbaTvqw8GTnAqrNfpfU6fAUrH+4wQul2zf4
 DA/Q==
X-Gm-Message-State: AOJu0Yx2THfDpBjCt1nbdCWrXHXXPYnsYm64YZsSSNJu0rWJD7agdG+C
 MLHHmJ2teSjbjokFtmzZv1/fOQ==
X-Google-Smtp-Source: AGHT+IEfvpth34gShkKuZ4bLW33Yj6ccahuIdxlYiCiJmwuZcXoUGwKBzSDnzJA3mFDUg19ehbM0Hg==
X-Received: by 2002:a05:600c:2317:b0:406:6964:7e96 with SMTP id
 23-20020a05600c231700b0040669647e96mr13462745wmo.13.1696869668212; 
 Mon, 09 Oct 2023 09:41:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b00407460234f9sm6145168wmo.21.2023.10.09.09.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:41:07 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BDDBC1FFC0;
 Mon,  9 Oct 2023 17:41:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/25] tests/docker: make docker engine choice entirely
 configure driven
Date: Mon,  9 Oct 2023 17:40:44 +0100
Message-Id: <20231009164104.369749-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164104.369749-1-alex.bennee@linaro.org>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since 0b1a649047 (tests/docker: use direct RUNC call to build
containers) we ended up with the potential for the remaining docker.py
script calls to deviate from the direct RUNC calls. Fix this by
dropping the use of ENGINE in the makefile and rely entirely on what
we detect at configure time.

We also tweak the RUNC detection so podman users can still run things
from the source tree.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add RUNC stanza suggested by Paolo
---
 configure                     | 1 -
 tests/docker/Makefile.include | 9 +++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index e08127045d..707132a3ae 100755
--- a/configure
+++ b/configure
@@ -1694,7 +1694,6 @@ if test -n "$gdb_bin"; then
 fi
 
 if test "$container" != no; then
-    echo "ENGINE=$container" >> $config_host_mak
     echo "RUNC=$runc" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index dfabafab92..ab68b2dbad 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -16,9 +16,8 @@ DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
 endif
 DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
 
-RUNC ?= docker
-ENGINE ?= auto
-DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(ENGINE)
+RUNC ?= $(if $(shell command -v docker), docker, podman)
+DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(RUNC)
 
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
@@ -158,7 +157,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 )
 
 docker:
-	@echo 'Build QEMU and run tests inside Docker or Podman containers'
+	@echo 'Build QEMU and run tests inside $(RUNC) containers'
 	@echo
 	@echo 'Available targets:'
 	@echo
@@ -198,8 +197,6 @@ docker:
 	@echo '    EXECUTABLE=<path>    Include executable in image.'
 	@echo '    EXTRA_FILES="<path> [... <path>]"'
 	@echo '                         Include extra files in image.'
-	@echo '    ENGINE=auto/docker/podman'
-	@echo '                         Specify which container engine to run.'
 	@echo '    REGISTRY=url         Cache builds from registry (default:$(DOCKER_REGISTRY))'
 
 docker-help: docker
-- 
2.39.2


