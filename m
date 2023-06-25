Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DCA73D494
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:30:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGW-0005Ru-LC; Sun, 25 Jun 2023 17:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGU-0005RV-Am
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGS-0003P3-J4
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b7e1875cc1so3075755ad.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728439; x=1690320439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iJaGY1IcpK2do/l808hPeHtD6amwR97RNOTv0XTF1E=;
 b=awpdXQKtVZkYjF7hDlUbQ/jRxu8lzB+Vx+BPoVyGZ0sMaweQ3pSMREXR+tfxRKdRrV
 5AXi0GIsSZ26rOiLIwQND8car20tVk4QVSykfJYaam0tH/p6JLV7O72G3PnFbLViSIOE
 gvfLlNbMIut4W7s27UxQVMrskRGadOMYxlvzmer1Z/KWqmPSnRnmpNaQr46qTyaxZ1/R
 jvaCU4vj+loJSV0n32j0lnZQCmHedmxMYxCEnDsGzItmXquM/mrgX3hr3J/ONItSRxJ/
 /1kzbsqTRJ7AafvcsJOcapmCllx0v8SlXH7rsk7oKG0H8UFuqjKcIQmLxefbb0UKsa9E
 uw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728439; x=1690320439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iJaGY1IcpK2do/l808hPeHtD6amwR97RNOTv0XTF1E=;
 b=hqyDP+qDheviK+NHV6+sW0MguoRrNSyO6GQhu2au5nBOdPw3yNv7M62Uk5XrHeiXuv
 vhxHI6xEe53W2NYCUA8fsULslbIkzTxoyhN1V71E0PR002RBrSr+QkLAqXuKj8M4IWsl
 iw2bpc5abvAXg+f9wOfpIiGCnKDT6x3Ih57jkcubiIGr3UMbxPXoZZXfhT6dlTuGMpLX
 VW4SLe+OeLqU/a+fL4ldvtH4WCwzvBCxyWKZ+4B1GK/EeIn+iM6FJGHg0PYMpI4f5e+w
 4WvxTW9C1UKK8p2kMTicFWcJjP5Ud9hUnmC9Mf1jgiEW8Grf6cRa2TwN0Q/O0EDcqyRO
 Z/OQ==
X-Gm-Message-State: AC+VfDy6Dad6ka4gizMXCFxvUnO9yTPLmTAoFPxDAO++g6/s7dFbN3r8
 VAMg9dF3GPn/3y7tS7z+YPnBda468tQkRnVZ
X-Google-Smtp-Source: ACHHUZ7OLMCBsV+h0QWU0THzxWQ/vX0o0YzLRwgO4HhwyHeUsW4VsS4YfgcXxvSDqYdB0goNHPK53w==
X-Received: by 2002:a17:903:32d2:b0:1b5:2ec:6ffb with SMTP id
 i18-20020a17090332d200b001b502ec6ffbmr3114936plr.0.1687728438727; 
 Sun, 25 Jun 2023 14:27:18 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:18 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v3 01/10] docs: Add specification for native library calls
Date: Mon, 26 Jun 2023 05:26:58 +0800
Message-Id: <20230625212707.1078951-2-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 docs/native_calls.txt | 70 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 docs/native_calls.txt

diff --git a/docs/native_calls.txt b/docs/native_calls.txt
new file mode 100644
index 0000000000..8906566b13
--- /dev/null
+++ b/docs/native_calls.txt
@@ -0,0 +1,70 @@
+Native Library Calls Optimization for QEMU Linux-User
+====================
+
+Description
+===========
+When running under the linux-user mode in QEMU, the entire program,
+including all library calls, is translated. Many well-understood
+library functions are usually optimized for the processor they run
+on. For example, the semantics of memcpy are well-defined and
+optimized. Instead of translating these library functions, we can
+call their native versions, as the runtime of library functions
+is generally biased towards a few core functions. Thus, only a
+small subset of functions (such as mem* and str*) would need to
+be hooked to be useful.
+
+
+Implementation
+==============
+This feature introduces a set of specialized instructions for native
+calls and provides helpers to translate these instructions to
+corresponding native functions. A shared library is also implemented,
+where native functions are rewritten as specialized instructions.
+At runtime, user programs load the shared library, and specialized
+instructions are executed when native functions are called.
+
+The specialized instructions are implemented using architecture-
+specific macros. These macros utilize unused or invalid opcodes or
+instruction fields to embed the necessary information for native
+function calls. This approach ensures that the specialized
+instructions do not conflict with existing instructions.
+
+For x86 and x86_64, the implementation uses an unused opcode.
+For arm and aarch64, the HLT instruction is used, as it is invalid in
+userspace and has 16 bits of spare immediate data.
+For mips and mips64, the implementation takes advantage of unused
+bytes in the syscall instruction.
+
+Supported Architectures
+=======================
+This feature is applicable to user programs with the following
+architectures now:
+- x86
+- x86_64
+- arm
+- aarch64
+- mips
+- mips64
+
+
+Usage
+=====
+1. Install Cross-Compilation Tools
+Cross-compilation tools are required to build the shared libraries
+that can hook the necessary library functions. For example, a viable
+command on Ubuntu is:
+```
+apt install libc6:i386 gcc-arm-linux-gnueabihf \
+gcc-aarch64-linux-gnu gcc-mips-linux-gnu gcc-mips64-linux-gnuabi64
+```
+2. Locate the Compiled libnative.so
+After compilation, the libnative.so file can be found in the
+`./build/common-user/native/<target>-linux-user` directory.
+
+3. Run the Program with the `--native-bypass` Option
+To run your program with native library bypass, use the
+`--native-bypass` option to import libnative.so:
+```
+./build/qemu-<target> --native-bypass \
+./build/common-user/native/<target>-linux-user/libnative.so ./program
+```
-- 
2.34.1


