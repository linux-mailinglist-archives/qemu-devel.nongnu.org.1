Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447ABBD8DB
	for <lists+qemu-devel@lfdr.de>; Mon, 06 Oct 2025 11:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hyZ-0006K8-Ki; Mon, 06 Oct 2025 05:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyX-0006Jg-QA
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:49 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyV-0003nY-IT
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:49 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 0E4A360B75
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:37 +0200 (CEST)
Received: (qmail 18608 invoked by uid 990); 6 Oct 2025 09:57:36 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:36 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>
Subject: [PATCH v7 00/25] tcg-plugins: add hooks for discontinuities
Date: Mon,  6 Oct 2025 11:56:55 +0200
Message-ID: <cover.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-0.004625) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.895374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=fNNibpMycVHPIJs5FkD7HNjGhOHQTnmUGxod93yF8bU=;
 b=UXOrVOOp5qT9X4vB9bmwcrX9oXi5aBhST+MGwGCRiO36v2Hr5JTb1hTRRJ7iHl3fH1UX7mx2R1
 4KmxhI2jM7Aw9ibds502wuu9JHoLjO5ICxRMlAci7ztvieLicPGNaFBKE3R6PspgYi8Jh22p5txP
 F/5ZuazhGNQHwNLMZld/ErEs84PRyjRoQGiaf0pZFVYUD1TFeOksB0+nA937BqHpOKkflzcf8nW6
 sirgKlRus6n0+ySNppowF/KE/3ycuj29hX3LeqFeusVXDnoU6o4VHdsZqw0Ix37YTsqbvpTPHVt+
 8xYm1+0MN7wymBshUYDRnshDq4FNOX+pWHEL3bpo+6jeCH+6Z5m0K6CvYbQeitXmsg4nbP9VqMRK
 3NrB61pIUuv3pKttYqq7vPUDNOhvTALiOx4L5acf7El5euaDjR1aOKlqaB+GHEyPSJWz6S+eTPae
 Qivd8ujbcgniBuYsGjqlvjSMmT2V7/FGJBu/ZzsjDAgcaXTbDomRteUax7BwmPSlK5N3XzrFyh03
 Iz+6H9S2u72sbbYUbe/KtcxETFS87A/Rrc8WP/6LN9WkEMJ+wq8dX9OUAa39Z9g+gl2cHownQAni
 aocr+hUMUL2gcI2W4uka5r+ovU3hHe9HswTN5bfrWBd9gv6+QqpPyfo44YgkiyLuFawKQ+tyethW
 U=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Some analysis greatly benefits, or depends on, information about
certain types of dicontinuities such as interrupts. For example, we may
need to handle the execution of a new translation block differently if
it is not the result of normal program flow but of an interrupt.

Even with the existing interfaces, it is more or less possible to
discern these situations, e.g. as done by the cflow plugin. However,
this process poses a considerable overhead to the core analysis one may
intend to perform.

These changes introduce a generic and easy-to-use interface for plugin
authors in the form of a callback for discontinuities. Patch 1 defines
an enumeration of some trap-related discontinuities including somewhat
narrow definitions of the discontinuity evetns and a callback type.
Patch 2 defines the callback registration function. Patch 3 adds some
hooks for triggering the callbacks. Patch 4 adds an example plugin
showcasing the new API.

Patches 5 through 22 call the hooks for all architectures but hexagon,
mapping architecture specific events to the three categories defined in
patch 1. We don't plan to add hooks for hexagon since despite having
exceptions apparently doesn't have any discontinuities associated with
them.

Patch 23 supplies a test plugin asserting some behavior of the plugin
API w.r.t. the PCs reported by the new API. Finally, patches 24 and 25
add new tests for riscv which serve as test-cases for the test plugin.

Sidenote: I'm likely doing something wrong for one architecture or
the other. These patches are untested for most of them.

Richard Henderson proposed streamlining interrupts and exceptions for
all targets and calling the hooks from a higher level rather than in
each target code. However, there are a few obstacles and I decided to
not do this as part of this series.

