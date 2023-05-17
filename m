Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42122707042
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGu-0004Cs-PD; Wed, 17 May 2023 13:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEn-0001sQ-Au
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEk-0004RV-UK
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMLDcjqwDF35UrdRcpPmiRXSC/LtqcCJfvAbqBE3Sw4=;
 b=bxkSlmOOEoVPJvjv0lgGggcuaBp/pa3KgNh8o0sZDo14vC6oPOn+0yOIzEvybjjYCkZZyJ
 8Oud1TfyXI1dwD5PDDvfzpsPD2v48VPgPzXpdAWYE1L6RWfQ9lDrvsGvMsDsxUtpOqccpm
 biV/vtiD+Kg/PqLB+mFcHXnBR42sUbQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-8RLDpEesOCqGtX-dvC4cig-1; Wed, 17 May 2023 13:46:53 -0400
X-MC-Unique: 8RLDpEesOCqGtX-dvC4cig-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f426d4944fso4324735e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345611; x=1686937611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMLDcjqwDF35UrdRcpPmiRXSC/LtqcCJfvAbqBE3Sw4=;
 b=EgHsaOylgNrHvFv42G9S1mWq+gWVNXBmGxyiz+eYlq0fc3mNK85jcXLnteIOZUN/R4
 tTi1lxwErp5aDodeLK7SSUirw5FwcNJ0fhaz+PCKmWsOUrVh0MVsUvE4cpAPEd/L3nlL
 AJU/w9/Z2Uh5lgaqR0iS9rYVQeMaEdND1T8n6gqRBx1S3hERL3TBW9cQ2m9fiYLsJrOO
 9j4ua+JGE4e0GxJkFQ7Zz+7GJuKUR3JIj7TRyvMSazny0S46hr6iv3VkYBYAvCdHINEM
 E50Q2Ibc4tzFEqpm6ummQ70Q25uGoGyDcqojuTZNp6JwbSBWYkMQ1Fslj2Aqy4zWCo9y
 SsNQ==
X-Gm-Message-State: AC+VfDxd+I3Yv11EKl9ULKmwi6FhoIubpeE63E2cKroFuyWF6py7BnoP
 xJ+uT+vhEEiaC5RMPeWyNx83GPjNp1ARrXw/EKwT1ez9BswglgKb+atkIuLXQ3/M/88lhXRinnw
 Svml+pvwRw9xPb2ukyt89XlbV0DpoBWCKDjohi5++Gxm/QKl1p281eop3kwGR5Dxf7STO0KB8/c
 c=
X-Received: by 2002:a1c:7507:0:b0:3f1:9acf:8682 with SMTP id
 o7-20020a1c7507000000b003f19acf8682mr26759930wmc.17.1684345611464; 
 Wed, 17 May 2023 10:46:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Oq4Z6v3OC/KDEy3PEPoX1r6ZlU3Pxr0O8QmMS8lqcv/RDfL79kREE55HRiaNB6L+l2avYlA==
X-Received: by 2002:a1c:7507:0:b0:3f1:9acf:8682 with SMTP id
 o7-20020a1c7507000000b003f19acf8682mr26759921wmc.17.1684345611064; 
 Wed, 17 May 2023 10:46:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a7bc341000000b003f31cb7a203sm3065845wmj.14.2023.05.17.10.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 54/68] meson: prepare move of QEMU_CFLAGS to meson
Date: Wed, 17 May 2023 19:45:06 +0200
Message-Id: <20230517174520.887405-55-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

Clean up the handling of compiler flags in meson.build, splitting
the general flags that should be included in subprojects as well,
from warning flags that only apply to QEMU itself.  The two were
mixed in both configure tests and meson tests.

This split makes it easier to move the compiler tests piecewise
from configure to Meson.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index 531f7a84c9aa..f162ed4e335f 100644
--- a/meson.build
+++ b/meson.build
@@ -190,10 +190,23 @@ endif
 # Compiler flags #
 ##################
 
-qemu_cflags = config_host['QEMU_CFLAGS'].split()
+qemu_common_flags = []
+qemu_cflags = []
+foreach arg : config_host['QEMU_CFLAGS'].split()
+  if arg.startswith('-W')
+    qemu_cflags += arg
+  else
+    qemu_common_flags += arg
+  endif
+endforeach
 qemu_objcflags = config_host['QEMU_OBJCFLAGS'].split()
 qemu_ldflags = config_host['QEMU_LDFLAGS'].split()
 
