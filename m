Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9847222AA
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tV-0002pn-5K; Mon, 05 Jun 2023 05:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tE-0002lc-DS
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tC-0006lP-AU
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDTaIO815jYKMtq0lxxzOJMLo2VA9Yqak5Vr38UtEkM=;
 b=Rw7Wu6JaMtpnqor0U7pGh3v4CBW69dANqNz/fjOBIqlkUfn/uQgESDKfiEKIBppkECG1db
 JnXtpmksB6djckCus3mQq2JX/q89JtrAyjjMkNV2eM7u5WpNaNhCJbUH+dNuF3vFaNvLSJ
 DFfTPowFUSwlevswkI0pXsmFoZO85Xw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-gxcrZawmNUiVnEo6e7cjqg-1; Mon, 05 Jun 2023 05:52:36 -0400
X-MC-Unique: gxcrZawmNUiVnEo6e7cjqg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9745c72d99cso291743066b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958755; x=1688550755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDTaIO815jYKMtq0lxxzOJMLo2VA9Yqak5Vr38UtEkM=;
 b=N+t94tY0mCBdInxQ2QnpVwUX4Nd7S5Yt9ezZmClbhmDFGKRW1+1UjLbcOL9rTKbk9d
 P7A/cih21YbjwGOftCEub8Y7nRgFYVocePxfa06MY77e8hpY4KVyeuynHgsBH343SxWf
 eV2CYX3RbT9yv0/eygmmAuWPokrLoQgjcs0oJqkRkUIvy7WJXY5H1FcBCdPNsiV1tjh4
 3GXN+Xy0VCo3mggPAs8lM+ATijplshH9/fqBM3lIK/ezXzjrmCjq90t/Ln5HvIpPTTm7
 YowF9uXaTLd+sDXYJP4EvU5qt8/PRIg8ixB6e8wEkhW9Nqr9C8xSQ2K+L7hHgc6hMTHF
 WDFQ==
X-Gm-Message-State: AC+VfDx7t6VuMC1XP2v7j1UY9kFCFZGhnRR6p6elL2tzKuPGm7D0zA1D
 vLppUDd0g21EQ8AymOevqz7gaPUseW1idnbuaIl3hds/tCYzZjePhmLGRWPgUCo99zmD23pKa0Y
 GwWIdWV17oowQh1q64aqTGUoWGFhaoJX83q+05zpQnBSbUDZXVBNk6M+UdTgf6m+99N5EBsc0ns
 A=
X-Received: by 2002:a05:6402:686:b0:50b:d18c:620a with SMTP id
 f6-20020a056402068600b0050bd18c620amr7045233edy.25.1685958755272; 
 Mon, 05 Jun 2023 02:52:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7hGIRZf+C0SH393QAM1osC86ya4GDZBy/wZzyYdXinY2Ih2Wj95kwyhQiffEka/Ydg4hbvBw==
X-Received: by 2002:a05:6402:686:b0:50b:d18c:620a with SMTP id
 f6-20020a056402068600b0050bd18c620amr7045221edy.25.1685958755014; 
 Mon, 05 Jun 2023 02:52:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa7de1a000000b005148f0e8568sm3681775edv.39.2023.06.05.02.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 06/10] configure: move SLOF submodule handling to
 pc-bios/s390-ccw
Date: Mon,  5 Jun 2023 11:52:19 +0200
Message-Id: <20230605095223.107653-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
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

Move the handling of the roms/SLOF submodule out of the main Makefile,
since we are going to remove submodules from the build process of QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml |  2 +-
 configure                           |  7 +++----
 pc-bios/s390-ccw/Makefile           | 11 +++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 3c997d7265b..d01d504ec5f 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -43,7 +43,7 @@
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   script:
     - scripts/git-submodule.sh update
-        $(sed -n '/GIT_SUBMODULES=/ s/.*=// p' build/config-host.mak)
+        roms/SLOF $(sed -n '/GIT_SUBMODULES=/ s/.*=// p' build/config-host.mak)
     - meson subprojects download $(cd build/subprojects && echo *)
     - cd build
     - find . -type f -exec touch {} +
diff --git a/configure b/configure
index 45d43ddbd97..de3904fb59d 100755
--- a/configure
+++ b/configure
@@ -1662,7 +1662,8 @@ fi
 
 # Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
 # (which is the lowest architecture level that Clang supports)
-if have_target s390x-softmmu && probe_target_compiler s390x-softmmu; then
+if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
+    GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" roms/SLOF >> config.log 2>&1; then
   write_c_skeleton
   do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
   has_z900=$?
@@ -1675,10 +1676,8 @@ if have_target s390x-softmmu && probe_target_compiler s390x-softmmu; then
     config_mak=pc-bios/s390-ccw/config-host.mak
     echo "# Automatically generated by configure - do not modify" > $config_mak
     echo "SRC_PATH=$source_path/pc-bios/s390-ccw" >> $config_mak
+    echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_mak
     write_target_makefile >> $config_mak
-    # SLOF is required for building the s390-ccw firmware on s390x,
-    # since it is using the libnet code from SLOF for network booting.
-    git_submodules="${git_submodules} roms/SLOF"
   fi
 fi
 
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 10e8f5cb633..9c5276f8ade 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -6,6 +6,8 @@ include config-host.mak
 CFLAGS = -O2 -g
 MAKEFLAGS += -rR
 
+GIT_SUBMODULES = roms/SLOF
+
 NULL :=
 SPACE := $(NULL) #
 TARGET_PREFIX := $(patsubst %/,%:$(SPACE),$(TARGET_DIR))
@@ -80,3 +82,12 @@ clean:
 
 distclean:
 	rm -f config-cc.mak
+
+.PHONY: git-submodule-update
+$(SRC_PATH)/../../.git-submodule-status: git-submodule-update config-host.mak
+Makefile: $(SRC_PATH)/../../.git-submodule-status
+
+git-submodule-update:
+ifneq ($(GIT_SUBMODULES_ACTION),ignore)
+	$(quiet-@)GIT=git "$(SRC_PATH)/../../scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)
+endif
-- 
2.40.1


