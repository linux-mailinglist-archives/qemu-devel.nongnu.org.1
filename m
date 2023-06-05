Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD85722C1C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 18:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Ce8-00073w-U0; Mon, 05 Jun 2023 12:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6CdV-0006id-SD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6CdJ-0004lM-VK
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685980820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wufvntv52Bzssb0ok2muONHrebyhsMD/4yTVZxAaVxU=;
 b=cgsdxjS9qCHBi3fG8PyL9XDQ8hczey0BaZKFuQlnDZOKH6bt5w+mtdoTYsr3aOTulLaLDw
 S59ZZNF+0Vc0eY1snmg2m5TyN9rPs/o2PNyPc2EMeaxxKXmnU1yqcFgh8K4mrHIYFkOkJ9
 ohLNfoJvQdfbz79IU/gcOe7+c4iYE88=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-raDl4HJxMVqx4aSZgPIrAQ-1; Mon, 05 Jun 2023 12:00:18 -0400
X-MC-Unique: raDl4HJxMVqx4aSZgPIrAQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-976c92459cbso231069966b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 09:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685980817; x=1688572817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wufvntv52Bzssb0ok2muONHrebyhsMD/4yTVZxAaVxU=;
 b=kY4Rjb3kPNiFq2av5U9M8j6sOustGOYU3+gZYU0kgjJoASVcOWRpZTkAoLz+nf+S5V
 DAB79as0Sox/xyhCQjb57fy5/tyi4fnBekmqOsGKZxHfmRWy8ppLz48OCgKf/tHlw9sz
 guXGgc8T7RllKwEKIEsDEAZy/rLn9d6Xl9YNkD+3IZnPOZl4a03j0XZW6J7R9uioxpcW
 xi8eOEV+cOyES4/lg3S/U8muOf9ybNQHHor3qMtE74aygfNfFjQIHKiSWSbDUkLldw1T
 QdqtAI507n9YaqvGzRANp4IPPgr+2apL2FRfCebun9766EOpDRFgdpkBCnDLWIX9gYaH
 R/KA==
X-Gm-Message-State: AC+VfDyLGkskFmw3UwTpY1j+eJPXn0xMQFsUhf6RoSW/5peU520jD3Hl
 8AhC4zVtr56KOul5fkPbVxMQXBjnhHlp1u8ErhG998W+UyGDkpqJyfPIn6g2wVC4agfMrwKYKXa
 F3A9KFzAHInRJGuYez9X2il4B49V/Q3afgWRY7q//E6qo4Iussec/W2E8XEglaYScEGWtfzdFd4
 0=
X-Received: by 2002:a17:907:944f:b0:974:62d7:1467 with SMTP id
 dl15-20020a170907944f00b0097462d71467mr5738728ejc.5.1685980816972; 
 Mon, 05 Jun 2023 09:00:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WGF83AtpFsjp9sWETZZFMd6ooPQ1/2qDCjltu8wVBberA0vonWmsR3fI9ndJepU4sQcfrig==
X-Received: by 2002:a17:907:944f:b0:974:62d7:1467 with SMTP id
 dl15-20020a170907944f00b0097462d71467mr5738705ejc.5.1685980816568; 
 Mon, 05 Jun 2023 09:00:16 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 fx12-20020a170906b74c00b0094ebc041e20sm4410652ejb.46.2023.06.05.09.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 09:00:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 jsnow@redhat.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH v2 1/2] Revert "tests/requirements.txt: bump up
 avocado-framework version to 101.0"
Date: Mon,  5 Jun 2023 18:00:11 +0200
Message-Id: <20230605160012.339685-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605160012.339685-1-pbonzini@redhat.com>
References: <20230605160012.339685-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

This reverts commit ec5ffa0056389c3c10ea2de1e78366f66f4e5abc.

Bumping avocado to version 101 has two issues.  First, there are problems
where Avocado is not logging of command lines or terminal output, and not
collecting Python logs outside the avocado namespace.

Second, the recent changes to Python handling mean that there is a single
virtual environment for all the build, instead of a separate one for testing.
Requiring a too-new version of avocado causes conflicts with any avocado
plugins installed on the host:

   $ make check-venv
   make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
     GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/berkeley-softfloat-3 dtc
     VENVPIP install -e /home/berrange/src/virt/qemu/python/
     VENVPIP install -r /home/berrange/src/virt/qemu/tests/requirements.txt
   ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
   avocado-framework-plugin-varianter-yaml-to-mux 98.0 requires avocado-framework==98.0, but you have avocado-framework 101.0 which is incompatible.
   avocado-framework-plugin-result-html 98.0 requires avocado-framework==98.0, but you have avocado-framework 101.0 which is incompatible.
   make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'

To avoid this issue, tests/requirements.txt should use a ">=" constraint
and the version of Avocado should be limited to what distros provide
in the system packages.  Only Fedora has Avocado, and more specifically
version 92.0 (though 98.0 is also available as a module).  As a first
step, this patch reverts the introduction of a too-new Avocado.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 18 +++++++-----------
 tests/requirements.txt |  2 +-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0184ef22373..8294a44816c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -136,18 +136,14 @@ get-vm-image-fedora-31-%: check-venv
 # download all vm images, according to defined targets
 get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_31_DOWNLOAD))
 
-JOBS_OPTION=$(lastword -j1 $(filter-out -j, $(filter -j%,$(MAKEFLAGS))))
-
 check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
-	$(call quiet-command, 							\
-            $(PYTHON) -m avocado 						\
-            --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) 	\
-            $(if $(AVOCADO_TAGS),, 						\
-			--filter-by-tags-include-empty 				\
-			--filter-by-tags-include-empty-key) 			\
-		--max-parallel-tasks $(JOBS_OPTION:-j%=%) 			\
-            $(AVOCADO_CMDLINE_TAGS) 						\
-            $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), 			\
+	$(call quiet-command, \
+            $(PYTHON) -m avocado \
+            --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
+            $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
+			--filter-by-tags-include-empty-key) \
+            $(AVOCADO_CMDLINE_TAGS) \
+            $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
             "AVOCADO", "tests/avocado")
 
 check-acceptance-deprecated-warning:
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 0e008b9aec3..07e713ef5ac 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -5,5 +5,5 @@
 # Note that qemu.git/python/ is implicitly installed to this venv when
 # 'make check-venv' is run, and will persist until configure is run
 # again.
-avocado-framework==101.0
+avocado-framework==88.1
 pycdlib==1.11.0
-- 
2.40.1