I also briefly considered adding a syscall discon type following the
realization that exceptions are also visible outside system emulation
mode, but decided against that since callbacks for syscall entry and
exit already exist.

Since v6:
  - The "traps" example plugin now only informs users that interrupts
    are only availible in system emulation mode rather than erroring
    out when not run in that mode.
  - The hostcall hook is now also called for xtensa simcalls (pointed
    out by Philippe Mathieu-Daudé).
  - The "discon" testing plugin now uses g_strdup_printf for formatting
    the reporting message (as suggested by Daniel P. Berrangé).
    Previously the message was assembled using g_string_append_printf.

Since v5:
  - The internal function plugin_vcpu_cb__discon now takes the
    qemu_plugin_event as a parameter instead of determining the event
    from the discon type.
  - Fixed computation of the last PC for ARM platforms.
  - Code mapping ARM exception index to discon type is now shared
    between m- and a-profile.
  - Fixed mapping of interrupt number to discon type for HPPA platforms.
  - Removed exception hook for some internal events for Motorola 68000.
  - Call hook for unaligned access exceptions on MicroBlaze platforms.
  - Prevented calling of exception hooks for resets on OpenRISC.
  - Made the discon test plugin compare hardware addesses transpated
    with qemu_plugin_translate_vaddr when comparing addresses. Before
    we'd use a crude bitmask.

Since v4:
  - Fixed a typo in the documentation of the
    qemu_plugin_vcpu_discon_cb_t function type (pointed out by Pierrick
    Bouvier)
  - Fixed a reference in the documentation of the
    qemu_plugin_vcpu_discon_cb_t function type
  - Added hooks for SuperH and TriCore targets
  - Fixed typos in commit messages (pointed out by Daniel Henrique
    Barboza)

Since v3 (RFC):
  - Switched to shifting 1 notation for qemu_plugin_discon_type values
    (as requested by Pierrick Bouvier)
  - Added missing documentation of function parameters of function
    pointer type qemu_plugin_vcpu_discon_cb_t
  - Added missing documentation of function parameters of
    qemu_plugin_register_vcpu_discon_cb
  - Eliminated "to" argument from hooks called from target specific
    code, i.e. qemu_plugin_vcpu_interrupt_cb and friends, determine "to"
    address using CPUClass::get_pc
  - Replaced comment declaring switch-case unreachable with
    g_assert_not_reached()
  - Call qemu_plugin_register_vcpu_discon_cb with QEMU_PLUGIN_DISCON_ALL
    rather than QEMU_PLUGIN_DISCON_TRAPS in "traps" example plugin
  - Take max_vcpus from qemu_info_t in "traps" example plugin, don't
    determine it based on VCPU activation
  - Added a description of the "traps" example plugin (as requested by
    Pierrick Bouvier)
  - Added section for the "traps" example plugin in documentation's
    "Emulation" chapter
  - Fixed messed-up switch-case in alpha_cpu_do_interrupt
  - Added hooks for PA-RISC, x86, loongarch, Motorola 68000, MicroBlaze,
    OpenRISC, Power PC, Renesas Xtreme, IBM System/390 and xtensa
    targets.
  - Made "discon" test plugin check PCs in vcpu_discon callback (as
    requested by Pierrick Bouvier)
  - Added parameter to "discon" test plugin for controlling which
    address bits are compared to cope with TBs being used under
    different virtual addresses
  - Added parameter to "discon" test plugin for printing a full
    instruction trace for debugging purposes
  - Made "discon" test plugin abort by default on address mismatches
  - Added test-cases for RISC-V

Since v2 (tcg-plugins: add hooks for interrupts, exceptions and traps):
  - Switched from traps as core concept to more generic discontinuities
  - Switched from semihosting to hostcall as term for emulated traps
  - Added enumeration of events and dedicated callback type
  - Make callback receive event type as well as origin and target PC
    (as requested by Pierrick Bouvier)
  - Combined registration functions for different traps into a single
    one for all types of discontinuities (as requested by Pierrick
    Bouvier)
  - Migrated records in example plugin from fully pre-allocated to a
    scoreboard (as suggested by Pierrick Bouvier)
  - Handle PSCI calls as hostcall (as pointed out by Peter Maydell)
  - Added hooks for ARM Cortex M arches (as pointed out by Peter
    Maydell)
  - Added hooks for Alpha targets
  - Added hooks for MIPS targets
  - Added a plugin for testing some of the interface behaviour

