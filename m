Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6A821650
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3m-0003ks-BA; Mon, 01 Jan 2024 20:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3e-0003h6-98
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:06 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3c-00075G-8E
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:05 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso7061097a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160742; x=1704765542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bvIqJJvCSw/W2rsjpUyM+grSiLNxzontPEfDkoi+BAY=;
 b=JRk9mckAbx0Gpo8a8kue4mqgn766jHX06a0Cm+FmT23Hg1JBs7tF6+EQy0vYA9p/3r
 Zi2i21MbQsw+wisPvsRgEtlWlDTyRQC3Ecjpb6mLPdy0wgemdBdI3e85wEbq4SBvn9at
 XZX/XhQioDKieZPAiFDuta1IRwSMQUtxZGxaPEOjy/AcwzFLGBbT25EfaiACIfME2uQI
 35vMmPfGD58cIztEZbJ67kyLL5Rh/dpnaWczLsk01k3XbJf9s098jaP69b+rsMuTq/26
 rGYi2d0I0oEhq0DOwHU1JadPGNldv32/ZjEO3UmVC/8lhHCGa3iPsdFLm2sr1ZEpqA6a
 7peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160742; x=1704765542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvIqJJvCSw/W2rsjpUyM+grSiLNxzontPEfDkoi+BAY=;
 b=slzA+5vzppHWz5fEs5xRyw0lZlCEpKyFBTzjdkkQBRqBCJf3LKuHb0+gwkWDaXK3cW
 c9H7jOUTOQCGIq6K7r0syKTBI0oFH0yQ3EAYPA4/xhIyG9XnSiD81ecNXxymxKbpNvFt
 8vlX6gNlnGjxKuPGiC/GpaGxcwk/I4y39YC8OK7X9oL9FsBifVhAFZvBCe/IZ3ose2mw
 xExNHHh+4TB437/JM2LjyoQVc7ji2RJQFwQz3X6J/6YkRHxE6NhN85Ad0C9WOAehBazA
 VNukUr35DJ+8FTEa/eLHlHTZ5NyO3O33+SDePFW9kIVvX4pHWP/8dVX8vi7wo1Hyd4e6
 RhFA==
X-Gm-Message-State: AOJu0YzJpHedoujS04BJgpvGYRhW1/ejhYHyWyUouDH0X0QF86DCdvgY
 XWVUQ4LxzAE0CfghjPxaI9/01PfDpFvmAjZhp+s051C0iE0=
X-Google-Smtp-Source: AGHT+IFraYfav/X8fjYTrS0tGuYreEBt71E+gkv9Bw/uq1AeatsGlSOAuSD5f2MQSNPvCAYwYY2VqQ==
X-Received: by 2002:a05:6a20:54a5:b0:197:2fae:794e with SMTP id
 i37-20020a056a2054a500b001972fae794emr1559210pzk.70.1704160742526; 
 Mon, 01 Jan 2024 17:59:02 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/33] tests/tcg: Remove run-test-mmap-*
Date: Tue,  2 Jan 2024 12:57:59 +1100
Message-Id: <20240102015808.132373-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
index 3473f4619e..0a1965fce7 100644
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
index 3dec7c6c42..53540ac96a 100644
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
index 6ff214e60a..33f7b1b127 100644
--- a/tests/tcg/m68k/Makefile.target
+++ b/tests/tcg/m68k/Makefile.target
@@ -5,6 +5,3 @@
 
 VPATH += $(SRC_PATH)/tests/tcg/m68k
 TESTS += trap denormal
-
-# On m68k Linux supports 4k and 8k pages (but 8k is currently broken)
-EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index d31ba8d6ae..313f7417ba 100644
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
 ifneq ($(GDB),)
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


