Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D77E4818
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:19:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qey-0007Ya-Fo; Tue, 07 Nov 2023 13:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0Qeo-0007YI-O2; Tue, 07 Nov 2023 13:18:34 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0Qel-0004di-VX; Tue, 07 Nov 2023 13:18:34 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8518275A4BC;
 Tue,  7 Nov 2023 19:18:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 794FC75A4B8; Tue,  7 Nov 2023 19:18:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 77A1775A4B7;
 Tue,  7 Nov 2023 19:18:44 +0100 (CET)
Date: Tue, 7 Nov 2023 19:18:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
In-Reply-To: <CAFEAcA-r+KkrM2RJ--OPC6MhpmfkHitBpwpXKUbvzD3ts4hAbw@mail.gmail.com>
Message-ID: <7757c836-f40c-8bcd-fc9a-187654c497d4@eik.bme.hu>
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <697ad2e0-cb23-4efe-89e5-d1b521c0648f@gmail.com>
 <b6ff86da-2532-708a-6737-4489d260c8a7@eik.bme.hu>
 <fa33a840-2135-4ba8-9db1-6684275e93c3@gmail.com>
 <092437de-efef-1c1c-00f5-8667792c5226@eik.bme.hu>
 <4cc81579-1b3c-1373-eeb2-0c941b06c5a1@eik.bme.hu>
 <CAFEAcA-r+KkrM2RJ--OPC6MhpmfkHitBpwpXKUbvzD3ts4hAbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
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

On Tue, 7 Nov 2023, Peter Maydell wrote:
> On Tue, 7 Nov 2023 at 18:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> So if it's tests/qtest/test-hmp.c that seems to try to run a bunch of
>> command for each machine AFAIU. This machine needs a firmware image but
>> this test seems to run it with -S and never starts the machine so could
>> take any file with -bios for that, e.g. -bios vof.bin (thought about -bios
>> /dev/null but that does not work but any other file should probably be
>> OK). I don't know how to tell test-hmp to use that thogh or to skip this
>> machine.
>>
>> At some point pegasos2 also needed a firmware but this wasn't a problem
>> back then. Either this test is new or we could just ignore this error?
>
> The test has been around for a long time, and no, you can't ignore
> 'make check' failures, they will break the CI. It's one of
> the tests we have that test properties that must be true for
> all board types (or all devices, in the case of some other
> tests). One of the properties is "it ought to start up cleanly
> without extra arguments".

I'll send a patch in a minute which hopefully fixes that skipping the exit 
when using qtest and called without -bios.

> pegasos2 works because there's a vof.bin for it in pc-bios/.

Now it has vof.bin but it did not have that previously and it still worked 
when it needed -bios too. But that was a while ago so don't remember the 
details.

Regards,
BALATON Zoltan

