Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92F707033
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGu-0004lH-T1; Wed, 17 May 2023 13:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLFA-0002mv-FF
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF7-0004dm-EN
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpHfQMAHim+xg75TnPiP56zC+UTGEuoT9DPQNdibHlI=;
 b=KzRRfYqjbEerpJHd9O/v8XRp+GmPNFcFl+GmUIQacqVpUcsbVgd4OZiVSy01AM3LG5HvMp
 2hdunkb4Z3tvueejuF5uXd/HFI59dy1eHPAvTrf/GJN2Dzm4VnGIsLBYsp8ogtj2cXcmCT
 jLcxdGedJA440janeScrI6oWVQXfqls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-0k-1oJAjNJ-1NngqY2LkPg-1; Wed, 17 May 2023 13:47:14 -0400
X-MC-Unique: 0k-1oJAjNJ-1NngqY2LkPg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so698571f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345632; x=1686937632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpHfQMAHim+xg75TnPiP56zC+UTGEuoT9DPQNdibHlI=;
 b=F4+mdF6MbD9jgncpm8PGszHt76Q9z1kF+Hnzel9VZM+j6vYSXlQ956KkRmi6QZCSgA
 TiEmmd+DVbwNJa/CwPNrmyt8fcwgtxk+5fkMtRDoqytp3fAQyjhqBxaIZN0lZPd0vSYz
 PdNDyEbD4cK5AhAVViqhIR3Nqn6Qp3WFmIyW1Ve64I9zWHgdOHXxKCWzAwxGswO3w/YK
 DZAIc6APCzWoAw4QQe/pR2SYOJJVtinMXNW96J4nbpjATPSCP66mFgN72NnjMWrzQvaW
 6ElVz7vN7t5ZYAvvmLlzF0UXyh0G6g20Sz4AHVthuJK3vIvUvvaCIHNEk2ESUP1Rw71b
 6miQ==
X-Gm-Message-State: AC+VfDwkKaikljVl2UaGphYJz2HpYdg1lQKFn7epyekMUU+uaP3ZNigL
 1qbO5e3atQfzwO+9MDuRJaN9C+6XUzdDLoaXcUisb2TpaaFLYO+KIJjhmdkgP1SoaQti3a5vYaG
 71aPQ3kXmm7YFXFuIZXAjLkQ9zS1UOzh8IpoFtlz1J7bGo29va6ECXrhQD2cHyq31QXtDZn57aB
 Q=
X-Received: by 2002:adf:ef08:0:b0:306:2e04:5925 with SMTP id
 e8-20020adfef08000000b003062e045925mr1364142wro.17.1684345632325; 
 Wed, 17 May 2023 10:47:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Xqh+5FHntHnrrcP0rby7kI/Q/NNp7uM3zSonloT2clrmLEyfbFe4uDcBmXJbfNzm05u6kbw==
X-Received: by 2002:adf:ef08:0:b0:306:2e04:5925 with SMTP id
 e8-20020adfef08000000b003062e045925mr1364114wro.17.1684345631534; 
 Wed, 17 May 2023 10:47:11 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 u14-20020adfdd4e000000b002f22c44e974sm3393883wrm.102.2023.05.17.10.47.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:47:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 68/68] docs/devel: update build system docs
Date: Wed, 17 May 2023 19:45:20 +0200
Message-Id: <20230517174520.887405-69-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

configure is only doing compiler and host setup now, so adjust the
relevant documentation.  It is also possible to build emulators with
ninja directly if one is so inclined, so mention that as well.

The Python virtual environment set up is a new major task of configure
as well.  Mention it in the list of produced files, while leaving it
for a future patch to document how it works and how ``mkvenv ensure``
is used.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 287 ++++++++++++++++++++++--------------
 1 file changed, 177 insertions(+), 110 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 4a733fc0a747..551c5a5ac0ae 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -4,30 +4,14 @@ The QEMU build system architecture
 
 This document aims to help developers understand the architecture of the
 QEMU build system. As with projects using GNU autotools, the QEMU build
