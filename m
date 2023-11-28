Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D071C7FBA51
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 13:41:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xOA-0003Hl-KE; Tue, 28 Nov 2023 07:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7xO3-0003Fg-Kc; Tue, 28 Nov 2023 07:40:24 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7xO0-0004uy-AJ; Tue, 28 Nov 2023 07:40:22 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5BDE575607B;
 Tue, 28 Nov 2023 13:40:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rb4QOIQnQZcY; Tue, 28 Nov 2023 13:40:14 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 704F4756078; Tue, 28 Nov 2023 13:40:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6E89F756066;
 Tue, 28 Nov 2023 13:40:14 +0100 (CET)
Date: Tue, 28 Nov 2023 13:40:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 philmd@linaro.org
Subject: Re: [PATCH v2 for-8.2] ppc/amigaone: Allow running AmigaOS without
 firmware image
In-Reply-To: <595c26d6-ef8f-443e-8192-3e73ee6b7d75@kaod.org>
Message-ID: <f83f1d7b-90db-5244-9eb8-8fe7721d3b08@eik.bme.hu>
References: <20231125163425.3B3BC756078@zero.eik.bme.hu>
 <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
 <0eb18a77-af0e-a84b-764c-b435ea912a3d@eik.bme.hu>
 <CX9LVFYU6MBA.MLF4OMOCHE6K@wheely>
 <3f188a09-9927-4fc3-a4eb-0cde34934539@kaod.org>
 <CXA2ENP9VBT1.2THPXM7WFD3I3@wheely>
 <595c26d6-ef8f-443e-8192-3e73ee6b7d75@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-759484113-1701175214=:91084"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-759484113-1701175214=:91084
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Cédric Le Goater wrote:
> On 11/28/23 02:47, Nicholas Piggin wrote:
>> On Tue Nov 28, 2023 at 2:37 AM AEST, Cédric Le Goater wrote:
>>> 
>>>> I'm not sure, I don't think it's necessary if your minimal patch works.
>>>> 
>>>> I'll do a PR for 8.2 for SLOF and Skiboot updates, so happy to include
>>>> this as well.
>>> 
>>> I think this is a bit late for 8.2 to change FW images, well, at least
>>> SLOF and skiboot. Are the new versions fixing something critical ?
>> 
>> Ah okay. Well then I can put them in next instead.
>> 
>> SLOF has a fix for virtio console over reboots, pretty minimal.
>
> I see that commit dd4d4ea0add9 has :
>
>  Fixes: cf28264 ("virtio-serial: Rework shutdown sequence")
>
> Looks good for 8.2
>
>> skiboot has some bug fixes but it's a bigger change and maybe not
>> so important for QEMU.> Could they be merged in next release 
>
> yes. it seems skiboot should be merged with chiptod support in 9.0.
>
>> and SLOF tagged with stable?
>> 
>> I think this amigaone patch could still be merged since it's only
>> touching a new machine and it's fixing an issue of missing firmware.
>
> ARM does something similar with roms. See hw/arm/boot.c file.
>
> It will need a "Fixes" tag.

That would be

Fixes: d9656f860a38f83efc9710c515eab6a5b015134c

as the only commit for this machine so far was the one that added it.

Regards,
BALATON Zoltan
--3866299591-759484113-1701175214=:91084--

