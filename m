Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F43179DAED
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:30:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAx3-0001FP-Gf; Tue, 12 Sep 2023 17:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAx0-0000xz-Tk
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:39 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAww-0007ZF-OB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fb98745c1so2159684b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554173; x=1695158973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYFipkq5GBv0dRUOXcmoig3E3YvWubfKodSG8cGfqzk=;
 b=JbGaKIzS5DoScMddJXNC+/nFyT10BbvftKv3y2xh5bMDcGZ1/YGv0PILjnvqJqzS/K
 zF+NxFC9pRz8QCim2SQ1p1jlL9HFEVD+9Oue5p2dH/nvYweJ4RK9AWRs2vHraiBnKBlL
 VO8j0EnhPvCQdPTxP64TcsjXLR4JFdQSI8/TG7HRpQfniqSwFPgCI3boHEqE+ZxKAvA2
 nP2PdpJBIr7gx5yJ0gOc/1AhjFmfnX/AmNJfjvXdFcsX6hcqn1mlxuPQKxgTDE4XBR3l
 OKybHcV79XBT+wk0Otj4XQ3q290lfqjuB6fsQl1lsLMPaRi3uIG8c1/y0g0tcXPeuTrE
 eWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554173; x=1695158973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYFipkq5GBv0dRUOXcmoig3E3YvWubfKodSG8cGfqzk=;
 b=APmsq5s4fP/vu/Lom/JdNliY1UdUgA2V3D7u0VvEXDnXzqVwlGKysPQMU/EA6FmGp6
 oj3mjE6t1ayydhbWKVD6M3AUCoY9/ob6nDGko/Dgw7gXO8kzgy6FoO4EYQZHK6btymAW
 XE6OW6kC7xqCKevPeHUB7UQL1pgY+m1PTqGpVCG0iVcVF/wfw7L0ytQiY9MeLBoTmoUh
 Ll99jBT6Z7W8ykTumsBC3qf/MhVfWWXfykjUNKFE1bv8oWbJT3Wfgf41AtTVL62jXnFf
 k3uevPbKY8tjCXi/IcNed/ftuQs18OBdl6ci0377Y9k2p9XueWdLpRE8JVSLMHEsv5Io
 c6Kg==
X-Gm-Message-State: AOJu0YzpGAIya7k0ESyvtxbuoIAcmmdXHMZkubq3C2onqf3fZR2EaJ9H
 5A0osDDujvQ0+4KllcT/jRc=
X-Google-Smtp-Source: AGHT+IHiXlZaUbkpcCVxFfB//bxKs0TYjbrNyFdzszgZQrYLaBubc7OFgyax8w8fdK4zJnTUFDQ2DQ==
X-Received: by 2002:a05:6a00:2d87:b0:68f:ece2:ac3b with SMTP id
 fb7-20020a056a002d8700b0068fece2ac3bmr1035317pfb.5.1694554172859; 
 Tue, 12 Sep 2023 14:29:32 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:32 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v6 9/9] docs/user: Add doc for native library calls
Date: Wed, 13 Sep 2023 05:28:42 +0800
Message-Id: <20230912212842.658374-10-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x42a.google.com
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
 docs/user/native_calls.rst | 91 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
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
index 0000000000..0f8c2273a3
--- /dev/null
+++ b/docs/user/native_calls.rst
@@ -0,0 +1,91 @@
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
+By writing the name of a specific library into the /etc/ld.so.preload
+file, the dynamic linker will prioritize loading this library before
+any others. If this library contains functions that share names with
+functions in other libraries, the ones in the specified library will
+take precedence.
+
+In order to bypass certain native libraries, we have developed a
+shared library and re-implemented the native functions within it
+as a special instruction sequence. By making dynamic modifications
+to the /etc/ld.so.preload file, the shared library is loaded into
+the user program. Consequently, when the user program calls a native
+function, it executes the corresponding special instruction sequence.
+During execution, the QEMU translator identifies these special
+instructions and executes the corresponding native functions
+accordingly.
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