-system has two stages, first the developer runs the "configure" script
+system has two stages; first the developer runs the "configure" script
 to determine the local build environment characteristics, then they run
-"make" to build the project. There is about where the similarities with
+"make" to build the project.  This is about where the similarities with
 GNU autotools end, so try to forget what you know about them.
 
+The two general ways to perform a build are as follows:
 
-Stage 1: configure
-==================
-
-The QEMU configure script is written directly in shell, and should be
-compatible with any POSIX shell, hence it uses #!/bin/sh. An important
-implication of this is that it is important to avoid using bash-isms on
-development platforms where bash is the primary host.
-
-In contrast to autoconf scripts, QEMU's configure is expected to be
-silent while it is checking for features. It will only display output
-when an error occurs, or to show the final feature enablement summary
-on completion.
-
-Because QEMU uses the Meson build system under the hood, only VPATH
-builds are supported.  There are two general ways to invoke configure &
-perform a build:
-
- - VPATH, build artifacts outside of QEMU source tree entirely::
+ - build artifacts outside of QEMU source tree entirely::
 
      cd ../
      mkdir build
@@ -35,80 +19,122 @@ perform a build:
      ../qemu/configure
      make
 
- - VPATH, build artifacts in a subdir of QEMU source tree::
+ - build artifacts in a subdir of QEMU source tree::
 
      mkdir build
      cd build
      ../configure
      make
 
-The configure script automatically recognizes
-command line options for which a same-named Meson option exists;
-dashes in the command line are replaced with underscores.
+Most of the actual build process uses Meson under the hood, therefore
+build artifacts cannot be placed in the source tree itself.
 
-Many checks on the compilation environment are still found in configure
-rather than ``meson.build``, but new checks should be added directly to
-``meson.build``.
 
-Patches are also welcome to move existing checks from the configure
-phase to ``meson.build``.  When doing so, ensure that ``meson.build`` does
-not use anymore the keys that you have removed from ``config-host.mak``.
-Typically these will be replaced in ``meson.build`` by boolean variables,
-``get_option('optname')`` invocations, or ``dep.found()`` expressions.
-In general, the remaining checks have little or no interdependencies,
-so they can be moved one by one.
+Stage 1: configure
+==================
 
-Helper functions
-----------------
+The configure script has five tasks:
 
-The configure script provides a variety of helper functions to assist
-developers in checking for system features:
+ - detect the host architecture
 
-``do_cc $ARGS...``
-   Attempt to run the system C compiler passing it $ARGS...
+ - list the targets for which to build emulators; the list of
+   targets also affects which firmware binaries and tests to build
 
-``do_cxx $ARGS...``
-   Attempt to run the system C++ compiler passing it $ARGS...
+ - find the compilers (native and cross) used to build executables,
+   firmware and tests.  The results are written as either Makefile
+   fragments (``config-host.mak``) or a Meson machine file
+   (``config-meson.cross``)
 
-``compile_object $CFLAGS``
-   Attempt to compile a test program with the system C compiler using
-   $CFLAGS. The test program must have been previously written to a file
-   called $TMPC.  The replacement in Meson is the compiler object ``cc``,
-   which has methods such as ``cc.compiles()``,
-   ``cc.check_header()``, ``cc.has_function()``.
+ - create a virtual environment in which all Python code runs during
+   the build, and possibly install packages into it from PyPI
 
