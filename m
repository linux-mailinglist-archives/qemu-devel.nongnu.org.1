Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111773CA4C
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 11:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCzuu-0003d6-3c; Sat, 24 Jun 2023 05:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qCzur-0003cp-Ji; Sat, 24 Jun 2023 05:50:49 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qCzuk-0001CC-Sx; Sat, 24 Jun 2023 05:50:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1B0C7748A77;
 Sat, 24 Jun 2023 11:50:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C8591748A76; Sat, 24 Jun 2023 11:50:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C50EF748A73;
 Sat, 24 Jun 2023 11:50:25 +0200 (CEST)
Date: Sat, 24 Jun 2023 11:50:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clegoate@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Frederic Barrat <frederic.barrat@fr.ibm.com>
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
In-Reply-To: <cf674f48-c083-9ad9-3801-8cbd37aecbb1@linaro.org>
Message-ID: <e9dd38cf-2dfd-a816-3b2d-4cbebc099727@eik.bme.hu>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <cf674f48-c083-9ad9-3801-8cbd37aecbb1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2033448452-1687600225=:42373"
X-Spam-Probability: 9%
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2033448452-1687600225=:42373
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 24 Jun 2023, Philippe Mathieu-Daudé wrote:
> On 23/6/23 14:37, Cédric Le Goater wrote:
>> On 6/23/23 11:10, Peter Maydell wrote:
>>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>> 
>>>> ppc has always silently ignored access to real (physical) addresses
>>>> with nothing behind it, which can make debugging difficult at times.
>>>> 
>>>> It looks like the way to handle this is implement the transaction
>>>> failed call, which most target architectures do. Notably not x86
>>>> though, I wonder why?
>>> 
>>> Much of this is historical legacy. QEMU originally had no
>>> concept of "the system outside the CPU returns some kind
>>> of bus error and the CPU raises an exception for it".
>>> This is turn is (I think) because the x86 PC doesn't do
>>> that: you always get back some kind of response, I think
>>> -1 on reads and writes ignored. We added the do_transaction_failed
>>> hook largely because we wanted it to give more accurate
>>> emulation of this kind of thing on Arm, but as usual with new
>>> facilities we left the other architectures to do it themselves
>>> if they wanted -- by default the behaviour remained the same.
>>> Some architectures have picked it up; some haven't.
>>> 
>>> The main reason it's a bit of a pain to turn the correct
>>> handling on is because often boards don't actually implement
>>> all the devices they're supposed to. For a pile of legacy Arm
>>> boards, especially where we didn't have good test images,
>>> we use the machine flag ignore_memory_transaction_failures to
>>> retain the legacy behaviour. (This isn't great because it's
>>> pretty much going to mean we have that flag set on those
>>> boards forever because nobody is going to care enough to
>>> investigate and test.)
>>> 
>>>> Other question is, sometimes I guess it's nice to avoid crashing in
>>>> order to try to quickly get past some unimplemented MMIO. Maybe a
>>>> command line option or something could turn it off? It should
>>>> probably be a QEMU-wide option if so, so that shouldn't hold this
>>>> series up, I can propose a option for that if anybody is worried
>>>> about it.
>>> 
>>> I would not recommend going any further than maybe setting the
>>> ignore_memory_transaction_failures flag for boards you don't
>>> care about. (But in an ideal world, don't set it and deal with
>>> any bug reports by implementing stub versions of missing devices.
>>> Depends how confident you are in your test coverage.)
>> 
>> It seems it broke the "mac99" and  powernv10 machines, using the
>> qemu-ppc-boot images which are mostly buildroot. See below for logs.
>
> Since commit 21786c7e59 ("softmmu/memory: Log invalid memory accesses")
> you can log the failed transaction with '-d guest_errors'. See for
> example commit a13bfa5a05 ("hw/mips/jazz: Map the UART devices

This reminds me I'd still want to split this from guest_errors as 
discussed here:

https://lists.nongnu.org/archive/html/qemu-devel/2023-02/msg08757.html

Can we get a decision on how to call these debug options?

> unconditionally"):
>
>  $ qemu-system-mips64el -M magnum -d guest_errors,unimp -bios NTPROM.RAW
>  Invalid access at addr 0x80007004, size 1, region '(null)', reason: 
> rejected
>  Invalid access at addr 0x80007001, size 1, region '(null)', reason: 
> rejected
>  Invalid access at addr 0x80007002, size 1, region '(null)', reason: 
> rejected
>  Invalid access at addr 0x80007003, size 1, region '(null)', reason: 
> rejected
>  Invalid access at addr 0x80007004, size 1, region '(null)', reason: 
> rejected
>
> Boards booting successfully with ignore_memory_transaction_failures
> set can often remove this flag by mapping missing accessed ranges as
> TYPE_UNIMPLEMENTED_DEVICE. (You can then log the same accesses using
> '-d unimp').

The mac99 may have a lot of unimplemented devices and they are also not 
quite documented so it may even be difficult to find where they should be.

Regards,
BALATON Zoltan
--3866299591-2033448452-1687600225=:42373--

