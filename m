Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 948217404F9
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 22:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFHI-00054N-Px; Tue, 27 Jun 2023 16:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEFHF-00053L-LC; Tue, 27 Jun 2023 16:27:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEFHD-0007Ec-6k; Tue, 27 Jun 2023 16:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2eZWg1LqA+pfuL7MGmIDT5W3d3AB+fo/HVZu2T0oriQ=; b=La9Lqi6Vyeqqoa6vnkUVtBcuYR
 cghuWm8HSrCrdqXAr4Lb3Jjfz8H58fqgDV0AV+QsJwRdbArXhNNI41KHfiZIueZbe681SidqL3kIz
 2yu6wUYPUaRUkfvvHCavRg1dVaNVvtG+2p4l0oWoomFazhwOwfFunUSrTEk7ayuXYXyB6Z0R6FmVf
 MJoe48B2FCor8EzCANR3I2BUKiB82ZHupLiaoLBweH2DiEFCJqyCS/iBVEXpKOs6hO0AglclsBEoG
 CLQSPVvgHlm8lF//RThoqzdLNGjEEtCFZPAUUPiXPfRsN0JVAbkKx4iMxnR9nK1UMWQpVf66P7WrF
 bvIWQrgp6G9KEmEfwBM2Y9oaqvpRQcQOBkeSNZWQudRkKKWBRU2aCnLpmd9E9qld1PYH05VqO5r+I
 R7WYGsz7pJyZuEn8vhZ+GGgMj3RGG2Y1xkfE6LHte7a3hyeOYev1p3WBcXmLL0HWfmAaaNI1icfAr
 I0rFHPj6yvkQdC3nypjOJVwSPxKdHNAy7ddE8qnigL/b+Jc9bTHJfgcZu30NWMxJV9qHWfhOD1oNj
 jzjySRLtlbSNMJTcLYRJhvms6jNbMFFFCV/wf5Q2pSMaJSzFEGubia5bwc9OQpdruY3fUChsLjL3y
 ESk62/DMdXcQAB9DgGjDgq3TWumFBGqAhNQzkV14g=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEFGw-0006lK-OJ; Tue, 27 Jun 2023 21:26:50 +0100
Message-ID: <840c34e7-0f5c-89fa-2dfa-f8de3da4d643@ilande.co.uk>
Date: Tue, 27 Jun 2023 21:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
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
 <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
 <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
 <d9b7499f-f462-79b3-e9e8-25a14a3b538d@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <d9b7499f-f462-79b3-e9e8-25a14a3b538d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
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

On 27/06/2023 13:41, Cédric Le Goater wrote:

