Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3EF724636
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XjX-0006Xs-Uo; Tue, 06 Jun 2023 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xj5-0005j4-FR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xj1-0001LB-FE
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsZHG504ppi0bD32Z8ri/3YIY0UtxnuneA7a5gOwU88=;
 b=XWAg6rRFGfZzjVeAeVfm4SG1c7Dq7uqJDsb6sQNZiSGPDZp9NmdQQMdA9TbT+NnTy+fuF0
 eLUs9kvcju6ORrm7zwZgFmC+NasE2JutW2uZWNOFdT/Kk+/pqy2WcB0Lnp9A9+9cCyQ+Um
 HFWYkR6vAqf5gQTTcSSWKaMDTyoo27Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-WIZi5D_8NX6KHTb10zy8rg-1; Tue, 06 Jun 2023 10:31:51 -0400
X-MC-Unique: WIZi5D_8NX6KHTb10zy8rg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-97463348446so410011366b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061910; x=1688653910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsZHG504ppi0bD32Z8ri/3YIY0UtxnuneA7a5gOwU88=;
 b=Nnj23j5qyAAuxC8BxLIcj17ncYc6nIvSZExS81m0zVzSgGnTWTjvvCXZ4qxV4pCzt9
 Gme4ToXkm1lpcBeuo9qMLNgv0ujl/gimvsbZ8iaJCioDN/tlQ6oCnvNBkutbI0XhodZo
 GO0i53NI96udONqQS4h8k8ZFrmmxe12E7kFX1ZSbe+WN+IG234pb1Rmr4lc4BvFJMnq0
 UWpdPikbRVg45OJeZ2R8N2eZhHF6bMRbuhcqY+tzj54gUcvlxa9WqjaTFICL62RJlSh0
 2LENV1NRdlEB7GVMeVYfGM9ki55/hRK4L/nZ0mLJnIf0768iNsSS+5IVRPoqpjK71tE3
 Y1TQ==
X-Gm-Message-State: AC+VfDyabheX5We18H17e1OzMWP14qarB25iR8SrXS8akCaKIM1ZIM3d
 1H2gibvoXyse5T69OYQeSuexXBScrH2ieS+CdU23lsDzRQ3AL9TnVHhVTCy1lZ8e7Pb0GhCLmLa
 nI7mSU4jltF1paePENZdPwr7rBk6KiTk7uH1uGP5cYtSSQAoNj5A9ofDMkgluDK0fZjpG5Gc0qv
 E=
X-Received: by 2002:a17:907:16a5:b0:978:6be4:7efb with SMTP id
 hc37-20020a17090716a500b009786be47efbmr2504006ejc.7.1686061910035; 
 Tue, 06 Jun 2023 07:31:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7F8bMWOVmOdKMZwZHA8RQOgz18K1JMJHkAJY+yAL37Wsm/NbrAD05OBaGyq/WCxL1ZfmtGQw==
X-Received: by 2002:a17:907:16a5:b0:978:6be4:7efb with SMTP id
 hc37-20020a17090716a500b009786be47efbmr2503988ejc.7.1686061909617; 
 Tue, 06 Jun 2023 07:31:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a50eb48000000b00510da8aa2c6sm5134031edp.69.2023.06.06.07.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 20/21] build: remove git submodule handling from main makefile
Date: Tue,  6 Jun 2023 16:31:15 +0200
Message-Id: <20230606143116.685644-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
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

The only remaining user of submodules at build time is roms/SLOF,
which is handled in pc-bios/s390-ccw/Makefile.  Remove the relevant
code from the main makefile.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml |  3 +--
 Makefile                            | 10 ----------
 configure                           |  7 -------
 meson.build                         |  1 -
 4 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index d01d504ec5f..76ff1dfcb6f 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -42,8 +42,7 @@
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   script:
-    - scripts/git-submodule.sh update
-        roms/SLOF $(sed -n '/GIT_SUBMODULES=/ s/.*=// p' build/config-host.mak)
+    - scripts/git-submodule.sh update roms/SLOF
     - meson subprojects download $(cd build/subprojects && echo *)
     - cd build
     - find . -type f -exec touch {} +
diff --git a/Makefile b/Makefile
index d68196acb9e..b22bf6fba12 100644
--- a/Makefile
+++ b/Makefile
@@ -45,16 +45,6 @@ include config-host.mak
 include Makefile.prereqs
 Makefile.prereqs: config-host.mak
 
-git-submodule-update:
-.git-submodule-status: git-submodule-update config-host.mak
-Makefile: .git-submodule-status
-
-.PHONY: git-submodule-update
-git-submodule-update:
-ifneq ($(GIT_SUBMODULES_ACTION),ignore)
-	$(quiet-@)GIT=git "$(SRC_PATH)/scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)
-endif
-
 # 0. ensure the build tree is okay
 
 # Check that we're not trying to do an out-of-tree build from
diff --git a/configure b/configure
index 4dad32938df..bc0660f5a32 100755
--- a/configure
+++ b/configure
@@ -253,7 +253,6 @@ else
     git_submodules_action="ignore"
 fi
 
-git_submodules=""
 git="git"
 debug_tcg="no"
 docs="auto"
@@ -1657,18 +1656,12 @@ fi
 #######################################
 # generate config-host.mak
 
-if ! (GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" "$git_submodules"); then
-    exit 1
-fi
-
 config_host_mak="config-host.mak"
 
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo >> $config_host_mak
 
 echo all: >> $config_host_mak
-echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
-echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_host_mak
 
 if test "$debug_tcg" = "yes" ; then
   echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 74fb147fde3..6cd29c11b05 100644
--- a/meson.build
+++ b/meson.build
@@ -3976,7 +3976,6 @@ endif
 summary_info = {}
 summary_info += {'Build directory':   meson.current_build_dir()}
 summary_info += {'Source path':       meson.current_source_dir()}
-summary_info += {'GIT submodules':    config_host['GIT_SUBMODULES']}
 summary_info += {'Download dependencies': get_option('wrap_mode') != 'nodownload'}
 summary(summary_info, bool_yn: true, section: 'Build environment')
 
-- 
2.40.1


