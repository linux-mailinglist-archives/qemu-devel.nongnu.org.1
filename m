Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3367724630
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:33:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xip-0005Gg-6z; Tue, 06 Jun 2023 10:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xij-00055v-Aa
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xih-0001Fx-Lr
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wufvntv52Bzssb0ok2muONHrebyhsMD/4yTVZxAaVxU=;
 b=X41gItp9k54MXmEy2WOiMZhPpbp/Rh+RtSa9bmD9u7/IEM4duTWPHORCf7yaIMqr6iZwJO
 EePgdCbE9DJ9Pq4dVFyMii9W7lI85PP4ccCxXNHmgYaN64Ekv++qZ88jbXwPaugSLL3XSG
 lwWRi/ABWSFVz79mWtPYV5b0Yzo+CRk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-AS8NQmJ2P0GchQZmrptHDA-1; Tue, 06 Jun 2023 10:31:33 -0400
X-MC-Unique: AS8NQmJ2P0GchQZmrptHDA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-977c516686aso335302766b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061891; x=1688653891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wufvntv52Bzssb0ok2muONHrebyhsMD/4yTVZxAaVxU=;
 b=du2AIjNNFAvWYHE+YdXbGQZqZ2zuV/rW/F/5ooI7hh066INEzZVo7mc8oX7zmkFdoR
 3r+tjiy0Wdf0UD4kYcXGP8sn6jzQWje/YHSenGWVvZ3CUyGEmeuweR78mOKm6qcj/PbL
 fNwH/nY7wrFsdGIPSsQqjcq11loTHxuz1wTC/HltwgcsLEa2vPxjA/OxgWuuygxN8QTV
 et/i2/CPs4GBJVa+AxmQ+Ebbo1o1r2vzSxn1mqyJ1IrW6NMKOgzmE+THw1mzCyo658Cn
 rDSNkldWaw11yETKwFNHqIaF6lj/89hFGnwUvFI2VWjW0lW0cdJghd/kzSMU7RdPCHdt
 gk1Q==
X-Gm-Message-State: AC+VfDyhLyQcEHepcv3XaK9/rxHXmkVGCjxrWE3udeYKvG64ioLGfRtO
 fMIm99OCFZsZNj2HReUGJerqXrYdz4zYqkFHTQWheLJOCUcZ9dMxhFyQfF1wLvaIgVhSKTHVa+R
 ml0xNImr7fwfpKUsPHy9CJjMQ752yFGXg1VX/h1HjMKS7UYxPRn53aaPZ12TDW3CP+zCdYMnDls
 w=
X-Received: by 2002:a17:907:80c:b0:974:218d:c048 with SMTP id
 wv12-20020a170907080c00b00974218dc048mr2880652ejb.26.1686061891638; 
 Tue, 06 Jun 2023 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VX3W8OFTx6SEbtgwUQMaFEDIyV5XdDhrRO7va9xHGbs/ldpZEqT7QYYa9M+K/FSO+Uc0lhA==
X-Received: by 2002:a17:907:80c:b0:974:218d:c048 with SMTP id
 wv12-20020a170907080c00b00974218dc048mr2880635ejb.26.1686061891349; 
 Tue, 06 Jun 2023 07:31:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a170906a00500b0096f641c6167sm5627555ejy.181.2023.06.06.07.31.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/21] Revert "tests/requirements.txt: bump up
 avocado-framework version to 101.0"
Date: Tue,  6 Jun 2023 16:31:04 +0200
Message-Id: <20230606143116.685644-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
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


