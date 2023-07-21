Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 509DC75C613
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 13:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMoey-0002Kd-Uc; Fri, 21 Jul 2023 07:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qMoeq-0002IH-Fu
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:50:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qMoem-0001LK-Ez
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:50:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3812B15742;
 Fri, 21 Jul 2023 14:50:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 56E6418861;
 Fri, 21 Jul 2023 14:50:32 +0300 (MSK)
Received: (nullmailer pid 3224662 invoked by uid 1000);
 Fri, 21 Jul 2023 11:50:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] scripts/qemu-binfmt-conf.sh: refresh
Date: Fri, 21 Jul 2023 14:50:31 +0300
Message-Id: <20230721115031.3224648-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Currently qemu-binfmt-conf.sh does a number of strange things.

1. --systemd requires an argument - the CPU type to register,
   while --debian (which is actually --binfmt-support) does not
   accept such an argument, so it is not possible to specify which
   CPU(s) to register for debian.

2. Why this "ALL" at all?

3. it just ignores extra command-line arguments.  It would be
   logical to specify which CPUs to register (multiple!) as the
   additional arguments.

4. Even if a CPU is explicitly requested, it does not register
   anything if this CPU is of the same family as host one. But
   this is wrong, since quite often it *is* desirable to do this
   registration, - like, when running in i386 when the system is
   not capable of running x86-64 binaries, and countless other
   examples

5. It ignores errors

6. It ignores wrong command line arguments

Fix this, and simplify things a bit.

1. Stop accepting an argument for --systemd.  With getopt_long,
   this argument, if given, will be returned as a non-optional
   parameter so compatibility with current version is preserved.

2. Accept optional arguments and generate registration for the
   given CPUs only.  In case no extra arguments are given, register
   for all supportd CPUs except of the same family as host.

3. Recognze "ALL" "CPU" to keep compatibility with current version
   (but do not document it).

4. Warn but perform registration anyway if a cpu of the same family
   has been requested.

5. In help text, use --debian and --systemd as alternatives to each
   other, to make it clear the two can not be used at the same time.

6. Tiny optimization of eval expression.

7. Fold the list of supported CPUs to fit in 80 columns.

8. Exit with non-zero code in case registration fails or the command
   line is wrong.

