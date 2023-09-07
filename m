Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA8E797292
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdh-0003QK-L1; Thu, 07 Sep 2023 09:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdQ-0003Og-Qf
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdO-0007P6-Bh
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xO8PrK9ireQp6JlWOrTfu2NpnIcqw9jxYoX6Yf3VkkY=;
 b=DonoBV6ebovl0ch3QQ+LoHIfp8g5X7i5BmrPfqKOBkhxB2LhpynxhYASNRuUEc7If4od/G
 eWlUY/nakZo1UCu3HCoksCp4Dc6SqqHlBopO/K8UpR9lZ7vD2J4zpwsqLaaF8CD+WMRm7/
 4VgY2lcEqS0F/RGSvV8ELdHHBF6ZyGk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-d-HNnDcqN96DQKJiuleuzA-1; Thu, 07 Sep 2023 09:01:14 -0400
X-MC-Unique: d-HNnDcqN96DQKJiuleuzA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b961c3af8fso11327001fa.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091667; x=1694696467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xO8PrK9ireQp6JlWOrTfu2NpnIcqw9jxYoX6Yf3VkkY=;
 b=GCyD0lpMfZ7Gtr8QK51MIupIElLyFnop0azHUwayYSj8e2G1xXi+pAg8GcqSosXNi+
 Y9VqObrVCTxUN4y7ydg4+d5Vcvy/n9a6VlCTqjU8xgZav5JsjyxU1BXR4p7OXTjBS3iv
 IwfemN2lQVcDt/jxnxCJI/BfWI5yYAgIJg5ZVEyMcsKN2QxfUn0V46Pg9+fyfazxwGG6
 3URY3HtsC8HnhImostoDtRNIavsdnV0Q2nhPZDV/9ZzgtpEZK6T7ShY/EQ852jbvM8S7
 7EcBjP59GAQ0VhcdFLpEJsSDgRiTE+dhMkUkbaiG7ST0kyTaBCeUXR06fBahnjt/1VJD
 0j/A==
X-Gm-Message-State: AOJu0YwvA2M5VyymngHGlAx7nvjOIac9WX/jPsDi/AxcCrcA4EUmWvij
 b/9XAiVeIjC1ROPTC9FFhT2kyotzZBZ9cvSqSLo6iRbhb/6rTnhtDuxzmonGxA1A8NLWDjLQL/Q
 QuqKbGShCzjhGeNNgaQdb/9GbdFlL0lKHc0HWCeZXgg8XVqUmWl4APdwTsAHF2hVoQJywcVX4w4
 c=
X-Received: by 2002:a19:674e:0:b0:501:b97a:9f50 with SMTP id
 e14-20020a19674e000000b00501b97a9f50mr4709117lfj.65.1694091667093; 
 Thu, 07 Sep 2023 06:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp8gpwesdoBiS5aDeFF8957Em9ZTyImvBU+/v+E9g0O2JYhuRTfSD14iJsGFcxOlnLVqx+Wg==
X-Received: by 2002:a19:674e:0:b0:501:b97a:9f50 with SMTP id
 e14-20020a19674e000000b00501b97a9f50mr4709085lfj.65.1694091666543; 
 Thu, 07 Sep 2023 06:01:06 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a05600c2a4300b003feea62440bsm2433877wme.43.2023.09.07.06.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 26/51] configure: move --enable-debug-tcg to meson
Date: Thu,  7 Sep 2023 14:59:35 +0200
Message-ID: <20230907130004.500601-27-pbonzini@redhat.com>
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
index 13f21fd24de..4c3918a34ec 100644
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


