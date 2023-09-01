Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F9D78F717
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpc-0007M9-7n; Thu, 31 Aug 2023 22:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007Aj-JZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpB-0001SL-PS
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:14 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68c3b9f85b7so1081030b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535032; x=1694139832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVa+6i7ltaDcVRVgM1SyKlnzNS7CnHg1qkG8lXGAgc8=;
 b=qiszB5/vWDtROG5ij0czfJLP5wdQyCXIOeu2UFz0oJx/AbgH+xlEictvd/AI3JZjeD
 1EIzFflWsdPvjvguMYHg6xQzuD22oHx3EeLNMcxk1wmFahuYx45LAwJde474RWepAWd9
 0P6+pbvDYJiRAhjqbeAY4N06WRMtAZTI794wZePBB1SI1A5GiitJPH8yVPGSRxk8W2Da
 uSrxsCnn0haK3JS1uxDK2zS9S9vogafcILhAglRZ7Qfr0ifatA3ToS3VhwKC6zEyClSf
 ss4fBln2IuBGocGOHRpf3EL6dDrm0Gn7sXpGNWhT3l1qunTge+PktwO0SN79NGKrKaTk
 v4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535032; x=1694139832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVa+6i7ltaDcVRVgM1SyKlnzNS7CnHg1qkG8lXGAgc8=;
 b=CpL2UYnipBxfWFI/SAD6LAuusUsFIW4KO9U1rvBHBUbNjm2Yj67WfBpO3nP5ZdBvTA
 ABoLLUSl8A6Qw3yfcETjdgacZ1LgwTqeas+C1eeZly+Jtz2SGIk/BmwCDBMkn3PCpkHm
 ZRc5j2VGM+RMnB1ZHP/l4TvgzI5tyACnDDuAJVFNhthGJNu3OLL0O6+Qo/usuIgFwCNE
 c6jKXJLGWTqEjQuGQbIfGgWEv+ly5jU/2KyrFcywlpbzry6+VJxzc1eDVZv+nwic+SYj
 u0a/62MFtvpiNFQwrM+OIQDf5vUcW1BRefOVws+0fbkw/whL7sX1rQY5I71j/0/X8DP7
 /7ew==
X-Gm-Message-State: AOJu0YyoCDL2Ls+QXsXsF/R6v+qbyrsQiz/OA1hSZOTj6l8TtOcG+l0n
 5eM/pX6fX2qzoV0OECJnS6QuwEqkSYsYJmIj2Rc=
X-Google-Smtp-Source: AGHT+IGZlnZrPr5a85TRvGN35rzyi30YztVOcTHUQKy/DrDd0OYC7pckFeFhlCWJx/BIwj/gwo5yIg==
X-Received: by 2002:a05:6a00:22c7:b0:68a:6193:710d with SMTP id
 f7-20020a056a0022c700b0068a6193710dmr1546133pfj.30.1693535032316; 
 Thu, 31 Aug 2023 19:23:52 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 24/33] tests/tcg: Remove run-test-mmap-*
Date: Thu, 31 Aug 2023 19:23:22 -0700
Message-Id: <20230901022331.115247-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


