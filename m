Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8062790800
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:01:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQES-0001Cs-Nu; Sat, 02 Sep 2023 09:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEL-0001CX-Sm
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEJ-0001if-DJ
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSmsxj0F9zLlEDlOc9BUZf4KydooBJ42LvrgpdbGCY4=;
 b=hOTerFVQiDmNFiY9ooA+hyPUrKpHblZDfJoWWrorKwl6VQSRkynyNoY6U5WZTIWKbdrRL8
 BgG5b3y7rIAHnm3qTfgR3uOGnGrjxMZ16J7Yw87QqMrkELRINZiuYkC1sPFM5+PMwP0mzp
 fhO3/ezlPygrgyaktrIdaGxxJh3GT2E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-uapJV6D0MXOKa9XsuMg98Q-1; Sat, 02 Sep 2023 08:59:57 -0400
X-MC-Unique: uapJV6D0MXOKa9XsuMg98Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-402493d2997so11395835e9.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659595; x=1694264395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSmsxj0F9zLlEDlOc9BUZf4KydooBJ42LvrgpdbGCY4=;
 b=DKWmdZAu8UOJ8LEtQBMxSqck6sXUUOzB9XG/Pcy+MhE7rNwu6gRzKjBVWkn6fg4XpK
 6SNopVrZf+VoBtf7UBZN+S8o2HkALj2qTh3tlsZ7GnIllmAcQSNN9NXMjq6tpEBjapLA
 t/CYkOM1Aag/xyZRQA+EGwxnqS54hk7a8oL6lW9MWNKg1DHUrYjsmCiY+jmxT3sBM7ah
 BrCsrnfDshRPKK3h5GOni6ebNMyl00Z6wucE6vPar5DID4LrkRpe3xlinCY859IX3WXA
 47VRMqyRM66hBFAivawRn3XiFMYNgMGmj8RprXHjHmSQjQ820zQKstmvh2W2GGKalTbc
 RDGA==
X-Gm-Message-State: AOJu0YxOfLxqFIssNYfJH2V5o0wVRgLE6MEMYGvmDSoj7BtLGNsJEu4K
 6DOhs/A3pa6PJVkUrSrYLTEhGFobOggWRPSb+/ZZ74jvICYuo/C9f4LlWOr8Evem0rUkBXSeagC
 SFDP3zsM5gOBsZfDm7CmmXf8301is0oXdYuNVu6Mza3AC93q5aygoWaloEDGLO9sVLg/tifTCfk
 w=
X-Received: by 2002:a05:600c:2111:b0:401:cf0d:25ca with SMTP id
 u17-20020a05600c211100b00401cf0d25camr3604399wml.40.1693659595438; 
 Sat, 02 Sep 2023 05:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHtYH+qiVTYJNRhuVh6FcOLlCJkxWXp0jNR2sBEOlRGNZJbFzqR0Twsj8ZaqBjX7xyWMxvDg==
X-Received: by 2002:a05:600c:2111:b0:401:cf0d:25ca with SMTP id
 u17-20020a05600c211100b00401cf0d25camr3604395wml.40.1693659595083; 
 Sat, 02 Sep 2023 05:59:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a7bc8c3000000b00401c595fcc7sm11060883wml.11.2023.09.02.05.59.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] configure: unify recursion into sub-Makefiles
Date: Sat,  2 Sep 2023 14:59:29 +0200
Message-ID: <20230902125934.113017-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Treat contrib/plugins the same as the firmware.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 27 ++++++++++++---------------
 configure | 13 ++++++++-----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index 5d48dfac18a..118c28e80d9 100644
--- a/Makefile
+++ b/Makefile
@@ -164,14 +164,6 @@ ifneq ($(filter $(ninja-targets), $(ninja-cmd-goals)),)
 endif
 endif
 
-ifeq ($(CONFIG_PLUGIN),y)
-.PHONY: plugins
-plugins:
-	$(call quiet-command,\
-		$(MAKE) $(SUBDIR_MAKEFLAGS) -C contrib/plugins V="$(V)", \
-		"BUILD", "example plugins")
-endif # $(CONFIG_PLUGIN)
-
 else # config-host.mak does not exist
 ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
 $(error Please call configure before running make)
