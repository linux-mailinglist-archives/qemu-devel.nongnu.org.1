Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4B70E40B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1W89-0001qA-Ld; Tue, 23 May 2023 13:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1W7x-0001pY-Ur
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:48:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1W7w-00032M-8V
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:48:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d2ca9ef0cso35031b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684864130; x=1687456130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/cKksD2CVmmV+t7E13jUrrew+hnYkyu369qdeylaPso=;
 b=YqlWPzpc9x0aMcY6qcaStzWJS+2Olk74GW8SXmepsg28XVE9u+qnCllmEdJJHIVgm3
 C9p+p4R/oM14FNzhXaMDoITjDOzdHOcx5s/FPqwfhy4SLgW1n2Bx92lP50mSPGhip6Rw
 u6mz79pdspZMia68mr1JhHbw94BA/7d/+/xshPF8HFv1WM3Ryfrsz5WxWfRbV79+OnbJ
 A+oxiqLW52Azj3KjP94sBjtkcZDmLnOqPRykM3fo7UQK7QO95sYowolWNBLTx1rzZGSi
 fc70KV3nDQggYlMXnqy9kJZZsxUiI+6lVAfkUf4qJM6w6KKgTCapcRcUrYxKZ51TDKAJ
 lAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684864130; x=1687456130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/cKksD2CVmmV+t7E13jUrrew+hnYkyu369qdeylaPso=;
 b=Cdh93lYwwXwH+fdcmjttSeSdDvFBBDx84Ph8TG0VrgH2ZYkIr6GEyKNc5HVrz2+8pU
 54AG+ur8qYzJltaUiAnir3J4BEGoxEsDMldu9YaryAhSoz7+dbPt3xldg5fg95VFSYq1
 FMLEcdV13UrdN84EcDISPUrZuV6k3yKWiLlArPpsJ4Z6clHZ/F7Hyd2xdjScGfJIfnpj
 y/6cSxfZsGJgjjyUVeI27U1sj1KVztKfXUozKlKepBCgxK0UnOyq5HL7e2IEem4T0Fg0
 DNi3UPuPmC0SRBTZgFZ/swreg5uUU01rt90ysCqvOhiA7heE4ALjvetaZf4SXBaPziWz
 EUJw==
X-Gm-Message-State: AC+VfDwzMP2sVey8uRE628GfTOKbE58HYUq5Mf/qjVI6A2N8r5UUuilT
 I+lqHhL1pfzXe3IkiGQ17xg9Uo42Jle8dRzH170=
X-Google-Smtp-Source: ACHHUZ5v1c8lLhhcMA7024T7VBKVN8xpKz8WARgziiVHw6zunUWQMqI8zLRZV74Yh7RV1YGjQL2YQg==
X-Received: by 2002:a05:6a00:130b:b0:64d:1451:8220 with SMTP id
 j11-20020a056a00130b00b0064d14518220mr19482240pfu.20.1684864130132; 
 Tue, 23 May 2023 10:48:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 k25-20020aa790d9000000b0064d421f0497sm6013374pfk.109.2023.05.23.10.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 10:48:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH] tests/decode: Convert tests to meson
Date: Tue, 23 May 2023 10:48:48 -0700
Message-Id: <20230523174848.682195-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Hi Paolo, I've used "should_fail: true" because from the docs that
seems like the proper thing, but that produces

28/39 qemu:decodetree / err_width1  EXPECTEDFAIL  0.08s  exit status 1

which isn't nearly so reassuring as OK.  I wonder if it would be better
to add a --test-fail switch to decodetree.py, to invert the exit value?

r~

---
 tests/decode/check.sh    | 24 ----------------
 tests/decode/meson.build | 60 ++++++++++++++++++++++++++++++++++++++++
 tests/meson.build        |  5 +---
 3 files changed, 61 insertions(+), 28 deletions(-)
 delete mode 100755 tests/decode/check.sh
 create mode 100644 tests/decode/meson.build

diff --git a/tests/decode/check.sh b/tests/decode/check.sh
deleted file mode 100755
index 95445a0115..0000000000
--- a/tests/decode/check.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/sh
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
-# See the COPYING.LIB file in the top-level directory.
-
-PYTHON=$1
-DECODETREE=$2
-E=0
-
-# All of these tests should produce errors
-for i in err_*.decode; do
-    if $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
-        # Pass, aka failed to fail.
-        echo FAIL: $i 1>&2
-        E=1
-    fi
-done
-
-for i in succ_*.decode; do
-    if ! $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
-        echo FAIL:$i 1>&2
-    fi
-done
-
-exit $E
diff --git a/tests/decode/meson.build b/tests/decode/meson.build
new file mode 100644
index 0000000000..e2e7ccef56
--- /dev/null
+++ b/tests/decode/meson.build
@@ -0,0 +1,60 @@
+err_tests = [
+    'err_argset1.decode',
+    'err_argset2.decode',
+    'err_field1.decode',
+    'err_field2.decode',
+    'err_field3.decode',
+    'err_field4.decode',
+    'err_field5.decode',
+    'err_field6.decode',
+    'err_init1.decode',
+    'err_init2.decode',
+    'err_init3.decode',
+    'err_init4.decode',
+    'err_overlap1.decode',
+    'err_overlap2.decode',
+    'err_overlap3.decode',
+    'err_overlap4.decode',
+    'err_overlap5.decode',
+    'err_overlap6.decode',
+    'err_overlap7.decode',
+    'err_overlap8.decode',
+    'err_overlap9.decode',
+    'err_pattern_group_empty.decode',
+    'err_pattern_group_ident1.decode',
+    'err_pattern_group_ident2.decode',
+    'err_pattern_group_nest1.decode',
+    'err_pattern_group_nest2.decode',
+    'err_pattern_group_nest3.decode',
+    'err_pattern_group_overlap1.decode',
+    'err_width1.decode',
+    'err_width2.decode',
+    'err_width3.decode',
+    'err_width4.decode',
+]
+
+succ_tests = [
+    'succ_argset_type1.decode',
+    'succ_function.decode',
+    'succ_ident1.decode',
+    'succ_pattern_group_nest1.decode',
+    'succ_pattern_group_nest2.decode',
+    'succ_pattern_group_nest3.decode',
+    'succ_pattern_group_nest4.decode',
+]
+
+suite = 'decodetree'
+
+decodetree = find_program(meson.project_source_root() / 'scripts/decodetree.py')
+
+foreach t: err_tests
+    test(fs.replace_suffix(t, ''),
+         decodetree, args: ['-o', '/dev/null', files(t)],
+         should_fail: true, suite: suite)
+endforeach
+
+foreach t: succ_tests
+    test(fs.replace_suffix(t, ''),
+         decodetree, args: ['-o', '/dev/null', files(t)],
+         suite: suite)
+endforeach
diff --git a/tests/meson.build b/tests/meson.build
index 8e318ec513..083f2990bd 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -74,10 +74,7 @@ if have_tools and have_vhost_user and 'CONFIG_LINUX' in config_host
              dependencies: [qemuutil, vhost_user])
 endif
 
-test('decodetree', sh,
-     args: [ files('decode/check.sh'), config_host['PYTHON'], files('../scripts/decodetree.py') ],
-     workdir: meson.current_source_dir() / 'decode',
-     suite: 'decodetree')
+subdir('decode')
 
 if 'CONFIG_TCG' in config_all
   subdir('fp')
-- 
2.34.1


