Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8EA73E0C9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmO3-0002Hc-Bu; Mon, 26 Jun 2023 09:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDmNy-0002HD-7O; Mon, 26 Jun 2023 09:36:06 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDmNv-0002C6-Ex; Mon, 26 Jun 2023 09:36:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqTPp0KD8z4wZp;
 Mon, 26 Jun 2023 23:35:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqTPf5nwcz4wb7;
 Mon, 26 Jun 2023 23:35:50 +1000 (AEST)
Message-ID: <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
Date: Mon, 26 Jun 2023 15:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
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

On 6/23/23 14:37, Cédric Le Goater wrote:
> On 6/23/23 11:10, Peter Maydell wrote:
>> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> ppc has always silently ignored access to real (physical) addresses
>>> with nothing behind it, which can make debugging difficult at times.
>>>
>>> It looks like the way to handle this is implement the transaction
>>> failed call, which most target architectures do. Notably not x86
>>> though, I wonder why?
>>
>> Much of this is historical legacy. QEMU originally had no
>> concept of "the system outside the CPU returns some kind
>> of bus error and the CPU raises an exception for it".
>> This is turn is (I think) because the x86 PC doesn't do
>> that: you always get back some kind of response, I think
>> -1 on reads and writes ignored. We added the do_transaction_failed
>> hook largely because we wanted it to give more accurate
>> emulation of this kind of thing on Arm, but as usual with new
>> facilities we left the other architectures to do it themselves
>> if they wanted -- by default the behaviour remained the same.
>> Some architectures have picked it up; some haven't.
>>
>> The main reason it's a bit of a pain to turn the correct
>> handling on is because often boards don't actually implement
>> all the devices they're supposed to. For a pile of legacy Arm
>> boards, especially where we didn't have good test images,
>> we use the machine flag ignore_memory_transaction_failures to
>> retain the legacy behaviour. (This isn't great because it's
>> pretty much going to mean we have that flag set on those
>> boards forever because nobody is going to care enough to
>> investigate and test.)
>>
>>> Other question is, sometimes I guess it's nice to avoid crashing in
>>> order to try to quickly get past some unimplemented MMIO. Maybe a
>>> command line option or something could turn it off? It should
>>> probably be a QEMU-wide option if so, so that shouldn't hold this
>>> series up, I can propose a option for that if anybody is worried
>>> about it.
>>
>> I would not recommend going any further than maybe setting the
>> ignore_memory_transaction_failures flag for boards you don't
>> care about. (But in an ideal world, don't set it and deal with
>> any bug reports by implementing stub versions of missing devices.
>> Depends how confident you are in your test coverage.)
> 
> It seems it broke the "mac99" and  powernv10 machines, using the
> qemu-ppc-boot images which are mostly buildroot. See below for logs.
> 
> Adding Mark for further testing on Mac OS.
  

Mac OS 9.2 fails to boot with a popup saying :
        
         Sorry, a system error occured.
         "Sound Manager"
           address error
         To temporarily turn off extensions, restart and
         hold down the shift key


Darwin and Mac OSX look OK.


Thanks,

C.