+if get_option('gprof')
+  qemu_common_flags += ['-p']
+  qemu_ldflags += ['-p']
+endif
+
 if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
@@ -207,10 +220,9 @@ if targetos == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
 
-if get_option('gprof')
-  qemu_cflags += ['-p']
-  qemu_objcflags += ['-p']
-  qemu_ldflags += ['-p']
+# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
+if targetos != 'sunos' and not config_host.has_key('CONFIG_TSAN')
+  qemu_ldflags += cc.get_supported_link_arguments('-Wl,--warn-common')
 endif
 
 # Specify linker-script with add_project_link_arguments so that it is not placed
@@ -226,8 +238,7 @@ if get_option('fuzzing')
                   name: '-fsanitize-coverage-allowlist=/dev/null',
                  args: ['-fsanitize-coverage-allowlist=/dev/null',
                         '-fsanitize-coverage=trace-pc'] )
-    add_global_arguments('-fsanitize-coverage-allowlist=instrumentation-filter',
-                         native: false, language: all_languages)
+    qemu_common_flags += ['-fsanitize-coverage-allowlist=instrumentation-filter']
   endif
 
   if get_option('fuzzing_engine') == ''
@@ -235,10 +246,8 @@ if get_option('fuzzing')
     # compiled code.  To build non-fuzzer binaries with --enable-fuzzing, link
     # everything with fsanitize=fuzzer-no-link. Otherwise, the linker will be
     # unable to bind the fuzzer-related callbacks added by instrumentation.
-    add_global_arguments('-fsanitize=fuzzer-no-link',
-                         native: false, language: all_languages)
-    add_global_link_arguments('-fsanitize=fuzzer-no-link',
-                              native: false, language: all_languages)
+    qemu_common_flags += ['-fsanitize=fuzzer-no-link']
+    qemu_ldflags += ['-fsanitize=fuzzer-no-link']
     # For the actual fuzzer binaries, we need to link against the libfuzzer
     # library. They need to be configurable, to support OSS-Fuzz
     fuzz_exe_ldflags = ['-fsanitize=fuzzer']
@@ -249,6 +258,9 @@ if get_option('fuzzing')
   endif
 endif
 
+add_global_arguments(qemu_common_flags, native: false, language: all_languages)
+add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+
 # Check that the C++ compiler exists and works with the C compiler.
 link_language = 'c'
 linker = cc
@@ -272,16 +284,9 @@ if 'cpp' in all_languages
   endif
 endif
 
-# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
-if targetos != 'sunos' and not config_host.has_key('CONFIG_TSAN')
-  qemu_ldflags += linker.get_supported_link_arguments('-Wl,--warn-common')
-endif
-
-add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
-
-add_global_arguments(qemu_cflags, native: false, language: 'c')
-add_global_arguments(qemu_cxxflags, native: false, language: 'cpp')
-add_global_arguments(qemu_objcflags, native: false, language: 'objc')
+add_project_arguments(qemu_cflags, native: false, language: 'c')
+add_project_arguments(qemu_cxxflags, native: false, language: 'cpp')
+add_project_arguments(qemu_objcflags, native: false, language: 'objc')
 if targetos == 'linux'
   add_project_arguments('-isystem', meson.current_source_dir() / 'linux-headers',
                         '-isystem', 'linux-headers',
@@ -3844,12 +3849,12 @@ link_args = get_option(link_language + '_link_args')
 if link_args.length() > 0
   summary_info += {'LDFLAGS':         ' '.join(link_args)}
 endif
-summary_info += {'QEMU_CFLAGS':       ' '.join(qemu_cflags)}
+summary_info += {'QEMU_CFLAGS':       ' '.join(qemu_common_flags + qemu_cflags)}
 if 'cpp' in all_languages
-  summary_info += {'QEMU_CXXFLAGS':     ' '.join(qemu_cxxflags)}
+  summary_info += {'QEMU_CXXFLAGS':     ' '.join(qemu_common_flags + qemu_cxxflags)}
 endif
 if 'objc' in all_languages
-  summary_info += {'QEMU_OBJCFLAGS':    ' '.join(qemu_objcflags)}
+  summary_info += {'QEMU_OBJCFLAGS':    ' '.join(qemu_common_flags + qemu_objcflags)}
 endif
 summary_info += {'QEMU_LDFLAGS':      ' '.join(qemu_ldflags)}
 summary_info += {'profiler':          get_option('profiler')}
-- 
2.40.1