> On 6/27/23 14:05, Howard Spoelstra wrote:
>>
>>
>> On Tue, Jun 27, 2023 at 1:24 PM Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk 
>> <mailto:mark.cave-ayland@ilande.co.uk>> wrote:
>>
>>     On 27/06/2023 11:28, Howard Spoelstra wrote:
>>
>>      > On Tue, Jun 27, 2023 at 10:15 AM Mark Cave-Ayland 
>> <mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.co.uk>
>>      > <mailto:mark.cave-ayland@ilande.co.uk 
>> <mailto:mark.cave-ayland@ilande.co.uk>>> wrote:
>>      >
>>      >     On 26/06/2023 14:35, Cédric Le Goater wrote:
>>      >
>>      >      > On 6/23/23 14:37, Cédric Le Goater wrote:
>>      >      >> On 6/23/23 11:10, Peter Maydell wrote:
>>      >      >>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com 
>> <mailto:npiggin@gmail.com>
>>      >     <mailto:npiggin@gmail.com <mailto:npiggin@gmail.com>>> wrote:
>>      >      >>>>
>>      >      >>>> ppc has always silently ignored access to real (physical) addresses
>>      >      >>>> with nothing behind it, which can make debugging difficult at times.
>>      >      >>>>
>>      >      >>>> It looks like the way to handle this is implement the transaction
>>      >      >>>> failed call, which most target architectures do. Notably not x86
>>      >      >>>> though, I wonder why?
>>      >      >>>
>>      >      >>> Much of this is historical legacy. QEMU originally had no
>>      >      >>> concept of "the system outside the CPU returns some kind
>>      >      >>> of bus error and the CPU raises an exception for it".
>>      >      >>> This is turn is (I think) because the x86 PC doesn't do
>>      >      >>> that: you always get back some kind of response, I think
>>      >      >>> -1 on reads and writes ignored. We added the do_transaction_failed
>>      >      >>> hook largely because we wanted it to give more accurate
>>      >      >>> emulation of this kind of thing on Arm, but as usual with new
>>      >      >>> facilities we left the other architectures to do it themselves
>>      >      >>> if they wanted -- by default the behaviour remained the same.
>>      >      >>> Some architectures have picked it up; some haven't.
>>      >      >>>
>>      >      >>> The main reason it's a bit of a pain to turn the correct
>>      >      >>> handling on is because often boards don't actually implement
>>      >      >>> all the devices they're supposed to. For a pile of legacy Arm
>>      >      >>> boards, especially where we didn't have good test images,
>>      >      >>> we use the machine flag ignore_memory_transaction_failures to
>>      >      >>> retain the legacy behaviour. (This isn't great because it's
>>      >      >>> pretty much going to mean we have that flag set on those
>>      >      >>> boards forever because nobody is going to care enough to
>>      >      >>> investigate and test.)
>>      >      >>>
>>      >      >>>> Other question is, sometimes I guess it's nice to avoid crashing in
>>      >      >>>> order to try to quickly get past some unimplemented MMIO. Maybe a
>>      >      >>>> command line option or something could turn it off? It should
>>      >      >>>> probably be a QEMU-wide option if so, so that shouldn't hold this
>>      >      >>>> series up, I can propose a option for that if anybody is worried
>>      >      >>>> about it.
>>      >      >>>
>>      >      >>> I would not recommend going any further than maybe setting the
>>      >      >>> ignore_memory_transaction_failures flag for boards you don't
>>      >      >>> care about. (But in an ideal world, don't set it and deal with
>>      >      >>> any bug reports by implementing stub versions of missing devices.
>>      >      >>> Depends how confident you are in your test coverage.)
>>      >      >>
>>      >      >> It seems it broke the "mac99" and  powernv10 machines, using the
>>      >      >> qemu-ppc-boot images which are mostly buildroot. See below for logs.
>>      >      >>
>>      >      >> Adding Mark for further testing on Mac OS.
>>      >      >
>>      >      >
>>      >      > Mac OS 9.2 fails to boot with a popup saying :
>>      >      >          Sorry, a system error occured.
>>      >      >          "Sound Manager"
>>      >      >            address error
>>      >      >          To temporarily turn off extensions, restart and
>>      >      >          hold down the shift key
>>      >      >
>>      >      >
>>      >      > Darwin and Mac OSX look OK.
>>      >
>>      >     My guess would be that MacOS 9.2 is trying to access the sound chip 
>> registers which
>>      >     isn't implemented in QEMU for the moment (I have a separate screamer branch
>>      >     available, but it's not ready for primetime yet). In theory they 
>> shouldn't be
>>      >     accessed at all because the sound device isn't present in the OpenBIOS 
>> device tree,
>>      >     but this is all fairly old stuff.
>>      >
>>      >     Does implementing the sound registers using a dummy device help at all?
>>      >
>>      >
>>      > My uneducated guess is that you stumbled on a longstanding, but intermittently
>>      > occurring, issue specific to Mac OS 9.2 related to sound support over USB in 
>> Apple
>>      > monitors.
>>
>>     I'm not sure I understand this: are there non-standard command line options being
>>     used here other than "qemu-system-ppc -M mac99 -cdrom macos92.iso -boot d"?
>>
>>
>>
>> It must be my windows host ;-)
>>
>> qemu-system-ppc.exe -M mac99,via=pmu -cdrom C:\mac-iso\9.2.2.iso -boot d -L pc-bios
>> crashes Mac OS with an address error. (with unpatched and patched builds).
> 
> Same on Linux. I get an invalid opcode. QEMU 7.2 work fine though.
> 
> C.

That certainly shouldn't happen, and if it worked in 7.2 then there's definitely a 
regression which has crept in there somewhere. I'll try and bisect this at some point 
soon, but feel free to try and beat me ;)


ATB,

Mark.


