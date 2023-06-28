Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F407740994
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPCY-0007EF-JV; Wed, 28 Jun 2023 03:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=C+FE=CQ=kaod.org=clg@ozlabs.org>)
 id 1qEPCV-00079l-Jq; Wed, 28 Jun 2023 03:02:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=C+FE=CQ=kaod.org=clg@ozlabs.org>)
 id 1qEPCS-0001q9-Qv; Wed, 28 Jun 2023 03:02:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QrXZx0kFbz4wp1;
 Wed, 28 Jun 2023 17:02:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QrXZq0dTZz4wp3;
 Wed, 28 Jun 2023 17:02:26 +1000 (AEST)
Message-ID: <7e596b48-c631-34d5-2b63-0aac1922de93@kaod.org>
Date: Wed, 28 Jun 2023 09:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
 <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
 <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
 <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
 <d9b7499f-f462-79b3-e9e8-25a14a3b538d@redhat.com>
 <840c34e7-0f5c-89fa-2dfa-f8de3da4d643@ilande.co.uk>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <840c34e7-0f5c-89fa-2dfa-f8de3da4d643@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=C+FE=CQ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.103, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/27/23 22:26, Mark Cave-Ayland wrote:
> On 27/06/2023 13:41, Cédric Le Goater wrote:
> 
>> On 6/27/23 14:05, Howard Spoelstra wrote:
>>>
>>>
>>> On Tue, Jun 27, 2023 at 1:24 PM Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.co.uk>> wrote:
>>>
>>>     On 27/06/2023 11:28, Howard Spoelstra wrote:
>>>
>>>      > On Tue, Jun 27, 2023 at 10:15 AM Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.co.uk>
>>>      > <mailto:mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.co.uk>>> wrote:
>>>      >
>>>      >     On 26/06/2023 14:35, Cédric Le Goater wrote:
>>>      >
>>>      >      > On 6/23/23 14:37, Cédric Le Goater wrote:
>>>      >      >> On 6/23/23 11:10, Peter Maydell wrote:
>>>      >      >>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com <mailto:npiggin@gmail.com>
>>>      >     <mailto:npiggin@gmail.com <mailto:npiggin@gmail.com>>> wrote:
>>>      >      >>>>
>>>      >      >>>> ppc has always silently ignored access to real (physical) addresses
>>>      >      >>>> with nothing behind it, which can make debugging difficult at times.
>>>      >      >>>>
>>>      >      >>>> It looks like the way to handle this is implement the transaction
>>>      >      >>>> failed call, which most target architectures do. Notably not x86
>>>      >      >>>> though, I wonder why?
>>>      >      >>>
>>>      >      >>> Much of this is historical legacy. QEMU originally had no
>>>      >      >>> concept of "the system outside the CPU returns some kind
>>>      >      >>> of bus error and the CPU raises an exception for it".
>>>      >      >>> This is turn is (I think) because the x86 PC doesn't do
>>>      >      >>> that: you always get back some kind of response, I think
>>>      >      >>> -1 on reads and writes ignored. We added the do_transaction_failed
>>>      >      >>> hook largely because we wanted it to give more accurate
>>>      >      >>> emulation of this kind of thing on Arm, but as usual with new
>>>      >      >>> facilities we left the other architectures to do it themselves
>>>      >      >>> if they wanted -- by default the behaviour remained the same.
>>>      >      >>> Some architectures have picked it up; some haven't.
>>>      >      >>>
>>>      >      >>> The main reason it's a bit of a pain to turn the correct
>>>      >      >>> handling on is because often boards don't actually implement
>>>      >      >>> all the devices they're supposed to. For a pile of legacy Arm
>>>      >      >>> boards, especially where we didn't have good test images,
>>>      >      >>> we use the machine flag ignore_memory_transaction_failures to
>>>      >      >>> retain the legacy behaviour. (This isn't great because it's
>>>      >      >>> pretty much going to mean we have that flag set on those
>>>      >      >>> boards forever because nobody is going to care enough to
>>>      >      >>> investigate and test.)
>>>      >      >>>
>>>      >      >>>> Other question is, sometimes I guess it's nice to avoid crashing in
>>>      >      >>>> order to try to quickly get past some unimplemented MMIO. Maybe a
>>>      >      >>>> command line option or something could turn it off? It should
>>>      >      >>>> probably be a QEMU-wide option if so, so that shouldn't hold this
>>>      >      >>>> series up, I can propose a option for that if anybody is worried
>>>      >      >>>> about it.
>>>      >      >>>
>>>      >      >>> I would not recommend going any further than maybe setting the
>>>      >      >>> ignore_memory_transaction_failures flag for boards you don't
>>>      >      >>> care about. (But in an ideal world, don't set it and deal with
>>>      >      >>> any bug reports by implementing stub versions of missing devices.
>>>      >      >>> Depends how confident you are in your test coverage.)
>>>      >      >>
>>>      >      >> It seems it broke the "mac99" and  powernv10 machines, using the
>>>      >      >> qemu-ppc-boot images which are mostly buildroot. See below for logs.
>>>      >      >>
>>>      >      >> Adding Mark for further testing on Mac OS.
>>>      >      >
>>>      >      >
>>>      >      > Mac OS 9.2 fails to boot with a popup saying :
>>>      >      >          Sorry, a system error occured.
>>>      >      >          "Sound Manager"
>>>      >      >            address error
>>>      >      >          To temporarily turn off extensions, restart and
>>>      >      >          hold down the shift key
>>>      >      >
>>>      >      >
>>>      >      > Darwin and Mac OSX look OK.
>>>      >
>>>      >     My guess would be that MacOS 9.2 is trying to access the sound chip registers which
>>>      >     isn't implemented in QEMU for the moment (I have a separate screamer branch
>>>      >     available, but it's not ready for primetime yet). In theory they shouldn't be
>>>      >     accessed at all because the sound device isn't present in the OpenBIOS device tree,
>>>      >     but this is all fairly old stuff.
>>>      >
>>>      >     Does implementing the sound registers using a dummy device help at all?
>>>      >
>>>      >
>>>      > My uneducated guess is that you stumbled on a longstanding, but intermittently
>>>      > occurring, issue specific to Mac OS 9.2 related to sound support over USB in Apple
>>>      > monitors.
>>>
>>>     I'm not sure I understand this: are there non-standard command line options being
>>>     used here other than "qemu-system-ppc -M mac99 -cdrom macos92.iso -boot d"?
>>>
>>>
>>>
>>> It must be my windows host ;-)
>>>
>>> qemu-system-ppc.exe -M mac99,via=pmu -cdrom C:\mac-iso\9.2.2.iso -boot d -L pc-bios
>>> crashes Mac OS with an address error. (with unpatched and patched builds).
>>
>> Same on Linux. I get an invalid opcode. QEMU 7.2 work fine though.
>>
>> C.
> 
> That certainly shouldn't happen, and if it worked in 7.2 then there's definitely a regression which has crept in there somewhere. I'll try and bisect this at some point soon, but feel free to try and beat me ;)

bisect points to :

commit e506ad6a05c806bbef460a7d014a184ff8d707a6
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Mar 6 04:30:11 2023 +0300

     accel/tcg: Pass last not end to tb_invalidate_phys_range
     
     Pass the address of the last byte to be changed, rather than
     the first address past the last byte.  This avoids overflow
     when the last page of the address space is involved.
     
     Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

  include/exec/exec-all.h   |  2 +-
  accel/tcg/tb-maint.c      | 31 ++++++++++++++++---------------
  accel/tcg/translate-all.c |  2 +-
  accel/tcg/user-exec.c     |  2 +-
  softmmu/physmem.c         |  2 +-
  5 files changed, 20 insertions(+), 19 deletions(-)


I think the instruction is fnmadds. Needs more digging.

Thanks,

C.