-``compile_prog $CFLAGS $LDFLAGS``
-   Attempt to compile a test program with the system C compiler using
-   $CFLAGS and link it with the system linker using $LDFLAGS. The test
-   program must have been previously written to a file called $TMPC.
-   The replacement in Meson is ``cc.find_library()`` and ``cc.links()``.
+ - invoke Meson in the virtual environment, to perform the actual
+   configuration step for the emulator build
+
+The configure script automatically recognizes command line options for
+which a same-named Meson option exists; dashes in the command line are
+replaced with underscores.
+
+Almost all QEMU developers that need to modify the build system will
+only be concerned with Meson, and therefore can skip the rest of this
+section.
+
+
+Modifying ``configure``
+-----------------------
+
+``configure`` is a shell script; it uses ``#!/bin/sh`` and therefore
+should be compatible with any POSIX shell. It is important to avoid
+using bash-isms to avoid breaking development platforms where bash is
+the primary host.
+
+The configure script provides a variety of functions to help writing
+portable shell code and providing consistent behavior across architectures
+and operating systems:
+
+``error_exit $MESSAGE $MORE...``
+   Print $MESSAGE to stderr, followed by $MORE... and then exit from the
+   configure script with non-zero status.
 
 ``has $COMMAND``
    Determine if $COMMAND exists in the current environment, either as a
    shell builtin, or executable binary, returning 0 on success.  The
    replacement in Meson is ``find_program()``.
 
+``probe_target_compiler $TARGET``
+  Detect a cross compiler and cross tools for the QEMU target $TARGET (e.g.,
+  ``$CPU-softmmu``, ``$CPU-linux-user``, ``$CPU-bsd-user``).  If a working
+  compiler is present, return success and set variables ``$target_cc``,
+  ``$target_ar``, etc. to non-empty values.
+
+``write_target_makefile``
+  Write a Makefile fragment to stdout, exposing the result of the most
+  ``probe_target_compiler`` call as the usual Make variables (``CC``,
+  ``AR``, ``LD``, etc.).
+
+
+Configure does not generally perform tests for compiler options beyond
+basic checks to detect the host platform and ensure the compiler is
+functioning.  These are performed using a few more helper functions:
+
+``compile_object $CFLAGS``
+   Attempt to compile a test program with the system C compiler using
+   $CFLAGS. The test program must have been previously written to a file
+   called $TMPC.
+
+``compile_prog $CFLAGS $LDFLAGS``
+   Attempt to compile a test program with the system C compiler using
+   $CFLAGS and link it with the system linker using $LDFLAGS. The test
+   program must have been previously written to a file called $TMPC.
+
 ``check_define $NAME``
-   Determine if the macro $NAME is defined by the system C compiler
+   Determine if the macro $NAME is defined by the system C compiler.
+
+``do_compiler $CC $ARGS...``
+   Attempt to run the C compiler $CC, passing it $ARGS...  This function
+   does not use flags passed via options such as ``--extra-cflags``, and
+   therefore can be used to check for cross compilers.  However, most
+   such checks are done at ``make`` time instead (see for example the
+   ``cc-option`` macro in ``pc-bios/option-rom/Makefile``).
 
 ``write_c_skeleton``
    Write a minimal C program main() function to the temporary file
-   indicated by $TMPC
+   indicated by $TMPC.
 
-``error_exit $MESSAGE $MORE...``
-   Print $MESSAGE to stderr, followed by $MORE... and then exit from the
-   configure script with non-zero status
 
+Python virtual environments and the QEMU build system
+-----------------------------------------------------
+
+TBD
 
 Stage 2: Meson
 ==============
 
-The Meson build system is currently used to describe the build
-process for:
+The Meson build system describes the build and install process for:
 
 1) executables, which include:
 
-   - Tools - ``qemu-img``, ``qemu-nbd``, ``qga`` (guest agent), etc
+   - Tools - ``qemu-img``, ``qemu-nbd``, ``qemu-ga`` (guest agent), etc
 
    - System emulators - ``qemu-system-$ARCH``
 
@@ -118,7 +144,8 @@ process for:
 
 2) documentation
 
-3) ROMs, which can be either installed as binary blobs or compiled
+3) ROMs, whether provided as binary blobs in the QEMU distributions
+   or cross compiled under the direction of the configure script
 
 4) other data files, such as icons or desktop files
 
@@ -273,8 +300,7 @@ system/userspace emulation target
 Adding checks
 -------------
 
