Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55F7222A5
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tb-0002rL-Pu; Mon, 05 Jun 2023 05:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tJ-0002pD-3F
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tH-0006mM-EN
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLpXk+3weJtOV+fHqWD4hS8kn1wUeCUWdGjfEsx3olI=;
 b=MifvL8soWflQpS87JXOv2BROoEAjXAZxvgzcMaeYyVaKbaotqT4BG2Vlu9yQThAXGuEF10
 LThIK6vilDNqSa9TXO0Fmg9G3ymuNzfpL/e/Lk7cOvvYlJF7e3KCfiZzDHfEqd5LxpVqOk
 EXD1/Ah4JBD9hZr7i4EUlUdYPIzZjNs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-BQwLlZdaM6WWYjcFoAsXPw-1; Mon, 05 Jun 2023 05:52:41 -0400
X-MC-Unique: BQwLlZdaM6WWYjcFoAsXPw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-513f337d478so2841762a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958759; x=1688550759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLpXk+3weJtOV+fHqWD4hS8kn1wUeCUWdGjfEsx3olI=;
 b=VC9BhBTHnfHLqpSJTiNe3kU5aX7l4hFVcWwWMuJPfMCM+Ng2R1YDT5B/CvOE48Ipfa
 3vd2OaQA7Gs1nDMpyuyLFth9tpsmw/4/pvTfdP3sp7nTw159zAmDB+A9+fGf/IprjoNI
 KiIUBxXjeMtW+kGyupS0Nf2wQzZYd67aVj2XZvuZQyQpWNcp1b5asrs/IRg0DRcDncvx
 YDi43fDAPFV7Ol2KQIICBJ2R9BjIW6RQVdRzuCnmE1cyaH6cEdwz9SAxIVrdOTq6/uoz
 76S/gnZ6N8Oq1HeFd/i/WfeNdDaWcNA4c5EbRU8BuiXBGakNYnh1PZuEBcbKDHHCq1IF
 MfEg==
X-Gm-Message-State: AC+VfDzsUrirjO3/bxazPjsiy9ZQ9pzOm5CEUeZ+fxf8Ld8eG5W8rwFq
 jCz3fy7ELUTUYuj5r2QdchzcBlztEu0u3uFrFux6eKOcgmzLPr9+geQ8Onhq26xBEMsS3+wu0tO
 L8ejND0jkUG3JDDLOowauuWLhcD12wtW7cKpqCsM0AL/u6UpVfILowLfUkF/0rfniocEI8qkTPv
 w=
X-Received: by 2002:a05:6402:3c7:b0:510:ee0f:1eab with SMTP id
 t7-20020a05640203c700b00510ee0f1eabmr5256870edw.41.1685958759604; 
 Mon, 05 Jun 2023 02:52:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5W/SzJSfvAoM3JCYewwFIB6XfjS6rtSEvEUCJFmjYGdESC7DY5dqqRwoYJjg2OVKuDPUgC3g==
X-Received: by 2002:a05:6402:3c7:b0:510:ee0f:1eab with SMTP id
 t7-20020a05640203c700b00510ee0f1eabmr5256861edw.41.1685958759364; 
 Mon, 05 Jun 2023 02:52:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa7de1a000000b005148f0e8568sm3681846edv.39.2023.06.05.02.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 09/10] build: remove git submodule handling from main makefile
Date: Mon,  5 Jun 2023 11:52:22 +0200
Message-Id: <20230605095223.107653-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
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

The only remaining user of submodules at build time is roms/SLOF,
which is handled in pc-bios/s390-ccw/Makefile.  Remove the relevant
code from the main makefile.

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
index badeeffd529..10df2eb1961 100644
--- a/meson.build
+++ b/meson.build
@@ -4008,7 +4008,6 @@ endif
 summary_info += {'Doc directory':     get_option('prefix') / get_option('docdir')}
 summary_info += {'Build directory':   meson.current_build_dir()}
 summary_info += {'Source path':       meson.current_source_dir()}
-summary_info += {'GIT submodules':    config_host['GIT_SUBMODULES']}
 summary(summary_info, bool_yn: true, section: 'Directories')
 
 # Host binaries
-- 
2.40.1


