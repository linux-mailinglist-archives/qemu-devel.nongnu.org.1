Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FE78D01A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mm-0000c8-8W; Tue, 29 Aug 2023 19:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nN-0002PK-JH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nK-00049Z-Je
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68bec3a9bdbso3174541b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346561; x=1693951361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80yiBDrasGbCP19yEMmSaaDi0ipiYiAfvI51hXAWE6g=;
 b=dgJs6X4nB1fJ6mdNPymBrmOQXNgHyf5e5yomo65NlYcdHUzOIcmgFlhnj81MuPCaay
 5zNQ/067rPBKGclMhC/nXkXaMbQZ7Dq/Fg9eSbBbuBp9P4nQVp6K+uoNDEvWAgb5bpYR
 6CRiMKxESMMreg5vJFSegn21HXkdRsd9cTkcAGXqiREtX1LTgmt3JC6li/BHLZ2l671W
 Ew5Y4CghLbbGFbp9xAClIEjOp32VL5F4tsPIGAeUTnIh2LIscovwbYzCxlaboF2hY5BM
 pHM46GkcADtJJHCRAWYaHMuPR0bAjCc3g5nTdVZpQOPu/nK6nNRjEldrR6DKQsmYPZEA
 ypUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346561; x=1693951361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=80yiBDrasGbCP19yEMmSaaDi0ipiYiAfvI51hXAWE6g=;
 b=d/TdtwsE068REjxigskaZnwBeLIm9cO8gjBEHhWFm3M1zad83V5U7hzRU2CTudCUMO
 MEaVfl8XN5uuRM/FMeYXPDrjxTWCEwquxhIL+9x06XAk9G/ExGnLErN7T3EXEracTPJy
 Ho3Fmm46JCtybygwSMN/9VCuzkZLb5pY4g476/49QUUpoyI61967bztFObuLepJx2TWX
 queBtzKWwXGOADo+lOMBZ2SOTBeKx4WrZltwVrsVE9RO8pKACetgwCIqEW4tcKZfW5TY
 9C8raKY5YVC5bYgUjFE7bc20XOAD10XXv0qBDuIPd7V5kOogT+CGlRtop+WgOGxdXsz4
 dXxw==
X-Gm-Message-State: AOJu0YzN3CPbzw9GTdy/tK/fW4U99RGY8B7PqqjugVzlnoBLRfLDz3yW
 UJsPTeOiu+pyUlbNSbX6UGCmlvL86Ok30wMV3ec=
X-Google-Smtp-Source: AGHT+IEYqtmEs7UyU5CQp9LYocu2HIox4mly2xbtEHjXx70NdGvFzU0cqrnaw/OJwURc0JC1VzjANQ==
X-Received: by 2002:a05:6a00:3982:b0:675:ef91:7922 with SMTP id
 fi2-20020a056a00398200b00675ef917922mr568966pfb.4.1693346559671; 
 Tue, 29 Aug 2023 15:02:39 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 10/20] linux-user: Add build-vdso.sh tool
Date: Tue, 29 Aug 2023 15:02:18 -0700
Message-Id: <20230829220228.928506-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

A shell script to build the vdso using the cross-compiler
makefile fragment.  If none detected, fall back to copying
the pre-build vdso from the source directory.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/build-vdso.sh | 31 +++++++++++++++++++++++++++++++
 linux-user/meson.build   |  1 +
 2 files changed, 32 insertions(+)
 create mode 100755 linux-user/build-vdso.sh

diff --git a/linux-user/build-vdso.sh b/linux-user/build-vdso.sh
new file mode 100755
index 0000000000..489088737f
--- /dev/null
+++ b/linux-user/build-vdso.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# Build vdso using cross tools
+
+build_dir=error
+source_dir=error
+target_dir=error
+output=error
+
+while test $# -gt 0; do
+  opt="$1"
+  shift
+  case "$opt" in
+    -B) build_dir=$1; shift;;
+    -C) source_dir=$1; shift;;
+    -T) target_dir=$1; shift;;
+    -o) output=$1; shift;;
+    --) break;;
+  esac
+done
+
+frag="${build_dir}/tests/tcg/${target_dir}/config-target.mak"
+if ! test -f "$frag"; then
+  # No cross-compiler available
+  # Copy pre-build image into build tree
+  cp "${source_dir}/$(basename ${output})" "${output}"
+  exit $?
+fi
+
+# Extract cross-compiler from the makefile fragment, and build.
+CC=$(grep CC= "$frag" | sed s/CC=//)
+exec $CC -o "$output" $@
diff --git a/linux-user/meson.build b/linux-user/meson.build
index e4cb70ed2d..099e5c4fe0 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -30,6 +30,7 @@ linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('sem
 
 syscall_nr_generators = {}
 
+build_vdso_cmd = find_program('build-vdso.sh')
 gen_vdso_exe = executable('gen-vdso', 'gen-vdso.c',
                           native: true, build_by_default: false)
 gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
-- 
2.34.1