-New checks should be added to Meson.  Compiler checks can be as simple as
-the following::
+Compiler checks can be as simple as the following::
 
   config_host_data.set('HAVE_BTRFS_H', cc.has_header('linux/btrfs.h'))
 
@@ -351,22 +377,30 @@ script, which may point to something other than the first python3
 binary on the path.
 
 
-Stage 3: makefiles
-==================
+Stage 3: Make
+=============
 
-The use of GNU make is required with the QEMU build system.
+The next step in building QEMU is to invoke make.  GNU Make is required
+to build QEMU, and may be installed as ``gmake`` on some hosts.
 
-The output of Meson is a build.ninja file, which is used with the Ninja
-build system.  QEMU uses a different approach, where Makefile rules are
-synthesized from the build.ninja file.  The main Makefile includes these
-rules and wraps them so that e.g. submodules are built before QEMU.
-The resulting build system is largely non-recursive in nature, in
-contrast to common practices seen with automake.
+The output of Meson is a ``build.ninja`` file, which is used with the
+Ninja build tool.  However, QEMU's build comprises other components than
+just the emulators (namely firmware and the tests in ``tests/tcg``) which
+need different cross compilers.  The QEMU Makefile wraps both Ninja and
+the smaller build systems for firmware and tests; it also takes care of
+running ``configure`` again when the script changes.  Apart from invoking
+these sub-Makefiles, the resulting build is largely non-recursive.
 
-Tests are also ran by the Makefile with the traditional ``make check``
-phony target, while benchmarks are run with ``make bench``.  Meson test
-suites such as ``unit`` can be ran with ``make check-unit`` too.  It is also
-possible to run tests defined in meson.build with ``meson test``.
+Tests, whether defined in ``meson.build`` or not, are also ran by the
+Makefile with the traditional ``make check`` phony target, while benchmarks
+are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
+with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
+tests for all targets.
+
+If desired, it is also possible to use ``ninja`` and ``meson test``,
+respectively to build emulators and run tests defined in meson.build.
+The main difference is that ``make`` needs the ``-jN`` flag in order to
+enable parallel builds or tests.
 
 Useful make targets
 -------------------
@@ -378,6 +412,7 @@ Useful make targets
   Print the value of the variable VAR. Useful for debugging the build
   system.
 
+
 Important files for the build system
 ====================================
 
@@ -391,8 +426,7 @@ number of dynamically created files listed later.
 ``Makefile``
   The main entry point used when invoking make to build all the components
   of QEMU. The default 'all' target will naturally result in the build of
-  every component. Makefile takes care of recursively building submodules
-  directly via a non-recursive set of rules.
+  every component.
 
 ``*/meson.build``
   The meson.build file in the root directory is the main entry point for the
@@ -401,59 +435,92 @@ number of dynamically created files listed later.
   other meson.build files spread throughout the QEMU source tree.
 
 ``tests/Makefile.include``
-  Rules for external test harnesses. These include the TCG tests,
-  ``qemu-iotests`` and the Avocado-based integration tests.
+  Rules for external test harnesses. These include the TCG tests
+  and the Avocado-based integration tests.
 
 ``tests/docker/Makefile.include``
-  Rules for Docker tests. Like tests/Makefile, this file is included
-  directly by the top level Makefile, anything defined in this file will
-  influence the entire build system.
+  Rules for Docker tests. Like ``tests/Makefile.include``, this file is
+  included directly by the top level Makefile, anything defined in this
+  file will influence the entire build system.
 
 ``tests/vm/Makefile.include``
-  Rules for VM-based tests. Like tests/Makefile, this file is included
-  directly by the top level Makefile, anything defined in this file will
-  influence the entire build system.
+  Rules for VM-based tests. Like ``tests/Makefile.include``, this file is
+  included directly by the top level Makefile, anything defined in this
+  file will influence the entire build system.
 
 Dynamically created files
 -------------------------
 
