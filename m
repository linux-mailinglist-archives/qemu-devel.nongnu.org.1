Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5C9781171
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX324-0008OP-Si; Fri, 18 Aug 2023 13:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX320-0008Ja-6L
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31x-00086J-EX
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:03 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so8162275ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378779; x=1692983579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JVa+6i7ltaDcVRVgM1SyKlnzNS7CnHg1qkG8lXGAgc8=;
 b=TtEnDoTO2HnjYSybEtdONXV+9T5Piz/yiitCNn3/rgwGMyLkWoV/hUviR6ClMX0CU1
 Y5C7ebmX3akZroWq8VyieDI6Voorf6oYb+VhDfFKXxEiU+RiWnyBMXvGAJF0E3vKPCF9
 o33KFefD+FO2uWsLa/0eHVApz+d+zxF5CdKB+eaTR2adu8M9bHl82073NRuVhz5Er+Ln
 sSTaPgWmsx3NJa9h+pMkW2LpWlWBTNmfSiZEKk6a6abzh2EdUmyJCAwHSgfGubpJpqY7
 jVRanQqegiecGeTBoKHEMmS/yvZiHiNs6pVZae2Hzi5fajdPuKE/w8eSwEpIXYxLThCV
 yg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378779; x=1692983579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVa+6i7ltaDcVRVgM1SyKlnzNS7CnHg1qkG8lXGAgc8=;
 b=dADEY3nMpZebI6/RN3CtkWPLrEdz/+xRp8+iCGXawkeDtH/KGHCBAttfoTDyj06xGf
 o0g303WLsYLjSHUaW1/QkJQ+1mS5YbPowlPu7Cg2rlGkbQMvcLhdnn4RG9cCqf5VqSDA
 r66aDyzSAYCDcjzhvY4M7xGb1IP/c+twmH1bKcWWpTFowp6DAfegMwBm0Z0XIixQT96I
 x7OWAvpG9PdaHuQJoz1YCVVDJ9d9rjWmHeGYBToWnXcqIRB7GTQADIWfDZyn5n5ULhTb
 hK30PvXNgs3tR8aQB1m81309Qh18zx9XMlbFLjReC0BcNnPjiPrRYxwm7y0U2d4s2My9
 8mqA==
X-Gm-Message-State: AOJu0YzSPV3eeqYUdIrjwVeLyZPpF4W+qUDfoRVQuJK8PB7fj4VIPwcO
 VhP5ElvU/A/gKeK4S1HkqKd6xoC1LiEGcW5j0kY=
X-Google-Smtp-Source: AGHT+IEC+LvpEytgooPoRXJ+QZKche6Af+m+q1BSWz4+yfhp1riN0VfI4YL2jHgmSGa/mSBF5+DWHw==
X-Received: by 2002:a17:903:230f:b0:1bc:7312:78e2 with SMTP id
 d15-20020a170903230f00b001bc731278e2mr9114708plh.5.1692378779174; 
 Fri, 18 Aug 2023 10:12:59 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/33] tests/tcg: Remove run-test-mmap-*
Date: Fri, 18 Aug 2023 10:12:18 -0700
Message-Id: <20230818171227.141728-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

These tests are confused, because -p does not change
the guest page size, but the host page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/alpha/Makefile.target     |  3 ---
 tests/tcg/arm/Makefile.target       |  3 ---
 tests/tcg/hppa/Makefile.target      |  3 ---
 tests/tcg/i386/Makefile.target      |  3 ---
 tests/tcg/m68k/Makefile.target      |  3 ---
 tests/tcg/multiarch/Makefile.target |  9 ---------
 tests/tcg/ppc/Makefile.target       | 12 ------------
 tests/tcg/sh4/Makefile.target       |  3 ---
 tests/tcg/sparc64/Makefile.target   |  6 ------
 9 files changed, 45 deletions(-)
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
index b94500a7d9..fdd7ddf64e 100644
--- a/tests/tcg/alpha/Makefile.target
+++ b/tests/tcg/alpha/Makefile.target
@@ -13,6 +13,3 @@ test-cmov: test-cond.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
 run-test-cmov: test-cmov
