Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022472462D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XjW-0006Ha-0y; Tue, 06 Jun 2023 10:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xj3-0005h4-Gb
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xj1-0001LD-CZ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mfp4JIbpnZmD+vI6YToqq1ibWR/osoRJjAfjzSDVCk=;
 b=dF0nEtqNL3HeOvzmGb+ww6mIuDtDgQUkdfrENKh3tRmXlH9QqrCnjqlrvoHWtGnjKkEhE+
 QlSbIdY5Y6NKd1snaA+/R0Eo+99Z7YlVXu10+C9WYHmQv1oCUFNlEx8JMJ705mFhe/27P4
 mGe/Ota/9ulSPCZmKKvPLw6rgevF0xI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-lKX2oGl9MAubFvBoBamk9Q-1; Tue, 06 Jun 2023 10:31:46 -0400
X-MC-Unique: lKX2oGl9MAubFvBoBamk9Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso543831566b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061905; x=1688653905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mfp4JIbpnZmD+vI6YToqq1ibWR/osoRJjAfjzSDVCk=;
 b=TS+/J4oJdchR9r50LnO09bKBweoogL2Uj/iLRxYPg8g5QgxquvYVzFEjSS6rwVOxQ2
 l9EbdB8/uDlVVnMIewNEHj7ryGaX7ANgFwWiHPsvOqIghxb89vJNKeHfas2+0qKWq1Sd
 vp8E7NdHLhaI7UWYfdq/sfMFBcyglhjOggfrXe+EvDxZCVOfrcAkIzBtrDDqpIvIwJj6
 r9lf+8xhBkM6tCUtQxuoOFcBFlMIV7+eG9l+ySDRbbklXew/mCgGM445S5IAP0TeK9gZ
 T70Kz3fxdHSq/77CMP8TEWZmj1MrRPxoiDmZmpm4XpA1gwG+6ouivb7GhCaT26ts68sV
 QOqw==
X-Gm-Message-State: AC+VfDx02/vEvQ9kc2l9pcyBHuNBkMOUCLwNMknXHGhroA7qHHnP/lGx
 o4Xz8P85dFJ/nIctwTcGrsohQasp+AMrlG/r134Z+tLb5DUprjVEDcyXCjEM7mi3SH6eK9g4evh
 +N4yft6TnCfybB8WhEViw/je8gu7rHbswsWUxCb3sv7wTLinv6Mo1me/eTE49iAxvqt7v61OaF4
 k=
X-Received: by 2002:a17:906:db06:b0:94f:7a8:a902 with SMTP id
 xj6-20020a170906db0600b0094f07a8a902mr2598719ejb.14.1686061905257; 
 Tue, 06 Jun 2023 07:31:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RATfo+iogObMNa4nwVwehbr3805UCLnPq0yAnQ0sTHLFObiSls72XhC6fgbPsHPWRjT4vlA==
X-Received: by 2002:a17:906:db06:b0:94f:7a8:a902 with SMTP id
 xj6-20020a170906db0600b0094f07a8a902mr2598708ejb.14.1686061905043; 
 Tue, 06 Jun 2023 07:31:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 fx22-20020a170906b75600b00977da5d3350sm2635118ejb.107.2023.06.06.07.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 17/21] configure: move SLOF submodule handling to
 pc-bios/s390-ccw
Date: Tue,  6 Jun 2023 16:31:12 +0200
Message-Id: <20230606143116.685644-18-pbonzini@redhat.com>
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

Move the handling of the roms/SLOF submodule out of the main Makefile,
since we are going to remove submodules from the build process of QEMU.

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


