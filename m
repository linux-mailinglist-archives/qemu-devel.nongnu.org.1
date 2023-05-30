Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA3A7161FD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:32:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOs-0001U2-CC; Tue, 30 May 2023 09:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOZ-00015I-0x; Tue, 30 May 2023 09:28:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOU-0002AR-TO; Tue, 30 May 2023 09:28:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 31709746377;
 Tue, 30 May 2023 15:28:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3B8AA746335; Tue, 30 May 2023 15:28:06 +0200 (CEST)
Message-Id: <cover.1685448535.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/7] Embedded PPC misc clean up and optimisation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 30 May 2023 15:28:06 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hello,

This series improves embedded PPC TLB emulation a bit and contains
some misc clean up I've found along the way. Before this patch
ppcemb_tlb_check() shows up in a memory access intensive profile
(running RageMem speed test in AmigaOS on sam460ex) at 11.91%
children, 10.77% self. After this series it does not show up at all.
This is not the biggest bottleneck, that is calling tlb_flush() from
helper_440_tlbwe() excessively but this was simpler to clean up and
still makes a small improvement.

RageMem results on master:
---> RAM <---
READ32:  593 MB/Sec
READ64:  616 MB/Sec
WRITE32: 589 MB/Sec
WRITE64: 621 MB/Sec
WRITE: 518 MB/Sec (Tricky)

---> VIDEO BUS <---
READ:  588 MB/Sec
WRITE: 571 MB/Sec

with this series:
---> RAM <---
READ32:  674 MB/Sec
READ64:  707 MB/Sec
WRITE32: 665 MB/Sec
WRITE64: 714 MB/Sec
WRITE: 580 MB/Sec (Tricky)

---> VIDEO BUS <---
READ:  691 MB/Sec
WRITE: 662 MB/Sec

The results have some jitter but both the higher values and that the
function is gone from the profile can prove the series has an effect.
If nothing else then simplifying the code a bit. For comparison this
is faster than a real sam460ex but much slower than running the same
with -M pegasos2 so embedded PPC TLB emulation still might need some
improvement. I know these are different and PPC440 has software
assisted TLB but the problem with it seems to be too much tlb_flushes
not that it needs more exceptions.

(If somebody is interested to reproduce and experiment with it the
benchmarks and some results are available from here:
https://www.amigans.net/modules/newbb/viewtopic.php?topic_id=9226
some of the tests also have MorphOS versions that's easier to get than
AmigaOS or sources that could be compiled under Linux.)

Regards,
BALATON Zoltan

BALATON Zoltan (7):
  target/ppc: Remove single use function
  target/ppc: Remove "ext" parameter of ppcemb_tlb_check()
  target/ppc: Move ppcemb_tlb_search() to mmu_common.c
  target/ppc: Remove some unneded line breaks
  target/ppc: Simplify ppcemb_tlb_search()
  target/ppc: Change ppcemb_tlb_check() to return bool
  target/ppc: Eliminate goto in mmubooke_check_tlb()

 target/ppc/cpu.h        | 13 ++----
 target/ppc/mmu_common.c | 91 +++++++++++++++++++++++------------------
 target/ppc/mmu_helper.c | 32 +--------------
 3 files changed, 57 insertions(+), 79 deletions(-)

-- 
2.30.9


