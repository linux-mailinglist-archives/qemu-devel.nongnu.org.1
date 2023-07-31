Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F476A054
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 20:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQXZ1-0006EA-GP; Mon, 31 Jul 2023 14:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQXYy-0006Dc-Su
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 14:24:12 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQXYw-0006R4-HP
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 14:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690827847; x=1691432647; i=deller@gmx.de;
 bh=XXe0e2kf5na1yBlA0g2NBqi9cKT1sXfottFhYfvewTg=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=ffaREzXsEIyNGGKFHHk7ytryq61qvom4IylEkpkRYSNJXCocx9REsW3TAg8LvyxGS/7Crvi
 KeBYyzPCZ2KHjUfIDOizZP8a4tRDOdECfIR65vYZI/FNqgl8fm2RYEAaxOrV844ZjXrwQ6Sot
 uv62Pq0j8ZH2D7iU2QgE9/NlWCwj7sFvW2KhEqcLiSm+V7dNlUZ0cYX4M9bZ3T67ahNkKV2Tq
 g60NW9d8x91bnlrztaOK8P0HDKHoyQK2JWeg2IEt5fAXDuSaoeomor6KlMyHad9RP9ke4Do12
 uUk77tep3FY9uruR09UMPwW3bJ8SzPf/DoasMDmk+V7tONauWfhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1pzyFj0liy-00iEjn; Mon, 31
 Jul 2023 20:24:07 +0200
Message-ID: <def4abbf-ec8a-7986-1831-d9c839acff8c@gmx.de>
Date: Mon, 31 Jul 2023 20:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
 <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
 <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
 <57d9980d-b881-b16e-844a-e651d6d09de7@gmx.de>
 <c3ed33f0-998d-5386-1880-22436af149b7@gmx.de>
In-Reply-To: <c3ed33f0-998d-5386-1880-22436af149b7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AX+TJnZYQH4xLZjzpzL3bB/3wDo6ZP4UtyMOylQtPltJGWDUIV0
 q1cj1GtWOduttoVWaQDFUWbyrMjuJ7+ND3+jF8QDPPeWs8/OzOuSnZ6OSGG5FQ37UJmX1sA
 vRoAaxJRyU5GVI9ek4fbEqN0ZUfqYgDk+xJcCiEboTOLib5JzyFWpDLo0/9P/9Yw5sZN32z
 payigabsF+RbCwT4fbaaw==
UI-OutboundReport: notjunk:1;M01:P0:j6VV95UqSx0=;72A9KpL3RIDUpO7zYJXcvpRR2Ni
 u1eYkb2NrGUTBfa5ujKFIAsl5IVXng/9clxzNiB5RIN6maQnUdVdYTTTeyj+H1l7nDYja+Mtu
 jixJQFiQLcc/DYuQjd2rDmOQZaaFWQWgFKO7Q+4NhqVu1zWSHrn4+22DCEDt+ozFj35nQ8OIm
 iQZFoRQfo1qPq0Eh/ylAZTMFwxkpR1inTKA3ObroFgtvGrez1MUkUuH+gvVsMPbMcMZ96adJq
 Xs0GXVPuOVOqBHhdLq+F7r66p2DgXVbaijVCH86lZz5bx1mXpDTH+BkH9m6NXfIqw5Z5YqtCE
 c1KJNiULh2PTQg722zKSrtj16XN+cIIRnQuzrtPCzk/+4jr2g9mrT5zo3EwxojN+vUWj7ZBXk
 ZiixAi6wde/wX2j/4oYYNrrPUqgqSLb8Di15Vy9lks8ZEtOO2V6N/TR3IRl+tqMC2Dj/JypH4
 71gvrxxqIGz9f6OrEWK02rdfUflnbMX3IY20WTqhtKvpvYu/L0T9/tFA8p3NCpHvXRJODpHHt
 1I/F3YTENlZ+9gurwtYykOHGjInG3XOZrRiLtGf81se/tl66MlyEZxxXDtNOZzx9aCRs8eM1S
 3k43s0nQOAKv7cfVfZUm7Zzr5OdWBG/IP+pHlvqmAB2tUbXeL/9+YqVKRaKQSqtM5zGVd9pR2
 RpsxODUWYxguHXQoA6MNZMuua78VndwJVDfKht1vMAlaibnyfalGcIVrqZZeEBkExU2YAxC7b
 o1GwyycEFUUsV5yd3GDbysHafmzghfomEeimuFAdVu49iVPIiaxlM4YOOHW51UPyF7quBmTrM
 cI0iwQ4VpN6GxV/vGH4s4/1bgqF3Yc1y9B5CRDgir4zxSdWuSTQQ9HGFCPH/St3UjkBxgYI+y
 NLckNk3u84XpA3DBk2qk5gGRBDajKPTmY+Zk3OJTsouEpq13cshnVW8lTzP37gBssMQg1W+j4
 Y30j6u9DtEhMGKw9l2FJHvroR30=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/31/23 19:43, Helge Deller wrote:
> On 7/31/23 18:47, Helge Deller wrote:
>> On 7/31/23 12:23, Akihiko Odaki wrote:
>>> On 2023/07/31 19:17, Joel Stanley wrote:
>>>> On Mon, 31 Jul 2023 at 09:31, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>>>
>>>>> 31.07.2023 11:03, Akihiko Odaki wrote:
>>>>>> linux-user was failing on M2 MacBook Air. Digging into the details,=
 I found
>>>>>> several bugs in brk and mmap so here are fixes.
>>>>>
>>>>> There's another work in this area by Helge Deller, have you seen it?
>>>>> ("linux-user: Fix and optimize target memory layout", a v5 already).
>>>>
>>>> Applying this series fixes the qemu-arm running the static armhf
>>>> binary on my ppc64le host that I reported here[1].
>>> >> [1] https://lore.kernel.org/qemu-devel/CACPK8XeyqcEDyyL3Jw2WYWs_gGd=
tTCf2=3DLy04CMgkshSMdj7RA@mail.gmail.com/
>>>>
>>>> Tested-by: Joel Stanley <joel@jms.id.au>
>>>
>>> Thanks for testing.
>>>
>>>>
>>>> The changes conflict with Helge's patches, so it would be good to wor=
k
>>>> out which of your changes should be combined with his.
>>>
>>> I suggest Helge to rebase his change to my series. The below is some
>>> detailed explanation:
>>
>>> It is almost orthogonal to my series, but patch 2 will conflict with
>>> my series since it changes how the initial brk is calculated.
>>>
>>> Unfortunately I think patch 2 has a bug. Without my patch, do_brk()
>>> assumes the heap is aligned with the host page size, but the patch
>>> does not consider the case that the host and target page sizes are
>>> different.
>> I've included your patches #2 (bugfix) and #3 (cleanup) to my latest
>> patch series and published it at
>> https://github.com/hdeller/qemu-hppa/tree/brk-fixes-akihiko
>>
>> Maybe you and Joel could try it out?
>
> I re-read the thread again. As it seems Joel already tried the latest
> version from me? Sadly I can't test myself on ppc64le (static binary
> needs klibc-PupSAGgtpafMlSLXOLgje1kXFo8.so in /usr/lib which I can't
> install on a debian porterbox).
>
> I still believe we need to track host and target brk page, but I'll give
> your patch a try.

As suggested, I've based my patches on top of yours and the tree can be
pulled from:
git pull https://github.com/hdeller/qemu-hppa/   brk-fixes-akihiko-2

My patches are neccessary to fix an arm-static testcase:
	/usr/bin/qemu-arm-static ./fstype

Let's try this patch series...

Helge

