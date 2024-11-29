Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4649D4587
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Nov 2024 02:52:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHn-0001ZS-V3; Wed, 20 Nov 2024 20:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHj-0001YO-Cf
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:07 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHh-0004X4-Hz
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=IhruTh9AaaXdYdQ72lpoc2vrYxq8f49r2KLX3qmIYJQ=; b=WnWdMnp+F6RqqVt
 gTSr4vNQ4PKS693vPGgInq9YdBo1GtoEqAKup4qGC0LugIyszVAhe0vGjzdRe/OAwPZEP16uZxpze
 mL8h3BAXpFgRcSAvW7MJpJ8EWasOb5VgSupYD/ZQKkHx0grHMHQgq0FDqLl8mKzCZWf5rvUB1RqqY
 yI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 09/43] helper-to-tcg: Introduce get-llvm-ir.py
Date: Thu, 21 Nov 2024 02:49:13 +0100
Message-ID: <20241121014947.18666-10-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Introduces a new python helper script to convert a set of QEMU .c files to
LLVM IR .ll using clang.  Compile flags are found by looking at
compile_commands.json, and llvm-link is used to link together all LLVM
modules into a single module.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/get-llvm-ir.py | 143 +++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100755 subprojects/helper-to-tcg/get-llvm-ir.py

diff --git a/subprojects/helper-to-tcg/get-llvm-ir.py b/subprojects/helper-to-tcg/get-llvm-ir.py
new file mode 100755
index 0000000000..9ee5d0e136
--- /dev/null
+++ b/subprojects/helper-to-tcg/get-llvm-ir.py
@@ -0,0 +1,143 @@
+#!/usr/bin/env python3
+
+##
+##  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
+##
+##  This program is free software; you can redistribute it and/or modify
+##  it under the terms of the GNU General Public License as published by
+##  the Free Software Foundation; either version 2 of the License, or
+##  (at your option) any later version.
+##
+##  This program is distributed in the hope that it will be useful,
+##  but WITHOUT ANY WARRANTY; without even the implied warranty of
+##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+##  GNU General Public License for more details.
+##
+##  You should have received a copy of the GNU General Public License
+##  along with this program; if not, see <http://www.gnu.org/licenses/>.
+##
+
+import argparse
+import json
+import os
+import shlex
+import sys
+import subprocess
+
+
+def log(msg):
+    print(msg, file=sys.stderr)
+
+
+def run_command(command):
+    proc = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
+    out = proc.communicate()
+    if proc.wait() != 0:
+        log(f"Command: {' '.join(command)} exited with {proc.returncode}\n")
+        log(f"output:\n{out}\n")
+
+
+def find_compile_commands(compile_commands_path, clang_path, input_path, target):
+    with open(compile_commands_path, "r") as f:
+        compile_commands = json.load(f)
+        for compile_command in compile_commands:
+            path = compile_command["file"]
+            if os.path.basename(path) != os.path.basename(input_path):
+                continue
+
+            os.chdir(compile_command["directory"])
+            command = compile_command["command"]
+
+            # If building multiple targets there's a chance
+            # input files share the same path and name.
+            # This could cause us to find the wrong compile
+            # command, we use the target path to distinguish
+            # between these.
+            if not target in command:
+                continue
+
+            argv = shlex.split(command)
+            argv[0] = clang_path
+
+            return argv
+
+    raise ValueError(f"Unable to find compile command for {input_path}")
+
+
+def generate_llvm_ir(
+    compile_commands_path, clang_path, output_path, input_path, target
+):
+    command = find_compile_commands(
+        compile_commands_path, clang_path, input_path, target
+    )
+
+    flags_to_remove = {
+        "-ftrivial-auto-var-init=zero",
+        "-fzero-call-used-regs=used-gpr",
+        "-Wimplicit-fallthrough=2",
+        "-Wold-style-declaration",
+        "-Wno-psabi",
+        "-Wshadow=local",
+    }
+
+    # Remove
+    #   - output of makefile rules (-MQ,-MF target);
+    #   - output of object files (-o target);
+    #   - excessive zero-initialization of block-scope variables
+    #     (-ftrivial-auto-var-init=zero);
+    #   - and any optimization flags (-O).
+    for i, arg in reversed(list(enumerate(command))):
+        if arg in {"-MQ", "-o", "-MF"}:
+            del command[i : i + 2]
+        elif arg.startswith("-O") or arg in flags_to_remove:
+            del command[i]
+
+    # Define a HELPER_TO_TCG macro for translation units wanting to
+    # conditionally include or exclude code during translation to TCG.
+    # Disable optimization (-O0) and make sure clang doesn't emit optnone
+    # attributes (-disable-O0-optnone) which inhibit further optimization.
+    # Optimization will be performed at a later stage in the helper-to-tcg
+    # pipeline.
+    command += [
+        "-S",
+        "-emit-llvm",
+        "-DHELPER_TO_TCG",
+        "-O0",
+        "-Xclang",
+        "-disable-O0-optnone",
+    ]
+    if output_path:
+        command += ["-o", output_path]
+
+    run_command(command)
+
+
+def main():
+    parser = argparse.ArgumentParser(
+        description="Produce the LLVM IR of a given .c file."
+    )
+    parser.add_argument(
+        "--compile-commands", required=True, help="Path to compile_commands.json"
+    )
+    parser.add_argument("--clang", default="clang", help="Path to clang.")
+    parser.add_argument("--llvm-link", default="llvm-link", help="Path to llvm-link.")
+    parser.add_argument("-o", "--output", required=True, help="Output .ll file path")
+    parser.add_argument(
+        "--target-path", help="Path to QEMU target dir. (e.q. target/i386)"
+    )
+    parser.add_argument("inputs", nargs="+", help=".c file inputs")
+    args = parser.parse_args()
+
+    outputs = []
+    for input in args.inputs:
+        output = os.path.basename(input) + ".ll"
+        generate_llvm_ir(
+            args.compile_commands, args.clang, output, input, args.target_path
+        )
+        outputs.append(output)
+
+    run_command([args.llvm_link] + outputs + ["-S", "-o", args.output])
+
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
2.45.2


