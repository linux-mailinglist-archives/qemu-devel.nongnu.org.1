Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2338910533
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jun 2024 15:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHRh-0001dg-Ky; Thu, 20 Jun 2024 09:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRf-0001ZN-FF
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRd-0006XX-Nw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718888596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iwf7E6c/3J88Z/SA0VCe8inq5N9r0YamgWdaOJEaKjI=;
 b=L5t2z541jz3njR7hqht4/0R4goSJspAvJg7z4baSikS5tPT58OQrW82cklj/rAxRpx/MN9
 k1Qb7jXM7ZEx1L3SrYGRzRFc4WLcG0ZnZWKPQit2U1YfBcgnsMH/+8ATpPkF3AvLp7BVBV
 vwHwlVgW80dlBjpC5pHaHCI2ODjmhxU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-HT4FkgtSOBqficcKj9nQlA-1; Thu, 20 Jun 2024 09:03:14 -0400
X-MC-Unique: HT4FkgtSOBqficcKj9nQlA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f381ea95dso95997866b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888589; x=1719493389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iwf7E6c/3J88Z/SA0VCe8inq5N9r0YamgWdaOJEaKjI=;
 b=XCks3BOdljWVWllBsKCwxc8V6E8JiIISLv02whCEcSlxoL+aQ9KHq4jRZlpcR6lqKp
 DjgeXx0kLRq6C3f7mmY46/894BeeXbLqUU4BCY8FTlfNl9ij5aW7QI58oJum8HvGpDrT
 +aBrq4giDhV0tyLmTH6TQRqQMrDtq0Yp2tlqSnilPYFNtAfDQAo8jrwaJPZQz6g2YwD8
 mJ3ua3hE5LI/NUkuS52DQOgP8hK0z/HEvy9u/MDGrwca7ob1NSicn8E5aFupnLq8sXnK
 M6GzjLrZOzJ96VyYNbYcjqR5/gFa+5yB3oGs/+py91eai5Z/vS4Hgu0EuM0kZXRfombN
 jaZQ==
X-Gm-Message-State: AOJu0Yx1VhRQtiVWmjor2+0d+XVvdLHmEaDaj0fkpfWixEGMm/4MhWgU
 Cg+ClMemTRYNREUYlNTe8kfQbp/joGxa93ucSg0IQmYnxJ2KnwcENGL2NKCs2BwXTnFfx0zqjfd
 3wnkEQJ3XlVFYcOPJ2aB8az7FmZU/HnP7NSnrMOVgJZSRBTgHGiZXWkkciIwq/lKglmXNRpEObp
 Baify9TfLtK4ZZjXxAdLAxgJyHK3FooWpDpGOH
X-Received: by 2002:a17:907:d406:b0:a6f:b3d3:fed1 with SMTP id
 a640c23a62f3a-a6fb3d3ff9amr349855966b.10.1718888589526; 
 Thu, 20 Jun 2024 06:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiSJLs3cJDkV1a8dXVrEgjyYHTGJQZ9qlBvN3pTMTX7278kHPx4iAieDTnOiF58k34uOGKkA==
X-Received: by 2002:a17:907:d406:b0:a6f:b3d3:fed1 with SMTP id
 a640c23a62f3a-a6fb3d3ff9amr349853266b.10.1718888589199; 
 Thu, 20 Jun 2024 06:03:09 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd2asm778117266b.141.2024.06.20.06.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:03:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru
Subject: [PATCH 4/6] meson: allow configuring the x86-64 baseline
Date: Thu, 20 Jun 2024 15:02:52 +0200
Message-ID: <20240620130254.415699-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620130254.415699-1-pbonzini@redhat.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 41 ++++++++++++++++++++++++++++-------
 meson_options.txt             |  3 +++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 97e00d6f59b..6e694ecd9fe 100644
--- a/meson.build
+++ b/meson.build
@@ -336,15 +336,40 @@ if host_arch == 'i386' and not cc.links('''
   qemu_common_flags = ['-march=i486'] + qemu_common_flags
 endif
 
-# Assume x86-64-v2 (minus CMPXCHG16B for 32-bit code)
-if host_arch == 'i386'
-  qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
-endif
+# Pick x86-64 baseline version
 if host_arch in ['i386', 'x86_64']
-  qemu_common_flags = ['-mpopcnt', '-msse4.2'] + qemu_common_flags
-endif
-if host_arch == 'x86_64'
-  qemu_common_flags = ['-mcx16'] + qemu_common_flags
+  if get_option('x86_version') == '0' and host_arch == 'x86_64'
+    error('x86_64-v1 required for x86-64 hosts')
+  endif
+
+  # add flags for individual instruction set extensions
+  if get_option('x86_version') >= '1'
+    if host_arch == 'i386'
+      qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
+    else
+      # present on basically all processors but technically not part of
+      # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
+      qemu_common_flags = ['-mcx16'] + qemu_common_flags
+    endif
+  endif
+  if get_option('x86_version') >= '2'
+    qemu_common_flags = ['-mpopcnt'] + qemu_common_flags
+    qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
+  endif
+  if get_option('x86_version') >= '3'
+    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi1', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+  endif
+
+  # add required vector instruction set (each level implies those below)
+  if get_option('x86_version') == '1'
+    qemu_common_flags = ['-msse2'] + qemu_common_flags
+  elif get_option('x86_version') == '2'
+    qemu_common_flags = ['-msse4.2'] + qemu_common_flags
+  elif get_option('x86_version') == '3'
+    qemu_common_flags = ['-mavx2'] + qemu_common_flags
+  elif get_option('x86_version') == '4'
+    qemu_common_flags = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl'] + qemu_common_flags
+  endif
 endif
 
 if get_option('prefer_static')
diff --git a/meson_options.txt b/meson_options.txt
index 7a79dd89706..6065ed2d352 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -370,3 +370,6 @@ option('qemu_ga_version', type: 'string', value: '',
 
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
+
+option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
+       description: 'tweak required x86_64 architecture version beyond compiler default')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 58d49a447d5..62842d47e88 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -82,6 +82,8 @@ meson_options_help() {
   printf "%s\n" '  --with-suffix=VALUE      Suffix for QEMU data/modules/config directories'
   printf "%s\n" '                           (can be empty) [qemu]'
   printf "%s\n" '  --with-trace-file=VALUE  Trace file prefix for simple backend [trace]'
+  printf "%s\n" '  --x86-version=CHOICE     tweak required x86_64 architecture version beyond'
+  printf "%s\n" '                           compiler default [1] (choices: 0/1/2/3)'
   printf "%s\n" ''
   printf "%s\n" 'Optional features, enabled with --enable-FEATURE and'
   printf "%s\n" 'disabled with --disable-FEATURE, default is enabled if available'
@@ -552,6 +554,7 @@ _meson_option_parse() {
     --disable-werror) printf "%s" -Dwerror=false ;;
     --enable-whpx) printf "%s" -Dwhpx=enabled ;;
     --disable-whpx) printf "%s" -Dwhpx=disabled ;;
+    --x86-version=*) quote_sh "-Dx86_version=$2" ;;
     --enable-xen) printf "%s" -Dxen=enabled ;;
     --disable-xen) printf "%s" -Dxen=disabled ;;
     --enable-xen-pci-passthrough) printf "%s" -Dxen_pci_passthrough=enabled ;;
-- 
2.45.2


