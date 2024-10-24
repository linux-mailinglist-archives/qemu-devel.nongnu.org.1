Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1359ADBBE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Oct 2024 08:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3qzY-0002Xo-SX; Thu, 24 Oct 2024 02:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9NnO=RU=kaod.org=clg@ozlabs.org>)
 id 1t3qzT-0002VA-RR; Thu, 24 Oct 2024 02:06:36 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9NnO=RU=kaod.org=clg@ozlabs.org>)
 id 1t3qzQ-0008Hr-Vf; Thu, 24 Oct 2024 02:06:35 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XYwQd35lZz4wc4;
 Thu, 24 Oct 2024 17:06:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYwQW2f9Nz4w2F;
 Thu, 24 Oct 2024 17:06:11 +1100 (AEDT)
Message-ID: <84e64626-059e-4177-bd40-2bf8fa84e8f9@kaod.org>
Date: Thu, 24 Oct 2024 08:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] aspeed/smc: Fix write incorrect data into flash
 in user mode
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-2-jamin_lin@aspeedtech.com>
 <ZxeDVTBwLZsOEDvE@redhat.com> <b682dc55-f5e8-4fec-82f7-333dbaba240e@kaod.org>
 <ZxfDYWEyMLcnMXlh@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <ZxfDYWEyMLcnMXlh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9NnO=RU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/22/24 17:23, Kevin Wolf wrote:
> Am 22.10.2024 um 15:40 hat Cédric Le Goater geschrieben:
>>>>    static const VMStateDescription vmstate_aspeed_smc = {
>>>>        .name = "aspeed.smc",
>>>> -    .version_id = 2,
>>>> +    .version_id = 3,
>>>>        .minimum_version_id = 2,
>>>>        .fields = (const VMStateField[]) {
>>>>            VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
>>>>            VMSTATE_UINT8(snoop_index, AspeedSMCState),
>>>>            VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
>>>> +        VMSTATE_BOOL(unselect, AspeedSMCState),
>>>>            VMSTATE_END_OF_LIST()
>>>>        }
>>>>    };
>>>
>>> I think this will break migration compatibility. In order to enable
>>> at least forward migration, it should be:
>>>
>>>       VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
>>
>> This is correct. I will fix the patch.
>>
>> Some background,
>>
>> The aspeed machines are fully emulated and the Aspeed SoC models are not
>> part of any virt* machines (yet). So migration support is a bit of a
>> theory. We have done our best to maintain some support, compatibility
>> not being a priority. IOW, it's not perfectly tuned as on virt machines.
>>
>> Also, on ARM, migration of the CPU secure mode (I think this is the reason,
>> Peter please correct me !) is not supported and if migration is initiated
>> after Linux has started, the machine will hang.
> 
> That's a good reason not to implement backwards migration for now, it
> would only complicate things. But as long as we claim to be migratable
> by having VMStateDescriptions and even increasing version_id, we should
> at least try to keep that part correct.

Sure. Thanks for pointing that out.

>> However, if one day, an aspeed model becomes part of a virt machine, we
>> should be more careful. I would start by resetting all vmstate versions
>> to 1!
> 
> Why would you reset it? Keeping 3 (or whatever it will be by then) as
> the first serious supported version shouldn't hurt and probably avoids
> some confusion.
  OK . We'll see when we get to that point. Who knows. The Aspeed machines
have gotten much bigger than we expected !

C.

