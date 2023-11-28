Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9297FB25A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 08:09:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7sBn-0004Fz-Al; Tue, 28 Nov 2023 02:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org>)
 id 1r7sBk-0004FL-LL; Tue, 28 Nov 2023 02:07:20 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org>)
 id 1r7sBi-0002um-NB; Tue, 28 Nov 2023 02:07:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SfYRh4QYpz4wqN;
 Tue, 28 Nov 2023 18:07:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SfYRc4rrWz4wcJ;
 Tue, 28 Nov 2023 18:07:08 +1100 (AEDT)
Message-ID: <595c26d6-ef8f-443e-8192-3e73ee6b7d75@kaod.org>
Date: Tue, 28 Nov 2023 08:07:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-8.2] ppc/amigaone: Allow running AmigaOS without
 firmware image
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>, philmd@linaro.org
References: <20231125163425.3B3BC756078@zero.eik.bme.hu>
 <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
 <0eb18a77-af0e-a84b-764c-b435ea912a3d@eik.bme.hu>
 <CX9LVFYU6MBA.MLF4OMOCHE6K@wheely>
 <3f188a09-9927-4fc3-a4eb-0cde34934539@kaod.org>
 <CXA2ENP9VBT1.2THPXM7WFD3I3@wheely>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CXA2ENP9VBT1.2THPXM7WFD3I3@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/28/23 02:47, Nicholas Piggin wrote:
> On Tue Nov 28, 2023 at 2:37 AM AEST, Cédric Le Goater wrote:
>>
>>> I'm not sure, I don't think it's necessary if your minimal patch works.
>>>
>>> I'll do a PR for 8.2 for SLOF and Skiboot updates, so happy to include
>>> this as well.
>>
>> I think this is a bit late for 8.2 to change FW images, well, at least
>> SLOF and skiboot. Are the new versions fixing something critical ?
> 
> Ah okay. Well then I can put them in next instead.
> 
> SLOF has a fix for virtio console over reboots, pretty minimal.

I see that commit dd4d4ea0add9 has :

   Fixes: cf28264 ("virtio-serial: Rework shutdown sequence")

Looks good for 8.2

> skiboot has some bug fixes but it's a bigger change and maybe not
> so important for QEMU.> Could they be merged in next release 

yes. it seems skiboot should be merged with chiptod support in 9.0.

> and SLOF tagged with stable?
>
> I think this amigaone patch could still be merged since it's only
> touching a new machine and it's fixing an issue of missing firmware.

ARM does something similar with roms. See hw/arm/boot.c file.

It will need a "Fixes" tag.

Thanks,

C.


