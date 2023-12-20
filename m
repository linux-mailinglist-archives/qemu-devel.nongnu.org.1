Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F681A50F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:29:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP4-0000PC-1R; Wed, 20 Dec 2023 11:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOx-0000Ms-EB
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:31 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOr-0004Qx-LG
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:30 -0500
Received: (qmail 15053 invoked by uid 484); 20 Dec 2023 16:26:01 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.392525 secs); 20 Dec 2023 16:26:01 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:25:59 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 00/18] first version of mcdstub
Date: Wed, 20 Dec 2023 17:25:37 +0100
Message-Id: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

SUMMARY
=======

This patch-set introduces the first version of the mcdstub.
The mcdstub is a debug interface, which enables debugging QEMU
using the MCD (Multi-Core Debug) API.
The mcdstub uses TCP to communicate with the host debug software. However,
because MCD is merely an API, the TCP communication is not part of
the MCD spec but specific to this project.

To translate between the MCD API and the TCP data stream coming from the mcdstub,
the host has to use a shared library (.dll/.so).
Such a shared library is available at: https://gitlab.com/lauterbach/mcdrefsrv
The MCD API itself can be downloaded here: https://repo.lauterbach.com/sprint_mcd_api_v1_0.zip

QUICK START
===========

Attention: MCD is currently only supported for qemu-system-arm !

Three components are required to Debug QEMU via MCD:

1. qemu-system-arm (built with this patch series applied).
2. MCD shared library (translates between the MCD API and TCP data).
3. Host debugging software with support for the MCD API (e.g. Lauterbach TRACE32).

To activate the mcdstub, just use the "mcd" launch option in combination with
a TCP port.

With the default TCP port 1235:

$ qemu-system-arm -M virt -cpu cortex-a15 -mcd default

With a custom TCP port:

$ qemu-system-arm -M virt -cpu cortex-a15 -mcd tcp::1235

QEMU will listen for an MCD host to connect to the specified port.

IMPORTANT CHANGES
=================

1. DebugClass:

This patch-set introduces the DebugClass to the QOM, which is used to abstract
GDB/MCD specific debugger details.
It is declared in include/qemu/debug.h, defined in debug/common/debug.c
It currently only offers one function: set_stop_cpu, which gets called
in cpu_handle_guest_debug in softmmu/cpus.c.
In the future, other functions could be moved from the mcd/gdbstub
to the DebugClass.

2. mcd launch option:

This patch-set introduces the mcd launch option to QEMU. The quick start
section describes how to use it.

3. MCD debugging features:

* Go, break, step
* Read/write memory (user space only)
* Read/write registers (GPR and CP)
* Set breakpoints and watchpoints.

=================

Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>

Nicolas Eder (18):
  gdbstub, mcdstub: file and build structure adapted to accomodate for
    the mcdstub
  gdbstub: hex conversion functions moved to cutils.h
  gdbstub: GDBRegisterState moved to gdbstub.h so it can be used outside
    of the gdbstub
  gdbstub: DebugClass added to system mode.
  mcdstub: memory helper functions added
  mcdstub: -mcd start option added, mcd specific defines added
  mcdstub: mcdserver initialization functions added
  cutils: qemu_strtou32 function added
  mcdstub: TCP packet plumbing added
  mcdstub: open and close server functions added
  mcdstub: system and core queries added
  mcdstub: all core specific queries added
  mcdstub: go, step and break added
  mcdstub: state query added
  mcdstub: skeleton for reset handling added
  mcdstub: register access added
  mcdstub: memory access added
  mcdstub: break/watchpoints added

 MAINTAINERS                              |   11 +-
 debug/common/debug.c                     |   51 +
 debug/common/meson.build                 |    1 +
 {gdbstub => debug/gdbstub}/gdbstub.c     |   27 +-
 {gdbstub => debug/gdbstub}/internals.h   |   26 -
 {gdbstub => debug/gdbstub}/meson.build   |    0
 {gdbstub => debug/gdbstub}/syscalls.c    |    0
 {gdbstub => debug/gdbstub}/system.c      |   18 +
 {gdbstub => debug/gdbstub}/trace-events  |    0
 debug/gdbstub/trace.h                    |    1 +
 {gdbstub => debug/gdbstub}/user-target.c |    0
 {gdbstub => debug/gdbstub}/user.c        |    0
 debug/mcdstub/arm_mcdstub.c              |  289 +++
 debug/mcdstub/mcdstub.c                  | 2481 ++++++++++++++++++++++
 debug/mcdstub/meson.build                |   12 +
 debug/meson.build                        |    3 +
 gdbstub/trace.h                          |    1 -
 include/exec/cpu-common.h                |    3 +
 include/exec/gdbstub.h                   |    8 +
 include/exec/memory.h                    |    9 +
 include/hw/boards.h                      |    1 +
 include/mcdstub/arm_mcdstub.h            |  118 +
 include/mcdstub/mcd_shared_defines.h     |  132 ++
 include/mcdstub/mcdstub.h                |  165 ++
 include/mcdstub/mcdstub_common.h         |   83 +
 include/qemu/cutils.h                    |   32 +
 include/qemu/debug.h                     |   38 +
 include/qemu/typedefs.h                  |    2 +
 meson.build                              |    4 +-
 qemu-options.hx                          |   18 +
 system/cpus.c                            |    9 +-
 system/memory.c                          |   11 +
 system/physmem.c                         |   26 +
 system/vl.c                              |   13 +
 util/cutils.c                            |   30 +
 35 files changed, 3575 insertions(+), 48 deletions(-)
 create mode 100644 debug/common/debug.c
 create mode 100644 debug/common/meson.build
 rename {gdbstub => debug/gdbstub}/gdbstub.c (98%)
 rename {gdbstub => debug/gdbstub}/internals.h (92%)
 rename {gdbstub => debug/gdbstub}/meson.build (100%)
 rename {gdbstub => debug/gdbstub}/syscalls.c (100%)
 rename {gdbstub => debug/gdbstub}/system.c (97%)
 rename {gdbstub => debug/gdbstub}/trace-events (100%)
 create mode 100644 debug/gdbstub/trace.h
 rename {gdbstub => debug/gdbstub}/user-target.c (100%)
 rename {gdbstub => debug/gdbstub}/user.c (100%)
 create mode 100644 debug/mcdstub/arm_mcdstub.c
 create mode 100644 debug/mcdstub/mcdstub.c
 create mode 100644 debug/mcdstub/meson.build
 create mode 100644 debug/meson.build
 delete mode 100644 gdbstub/trace.h
 create mode 100644 include/mcdstub/arm_mcdstub.h
 create mode 100644 include/mcdstub/mcd_shared_defines.h
 create mode 100644 include/mcdstub/mcdstub.h
 create mode 100644 include/mcdstub/mcdstub_common.h
 create mode 100644 include/qemu/debug.h

-- 
2.34.1


