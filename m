Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A5872205D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:00:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6576-0004rl-IR; Mon, 05 Jun 2023 03:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q656s-0004qg-2J
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q656q-0001LL-6N
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685951915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLt3yt4KkncC5BZ28dsIIKYc4ne835xJoFgKxj2QqLQ=;
 b=g0GqTqQDBk/Q0Bo0GHx2e0PPkL1oumEqkBWLB8sf8EwIRbpWJfSZ3F5pBf5caQp36W7rkT
 y87KSCvt6Osr60ptx7gfBiuR4WbDSJE7iY030V78f9ll+olV+N6QGGEzADmccWj0CWougM
 R6TPCOpBuZ9LqfrCNukG1toLfqQGAbY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-Yf9NH4QMM5qT6lOUPAwgyQ-1; Mon, 05 Jun 2023 03:58:34 -0400
X-MC-Unique: Yf9NH4QMM5qT6lOUPAwgyQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977eabfc3ccso28177766b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 00:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685951912; x=1688543912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLt3yt4KkncC5BZ28dsIIKYc4ne835xJoFgKxj2QqLQ=;
 b=YLT748wlFo7KWqa+VBiGWKZ0du6cdqcztovHpv8nah7i5v4Cvd5YLIA797w+wY5lWS
 0XmVEP+Z2O8NXiGKQjWiXge5NAafXwvuzsjKflX+oKifxMjdZ4sE7QZTy4x1+GhNmFXW
 D07vVOr+pVMU4YTByBeB6VwDUiXAiKKFITyqCE9v2Ci1ufpoalrAk9YhbPFMlxZUEd5R
 cWQqMc8LLAnHiAoUIT9utjbe2Twqj/EnLXd7MnhHbZGOeUgNC2Zgo9KNYXHVzamrhT+2
 2Uruin+rikHkdEN4RvzVXg99GlC8zGGcCvZLUmrXUSkhmKrYwWabxbjnS2YFnUrec94I
 I7xQ==
X-Gm-Message-State: AC+VfDy5z2nOKjpTD69xLvSgeN6Z2UW508eGjIUi5BGrildO5f8sXwN8
 sgVx6WDIVtShAWj/imKX98RN+Mc0mHrPqQ9O6Gw4wjTKgtn8NgH6ix2vQH2OLGlzcujBsnmDoaq
 ANz/2oZ6ODfEKRfFmhOuBL427Yrz7mwdhkU93xgsIFg1xHtTMenl+bLLiqFp5qo5wSjQ4L6Agrh
 Q=
X-Received: by 2002:a17:907:d2a:b0:977:e95d:efdf with SMTP id
 gn42-20020a1709070d2a00b00977e95defdfmr460422ejc.29.1685951912311; 
 Mon, 05 Jun 2023 00:58:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CXj3NQfO5x10mInRk3eBKubsCZhBkxNKfzpIc8eBbGvpadcmiZIEFbkjS0KYNexUMPPpcfQ==
X-Received: by 2002:a17:907:d2a:b0:977:e95d:efdf with SMTP id
 gn42-20020a1709070d2a00b00977e95defdfmr460408ejc.29.1685951911928; 
 Mon, 05 Jun 2023 00:58:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a170906c40100b0096fc35ca733sm3971419ejz.41.2023.06.05.00.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 00:58:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 jsnow@redhat.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH 2/2] tests: update avocado installation to use mkvenv
Date: Mon,  5 Jun 2023 09:58:23 +0200
Message-Id: <20230605075823.48871-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605075823.48871-1-pbonzini@redhat.com>
References: <20230605075823.48871-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The recent changes to Python handling mean that there is a single
virtual environment for all the build, instead of a separate one for testing.
Because this virtual environment will often have system site packages
available, it makes sense to use mkvenv.py to install avocado, which will
avoid using PyPI if a new-enough version is available in the system.

However, requiring a specific version of avocado will cause conflicts with
any avocado plugins installed on the host:

   $ make check-venv
   make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
     GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/berkeley-softfloat-3 dtc
     VENVPIP install -e /home/berrange/src/virt/qemu/python/
     VENVPIP install -r /home/berrange/src/virt/qemu/tests/requirements.txt
   ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
   avocado-framework-plugin-varianter-yaml-to-mux 98.0 requires avocado-framework==98.0, but you have avocado-framework 101.0 which is incompatible.
   avocado-framework-plugin-result-html 98.0 requires avocado-framework==98.0, but you have avocado-framework 101.0 which is incompatible.
   make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'

so the requirements should use a ">=" constraint and the versions of
Avocado and pycdlib should be limited to what distros provide
in the system packages.  Only Fedora has Avocado, and more specifically
version 92.0, while the following distros have pycdlib:

   CentOS Stream 8             1.11.0
   CentOS Stream 9             1.11.0
   Fedora 37                   1.13.0
   Fedora 38                   1.14.0
   Ubuntu 22.04                1.11.0
   Debian bookworm             1.12.0

So the current minimal versions specified by tests/requirements.txt are
okay.  Move them to the check-venv target and add the corresponding
constraints to python/tests/minreqs.txt as well.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1663
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/tests/minreqs.txt | 3 ++-
 tests/Makefile.include   | 8 ++++++--
 tests/requirements.txt   | 9 ---------
 3 files changed, 8 insertions(+), 12 deletions(-)
 delete mode 100644 tests/requirements.txt

diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 1ce72cef6d8..6c9336ad119 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -23,7 +23,8 @@ distlib==0.3.6
 fusepy==2.0.4
 
 # Test-runners, utilities, etc.
-avocado-framework==90.0
+avocado-framework==88.1
+pycdlib==1.11.0
 
 # Linters
 flake8==5.0.4
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8294a44816c..82240d631fe 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1,5 +1,8 @@
 # -*- Mode: makefile -*-
 
+AVOCADO_MIN_VERSION=88.1
+PYCDLIB_MIN_VERSION=1.11.0
+
 .PHONY: check-help
 check-help:
 	@echo "Regression testing targets:"
@@ -90,7 +93,7 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 TARGETS=$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-targets)))
 
 TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
-TESTS_VENV_REQ=$(SRC_PATH)/tests/requirements.txt
+TESTS_VENV_REQ=$(SRC_PATH)/python/tests/minreqs.txt
 TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
 ifndef AVOCADO_TESTS
 	AVOCADO_TESTS=tests/avocado
@@ -112,7 +115,8 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
 
 $(TESTS_VENV_TOKEN): $(TESTS_VENV_REQ)
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(call quiet-venv-pip,install -r $(TESTS_VENV_REQ))
+	$(quiet-@)$(PYTHON) $(SRC_PATH)/python/scripts/mkvenv.py ensure --diagnose avocado --online \
+	      'avocado-framework>=$(AVOCADO_MIN_VERSION)' 'pycdlib>=$(PYCDLIB_MIN_VERSION)'
 	$(call quiet-command, touch $@)
 
 $(TESTS_RESULTS_DIR):
diff --git a/tests/requirements.txt b/tests/requirements.txt
deleted file mode 100644
index 07e713ef5ac..00000000000
--- a/tests/requirements.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-# Add Python module requirements, one per line, to be installed
-# in the qemu build_dir/pyvenv Python virtual environment. For more info,
-# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-#
-# Note that qemu.git/python/ is implicitly installed to this venv when
-# 'make check-venv' is run, and will persist until configure is run
-# again.
-avocado-framework==88.1
-pycdlib==1.11.0
-- 
2.40.1


