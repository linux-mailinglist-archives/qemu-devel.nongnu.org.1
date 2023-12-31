Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBEF820A86
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:50:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUm-0007UA-Nr; Sun, 31 Dec 2023 03:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTO-0005Xg-Iv
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTJ-0000zi-VD
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sw3pHZcqSBK/WVs4b2htln5t44nIcxf/4OtKVAy2i/Y=;
 b=etC7/wbtg0KfntG/LNtFxsFk71XJn6Ht1cUw9Gsa7Vn5AzL3SFHMApSjjhwJMHVey0ryC0
 TbyCX9dvlisG4L8Gw6axYxJYRcP1zqDqNDRVHbWMO5vU821EkjN3gcL+1ehHaXpEZTYbJO
 yzeimesbCPWvwczhUexNqRhNDUDljpA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-8MnbZrJIOE-yWeCTevbVYQ-1; Sun, 31 Dec 2023 03:46:58 -0500
X-MC-Unique: 8MnbZrJIOE-yWeCTevbVYQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33689c90957so5614660f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012417; x=1704617217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sw3pHZcqSBK/WVs4b2htln5t44nIcxf/4OtKVAy2i/Y=;
 b=GFtdT86E56c+ZhdeRjxNgoV09Y8seJ3Y9dGwj3ZyyqoGFu8tYCEMxkPo+AavBBFs2L
 sFDUSQcqR4FrM8ey3Zv9GsYaBAH7ltp2xWNftbsHl5bkbw4KGru3WdBPBshiRkLlHXIM
 v0U42Mp4jgubCR94pN1bNTVJHY+NetlkzSRVz1bkJr5KCDiyONK/24ybRo5NDmwChBc1
 RGZHjY4iL+CTCx7onnFz6D+Ujqi7hsv6M4kfVdbE560H5l8sfWR7G0X176PfrTObHb4R
 ylFca94vglqoZPZDE+uJYzzcAxtiF2hmvMqBJ/7xQCs3ZB8N7CXpuE6jGf1VsS2SglH8
 Pj0g==
X-Gm-Message-State: AOJu0Yxee8HMBlIOoy/JNT2qO0l3K1RTY11nIpUKv3J5ViuTn5c4YElu
 OvZWT/jjt8dG9+G0K0t8sco1LlyI1OmgucTk+nwC6CrTLuPtFH8WQ2fJVLoRqsKkquyKwwDDraC
 oS2LGbgAZ0ZoY2Oxwr+/7STnA5GlwF6nqqzSUVrWo94OSXyny3U6iPpr3OvV0lAMpkLJNW33Lsp
 bGHtmwYSY=
X-Received: by 2002:a05:600c:3b82:b0:40d:5a9f:2b59 with SMTP id
 n2-20020a05600c3b8200b0040d5a9f2b59mr3708372wms.41.1704012416224; 
 Sun, 31 Dec 2023 00:46:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtu91BBRpLJjpfWqKvuz62PoBj5CIS5bsFGh3t3sjdkLrKr7gz8DXvURhwIcBqPKMhMsfSNA==
X-Received: by 2002:a05:600c:3b82:b0:40d:5a9f:2b59 with SMTP id
 n2-20020a05600c3b8200b0040d5a9f2b59mr3708361wms.41.1704012414966; 
 Sun, 31 Dec 2023 00:46:54 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a05600c451400b0040d839de5c2sm4315901wmo.33.2023.12.31.00.46.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/46] configure, meson: rename targetos to host_os
Date: Sun, 31 Dec 2023 09:45:01 +0100
Message-ID: <20231231084502.235366-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This variable is about the host OS, not the target.  It is used a lot
more since the Meson conversion, but the original sin dates back to 2003.
Time to fix it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/meson.build                |   2 +-
 backends/meson.build                 |   4 +-
 block/meson.build                    |   4 +-
 bsd-user/meson.build                 |   2 +-
 chardev/meson.build                  |   4 +-
 configure                            |  58 ++++----
 contrib/ivshmem-client/meson.build   |   2 +-
 contrib/ivshmem-server/meson.build   |   2 +-
 contrib/vhost-user-blk/meson.build   |   2 +-
 contrib/vhost-user-input/meson.build |   2 +-
 contrib/vhost-user-scsi/meson.build  |   2 +-
 docs/devel/kconfig.rst               |   2 +-
 fsdev/meson.build                    |   2 +-
 hw/9pfs/meson.build                  |   4 +-
 hw/display/meson.build               |   2 +-
 hw/ppc/meson.build                   |   2 +-
 hw/usb/meson.build                   |   4 +-
 meson.build                          | 206 +++++++++++++--------------
 net/can/meson.build                  |   2 +-
 net/meson.build                      |   8 +-
 plugins/meson.build                  |   4 +-
 qga/meson.build                      |  16 +--
 scsi/meson.build                     |   2 +-
 system/meson.build                   |   4 +-
 tests/fp/meson.build                 |   2 +-
 tests/meson.build                    |   2 +-
 tests/plugin/meson.build             |   2 +-
 tests/qemu-iotests/meson.build       |   2 +-
 tests/qtest/meson.build              |  10 +-
 tests/unit/meson.build               |   8 +-
 ui/dbus-display1.xml                 |  10 +-
 ui/meson.build                       |   8 +-
 util/meson.build                     |   8 +-
 33 files changed, 197 insertions(+), 197 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 1dad6bbbfbd..d25638d6c15 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -17,7 +17,7 @@ if get_option('plugins')
   tcg_ss.add(files('plugin-gen.c'))
 endif
 tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
-if targetos == 'linux'
+if host_os == 'linux'
   tcg_ss.add(files('perf.c'))
 endif
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
diff --git a/backends/meson.build b/backends/meson.build
index 6dee4e9203b..8b2b111497f 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -10,11 +10,11 @@ system_ss.add([files(
   'confidential-guest-support.c',
 ), numa])
 
-if targetos != 'windows'
+if host_os != 'windows'
   system_ss.add(files('rng-random.c'))
   system_ss.add(files('hostmem-file.c'))
 endif
-if targetos == 'linux'
+if host_os == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
 endif
 if keyutils.found()
diff --git a/block/meson.build b/block/meson.build
index ddea1e40070..e1f03fd773e 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -88,13 +88,13 @@ if get_option('parallels').allowed()
   block_ss.add(files('parallels.c', 'parallels-ext.c'))
 endif
 
-if targetos == 'windows'
+if host_os == 'windows'
   block_ss.add(files('file-win32.c', 'win32-aio.c'))
 else
   block_ss.add(files('file-posix.c'), coref, iokit)
 endif
 block_ss.add(when: libiscsi, if_true: files('iscsi-opts.c'))
-if targetos == 'linux'
+if host_os == 'linux'
   block_ss.add(files('nvme.c'))
 endif
 if get_option('replication').allowed()
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index c6bfd3b2b53..39bad0ae33e 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -24,6 +24,6 @@ kvm = cc.find_library('kvm', required: true)
 bsd_user_ss.add(elf, procstat, kvm)
 
 # Pull in the OS-specific build glue, if any
-subdir(targetos)
+subdir(host_os)
 
 specific_ss.add_all(when: 'CONFIG_BSD_USER', if_true: bsd_user_ss)
diff --git a/chardev/meson.build b/chardev/meson.build
index db6840b71af..c80337d15fa 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -12,7 +12,7 @@ chardev_ss.add(files(
   'char-udp.c',
   'char.c',
 ))
-if targetos == 'windows'
+if host_os == 'windows'
   chardev_ss.add(files(
     'char-console.c',
     'char-win-stdio.c',
@@ -23,7 +23,7 @@ else
       'char-fd.c',
       'char-pty.c',
     ), util)
-  if targetos in ['linux', 'gnu/kfreebsd', 'freebsd', 'dragonfly']
+  if host_os in ['linux', 'gnu/kfreebsd', 'freebsd', 'dragonfly']
     chardev_ss.add(files('char-parallel.c'))
   endif
 endif
diff --git a/configure b/configure
index 0128fd30ea8..21ab9a64e98 100755
--- a/configure
+++ b/configure
@@ -334,30 +334,30 @@ EOF
 }
 
 if check_define __linux__ ; then
-  targetos=linux
+  host_os=linux
 elif check_define _WIN32 ; then
-  targetos=windows
+  host_os=windows
 elif check_define __OpenBSD__ ; then
-  targetos=openbsd
+  host_os=openbsd
 elif check_define __sun__ ; then