-The following files are generated dynamically by configure in order to
-control the behaviour of the statically defined makefiles. This avoids
-the need for QEMU makefiles to go through any pre-processing as seen
-with autotools, where Makefile.am generates Makefile.in which generates
-Makefile.
+The following files are generated at run-time in order to control the
+behaviour of the Makefiles. This avoids the need for QEMU makefiles to
+go through any pre-processing as seen with autotools, where configure
+generates ``Makefile`` from ``Makefile.in``.
 
 Built by configure:
 
 ``config-host.mak``
   When configure has determined the characteristics of the build host it
-  will write a long list of variables to config-host.mak file. This
-  provides the various install directories, compiler / linker flags and a
+  will write them to this file for use in ``Makefile`` and to a smaller
+  extent ``meson.build``. These include the paths to various tools and a
   variety of ``CONFIG_*`` variables related to optionally enabled features.
-  This is imported by the top level Makefile and meson.build in order to
-  tailor the build output.
 
-  config-host.mak is also used as a dependency checking mechanism. If make
+  ``config-host.mak`` is also used as a dependency checking mechanism. If make
   sees that the modification timestamp on configure is newer than that on
-  config-host.mak, then configure will be re-run.
+  ``config-host.mak``, then configure will be re-run.
 
-  The variables defined here are those which are applicable to all QEMU
-  build outputs. Variables which are potentially different for each
-  emulator target are defined by the next file...
+  The variables defined here apply to all QEMU
+  build outputs.
 
+``config-meson.cross``
+
+  A Meson "cross file" (or native file) used to communicate the paths to
+  the toolchain and other configuration options.
+
+``config.status``
+
+  A small shell script that will invoke configure again with the same
+  environment variables that were set during the first run.  It's used to
+  rerun configure after changes to the source code, but it can also be
+  inspected manually to check the contents of the environment.
+
+``Makefile.prereqs``
+
+  A set of Makefile dependencies that order the build and execution of
+  firmware and tests after the container images and emulators that they
+  need.
+
+``pc-bios/*/config.mak``, ``tests/tcg/config-host.mak``, ``tests/tcg/*/config-target.mak``
+
+  Configuration variables used to build the firmware and TCG tests,
+  including paths to cross compilation toolchains.
+
+``pyvenv``
+
+  A Python virtual environment that is used for all Python code running
+  during the build.  Using a virtual environment ensures that even code
+  that is run via ``sphinx-build``, ``meson`` etc. uses the same interpreter
+  and packages.
 
 Built by Meson:
 
-``${TARGET-NAME}-config-devices.mak``
-  TARGET-NAME is again the name of a system or userspace emulator. The
-  config-devices.mak file is automatically generated by make using the
-  scripts/make_device_config.sh program, feeding it the
-  default-configs/$TARGET-NAME file as input.
+``config-host.h``
+  Used by C code to determine the properties of the build environment
+  and the set of enabled features for the entire build.
 
-``config-host.h``, ``$TARGET_NAME-config-target.h``, ``$TARGET_NAME-config-devices.h``
-  These files are used by source code to determine what features are
-  enabled.  They are generated from the contents of the corresponding
-  ``*.mak`` files using Meson's ``configure_file()`` function.
+``${TARGET-NAME}-config-devices.mak``
+  TARGET-NAME is the name of a system emulator. The file is
+  generated by Meson using files under ``configs/devices`` as input.
+
+``${TARGET-NAME}-config-target.mak``
+  TARGET-NAME is the name of a system or usermode emulator. The file is
+  generated by Meson using files under ``configs/targets`` as input.
+
+``$TARGET_NAME-config-target.h``, ``$TARGET_NAME-config-devices.h``
+  Used by C code to determine the properties and enabled
+  features for each target.  enabled.  They are generated from
+  the contents of the corresponding ``*.mak`` files using Meson's
+  ``configure_file()`` function; each target can include them using
+  the ``CONFIG_TARGET`` and ``CONFIG_DEVICES`` macro respectively.
 
 ``build.ninja``
   The build rules.
-- 
2.40.1


