Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 283937D748D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:41:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjj9-0000r5-I9; Wed, 25 Oct 2023 15:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjj6-0000qO-8K
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:36 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjj4-00067x-6G
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:36 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77774120c6eso9820985a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262771; x=1698867571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkO/a2qNKiS9VIoexxTIyQuXXrYV6TaKvpeGj8t7mHo=;
 b=HWO6ZxZzRteklyRhKTZFvPr3SotPCCmYKMCodTRwHvO9KLC46RDQSEShHDbyPtBrap
 F98Qr0YMn5pQ7Rqw9Akv8VmworE1D9/SwCIltTJKH10F6m6oOXqYxLU5Q0cyEIWjLB3k
 6+syEy3IrMBF9FCf/T9xLdj/mQcbK6jOJ8yu17dOW0AEfoj35Ha8hjvHuzjmRDiVmhxT
 Xp6qgFfWmCIibjsIbXUdluJa6nRcXcZ7nepLqmUZwB+98iCAdvf6kh4qBrVRUkMdk+jV
 eivYvTjh9hsHPpWEFGb+5dmIsLRSgiWkl53iIjlG6I3NtRdXeiQ+P1W3mKM5QugeYc6w
 RJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262771; x=1698867571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkO/a2qNKiS9VIoexxTIyQuXXrYV6TaKvpeGj8t7mHo=;
 b=dFyvDKne51tg2DfrSncCOHCGo4EMCqc129OBIZm4hLA7DyWtWzCXi96Zumn3jGwYTI
 GRUhHxuMU1unJ7cIBFknLDhmIfVl6SCqlxgfjzxHpHSeCd6Jcv55EZXL7R6qIzLiYuth
 iGWcR3O3ma3ICm/5IjsEpWPbkjc+iAd08n6Pzs5YeI/i1leJQ2h9tt2CiaIPBgS9jor4
 bs830CiRBUQXa5CxuO4XnmaIgWztqVN/FFYhhi3MCQW/BW5MDwTcsQgZSQQE9j44+VVM
 AJhz2EnWkRd1Sn2T9Vd8SzyRxhQMkGsb+aa4RZ4WYyhTSbHLdL1fkJyZeNgFA7eZG7c3
 050A==
X-Gm-Message-State: AOJu0YxNvRRWOHnOD+BRGS6KDkodCF9zubzfEjqKBzkbInisa6C/qOJG
 1mF+LPZ8D5JUz/4JkK7nZvs7MQ==
X-Google-Smtp-Source: AGHT+IFpSmF6V6lIvHNkvZQofGD3hVcEcMNevdLuz1pAGweH0jrhMdsUHqX8To7n5vdxQ8BcexusRA==
X-Received: by 2002:a05:620a:981:b0:778:8f98:96a with SMTP id
 x1-20020a05620a098100b007788f98096amr15248990qkx.21.1698262771318; 
 Wed, 25 Oct 2023 12:39:31 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:31 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 02/16] meson: Introduce new instruction set enqcmd to the
 build system.
Date: Wed, 25 Oct 2023 19:38:08 +0000
Message-Id: <20231025193822.2813204-3-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enable instruction set enqcmd in build.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 meson.build                   | 2 ++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/meson.build b/meson.build
index bd65a111aa..6ea859829c 100644
--- a/meson.build
+++ b/meson.build
@@ -2661,6 +2661,8 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
     int main(int argc, char *argv[]) { return bar(argv[0]); }
   '''), error_message: 'AVX512BW not available').allowed())
 
+config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd'))
+
 # For both AArch64 and AArch32, detect if builtins are available.
 config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
     #include <arm_neon.h>
diff --git a/meson_options.txt b/meson_options.txt
index 6a17b90968..029be1df9f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -119,6 +119,8 @@ option('avx512f', type: 'feature', value: 'disabled',
        description: 'AVX512F optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
+option('enqcmd', type: 'boolean', value: false,
+       description: 'MENQCMD optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 option('libkeyutils', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 2a74b0275b..768f2d7627 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -82,6 +82,7 @@ meson_options_help() {
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
   printf "%s\n" '  avx512f         AVX512F optimizations'
+  printf "%s\n" '  enqcmd          ENQCMD optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -224,6 +225,8 @@ _meson_option_parse() {
     --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
     --enable-avx512f) printf "%s" -Davx512f=enabled ;;
     --disable-avx512f) printf "%s" -Davx512f=disabled ;;
+    --enable-enqcmd) printf "%s" -Denqcmd=true ;;
+    --disable-enqcmd) printf "%s" -Denqcmd=false ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
2.30.2


