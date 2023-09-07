Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356B7972AF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeb-0005nx-SX; Thu, 07 Sep 2023 09:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdT-0003QA-38
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdP-0007PG-7w
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iaktLIjVJSqvWsFHPYa1zZxD9ZnUqDBRnUr485Ej9/A=;
 b=iOqfUWzEPOu4d4OsZwHGBCLWVPC1TsCMJSPnglomOsbfgTHm7weAdFZ+eUVfbSXxnwk72s
 2rfo/B65o3cC9NkHwqzIdY0SsFJNGR6NFlI8rQ501Uzv8d+1u4uyA5DsxwrvMrk+vZFv+Y
 SfUCQFiHELEyKaV+s/8dEwBHzSiArT4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-BDh9_6fpNO2uHYpDXW2_bg-1; Thu, 07 Sep 2023 09:01:18 -0400
X-MC-Unique: BDh9_6fpNO2uHYpDXW2_bg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so569713f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091671; x=1694696471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaktLIjVJSqvWsFHPYa1zZxD9ZnUqDBRnUr485Ej9/A=;
 b=RSsuNGD+dL19X/IMQjERI9gW5VQtkctTug0NyrhHJ9dXJtRcKrSmHpu+xfUNx46WUc
 OuK6UjKdOefxdIfrxzslRRJCpP8oz/iyIGjiNNNPcxAt1zuabdTBqRya0LBLRlkhgrgC
 DiIWRGXRAh1HzZEbPztLZy2RwKsDd1DvFLuf3O/TfdY9hEMHJ3KpGvBnRhek3eXVCiIL
 67uycjO6IJfbD1kkbZlsU4SakSdAmNqygNyJsLsc1pI4YT+UICkhBxsOxfIbYNGjVUfu
 LEf7hypaTuKXg7Wl5Wr6bW+v+RH/OUNcDTDD2Fy/ghbtRD45yBkT/c0o0Jw1M8j4X1qf
 U7+g==
X-Gm-Message-State: AOJu0YylNMHWlXcGRr/2qpn2thWbEAsVNhiOIm4yAjzud/Ju99biinRY
 nXUf1+lWRk/EJKg4rY7v8ld+EmIbtHBH4bVxQ5GRxw9CgGHdCGsWaN2NSDUEQitRUkJG0XNRUE/
 bpfrVgiHDWhyVrA7Dr1Ur2L02uOHwh/ccjRMT51VPILHMTBzHawDGNVNQpDguwFsybU+1jD3/O0
 M=
X-Received: by 2002:adf:ce8c:0:b0:31c:762b:ceb3 with SMTP id
 r12-20020adfce8c000000b0031c762bceb3mr4836152wrn.48.1694091671676; 
 Thu, 07 Sep 2023 06:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMDVeUzifF2ChTwapyG0zaRFZNMat+bkxtX2EOJV+FvkHZDv7ekmwTyUMeOpAFNoYzD+PI/g==
X-Received: by 2002:adf:ce8c:0:b0:31c:762b:ceb3 with SMTP id
 r12-20020adfce8c000000b0031c762bceb3mr4836109wrn.48.1694091670973; 
 Thu, 07 Sep 2023 06:01:10 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a5d6643000000b00318147fd2d3sm23318716wrw.41.2023.09.07.06.01.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/51] configure: unify recursion into sub-Makefiles
Date: Thu,  7 Sep 2023 14:59:37 +0200
Message-ID: <20230907130004.500601-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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
index 849cd3c0385..a0912e4b268 100755
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


