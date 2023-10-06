Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5AE7BB3DB
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogmq-0007zJ-Cs; Fri, 06 Oct 2023 05:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmo-0007yw-Cl
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:18 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogml-0000sD-CE
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:18 -0400
Received: (qmail 19337 invoked by uid 484); 6 Oct 2023 09:06:11 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.333371 secs); 06 Oct 2023 09:06:11 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:10 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 00/29] first version of mcdstub
Date: Fri,  6 Oct 2023 11:05:41 +0200
Message-Id: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
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
Such a shared library will be available soon Lauterbach's open source site
and will be linked to from inside this project in a future patch.
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
It is declared in include/qemu/debug.h, defined in debug/debug-common.c
and configured in debug/debug-gdb.c and debug/debug-mcd.c respectively.
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

neder (29):
  mcdstub initial commit, mcdstub file structure added
  TCP chardev added, handshake with TRACE32 working
  TCP packet handling added
  queries for resets and triggers added
  queries for memory spaces and register groups added
  query for registers added
  query data preparation improved
  shared header file added, used for TCP packet data
  memory and register query data now stored per core
  handler for resets added
  query for the VM state added
  handler for reading registers added
  handler for reading memory added
  handler for single step added
  adapting to the qemu coding style
  deleting the mcdd startup option
  handler for breakpoints and watchpoints added
  making step and go handlers core-specific
  adding trigger ID handling for TRACE32
  cp register read/write added
  switching between secure and non-secure memory added
  transitioning to unsinged integers in TCP packets and removing
    MCD-API-specific terms
  moved all ARM code to the ARM mcdstub and added now commom header file
  step and go handlers now propperly perform global operations
  Doxygen documentation added
  moved all mcd related header files into include/mcdstub
  MCD stub entry added to maintainers file
  added description to out-commented gdb function
  introducing the DebugClass. It is used to abstract the gdb/mcd
    set_stop_cpu function.

 MAINTAINERS                          |   12 +
 debug/debug-common.c                 |   42 +
 debug/debug-gdb.c                    |   24 +
 debug/debug-mcd.c                    |   25 +
 gdbstub/meson.build                  |    4 +-
 gdbstub/softmmu.c                    |    4 +
 gdbstub/user.c                       |    2 +
 include/exec/gdbstub.h               |    5 +
 include/exec/mcdstub.h               |   12 +
 include/hw/boards.h                  |    1 +
 include/mcdstub/arm_mcdstub.h        |  139 ++
 include/mcdstub/mcd_shared_defines.h |  105 ++
 include/mcdstub/mcdstub.h            |  829 +++++++++++
 include/mcdstub/mcdstub_common.h     |   64 +
 include/mcdstub/syscalls.h           |    6 +
 include/qemu/debug.h                 |   19 +
 include/qemu/typedefs.h              |    2 +
 mcdstub/mcd_syscalls.c               |   30 +
 mcdstub/mcdstub.c                    | 1960 ++++++++++++++++++++++++++
 mcdstub/meson.build                  |   19 +
 meson.build                          |    1 +
 qemu-options.hx                      |   18 +
 softmmu/cpus.c                       |    9 +-
 softmmu/vl.c                         |   13 +
 target/arm/mcdstub.c                 |  559 ++++++++
 target/arm/meson.build               |    1 +
 26 files changed, 3902 insertions(+), 3 deletions(-)
 create mode 100644 debug/debug-common.c
 create mode 100644 debug/debug-gdb.c
 create mode 100644 debug/debug-mcd.c
 create mode 100644 include/exec/mcdstub.h
 create mode 100644 include/mcdstub/arm_mcdstub.h
 create mode 100644 include/mcdstub/mcd_shared_defines.h
 create mode 100644 include/mcdstub/mcdstub.h
 create mode 100644 include/mcdstub/mcdstub_common.h
 create mode 100644 include/mcdstub/syscalls.h
 create mode 100644 include/qemu/debug.h
 create mode 100644 mcdstub/mcd_syscalls.c
 create mode 100644 mcdstub/mcdstub.c
 create mode 100644 mcdstub/meson.build
 create mode 100644 target/arm/mcdstub.c

-- 
2.34.1


