Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62DBE1073
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 01:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Auy-0007vW-56; Wed, 15 Oct 2025 19:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9Auw-0007vI-Bo
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:28:26 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9Aur-0001SC-Nb
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:28:25 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b62fcddfa21so40290a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760570899; x=1761175699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8k6JklyVNT0RQ4Y2ow7qi/JNbrLA90/mWbrGNVfAAvE=;
 b=dxmg5L/QCI7O5WENofaF9SZESwdLBobV2gHI1ex9F9elFk3wYjP8mjAK47M6s7tH5E
 gqEc8+mgAuY8rQgMgbsiDfY9meyulXgxkd6aZj4UqV9PEx2a03BCERVF6b6kHJ+DwAbQ
 NNS92iVf8hYsOpptg+sgTvHR4e2A19uXbSao7EVkmZCyQ6trL+5mSJgoP+8eq9lA6PxY
 t2vL3K1GkXjJd01n+cn3YyE4pnva/dLZRVYx7pcTNFI5w2FQTKc/gppWUZEp5ANbppv/
 gpbH8r3DQ+R51wddZf/Gk8I14EFt1KNoLxfFP2vzbuPoYmcW2DXCMRnMnT2N/IRoykYA
 2igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760570899; x=1761175699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8k6JklyVNT0RQ4Y2ow7qi/JNbrLA90/mWbrGNVfAAvE=;
 b=XXUnuaihyXy0MA0BBboqEMmoWdCOBplA90pjxgucnsb/yyqkxmuK5uwrhOhhjZGB68
 XYL03UuJ4fkDH0dmLjUryS2QRio/uDeN9dHgA1V33xiHXGHnNffImYdoC9jYxEJ5dvQl
 7/hEudaPDOaVL9aPLQvJZCzQmFkpxTThhkoPwmZSDeF0C2+guiRCnH9zonYJxta7BR9w
 DMehk+gV1HvtjlUh4RujyExIOPW0ePj5Lp4c8Wt6k+MHt4ZmjRRHCp64O4neFbFclbgY
 AOixuf1+Pj5c4x5aKMQiQScpADTXCHJ2h2KYrL/FBlhCIsGk+wOy9fjYoRjKjb/XrYv9
 vpng==
X-Gm-Message-State: AOJu0YyBQ1pGEwtB2xBCNW5uWwXv2MIsWqY1m2VFRNJjz69Y5pIA4tgb
 80o2Re24f+WiCY+oRey+sYOEhEYo0BgB4Hj+pp1avFcgc8faQGLKsqLOokCtGWmcyS2MsTCRhSQ
 drMCj
X-Gm-Gg: ASbGncvysz7eX7wh51nfnzfiVSVTsptcQEca6Ep8saVwfUNx0/OVeb7y2+aNAdfmNL8
 ifPQNmGqu28r2eYonkYjWu7Y5dVyuuRQ4T4p9oyf6i2QUrZt2bvDeb6CufV/0au4U9bZDvWUSJe
 CjBANoaEGM5rXTLI/W6iXDT/TYGAtuQH/Z3bMiYU+7eYRqBceuLPUi2JZwUwtAn/qBexsZ0gh7Z
 E9ZXp//g19HQLK0vtvJzWdvFXmC74LAt2oe6IIu7JYF6nq43aLptJrSsbfmlILFf4gN9+PFidKi
 j8t7tJwf5QpBfVA/l+Ur3MQTEcM69nVVnEpQvFO/0Rhe0QmsCk4QccK6QCmVDZpBDQldx6mEsxG
 reFpuwpde8PM7aFsEOOrMsb/pAW55unf03VHYJOL03sIS41C+5momI0jQ0sZwYG74NmtFOSJilB
 wxLFuCnLUv1QpvFB6DHdCuyzAgqWYZF/mDvyqKNhT7YVHkMA==
X-Google-Smtp-Source: AGHT+IHQmruXmSOHOyQ4ZvdcR3QGo/C4zdExXvbFVP/kDJv0VZ5kXVLq6z0vWhjHKy+U0giqVe/l1Q==
X-Received: by 2002:a17:903:2381:b0:28e:7ab2:811c with SMTP id
 d9443c01a7336-290272e4bc1mr397959425ad.45.1760570899358; 
 Wed, 15 Oct 2025 16:28:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099ae78c6sm7787485ad.100.2025.10.15.16.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 16:28:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] contrib/plugins/uftrace_symbols.py: generate debug files
 to map symbols to source