-  targetos=sunos
+  host_os=sunos
 elif check_define __HAIKU__ ; then
-  targetos=haiku
+  host_os=haiku
 elif check_define __FreeBSD__ ; then
-  targetos=freebsd
+  host_os=freebsd
 elif check_define __FreeBSD_kernel__ && check_define __GLIBC__; then
-  targetos=gnu/kfreebsd
+  host_os=gnu/kfreebsd
 elif check_define __DragonFly__ ; then
-  targetos=dragonfly
+  host_os=dragonfly
 elif check_define __NetBSD__; then
-  targetos=netbsd
+  host_os=netbsd
 elif check_define __APPLE__; then
-  targetos=darwin
+  host_os=darwin
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
   # be the result of a missing compiler.
-  targetos=bogus
+  host_os=bogus
 fi
 
 if test ! -z "$cpu" ; then
@@ -573,13 +573,13 @@ do
     fi
 done
 
-if test "$targetos" = "windows" ; then
+if test "$host_os" = "windows" ; then
   EXESUF=".exe"
 fi
 
 meson_option_build_array() {
   printf '['
-  (if test "$targetos" = windows; then
+  (if test "$host_os" = windows; then
     IFS=\;
   else
     IFS=:
@@ -802,7 +802,7 @@ mak_wilds=""
 
 if [ -n "$host_arch" ] && [ -d "$source_path/common-user/host/$host_arch" ]; then
     if [ "$linux_user" != no ]; then
-        if [ "$targetos" = linux ]; then
+        if [ "$host_os" = linux ]; then
             linux_user=yes
         elif [ "$linux_user" = yes ]; then
             error_exit "linux-user not supported on this architecture"
@@ -813,9 +813,9 @@ if [ -n "$host_arch" ] && [ -d "$source_path/common-user/host/$host_arch" ]; the
     fi
     if [ "$bsd_user" != no ]; then
         if [ "$bsd_user" = "" ]; then
-            test $targetos = freebsd && bsd_user=yes
+            test $host_os = freebsd && bsd_user=yes
         fi
-        if [ "$bsd_user" = yes ] && ! [ -d "$source_path/bsd-user/$targetos" ]; then
+        if [ "$bsd_user" = yes ] && ! [ -d "$source_path/bsd-user/$host_os" ]; then
             error_exit "bsd-user not supported on this host OS"
         fi
         if [ "$bsd_user" = "yes" ]; then
@@ -998,7 +998,7 @@ if test -z "$ninja"; then
     fi
 fi
 
-if test "$targetos" = "bogus"; then
+if test "$host_os" = "bogus"; then
     # Now that we know that we're not printing the help and that
     # the compiler works (so the results of the check_defines we used
     # to identify the OS are reliable), if we didn't recognize the
@@ -1007,7 +1007,7 @@ if test "$targetos" = "bogus"; then
 fi
 
 # test for any invalid configuration combinations
-if test "$targetos" = "windows" && ! has "$dlltool"; then
+if test "$host_os" = "windows" && ! has "$dlltool"; then
   if test "$plugins" = "yes"; then
     error_exit "TCG plugins requires dlltool to build on Windows platforms"
   fi
@@ -1041,7 +1041,7 @@ static THREAD int tls_var;
 int main(void) { return tls_var; }
 EOF
 
-if test "$targetos" = windows || test "$targetos" = haiku; then
+if test "$host_os" = windows || test "$host_os" = haiku; then
   if test "$pie" = "yes"; then
     error_exit "PIE not available due to missing OS support"
   fi
@@ -1541,8 +1541,8 @@ echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
 
 # Mac OS X ships with a broken assembler
 if have_target i386-softmmu x86_64-softmmu && \
-        test "$targetos" != "darwin" && test "$targetos" != "sunos" && \
-        test "$targetos" != "haiku" && \
+        test "$host_os" != "darwin" && test "$host_os" != "sunos" && \
+        test "$host_os" != "haiku" && \
         probe_target_compiler i386-softmmu; then
     subdirs="$subdirs pc-bios/optionrom"
     config_mak=pc-bios/optionrom/config.mak
@@ -1606,7 +1606,7 @@ echo "NINJA=$ninja" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers for KVM architectures
-if test "$targetos" = "linux" && test -n "$linux_arch"; then
+if test "$host_os" = "linux" && test -n "$linux_arch"; then
   symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
 fi
 
@@ -1629,13 +1629,13 @@ echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
 echo "PKG_CONFIG=${pkg_config}" >> contrib/plugins/$config_host_mak
 echo "CC=$cc $CPU_CFLAGS" >> contrib/plugins/$config_host_mak
 echo "CFLAGS=${CFLAGS-$default_cflags} $EXTRA_CFLAGS" >> contrib/plugins/$config_host_mak
-if test "$targetos" = windows; then
+if test "$host_os" = windows; then
   echo "DLLTOOL=$dlltool" >> contrib/plugins/$config_host_mak
 fi
-if test "$targetos" = darwin; then
+if test "$host_os" = darwin; then
   echo "CONFIG_DARWIN=y" >> contrib/plugins/$config_host_mak
 fi
-if test "$targetos" = windows; then
+if test "$host_os" = windows; then
   echo "CONFIG_WIN32=y" >> contrib/plugins/$config_host_mak
 fi
 
@@ -1715,7 +1715,7 @@ if test "$skip_meson" = no; then
   echo "# environment defaults, can still be overridden on " >> $cross
   echo "# the command line" >> $cross
   if test -e "$source_path/.git" && \
-      { test "$targetos" = linux || test "$targetos" = "windows"; }; then
+      { test "$host_os" = linux || test "$host_os" = "windows"; }; then
       echo 'werror = true' >> $cross
   fi
   echo "[project options]" >> $cross
@@ -1752,7 +1752,7 @@ if test "$skip_meson" = no; then
   echo "windmc = [$(meson_quote $windmc)]" >> $cross
   if test "$cross_compile" = "yes"; then
     echo "[host_machine]" >> $cross
-    echo "system = '$targetos'" >> $cross
+    echo "system = '$host_os'" >> $cross
     case "$cpu" in
         i386)
             echo "cpu_family = 'x86'" >> $cross
@@ -1778,8 +1778,8 @@ if test "$skip_meson" = no; then
   fi
   mv $cross config-meson.cross
   meson_add_machine_file config-meson.cross
-  if test -f "$source_path/configs/meson/$targetos.txt"; then
-    meson_add_machine_file $source_path/configs/meson/$targetos.txt
+  if test -f "$source_path/configs/meson/$host_os.txt"; then
+    meson_add_machine_file $source_path/configs/meson/$host_os.txt
   fi
 
   rm -rf meson-private meson-info meson-logs
diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
index ce8dcca84dd..3c8b09af4bf 100644
--- a/contrib/ivshmem-client/meson.build
+++ b/contrib/ivshmem-client/meson.build
@@ -1,4 +1,4 @@
 executable('ivshmem-client', files('ivshmem-client.c', 'main.c'), genh,
            dependencies: glib,
-           build_by_default: targetos == 'linux',
+           build_by_default: host_os == 'linux',
            install: false)
diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
index c6c3c82e89f..1c8fea6594d 100644
--- a/contrib/ivshmem-server/meson.build
+++ b/contrib/ivshmem-server/meson.build
@@ -1,4 +1,4 @@
 executable('ivshmem-server', files('ivshmem-server.c', 'main.c'), genh,
            dependencies: [qemuutil, rt],
-           build_by_default: targetos == 'linux',
+           build_by_default: host_os == 'linux',
            install: false)
diff --git a/contrib/vhost-user-blk/meson.build b/contrib/vhost-user-blk/meson.build
index dcb9e2ffcd0..ac1eece37a4 100644
--- a/contrib/vhost-user-blk/meson.build
+++ b/contrib/vhost-user-blk/meson.build
@@ -1,4 +1,4 @@
 executable('vhost-user-blk', files('vhost-user-blk.c'),
            dependencies: [qemuutil, vhost_user],
-           build_by_default: targetos == 'linux',
+           build_by_default: host_os == 'linux',
            install: false)
diff --git a/contrib/vhost-user-input/meson.build b/contrib/vhost-user-input/meson.build
index 21a9ed4f15e..840d866594b 100644
--- a/contrib/vhost-user-input/meson.build
+++ b/contrib/vhost-user-input/meson.build
@@ -1,4 +1,4 @@
 executable('vhost-user-input', files('main.c'),
            dependencies: [qemuutil, vhost_user],
-           build_by_default: targetos == 'linux',
+           build_by_default: host_os == 'linux',
            install: false)
diff --git a/contrib/vhost-user-scsi/meson.build b/contrib/vhost-user-scsi/meson.build
index cc893f6f203..44be04853e4 100644
--- a/contrib/vhost-user-scsi/meson.build
+++ b/contrib/vhost-user-scsi/meson.build
@@ -1,6 +1,6 @@
 if libiscsi.found()
   executable('vhost-user-scsi', files('vhost-user-scsi.c'),
              dependencies: [qemuutil, libiscsi, vhost_user],
-             build_by_default: targetos == 'linux',
+             build_by_default: host_os == 'linux',
              install: false)
 endif
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index 73f52de1067..ccb9a46bd77 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -316,6 +316,6 @@ variable::
 
     host_kconfig = \
       (have_tpm ? ['CONFIG_TPM=y'] : []) + \
-      (targetos == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
+      (host_os == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
       (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
       ...
diff --git a/fsdev/meson.build b/fsdev/meson.build
index db67530d7f2..e20d7255e1e 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -5,7 +5,7 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
   '9p-marshal.c',
   'qemu-fsdev.c',
 ), if_false: files('qemu-fsdev-dummy.c'))
-if targetos in ['linux', 'darwin']
+if host_os in ['linux', 'darwin']
   system_ss.add_all(fsdev_ss)
 endif
 
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index 3eee7c268a9..f1b62fa8c80 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -13,9 +13,9 @@ fs_ss.add(files(
   'coth.c',
   'coxattr.c',
 ))
-if targetos == 'darwin'
+if host_os == 'darwin'
   fs_ss.add(files('9p-util-darwin.c'))
-elif targetos == 'linux'
+elif host_os == 'linux'
   fs_ss.add(files('9p-util-linux.c'))
 endif
 fs_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-9p-backend.c'))
diff --git a/hw/display/meson.build b/hw/display/meson.build
index ac0159c516e..f93a69f70f4 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -69,7 +69,7 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss = ss.source_set()
   virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_GPU',
                     if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c'), pixman])
-  if targetos == 'linux'
+  if host_os == 'linux'
     virtio_gpu_ss.add(files('virtio-gpu-udmabuf.c'))
   else
     virtio_gpu_ss.add(files('virtio-gpu-udmabuf-stubs.c'))
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 3dedcf3043d..eba3406e7f3 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -34,7 +34,7 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
   'spapr_softmmu.c',
 ))
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
-if targetos == 'linux'
+if host_os == 'linux'
   ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
     'spapr_pci_vfio.c',
   ))
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index b7755b638fc..2c13c528785 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -44,7 +44,7 @@ system_ss.add(when: 'CONFIG_USB_STORAGE_UAS', if_true: files('dev-uas.c'))
 system_ss.add(when: 'CONFIG_USB_AUDIO', if_true: files('dev-audio.c'))
 system_ss.add(when: 'CONFIG_USB_SERIAL', if_true: files('dev-serial.c'))
 system_ss.add(when: 'CONFIG_USB_NETWORK', if_true: files('dev-network.c'))