-
-# On Alpha Linux only supports 8k pages
-EXTRA_RUNS+=run-test-mmap-8192
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0038cef02c..4b8c9c334e 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -79,6 +79,3 @@ sha512-vector: sha512.c
 ARM_TESTS += sha512-vector
 
 TESTS += $(ARM_TESTS)
-
-# On ARM Linux only supports 4k pages
-EXTRA_RUNS+=run-test-mmap-4096
diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
index cdd0d572a7..ea5ae2186d 100644
--- a/tests/tcg/hppa/Makefile.target
+++ b/tests/tcg/hppa/Makefile.target
@@ -2,9 +2,6 @@
 #
 # HPPA specific tweaks - specifically masking out broken tests
 
-# On parisc Linux supports 4K/16K/64K (but currently only 4k works)
-EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-16384 run-test-mmap-65536
-
 # This triggers failures for hppa-linux about 1% of the time
 # HPPA is the odd target that can't use the sigtramp page;
 # it requires the full vdso with dwarf2 unwind info.
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index fdf757c6ce..f64d7bfbf5 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -71,9 +71,6 @@ endif
 I386_TESTS:=$(filter-out $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
 TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
 
-# On i386 and x86_64 Linux only supports 4k pages (large pages are a different hack)
-EXTRA_RUNS+=run-test-mmap-4096
-
 sha512-sse: CFLAGS=-msse4.1 -O3
 sha512-sse: sha512.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
index 1163c7ef03..73a16aedd2 100644
--- a/tests/tcg/m68k/Makefile.target
+++ b/tests/tcg/m68k/Makefile.target
@@ -5,6 +5,3 @@
 
 VPATH += $(SRC_PATH)/tests/tcg/m68k
 TESTS += trap
-
-# On m68k Linux supports 4k and 8k pages (but 8k is currently broken)
-EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 43bddeaf21..fa1ac190f2 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -51,18 +51,9 @@ run-plugin-vma-pthread-with-%: vma-pthread
 	$(call skip-test, $<, "flaky on CI?")
 endif
 
-# We define the runner for test-mmap after the individual
-# architectures have defined their supported pages sizes. If no
-# additional page sizes are defined we only run the default test.
-
-# default case (host page size)
 run-test-mmap: test-mmap
 	$(call run-test, test-mmap, $(QEMU) $<, $< (default))
 
-# additional page sizes (defined by each architecture adding to EXTRA_RUNS)
-run-test-mmap-%: test-mmap
-	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<, $< ($* byte pages))
-
 ifneq ($(HAVE_GDB_BIN),)
 ifeq ($(HOST_GDB_SUPPORTS_ARCH),y)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
diff --git a/tests/tcg/ppc/Makefile.target b/tests/tcg/ppc/Makefile.target
deleted file mode 100644
index f5e08c7376..0000000000
--- a/tests/tcg/ppc/Makefile.target
+++ /dev/null
@@ -1,12 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# PPC - included from tests/tcg/Makefile
-#
-
-ifneq (,$(findstring 64,$(TARGET_NAME)))
-# On PPC64 Linux can be configured with 4k (default) or 64k pages (currently broken)
-EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-65536
-else
-# On PPC32 Linux supports 4K/16K/64K/256K (but currently only 4k works)
-EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-16384 run-test-mmap-65536 run-test-mmap-262144
-endif
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 47c39a44b6..16eaa850a8 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -3,9 +3,6 @@
 # SuperH specific tweaks
 #
 
-# On sh Linux supports 4k, 8k, 16k and 64k pages (but only 4k currently works)
-EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192 run-test-mmap-16384 run-test-mmap-65536
-
 # This triggers failures for sh4-linux about 10% of the time.
 # Random SIGSEGV at unpredictable guest address, cause unknown.
 run-signals: signals
diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
deleted file mode 100644
index 408dace783..0000000000
--- a/tests/tcg/sparc64/Makefile.target
+++ /dev/null
@@ -1,6 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# sparc specific tweaks
-
-# On Sparc64 Linux support 8k pages
-EXTRA_RUNS+=run-test-mmap-8192
-- 
2.34.1


