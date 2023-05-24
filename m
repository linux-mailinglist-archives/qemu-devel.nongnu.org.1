Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3270FCC4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 19:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1sRL-0008F2-76; Wed, 24 May 2023 13:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1sRJ-00089p-1z
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:38:21 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1sRG-0001md-T6
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:38:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d24136663so936356b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684949897; x=1687541897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bs800fg5CKmMHGSXaOcoJapkzNZtDhJHKEk1IzMosJM=;
 b=LwFQpRAYKILsLMajA4RLocobxDuT3fUlHv8MPAo818spoGY8cLaydC5S5kM7yxXi38
 j0CXWljCunjO12kEIzizR+92cpk1WM+SkH05+lbdqEBll9DsMaD6fnqe+7JMZIJrBE/H
 PcuNMOQmbNGNUr8/tE2D7ACUw/qQJBTD7mWT9lDRbWScH6Z312/Uyx4k87xKWBKQEl+m
 jKYufVUVDtrgVUZ3VcdOvEuIXJxlV71exFd/XH1FmSFdsFBsRMgbrWFg69Lv3769/7Xe
 3QdLrlFXBtuPOg6Pk3SMfr11Bz+DDkiDngwmcm9DRJKENgEudlHTWk7gfGzZDqEg9wfU
 6q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684949897; x=1687541897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bs800fg5CKmMHGSXaOcoJapkzNZtDhJHKEk1IzMosJM=;
 b=FpNYN3aY1aC5KWsQ9N72+021bP3+PXdlS4J/iJiRL8BsF68booTRHTbPeiBN4e+J7N
 LNZDkaZU07aWOMz2jl0S7pM+nUNMTmqc59Fka2DK443KncuAneZISia68VrTXPMNQ4u/
 ///69w7WKZoZzV+wqeI5z37DTvsn4EvsrOnKyscQ9EEqMXUvf7Krzi97VPmKb2phfrvG
 H/KJTAtlk85sJERp34AtyyRNrT64oCMr96qGsbvDUaYCl5Z4t67SVUvKoKc57X3qDL5T
 R6PvImscy3zx0kOknYM2ZJuAExhzIjvlqgvXvOzZpmNenYxiC/uvCwQl2Z9qJBEqic2i
 V1lg==
X-Gm-Message-State: AC+VfDzWNFZ0PwzoVQ0nKYewrk0wCVmkr1JjMxkaHaSmIIX73wT5dvwR
 jOVZBuCIMZVanSikpb4lTw/uhnm246/Sww2/bfQ=
X-Google-Smtp-Source: ACHHUZ6ib5Kgm30HbygyCWcYAfLddEMvEGRD/vKtaSHQO/ePVfG0HE+c+Ic4Q4Pc5HaQERf58KnLzw==
X-Received: by 2002:a05:6a20:5486:b0:107:1f22:10d5 with SMTP id
 i6-20020a056a20548600b001071f2210d5mr22914387pzk.52.1684949897090; 
 Wed, 24 May 2023 10:38:17 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 5-20020a631945000000b0053b9bb98331sm5415843pgz.20.2023.05.24.10.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 10:38:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/decode: Emit TAP
Date: Wed, 24 May 2023 10:38:15 -0700
Message-Id: <20230524173815.1148653-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

We currently print FAIL for the failure of a succ_* test, but don't
return a failure exit code.  Instead, convert the script to emit
Test Anything Protocol, which gives visibility into each subtest
as well as not relying on exit codes.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/decode/check.sh | 36 ++++++++++++++++++++++++++----------
 tests/meson.build     |  1 +
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/tests/decode/check.sh b/tests/decode/check.sh
index 95445a0115..a3d879a099 100755
--- a/tests/decode/check.sh
+++ b/tests/decode/check.sh
@@ -4,21 +4,37 @@
 
 PYTHON=$1
 DECODETREE=$2
-E=0
+E_FILES=`echo err_*.decode`
+S_FILES=`echo succ_*.decode`
 
-# All of these tests should produce errors
-for i in err_*.decode; do
+j=0
+for i in $E_FILES $S_FILES; do
+    j=`expr $j + 1`
+done
+
+echo 1..$j
+
+j=0
+for i in $E_FILES; do
+    j=`expr $j + 1`
+    n=`basename $i .decode`
     if $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
-        # Pass, aka failed to fail.
-        echo FAIL: $i 1>&2
-        E=1
+        # Failed to fail.
+        echo not ok $j $n
+    else
+        echo ok $j $n
     fi
 done
 
-for i in succ_*.decode; do
-    if ! $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
-        echo FAIL:$i 1>&2
+for i in $S_FILES; do
+    j=`expr $j + 1`
+    n=`basename $i .decode`
+    if $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
+        # Succeeded.
+        echo ok $j $n
+    else
+        echo not ok $j $n
     fi
 done
 
-exit $E
+exit 0
diff --git a/tests/meson.build b/tests/meson.build
index 8e318ec513..137ef85ab6 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -77,6 +77,7 @@ endif
 test('decodetree', sh,
      args: [ files('decode/check.sh'), config_host['PYTHON'], files('../scripts/decodetree.py') ],
      workdir: meson.current_source_dir() / 'decode',
+     protocol: 'tap', verbose: true,
      suite: 'decodetree')
 
 if 'CONFIG_TCG' in config_all
-- 
2.34.1


