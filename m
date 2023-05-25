Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3660710A14
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28DM-0007mH-Sy; Thu, 25 May 2023 06:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q28DK-0007m6-Rs
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q28DJ-0000qL-G4
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685010536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPawskpfD7SUiGgqDedHsfmhvlO7a1fVJVETqHByam8=;
 b=gV7z+6rZiwoe9bU/ZNI1CRqvSbiEVGYzP5V2Xl+e/x70bWjdXD5DW49y/f5Qu0ykZRR1jn
 WsVHlYHMBwSMkCruxUgFGYTKUg/1Xhvg1GSP0+dB8a+fF3Upo34t42q7h0KRrRWXVn81tv
 TSZEs4zImpACCYpOJDZyOWvS3gzT9k0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-7h9mHx-EM7OVZ6hghFmcgg-1; Thu, 25 May 2023 06:28:52 -0400
X-MC-Unique: 7h9mHx-EM7OVZ6hghFmcgg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f4f1bb838so46624766b.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685010531; x=1687602531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mPawskpfD7SUiGgqDedHsfmhvlO7a1fVJVETqHByam8=;
 b=W+SHDBPlOfke0WVckROtPK1VY/hulFhL/9nCdjqo7WSQ8JvQExAC8sjspVpR1mbmD+
 ROscd+VJYOyQ8MOvZidLYbwPv6Juh664qPHtpi4ZONHq3/srwGDjFrpPu/xRJnv3pPKC
 ordZPYXqhb/nQmf328RXS444RuiwcPUE8bwD0i4gr+EJnJPJvVcLmCcMbWXOICprMt9Q
 hb7/R40gkOPIe+a/g+X0jhG6YBaYNYbLAGWp7KgioH7eEcXC7eP4T9bSHD6ail5aZyeK
 vVevl28S2f0f2BKbxfm3jERS95hhLOAZjHKmSToV3Dr59Ho+UCoFfCcL8Wv6N3n4e322
 in0Q==
X-Gm-Message-State: AC+VfDxIYC6Xw75YFLqPDmTEp4U9shWuxACwwAhy9qENTGTPvdsf3RqJ
 aZk90okGONYoK6Dof7/l9iWAX9zaHIanwewmOmx3VVEZ0p2mkqkJcwFjFjHnaLxNlONtnbpplg6
 g57LNBRyAIrdz+SBsAyF0TaWOuoyU7eyZxyY1535oQLaTYONNXFWe+NCpprywrVA8zbMd8Y6Puh
 M=
X-Received: by 2002:a17:907:6d06:b0:96f:9cea:a346 with SMTP id
 sa6-20020a1709076d0600b0096f9ceaa346mr991248ejc.1.1685010530799; 
 Thu, 25 May 2023 03:28:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+1BiVXLyl93V6BH0Q6MKdOnsBjC/4ByMkspveeB9uENyBQaTVtO86NT01b/gvnFVypNC3DA==
X-Received: by 2002:a17:907:6d06:b0:96f:9cea:a346 with SMTP id
 sa6-20020a1709076d0600b0096f9ceaa346mr991235ejc.1.1685010530355; 
 Thu, 25 May 2023 03:28:50 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 bt22-20020a170906b15600b0096f603dc8ddsm658157ejb.142.2023.05.25.03.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 03:28:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	jsnow@redhat.com
Subject: [PATCH 3/3] Makefile: remove $(TESTS_PYTHON)
Date: Thu, 25 May 2023 12:28:44 +0200
Message-Id: <20230525102844.209240-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525102844.209240-1-pbonzini@redhat.com>
References: <20230525102844.209240-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

It is now the same as $(PYTHON), since the latter always points at pyvenv/bin/python3.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include    | 8 +++-----
 tests/vm/Makefile.include | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5b838ec438b0..0184ef223737 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -89,11 +89,9 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 # Build up our target list from the filtered list of ninja targets
 TARGETS=$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-targets)))
 
-TESTS_VENV_DIR=$(BUILD_DIR)/pyvenv
 TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
 TESTS_VENV_REQ=$(SRC_PATH)/tests/requirements.txt
 TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
-TESTS_PYTHON=$(TESTS_VENV_DIR)/bin/python3
 ifndef AVOCADO_TESTS
 	AVOCADO_TESTS=tests/avocado
 endif
@@ -109,7 +107,7 @@ else
 endif
 
 quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
-    $(TESTS_PYTHON) -m pip -q --disable-pip-version-check $1, \
+    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
     "VENVPIP","$1")
 
 $(TESTS_VENV_TOKEN): $(TESTS_VENV_REQ)
@@ -131,7 +129,7 @@ FEDORA_31_DOWNLOAD=$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CANDIDATES))
 # download one specific Fedora 31 image
 get-vm-image-fedora-31-%: check-venv
 	$(call quiet-command, \
-             $(TESTS_PYTHON) -m avocado vmimage get \
+             $(PYTHON) -m avocado vmimage get \
              --distro=fedora --distro-version=31 --arch=$*, \
 	"AVOCADO", "Downloading avocado tests VM image for $*")
 
@@ -142,7 +140,7 @@ JOBS_OPTION=$(lastword -j1 $(filter-out -j, $(filter -j%,$(MAKEFLAGS))))
 
 check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 	$(call quiet-command, 							\
-            $(TESTS_PYTHON) -m avocado 						\
+            $(PYTHON) -m avocado 						\
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) 	\
             $(if $(AVOCADO_TAGS),, 						\
 			--filter-by-tags-include-empty 				\
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index c2a8ca1c175a..f0f5d32fb0f0 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -5,7 +5,7 @@ ifeq ($(realpath $(SRC_PATH)),$(realpath .))
 VM_PYTHON = PYTHONPATH=$(SRC_PATH)/python /usr/bin/env python3
 VM_VENV =
 else
-VM_PYTHON = $(TESTS_PYTHON)
+VM_PYTHON = $(PYTHON)
 VM_VENV = check-venv
 endif
 
-- 
2.40.1


