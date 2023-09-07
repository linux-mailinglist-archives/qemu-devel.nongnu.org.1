Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D5B79727B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdc-0003Pu-Lb; Thu, 07 Sep 2023 09:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdI-00039t-Ul
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdF-0007NR-RO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vC+s/1c/aD+R+OU0sMKhncoUeeIumfmEoRZ3URXLr0=;
 b=I96FNYDioKB7eWVBShK1AqT2zQww/x2rXdlI52N4PO8RWd1c6531ye2oItBdfumt3JbN5x
 2sZnJ3H5upwTYj5ThyT/eY4WSn1gzfoSYVhE+qHn17ujDfEXHJXN3/UowR7I1erjYThcBF
 bA7jDNUsMS1O77c9Mc45T5pfOc0Q9G8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-BeVbmmCeMT-Glc0VU6iAjQ-1; Thu, 07 Sep 2023 09:01:11 -0400
X-MC-Unique: BeVbmmCeMT-Glc0VU6iAjQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4020645b2a2so5892485e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091669; x=1694696469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vC+s/1c/aD+R+OU0sMKhncoUeeIumfmEoRZ3URXLr0=;
 b=N+BASJige5qdkvdqH+xDArJ50KrSjzbdBbg5YGuien1nRpUdk+JyAQ+RRyzAy2rHph
 lwslip2b+QZ0ke8ovL/WI46EQSNVXyFaZ+faN0iwSNOY3cQZLMoMKQrWP9u0+ozOy3lw
 PJDpPGPpwoPWPReUOqBh46UtH/JehI2niIHnkDty+ariNXeO3TmF3uXwWOA9qrBVEWfa
 IoDrpADd5xZF5f2TK4McEBHS9g9UsRI2BHhbfeAWcRyGZHOei/F5E038y31IAe+7dar8
 6OG6eSBtzCG7tbCLEwAaeOdNQbzbHrrP9Gd6nqzuv1jlW4CrYFsFHyDC7JqILM4DqNiR
 rd3w==
X-Gm-Message-State: AOJu0YyToGTAwWBKAy6lJ6BY30irPIFidmQ+0eBlLDlXSBOdWmf1UQ/E
 KK7NbQNMxA/R6v/4wbZNcsR1zTLjt16B+KloruFcWtyxXZQa3b0hVkQ8IK5EeyDOlFxHpprOXu0
 tQDU0cayUiySH3etvfKCg+OampfII/NtgY9Gyml/NPOMCW0UKHS0R2gwNy4PKprtZnk/y0dOyAo
 s=
X-Received: by 2002:a7b:c855:0:b0:400:57d1:4915 with SMTP id
 c21-20020a7bc855000000b0040057d14915mr4380683wml.37.1694091669371; 
 Thu, 07 Sep 2023 06:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGauUA/hrxYq021ycEzjQ676BBMeT8S7Uq60/fg36DFmGZkUpHR6OhdVhguWIX/77a2wZFSGw==
X-Received: by 2002:a7b:c855:0:b0:400:57d1:4915 with SMTP id
 c21-20020a7bc855000000b0040057d14915mr4380666wml.37.1694091668997; 
 Thu, 07 Sep 2023 06:01:08 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a05600c1c9000b003feae747ff2sm2514236wms.35.2023.09.07.06.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 27/51] contrib/plugins: use an independent makefile
Date: Thu,  7 Sep 2023 14:59:36 +0200
Message-ID: <20230907130004.500601-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

The initial reason to write this patch was to remove the last use of
CONFIG_DEBUG_TCG from the makefiles; the flags to use to build TCG
plugins are unrelated to --enable-debug-tcg, and instead they should
be the same as those used to build emulators (the plugins are not build
via meson for demonstration reasons only).

However, since contrib/plugins/Makefile is also the last case of doing
a compilation job using config-host.mak, go a step further and make it
use a completely separate configuration file, removing all references
to compilers from the toplevel config-host.mak.  Clean up references to
empty variables, and use .SECONDARY so that intermediate object files
are not deleted.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                | 15 ++++++++++++---
 contrib/plugins/Makefile | 16 ++++++++--------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index afd6121b616..849cd3c0385 100755
--- a/configure
+++ b/configure
@@ -245,7 +245,7 @@ for opt do
   esac
 done
 
-
+default_cflags='-O2 -g'
 git_submodules_action="update"
 git="git"
 docs="auto"
@@ -732,6 +732,7 @@ for opt do
       meson_option_parse --enable-debug-graph-lock ""
       meson_option_parse --enable-debug-mutex ""
       meson_option_add -Doptimization=0
+      default_cflags='-O0 -g'
   ;;
   --disable-tcg) tcg="disabled"
                  plugins="no"
@@ -1731,8 +1732,6 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
-echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
-echo "CC=$cc" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers for KVM architectures
@@ -1757,6 +1756,16 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
+# contrib/plugins configuration
+echo "# Automatically generated by configure - do not modify" > contrib/plugins/$config_host_mak
+echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
+echo "PKG_CONFIG=${pkg_config}" >> contrib/plugins/$config_host_mak
+echo "CC=$cc $CPU_CFLAGS" >> contrib/plugins/$config_host_mak
+echo "CFLAGS=${CFLAGS-$default_cflags} $EXTRA_CFLAGS" >> contrib/plugins/$config_host_mak
+if test "$targetos" = darwin; then
+  echo "CONFIG_DARWIN=y" >> contrib/plugins/$config_host_mak
+fi
+
 # tests/tcg configuration
 (config_host_mak=tests/tcg/config-host.mak
 mkdir -p tests/tcg
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index c26fa08441e..8ba78c7a329 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -6,11 +6,11 @@
 # programs that the main configure has already done for us.
 #
 
-BUILD_DIR := $(CURDIR)/../..
+include config-host.mak
 
-include $(BUILD_DIR)/config-host.mak
+TOP_SRC_PATH = $(SRC_PATH)/../..
 
-VPATH += $(SRC_PATH)/contrib/plugins
+VPATH += $(SRC_PATH)
 
 NAMES :=
 NAMES += execlog
@@ -26,15 +26,14 @@ SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
 # The main QEMU uses Glib extensively so it's perfectly fine to use it
 # in plugins (which many example do).
-CFLAGS := $(shell $(PKG_CONFIG) --cflags glib-2.0)
-CFLAGS += -fPIC -Wall
-CFLAGS += $(if $(CONFIG_DEBUG_TCG), -ggdb -O0)
-CFLAGS += -I$(SRC_PATH)/include/qemu
+PLUGIN_CFLAGS := $(shell $(PKG_CONFIG) --cflags glib-2.0)
+PLUGIN_CFLAGS += -fPIC -Wall
+PLUGIN_CFLAGS += -I$(TOP_SRC_PATH)/include/qemu
 
 all: $(SONAMES)
 
 %.o: %.c
-	$(CC) $(CFLAGS) -c -o $@ $<
+	$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<
 
 lib%.so: %.o
 ifeq ($(CONFIG_DARWIN),y)
@@ -48,3 +47,4 @@ clean:
 	rm -Rf .libs
 
 .PHONY: all clean
+.SECONDARY:
-- 
2.41.0


