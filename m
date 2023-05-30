Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E4716D1B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aK-0000w9-4k; Tue, 30 May 2023 15:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zq-0000sc-CV
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zn-00019M-HZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d3491609fso3532983b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473210; x=1688065210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n2KZhBl7auKQZshK7fFmdKmLRAK3y6cufIORo1eqyzc=;
 b=cBgE0RggNJWADNaDFLVoB+rXA+nyEkFg1yGWD+O0e9NpVFgGRMVZHJWWO+/+Y3t0y5
 7Y6wtyROO+Z9hDkz8Qxp67oXiPBKsG5GpkOeXbNYzKVgKDBMnhyOuf5fldKvi5BDZfSM
 ZgwPV9//knIneQwfOW9ErD7XNYvAAE6874l8o//MZhSWLUQ/9dH3xUz+ld8pLkyjvnXS
 MYboVUSvRma3oXrLZpSXimMT034j087+zMUVRw3ESwEAOJPwJqYNHqb4Kdm8HddQfLgo
 IBqLC19RJnbQgVuspeq5egSw2bxnEs8TMafczpYL1vj4RjottJJFtMSmmKKU4Qm5vxl+
 8yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473210; x=1688065210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2KZhBl7auKQZshK7fFmdKmLRAK3y6cufIORo1eqyzc=;
 b=d6Xp4kQ+T0oFoDVO+VUX+49sjHsJ0gw0VXkKNF+D8/bOTFVMO0rgwkrLG7V84VKVTs
 5JOzp8P6ukMEGaAdWKrkadAUwRYhAXoD6hegz9+uApD43TpqlciOgVRDNRscZbK3EcKk
 VSkek89XoYRORjV0DtGXUbgg4lp0PP43gBibfc7jmadfO4bGY4D4ln8O9Cr69dvEZq+9
 aIQjRPgtX/84qPcymuw2XAnZBqHPmteDYlFUSjufXuw23V8hrGuZkm4Obu+6edZJUj3T
 ich88k23YFrEsLyxgYf+YwgtrdgLSgRzmbWoEXgTCMm92/x1OiMexd8Z2EyJreHEUQJ2
 TyuQ==
X-Gm-Message-State: AC+VfDxEVypR3AJkwUzIiN1FI9nTxCO+FYDkfJ6NqO8wlQGZ5y9PiqgW
 8ubSDS8Hvd1dzhJF3T9b7dWv5DE3OrIgzstR9LQ=
X-Google-Smtp-Source: ACHHUZ4dRTo2IFGczauYpefl9xKFRORgNf0OouA915lPluybda4UsiDjaKY6OGJWEfCAtk17ML0JkQ==
X-Received: by 2002:a05:6a21:3707:b0:10d:f812:e4b5 with SMTP id
 yl7-20020a056a21370700b0010df812e4b5mr2755650pzb.35.1685473210222; 
 Tue, 30 May 2023 12:00:10 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/27] tests/decode: Convert tests to meson
Date: Tue, 30 May 2023 11:59:44 -0700
Message-Id: <20230530185949.410208-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 tests/decode/check.sh    | 24 ----------------
 tests/decode/meson.build | 59 ++++++++++++++++++++++++++++++++++++++++
 tests/meson.build        |  5 +---
 3 files changed, 60 insertions(+), 28 deletions(-)
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
index 0000000000..b4850562f9
--- /dev/null
+++ b/tests/decode/meson.build
@@ -0,0 +1,59 @@
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
+decodetree = find_program(meson.project_source_root() / 'scripts/decodetree.py')
+
+foreach t: err_tests
+    test(fs.replace_suffix(t, ''),
+         decodetree, args: ['-o', '/dev/null', '--test-for-error', files(t)],
+         suite: suite)
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


