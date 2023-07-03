Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E95745CB8
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJ9k-0005Gv-1p; Mon, 03 Jul 2023 08:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJ9C-0005DK-1f; Mon, 03 Jul 2023 08:59:25 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJ9A-0002L3-65; Mon, 03 Jul 2023 08:59:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QvmG71H8Zz4wqX;
 Mon,  3 Jul 2023 22:59:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvmG44G4dz4wZp;
 Mon,  3 Jul 2023 22:59:08 +1000 (AEST)
Message-ID: <5d0bce5a-244d-302e-8437-fe5f66787e74@kaod.org>
Date: Mon, 3 Jul 2023 14:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] ppc/pnv: SMT support for powernv
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230703101700.24064-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230703101700.24064-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/3/23 12:16, Nicholas Piggin wrote:
> These patches implement enough to install a distro, boot, run SMP KVM
> guests with libvirt with good performance using MTTCG (as reported by
> Cedric).
> 
> There are a few more SPRs that need to be done, and per-LPAR SPRs are
> mostly not annotated yet so it can't run in 1 LPAR mode. But those can
> be added in time, it will take a bit of time to get everything exactly
> as hardware does so I consider this good enough to run common
> software usefully.
> 
> Thanks Joel and Cedric for reviews and testing.
> 
> Since RFC:
> - Rebased against ppc-next (no conflicts vs upstream anyway).
> - Add patch 4 avocado boot test with SMT, as was added with pseries SMT.
> - Renamed POWERPC_FLAG_1LPAR to POWERPC_FLAG_SMT_1LPAR since it implies
>    SMT.
> - Fixed typos, patch 1, 3 changelogs improvement (hopefully).

Since you should resend for the clang breakage, could you please update
the CAVEATS section in docs/system/ppc/powernv.rst also ?

pseries documentation will need a similar update. Not sure where though.

Thanks,

C.


> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    target/ppc: Add LPAR-per-core vs per-thread mode flag
>    target/ppc: SMT support for the HID SPR
>    ppc/pnv: SMT support for powernv
>    tests/avocado: Add powernv machine test script
> 
>   hw/ppc/pnv.c                 | 12 +++++
>   hw/ppc/pnv_core.c            | 13 +++---
>   hw/ppc/spapr_cpu_core.c      |  2 +
>   target/ppc/cpu.h             |  3 ++
>   target/ppc/cpu_init.c        | 14 +++++-
>   target/ppc/helper.h          |  1 +
>   target/ppc/misc_helper.c     | 21 +++++++++
>   target/ppc/spr_common.h      |  1 +
>   target/ppc/translate.c       | 32 ++++++++++++--
>   tests/avocado/ppc_powernv.py | 86 ++++++++++++++++++++++++++++++++++++
>   10 files changed, 173 insertions(+), 12 deletions(-)
>   create mode 100644 tests/avocado/ppc_powernv.py
> 


