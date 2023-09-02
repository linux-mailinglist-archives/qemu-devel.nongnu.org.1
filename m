Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ACA7907FC
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:01:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEH-00019o-0N; Sat, 02 Sep 2023 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEF-00017I-NW
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQED-0001hj-BB
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/p9QPRRWGG4B7tJGNdk16lD/c2yXoWPGLZHm5emGOI=;
 b=TVNTUe17MXv0/1d2RMAVXOpGsPPIMkeZlGK9DGI9+zxT91kzpUdQTqtg8i8mrtHSnGPMdY
 BURIubN46BKO1Gdr0mekCITTUzUFpQpdOTCxXwjDevVKX5FBD7aFrGG/7jQ58X9WBtvt4f
 t6TLk/8dTOpE+RrtlLBTglAYV3h4+xY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-KgJUtXqLMtyoUBAHnXSOqg-1; Sat, 02 Sep 2023 08:59:51 -0400
X-MC-Unique: KgJUtXqLMtyoUBAHnXSOqg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31aef28315eso1628893f8f.2
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659589; x=1694264389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/p9QPRRWGG4B7tJGNdk16lD/c2yXoWPGLZHm5emGOI=;
 b=gTHhLmQIXkBOaKjb9PGmwxUDxF2/DiY730oi0uKAzGhSmepQPLH4Bab2o8mwq4Kzam
 e+70vaH31zk2WcUmwK+iQaSbO9+Bali3ABDacHRACs+lnX6MSJm86aZBiJ9DguEV4WoL
 WBZ7jXPAlHGGOo9kc4NXBcFkdNuEFaS1dt+gy/zO/gTTnNs9W9V9DpWVtrzLLJLB9O2J
 2Mlky9f454yjbyCY9ElVu5lKZmV88+pTbRi1vK87EzRxdFiQAbdlXnrAYbqN9qQ+FLZ8
 BIsMi6hFuTf+BSTnx4jaVHqjFvYb3hCiTkpCuDF/DSX16NPfV1fwfZaw26Nzx0e3Ycqd
 mYPA==
X-Gm-Message-State: AOJu0YwBYJ5wCGpZV2ti7Xw/n/VmFI/YMsG75K1oguM0EG082KrsHA8k
 7mu82p96LdS0MjIkQXSl5gT0PSLQ1wAVcSZKCq7yJq6QRVeGngR0vpRyq9cdsMgQ6/EpDiXSClL
 yGlPBMkV6uB6GOkjKJbjwnuNmKnaoZW1QeaVtt1v3HY897Tny/R18pbTIReKNF3yYTKM1gyjOGj
 M=
X-Received: by 2002:adf:e7cc:0:b0:31a:dc2e:2db2 with SMTP id
 e12-20020adfe7cc000000b0031adc2e2db2mr4104680wrn.49.1693659589077; 
 Sat, 02 Sep 2023 05:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVzrkjaiVxy4O6lzWDrA2P6ep2m1USAGqFhk+Ffvi1qT+Ce2nvLPzkjhyrmOSJPeMmWwDTCQ==
X-Received: by 2002:adf:e7cc:0:b0:31a:dc2e:2db2 with SMTP id
 e12-20020adfe7cc000000b0031adc2e2db2mr4104673wrn.49.1693659588825; 
 Sat, 02 Sep 2023 05:59:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a5d688c000000b0031ae2a7adb5sm8417559wru.85.2023.09.02.05.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 07/15] configure: move --enable-debug-tcg to meson
Date: Sat,  2 Sep 2023 14:59:26 +0200
Message-ID: <20230902125934.113017-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 11 +----------
 meson.build                   |  3 ++-
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index f96f7359a83..afd6121b616 100755
--- a/configure
+++ b/configure
@@ -248,7 +248,6 @@ done
 
 git_submodules_action="update"
 git="git"
-debug_tcg="no"
 docs="auto"
 EXESUF=""
 prefix="/usr/local"
@@ -727,13 +726,9 @@ for opt do
     # configure to be used by RPM and similar macros that set
     # lots of directory switches by default.
   ;;
