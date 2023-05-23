Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC4D70DD7A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:31:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1S6v-0004fW-PD; Tue, 23 May 2023 09:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1q1S6s-0004XB-E2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1q1S6q-00061H-5i
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684848684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ALH8ygfQExhI64PQIFKaxa6QiTxPIbjn4rjrnsnGxtE=;
 b=S4HucrZwBo65PyGaI46I6kG6pkVPCY78tR74DToCkaCeJ3vVi9WqfuRigRZi1i+gRDwomy
 Mo7RuVEcvr3iHldoVUfLG2FAEtMdRJipoiLmMJiv7B8tBxfhh9Qm/QQIbLGfqXIpB+wJc2
 KDC7ogOAsszSZPGMhO1Jw1RO9vWxG6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620--s9d3AC7OxuqYhjmSswZfw-1; Tue, 23 May 2023 09:31:21 -0400
X-MC-Unique: -s9d3AC7OxuqYhjmSswZfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B0CF101B047;
 Tue, 23 May 2023 13:31:21 +0000 (UTC)
Received: from pinwheel.wattfactory.local (unknown [10.39.194.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECB2740D1B60;
 Tue, 23 May 2023 13:31:18 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH v2] docs: build-system: rename "default-configs" to "configs"
Date: Tue, 23 May 2023 15:31:17 +0200
Message-Id: <20230523133117.2278587-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 812b31d3f9 (configs: rename default-configs to configs and
reorganise, 2021-07-07) did the rename.

Reflect that update also in the documentation.

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 docs/devel/build-system.rst | 12 +++++------
 docs/devel/kconfig.rst      | 40 ++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 1894721743..20ebcc9ac6 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -193,7 +193,7 @@ Target-dependent emulator sourcesets:
   Each emulator also includes sources for files in the ``hw/`` and ``target/``
   subdirectories.  The subdirectory used for each emulator comes
   from the target's definition of ``TARGET_BASE_ARCH`` or (if missing)
-  ``TARGET_ARCH``, as found in ``default-configs/targets/*.mak``.
+  ``TARGET_ARCH``, as found in ``configs/targets/*.mak``.
 
   Each subdirectory in ``hw/`` adds one sourceset to the ``hw_arch`` dictionary,
   for example::
@@ -250,8 +250,8 @@ Utility sourcesets:
 The following files concur in the definition of which files are linked
 into each emulator:
 
-``default-configs/devices/*.mak``
-  The files under ``default-configs/devices/`` control the boards and devices
+``configs/devices/*.mak``
+  The files under ``configs/devices/`` control the boards and devices
   that are built into each QEMU system emulation targets. They merely contain
   a list of config variable definitions such as::
 
@@ -260,11 +260,11 @@ into each emulator:
     CONFIG_XLNX_VERSAL=y
 
 ``*/Kconfig``
-  These files are processed together with ``default-configs/devices/*.mak`` and
+  These files are processed together with ``configs/devices/*.mak`` and
   describe the dependencies between various features, subsystems and
   device models.  They are described in :ref:`kconfig`
 
-``default-configs/targets/*.mak``
+``configs/targets/*.mak``
   These files mostly define symbols that appear in the ``*-config-target.h``
   file for each emulator [#cfgtarget]_.  However, the ``TARGET_ARCH``
   and ``TARGET_BASE_ARCH`` will also be used to select the ``hw/`` and
@@ -457,7 +457,7 @@ Built by Meson:
   TARGET-NAME is again the name of a system or userspace emulator. The
   config-devices.mak file is automatically generated by make using the
   scripts/make_device_config.sh program, feeding it the
-  default-configs/$TARGET-NAME file as input.
+  configs/$TARGET-NAME file as input.
 
 ``config-host.h``, ``$TARGET_NAME-config-target.h``, ``$TARGET_NAME-config-devices.h``
   These files are used by source code to determine what features are
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index e3a544e463..73118e5106 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -38,11 +38,11 @@ originated in the Linux kernel, though it was heavily simplified and
 the handling of dependencies is stricter in QEMU.
 
 Unlike Linux, there is no user interface to edit the configuration, which
-is instead specified in per-target files under the ``default-configs/``
+is instead specified in per-target files under the ``configs/target/``
 directory of the QEMU source tree.  This is because, unlike Linux,
-configuration and dependencies can be treated as a black box when building
-QEMU; the default configuration that QEMU ships with should be okay in
-almost all cases.
+configuration and dependencies can be treated as a black box when
+building QEMU; the default configuration that QEMU ships with should be
+okay in almost all cases.
 
 The Kconfig language
 --------------------
@@ -103,11 +103,12 @@ directives can be included:
 **default value**: ``default <value> [if <expr>]``
 
   Default values are assigned to the config symbol if no other value was
-  set by the user via ``default-configs/*.mak`` files, and only if
-  ``select`` or ``depends on`` directives do not force the value to true
-  or false respectively.  ``<value>`` can be ``y`` or ``n``; it cannot
-  be an arbitrary Boolean expression.  However, a condition for applying
-  the default value can be added with ``if``.
+  set by the user via
+  ``configs/devices/TARGETNAME-softmmu/*.mak`` files, and only
+  if ``select`` or ``depends on`` directives do not force the value to
+  true or false respectively.  ``<value>`` can be ``y`` or ``n``; it
+  cannot be an arbitrary Boolean expression.  However, a condition for
+  applying the default value can be added with ``if``.
 
   A configuration element can have any number of default values (usually,
   if more than one default is present, they will have different
@@ -119,8 +120,8 @@ directives can be included:
   This is similar to ``select`` as it applies a lower limit of ``y``
   to another symbol.  However, the lower limit is only a default
   and the "implied" symbol's value may still be set to ``n`` from a
-  ``default-configs/*.mak`` files.  The following two examples are
-  equivalent::
+  ``configs/devices/TARGETNAME-softmmu/*.mak`` files.  The following
+  two examples are equivalent::
 
     config FOO
       bool
@@ -146,8 +147,9 @@ declares its dependencies in different ways:
       bool
 
   Subsystems always default to false (they have no ``default`` directive)
-  and are never visible in ``default-configs/*.mak`` files.  It's
-  up to other symbols to ``select`` whatever subsystems they require.
+  and are never visible in ``configs/devices/TARGETNAME-softmmu/*.mak``
+  files.  It's up to other symbols to ``select`` whatever subsystems
+  they require.
 
   They sometimes have ``select`` directives to bring in other required
   subsystems or buses.  For example, ``AUX`` (the DisplayPort auxiliary
@@ -229,7 +231,8 @@ declares its dependencies in different ways:
   cannot be started at all without it.  It should be listed under
   ``imply`` if (depending on the QEMU command line) the board may or
   may not be started without it.  Boards also default to false; they are
-  enabled by the ``default-configs/*.mak`` for the target they apply to.
+  enabled by the ``configs/targets/TARGETNAME-softmmu/*.mak`` for the
+  target they apply to.
 
 **internal elements**
 
@@ -241,18 +244,19 @@ declares its dependencies in different ways:
 
   Internal elements group code that is useful in several boards or
   devices.  They are usually enabled with ``select`` and in turn select
-  other elements; they are never visible in ``default-configs/*.mak``
-  files, and often not even in the Makefile.
+  other elements; they are never visible in
+  ``configs/devices/TARGETNAME-softmmu/*.mak`` files, and often not even
+  in the Makefile.
 
 Writing and modifying default configurations
 --------------------------------------------
 
 In addition to the Kconfig files under hw/, each target also includes
-a file called ``default-configs/TARGETNAME-softmmu.mak``.  These files
+a file called ``configs/devices/TARGETNAME-softmmu.mak``.  These files
 initialize some Kconfig variables to non-default values and provide the
 starting point to turn on devices and subsystems.
 
-A file in ``default-configs/`` looks like the following example::
+A file in ``configs/devices/`` looks like the following example::
 
     # Default configuration for alpha-softmmu
 
-- 
2.40.1


