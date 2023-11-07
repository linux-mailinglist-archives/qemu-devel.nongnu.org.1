Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54757E3FBE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lly-0001C2-Mh; Tue, 07 Nov 2023 08:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkg-0008G6-93
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:22 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkG-0005gH-LN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:03 -0500
Received: (qmail 30780 invoked by uid 484); 7 Nov 2023 13:03:30 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.50437 secs); 07 Nov 2023 13:03:30 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:28 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 00/20] first version of mcdstub
Date: Tue,  7 Nov 2023 14:03:03 +0100
Message-Id: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
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

Nicolas Eder (20):
  mcdstub: initial file structure for new mcdstub created. -mcd QEMU
    startup option added. Functions for initializing the mcdstub added.
    Basic helper functions for processes/cpus in the mcdstub added
  mcdstub gdbstub: new DebugClass and DebugState introduced. They are
    used to abstract the debugger details behind a QOM. This is
    currently used in the cpu_handle_guest_debug function
  gdbstub: moving code so that it can be easier accessed from outside
    the gdbstub: fromhex and tohex functions moved to a cutils header.
    GDBRegisterState moved to gdbstub.h
  mcdstub: added header with defines specific to the mcd tcp packet
    communication
  mcdstub: tcp packet processing added
  mcdstub: open/close server functions and trigger/reset data added.
    User for initial connection with an mcd client
  mcdstub: quitting QEMU via mcd command added
  mcdstub: query packet processing added and core/system querie added
  mcdstub: open/close core added. This includes core specific data
    preparation: memory spaces, register groups and registers. This data
    preparation is done in the arm mcdstub
  mcdstub: state query added: this query collects information about the
    state of a specific core. This commit also includes
    mcd_vm_state_change, which is called when the cpu state changes
    because it collects data for the query
  mcdstub: reset and trigger queries added
  mcdstub: missing parse_reg_xml function for parsing gdb register xml
    files added
  mcdstub: added queries for memory spaces, register groups and
    registers
  mcdstub: missing handle_query_state function added
  mcdstub: added go, break and step functionality and all corresponding
    functions
  mcdstub: function construct for resets added
  mcdstub: reading/writing registers added
  mcdstub: read/write to memory added: This also includes various helper
    functions in the QEMU memory code
  mcdstub: break/watchpoints added
  mcdstub: updated MAINTAINERS file and fully activated the mcdstub in
    the meson build system

 MAINTAINERS                          |   11 +
 debug/debug-common.c                 |   42 +
 debug/debug-gdb.c                    |   24 +
 debug/debug-mcd.c                    |   25 +
 gdbstub/gdbstub.c                    |    9 +-
 gdbstub/internals.h                  |   26 -
 gdbstub/meson.build                  |    4 +-
 gdbstub/system.c                     |    4 +
 gdbstub/user.c                       |    2 +
 include/cutils.h                     |   30 +
 include/exec/cpu-common.h            |    2 +
 include/exec/gdbstub.h               |   14 +-
 include/exec/memory.h                |    9 +
 include/hw/boards.h                  |    1 +
 include/mcdstub/arm_mcdstub.h        |  107 ++
 include/mcdstub/mcd_shared_defines.h |  108 ++
 include/mcdstub/mcdstub.h            |  893 ++++++++++++
 include/mcdstub/mcdstub_common.h     |   59 +
 include/qemu/debug.h                 |   19 +
 include/qemu/typedefs.h              |    2 +
 mcdstub/mcdstub.c                    | 1998 ++++++++++++++++++++++++++
 mcdstub/meson.build                  |   15 +
 meson.build                          |    1 +
 qemu-options.hx                      |   18 +
 system/cpus.c                        |    9 +-
 system/memory.c                      |   11 +
 system/physmem.c                     |   26 +
 system/vl.c                          |   13 +
 target/arm/mcdstub.c                 |  304 ++++
 target/arm/meson.build               |    1 +
 30 files changed, 3749 insertions(+), 38 deletions(-)
 create mode 100644 debug/debug-common.c
 create mode 100644 debug/debug-gdb.c
 create mode 100644 debug/debug-mcd.c
 create mode 100644 include/cutils.h
 create mode 100644 include/mcdstub/arm_mcdstub.h
 create mode 100644 include/mcdstub/mcd_shared_defines.h
 create mode 100644 include/mcdstub/mcdstub.h
 create mode 100644 include/mcdstub/mcdstub_common.h
 create mode 100644 include/qemu/debug.h
 create mode 100644 mcdstub/mcdstub.c
 create mode 100644 mcdstub/meson.build
 create mode 100644 target/arm/mcdstub.c

-- 
2.34.1


