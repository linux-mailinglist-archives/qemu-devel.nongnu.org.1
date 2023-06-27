Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5B73FB15
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6o3-0007fc-MA; Tue, 27 Jun 2023 07:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE6o1-0007en-LE; Tue, 27 Jun 2023 07:24:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE6nw-0006yK-Hy; Tue, 27 Jun 2023 07:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fue0aP81KLULsewOrB74oqqM2nUnLi6Pv5PrufRP2yg=; b=voL7MnULYnGbD/U4wQwfopkTY4
 Lpgw9sgaPiuEc6ULVXOdGoMXivZVVokNtr+7Op4nM/yP6X3YsorB33b0C4YpWPIcF7WGX+WfZWcEe
 RkioZJpsTM3RkSiD139KZCy5pIWw9QQk0ygYh/Hhd9VxKby9MRvM/7RLSq1Cb01UDEuhnHd5VH4R+
 dYvqvvBpXNzi5h9GlYWIaapw+NCq1dcf6ECmgYODccApP21CzoGw7ZjFNDO3bLwHdN0PCxDruI6kS
 YW0W4wqqAGEyMYyNifsQOd3TXQFvSi6shStVSS2y9pcTsgd9tRY/gLyXii10lsdFqynq0aHdJ6bc0
 j1XqB8sNzeMxfZ2L7I5d+OopbDVMZjsFkOmjxFmeg6P1u8TfgK39fFcc2cAAOcqlSX0AEuwZXa/dO
 SxawLgDTb3tgvcbPyKwfhITZIOtPMipL8AC6PIkYoAj4hjIqHtaen50XhzGG0HkEqwRLxP/fAm8fj
 ODTVK0bj4gt9QUboq7ZeU4c9AWD2aPdu9SiLUuwypbcGjdy1MlLwMf23Yaknd73L96+GO6a44qJSn
 NDoKhxAIK0isWzmzWIhAvk9oaxWpGWy2PK7HBQ6gd/pwjpdPTYcN+zdW3LwfiU5HTIy5GKdnVYPi8
 Q5dSmy/N+ZSFofRBWDuXPANglIWvPFPHIV59WX1qw=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE6nf-0003Wq-Jk; Tue, 27 Jun 2023 12:24:03 +0100
Message-ID: <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
Date: Tue, 27 Jun 2023 12:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
 <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 27/06/2023 11:28, Howard Spoelstra wrote:

> On Tue, Jun 27, 2023 at 10:15 AM Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk 
> <mailto:mark.cave-ayland@ilande.co.uk>> wrote:
> 
>     On 26/06/2023 14:35, Cédric Le Goater wrote:
> 
>      > On 6/23/23 14:37, Cédric Le Goater wrote:
>      >> On 6/23/23 11:10, Peter Maydell wrote:
>      >>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com
>     <mailto:npiggin@gmail.com>> wrote:
>      >>>>
>      >>>> ppc has always silently ignored access to real (physical) addresses
>      >>>> with nothing behind it, which can make debugging difficult at times.
>      >>>>
>      >>>> It looks like the way to handle this is implement the transaction
>      >>>> failed call, which most target architectures do. Notably not x86
>      >>>> though, I wonder why?
>      >>>
>      >>> Much of this is historical legacy. QEMU originally had no
>      >>> concept of "the system outside the CPU returns some kind
>      >>> of bus error and the CPU raises an exception for it".
>      >>> This is turn is (I think) because the x86 PC doesn't do
>      >>> that: you always get back some kind of response, I think
>      >>> -1 on reads and writes ignored. We added the do_transaction_failed
>      >>> hook largely because we wanted it to give more accurate
>      >>> emulation of this kind of thing on Arm, but as usual with new
>      >>> facilities we left the other architectures to do it themselves
>      >>> if they wanted -- by default the behaviour remained the same.
>      >>> Some architectures have picked it up; some haven't.
>      >>>
>      >>> The main reason it's a bit of a pain to turn the correct
>      >>> handling on is because often boards don't actually implement
>      >>> all the devices they're supposed to. For a pile of legacy Arm
>      >>> boards, especially where we didn't have good test images,
>      >>> we use the machine flag ignore_memory_transaction_failures to
>      >>> retain the legacy behaviour. (This isn't great because it's
>      >>> pretty much going to mean we have that flag set on those
>      >>> boards forever because nobody is going to care enough to
>      >>> investigate and test.)
>      >>>
>      >>>> Other question is, sometimes I guess it's nice to avoid crashing in
>      >>>> order to try to quickly get past some unimplemented MMIO. Maybe a
>      >>>> command line option or something could turn it off? It should
>      >>>> probably be a QEMU-wide option if so, so that shouldn't hold this
>      >>>> series up, I can propose a option for that if anybody is worried
>      >>>> about it.
>      >>>
>      >>> I would not recommend going any further than maybe setting the
>      >>> ignore_memory_transaction_failures flag for boards you don't
>      >>> care about. (But in an ideal world, don't set it and deal with
>      >>> any bug reports by implementing stub versions of missing devices.
>      >>> Depends how confident you are in your test coverage.)
>      >>
>      >> It seems it broke the "mac99" and  powernv10 machines, using the
>      >> qemu-ppc-boot images which are mostly buildroot. See below for logs.
>      >>
>      >> Adding Mark for further testing on Mac OS.
>      >
>      >
>      > Mac OS 9.2 fails to boot with a popup saying :
>      >          Sorry, a system error occured.
>      >          "Sound Manager"
>      >            address error
>      >          To temporarily turn off extensions, restart and
>      >          hold down the shift key
>      >
>      >
>      > Darwin and Mac OSX look OK.
> 
>     My guess would be that MacOS 9.2 is trying to access the sound chip registers which
>     isn't implemented in QEMU for the moment (I have a separate screamer branch
>     available, but it's not ready for primetime yet). In theory they shouldn't be
>     accessed at all because the sound device isn't present in the OpenBIOS device tree,
>     but this is all fairly old stuff.
> 
>     Does implementing the sound registers using a dummy device help at all?
> 
> 
> My uneducated guess is that you stumbled on a longstanding, but intermittently 
> occurring, issue specific to Mac OS 9.2 related to sound support over USB in Apple 
> monitors.

I'm not sure I understand this: are there non-standard command line options being 
used here other than "qemu-system-ppc -M mac99 -cdrom macos92.iso -boot d"?

> I believe It is not fixed by the patch set from the 23 of june, I still get system 
> errors when running Mac OS 9.2 with the mac99 machine after applying them.
> Mac OS 9.2 has required mac99,via=pmu for a long time now to always boot 
> successfully. (while 9.0.4 requires mac99 to boot, due to an undiagnosed OHCI USB 
> problem with the specific drivers that ship with it.)  ;-)

I always test MacOS 9.2 boot both with and without via=pmu for my OpenBIOS tests, so 
I'd expect this to work unless a regression has slipped in?


ATB,

Mark.


