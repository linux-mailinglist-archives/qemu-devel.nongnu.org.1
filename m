Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F163A738C7C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1BF-0004Wm-48; Wed, 21 Jun 2023 12:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5utS=CJ=kaod.org=clg@ozlabs.org>)
 id 1qC1BC-0004Vo-VR; Wed, 21 Jun 2023 12:59:38 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5utS=CJ=kaod.org=clg@ozlabs.org>)
 id 1qC1BA-0004rM-Os; Wed, 21 Jun 2023 12:59:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QmV8y69wTz4wjF;
 Thu, 22 Jun 2023 02:59:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmV8w5hKQz4wgj;
 Thu, 22 Jun 2023 02:59:28 +1000 (AEST)
Message-ID: <2449d9af-c468-fb9a-2caa-5d4955bb64fb@kaod.org>
Date: Wed, 21 Jun 2023 18:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 05/29] pnv/xive2: Handle TIMA access through all ports
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org
References: <20230610133132.290703-1-danielhb413@gmail.com>
 <20230610133132.290703-6-danielhb413@gmail.com>
 <CAFEAcA_KKSc=Ns9n1UJKdnhZ846EGK-nFbsG_e2mw_zwMoOJcw@mail.gmail.com>
 <4ad1a081-bf98-1b7d-05c9-82c230da34ce@kaod.org>
 <9f71ffc4-2b37-d8b8-56c6-658d264242c4@linux.ibm.com>
 <c300d299-a90b-c29a-b556-83a2545adc30@kaod.org>
 <93480aa2-3639-1758-0395-a91bd7640099@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <93480aa2-3639-1758-0395-a91bd7640099@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5utS=CJ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/21/23 17:18, Frederic Barrat wrote:
> 
> 
> On 21/06/2023 09:18, Cédric Le Goater wrote:
>> The XIVE2 TM ops are implemented with a shortcut (See the TODO in
>> pnv_xive2_tm_*()). We could
>>
>> 1. extend xive_tctx_tm_write/read with a 'bool gen1_tima_os' parameter:
>>
>>      xive_tctx_tm_write(xptr, tctx, offset, value, size, gen1_tima_os);
>>
>>     and use the bool in xive_tm_find_op() to select a XiveTmOp array.
>>     The new xive2_tm_operations[] would be defined as xive_tm_operations[]
>>     but with an override of HV_PUSH_OS_CTX_OFFSET and HV_PULL_OS_CTX_OFFSET.
>>
>> 2. or extend the XivePresenterClass with a get_config() handler like it
>>     was done for Xive2RouterClass().
>>
>> 3. or introduce an array of XiveTmOp under XivePresenterClass defined by
>>     the controller variant.
>>
>> In any case, we need a new xive2_tm_operations[] for the XIVE2 TM register
>> layout. Option 1 is simpler I think.
> 
> 
> I was also leaning on introducing a xive2_tm_operations[] array of operations to fix it correctly.
> 
> While I agree it's the simplest, I'm not fond of (1), since we'd need to carry that extra parameter to xive_tm_find_op(). Admittedly it's just one extra level, but I went with something which is hopefully what you had in mind for (2). 

It is.

> I like that we can easily extend it in the future.

Yes. There are new  bits in the Gen2 TM layout that might need an
implementation for other workloads than OPAL/Linux. Having a second
array will help.
  

>> This would  also "fix" the indirect ops in XIVE2, not that we care much
>> but it will be cleaner.
> 
> I'm not sure I see what you mean here. It cleans up nicely pnv_xive2_tm_read/write(), but is that really what you had in mind?

yes.

I meant that indirect ops in XIVE2 didn't bother testing Gen1/Gen2.

> 
> 
> Something related I notice is that when doing an indirect access to the TIMA through the IC BAR, we call the TIMA access functions with a NULL reference to the presenter:

Yes. I don't remember why. May be because it was not important at
the time.

> 
> static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
>                                                unsigned size)
> {
>      PnvXive2 *xive = PNV_XIVE2(opaque);
> ...
>      tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>      if (tctx) {
>          val = xive_tctx_tm_read(NULL, tctx, offset, size);
>      }
> 
> We seem to mostly ignore that first parameter in xive_tctx_tm_read/write(). IIUC, the special ops will be checked with a page offset matching ring 0 and won't match anything. Still, it seems a bit dangerous and I was wondering:
> 1. can't we just create it from the PnvXive2 we have at hand?

we could.

> 2. in any case, isn't it always redundant with tctxt->presenter?

it is. it should be the same. May add an assert in pnv_xive2_get_indirect_tctx()
if they are different.


Thanks,

C.


> 
>    Fred


