Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 691CC7EAA28
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:42:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBM-0007DR-3l; Tue, 14 Nov 2023 00:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBK-0007DD-9q
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:50 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBA-0001S3-L1
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:42 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-77897c4ac1fso337145285a.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940499; x=1700545299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46PzmwJ0rU1BgPMUK6fRjq2lrI+tOWnmggKPgnPdDUc=;
 b=jzhW8etf1OERKsagiH41GruwoD9J3vrMJu3EV/W4yyu8jBzGgjvnkLvCd1FRTmDXKX
 zDLoiCqXkx4cz5z3iGiIaKl9wT9uBS7zslobacUAsL3y7UTOE2kg6VZpRWBXWEJU5UlW
 /LlWvvIw9rsEKnN6r2B1XsA3oPChIte5+AggdRXnJRzLgxE+J8TZA81hqaRdtzgrKBf8
 5DJyR/9JeyQdmkPll8Sae8utxG8BrnsmsRp+bZhfp5qOyYlSw6QzNtcb4tQQn6tBb+uz
 ok9SGaXTJ/N7h4uYEqPbOZdtfNenzQovo9QKb0qi1FuLXMnEfSWugyTHTiFfMsGxwj9J
 QTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940499; x=1700545299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46PzmwJ0rU1BgPMUK6fRjq2lrI+tOWnmggKPgnPdDUc=;
 b=Y+nZLCHYBCeqQXPu1b78TzfSX5dpdesLFM5xnyCo5VhzOKZVPkOn/HmzURcq/gUfHg
 gCYQd8uEq0SVHyiNvHMR53kiCNl4D34+ZFNJgZG2B7babvwSf6fNOGasHXjsC+jpdQff
 qzwUnM3pblcIRfcBoGi1j/RI5VqqaBrGs8Hea6WvissfpH5mgHi83PgCKTs2kqGiVqZO
 iFvQ7McMaHoTZrLsKNDiAsk5cFbwU1JoyAkZGPj7r3RCV0Awk4+QkAL96T1SgGvALyEq
 DnIfxgK7tSNnZPgGJJEKhU4OpzAW1uBSxm8IyHBhOlJPm1BQTGrBROcTEkbVZ/WJASZ0
 u1Qw==
X-Gm-Message-State: AOJu0Yx7xC50OzEX6d5HYY1aQG8Z+DqYBR7bC4nlOEVni6A49/PuXdsT
 eSgOmfruiSKTdFs+oLvMwZB2ag==
X-Google-Smtp-Source: AGHT+IHu1ZUJ3vrKX++qgwRLRZzIaj64AoP0XD7TSD8cVd1C4uYmtsCPB9epKzTD8/rrgRyUQRZf+g==
X-Received: by 2002:a05:620a:6a83:b0:778:8dc1:bb7b with SMTP id
 ud3-20020a05620a6a8300b007788dc1bb7bmr1260865qkn.27.1699940499397; 
 Mon, 13 Nov 2023 21:41:39 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:39 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 05/20] meson: Introduce new instruction set enqcmd to the
 build system.
Date: Tue, 14 Nov 2023 05:40:17 +0000
Message-Id: <20231114054032.1192027-6-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72b.google.com
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
 meson.build                   | 2 ++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/meson.build b/meson.build
index ec01f8b138..1292ab78a3 100644
--- a/meson.build
+++ b/meson.build
@@ -2708,6 +2708,8 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
     int main(int argc, char *argv[]) { return bar(argv[0]); }
   '''), error_message: 'AVX512BW not available').allowed())
 
+config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd'))
+
 # For both AArch64 and AArch32, detect if builtins are available.
 config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
     #include <arm_neon.h>
diff --git a/meson_options.txt b/meson_options.txt
index c9baeda639..6fe8aca181 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -121,6 +121,8 @@ option('avx512f', type: 'feature', value: 'disabled',
        description: 'AVX512F optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
+option('enqcmd', type: 'boolean', value: false,
+       description: 'MENQCMD optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 option('libkeyutils', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 680fa3f581..bf139e3fb4 100644
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
+    --enable-enqcmd) printf "%s" -Denqcmd=true ;;
+    --disable-enqcmd) printf "%s" -Denqcmd=false ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
2.30.2