-if targetos != 'windows'
+if host_os != 'windows'
   system_ss.add(when: 'CONFIG_USB_STORAGE_MTP', if_true: files('dev-mtp.c'))
 endif
 
@@ -60,7 +60,7 @@ endif
 
 # U2F
 system_ss.add(when: 'CONFIG_USB_U2F', if_true: files('u2f.c'))
-if targetos == 'linux'
+if host_os == 'linux'
   system_ss.add(when: 'CONFIG_USB_U2F', if_true: [libudev, files('u2f-passthru.c')])
 endif
 if u2f.found()
diff --git a/meson.build b/meson.build
index 754c469ec98..44bc5bf0c0e 100644
--- a/meson.build
+++ b/meson.build
@@ -18,7 +18,7 @@ keyval = import('keyval')
 ss = import('sourceset')
 fs = import('fs')
 
-targetos = host_machine.system()
+host_os = host_machine.system()
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 
 # Temporary directory used for files created while
@@ -61,11 +61,11 @@ python = import('python').find_installation()
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
-if targetos == 'windows' and add_languages('cpp', required: false, native: false)
+if host_os == 'windows' and add_languages('cpp', required: false, native: false)
   all_languages += ['cpp']
   cxx = meson.get_compiler('cpp')
 endif
-if targetos == 'darwin' and \
+if host_os == 'darwin' and \
    add_languages('objc', required: get_option('cocoa'), native: false)
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
@@ -120,7 +120,7 @@ if get_option('fuzzing') and get_option('fuzzing_engine') == '' and \
 endif
 
 # Tracing backends
-if 'ftrace' in get_option('trace_backends') and targetos != 'linux'
+if 'ftrace' in get_option('trace_backends') and host_os != 'linux'
   error('ftrace is supported only on Linux')
 endif
 if 'syslog' in get_option('trace_backends') and not cc.compiles('''
@@ -135,30 +135,30 @@ endif
 
 # Miscellaneous Linux-only features
 get_option('mpath') \
-  .require(targetos == 'linux', error_message: 'Multipath is supported only on Linux')
+  .require(host_os == 'linux', error_message: 'Multipath is supported only on Linux')
 
 multiprocess_allowed = get_option('multiprocess') \
-  .require(targetos == 'linux', error_message: 'Multiprocess QEMU is supported only on Linux') \
+  .require(host_os == 'linux', error_message: 'Multiprocess QEMU is supported only on Linux') \
   .allowed()
 
 vfio_user_server_allowed = get_option('vfio_user_server') \
-  .require(targetos == 'linux', error_message: 'vfio-user server is supported only on Linux') \
+  .require(host_os == 'linux', error_message: 'vfio-user server is supported only on Linux') \
   .allowed()
 
 have_tpm = get_option('tpm') \
-  .require(targetos != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
+  .require(host_os != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
   .allowed()
 
 # vhost
 have_vhost_user = get_option('vhost_user') \
-  .disable_auto_if(targetos != 'linux') \
-  .require(targetos != 'windows',
+  .disable_auto_if(host_os != 'linux') \
+  .require(host_os != 'windows',
            error_message: 'vhost-user is not available on Windows').allowed()
 have_vhost_vdpa = get_option('vhost_vdpa') \
-  .require(targetos == 'linux',
+  .require(host_os == 'linux',
            error_message: 'vhost-vdpa is only available on Linux').allowed()
 have_vhost_kernel = get_option('vhost_kernel') \
-  .require(targetos == 'linux',
+  .require(host_os == 'linux',
            error_message: 'vhost-kernel is only available on Linux').allowed()
 have_vhost_user_crypto = get_option('vhost_crypto') \
   .require(have_vhost_user,
@@ -187,13 +187,13 @@ have_tools = get_option('tools') \
   .allowed()
 have_ga = get_option('guest_agent') \
   .disable_auto_if(not have_system and not have_tools) \
-  .require(targetos in ['sunos', 'linux', 'windows', 'freebsd', 'netbsd', 'openbsd'],
+  .require(host_os in ['sunos', 'linux', 'windows', 'freebsd', 'netbsd', 'openbsd'],
            error_message: 'unsupported OS for QEMU guest agent') \
   .allowed()
 have_block = have_system or have_tools
 
 enable_modules = get_option('modules') \
-  .require(targetos != 'windows',
+  .require(host_os != 'windows',
            error_message: 'Modules are not available for Windows') \
   .require(not get_option('prefer_static'),
            error_message: 'Modules are incompatible with static linking') \
@@ -260,7 +260,7 @@ endif
 
 modular_tcg = []
 # Darwin does not support references to thread-local variables in modules
-if targetos != 'darwin'
+if host_os != 'darwin'
   modular_tcg = ['i386-softmmu', 'x86_64-softmmu']
 endif
 
@@ -300,18 +300,18 @@ qemu_common_flags = [
 qemu_cflags = []
 qemu_ldflags = []
 
-if targetos == 'darwin'
+if host_os == 'darwin'
   # Disable attempts to use ObjectiveC features in os/object.h since they
   # won't work when we're compiling with gcc as a C compiler.
   if compiler.get_id() == 'gcc'
     qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
   endif
-elif targetos == 'sunos'
+elif host_os == 'sunos'
   # needed for CMSG_ macros in sys/socket.h
   qemu_common_flags += '-D_XOPEN_SOURCE=600'
   # needed for TIOCWIN* defines in termios.h
   qemu_common_flags += '-D__EXTENSIONS__'
-elif targetos == 'haiku'
+elif host_os == 'haiku'
   qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
 endif
 
@@ -395,10 +395,10 @@ ucontext_probe = '''
 # For POSIX prefer ucontext, but it's not always possible. The fallback
 # is sigcontext.
 supported_backends = []
-if targetos == 'windows'
+if host_os == 'windows'
   supported_backends += ['windows']
 else
-  if targetos != 'darwin' and cc.links(ucontext_probe)
+  if host_os != 'darwin' and cc.links(ucontext_probe)
     supported_backends += ['ucontext']
   endif
   supported_backends += ['sigaltstack']
@@ -469,13 +469,13 @@ endif
 # The combination is known as "full relro", because .got.plt is read-only too.
 qemu_ldflags += cc.get_supported_link_arguments('-Wl,-z,relro', '-Wl,-z,now')
 
-if targetos == 'windows'
+if host_os == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-seh', '-Wl,--nxcompat')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
 
 # Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
-if targetos != 'sunos' and not get_option('tsan')
+if host_os != 'sunos' and not get_option('tsan')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--warn-common')
 endif
 
@@ -585,7 +585,7 @@ warn_flags = [
   '-Wshadow=local',
 ]
 
-if targetos != 'darwin'
+if host_os != 'darwin'
   warn_flags += ['-Wthread-safety']
 endif
 
@@ -605,7 +605,7 @@ if 'objc' in all_languages
   # Note sanitizer flags are not applied to Objective-C sources!
   add_project_arguments(objc.get_supported_arguments(warn_flags), native: false, language: 'objc')
 endif
-if targetos == 'linux'
+if host_os == 'linux'
   add_project_arguments('-isystem', meson.current_source_dir() / 'linux-headers',
                         '-isystem', 'linux-headers',
                         language: all_languages)
@@ -652,7 +652,7 @@ midl = not_found
 widl = not_found
 pathcch = not_found
 host_dsosuf = '.so'
-if targetos == 'windows'
+if host_os == 'windows'
   midl = find_program('midl', required: false)
   widl = find_program('widl', required: false)
   pathcch = cc.find_library('pathcch')
@@ -664,19 +664,19 @@ if targetos == 'windows'
                                       depend_files: files('pc-bios/qemu-nsis.ico'),
                                       include_directories: include_directories('.'))
   host_dsosuf = '.dll'
