Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B5738A93
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0S8-0003ug-4r; Wed, 21 Jun 2023 12:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qC0S4-0003uA-CT
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:13:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qC0S0-0006vq-Sq
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:12:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 76D18746E5A;
 Wed, 21 Jun 2023 18:12:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3EBD174632B; Wed, 21 Jun 2023 18:12:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3CC23745720;
 Wed, 21 Jun 2023 18:12:44 +0200 (CEST)
Date: Wed, 21 Jun 2023 18:12:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 02/24] q800: add missing space after parent object in
 GLUEState
In-Reply-To: <4e72ee4d-a5ed-7c43-df8b-3d3d8c159675@ilande.co.uk>
Message-ID: <73bb7d36-d5c2-02b9-a0f1-79b940487ddc@eik.bme.hu>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-3-mark.cave-ayland@ilande.co.uk>
 <2f1b2a44-0d0a-751d-4f3f-2de1f4ce4729@eik.bme.hu>
 <4e72ee4d-a5ed-7c43-df8b-3d3d8c159675@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1591175739-1687363964=:5320"
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

--3866299591-1591175739-1687363964=:5320
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
> On 21/06/2023 12:41, BALATON Zoltan wrote:
>
>> On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
>>> This brings GLUEState in line with our current QOM guidelines.
>> 
>> Are these guidelines documented somewhere? I like this better than the 
>> public/private comments (although I prefer no space at all with just 
>> documenting that QOM object parents should not be accessed directly) but I 
>> haven't seen it discussed and agreed upon so it looks like a convention you 
>> defined but not documented anywhere. But it could be I missed the patch to 
>> coding style or QOM docs to establish this convention.
>
> Alex documented this earlier in the year: you can find this online at 
> https://qemu.readthedocs.io/en/master/devel/style.html#qemu-specific-idioms.

The examples in
https://qemu.readthedocs.io/en/master/devel/qom.html
now contradict that by using parent instead of parent_obj there.

>> If we really want to make these QOM object states stand out we might even 
>> consider formatting these as
>> 
>> struct GLUEState { SysBusDevice parent_obj;
>>      M68kCPU *cpu;
>>      ...
>> }
>> 
>> unless checkpatch would not like that or something.
>
> I'm not overly convinced by this, and yes I suspect it would also require 
> some hacking on checkpatch.pl for it to work.

Nevermind, was just an idea. Blank line wiithout comments is also a good 
convention and less weird looking than the above.

Regards,
BALATON Zoltan

>
>
> ATB,
>
> Mark.
>
>
--3866299591-1591175739-1687363964=:5320--