-  --enable-debug-tcg) debug_tcg="yes"
-  ;;
-  --disable-debug-tcg) debug_tcg="no"
-  ;;
   --enable-debug)
       # Enable debugging options that aren't excessively noisy
-      debug_tcg="yes"
+      meson_option_parse --enable-debug-tcg ""
       meson_option_parse --enable-debug-graph-lock ""
       meson_option_parse --enable-debug-mutex ""
       meson_option_add -Doptimization=0
@@ -933,7 +928,6 @@ cat << EOF
   linux-user      all linux usermode emulation targets
   bsd-user        all BSD usermode emulation targets
   pie             Position Independent Executables
-  debug-tcg       TCG debugging (default is disabled)
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -1684,9 +1678,6 @@ echo >> $config_host_mak
 
 echo all: >> $config_host_mak
 
-if test "$debug_tcg" = "yes" ; then
-  echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
-fi
 if test "$targetos" = "windows"; then
   echo "CONFIG_WIN32=y" >> $config_host_mak
   echo "QEMU_GA_MANUFACTURER=${QEMU_GA_MANUFACTURER-QEMU}" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 9bcf117f8a4..baf47613650 100644
--- a/meson.build
+++ b/meson.build
@@ -2199,6 +2199,7 @@ config_host_data.set10('CONFIG_COROUTINE_POOL', have_coroutine_pool)
 config_host_data.set('CONFIG_DEBUG_GRAPH_LOCK', get_option('debug_graph_lock'))
 config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
+config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
 config_host_data.set('CONFIG_GPROF', get_option('gprof'))
 config_host_data.set('CONFIG_LIVE_BLOCK_MIGRATION', get_option('live_block_migration').allowed())
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
@@ -4156,7 +4157,7 @@ if config_all.has_key('CONFIG_TCG')
     summary_info += {'TCG backend':   'native (@0@)'.format(cpu)}
   endif
   summary_info += {'TCG plugins': config_host.has_key('CONFIG_PLUGIN')}
-  summary_info += {'TCG debug enabled': config_host.has_key('CONFIG_DEBUG_TCG')}
+  summary_info += {'TCG debug enabled': get_option('debug_tcg')}
 endif
 summary_info += {'target list':       ' '.join(target_dirs)}
 if have_system
diff --git a/meson_options.txt b/meson_options.txt
index aaea5ddd779..5d6b889554c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -83,6 +83,8 @@ option('xen_pci_passthrough', type: 'feature', value: 'auto',
        description: 'Xen PCI passthrough support')
 option('tcg', type: 'feature', value: 'enabled',
        description: 'TCG support')
+option('debug_tcg', type: 'boolean', value: false,
+       description: 'TCG debugging')
 option('tcg_interpreter', type: 'boolean', value: false,
        description: 'TCG with bytecode interpreter (slow)')
 option('safe_stack', type: 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 9da3fe299b7..5567fd29985 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -29,6 +29,7 @@ meson_options_help() {
   printf "%s\n" '  --enable-debug-mutex     mutex debugging support'
   printf "%s\n" '  --enable-debug-stack-usage'
   printf "%s\n" '                           measure coroutine stack usage'
+  printf "%s\n" '  --enable-debug-tcg       TCG debugging'
   printf "%s\n" '  --enable-fdt[=CHOICE]    Whether and how to find the libfdt library'
   printf "%s\n" '                           (choices: auto/disabled/enabled/internal/system)'
   printf "%s\n" '  --enable-fuzzing         build fuzzing targets'
@@ -276,6 +277,8 @@ _meson_option_parse() {
     --disable-debug-mutex) printf "%s" -Ddebug_mutex=false ;;
     --enable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=true ;;
     --disable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=false ;;
+    --enable-debug-tcg) printf "%s" -Ddebug_tcg=true ;;
+    --disable-debug-tcg) printf "%s" -Ddebug_tcg=false ;;
     --enable-dmg) printf "%s" -Ddmg=enabled ;;
     --disable-dmg) printf "%s" -Ddmg=disabled ;;
     --docdir=*) quote_sh "-Ddocdir=$2" ;;
-- 
2.41.0


