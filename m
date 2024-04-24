Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11848AFBC7
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 00:34:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOfo-00019N-KN; Tue, 23 Apr 2024 18:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOfb-00016q-0A; Tue, 23 Apr 2024 18:31:25 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOfX-0004aV-3F; Tue, 23 Apr 2024 18:31:22 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BBCED4E603E;
 Wed, 24 Apr 2024 00:31:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 20qXyZhTjFCM; Wed, 24 Apr 2024 00:31:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9BBA64E603D; Wed, 24 Apr 2024 00:31:10 +0200 (CEST)
Message-Id: <cover.1713907038.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 00/24] Misc PPC exception and BookE MMU clean ups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 24 Apr 2024 00:31:10 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This series does some further clean up mostly around BookE MMU to
untangle it from other MMU models. It also contains some other changes
that I've come up with while working on this. The first 3 patches are
from the last exception handling clean up series that were dropped due
to some error on CI but I'm not sure if that was because of some CI
infrastructure problem or some problem with the patches as the error
did not make much sense. So these patches are only rebased now, I made
no other change to them until the issue is understood better. The rest
are new patches I've added since tha last series. Please review.

Regards,
BALATON Zoltan


BALATON Zoltan (24):
  target/ppc: Fix gen_sc to use correct nip
  target/ppc: Move patching nip from exception handler to helper_scv
  target/ppc: Simplify syscall exception handlers
  target/ppc: Remove unused helper
  target/ppc/mmu_common.c: Move calculation of a value closer to its
    usage
  target/ppc/mmu_common.c: Simplify checking for real mode
  target/ppc/mmu_common.c: Drop cases for unimplemented MPC8xx MMU
  target/ppc/mmu_common.c: Introduce mmu6xx_get_physical_address()
  target/ppc/mmu_common.c: Rename get_bat_6xx_tlb()
  target/ppc/mmu_common.c: Split out BookE cases before checking real
    mode
  target/ppc/mmu_common.c: Split off real mode cases in
    get_physical_address_wtlb()
  target/ppc/mmu_common.c: Inline and remove check_physical()
  target/ppc/mmu_common.c: Simplify mmubooke_get_physical_address()
  target/ppc/mmu_common.c: Simplify mmubooke206_get_physical_address()
  target/ppc/mmu_common.c: Fix misindented qemu_log_mask() calls
  target/ppc/mmu_common.c: Deindent ppc_jumbo_xlate()
  target/ppc/mmu_common.c: Replace hard coded constants in
    ppc_jumbo_xlate()
  target/ppc/mmu_common.c: Make get_physical_address_wtlb() static
  target/ppc: Move mmu_ctx_t definition to mmu_common.c
  target/ppc: Remove ppc_hash32_pp_prot() and reuse common function
  target/ppc/mmu_common.c: Split off BookE handling from
    ppc_jumbo_xlate()
  target/ppc/mmu_common.c: Remove BookE handling from
    get_physical_address_wtlb()
  target/ppc/mmu_common.c: Simplify ppc_booke_xlate()
  target/ppc/mmu_common.c: Move BookE MMU functions together

 target/ppc/excp_helper.c |  67 +---
 target/ppc/helper.h      |   2 -
 target/ppc/internal.h    |  19 +-
 target/ppc/mmu-hash32.c  |  47 +--
 target/ppc/mmu_common.c  | 731 +++++++++++++++++++--------------------
 target/ppc/mmu_helper.c  |  24 --
 target/ppc/translate.c   |  12 +-
 7 files changed, 384 insertions(+), 518 deletions(-)

-- 
2.30.9


