Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 224B8A3F6B3
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 15:03:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTb9-00085I-Ss; Fri, 21 Feb 2025 09:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWf-0006Pz-Ml
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:50 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWc-00014y-VJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:49 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 3AC7F204E5A7; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AC7F204E5A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=F+cymudjeMMlPLTxCG5T5lz00MrTywaCf29lZWU3Zdg=;
 h=From:To:Cc:Subject:Date:From;
 b=f+nMdLCzDQJmEkAJ+F9FXJhuOyTYFricETh4aEP4olUcBsCc8d6/kzbltZNsNTcgQ
 AdVr3u6tlJm5liEL743ibXRoHpbkNvWWx8yD0SEVdmcFUeMImNEdPJgr+P9w+Sruk4
 zwD/C+NtwAJX+dF6gjQbl7WZAb1sibX9BjX5XKJs=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 00/19] Factor out HVF's instruction emulator
Date: Fri, 21 Feb 2025 00:36:08 -0800
Message-Id: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:00:51 -0500
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

Hi,

Microsoft's Linux Systems Group developed a Linux driver for the Microsoft
Hypervisor (MSHV for short). The driver is being upstreamed. The first
supported VMM is Cloud Hypervisor. QEMU will be the second supported
VMM.

The plan is to write an mshv accelerator in QEMU. The accelerator is still in
the works.

MSHV doesn't emulate instructions. VMMs are supposed to bring their own
instruction emulator. The path we've chosen is to reuse what's already in QEMU.
The instruction emulator in HVF looks good for what we need.

This patch series attempts to make the instruction emulator in HVF a common
component for the i386 target. It removes HVF specific code by either using a
set of hooks or moving it to better locations. The new incoming MSHV
accelerator will implement the hooks, and where necessary, enhance the emulator
and / or add new hooks.

This patch series is in RFC state. The patches have been lightly tested by
running a Linux VM on an Intel-based Mac.  We hope to get some feedback on the
overall approach, and let the community bikeshed a bit about names and
location.

First two patches fix issues in the existing code. They can be applied
regardless of the discussion around the overall approach.

The checkpatch script complains about a few things. Some are from the original
code I didn't touch. For the code I changed or moved, it complains that some
lines are long (>80). Seeing that the rule was not followed strictly in the old
code base, I held off fixing that class of issues. The other thing it complains
is there is no entry for the new directory in MAINTAINERS. We can fix these
issues if they are deemed important.

Please let us know what you think. The alternative is to duplicate the
instruction emulator code in the mshv accelerator. That looks to be a worse
option.

Thanks,
Wei.

Wei Liu (19):
  target/i386/hvf: fix a typo in a type name
  target/i386/hvf: fix the declaration of hvf_handle_io
  target/i386/hvf: use x86_segment in x86_decode.c
  target/i386/hvf: introduce x86_emul_ops
  target/i386/hvf: remove HVF specific calls from x86_decode.c
  target/i386/hvf: move and rename {load,store}_regs
  target/i386/hvf: provide and use handle_io in emul_ops
  target/i386: rename hvf_mmio_buf to mmio_buf
  target/i386/hvf: use emul_ops->read_mem in x86_emu.c
  taret/i386/hvf: provide and use write_mem in emul_ops
  target/i386/hvf: move and rename simulate_{rdmsr,wrmsr}
  target/i386/hvf: provide and use simulate_{wrmsr,rdmsr} in emul_ops
  target/i386: rename lazy flags field and its type
  target/i386/hvf: drop unused headers
  target/i386/hvf: drop some dead code
  target/i386/hvf: rename some include guards
  target/i386: add a directory for x86 instruction emulator
  target/i386/x86-insn-emul: add a panic.h
  target/i386: move x86 instruction emulator out of hvf

 target/i386/cpu.h                             |   8 +-
 target/i386/hvf/hvf-i386.h                    |   4 +-
 target/i386/hvf/hvf.c                         | 334 ++++++++++++++++--
 target/i386/hvf/meson.build                   |   3 -
 target/i386/hvf/vmx.h                         |   2 +-
 target/i386/hvf/x86.c                         |   8 +-
 target/i386/hvf/x86_cpuid.c                   |   2 +-
 target/i386/hvf/x86_descr.c                   |   8 +-
 target/i386/hvf/x86_descr.h                   |   8 +-
 target/i386/hvf/x86_mmu.c                     |   2 +-
 target/i386/hvf/x86_task.c                    |  32 +-
 target/i386/hvf/x86_task.h                    |   2 +-
 target/i386/hvf/x86hvf.c                      |   2 +-
 target/i386/hvf/x86hvf.h                      |   3 +
 target/i386/meson.build                       |   1 +
 target/i386/x86-insn-emul/meson.build         |   5 +
 target/i386/x86-insn-emul/panic.h             |  45 +++
 target/i386/{hvf => x86-insn-emul}/x86.h      |  12 +-
 .../i386/{hvf => x86-insn-emul}/x86_decode.c  |  18 +-
 .../i386/{hvf => x86-insn-emul}/x86_decode.h  |   4 +-
 target/i386/{hvf => x86-insn-emul}/x86_emu.c  | 329 ++---------------
 target/i386/{hvf => x86-insn-emul}/x86_emu.h  |  20 +-
 .../i386/{hvf => x86-insn-emul}/x86_flags.c   |  56 +--
 .../i386/{hvf => x86-insn-emul}/x86_flags.h   |   6 +-
 24 files changed, 497 insertions(+), 417 deletions(-)
 create mode 100644 target/i386/x86-insn-emul/meson.build
 create mode 100644 target/i386/x86-insn-emul/panic.h
 rename target/i386/{hvf => x86-insn-emul}/x86.h (96%)
 rename target/i386/{hvf => x86-insn-emul}/x86_decode.c (99%)
 rename target/i386/{hvf => x86-insn-emul}/x86_decode.h (99%)
 rename target/i386/{hvf => x86-insn-emul}/x86_emu.c (78%)
 rename target/i386/{hvf => x86-insn-emul}/x86_emu.h (72%)
 rename target/i386/{hvf => x86-insn-emul}/x86_flags.c (83%)
 rename target/i386/{hvf => x86-insn-emul}/x86_flags.h (97%)

-- 
2.39.5 (Apple Git-154)