Date: Wed, 15 Oct 2025 16:28:09 -0700
Message-ID: <20251015232809.628043-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

Enhance uftrace_symbols.py to generate .dbg files, containing
source location for every symbol present in .sym file.
It allows to use `uftrace {replay,dump} --srcline` and show origin of
functions, connecting trace to original source code.

It was first implemented with pyelftools DWARF parser, which was way
too slow (~minutes) to get locations for every symbol in the linux
kernel. Thus, we use `addr2line` instead, which runs in seconds.

As well, there were some bugs with latest pyelftools release,
requiring to run master version, which is not installable with pip.
Thus, since we now require binutils (addr2line), we can ditch pyelftools
based implementation and simply rely on `nm` to get symbols information,
which is faster and better.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 116 +++++++++++++++++++----------
 1 file changed, 76 insertions(+), 40 deletions(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index b49e03203c8..45fb79c7a58 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 # -*- coding: utf-8 -*-
 #
-# Create symbols and mapping files for uftrace.
+# Create symbols, debug and mapping files for uftrace.
 #
 # Copyright 2025 Linaro Ltd
 # Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
@@ -9,44 +9,71 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import argparse
-import elftools # pip install pyelftools
 import os
+import subprocess
 
-from elftools.elf.elffile import ELFFile
-from elftools.elf.sections import SymbolTableSection
+class Symbol:
+    def __init__(self, name, addr, size):
+        self.name = name
+        # clamp addr to 48 bits, like uftrace entries
+        self.addr = addr & 0xffffffffffff
+        self.full_addr = addr
+        self.size = size
 
-def elf_func_symbols(elf):
-    symbol_tables = [(idx, s) for idx, s in enumerate(elf.iter_sections())
-                  if isinstance(s, SymbolTableSection)]
-    symbols = []
-    for _, section in symbol_tables:
-        for _, symbol in enumerate(section.iter_symbols()):
-            if symbol_size(symbol) == 0:
-                continue
-            type = symbol['st_info']['type']
-            if type == 'STT_FUNC' or type == 'STT_NOTYPE':
-                symbols.append(symbol)
-    symbols.sort(key = lambda x: symbol_addr(x))
+    def set_loc(self, file, line):
+        self.file = file
+        self.line = line
+
+def get_symbols(elf_file):
+    symbols=[]
+    try:
+        out = subprocess.check_output(['nm', '--print-size', elf_file],
+                                      stderr=subprocess.STDOUT,
+                                      text=True)
+    except subprocess.CalledProcessError as e:
+        print(e.output)
+        raise
+    out = out.strip().split('\n')
+    for line in out:
+        info = line.split(' ')
+        if len(info) == 3:
+            # missing size information
+            continue
+        addr, size, type, name = info
+        # add only symbols from .text section
+        if type.lower() != 't':
+            continue
+        addr = int(addr, 16)
+        size = int(size, 16)
+        symbols.append(Symbol(name, addr, size))
+    symbols.sort(key = lambda x: x.addr)
     return symbols
 
-def symbol_size(symbol):
-    return symbol['st_size']
-
-def symbol_addr(symbol):
-    addr = symbol['st_value']
-    # clamp addr to 48 bits, like uftrace entries
-    return addr & 0xffffffffffff
-
-def symbol_name(symbol):
-    return symbol.name
+def find_symbols_locations(elf_file, symbols):
+    addresses = '\n'.join([hex(x.full_addr) for x in symbols])
+    try:
+        out = subprocess.check_output(['addr2line', '--exe', elf_file],
+                                      stderr=subprocess.STDOUT,
+                                      input=addresses, text=True)
+    except subprocess.CalledProcessError as e:
+        print(e.output)
+        raise
+    out = out.strip().split('\n')
+    assert len(out) == len(symbols)
+    for i in range(len(symbols)):
+        s = symbols[i]
+        file, line = out[i].split(':')
+        # addr2line may return 'line (discriminator [0-9]+)' sometimes,
+        # remove this to keep only line number.
+        line = line.split(' ')[0]
+        s.set_loc(file, line)
 
 class BinaryFile:
     def __init__(self, path, map_offset):
         self.fullpath = os.path.realpath(path)
         self.map_offset = map_offset
-        with open(path, 'rb') as f:
-            self.elf = ELFFile(f)
-            self.symbols = elf_func_symbols(self.elf)
+        self.symbols = get_symbols(self.fullpath)
+        find_symbols_locations(self.fullpath, self.symbols)
 
     def path(self):
         return self.fullpath
@@ -56,24 +83,31 @@ def addr_start(self):
 
     def addr_end(self):
         last_sym = self.symbols[-1]
-        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
+        return last_sym.addr + last_sym.size + self.map_offset
 
     def generate_symbol_file(self, prefix_symbols):
         binary_name = os.path.basename(self.fullpath)
-        sym_file_path = f'./uftrace.data/{binary_name}.sym'
+        sym_file_path = os.path.join('uftrace.data', f'{binary_name}.sym')
         print(f'{sym_file_path} ({len(self.symbols)} symbols)')
         with open(sym_file_path, 'w') as sym_file:
             # print hexadecimal addresses on 48 bits
             addrx = "0>12x"
             for s in self.symbols:
-                addr = symbol_addr(s)
+                addr = s.addr
                 addr = f'{addr:{addrx}}'
-                size = f'{symbol_size(s):{addrx}}'
-                name = symbol_name(s)
+                size = f'{s.size:{addrx}}'
                 if prefix_symbols:
-                    name = f'{binary_name}:{name}'
+                    name = f'{binary_name}:{s.name}'
                 print(addr, size, 'T', name, file=sym_file)
 
+    def generate_debug_file(self):
+        binary_name = os.path.basename(self.fullpath)
+        dbg_file_path = os.path.join('uftrace.data', f'{binary_name}.dbg')
+        with open(dbg_file_path, 'w') as dbg_file:
+            for s in self.symbols:
+                print(f'F: {hex(s.addr)} {s.name}', file=dbg_file)
+                print(f'L: {s.line} {s.file}', file=dbg_file)
+
 def parse_parameter(p):
     s = p.split(":")
     path = s[0]
@@ -84,7 +118,7 @@ def parse_parameter(p):
     offset = s[1]
     if not offset.startswith('0x'):
         err = f'offset "{offset}" is not an hexadecimal constant. '
-        err += 'It should starts with "0x".'
+        err += 'It should start with "0x".'
         raise ValueError(err)
     offset = int(offset, 16)
     return path, offset
@@ -97,7 +131,7 @@ def is_from_user_mode(map_file_path):
     return False
 
 def generate_map(binaries):
-    map_file_path = './uftrace.data/sid-0.map'
+    map_file_path = os.path.join('uftrace.data', 'sid-0.map')
 
     if is_from_user_mode(map_file_path):
         print(f'do not overwrite {map_file_path} generated from qemu-user')
@@ -124,7 +158,8 @@ def generate_map(binaries):
 
 def main():
     parser = argparse.ArgumentParser(description=
-                                     'generate symbol files for uftrace')
+                                     'generate symbol files for uftrace. '
+                                     'Require binutils (nm and addr2line).')
     parser.add_argument('elf_file', nargs='+',
                         help='path to an ELF file. '
                         'Use /path/to/file:0xdeadbeef to add a mapping offset.')
@@ -133,8 +168,8 @@ def main():
                         action=argparse.BooleanOptionalAction)
     args = parser.parse_args()
 
-    if not os.path.exists('./uftrace.data'):
-        os.mkdir('./uftrace.data')
+    if not os.path.exists('uftrace.data'):
+        os.mkdir('uftrace.data')
 
     binaries = []
     for file in args.elf_file:
@@ -145,6 +180,7 @@ def main():
 
     for b in binaries:
         b.generate_symbol_file(args.prefix_symbols)
+        b.generate_debug_file()
 
     generate_map(binaries)
 
-- 
2.47.3


