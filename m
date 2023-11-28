Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 584497FBC9A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:20:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yvc-00009f-0X; Tue, 28 Nov 2023 09:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7yvP-00009N-Fz
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:18:55 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7yvM-0000H4-Sc
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:18:54 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 587C275A4B9;
 Tue, 28 Nov 2023 15:18:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id JfzwyqHkSwRe; Tue, 28 Nov 2023 15:18:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 67758756094; Tue, 28 Nov 2023 15:18:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6583F756078;
 Tue, 28 Nov 2023 15:18:46 +0100 (CET)
Date: Tue, 28 Nov 2023 15:18:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, vr_qemu@t-online.de
Subject: Re: [PATCH v3 0/4] Fix IRQ routing in via south bridge
In-Reply-To: <2b8e0424-1b93-4ae1-9d66-aeeaf7afc313@linaro.org>
Message-ID: <6c02e402-e07a-4651-07eb-2983e9d8b953@eik.bme.hu>
References: <cover.1701035944.git.balaton@eik.bme.hu>
 <cc64f407-9a5a-d0b7-33b7-0f142a9ec6a1@eik.bme.hu>
 <2b8e0424-1b93-4ae1-9d66-aeeaf7afc313@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-402525679-1701180217=:13889"
Content-ID: <22b76f0a-9383-96de-9644-718da5d87cfe@eik.bme.hu>
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

--3866299591-402525679-1701180217=:13889
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <af3669ff-81b6-69ac-e027-f4d640b7f162@eik.bme.hu>

On Tue, 28 Nov 2023, Philippe Mathieu-Daudé wrote:
> On 28/11/23 13:47, BALATON Zoltan wrote:
>> On Sun, 26 Nov 2023, BALATON Zoltan wrote:
>>> Philippe,
>>> 
>>> Could this be merged for 8.2 as it fixes USB on the amigaone machine?
>>> This would be useful as usb-storage is the simplest way to share data
>>> with the host with these machines.
>> 
>> Philippe, do you have some time to look at this now for 8.2 please? I still 
>> hope this could be fixed for the amigaone machine on release and dont' have 
>> to wait until the next one for USB to work on that machine.
>
> Thanks for your detailed cover and patch descriptions.
>
> I just finished to run my tests and they all passed.
>
> I couldn't spend much time reviewing the patches, but having a quick
> look I don't think the way you model it is correct. This is a tricky
> setup and apparently we don't fully understand it (I understand what
> you explained, but some pieces don't make sense to me). That said,
> I understand it help you and the AmigaOne users, and nobody objected.
> So, while being a bit reluctant, I am queuing this series; and will
> send a PR in a few. We'll have time to improve this model later.

Thanks very much. I'm open to further discussion and improving this model, 
just wanted to have something working in master now. The discussion about 
this seemed never ending, it started before 8.0 and still could not get to 
a conclusion yet so until then this should work for now and allow users to 
use it and does not prevent improving it later. So I'm still interested in 
your review and why do you think this is not modelling it correctly but we 
have more time for that now and can change this further as a follow up.

I think the current way makes it easier to add Bernhard's SCI interrupt as 
well for which I had a review proposal before. The main disagreement 
seemsd to be if the chip functions should be PCI devices or not. I think 
they aren't like regular PCI devices and clearly don't use PCI interrupts 
so Mark's and Bernhard's idea to use PCI bus interrupt routing for these 
does not work because they need to be independently routable to ISA 
interrupts. So whatever we do we'll need to distinguish the interrupt 
sources and keep track of their state individually because more than one 
of them can control a single ISA IRQ. Doing this in the ISA bridge seems 
like the best place because that already owns the ISA interrupts so no 
other component will need access to them and it can keep track of state of 
IRQ sources at one place.

Regards,
BALATON Zoltan
--3866299591-402525679-1701180217=:13889--

