Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D991B7CDA40
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4gO-0000xI-W7; Wed, 18 Oct 2023 07:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qt4gI-0000vT-BT; Wed, 18 Oct 2023 07:25:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qt4gF-0005Eu-R3; Wed, 18 Oct 2023 07:25:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 38AC5756078;
 Wed, 18 Oct 2023 13:25:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ED857756062; Wed, 18 Oct 2023 13:25:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EB1DB75606C;
 Wed, 18 Oct 2023 13:25:31 +0200 (CEST)
Date: Wed, 18 Oct 2023 13:25:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, philmd@linaro.org, 
 Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [RFC PATCH v4 4/4] tests/avocado: Add test for amigaone board
In-Reply-To: <00f18d3d-f0b6-42cf-ae13-46c350e57689@kaod.org>
Message-ID: <467c0fad-aa60-c8fc-703d-7d05084b72ad@eik.bme.hu>
References: <cover.1697568616.git.balaton@eik.bme.hu>
 <dea7938f15c3231984546b12ccc8e3b8ba42a203.1697568616.git.balaton@eik.bme.hu>
 <80c9cc1a-7d5b-4840-8dd5-9cbaae51114a@redhat.com>
 <00f18d3d-f0b6-42cf-ae13-46c350e57689@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1471827360-1697628331=:90406"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1471827360-1697628331=:90406
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 18 Oct 2023, Cédric Le Goater wrote:
> On 10/18/23 07:58, Thomas Huth wrote:
>> Please add a short patch description if this moves from RFC to a real patch
>> 
>> On 17/10/2023 21.06, BALATON Zoltan wrote:
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> I have no idea if this works so testing and corrections are welcome
>> 
>> Why don't you test it on your own? I think this should be sufficient:
>>
>>   make check-avocado AVOCADO_TAGS=machine:amigaone
>
> Test doesn't pass :
>
> Fetching asset from 
> tests/avocado/ppc_amiga.py:AmigaOneMachine.test_ppc_amigaone
> JOB ID     : 39645d61f6f6c90ae87e3a48fe29beb16146aa73
> JOB LOG    : 
> /home/legoater/work/qemu/qemu.git/build/tests/results/job-2023-10-18T05.51-39645d6/job.log
> (1/1) tests/avocado/ppc_amiga.py:AmigaOneMachine.test_ppc_amigaone:  ERROR: 
> file is not an archive (0.10 s)

OK then how to extract a zip file? Does it need to have name ending with 
.zip to work? The download may end up in a strangely named file due to how 
the URL ends. Anybody knows how to fix this? I never used Avocado, only 
followed examples found in other tests but possible I did not get how it 
should work.

Regards,
BALATON Zoltan

> Interrupting job (failfast).
> RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | 
> CANCEL 0
> JOB TIME   : 2.53 s
>
> C.
>
>> 
>>> but this could be a basic test. Booting further is a bit more involved
>>> as we'd need alternative VGA BIOS and selecting menu items in the
>>> firmware to allow CD boot so I did not try to automate that.
>>> 
>>> This could be simpler if the u-boot-amigaone.bin could be added to
>>> pc-bios. It's GPL so should be OK to include and distribute but irs
>>> sources seem to be lost and could not be recovered or reconstructed so
>>> we only have this binary. Who should be able to decide about that?
>> 
>> I'm sorry, but if the sources are not available anymore, then I think it 
>> will not be possible to ship the binary in the QEMU tarball - since the GPL 
>> requires that the distributor of the binary can also provide the sources on 
>> request.
>>
>>   Thomas
>> 
>
>
>
--3866299591-1471827360-1697628331=:90406--

