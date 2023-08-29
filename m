Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9925A78C04A
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau78-0002vH-Av; Tue, 29 Aug 2023 04:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6y-0002rV-Uh
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6n-00006e-2c
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1wX7GyzcnzxIJysEaD63+jXx/A14PVyPXKg2CU7Syc=;
 b=UP5/02y86YbwSgJl7xcgQRHJk7oDTB/9sUoqiRRdwPNWVi77cMwS68YrDravho76KEVq2f
 xrGlmzidY8/dHuGf5rGaTQ6zpjFA6Plnpm7xyVzge1iZJ2xV79v8lGqhi1+TwwvYrZ8Bqt
 OhdwPUGgimJGBjKu3yF+Wn/bSFtSSag=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-WiwoOuYaN42uHPGcIQlCEg-1; Tue, 29 Aug 2023 04:29:53 -0400
X-MC-Unique: WiwoOuYaN42uHPGcIQlCEg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c879c41f4so1668691f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297791; x=1693902591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1wX7GyzcnzxIJysEaD63+jXx/A14PVyPXKg2CU7Syc=;
 b=LZhsKypJxLjPayF0GD+Rgsisuwn+fAAsnB9+HBR1da+dn5gd5pE6Z3ZfeSI4k9UFh2
 RbWKqW+OiBntsVBDupIMuvlyvJspPfnryhFl59amq7P/58qm6TnFpJoLyi4yYFlCftbH
 /iWJ+mFv5PeXgTa+PxwlNkRPckODTvirJ12MlvQU3FcISAMAbGxAuca/vKQ4HW72hzN9
 7p77z2wVtY67+eGkCJjEEYl8WuI0u4BQ2n/JjClhaeKNfzhoYOg5Jng/Aefr01POmfVZ
 LduxLl0DiZa9S8JR7mCM9eoZKZU5SEXNDh8Ro4/DEFxiHikCHcsEU25nFSP/zjTGSRo3
 l4mA==
X-Gm-Message-State: AOJu0YwXuoA+LaYqboOUKFPRjXNg+FvvIRCvMjbl/vkMy5TpHLexLmdq
 ld5/Nqb1ZUq5j5wRvgkOYitcEneIZ+dPk34+Xd8baDYmZtQRmXGHtBJ873vDxTsC2QZqwSwUlWH
 1Xj/e/0mbEBLPc06lkZUDq4UtvOdaJQaJbO1aRuksIOHyAIOg5rW2AQs7JnbQs5xQiLuQfynS1W
 U=
X-Received: by 2002:adf:ce82:0:b0:317:5ddd:837b with SMTP id
 r2-20020adfce82000000b003175ddd837bmr20641255wrn.7.1693297791722; 
 Tue, 29 Aug 2023 01:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFCCxBD66AGMOKiJxCA0IaxVqTgazvj4VFj4ztQwSr2NhT1gJJMHfJ8xFvynLr6KgQafX/Bg==
X-Received: by 2002:adf:ce82:0:b0:317:5ddd:837b with SMTP id
 r2-20020adfce82000000b003175ddd837bmr20641241wrn.7.1693297791315; 
 Tue, 29 Aug 2023 01:29:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adffa84000000b003197b85bad2sm13040149wrr.79.2023.08.29.01.29.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/10] configure: move --enable-debug-tcg to meson
Date: Tue, 29 Aug 2023 10:29:31 +0200
Message-ID: <20230829082931.67601-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829082931.67601-1-pbonzini@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 11 +----------
 meson.build                   |  3 ++-
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index aed48db68fd..40729a6d5f5 100755
--- a/configure
+++ b/configure
@@ -248,7 +248,6 @@ done
 default_cflags='-O2 -g'
 git_submodules_action="update"
 git="git"
-debug_tcg="no"
 docs="auto"
 EXESUF=""
 prefix="/usr/local"
@@ -747,13 +746,9 @@ for opt do
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
@@ -948,7 +943,6 @@ cat << EOF
   linux-user      all linux usermode emulation targets
   bsd-user        all BSD usermode emulation targets
   pie             Position Independent Executables
-  debug-tcg       TCG debugging (default is disabled)
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -1699,9 +1693,6 @@ echo >> $config_host_mak
 
 echo all: >> $config_host_mak
 
-if test "$debug_tcg" = "yes" ; then
-  echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
-fi
 if test "$targetos" = "windows"; then
   echo "CONFIG_WIN32=y" >> $config_host_mak
   echo "QEMU_GA_MANUFACTURER=${QEMU_GA_MANUFACTURER-QEMU}" >> $config_host_mak
diff --git a/meson.build b/meson.build
index d3d10140c57..45f9cc62a60 100644
--- a/meson.build
+++ b/meson.build
@@ -2201,6 +2201,7 @@ config_host_data.set10('CONFIG_COROUTINE_POOL', have_coroutine_pool)
 config_host_data.set('CONFIG_DEBUG_GRAPH_LOCK', get_option('debug_graph_lock'))
 config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
+config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
 config_host_data.set('CONFIG_GPROF', get_option('gprof'))
 config_host_data.set('CONFIG_LIVE_BLOCK_MIGRATION', get_option('live_block_migration').allowed())
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
@@ -4158,7 +4159,7 @@ if config_all.has_key('CONFIG_TCG')
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


