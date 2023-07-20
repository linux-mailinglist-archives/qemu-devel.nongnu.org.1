Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C675B518
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:59:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWzc-0000OV-IJ; Thu, 20 Jul 2023 12:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2hVk=DG=kaod.org=clg@ozlabs.org>)
 id 1qMWzb-0000OM-5p
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:59:07 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2hVk=DG=kaod.org=clg@ozlabs.org>)
 id 1qMWzW-00059I-41
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:59:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4R6Jmx496lz4wy8;
 Fri, 21 Jul 2023 02:58:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6Jmv5c3Tz4wxx;
 Fri, 21 Jul 2023 02:58:55 +1000 (AEST)
Message-ID: <d0980c1a-0a0f-b0e0-01e1-3ffe6b0c77c9@kaod.org>
Date: Thu, 20 Jul 2023 18:58:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 3/4] hw/rtc/aspeed_rtc: Use 64-bit offset for
 holding time_t difference
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <20230720155902.1590362-4-peter.maydell@linaro.org>
 <e15250a2-3d21-d70b-980f-38d8165f0e30@kaod.org>
 <CAFEAcA9SmC+oN3wfoEfO-j6pms_0k-dmuuYCdLwVsHcQk_=hDA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAFEAcA9SmC+oN3wfoEfO-j6pms_0k-dmuuYCdLwVsHcQk_=hDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=2hVk=DG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.096, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 7/20/23 18:45, Peter Maydell wrote:
> On Thu, 20 Jul 2023 at 17:42, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 7/20/23 17:59, Peter Maydell wrote:
>>> In the aspeed_rtc device we store a difference between two time_t
>>> values in an 'int'. This is not really correct when time_t could
>>> be 64 bits. Enlarge the field to 'int64_t'.
>>>
>>> This is a migration compatibility break for the aspeed boards.
>>> While we are changing the vmstate, remove the accidental
>>> duplicate of the offset field.
>>
>> Ah yes. Thanks.
>>
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>
>>
>>> ---
>>> I took "bump the migration version" as the simplest approach
>>> here, because I don't think we care about migration compat
>>> in this case. If we do I can write the alternate version of
>>> the patch...
>>
>>
>> I don't think we care much about migration compat and fyi, migration
>> of aspeed machines broke a while ago. It still migrates if done before
>> Linux is loaded.
> 
> Is that the "migration of AArch32 Secure state doesn't work
> properly" bug, or am I misremembering?

probably, arm926 is not impacted, arm1176 and cortex-a7 are.

C.

