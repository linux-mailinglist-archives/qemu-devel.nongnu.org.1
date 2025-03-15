Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA6A6275B
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Mar 2025 07:28:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKzk-0003wF-PK; Sat, 15 Mar 2025 02:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKvY-0004ZH-UZ; Sat, 15 Mar 2025 02:23:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKvV-0003uS-MK; Sat, 15 Mar 2025 02:23:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3E1F8FF9FF;
 Sat, 15 Mar 2025 09:17:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 13F901CAC68;
 Sat, 15 Mar 2025 09:18:02 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A5BD055915; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 51/51] docs: Rename default-configs to configs
Date: Sat, 15 Mar 2025 09:17:57 +0300
Message-Id: <20250315061801.622606-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Greg Kurz <groug@kaod.org>

This was missed at the time.

Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorganise")
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250306174113.427116-1-groug@kaod.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 48170c2d865a5937092b1384421b01cd38113042)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index d42045a232..a759982f45 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -260,7 +260,7 @@ Target-dependent emulator sourcesets:
   Each emulator also includes sources for files in the ``hw/`` and ``target/``
   subdirectories.  The subdirectory used for each emulator comes
   from the target's definition of ``TARGET_BASE_ARCH`` or (if missing)
-  ``TARGET_ARCH``, as found in ``default-configs/targets/*.mak``.
+  ``TARGET_ARCH``, as found in ``configs/targets/*.mak``.
 
   Each subdirectory in ``hw/`` adds one sourceset to the ``hw_arch`` dictionary,
   for example::
@@ -317,8 +317,8 @@ Utility sourcesets:
 The following files concur in the definition of which files are linked
 into each emulator:
 
-``default-configs/devices/*.mak``
-  The files under ``default-configs/devices/`` control the boards and devices
+``configs/devices/*.mak``
+  The files under ``configs/devices/`` control the boards and devices
   that are built into each QEMU system emulation targets. They merely contain
   a list of config variable definitions such as::
 
@@ -327,11 +327,11 @@ into each emulator:
     CONFIG_XLNX_VERSAL=y
 
 ``*/Kconfig``
-  These files are processed together with ``default-configs/devices/*.mak`` and
+  These files are processed together with ``configs/devices/*.mak`` and
   describe the dependencies between various features, subsystems and
   device models.  They are described in :ref:`kconfig`
 
-``default-configs/targets/*.mak``
+``configs/targets/*.mak``
   These files mostly define symbols that appear in the ``*-config-target.h``
   file for each emulator\ [#cfgtarget]_.  However, the ``TARGET_ARCH``
   and ``TARGET_BASE_ARCH`` will also be used to select the ``hw/`` and
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index 52d4b905f6..493b76c4fb 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -38,7 +38,7 @@ originated in the Linux kernel, though it was heavily simplified and
 the handling of dependencies is stricter in QEMU.
 
 Unlike Linux, there is no user interface to edit the configuration, which
-is instead specified in per-target files under the ``default-configs/``
+is instead specified in per-target files under the ``configs/``
 directory of the QEMU source tree.  This is because, unlike Linux,
 configuration and dependencies can be treated as a black box when building
 QEMU; the default configuration that QEMU ships with should be okay in
@@ -103,7 +103,7 @@ directives can be included:
 **default value**: ``default <value> [if <expr>]``
 
   Default values are assigned to the config symbol if no other value was
-  set by the user via ``default-configs/*.mak`` files, and only if
+  set by the user via ``configs/*.mak`` files, and only if
   ``select`` or ``depends on`` directives do not force the value to true
   or false respectively.  ``<value>`` can be ``y`` or ``n``; it cannot
   be an arbitrary Boolean expression.  However, a condition for applying
@@ -119,7 +119,7 @@ directives can be included:
   This is similar to ``select`` as it applies a lower limit of ``y``
   to another symbol.  However, the lower limit is only a default
   and the "implied" symbol's value may still be set to ``n`` from a
-  ``default-configs/*.mak`` files.  The following two examples are
+  ``configs/*.mak`` files.  The following two examples are
   equivalent::
 
     config FOO
@@ -146,7 +146,7 @@ declares its dependencies in different ways:
       bool
 
   Subsystems always default to false (they have no ``default`` directive)
-  and are never visible in ``default-configs/*.mak`` files.  It's
+  and are never visible in ``configs/*.mak`` files.  It's
   up to other symbols to ``select`` whatever subsystems they require.
 
   They sometimes have ``select`` directives to bring in other required
@@ -238,7 +238,7 @@ declares its dependencies in different ways:
   include libraries (such as ``FDT``) or ``TARGET_BIG_ENDIAN``
   (possibly negated).
 
-  Boards are listed for convenience in the ``default-configs/*.mak``
+  Boards are listed for convenience in the ``configs/*.mak``
   for the target they apply to.
 
 **internal elements**
@@ -251,18 +251,18 @@ declares its dependencies in different ways:
 
   Internal elements group code that is useful in several boards or
   devices.  They are usually enabled with ``select`` and in turn select
-  other elements; they are never visible in ``default-configs/*.mak``
+  other elements; they are never visible in ``configs/*.mak``
   files, and often not even in the Makefile.
 
 Writing and modifying default configurations
 --------------------------------------------
 
 In addition to the Kconfig files under hw/, each target also includes
-a file called ``default-configs/TARGETNAME-softmmu.mak``.  These files
+a file called ``configs/TARGETNAME-softmmu.mak``.  These files
 initialize some Kconfig variables to non-default values and provide the
 starting point to turn on devices and subsystems.
 
-A file in ``default-configs/`` looks like the following example::
+A file in ``configs/`` looks like the following example::
 
     # Default configuration for alpha-softmmu
 
-- 
2.39.5


