Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FED712A46
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzf-0004DB-HG; Fri, 26 May 2023 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zza-0004BO-38
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2ZzX-0002dE-V1
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fzs0h2LMkCyS2RcHmjcBAfl2R0ztIYcRkkcOdDDYgWk=;
 b=UAIEopr+aky9m8vbQ89nuI5cioIijWKmgYVB4fiTRcdcTLOgpO9HBLQBTRyBmir/36vAre
 r4w61Jks6AKPOKxz+v8rXIOlOCvLHGP27dx9lLqntC1oPh+zpiR9LI3+Rhn33UsvpmUn/O
 PPI1123Ui1+G8DNtfzeQ4o2Ms4qzabk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-RjS0zBG2PiGgORXZQJiX0A-1; Fri, 26 May 2023 12:08:33 -0400
X-MC-Unique: RjS0zBG2PiGgORXZQJiX0A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-970e0152da7so112843766b.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117312; x=1687709312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fzs0h2LMkCyS2RcHmjcBAfl2R0ztIYcRkkcOdDDYgWk=;
 b=LdnVO0Fts0MqyCIPRs/F53oz489+MpS0o6gjDE5C8Mn0bmakF4LS/3tMgOc5EhFDph
 mCpiiqS5rkvsEX9+rEoWTh7TfrvYxDhBPUQUalFZji+X17FwBHcp9LxnGtthm8NN6CHH
 pvfkj5wpRoQg/eri4L6CJccH+RKhuc7tdmujLL/Y6jaMUo5TRZZ7q8goAGuIYTJ3nNzZ
 NiK4paCEN9VpvIbJ798/Ny7WhM4fK3VVvOeSjb7YTrJ3y7QF++JarNbta+Urq1wxsOKR
 KHMg/4djdtCc49a7VddaKvxUfCZmZ9mC6OZ8fZSlZWYLk2ZQyBSNK7PljJznnAgH0d5p
 /zRA==
X-Gm-Message-State: AC+VfDy7R+QaTMpbHECMKcQCCCMVIrK1GSPqi3m7B2S0OO09GzAq4ggt
 Ww18QRB0xLs/AVxhaYx61XtYGpNKFFr3buteRWOoqWjX0fGeXjaNrI5Tf5jxjb57X7Yi8ydjFFi
 iAbkRhyi21I4WJIKmWIXuCS2xl4CqYMt1ynZj0H9QJhlLhWz9zaYfscjab74fwsU9Zdyo0bi4Dx
 E=
X-Received: by 2002:a17:907:80a:b0:94f:2852:1d2b with SMTP id
 wv10-20020a170907080a00b0094f28521d2bmr2253876ejb.72.1685117311774; 
 Fri, 26 May 2023 09:08:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AjMZyHpEAKtHO60KZkEJ5LSNkPg29ccnrV/GRV/FE2UDMYsmwxh6ZaN6FUPbRraSdNqdyOg==
X-Received: by 2002:a17:907:80a:b0:94f:2852:1d2b with SMTP id
 wv10-20020a170907080a00b0094f28521d2bmr2253859ejb.72.1685117311525; 
 Fri, 26 May 2023 09:08:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a170906714b00b0096f89fd4bf8sm2307767ejj.122.2023.05.26.09.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/12] Makefile: remove $(TESTS_PYTHON)
Date: Fri, 26 May 2023 18:08:15 +0200
Message-Id: <20230526160824.655279-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


