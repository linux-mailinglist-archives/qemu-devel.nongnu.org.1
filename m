Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3713790804
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEM-0001CO-Oo; Sat, 02 Sep 2023 09:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEJ-0001BA-Pn
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEH-0001iO-Hf
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASlqPfRTx1HqkKZS28AHHrSkUMgZS0lrgJaZwtX7dp0=;
 b=A8tkr9C+krOl7vZHNxSbs1uj/0bK6Iqp0BAi8/CSEAJ1a8RBXAyXAfqV9nn8TqPDPK9r28
 aTQ5k05nubt/PSC1elQ2uM+2t8t2m9oPGvSeaWTMbhfXlJGKsPdnE6QdmcQluSJJ0OkglC
 7a1FJ8NutKi3j+wPAK9SU2D+ye5JgEw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Po1VeB4rO5esmcwKmhbneQ-1; Sat, 02 Sep 2023 08:59:54 -0400
X-MC-Unique: Po1VeB4rO5esmcwKmhbneQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4005f0a53c5so19219655e9.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659593; x=1694264393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASlqPfRTx1HqkKZS28AHHrSkUMgZS0lrgJaZwtX7dp0=;
 b=HSaOX8aWSvTBjU/2CU75E0R0bNB7gDZNTfpyWs30vziOIkSxwk2HeSQKMi/H4GNRE7
 d9AP2RgDxxBdhR7v7skQVa0XClCjgSrxniE2HO31lYLae32yvQxxB4AQxt/ZQF34bYSE
 TKOQaADhjH7L6HO2Yy5MzCr9emUcYeU4evC6Gzxd5cxuzUF7v2nFw1dZ0Us7/unC78G9
 ejtqhk/tVIdMRSDudYZacYb1WjbkFidnG+ZGWMtPLFn10IiqQjXLsSuVyO3G6iCqmn+r
 G09E8RK/qiPab7P++AZ0U0TrxeqtXkGOfa0h/0QfEcj1+USjHi7I7ciyOC+KkAYYmnEp
 8p4g==
X-Gm-Message-State: AOJu0YyBoqUiWXqVbv0QK5/QOKUIZMtCtJyjhMPG8nKEMcz+0LW4c7qO
 vNaIsGnPaIdPOm8wCPIP8V6+rF9Q9bypWF8O77UBkHxyPVaj3jzPUaS+wgRLWJJ4JaPtdN0NkSK
 h9p8FApL9y5Xzi0gc4X8dhrJqNSMeSpZiJAWah3bKZ+tkWlqkUXWHA/zW9j9U61HVn7CMF2Lt0h
 s=
X-Received: by 2002:a1c:790b:0:b0:401:b654:e8e7 with SMTP id
 l11-20020a1c790b000000b00401b654e8e7mr3786688wme.28.1693659593146; 
 Sat, 02 Sep 2023 05:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPFbV1Z6U3OuSKPIsvSauFr2bXqQE0z15d2Ve7pfaf6ePa/FGPFALtKArAPxHEQjc8S154Eg==
X-Received: by 2002:a1c:790b:0:b0:401:b654:e8e7 with SMTP id
 l11-20020a1c790b000000b00401b654e8e7mr3786680wme.28.1693659592637; 
 Sat, 02 Sep 2023 05:59:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a1ced03000000b003feae747ff2sm11181296wmh.35.2023.09.02.05.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 09/15] contrib/plugins: use an independent makefile
Date: Sat,  2 Sep 2023 14:59:28 +0200
Message-ID: <20230902125934.113017-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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
 configure                | 12 +++++++++---
 contrib/plugins/Makefile | 18 +++++++++---------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index afd6121b616..1be8b430a54 100755
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
@@ -1757,6 +1756,13 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
+# contrib/plugins configuration
+echo "# Automatically generated by configure - do not modify" > contrib/plugins/$config_host_mak
+echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
+echo "PKG_CONFIG=${pkg_config}" >> contrib/plugins/$config_host_mak
+echo "CC=$cc $CPU_CFLAGS" >> contrib/plugins/$config_host_mak
+echo "CFLAGS=${CFLAGS-$default_cflags} $EXTRA_CFLAGS" >> contrib/plugins/$config_host_mak
+
 # tests/tcg configuration
 (config_host_mak=tests/tcg/config-host.mak
 mkdir -p tests/tcg
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index b2b9db9f51a..0751201bcb3 100644
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
@@ -26,21 +26,21 @@ SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
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
-	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
+	$(CC) -shared -Wl,-soname,$@ -o $@ $^
 
 clean:
 	rm -f *.o *.so *.d
 	rm -Rf .libs
 
 .PHONY: all clean
+.SECONDARY:
-- 
2.41.0


