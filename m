Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FFAB42233
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 15:43:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnkO-0005ze-KO; Wed, 03 Sep 2025 09:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1utnkM-0005y5-L6; Wed, 03 Sep 2025 09:41:58 -0400
Received: from forward103a.mail.yandex.net ([2a02:6b8:c0e:500:1:45:d181:d103])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1utnkJ-0007Eq-Jl; Wed, 03 Sep 2025 09:41:58 -0400
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0d:400:0:640:80de:0])
 by forward103a.mail.yandex.net (Yandex) with ESMTPS id 6E9028075F;
 Wed, 03 Sep 2025 16:41:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id kfgPGGxM54Y0-0CgiHkRS; 
 Wed, 03 Sep 2025 16:41:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1756906907; bh=VIXPHPX2ub7qItf86FnjXAXVy7ZYnmwKLv/n6hcDljI=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=IDXp11mu2EJ+YczsRQvA2HgC/TuZjWn5ZzO/a/h5tEZ5VqccwljnBMxf+rsP9vSIg
 ktn1wssUEsIqQJE5lq0belokHB0kfjGfGTVTDQ6wJe8ePIbxfhcpRgAGAq/KN/Kbnu
 VMO63hXcBBjgp+6HDF4a3GYfYYoVkmTZ5NuTwB0A=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Danila Zhebryakov <d.zhebryakov@yandex.ru>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Danila Zhebryakov <d.zhebryakov@yandex.ru>
Subject: [PATCH v2 0/4] Add support for PowerPC e500 little-endian pages
Date: Wed,  3 Sep 2025 16:41:42 +0300
Message-ID: <20250903134146.1487794-1-d.zhebryakov@yandex.ru>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:d103;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward103a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

These changes make powerpc booke206 mmu pass TLB_BSWAP flag for pages marked as LE, and also fixes all the issues this causes.
 - added TLB_BSWAP to non-MMIO flags
 - inserted additional check for LE page when bswap-ing instructions
 - removed assert for cross-page TLB_BSWAP accesses
 - added gdbstub fix to account for TLB_BSWAP of the currently running code

BE- and LE- atomic operations (used by load-and-reserve and store-conditional instructions) were unified to support TLB_BSWAP

Some of the fixes are based on what is done in https://github.com/YetAnotherMod/qemu

V2:
 - Removed usage of PAGE_USER bit for LE (comment on previous version)
 - Refactored MMU code so directly setting TLB_BSWAP is possible
 - moved translation LE page detect to occur 1 time per translation (comment on previous version)
 - Removed redundant assert in atomic_mmu_lookup (comment on previous version)
 - Added assert on cross-endian accesses (ideally, there should be an exception)
 - Changed atomic need_bswap handling (comment on previous version)
 - Rebased and fixed atomics

According to RM, unaligned accesses between LE and BE pages should cause an exception on e500.
However, (as I understand it) supporting this would require adding a new callback to TCGCPUOps, likely just for E500 or maybe a couple other CPUs doing this.
Such accesses are clearly not normal and usually don't occur in real applications, so I think just placing assert is OK here.

Danila Zhebryakov (4):
  accel/tcg: Unify big- and little- endian atomic ops
  target/ppc: refactor MMU helpers
  target/ppc: Add support for LE pages on PowerPC booke206 mmu
  target/ppc: fix GDB stub to work correctly with LE pages

 accel/tcg/atomic_common.c.inc       |  36 +--
 accel/tcg/atomic_template.h         | 326 ++++++++++------------------
 accel/tcg/cputlb.c                  |  29 ++-
 accel/tcg/tcg-runtime.h             |  48 +---
 accel/tcg/user-exec.c               |   2 +-
 include/accel/tcg/cpu-ldst-common.h |  51 ++---
 target/m68k/op_helper.c             |   4 +-
 target/ppc/gdbstub.c                |  17 +-
 target/ppc/internal.h               |   3 +-
 target/ppc/mmu-booke.c              |  67 +++---
 target/ppc/mmu-booke.h              |   2 +-
 target/ppc/mmu-hash32.c             |  30 +--
 target/ppc/mmu-hash32.h             |   3 +-
 target/ppc/mmu-hash64.c             |  14 +-
 target/ppc/mmu-hash64.h             |   2 +-
 target/ppc/mmu-radix64.c            |  20 +-
 target/ppc/mmu-radix64.h            |   2 +-
 target/ppc/mmu_common.c             |  75 ++++---
 target/ppc/mmu_helper.c             |  15 +-
 target/ppc/translate.c              |  42 +++-
 target/s390x/tcg/mem_helper.c       |   6 +-
 tcg/tcg-op-ldst.c                   |  43 ++--
 22 files changed, 370 insertions(+), 467 deletions(-)

-- 
2.47.2


