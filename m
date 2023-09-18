Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA37A4A9F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEOH-0000W2-RA; Mon, 18 Sep 2023 09:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENp-0000Bj-UK
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENl-0004gQ-NZ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695044024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Izi3AgniXVJCnAZ9pY2FQA6RTZ/rqmD6IBSgF3iUu+I=;
 b=Wjcob5C/2oi8TtxNodqYuAjP2SSsVbaHB7xeIHqwf1MqFmZMcYSBAse7KW+q+ilUHALKWs
 Qv6jUdG1xWOtnlsLkSlbaEYZRxKgVlJPJq2LO59jsvseMyqaymRSb44ohzKaZrO4NInaKk
 XockWr2kZaR0R/Z56T1z2je+qKLZ0tQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-E3mvzwqpOe2mzyZn5OogUw-1; Mon, 18 Sep 2023 09:33:42 -0400
X-MC-Unique: E3mvzwqpOe2mzyZn5OogUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25EF7185A79C;
 Mon, 18 Sep 2023 13:33:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96316140273C;
 Mon, 18 Sep 2023 13:33:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EBF091800D70; Mon, 18 Sep 2023 15:33:38 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 2/8] edk2: update build script
Date: Mon, 18 Sep 2023 15:33:24 +0200
Message-ID: <20230918133338.2399701-3-kraxel@redhat.com>
In-Reply-To: <20230918133338.2399701-1-kraxel@redhat.com>
References: <20230918133338.2399701-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Sync with latest version from gitlab.com/kraxel/edk2-build-config

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2-build.py | 202 ++++++++++++++++++++++++++++-----------------
 1 file changed, 128 insertions(+), 74 deletions(-)