-elif targetos == 'darwin'
+elif host_os == 'darwin'
   coref = dependency('appleframeworks', modules: 'CoreFoundation')
   iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
   host_dsosuf = '.dylib'
-elif targetos == 'sunos'
+elif host_os == 'sunos'
   socket = [cc.find_library('socket'),
             cc.find_library('nsl'),
             cc.find_library('resolv')]
-elif targetos == 'haiku'
+elif host_os == 'haiku'
   socket = [cc.find_library('posix_error_mapper'),
             cc.find_library('network'),
             cc.find_library('bsd')]
-elif targetos == 'openbsd'
+elif host_os == 'openbsd'
   if get_option('tcg').allowed() and target_dirs.length() > 0
     # Disable OpenBSD W^X if available
     emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
@@ -688,10 +688,10 @@ endif
 ###############################################
 
 accelerators = []
-if get_option('kvm').allowed() and targetos == 'linux'
+if get_option('kvm').allowed() and host_os == 'linux'
   accelerators += 'CONFIG_KVM'
 endif
-if get_option('whpx').allowed() and targetos == 'windows'
+if get_option('whpx').allowed() and host_os == 'windows'
   if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
     error('WHPX requires 64-bit host')
   elif cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
@@ -710,7 +710,7 @@ if get_option('hvf').allowed()
 endif
 
 nvmm = not_found
-if targetos == 'netbsd'
+if host_os == 'netbsd'
   nvmm = cc.find_library('nvmm', required: get_option('nvmm'))
   if nvmm.found()
     accelerators += 'CONFIG_NVMM'
@@ -830,7 +830,7 @@ endif
 have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
   .require(xen.found(),
            error_message: 'Xen PCI passthrough requested but Xen not enabled') \
