Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A7773AB2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:21:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNZ0-0001M5-La; Tue, 08 Aug 2023 10:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYu-0001Ld-HV
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYs-0000VA-Tk
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso50885855ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504390; x=1692109190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuQ2Qkfj6B3zA1uyx3Q0Q6mG7A7//D96fP1uqBR5p/8=;
 b=e17Q11KyGXTeKFPK1QOLHSJwvEVtlOXvkqlQUTOlXn3mrLbzFqgq63dkYvjwYYwGQg
 yAv3Nb8M0e817YIrpZrKqwcRTd+ef4y4Df7PMUWkKiLTrEsS9Lqp6/jY9EcSYIe+LGbE
 aW7nYu1IDwMqUKmslytOv4dWODEd2ZcNzKTqqqZgadl45ulBVVgp1lHKtvVK9COft2GK
 7RIa/bSNWpNMXCU0+jKPMopeBtFiRUFZc7xaSYRoyNJCdTrEP16ZWB/vSVklEcdj4VJC
 nbfU3nba8AMvxhpRBbAZ6/YIoiZcvglYrR2SPhmHWcEIP007fQiNQrkqpXoKDIIqC6lN
 6w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504390; x=1692109190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuQ2Qkfj6B3zA1uyx3Q0Q6mG7A7//D96fP1uqBR5p/8=;
 b=F+AtbKsb5K1CqiweN0I8e2zntDIItCUw0O7J43NB95OSVknK9o9c5/zg8nKmgLjlSq
 oelTvrBt1B45fIt6pT3I02H4E2/RU+omb4ROTi4Dqc7R9oA6X/Rim134JMBZ8A2qVhZq
 UMIqRGftzpGEFTOItYeu1PWrCnjdv1o1oyyREE1DFKGp3oR7iCF/Tpx2G0EPD1OsYXeh
 8/xEnSPy7FUuuHJ793MJ9xaJlH9QGeE79R7MovS2lA69Ux5MkrUVolYLHNHSgDuH5W69
 d1K3+y+sETVujHXfrX/gZk+BMdiSN5oOzemHRHzLaopLkKg4ctpqZCxiULhB6kyYgLVu
 2CAw==
X-Gm-Message-State: AOJu0YwZTc1tx0Bi6AlnvLmJx09vfE4A2vmdC+W8+ialRpLUeh35jw5t
 E+RJ3Vv8l+IbmK/cTMTrw3PCC0UWZ5c0zFk9
X-Google-Smtp-Source: AGHT+IHK+WBxU8zzO1B2I6B1hbv6Bz50yFqt55plcWiCMAWVtJBM0vdFu8k8iTQ7PBhho7LP1iLzXA==
X-Received: by 2002:a17:902:dad1:b0:1b8:6987:de84 with SMTP id
 q17-20020a170902dad100b001b86987de84mr16354252plx.48.1691504389643; 
 Tue, 08 Aug 2023 07:19:49 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:49 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v4 11/11] docs/user: Add doc for native library calls
Date: Tue,  8 Aug 2023 22:17:39 +0800
Message-Id: <20230808141739.3110740-12-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62c.google.com
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
index 0000000000..c4b854096a
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
+HLT is an invalid instruction for userspace and usefully has 16
+bits of spare immeadiate data which we can stuff data in.
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