9. Remove explicit checking for writability of various things.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/qemu-binfmt-conf.sh | 89 +++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 6ef9f118d9..27d506000d 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -182,10 +182,10 @@ qemu_get_family() {
 
 usage() {
     cat <<EOF
-Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
+Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian|--systemd]
                            [--help][--credential yes|no][--exportdir PATH]
                            [--persistent yes|no][--qemu-suffix SUFFIX]
-                           [--preserve-argv0 yes|no]
+                           [--preserve-argv0 yes|no] [CPU...]
 
        Configure binfmt_misc to use qemu interpreter
 
@@ -217,21 +217,17 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
 
     With systemd, binfmt files are loaded by systemd-binfmt.service
 
+    If CPU(s) are specified in the command line, configure binfmt_misc for
+    this set of CPUs only.  If no types are specified, make configuration
+    for all supported CPU types except the ones from the host CPU family.
+
     The environment variable HOST_ARCH allows to override 'uname' to generate
     configuration files for a different architecture than the current one.
 
-    where CPU is one of:
-
-        $qemu_target_list
+    Supported CPUs are:
 
 EOF
-}
-
-qemu_check_access() {
-    if [ ! -w "$1" ] ; then
-        echo "ERROR: cannot write to $1" 1>&2
-        exit 1
-    fi
+echo $qemu_target_list | fold -w68 -s | sed 's/^/        /'
 }
 
 qemu_check_bintfmt_misc() {
@@ -246,8 +242,6 @@ qemu_check_bintfmt_misc() {
           exit 1
       fi
     fi
-
-    qemu_check_access /proc/sys/fs/binfmt_misc/register
 }
 
 installed_dpkg() {
@@ -260,14 +254,12 @@ qemu_check_debian() {
     elif ! installed_dpkg binfmt-support ; then
         echo "WARNING: package binfmt-support is needed" 1>&2
     fi
-    qemu_check_access "$EXPORTDIR"
 }
 
 qemu_check_systemd() {
     if ! systemctl -q is-enabled systemd-binfmt.service ; then
         echo "WARNING: systemd-binfmt.service is missing or disabled" 1>&2
     fi
-    qemu_check_access "$EXPORTDIR"
 }
 
 qemu_generate_register() {
@@ -287,16 +279,16 @@ qemu_generate_register() {
 
 qemu_register_interpreter() {
     echo "Setting $qemu as binfmt interpreter for $cpu"
-    qemu_generate_register > /proc/sys/fs/binfmt_misc/register
+    qemu_generate_register > /proc/sys/fs/binfmt_misc/register || exit 1
 }
 
 qemu_generate_systemd() {
     echo "Setting $qemu as binfmt interpreter for $cpu for systemd-binfmt.service"
-    qemu_generate_register > "$EXPORTDIR/qemu-$cpu.conf"
+    qemu_generate_register > "$EXPORTDIR/qemu-$cpu.conf" || exit 1
 }
 
 qemu_generate_debian() {
-    cat > "$EXPORTDIR/qemu-$cpu" <<EOF
+    cat > "$EXPORTDIR/qemu-$cpu" <<EOF || exit 1
 package qemu-$cpu
 interpreter $qemu
 magic $magic
@@ -311,16 +303,22 @@ qemu_set_binfmts() {
     # probe cpu type
     host_family=$(qemu_get_family)
 
-    # register the interpreter for each cpu except for the native one
+    if [ $# -ne 0 ]; then # explicitly requested CPU
+        explicit=yes
+    else # all supported CPUs except of the same family as host CPU
+        explicit=
+        set -- $qemu_target_list
+    fi
 
-    for cpu in ${qemu_target_list} ; do
-        magic=$(eval echo \$${cpu}_magic)
-        mask=$(eval echo \$${cpu}_mask)
-        family=$(eval echo \$${cpu}_family)
+    for cpu in "$@" ; do
+        eval \
+            magic=\"\$${cpu}_magic\" \
+            mask=\"\$${cpu}_mask\" \
+            family=\"\$${cpu}_family\"
 
         if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ] ; then
-            echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
-            continue
+            echo "ERROR: unknown cpu $cpu" >&2
+            exit 1
         fi
 
         qemu="$QEMU_PATH/qemu-$cpu"
@@ -329,9 +327,12 @@ qemu_set_binfmts() {
         fi
 
         qemu="$qemu$QEMU_SUFFIX"
-        if [ "$host_family" != "$family" ] ; then
-            $BINFMT_SET
+        if [ "$host_family" = "$family" ] ; then
+            [ -n "$explicit" ] || continue
+            echo "WARNING: requested CPU $cpu is of the same family as host CPU" >&2
+            echo "WARNING: this might break the system" >&2
         fi
+        $BINFMT_SET
     done
 }
 
@@ -347,9 +348,9 @@ PERSISTENT=no
 PRESERVE_ARG0=no
 QEMU_SUFFIX=""
 
-_longopts="debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,\
+_longopts="debian,systemd,qemu-path:,qemu-suffix:,exportdir:,help,credential:,\
 persistent:,preserve-argv0:"
-options=$(getopt -o ds:Q:S:e:hc:p:g:F: -l ${_longopts} -- "$@")
+options=$(getopt -o dsQ:S:e:hc:p:g:F: -l ${_longopts} -- "$@") || exit 1
 eval set -- "$options"
 
 while true ; do
@@ -363,23 +364,6 @@ while true ; do
         CHECK=qemu_check_systemd
         BINFMT_SET=qemu_generate_systemd
         EXPORTDIR=${EXPORTDIR:-$SYSTEMDDIR}
-        shift
-        # check given cpu is in the supported CPU list
-        if [ "$1" != "ALL" ] ; then
-            for cpu in ${qemu_target_list} ; do
-                if [ "$cpu" = "$1" ] ; then
-                    break
-                fi
-            done
-
-            if [ "$cpu" = "$1" ] ; then
-                qemu_target_list="$1"
-            else
-                echo "ERROR: unknown CPU \"$1\"" 1>&2
-                usage
-                exit 1
-            fi
-        fi
         ;;
     -Q|--qemu-path)
         shift
@@ -409,12 +393,19 @@ while true ; do
         shift
         PRESERVE_ARG0="$1"
         ;;
-    *)
+    --)
+        shift
         break
         ;;
+    *)
+        exit 1
+        ;;
     esac
     shift
 done
 
 $CHECK
-qemu_set_binfmts
+if [ ALL = "$1" ]; then
+  set --
+fi
+qemu_set_binfmts "$@"
-- 
2.39.2


