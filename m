Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD97FEFE9
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 14:19:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8gvx-0008E2-Jr; Thu, 30 Nov 2023 08:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r8gvt-0008CG-PZ; Thu, 30 Nov 2023 08:18:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r8gvs-0003CC-4k; Thu, 30 Nov 2023 08:18:21 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2AD3275A4C4;
 Thu, 30 Nov 2023 14:18:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id T_wA2zeOEYia; Thu, 30 Nov 2023 14:18:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4063975A4C3; Thu, 30 Nov 2023 14:18:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3E4D075A4C7;
 Thu, 30 Nov 2023 14:18:16 +0100 (CET)
Date: Thu, 30 Nov 2023 14:18:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, philmd@linaro.org
Subject: Re: [PATCH v3] ppc/amigaone: Allow running AmigaOS without firmware
 image
In-Reply-To: <CXC3H0PGQZEG.1QL49XWJNHLL6@wheely>
Message-ID: <4299c2d3-3321-b551-4627-573bcb3c769d@eik.bme.hu>
References: <20231128013253.80524756078@zero.eik.bme.hu>
 <8df98507-3b2f-426e-ab25-f571f06c769b@kaod.org>
 <356aadfe-98d6-1b31-46e1-4d01ceedd477@eik.bme.hu>
 <CXC3H0PGQZEG.1QL49XWJNHLL6@wheely>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-494487108-1701350296=:60650"
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

--3866299591-494487108-1701350296=:60650
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2023, Nicholas Piggin wrote:
> On Thu Nov 30, 2023 at 8:49 AM AEST, BALATON Zoltan wrote:
>> On Tue, 28 Nov 2023, Cédric Le Goater wrote:
>>> On 11/28/23 02:32, BALATON Zoltan wrote:
>>>> The machine uses a modified U-Boot under GPL license but the sources
>>>> of it are lost with only a binary available so it cannot be included
>>>> in QEMU. Allow running without the firmware image which can be used
>>>> when calling a boot loader directly and thus simplifying booting
>>>> guests. We need a small routine that AmigaOS calls from ROM which is
>>>> added in this case to allow booting AmigaOS without external firmware
>>>> image.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>
>>> Since this is 8.2 material :
>>>
>>>
>>> Fixes: d9656f860a38 ("hw/ppc: Add emulation of AmigaOne XE board")
>>
>> This has missed rc2 but I hope there still will be a pull request before
>> rc3 which is the last chance now. I've sent a v4 which simpilifies the
>
> Sigh, yes a few hiccups but I will send a PR with your v3 and a SLOF
> update.
>
>> inserted code as I've found there's no need to do it like in the rom as
>> the only place it's called from just cares about the result.
>>
>> I forgot the Fixes tag again, sorry, but the one above is still the same.
>
> That's okay I added it. I'll just keep v3 since I have done some
> tests with it. If it matches the the old rom then it seems like
> a good starting point anyway, can always patch it later.

The only change is the code in it so it should not change any test results 
but v3 could work too, it just now seems unnecessary to include that much 
code when the short version is the same. Anyway, eiher v3 or v4 is OK.

Regards,
BALATON Zoltan
--3866299591-494487108-1701350296=:60650--

