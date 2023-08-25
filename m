Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D296E78853C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZUME-0006Cj-86; Fri, 25 Aug 2023 06:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZUMC-0006CV-ED
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:48:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZUM9-0001iX-T8
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:59 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68a520dba33so677404b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692960476; x=1693565276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyC+adW6JE1nm7YzFgK0MaLc4sW9/I/IL2kdZEAU7VA=;
 b=hbiXyDTfgIQoxRiSA0JTsSCoN4p/gJFRFtWa5JWh1GSL/ObJsB69WmfPM4HlmJPFij
 H3IkvKitPB/a6LaFsiSgpCvKByE3w1gbfAJi5sg/cBoGgOQ27EHBEek2slga6QSRBUxZ
 DZ5J02xfYNLnL8iHibbPEvPVZumFNbtqRf94NNmoZUKc36PRzIe32T5NxdOJrw+ad2ry
 9e+uaTxhEWj/7qbZ/os6RSXXexnA3GmN+YVdNUZ+Ncjce+y5raxrkCY5uSIOZ0EiZd1R
 Q4j/dXcZ5J+ieCVU5MIjEECBtSjiFxG07Tvlv3/0+MHrW2L9EKdB2moAMTtZ+nWjxHpH
 eKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960476; x=1693565276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyC+adW6JE1nm7YzFgK0MaLc4sW9/I/IL2kdZEAU7VA=;
 b=Q7TMotj7/fAreWSppiX17ymyH7s6TbjmvPD4ERglfypef1Kf+E7y6RNA4xKZqAh0yO
 xLvKLSyLBTa757tml9tKdCpMSO78igjcEqU5VbHR9k5VyPR/k05ZvWKbqyckm8uZGBWE
 mtkCsuwFAJvEFxADySr4UFCnbPDlatqfArzEdg/SUZT5hf3plHoEQdJEVIPc0DKz47uq
 5OT1NRNHKKiOvVDeeaYtGF4U1Bf3hl7QBm2ivPxaQdekjzx4vC+6mllWqMk51F0Gz8YW
 bnV45TThaF5eTsALLqEuOUyHTIo+jntTwU/MFsGHxP4qA8ifN3wXBVkDiOf+EMUDpzFp
 ZsAQ==
X-Gm-Message-State: AOJu0YxtoV1eLfcVE1TrvcDnaLT2LqUwQOxe8/ZU8pKsABCqCDQTN9fW
 ymf79IfoisniVgFheDvd/mHG9XTSfilobA==
X-Google-Smtp-Source: AGHT+IG1g1TeaESsLbwiOR6Mm47D6OXMIzx0qV3dWkZmmcR9DP/xOxHN1K/RxnsCuz8ArOdQWVbB+w==
X-Received: by 2002:a05:6a21:3e0a:b0:14b:ea0d:e313 with SMTP id
 bk10-20020a056a213e0a00b0014bea0de313mr4549788pzc.0.1692960476544; 
 Fri, 25 Aug 2023 03:47:56 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170902ce8500b001b89891bfc4sm1346985plg.199.2023.08.25.03.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:47:56 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v5 10/10] docs/user: Add doc for native library calls
Date: Fri, 25 Aug 2023 18:45:26 +0800
Message-Id: <20230825104526.1754950-11-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
References: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 docs/user/index.rst        |  1 +
 docs/user/native_calls.rst | 90 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 docs/user/native_calls.rst

diff --git a/docs/user/index.rst b/docs/user/index.rst
index 782d27cda2..d3fc9b7af1 100644
--- a/docs/user/index.rst
+++ b/docs/user/index.rst
@@ -12,3 +12,4 @@ processes compiled for one CPU on another CPU.
    :maxdepth: 2
 
    main
+   native_calls
diff --git a/docs/user/native_calls.rst b/docs/user/native_calls.rst
new file mode 100644
index 0000000000..e86675128a
--- /dev/null
+++ b/docs/user/native_calls.rst
@@ -0,0 +1,90 @@
+Native Library Calls Optimization
+=================================
+
+Description
+-----------
+
+Executing a program under QEMU's user mode subjects the entire
+program, including all library calls, to translation. It's important
+to understand that many of these library functions are optimized
+specifically for the guest architecture. Therefore, their
+translation might not yield the most efficient execution.
+
+When the semantics of a library function are well defined, we can
+capitalize on this by substituting the translated version with a call
+to the native equivalent function.
+
+To achieve tangible results, focus should be given to functions such
+as memory-related ('mem*') and string-related ('str*') functions.
+These subsets of functions often have the most significant effect
+on overall performance, making them optimal candidates for
+optimization.
+
+Implementation
+--------------
+
+Upon setting the LD_PRELOAD environment variable, the dynamic linker
+will load the library specified in LD_PRELOAD preferentially. If there
+exist functions in the LD_PRELOAD library that share names with those
+in other libraries, they will override the corresponding functions in
+those other libraries.
+
+To implement native library bypass, we created a shared library and
+re-implemented the native functions within it as a special
+instruction sequence. By means of the LD_PRELOAD environment
+variable, we load this shared library into the user program.
+Therefore, when the user program calls a native function, it actually
+executes this special instruction sequence. During execution, QEMU's
+translator captures these special instructions and executes the
+corresponding native functions.
+
+These special instructions are implemented using
+architecture-specific unused or invalid opcodes, ensuring that they
+do not conflict with existing instructions.
+
+
+i386 and x86_64
+---------------
+An unused instruction is utilized to mark a native call.
+
+arm and aarch64
+---------------
+HLT is an invalid instruction for userspace programs, and is used to
+mark a native call.
+
+mips and mips64
+---------------
+The syscall instruction contains 20 unused bits, which are typically
+set to 0. These bits can be used to store non-zero data,
+distinguishing them from a regular syscall instruction.
+
+Usage
+-----
+
+1. Install cross-compilation tools
+
+Cross-compilation tools are required to build the shared libraries
+that can hook the necessary library functions. For example, a viable
+command on Ubuntu is:
+
+::
+
+    apt install gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu \
+    gcc-mips-linux-gnu gcc-mips64-linux-gnuabi64
+
+
+2. Locate the compiled libnative.so
+
+After compilation, the libnative.so file can be found in the
+``./build/common-user/native/<target>-linux-user`` directory.
+
+3. Run the program with the ``--native-bypass`` option
+
+To run your program with native library bypass, use the
+``--native-bypass`` option to import libnative.so:
+
+::
+
+    qemu-<target> --native-bypass \
+    ./build/common-user/native/<target>-linux-user/libnative.so ./program
+
-- 
2.34.1