@@ -184,15 +176,20 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: recurse-all
 
-ROMS_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(ROMS)))
-.PHONY: $(ROMS_RULES)
-$(ROMS_RULES):
+SUBDIR_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(SUBDIRS)))
+.PHONY: $(SUBDIR_RULES)
+$(SUBDIR_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
+ifneq ($(filter contrib/plugins, $(SUBDIRS)),)
+.PHONY: plugins
+plugins: contrib/plugins/all
+endif
+
 .PHONY: recurse-all recurse-clean
-recurse-all: $(addsuffix /all, $(ROMS))
-recurse-clean: $(addsuffix /clean, $(ROMS))
-recurse-distclean: $(addsuffix /distclean, $(ROMS))
+recurse-all: $(addsuffix /all, $(SUBDIRS))
+recurse-clean: $(addsuffix /clean, $(SUBDIRS))
+recurse-distclean: $(addsuffix /distclean, $(SUBDIRS))
 
 ######################################################################
 
@@ -296,7 +293,7 @@ help:
 	$(call print-help,cscope,Generate cscope index)
 	$(call print-help,sparse,Run sparse on the QEMU source)
 	@echo  ''
-ifeq ($(CONFIG_PLUGIN),y)
+ifneq ($(filter contrib/plugins, $(SUBDIRS)),)
 	@echo  'Plugin targets:'
 	$(call print-help,plugins,Build the example TCG plugins)
 	@echo  ''
diff --git a/configure b/configure
index 1be8b430a54..9980eaeef57 100755
--- a/configure
+++ b/configure
@@ -256,6 +256,7 @@ softmmu="yes"
 linux_user=""
 bsd_user=""
 plugins="$default_feature"
+subdirs=""
 ninja=""
 python=
 download="enabled"
@@ -1067,6 +1068,9 @@ if test "$static" = "yes" ; then
   fi
 fi
 test "$plugins" = "" && plugins=yes
+if test "$plugins" = "yes"; then
+  subdirs="$subdirs contrib/plugins"
+fi
 
 cat > $TMPC << EOF
 
@@ -1627,12 +1631,11 @@ done
 echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
 
 # Mac OS X ships with a broken assembler
-roms=
 if have_target i386-softmmu x86_64-softmmu && \
         test "$targetos" != "darwin" && test "$targetos" != "sunos" && \
         test "$targetos" != "haiku" && \
         probe_target_compiler i386-softmmu; then
-    roms="pc-bios/optionrom"
+    subdirs="$subdirs pc-bios/optionrom"
     config_mak=pc-bios/optionrom/config.mak
     echo "# Automatically generated by configure - do not modify" > $config_mak
     echo "TOPSRC_DIR=$source_path" >> $config_mak
@@ -1641,7 +1644,7 @@ fi
 
 if have_target ppc-softmmu ppc64-softmmu && \
         probe_target_compiler ppc-softmmu; then
-    roms="$roms pc-bios/vof"
+    subdirs="$subdirs pc-bios/vof"
     config_mak=pc-bios/vof/config.mak
     echo "# Automatically generated by configure - do not modify" > $config_mak
     echo "SRC_DIR=$source_path/pc-bios/vof" >> $config_mak
@@ -1660,7 +1663,7 @@ if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
       echo "WARNING: Your compiler does not support the z900!"
       echo "         The s390-ccw bios will only work with guest CPUs >= z10."
     fi
-    roms="$roms pc-bios/s390-ccw"
+    subdirs="$subdirs pc-bios/s390-ccw"
     config_mak=pc-bios/s390-ccw/config-host.mak
     echo "# Automatically generated by configure - do not modify" > $config_mak
     echo "SRC_PATH=$source_path/pc-bios/s390-ccw" >> $config_mak
@@ -1727,7 +1730,7 @@ if test "$container" != no; then
     echo "ENGINE=$container" >> $config_host_mak
     echo "RUNC=$runc" >> $config_host_mak
 fi
-echo "ROMS=$roms" >> $config_host_mak
+echo "SUBDIRS=$subdirs" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
-- 
2.41.0


