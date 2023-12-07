Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B0808EEF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 18:41:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBIM2-0008PC-1j; Thu, 07 Dec 2023 12:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rBILt-0008OL-Od
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 12:39:58 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rBILq-00078r-3a
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 12:39:57 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A821975A4C2;
 Thu,  7 Dec 2023 18:39:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id McD21M8WIdH2; Thu,  7 Dec 2023 18:39:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C082D75A406; Thu,  7 Dec 2023 18:39:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BEED2756094;
 Thu,  7 Dec 2023 18:39:37 +0100 (CET)
Date: Thu, 7 Dec 2023 18:39:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: aziz tlili <aziztlili2222@gmail.com>
cc: qemu-devel@nongnu.org
Subject: Re: Request for New PPC Machine Supporting Multiple SMP Cores
In-Reply-To: <CAHwHw5A6g428uTpMEQ=NCkXP7sXVfCWv5QSUw3pHfncmG-2gPA@mail.gmail.com>
Message-ID: <5f2068a4-955a-9d16-347d-4d2771b78aa8@eik.bme.hu>
References: <CAHwHw5A6g428uTpMEQ=NCkXP7sXVfCWv5QSUw3pHfncmG-2gPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Thu, 7 Dec 2023, aziz tlili wrote:
> Dear QEMU Team,
>
> I hope this message finds you well. I've been a user of QEMU for well over
> a year.
>
> I wanted to share an idea for a potential enhancement that I believe could
> benefit many users, including myself. It would be fantastic to have a new
> PPC machine model similar to the existing mac99, but with support for
> multiple SMP cores for both qemu-system-ppc and qemu-system-ppc64.

There are several machines in qemu-system-ppc64 that support SMP such as 
pseries and powernv I think. For qemu-system-ppc maybe only ppce500. The 
mac99 may create multiple CPUs (G4 when ron with qemu-system-ppc or G5 
with qemu-system-ppc64) but not sure if there's an OS that can actually 
use that. Linux support for mac99 may not be the best.

> The ability to simulate multiple SMP cores within a PPC machine environment
> would significantly enhance the capabilities of QEMU for various
> applications, testing scenarios, and development purposes. This addition
> could greatly benefit the community working on PowerPC architecture.

Sure. Contributions are welcome.

> I understand the complexities involved in such developments but wanted to
> express the potential advantages and how this enhancement could contribute
> to expanding QEMU's capabilities.

Problem is not in understanding the potential advantages but the lack of 
people interested in working on that so progress depends on somebody doing 
it and sending patches.

Regards,
BALATON Zoltan

> Thank you for considering my suggestion. I would be more than happy to
> provide further details or collaborate in any way that could assist in
> making this idea a reality.
>
> Best regards,
> Aziz Tlili
>