-  .require(targetos == 'linux',
+  .require(host_os == 'linux',
            error_message: 'Xen PCI passthrough not available on this platform') \
   .require(cpu == 'x86'  or cpu == 'x86_64',
            error_message: 'Xen PCI passthrough not available on this platform') \
@@ -858,7 +858,7 @@ endif
 
 # This workaround is required due to a bug in pkg-config file for glib as it
 # doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
-if targetos == 'windows' and get_option('prefer_static')
+if host_os == 'windows' and get_option('prefer_static')
   glib_cflags += ['-DGLIB_STATIC_COMPILATION']
 endif
 
@@ -1119,12 +1119,12 @@ if vde.found() and not cc.links('''
 endif
 
 pulse = not_found
-if not get_option('pa').auto() or (targetos == 'linux' and have_system)
+if not get_option('pa').auto() or (host_os == 'linux' and have_system)
   pulse = dependency('libpulse', required: get_option('pa'),
                      method: 'pkg-config')
 endif
 alsa = not_found
-if not get_option('alsa').auto() or (targetos == 'linux' and have_system)
+if not get_option('alsa').auto() or (host_os == 'linux' and have_system)
   alsa = dependency('alsa', required: get_option('alsa'),
                     method: 'pkg-config')
 endif
@@ -1134,7 +1134,7 @@ if not get_option('jack').auto() or have_system
                     method: 'pkg-config')
 endif
 pipewire = not_found
-if not get_option('pipewire').auto() or (targetos == 'linux' and have_system)
+if not get_option('pipewire').auto() or (host_os == 'linux' and have_system)
   pipewire = dependency('libpipewire-0.3', version: '>=0.3.60',
                     required: get_option('pipewire'),
                     method: 'pkg-config')
@@ -1179,7 +1179,7 @@ if not get_option('zstd').auto() or have_block
 endif
 virgl = not_found
 
-have_vhost_user_gpu = have_tools and targetos == 'linux' and pixman.found()
+have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
 if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
   virgl = dependency('virglrenderer',
                      method: 'pkg-config',
@@ -1204,7 +1204,7 @@ if not get_option('curl').auto() or have_block
                     required: get_option('curl'))
 endif
 libudev = not_found
-if targetos == 'linux' and (have_system or have_tools)
+if host_os == 'linux' and (have_system or have_tools)
   libudev = dependency('libudev',
                        method: 'pkg-config',
                        required: get_option('libudev'))
@@ -1212,7 +1212,7 @@ endif
 
 mpathlibs = [libudev]
 mpathpersist = not_found
-if targetos == 'linux' and have_tools and get_option('mpath').allowed()
+if host_os == 'linux' and have_tools and get_option('mpath').allowed()
   mpath_test_source = '''
     #include <libudev.h>
     #include <mpath_persist.h>
@@ -1283,7 +1283,7 @@ if have_system and get_option('curses').allowed()
       return 0;
     }'''
 
-  curses_dep_list = targetos == 'windows' ? ['ncurses', 'ncursesw'] : ['ncursesw']
+  curses_dep_list = host_os == 'windows' ? ['ncurses', 'ncursesw'] : ['ncursesw']
   curses = dependency(curses_dep_list,
                       required: false,
                       method: 'pkg-config')
@@ -1300,13 +1300,13 @@ if have_system and get_option('curses').allowed()
   endif
   if not curses.found()
     has_curses_h = cc.has_header('curses.h', args: curses_compile_args)
-    if targetos != 'windows' and not has_curses_h
+    if host_os != 'windows' and not has_curses_h
       message('Trying with /usr/include/ncursesw')
       curses_compile_args += ['-I/usr/include/ncursesw']
       has_curses_h = cc.has_header('curses.h', args: curses_compile_args)
     endif
     if has_curses_h
-      curses_libname_list = (targetos == 'windows' ? ['pdcurses'] : ['ncursesw', 'cursesw'])
+      curses_libname_list = (host_os == 'windows' ? ['pdcurses'] : ['ncursesw', 'cursesw'])
       foreach curses_libname : curses_libname_list
         libcurses = cc.find_library(curses_libname,
                                     required: false)
@@ -1529,7 +1529,7 @@ oss = not_found
 if get_option('oss').allowed() and have_system
   if not cc.has_header('sys/soundcard.h')
     # not found
-  elif targetos == 'netbsd'
+  elif host_os == 'netbsd'
     oss = cc.find_library('ossaudio', required: get_option('oss'))
   else
     oss = declare_dependency()
@@ -1542,7 +1542,7 @@ if get_option('oss').allowed() and have_system
   endif
 endif
 dsound = not_found
-if not get_option('dsound').auto() or (targetos == 'windows' and have_system)
+if not get_option('dsound').auto() or (host_os == 'windows' and have_system)
   if cc.has_header('dsound.h')
     dsound = declare_dependency(link_args: ['-lole32', '-ldxguid'])
   endif
@@ -1555,7 +1555,7 @@ if not get_option('dsound').auto() or (targetos == 'windows' and have_system)
 endif
 
 coreaudio = not_found
-if not get_option('coreaudio').auto() or (targetos == 'darwin' and have_system)
+if not get_option('coreaudio').auto() or (host_os == 'darwin' and have_system)
   coreaudio = dependency('appleframeworks', modules: 'CoreAudio',
                          required: get_option('coreaudio'))
 endif
@@ -1910,7 +1910,7 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
 has_statx_mnt_id = cc.has_header_symbol('sys/stat.h', 'STATX_MNT_ID', prefix: gnu_source_prefix)
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
-  .require(targetos == 'linux',
+  .require(host_os == 'linux',
            error_message: 'vhost_user_blk_server requires linux') \
   .require(have_vhost_user,
            error_message: 'vhost_user_blk_server requires vhost-user support') \
@@ -1938,18 +1938,18 @@ if get_option('fuse_lseek').allowed()
   endif
 endif
 
-have_libvduse = (targetos == 'linux')
+have_libvduse = (host_os == 'linux')
 if get_option('libvduse').enabled()
-    if targetos != 'linux'
+    if host_os != 'linux'
         error('libvduse requires linux')
     endif
 elif get_option('libvduse').disabled()
     have_libvduse = false
 endif
 
-have_vduse_blk_export = (have_libvduse and targetos == 'linux')
+have_vduse_blk_export = (have_libvduse and host_os == 'linux')
 if get_option('vduse_blk_export').enabled()
-    if targetos != 'linux'
+    if host_os != 'linux'
         error('vduse_blk_export requires linux')
     elif not have_libvduse
         error('vduse_blk_export requires libvduse support')
@@ -2017,7 +2017,7 @@ if have_system
   # Default to native drivers first, OSS second, SDL third
   audio_drivers_priority = \
     [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
-    (targetos == 'linux' ? [] : [ 'sdl' ])
+    (host_os == 'linux' ? [] : [ 'sdl' ])
   audio_drivers_default = []
   foreach k: audio_drivers_priority
     if audio_drivers_available[k]
@@ -2038,7 +2038,7 @@ endif
 config_host_data.set('CONFIG_AUDIO_DRIVERS',
                      '"' + '", "'.join(audio_drivers_selected) + '", ')
 
-have_host_block_device = (targetos != 'darwin' or
+have_host_block_device = (host_os != 'darwin' or
     cc.has_header('IOKit/storage/IOMedia.h'))
 
 dbus_display = get_option('dbus_display') \
@@ -2049,17 +2049,17 @@ dbus_display = get_option('dbus_display') \
   .allowed()
 
 have_virtfs = get_option('virtfs') \
-    .require(targetos == 'linux' or targetos == 'darwin',
+    .require(host_os == 'linux' or host_os == 'darwin',
              error_message: 'virtio-9p (virtfs) requires Linux or macOS') \
-    .require(targetos == 'linux' or cc.has_function('pthread_fchdir_np'),
+    .require(host_os == 'linux' or cc.has_function('pthread_fchdir_np'),
              error_message: 'virtio-9p (virtfs) on macOS requires the presence of pthread_fchdir_np') \
-    .require(targetos == 'darwin' or libattr.found(),
+    .require(host_os == 'darwin' or libattr.found(),
              error_message: 'virtio-9p (virtfs) on Linux requires libattr-devel') \
     .disable_auto_if(not have_tools and not have_system) \
     .allowed()
 
 have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
-    .require(targetos != 'darwin', error_message: 'the virtfs proxy helper is incompatible with macOS') \
+    .require(host_os != 'darwin', error_message: 'the virtfs proxy helper is incompatible with macOS') \
     .require(have_virtfs, error_message: 'the virtfs proxy helper requires that virtfs is enabled') \
     .disable_auto_if(not have_tools) \
     .require(libcap_ng.found(), error_message: 'the virtfs proxy helper requires libcap-ng') \
@@ -2114,12 +2114,12 @@ if enable_modules
 endif
 
 have_slirp_smbd = get_option('slirp_smbd') \
-  .require(targetos != 'windows', error_message: 'Host smbd not supported on this platform.') \
+  .require(host_os != 'windows', error_message: 'Host smbd not supported on this platform.') \
   .allowed()
 if have_slirp_smbd
   smbd_path = get_option('smbd')
   if smbd_path == ''
-    smbd_path = (targetos == 'sunos' ? '/usr/sfw/sbin/smbd' : '/usr/sbin/smbd')
+    smbd_path = (host_os == 'sunos' ? '/usr/sfw/sbin/smbd' : '/usr/sbin/smbd')
   endif
   config_host_data.set_quoted('CONFIG_SMBD_COMMAND', smbd_path)
 endif
@@ -2127,7 +2127,7 @@ endif
 config_host_data.set('HOST_' + host_arch.to_upper(), 1)
 
 kvm_targets_c = '""'
-if get_option('kvm').allowed() and targetos == 'linux'
+if get_option('kvm').allowed() and host_os == 'linux'
   kvm_targets_c = '"' + '" ,"'.join(kvm_targets) + '"'
 endif
 config_host_data.set('CONFIG_KVM_TARGETS', kvm_targets_c)
@@ -2140,16 +2140,16 @@ config_host_data.set('CONFIG_MODULE_UPGRADES', get_option('module_upgrades'))
 config_host_data.set('CONFIG_ATTR', libattr.found())
 config_host_data.set('CONFIG_BDRV_WHITELIST_TOOLS', get_option('block_drv_whitelist_in_tools'))
 config_host_data.set('CONFIG_BRLAPI', brlapi.found())
-config_host_data.set('CONFIG_BSD', targetos in bsd_oses)
+config_host_data.set('CONFIG_BSD', host_os in bsd_oses)
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_COCOA', cocoa.found())
-config_host_data.set('CONFIG_DARWIN', targetos == 'darwin')
+config_host_data.set('CONFIG_DARWIN', host_os == 'darwin')
 config_host_data.set('CONFIG_FUZZ', get_option('fuzzing'))
 config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
-config_host_data.set('CONFIG_LINUX', targetos == 'linux')
-config_host_data.set('CONFIG_POSIX', targetos != 'windows')
-config_host_data.set('CONFIG_WIN32', targetos == 'windows')
+config_host_data.set('CONFIG_LINUX', host_os == 'linux')
+config_host_data.set('CONFIG_POSIX', host_os != 'windows')
+config_host_data.set('CONFIG_WIN32', host_os == 'windows')
 config_host_data.set('CONFIG_LZO', lzo.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_BLKIO', blkio.found())
@@ -2207,7 +2207,7 @@ endif
 config_host_data.set('CONFIG_PIXMAN', pixman.found())
 config_host_data.set('CONFIG_SLIRP', slirp.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
-config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
+config_host_data.set('CONFIG_SOLARIS', host_os == 'sunos')
 if get_option('tcg').allowed()
   config_host_data.set('CONFIG_TCG', 1)
   config_host_data.set('CONFIG_TCG_INTERPRETER', tcg_arch == 'tci')
@@ -2308,7 +2308,7 @@ config_host_data.set('HAVE_PTY_H', cc.has_header('pty.h'))
 config_host_data.set('HAVE_SYS_DISK_H', cc.has_header('sys/disk.h'))
 config_host_data.set('HAVE_SYS_IOCCOM_H', cc.has_header('sys/ioccom.h'))
 config_host_data.set('HAVE_SYS_KCOV_H', cc.has_header('sys/kcov.h'))
-if targetos == 'windows'
+if host_os == 'windows'
   config_host_data.set('HAVE_AFUNIX_H', cc.has_header('afunix.h'))
 endif
 
@@ -2690,7 +2690,7 @@ config_host_data.set('CONFIG_USBFS', have_linux_user and cc.compiles('''
   int main(void) { return 0; }'''))
 
 have_keyring = get_option('keyring') \
-  .require(targetos == 'linux', error_message: 'keyring is only available on Linux') \
+  .require(host_os == 'linux', error_message: 'keyring is only available on Linux') \
   .require(cc.compiles('''
     #include <errno.h>
     #include <asm/unistd.h>
@@ -2799,9 +2799,9 @@ endif
 
 if get_option('membarrier').disabled()
   have_membarrier = false
-elif targetos == 'windows'
+elif host_os == 'windows'
   have_membarrier = true
-elif targetos == 'linux'
+elif host_os == 'linux'
   have_membarrier = cc.compiles('''
     #include <linux/membarrier.h>
     #include <sys/syscall.h>
@@ -2838,7 +2838,7 @@ config_host_data.set('CONFIG_AF_VSOCK', cc.has_header_symbol(
 
 have_vss = false
 have_vss_sdk = false # old xp/2003 SDK
-if targetos == 'windows' and 'cpp' in all_languages
+if host_os == 'windows' and 'cpp' in all_languages
   have_vss = cxx.compiles('''
     #define __MIDL_user_allocate_free_DEFINED__
     #include <vss.h>
@@ -2849,7 +2849,7 @@ config_host_data.set('HAVE_VSS_SDK', have_vss_sdk)
 
 # Older versions of MinGW do not import _lock_file and _unlock_file properly.
 # This was fixed for v6.0.0 with commit b48e3ac8969d.
-if targetos == 'windows'
+if host_os == 'windows'
   config_host_data.set('HAVE__LOCK_FILE', cc.links('''
     #include <stdio.h>
     int main(void) {
@@ -2859,7 +2859,7 @@ if targetos == 'windows'
     }''', name: '_lock_file and _unlock_file'))
 endif
 
-if targetos == 'windows'
+if host_os == 'windows'
   mingw_has_setjmp_longjmp = cc.links('''
     #include <setjmp.h>
     int main(void) {
@@ -2929,7 +2929,7 @@ host_kconfig = \
   (have_vhost_vdpa ? ['CONFIG_VHOST_VDPA=y'] : []) + \
   (have_vhost_kernel ? ['CONFIG_VHOST_KERNEL=y'] : []) + \
   (have_virtfs ? ['CONFIG_VIRTFS=y'] : []) + \
-  (targetos == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
+  (host_os == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
   (have_pvrdma ? ['CONFIG_PVRDMA=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
@@ -2943,7 +2943,7 @@ fdt_required = []
 foreach target : target_dirs
   config_target = { 'TARGET_NAME': target.split('-')[0] }
   if target.endswith('linux-user')
-    if targetos != 'linux'
+    if host_os != 'linux'
       if default_targets
         continue
       endif
@@ -2951,7 +2951,7 @@ foreach target : target_dirs
     endif
     config_target += { 'CONFIG_LINUX_USER': 'y' }
   elif target.endswith('bsd-user')
-    if targetos not in bsd_oses
+    if host_os not in bsd_oses
       if default_targets
         continue
       endif
@@ -3132,7 +3132,7 @@ endif
 config_host_data.set('CONFIG_FDT', fdt.found())
 
 vhost_user = not_found
-if targetos == 'linux' and have_vhost_user
+if host_os == 'linux' and have_vhost_user
   libvhost_user = subproject('libvhost-user')
   vhost_user = libvhost_user.get_variable('vhost_user_dep')
 endif
@@ -3456,7 +3456,7 @@ if have_block
 
   # os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
   # os-win32.c does not
-  if targetos == 'windows'
+  if host_os == 'windows'
     system_ss.add(files('os-win32.c'))
   else
     blockdev_ss.add(files('os-posix.c'))
@@ -3744,7 +3744,7 @@ common_all = static_library('common',
 
 feature_to_c = find_program('scripts/feature_to_c.py')
 
-if targetos == 'darwin'
+if host_os == 'darwin'
   entitlement = find_program('scripts/entitlement.sh')
 endif
 
@@ -3761,7 +3761,7 @@ foreach target : target_dirs
   link_args = emulator_link_args
 
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
-  if targetos == 'linux'
+  if host_os == 'linux'
     target_inc += include_directories('linux-headers', is_system: true)
   endif
   if target.endswith('-softmmu')
@@ -3791,7 +3791,7 @@ foreach target : target_dirs
     endif
     if 'CONFIG_BSD_USER' in config_target
       base_dir = 'bsd-user'
-      target_inc += include_directories('bsd-user/' / targetos)
+      target_inc += include_directories('bsd-user/' / host_os)
       target_inc += include_directories('bsd-user/host/' / host_arch)
       dir = base_dir / abi
       arch_srcs += files(dir / 'signal.c', dir / 'target_arch_cpu.c')
@@ -3848,7 +3848,7 @@ foreach target : target_dirs
       'sources': files('system/main.c'),
       'dependencies': []
     }]
-    if targetos == 'windows' and (sdl.found() or gtk.found())
+    if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
@@ -3875,7 +3875,7 @@ foreach target : target_dirs
   endif
   foreach exe: execs
     exe_name = exe['name']
-    if targetos == 'darwin'
+    if host_os == 'darwin'
       exe_name += '-unsigned'
     endif
 
@@ -3888,7 +3888,7 @@ foreach target : target_dirs
                link_args: link_args,
                win_subsystem: exe['win_subsystem'])
 
-    if targetos == 'darwin'
+    if host_os == 'darwin'
       icon = 'pc-bios/qemu.rsrc'
       build_input = [emulator, files(icon)]
       install_input = [
@@ -3944,7 +3944,7 @@ endforeach
 
 if get_option('plugins')
   install_headers('include/qemu/qemu-plugin.h')
-  if targetos == 'windows'
+  if host_os == 'windows'
     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
     # so that plugin authors can compile against it.
     install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
@@ -3985,7 +3985,7 @@ if have_tools
     subdir('contrib/vhost-user-scsi')
   endif
 
-  if targetos == 'linux'
+  if host_os == 'linux'
     executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),
                dependencies: [qemuutil, libcap_ng],
                install: true,
@@ -4052,7 +4052,7 @@ summary(summary_info, bool_yn: true, section: 'Build environment')
 # Directories
 summary_info += {'Install prefix':    get_option('prefix')}
 summary_info += {'BIOS directory':    qemu_datadir}
-pathsep = targetos == 'windows' ? ';' : ':'
+pathsep = host_os == 'windows' ? ';' : ':'
 summary_info += {'firmware path':     pathsep.join(get_option('qemu_firmwarepath'))}
 summary_info += {'binary directory':  get_option('prefix') / get_option('bindir')}
 summary_info += {'library directory': get_option('prefix') / get_option('libdir')}
@@ -4060,7 +4060,7 @@ summary_info += {'module directory':  qemu_moddir}
 summary_info += {'libexec directory': get_option('prefix') / get_option('libexecdir')}
 summary_info += {'include directory': get_option('prefix') / get_option('includedir')}
 summary_info += {'config directory':  get_option('prefix') / get_option('sysconfdir')}
-if targetos != 'windows'
+if host_os != 'windows'
   summary_info += {'local state directory': get_option('prefix') / get_option('localstatedir')}
   summary_info += {'Manual directory':      get_option('prefix') / get_option('mandir')}
 else
@@ -4083,7 +4083,7 @@ if config_host.has_key('GDB')
 endif
 summary_info += {'iasl':              iasl}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
-if targetos == 'windows' and have_ga
+if host_os == 'windows' and have_ga
   summary_info += {'wixl':            wixl}
 endif
 if slirp.found() and have_system
@@ -4181,7 +4181,7 @@ if get_option('cfi')
 endif
 summary_info += {'strip binaries':    get_option('strip')}
 summary_info += {'sparse':            sparse}
-summary_info += {'mingw32 support':   targetos == 'windows'}
+summary_info += {'mingw32 support':   host_os == 'windows'}
 summary(summary_info, bool_yn: true, section: 'Compilation')
 
 # snarf the cross-compilation information for tests
@@ -4280,7 +4280,7 @@ summary(summary_info, bool_yn: true, section: 'Crypto')
 
 # UI
 summary_info = {}
-if targetos == 'darwin'
+if host_os == 'darwin'
   summary_info += {'Cocoa support':           cocoa}
 endif
 summary_info += {'SDL support':       sdl}
@@ -4304,15 +4304,15 @@ summary(summary_info, bool_yn: true, section: 'User interface')
 
 # Audio backends
 summary_info = {}
-if targetos not in ['darwin', 'haiku', 'windows']
+if host_os not in ['darwin', 'haiku', 'windows']
   summary_info += {'OSS support':     oss}
   summary_info += {'sndio support':   sndio}
-elif targetos == 'darwin'
+elif host_os == 'darwin'
   summary_info += {'CoreAudio support': coreaudio}
-elif targetos == 'windows'
+elif host_os == 'windows'
   summary_info += {'DirectSound support': dsound}
 endif
-if targetos == 'linux'
+if host_os == 'linux'
   summary_info += {'ALSA support':    alsa}
   summary_info += {'PulseAudio support': pulse}
 endif
@@ -4322,7 +4322,7 @@ summary(summary_info, bool_yn: true, section: 'Audio backends')
 
 # Network backends
 summary_info = {}
-if targetos == 'darwin'
+if host_os == 'darwin'
   summary_info += {'vmnet.framework support': vmnet}
 endif
 summary_info += {'AF_XDP support':    libxdp}
@@ -4359,7 +4359,7 @@ summary_info += {'OpenGL support (epoxy)': opengl}
 summary_info += {'GBM':               gbm}
 summary_info += {'libiscsi support':  libiscsi}
 summary_info += {'libnfs support':    libnfs}
-if targetos == 'windows'
+if host_os == 'windows'
   if have_ga
     summary_info += {'QGA VSS support':   have_qga_vss}
   endif
@@ -4401,20 +4401,20 @@ if host_arch == 'unknown'
   endif
 endif
 
-if not supported_oses.contains(targetos)
+if not supported_oses.contains(host_os)
   message()
   warning('UNSUPPORTED HOST OS')
   message()
-  message('Support for host OS ' + targetos + 'is not currently maintained.')
+  message('Support for host OS ' + host_os + 'is not currently maintained.')
   message('configure has succeeded and you can continue to build, but')
   message('the QEMU project does not guarantee that QEMU will compile or')
   message('work on this operating system. You can help by volunteering')
   message('to maintain it and providing a build host for our continuous')
   message('integration setup. This will ensure that future versions of QEMU')
-  message('will keep working on ' + targetos + '.')
+  message('will keep working on ' + host_os + '.')
 endif
 
-if host_arch == 'unknown' or not supported_oses.contains(targetos)
+if host_arch == 'unknown' or not supported_oses.contains(host_os)
   message()
   message('If you want to help supporting QEMU on this platform, please')
   message('contact the developers at qemu-devel@nongnu.org.')
@@ -4428,8 +4428,8 @@ if get_option('relocatable') and \
   warning('bindir not included within prefix, the installation will not be relocatable.')
   actually_reloc = false
 endif
-if not actually_reloc and (targetos == 'windows' or get_option('relocatable'))
-  if targetos == 'windows'
+if not actually_reloc and (host_os == 'windows' or get_option('relocatable'))
+  if host_os == 'windows'
     message()
     warning('Windows installs should usually be relocatable.')
   endif
diff --git a/net/can/meson.build b/net/can/meson.build
index bdf6f8eee16..af3b27921cd 100644
--- a/net/can/meson.build
+++ b/net/can/meson.build
@@ -1,6 +1,6 @@
 can_ss = ss.source_set()
 can_ss.add(files('can_core.c', 'can_host.c'))
-if targetos == 'linux'
+if host_os == 'linux'
   can_ss.add(files('can_socketcan.c'))
 endif
 
diff --git a/net/meson.build b/net/meson.build
index a53f18ad7b4..9432a588e4e 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -43,13 +43,13 @@ if have_vhost_net_user
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
 endif
 
-if targetos == 'windows'
+if host_os == 'windows'
   system_ss.add(files('tap-win32.c'))
-elif targetos == 'linux'
+elif host_os == 'linux'
   system_ss.add(files('tap.c', 'tap-linux.c'))
-elif targetos in bsd_oses
+elif host_os in bsd_oses
   system_ss.add(files('tap.c', 'tap-bsd.c'))
-elif targetos == 'sunos'
+elif host_os == 'sunos'
   system_ss.add(files('tap.c', 'tap-solaris.c'))
 else
   system_ss.add(files('tap.c', 'tap-stub.c'))
diff --git a/plugins/meson.build b/plugins/meson.build
index 6b2d7a92926..51b4350c2a0 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -1,7 +1,7 @@
 plugin_ldflags = []
 # Modules need more symbols than just those in plugins/qemu-plugins.symbols
 if not enable_modules
-  if targetos == 'darwin'
+  if host_os == 'darwin'
     configure_file(
       input: files('qemu-plugins.symbols'),
       output: 'qemu-plugins-ld64.symbols',
@@ -14,7 +14,7 @@ if not enable_modules
 endif
 
 if get_option('plugins')
-  if targetos == 'windows'
+  if host_os == 'windows'
     dlltool = find_program('dlltool', required: true)
 
     # Generate a .lib file for plugins to link against.
diff --git a/qga/meson.build b/qga/meson.build
index 66c0f1e56f8..1c3d2a3d1b7 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -7,7 +7,7 @@ if not have_ga
 endif
 
 have_qga_vss = get_option('qga_vss') \
-  .require(targetos == 'windows',
+  .require(host_os == 'windows',
            error_message: 'VSS support requires Windows') \
   .require('cpp' in all_languages,
            error_message: 'VSS support requires a C++ compiler') \
@@ -67,7 +67,7 @@ qga_ss.add(files(
   'main.c',
   'cutils.c',
 ))
-if targetos == 'windows'
+if host_os == 'windows'
   qga_ss.add(files(
     'channel-win32.c',
     'commands-win32.c',
@@ -80,9 +80,9 @@ else
     'commands-posix.c',
     'commands-posix-ssh.c',
   ))
-  if targetos == 'linux'
+  if host_os == 'linux'
     qga_ss.add(files('commands-linux.c'))
-  elif targetos in bsd_oses
+  elif host_os in bsd_oses
     qga_ss.add(files('commands-bsd.c'))
   endif
 endif
@@ -91,7 +91,7 @@ qga_ss = qga_ss.apply({})
 
 gen_tlb = []
 qga_libs = []
-if targetos == 'windows'
+if host_os == 'windows'
   qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
                '-lsetupapi', '-lcfgmgr32']
   if have_qga_vss
@@ -101,7 +101,7 @@ if targetos == 'windows'
 endif
 
 qga_objs = []
-if targetos == 'windows'
+if host_os == 'windows'
   windmc = find_program('windmc', required: true)
   windres = find_program('windres', required: true)
 
@@ -123,7 +123,7 @@ qga = executable('qemu-ga', qga_ss.sources() + qga_objs,
                  install: true)
 all_qga += qga
 
-if targetos == 'windows'
+if host_os == 'windows'
   qemu_ga_msi_arch = {
     'x86': ['-D', 'Arch=32'],
     'x86_64': ['-a', 'x64', '-D', 'Arch=64']
@@ -185,7 +185,7 @@ test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 # the leak detector in build-oss-fuzz Gitlab CI test. we should re-enable
 # this when an alternative is implemented or when the underlying glib
 # issue is identified/fix
-#if targetos != 'windows'
+#if host_os != 'windows'
 if false
   srcs = [files('commands-posix-ssh.c')]
   i = 0
diff --git a/scsi/meson.build b/scsi/meson.build
index 0ff2b3affe0..cdb91e11b0e 100644
--- a/scsi/meson.build
+++ b/scsi/meson.build
@@ -1,5 +1,5 @@
 block_ss.add(files('utils.c'))
-if targetos == 'linux'
+if host_os == 'linux'
   block_ss.add(files('pr-manager.c', 'pr-manager-helper.c'))
 else
   block_ss.add(files('pr-manager-stub.c'))
diff --git a/system/meson.build b/system/meson.build
index 0632a3daa8a..25e21172505 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -33,6 +33,6 @@ endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
 system_ss.add(when: fdt, if_true: files('device_tree.c'))
-if targetos == 'linux'
-  system_ss.add('async-teardown.c')
+if host_os == 'linux'
+  system_ss.add(files('async-teardown.c'))
 endif
diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 9ef322afc42..4ab89aaa960 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -3,7 +3,7 @@ if 'CONFIG_TCG' not in config_all_accel
 endif
 # There are namespace pollution issues on Windows, due to osdep.h
 # bringing in Windows headers that define a FLOAT128 type.
-if targetos == 'windows'
+if host_os == 'windows'
   subdir_done()
 endif
 
diff --git a/tests/meson.build b/tests/meson.build
index 32cc15a3ef7..0a6f96f8f84 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -68,7 +68,7 @@ test_deps = {
   'test-qht-par': qht_bench,
 }
 
-if have_tools and have_vhost_user and targetos == 'linux'
+if have_tools and have_vhost_user and host_os == 'linux'
   executable('vhost-user-bridge',
              sources: files('vhost-user-bridge.c'),
              dependencies: [qemuutil, vhost_user])
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index 28a929dbcc0..e18183aaeda 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -1,7 +1,7 @@
 t = []
 if get_option('plugins')
   foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
-    if targetos == 'windows'
+    if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 53847cb98fc..fad340ad595 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -1,4 +1,4 @@
-if not have_tools or targetos == 'windows'
+if not have_tools or host_os == 'windows'
   subdir_done()
 endif
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 565eff4c0a2..f25bffcc20a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -38,8 +38,8 @@ qtests_cxl = \
 #        for the availability of the default NICs in the tests
 qtests_filter = \
   (get_option('default_devices') and slirp.found() ? ['test-netfilter'] : []) + \
-  (get_option('default_devices') and targetos != 'windows' ? ['test-filter-mirror'] : []) + \
-  (get_option('default_devices') and targetos != 'windows' ? ['test-filter-redirector'] : [])
+  (get_option('default_devices') and host_os != 'windows' ? ['test-filter-mirror'] : []) + \
+  (get_option('default_devices') and host_os != 'windows' ? ['test-filter-redirector'] : [])
 
 qtests_i386 = \
   (slirp.found() ? ['pxe-test'] : []) + \
@@ -48,7 +48,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_SGA') ? ['boot-serial-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_ISA_IPMI_KCS') ? ['ipmi-kcs-test'] : []) +            \
-  (targetos == 'linux' and                                                                  \
+  (host_os == 'linux' and                                                                  \
    config_all_devices.has_key('CONFIG_ISA_IPMI_BT') and
    config_all_devices.has_key('CONFIG_IPMI_EXTERN') ? ['ipmi-bt-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_WDT_IB700') ? ['wdt_ib700-test'] : []) +              \
@@ -74,7 +74,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
-  (targetos != 'windows' and                                                                \
+  (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
    config_all_devices.has_key('CONFIG_VIRTIO_NET') and                                      \
@@ -277,7 +277,7 @@ if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
   qos_test_ss.add(files('virtio-serial-test.c'))
 endif
 
-if targetos != 'windows'
+if host_os != 'windows'
   qos_test_ss.add(files('e1000e-test.c'))
 endif
 if have_virtfs
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index a05d4710904..69f9c050504 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -100,7 +100,7 @@ if have_block
   }
   if gnutls.found() and \
      tasn1.found() and \
-     targetos != 'windows'
+     host_os != 'windows'
     tests += {
       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
                                    tasn1, crypto, gnutls],
@@ -115,7 +115,7 @@ if have_block
   if xts == 'private'
     tests += {'test-crypto-xts': [crypto, io]}
   endif
-  if targetos != 'windows'
+  if host_os != 'windows'
     tests += {
       'test-image-locking': [testblock],
       'test-nested-aio-poll': [testblock],
@@ -150,7 +150,7 @@ if have_system
   # are not runnable under TSan due to a known issue.
   # https://github.com/google/sanitizers/issues/1116
   if not get_option('tsan')
-    if targetos != 'windows'
+    if host_os != 'windows'
         tests += {
           'test-char': ['socket-helpers.c', qom, io, chardev]
         }
@@ -162,7 +162,7 @@ if have_system
   endif
 endif
 
-if have_ga and targetos == 'linux'
+if have_ga and host_os == 'linux'
   tests += {'test-qga': ['../qtest/libqmp.c']}
   test_deps += {'test-qga': qga}
 endif
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index f0e2fac2127..ce35d64eea1 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -71,7 +71,7 @@
         :dbus:iface:`org.qemu.Display1.Listener` interface.
     -->
     <method name="RegisterListener">
-      <?if $(env.TARGETOS) == windows?>
+      <?if $(env.HOST_OS) == windows?>
       <arg type="ay" name="listener" direction="in">
         <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
       </arg>
@@ -370,7 +370,7 @@
       </arg>
     </method>
 
-    <?if $(env.TARGETOS) != windows?>
+    <?if $(env.HOST_OS) != windows?>
     <!--
         ScanoutDMABUF:
         @dmabuf: the DMABUF file descriptor.
@@ -694,7 +694,7 @@
         :dbus:iface:`org.qemu.Display1.AudioOutListener` interface.
     -->
     <method name="RegisterOutListener">
-      <?if $(env.TARGETOS) == windows?>
+      <?if $(env.HOST_OS) == windows?>
       <arg type="ay" name="listener" direction="in">
         <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
       </arg>
@@ -715,7 +715,7 @@
         :dbus:iface:`org.qemu.Display1.AudioInListener` interface.
     -->
     <method name="RegisterInListener">
-      <?if $(env.TARGETOS) == windows?>
+      <?if $(env.HOST_OS) == windows?>
       <arg type="ay" name="listener" direction="in">
         <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
       </arg>
@@ -976,7 +976,7 @@
         The current handler, if any, will be replaced.
     -->
     <method name="Register">
-      <?if $(env.TARGETOS) == windows?>
+      <?if $(env.HOST_OS) == windows?>
       <arg type="ay" name="listener" direction="in">
         <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
       </arg>
diff --git a/ui/meson.build b/ui/meson.build
index a370494c4ab..376e0d771ba 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -25,7 +25,7 @@ endif
 system_ss.add([spice_headers, files('spice-module.c')])
 system_ss.add(when: spice_protocol, if_true: files('vdagent.c'))
 
-if targetos == 'linux'
+if host_os == 'linux'
   system_ss.add(files('input-linux.c', 'udmabuf.c'))
 endif
 system_ss.add(when: cocoa, if_true: files('cocoa.m'))
@@ -75,7 +75,7 @@ endif
 if dbus_display
   dbus_ss = ss.source_set()
   env = environment()
-  env.set('TARGETOS', targetos)
+  env.set('HOST_OS', host_os)
   xml = custom_target('dbus-display preprocess',
                       input: 'dbus-display1.xml',
                       output: 'dbus-display1.xml',
@@ -105,7 +105,7 @@ if dbus_display
 endif
 
 if gtk.found()
-  if targetos == 'windows'
+  if host_os == 'windows'
     system_ss.add(files('win32-kbd-hook.c'))
   endif
 
@@ -121,7 +121,7 @@ if gtk.found()
 endif
 
 if sdl.found()
-  if targetos == 'windows'
+  if host_os == 'windows'
     system_ss.add(files('win32-kbd-hook.c'))
   endif
 
diff --git a/util/meson.build b/util/meson.build
index 4e970d2b488..af3bf5692d8 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -3,7 +3,7 @@ util_ss.add(files('thread-context.c'), numa)
 if not config_host_data.get('CONFIG_ATOMIC64')
   util_ss.add(files('atomic64.c'))
 endif
-if targetos != 'windows'
+if host_os != 'windows'
   util_ss.add(files('aio-posix.c'))
   util_ss.add(files('fdmon-poll.c'))
   if config_host_data.get('CONFIG_EPOLL_CREATE1')
@@ -13,7 +13,7 @@ if targetos != 'windows'
   util_ss.add(files('event_notifier-posix.c'))
   util_ss.add(files('mmap-alloc.c'))
   freebsd_dep = []
-  if targetos == 'freebsd'
+  if host_os == 'freebsd'
     freebsd_dep = util
   endif
   util_ss.add(files('oslib-posix.c'), freebsd_dep)
@@ -73,7 +73,7 @@ endif
 if have_system
   util_ss.add(files('crc-ccitt.c'))
   util_ss.add(when: gio, if_true: files('dbus.c'))
-  if targetos == 'linux'
+  if host_os == 'linux'
     util_ss.add(files('userfaultfd.c'))
   endif
 endif
@@ -108,7 +108,7 @@ if have_block
   else
     util_ss.add(files('filemonitor-stub.c'))
   endif
-  if targetos == 'linux'
+  if host_os == 'linux'
     util_ss.add(files('vhost-user-server.c'), vhost_user)
     util_ss.add(files('vfio-helpers.c'))
     util_ss.add(files('chardev_open.c'))
-- 
2.43.0