Since v1:
  - Split the one callback into multiple callbacks
  - Added a target-agnostic definition of the relevant event(s)
  - Call hooks from architecture-code rather than accel/tcg/cpu-exec.c
  - Added a plugin showcasing API usage

Julian Ganz (25):
  plugins: add types for callbacks related to certain discontinuities
  plugins: add API for registering discontinuity callbacks
  plugins: add hooks for new discontinuity related callbacks
  contrib/plugins: add plugin showcasing new dicontinuity related API
  target/alpha: call plugin trap callbacks
  target/arm: call plugin trap callbacks
  target/avr: call plugin trap callbacks
  target/hppa: call plugin trap callbacks
  target/i386: call plugin trap callbacks
  target/loongarch: call plugin trap callbacks
  target/m68k: call plugin trap callbacks
  target/microblaze: call plugin trap callbacks
  target/mips: call plugin trap callbacks
  target/openrisc: call plugin trap callbacks
  target/ppc: call plugin trap callbacks
  target/riscv: call plugin trap callbacks
  target/rx: call plugin trap callbacks
  target/s390x: call plugin trap callbacks
  target/sh4: call plugin trap callbacks
  target/sparc: call plugin trap callbacks
  target/tricore: call plugin trap callbacks
  target/xtensa: call plugin trap callbacks
  tests: add plugin asserting correctness of discon event's to_pc
  tests: add test for double-traps on rv64
  tests: add test with interrupted memory accesses on rv64

 contrib/plugins/meson.build               |   2 +-
 contrib/plugins/traps.c                   |  83 ++++++++
 docs/about/emulation.rst                  |   8 +
 include/qemu/plugin-event.h               |   3 +
 include/qemu/plugin.h                     |  13 ++
 include/qemu/qemu-plugin.h                |  60 ++++++
 plugins/core.c                            |  57 ++++++
 target/alpha/helper.c                     |  13 ++
 target/arm/helper.c                       |  24 +++
 target/arm/internals.h                    |   1 +
 target/arm/tcg/m_helper.c                 |   5 +
 target/avr/helper.c                       |   3 +
 target/hppa/int_helper.c                  |  44 +++++
 target/i386/tcg/excp_helper.c             |   3 +
 target/i386/tcg/seg_helper.c              |   4 +
 target/loongarch/cpu.c                    |   4 +
 target/m68k/op_helper.c                   |  22 +++
 target/microblaze/helper.c                |  10 +
 target/mips/tcg/system/tlb_helper.c       |  11 ++
 target/openrisc/interrupt.c               |  15 ++
 target/ppc/excp_helper.c                  |  41 ++++
 target/riscv/cpu_helper.c                 |   9 +
 target/rx/helper.c                        |  12 ++
 target/s390x/tcg/excp_helper.c            |   8 +
 target/sh4/helper.c                       |   4 +
 target/sparc/int32_helper.c               |   7 +
 target/sparc/int64_helper.c               |  10 +
 target/tricore/op_helper.c                |   5 +
 target/xtensa/exc_helper.c                |   6 +
 target/xtensa/xtensa-semi.c               |   3 +
 tests/tcg/plugins/discons.c               | 221 ++++++++++++++++++++++
 tests/tcg/plugins/meson.build             |   2 +-
 tests/tcg/riscv64/Makefile.softmmu-target |  12 ++
 tests/tcg/riscv64/doubletrap.S            |  73 +++++++
 tests/tcg/riscv64/interruptedmemory.S     |  67 +++++++
 35 files changed, 863 insertions(+), 2 deletions(-)
 create mode 100644 contrib/plugins/traps.c
 create mode 100644 tests/tcg/plugins/discons.c
 create mode 100644 tests/tcg/riscv64/doubletrap.S
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

-- 
2.49.1