diff --git a/roms/edk2-build.py b/roms/edk2-build.py
index 870893f7c8e3..e564765aaa71 100755
--- a/roms/edk2-build.py
+++ b/roms/edk2-build.py
@@ -6,6 +6,7 @@
 """
 import os
 import sys
+import time
 import shutil
 import argparse
 import subprocess
@@ -45,19 +46,28 @@ def get_coredir(cfg):
         return os.path.abspath(cfg['global']['core'])
     return os.getcwd()
 
-def get_version(cfg):
+def get_toolchain(cfg, build):
+    if cfg.has_option(build, 'tool'):
+        return cfg[build]['tool']
+    if cfg.has_option('global', 'tool'):
+        return cfg['global']['tool']
+    return 'GCC5'
+
+def get_version(cfg, silent = False):
     coredir = get_coredir(cfg)
     if version_override:
         version = version_override
-        print('')
-        print(f'### version [override]: {version}')
+        if not silent:
+            print('')
+            print(f'### version [override]: {version}')
         return version
     if os.environ.get('RPM_PACKAGE_NAME'):
         version = os.environ.get('RPM_PACKAGE_NAME')
         version += '-' + os.environ.get('RPM_PACKAGE_VERSION')
         version += '-' + os.environ.get('RPM_PACKAGE_RELEASE')
-        print('')
-        print(f'### version [rpmbuild]: {version}')
+        if not silent:
+            print('')
+            print(f'### version [rpmbuild]: {version}')
         return version
     if os.path.exists(coredir + '/.git'):
         cmdline = [ 'git', 'describe', '--tags', '--abbrev=8',
@@ -66,16 +76,17 @@ def get_version(cfg):
                                 stdout = subprocess.PIPE,
                                 check = True)
         version = result.stdout.decode().strip()
-        print('')
-        print(f'### version [git]: {version}')
+        if not silent:
+            print('')
+            print(f'### version [git]: {version}')
         return version
     return None
 
 def pcd_string(name, value):
     return f'{name}=L{value}\\0'
 
-def pcd_version(cfg):
-    version = get_version(cfg)
+def pcd_version(cfg, silent = False):
+    version = get_version(cfg, silent)
     if version is None:
         return []
     return [ '--pcd', pcd_string('PcdFirmwareVersionString', version) ]
@@ -85,49 +96,58 @@ def pcd_release_date():
         return []
     return [ '--pcd', pcd_string('PcdFirmwareReleaseDateString', release_date) ]
 
-def build_message(line, line2 = None):
+def build_message(line, line2 = None, silent = False):
     if os.environ.get('TERM') in [ 'xterm', 'xterm-256color' ]:
         # setxterm  title
         start  = '\x1b]2;'
         end    = '\x07'
         print(f'{start}{rebase_prefix}{line}{end}', end = '')
 
-    print('')
-    print('###')
-    print(f'### {rebase_prefix}{line}')
-    if line2:
-        print(f'### {line2}')
-    print('###', flush = True)
+    if silent:
+        print(f'### {rebase_prefix}{line}', flush = True)
+    else:
+        print('')
+        print('###')
+        print(f'### {rebase_prefix}{line}')
+        if line2:
+            print(f'### {line2}')
+        print('###', flush = True)
 
-def build_run(cmdline, name, section, silent = False):
-    print(cmdline, flush = True)
+def build_run(cmdline, name, section, silent = False, nologs = False):
     if silent:
-        print('### building in silent mode ...', flush = True)
+        logfile = f'{section}.log'
+        if nologs:
+            print(f'### building in silent mode [no log] ...', flush = True)
+        else:
+            print(f'### building in silent mode [{logfile}] ...', flush = True)
+        start = time.time()
         result = subprocess.run(cmdline, check = False,
                                 stdout = subprocess.PIPE,
                                 stderr = subprocess.STDOUT)
-
-        logfile = f'{section}.log'
-        print(f'### writing log to {logfile} ...')
-        with open(logfile, 'wb') as f:
-            f.write(result.stdout)
+        if not nologs:
+            with open(logfile, 'wb') as f:
+                f.write(result.stdout)
 
         if result.returncode:
             print('### BUILD FAILURE')
+            print('### cmdline')
+            print(cmdline)
             print('### output')
             print(result.stdout.decode())
             print(f'### exit code: {result.returncode}')
         else:
-            print('### OK')
+            secs = int(time.time() - start)
+            print(f'### OK ({int(secs/60)}:{secs%60:02d})')
     else:
+        print(cmdline, flush = True)
         result = subprocess.run(cmdline, check = False)
     if result.returncode:
         print(f'ERROR: {cmdline[0]} exited with {result.returncode}'
               f' while building {name}')
         sys.exit(result.returncode)
 
-def build_copy(plat, tgt, dstdir, copy):
-    srcdir = f'Build/{plat}/{tgt}_GCC5'
+def build_copy(plat, tgt, toolchain, dstdir, copy):
+    srcdir = f'Build/{plat}/{tgt}_{toolchain}'
     names = copy.split()
     srcfile = names[0]
     if len(names) > 1:
@@ -156,66 +176,68 @@ def pad_file(dstdir, pad):
     subprocess.run(cmdline, check = True)
 
 # pylint: disable=too-many-branches
-def build_one(cfg, build, jobs = None, silent = False):
+def build_one(cfg, build, jobs = None, silent = False, nologs = False):
+    b = cfg[build]
+
     cmdline  = [ 'build' ]
-    cmdline += [ '-t', 'GCC5' ]
-    cmdline += [ '-p', cfg[build]['conf'] ]
+    cmdline += [ '-t', get_toolchain(cfg, build) ]
+    cmdline += [ '-p', b['conf'] ]
 
-    if (cfg[build]['conf'].startswith('OvmfPkg/') or
-        cfg[build]['conf'].startswith('ArmVirtPkg/')):
-        cmdline += pcd_version(cfg)
+    if (b['conf'].startswith('OvmfPkg/') or
+        b['conf'].startswith('ArmVirtPkg/')):
+        cmdline += pcd_version(cfg, silent)
         cmdline += pcd_release_date()
 
     if jobs:
         cmdline += [ '-n', jobs ]
-    for arch in cfg[build]['arch'].split():
+    for arch in b['arch'].split():
         cmdline += [ '-a', arch ]
-    if 'opts' in cfg[build]:
-        for name in cfg[build]['opts'].split():
+    if 'opts' in b:
+        for name in b['opts'].split():
             section = 'opts.' + name
             for opt in cfg[section]:
                 cmdline += [ '-D', opt + '=' + cfg[section][opt] ]
-    if 'pcds' in cfg[build]:
-        for name in cfg[build]['pcds'].split():
+    if 'pcds' in b:
+        for name in b['pcds'].split():
             section = 'pcds.' + name
             for pcd in cfg[section]:
                 cmdline += [ '--pcd', pcd + '=' + cfg[section][pcd] ]
-    if 'tgts' in cfg[build]:
-        tgts = cfg[build]['tgts'].split()
+    if 'tgts' in b:
+        tgts = b['tgts'].split()
     else:
         tgts = [ 'DEBUG' ]
     for tgt in tgts:
         desc = None
-        if 'desc' in cfg[build]:
-            desc = cfg[build]['desc']
-        build_message(f'building: {cfg[build]["conf"]} ({cfg[build]["arch"]}, {tgt})',
-                      f'description: {desc}')
+        if 'desc' in b:
+            desc = b['desc']
+        build_message(f'building: {b["conf"]} ({b["arch"]}, {tgt})',
+                      f'description: {desc}',
+                      silent = silent)
         build_run(cmdline + [ '-b', tgt ],
-                  cfg[build]['conf'],
+                  b['conf'],
                   build + '.' + tgt,
-                  silent)
+                  silent,
+                  nologs)
 
-        if 'plat' in cfg[build]:
+        if 'plat' in b:
             # copy files
-            for cpy in cfg[build]:
+            for cpy in b:
                 if not cpy.startswith('cpy'):
                     continue
-                build_copy(cfg[build]['plat'],
-                           tgt,
-                           cfg[build]['dest'],
-                           cfg[build][cpy])
+                build_copy(b['plat'], tgt,
+                           get_toolchain(cfg, build),
+                           b['dest'], b[cpy])
             # pad builds
-            for pad in cfg[build]:
+            for pad in b:
                 if not pad.startswith('pad'):
                     continue
-                pad_file(cfg[build]['dest'],
-                         cfg[build][pad])
+                pad_file(b['dest'], b[pad])
 
-def build_basetools(silent = False):
-    build_message('building: BaseTools')
+def build_basetools(silent = False, nologs = False):
+    build_message('building: BaseTools', silent = silent)
     basedir = os.environ['EDK_TOOLS_PATH']
     cmdline = [ 'make', '-C', basedir ]
-    build_run(cmdline, 'BaseTools', 'build.basetools', silent)
+    build_run(cmdline, 'BaseTools', 'build.basetools', silent, nologs)
 
 def binary_exists(name):
     for pdir in os.environ['PATH'].split(':'):
@@ -223,7 +245,7 @@ def binary_exists(name):
             return True
     return False
 
-def prepare_env(cfg):
+def prepare_env(cfg, silent = False):
     """ mimic Conf/BuildEnv.sh """
     workspace = os.getcwd()
     packages = [ workspace, ]
@@ -253,7 +275,7 @@ def prepare_env(cfg):
     toolsdef = coredir + '/Conf/tools_def.txt'
     if not os.path.exists(toolsdef):
         os.makedirs(os.path.dirname(toolsdef), exist_ok = True)
-        build_message('running BaseTools/BuildEnv')
+        build_message('running BaseTools/BuildEnv', silent = silent)
         cmdline = [ 'bash', 'BaseTools/BuildEnv' ]
         subprocess.run(cmdline, cwd = coredir, check = True)
 
@@ -267,20 +289,32 @@ def prepare_env(cfg):
     os.environ['PYTHONHASHSEED'] = '1'
 
     # for cross builds
-    if binary_exists('arm-linux-gnu-gcc'):
+    if binary_exists('arm-linux-gnueabi-gcc'):
+        # ubuntu
+        os.environ['GCC5_ARM_PREFIX'] = 'arm-linux-gnueabi-'
+        os.environ['GCC_ARM_PREFIX'] = 'arm-linux-gnueabi-'
+    elif binary_exists('arm-linux-gnu-gcc'):
+        # fedora
         os.environ['GCC5_ARM_PREFIX'] = 'arm-linux-gnu-'
+        os.environ['GCC_ARM_PREFIX'] = 'arm-linux-gnu-'
     if binary_exists('loongarch64-linux-gnu-gcc'):
         os.environ['GCC5_LOONGARCH64_PREFIX'] = 'loongarch64-linux-gnu-'
+        os.environ['GCC_LOONGARCH64_PREFIX'] = 'loongarch64-linux-gnu-'
 
     hostarch = os.uname().machine
     if binary_exists('aarch64-linux-gnu-gcc') and hostarch != 'aarch64':
         os.environ['GCC5_AARCH64_PREFIX'] = 'aarch64-linux-gnu-'
+        os.environ['GCC_AARCH64_PREFIX'] = 'aarch64-linux-gnu-'
     if binary_exists('riscv64-linux-gnu-gcc') and hostarch != 'riscv64':
         os.environ['GCC5_RISCV64_PREFIX'] = 'riscv64-linux-gnu-'
+        os.environ['GCC_RISCV64_PREFIX'] = 'riscv64-linux-gnu-'
     if binary_exists('x86_64-linux-gnu-gcc') and hostarch != 'x86_64':
         os.environ['GCC5_IA32_PREFIX'] = 'x86_64-linux-gnu-'
         os.environ['GCC5_X64_PREFIX'] = 'x86_64-linux-gnu-'
         os.environ['GCC5_BIN'] = 'x86_64-linux-gnu-'
+        os.environ['GCC_IA32_PREFIX'] = 'x86_64-linux-gnu-'
+        os.environ['GCC_X64_PREFIX'] = 'x86_64-linux-gnu-'
+        os.environ['GCC_BIN'] = 'x86_64-linux-gnu-'
 
 def build_list(cfg):
     for build in cfg.sections():
@@ -303,10 +337,12 @@ def main():
     parser.add_argument('-j', '--jobs', dest = 'jobs', type = str,
                         help = 'allow up to JOBS parallel build jobs',
                         metavar = 'JOBS')
-    parser.add_argument('-m', '--match', dest = 'match', type = str,
+    parser.add_argument('-m', '--match', dest = 'match',
+                        type = str, action = 'append',
                         help = 'only run builds matching INCLUDE (substring)',
                         metavar = 'INCLUDE')
-    parser.add_argument('-x', '--exclude', dest = 'exclude', type = str,
+    parser.add_argument('-x', '--exclude', dest = 'exclude',
+                        type = str, action = 'append',
                         help = 'skip builds matching EXCLUDE (substring)',
                         metavar = 'EXCLUDE')
     parser.add_argument('-l', '--list', dest = 'list',
@@ -316,6 +352,9 @@ def main():
                         action = 'store_true', default = False,
                         help = 'write build output to logfiles, '
                         'write to console only on errors')
+    parser.add_argument('--no-logs', dest = 'nologs',
+                        action = 'store_true', default = False,
+                        help = 'do not write build log files (with --silent)')
     parser.add_argument('--core', dest = 'core', type = str, metavar = 'DIR',
                         help = 'location of the core edk2 repository '
                         '(i.e. where BuildTools are located)')
@@ -323,6 +362,9 @@ def main():
                         type = str, action = 'append', metavar = 'DIR',
                         help = 'location(s) of additional packages '
                         '(can be specified multiple times)')
+    parser.add_argument('-t', '--toolchain', dest = 'toolchain',
+                        type = str, metavar = 'NAME',
+                        help = 'tool chain to be used to build edk2')
     parser.add_argument('--version-override', dest = 'version_override',
                         type = str, metavar = 'VERSION',
                         help = 'set firmware build version')
@@ -335,7 +377,7 @@ def main():
         os.chdir(options.directory)
 
     if not os.path.exists(options.configfile):
-        print('config file "{options.configfile}" not found')
+        print(f'config file "{options.configfile}" not found')
         return 1
 
     cfg = configparser.ConfigParser()
@@ -344,7 +386,7 @@ def main():
 
     if options.list:
         build_list(cfg)
-        return
+        return 0
 
     if not cfg.has_section('global'):
         cfg.add_section('global')
@@ -352,6 +394,8 @@ def main():
         cfg.set('global', 'core', options.core)
     if options.pkgs:
         cfg.set('global', 'pkgs', ' '.join(options.pkgs))
+    if options.toolchain:
+        cfg.set('global', 'tool', options.toolchain)
 
     global version_override
     global release_date
@@ -361,18 +405,28 @@ def main():
     if options.release_date:
         release_date = options.release_date
 
-    prepare_env(cfg)
-    build_basetools(options.silent)
+    prepare_env(cfg, options.silent)
+    build_basetools(options.silent, options.nologs)
     for build in cfg.sections():
         if not build.startswith('build.'):
             continue
-        if options.match and options.match not in build:
-            print(f'# skipping "{build}" (not matching "{options.match}")')
-            continue
-        if options.exclude and options.exclude in build:
-            print(f'# skipping "{build}" (matching "{options.exclude}")')
-            continue
-        build_one(cfg, build, options.jobs, options.silent)
+        if options.match:
+            matching = False
+            for item in options.match:
+                if item in build:
+                    matching = True
+            if not matching:
+                print(f'# skipping "{build}" (not matching "{"|".join(options.match)}")')
+                continue
+        if options.exclude:
+            exclude = False
+            for item in options.exclude:
+                if item in build:
+                    print(f'# skipping "{build}" (matching "{item}")')
+                    exclude = True
+            if exclude:
+                continue
+        build_one(cfg, build, options.jobs, options.silent, options.nologs)
 
     return 0
 
-- 
2.41.0


