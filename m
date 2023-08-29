Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 959BC78C049
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau6o-0002la-Tf; Tue, 29 Aug 2023 04:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6h-0002fV-7w
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6d-0008TB-P0
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTWWyRaT75f8DRqj83gMtzait4DH3XGzdwX7f3Ycivs=;
 b=XgFjOURYMoALKru/RMnUDbAsV1uy7JTQVN21+wD4YB9cbk0W5Yg1LDCVQVDZl1EJabevqD
 orYaQo2gQWrV0zadT+WGMgpWfXKXmcfVVa2LOee3+ZcqTMxuwlL/YXisOeR8uzDJ3gU/L6
 xl82nF5vYJGO06pSs08dq0CiX1usQuw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-KnFXfQ80PIO-hl1OFB_fPw-1; Tue, 29 Aug 2023 04:29:45 -0400
X-MC-Unique: KnFXfQ80PIO-hl1OFB_fPw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe5b94bd62so29394465e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297784; x=1693902584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTWWyRaT75f8DRqj83gMtzait4DH3XGzdwX7f3Ycivs=;
 b=kyi8kMxN8kEiPOU1wKgeaQOCIh/tR1zfdaK/vNzb2FPEalhRjR9/hi8f8u/U958Oyk
 JtiZaCtOyPdEizdmwlUF0Qjtb1gty/vADT4j+vz6rYwvnNfID6Azjus763gO4DIIZmeL
 oMPFow+UJRaEn+gfvRzbaZa3PuDOjeVg+750aHVUOlJTYaUJcu3TWY812TyUqYFucfRm
 h4IySkzrwWjIN0p8R0yQmN/J+PXSyXNIw+JqfAf1ahNu92BLDhCh3EylysBtyx6Qn+Mh
 ztThuy8sPrvb9nciuiyvki17uhUoMfdfLprxxs6ct33wP66QkVlvPEXCpNcOFbjPMz7u
 3LSw==
X-Gm-Message-State: AOJu0YyO71gX6LptPNDqN/dimhy7RxQk8rqlNW1dBLijd0FB2nzPBvha
 vTrBWvVEd6qGI1ul6L+3cu4H3nPKpzquHmMR4ymekYGRyKKjrM/HutEhKFAvpC8bIMlqLgnSHm4
 RerPmRhj41w3yVF2gkIQF/OExeYN6w8Sz52ZAGoFsZO0xdcIC4YHofyhf5JtITdgrb2Doyd3YM7
 w=
X-Received: by 2002:a7b:cb41:0:b0:3fe:1b4e:c484 with SMTP id
 v1-20020a7bcb41000000b003fe1b4ec484mr21025427wmj.5.1693297783914; 
 Tue, 29 Aug 2023 01:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwhBGjj4wNUFiRl/+YOOlt3RXk2y20AelA9KydU78Uf3bON+O3fyt3qNsxiXxECYzkUe629g==
X-Received: by 2002:a7b:cb41:0:b0:3fe:1b4e:c484 with SMTP id
 v1-20020a7bcb41000000b003fe1b4ec484mr21025419wmj.5.1693297783560; 
 Tue, 29 Aug 2023 01:29:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfea4e000000b003142ea7a661sm13042260wrn.21.2023.08.29.01.29.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] contrib/plugins: use an independent makefile
Date: Tue, 29 Aug 2023 10:29:27 +0200
Message-ID: <20230829082931.67601-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829082931.67601-1-pbonzini@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                | 12 +++++++++---
 contrib/plugins/Makefile | 18 +++++++++---------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index b2bc1ff5f7b..4a7e7afb996 100755
--- a/configure
+++ b/configure
@@ -245,7 +245,7 @@ for opt do
   esac
 done
 
-
+default_cflags='-O2 -g'
 git_submodules_action="update"
 git="git"
 debug_tcg="no"
@@ -768,6 +768,7 @@ for opt do
       meson_option_parse --enable-debug-graph-lock ""
       meson_option_parse --enable-debug-mutex ""
       meson_option_add -Doptimization=0
+      default_cflags='-O0 -g'
   ;;
   --disable-tcg) tcg="disabled"
                  plugins="no"
@@ -1763,8 +1764,6 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
-echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
-echo "CC=$cc" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers for KVM architectures
@@ -1789,6 +1788,13 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
+# contrib/plugins configuration
+echo "# Automatically generated by configure - do not modify" > contrib/plugins/$config_host_mak
+echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
+echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
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


