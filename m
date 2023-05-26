Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F6711D8C
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 04:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Mwp-00029r-GN; Thu, 25 May 2023 22:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Mwj-00028G-Ju
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:49 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2MwU-0004sz-Rt
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:49 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-253520adb30so289759a91.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 19:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685067153; x=1687659153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2KZhBl7auKQZshK7fFmdKmLRAK3y6cufIORo1eqyzc=;
 b=sUzfwKv6CRwwQeoxGMUrjM4Mel4UicrC69aqTKCrxD3RQlqx1FciBktxsYFJt6ntKD
 mBehDnIJ/zEYg5ABJ1A+vE55EYTyqDe03xr9kDnIXB2Z6B6kPJWLOEyj2p3R9DP2014y
 Quo5PByeFm3vrTE6mQ26CCAzxFL1KjA42hCFmSg5GPF3o+tmosAGBu9HzmMbQkjjDeh7
 9uoqwitrJ/CVzCOqCMrkheeFcpcYZiPEnT1C5SEspB80s2RIZ9q/KgDtBs0u/681IBV0
 qU+UA4u0Oq5W5UdKCzOZAsR+Ack10FjPuUIMy77F1+I+K+YC/6LKEvhtDXUOAUH8cjP0
 Cgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685067153; x=1687659153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2KZhBl7auKQZshK7fFmdKmLRAK3y6cufIORo1eqyzc=;
 b=RwvtJIvlAZb+ed9mTVavJpgP3itK0Jx7LVhZF0swOafSX3YMLp7piK4FM/w9Hhe6EY
 PpUgXeQZyiUE0U584nIKohOgXHAcErvM12/pan/dNidzgDU+pEzCWq2VADwxexxMxD9s
 SvbszMKVrdk9HBqU0/ve9SIrGYtI3eEZAz1HFLHX9jQc2ziNUjsry16W47AxuaUr7xFZ
 zTRPi3syB4rdhaBnIKLGy2sl2+xzeMHMm08CziKQelUieSWUWBnfzMqlL8qwUT5B13pe
 PcEAabKX1Q+1qsMioh4hWMSlI85J6UWQO6GKHzgLaOWcM+tgLFrVGkPmP6za/sH58E54
 7Bsw==
X-Gm-Message-State: AC+VfDzSS5WNuPiylFiEXgREKOhc6BMJbdAJZU99rpvMELs/Sacn3Kkt
 8U2Yo5dGnp6FQCVtfac7NeXTQcIlZM3O5o908EA=
X-Google-Smtp-Source: ACHHUZ7XyjVgsyixvIuRfM3SlVb6G6rK5OxuDsAEkH4Hzy+o2MZ6f8Nz0ZpDr9Yc/LKE6OiaHBUuIQ==
X-Received: by 2002:a17:90a:17a2:b0:24e:e6c:794c with SMTP id
 q31-20020a17090a17a200b0024e0e6c794cmr644829pja.38.1685067153537; 
 Thu, 25 May 2023 19:12:33 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 oe17-20020a17090b395100b0023a9564763bsm3594086pjb.29.2023.05.25.19.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 19:12:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 4/4] tests/decode: Convert tests to meson
Date: Thu, 25 May 2023 19:12:28 -0700
Message-Id: <20230526021228.1777917-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526021228.1777917-1-richard.henderson@linaro.org>
References: <20230526021228.1777917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


