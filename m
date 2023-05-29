Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09190714F52
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 20:21:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3hU1-0007dQ-0n; Mon, 29 May 2023 14:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hTu-0007cw-Jn
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:20:34 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hTs-00018a-RP
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:20:34 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-75b01271ad4so200713685a.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1685384428; x=1687976428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnYi90ggTG0Ds7eZTyC/rI0dhRliL/IK6cmFzV+ubwg=;
 b=SwKgh8ZvhC1yKIvPXbfjcwSnnX3zqussFaWo1bU1+vxKVtwNuj05/liiix4rzTSwXv
 tMD2TvKuWdyjc4ASMnrCWgy7WNKjQsQb8bOPKqccxuyJQNr72T6IhfmjM+2C+vXWmBq7
 HxIPPsLr2mhfZA2pLo4VwIuep+sHgs8teZYnfZ5MYEA847ghPuWTWlsAx/ACB793dpBn
 iAnebh73K4FMr6MY0Pb2izvUX6ucSFObcA0TM8QltHiMEsU8+Tk+HDOcgb6Xc8zqotry
 VHqxVZWxC0f1/soAhPN3FrBZlZ2WQMYqcj8I9qJemI0de/lCX5ECuvD2Z/JUgARsTF/0
 uniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685384428; x=1687976428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnYi90ggTG0Ds7eZTyC/rI0dhRliL/IK6cmFzV+ubwg=;
 b=dlHBPsO8jUiskfHtv9LrFcKt4sR9nIQKoNuIJxWSes/aQXquH6VWKNtPZhiDX5de8v
 KpRIVetf6YbHuSPeWFVNqej+1fg099455+mSlUJCaiX5KznCFLwNrTMH8+ydWC7gY9Tl
 MmdDlX8euTCzz/+s9t7A2+hIPu7e6KdfLPHMIWE6plUdM/gQdahNYpgANJrbUH1CNM3C
 SS3KJSZpvfADkKFt12jCOqWI2UhWIcUu/Qbt8d5i8M6SX1BTW+Il6EP5kCrPFQru9J5r
 rBWsQp+10bFP0Vr7QTujEEgUDhaVxt+VARzVWm6A9YnZl8T5V1227aNMz7Np9kdCAUSA
 zeGg==
X-Gm-Message-State: AC+VfDzxk0s9fz4wko3Io+pj7d6/RIekresJUPMmRobo5XdRxmF3n6MD
 0iHfBLbyTAjI2LvwsuTDmWFhiA==
X-Google-Smtp-Source: ACHHUZ7dOVC6aFr2aRPppOQTh1ca6A8WzVvbcj4g4qV0zfZtKtqkaZbktCJQ4EuZYGKt59WqEAyVrA==
X-Received: by 2002:a05:620a:4454:b0:75b:7eea:8178 with SMTP id
 w20-20020a05620a445400b0075b7eea8178mr10218452qkp.47.1685384428757; 
 Mon, 29 May 2023 11:20:28 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.95])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a05620a126f00b0074e3cf3b44dsm2873314qkl.125.2023.05.29.11.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 11:20:28 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com,
	quintela@redhat.com,
	qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 1/4] Introduce new instruction set enqcmd/mmovdir64b to the
 build system.
Date: Mon, 29 May 2023 18:19:58 +0000
Message-Id: <20230529182001.2232069-2-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230529182001.2232069-1-hao.xiang@bytedance.com>
References: <20230529182001.2232069-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72e.google.com
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

1. Enable instruction set enqcmd in build.
2. Enable instruction set movdir64b in build.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 meson.build                   | 3 +++
 meson_options.txt             | 4 ++++
 scripts/meson-buildoptions.sh | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/meson.build b/meson.build
index 2d48aa1e2e..46f1bb2e34 100644
--- a/meson.build
+++ b/meson.build
@@ -2682,6 +2682,8 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
     int main(int argc, char *argv[]) { return bar(argv[0]); }
   '''), error_message: 'AVX512BW not available').allowed())
 
+config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd'))
+
 have_pvrdma = get_option('pvrdma') \
   .require(rdma.found(), error_message: 'PVRDMA requires OpenFabrics libraries') \
   .require(cc.compiles(gnu_source_prefix + '''
@@ -4123,6 +4125,7 @@ summary_info += {'memory allocator':  get_option('malloc')}
 summary_info += {'avx2 optimization': config_host_data.get('CONFIG_AVX2_OPT')}
 summary_info += {'avx512bw optimization': config_host_data.get('CONFIG_AVX512BW_OPT')}
 summary_info += {'avx512f optimization': config_host_data.get('CONFIG_AVX512F_OPT')}
+summary_info += {'dsa acceleration': config_host_data.get('CONFIG_DSA_OPT')}
 if get_option('gprof')
   gprof_info = 'YES (deprecated)'
 else
diff --git a/meson_options.txt b/meson_options.txt
index 90237389e2..51097da56c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -117,6 +117,10 @@ option('avx512f', type: 'feature', value: 'disabled',
        description: 'AVX512F optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
+option('enqcmd', type: 'boolean', value: false,
+       description: 'MENQCMD optimizations')
+option('movdir64b', type: 'boolean', value: false,
+       description: 'MMOVDIR64B optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5714fd93d9..5ef4ec36f4 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -81,6 +81,8 @@ meson_options_help() {
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
   printf "%s\n" '  avx512f         AVX512F optimizations'
+  printf "%s\n" '  enqcmd          ENQCMD optimizations'
+  printf "%s\n" '  movdir64b       MOVDIR64B optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -221,6 +223,10 @@ _meson_option_parse() {
     --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
     --enable-avx512f) printf "%s" -Davx512f=enabled ;;
     --disable-avx512f) printf "%s" -Davx512f=disabled ;;
+    --enable-enqcmd) printf "%s" -Denqcmd=true ;;
+    --disable-enqcmd) printf "%s" -Denqcmd=false ;;
+    --enable-movdir64b) printf "%s" -Dmovdir64b=true ;;
+    --disable-movdir64b) printf "%s" -Dmovdir64b=false ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
2.30.2


