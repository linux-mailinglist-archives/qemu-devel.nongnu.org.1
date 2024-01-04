Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5BE8239D5
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:48:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs8-0008Lt-36; Wed, 03 Jan 2024 19:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrk-0008Gp-7U
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:45 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBri-0007Pw-HC
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:43 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2041e117abaso8681fac.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329140; x=1704933940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IO3Ie4egqGOtmOg4OF6nYboztJYDYrxjcZeUtfIJV84=;
 b=eaAWqJnQpjEM99LpikdSq2rRZg2mPhcluMxM3Rp2F2spTn4XBpQ5DgFMuFUy3So8Um
 wSnQj1Hd+/o1jET/nWxwPd1zqEj43Jy0VUYsp+t2G9CBk3wfKMPg5gxYwl6s1a0K8Yla
 iq2uIJrBPYmDgMWT3oWHb1BeoGRpnYz8jIYNvUXDTYSDpJxKLdbP0lHLFGt/6cQbU7mn
 kQR0MGZS2sYVHciq6xUhYT+I+puH0fc3yijnU9WN/IUnNnfKH7M5XjuTiHRncn5j0Asp
 8f7D+ryNWSo3hhqh2ST1aL+SS3ue9hG+GOGiXD0Ng3oCFjMt5EDN6x33gE6yBv94mp0W
 zEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329140; x=1704933940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IO3Ie4egqGOtmOg4OF6nYboztJYDYrxjcZeUtfIJV84=;
 b=e/MgduTY2PVjMcPJPI7oxK8yLDksxA6sU8HTm/p7wHXQCGaznuMN7rD4fqkaFsM2DL
 Z/d4TTEXEWalIkpxjdM9CXJq7m8LFH583X+vtPzh+5HpA20fTB59xlcpR5LufvV2HRw9
 5Peh3X7T3cFRwYy7wDHlCUo8EbNFKEIAv2zdNL1T/vj9gPIpxmifhZzuhK+yZPOO3mXE
 lAQuZoMjQ7pKmfRFlvHLfgpr7EmeoYFd2G/J8JmpFu2y49FD5jGdEJt3RXHYnpPKvyc9
 oDup/+gE2hlK2+2t6rSAeIR+2PBCgzdBDPhCzvwAS+gKiVsvB362gyOvkJwTTp+xmAtr
 4raA==
X-Gm-Message-State: AOJu0YwNEIPNPXvO3OpiUVdu9tURCHk7d0VR9u0HsmTK+nYcx7U9/XWF
 502zB6BapLbF4rriefhrZcLGUas1qbGP+A==
X-Google-Smtp-Source: AGHT+IE1wHt4I1z2MBxJPt32D6G7I97ZgXISyv8R9NmFNcuyS7LLowAHDT+1pnwZyNezwYyQMv69iA==
X-Received: by 2002:a05:6870:1782:b0:203:dbec:d78d with SMTP id
 r2-20020a056870178200b00203dbecd78dmr14433497oae.38.1704329140063; 
 Wed, 03 Jan 2024 16:45:40 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:39 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 05/20] meson: Introduce new instruction set enqcmd to the
 build system.
Date: Thu,  4 Jan 2024 00:44:37 +0000
Message-Id: <20240104004452.324068-6-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Enable instruction set enqcmd in build.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 meson.build                   | 14 ++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/meson.build b/meson.build
index 6c77d9687d..ea10d99cf4 100644
--- a/meson.build
+++ b/meson.build
@@ -2712,6 +2712,20 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
     int main(int argc, char *argv[]) { return bar(argv[0]); }
   '''), error_message: 'AVX512BW not available').allowed())
 
+config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd') \
+  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable ENQCMD') \
+  .require(cc.links('''
+    #include <stdint.h>
+    #include <cpuid.h>
+    #include <immintrin.h>
+    static int __attribute__((target("enqcmd"))) bar(void *a) {
+      uint64_t dst[8] = { 0 };
+      uint64_t src[8] = { 0 };
+      return _enqcmd(dst, src);
+    }
+    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
+  '''), error_message: 'ENQCMD not available').allowed())
+
 # For both AArch64 and AArch32, detect if builtins are available.
 config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
     #include <arm_neon.h>
diff --git a/meson_options.txt b/meson_options.txt
index c9baeda639..618970d0f7 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -121,6 +121,8 @@ option('avx512f', type: 'feature', value: 'disabled',
        description: 'AVX512F optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
+option('enqcmd', type: 'feature', value: 'disabled',
+       description: 'MENQCMD optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 option('libkeyutils', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 680fa3f581..c1389ff109 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -93,6 +93,7 @@ meson_options_help() {
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
   printf "%s\n" '  avx512f         AVX512F optimizations'
+  printf "%s\n" '  enqcmd          ENQCMD optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -240,6 +241,8 @@ _meson_option_parse() {
     --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
     --enable-avx512f) printf "%s" -Davx512f=enabled ;;
     --disable-avx512f) printf "%s" -Davx512f=disabled ;;
+    --enable-enqcmd) printf "%s" -Denqcmd=enabled ;;
+    --disable-enqcmd) printf "%s" -Denqcmd=disabled ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
2.30.2


