Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A076CAFE
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 12:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR9EU-0004r2-FW; Wed, 02 Aug 2023 06:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR9ES-0004qg-Nw
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 06:37:32 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR9EQ-0004yb-Oz
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 06:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690972647; x=1691577447; i=deller@gmx.de;
 bh=7GQFfAyP3J8/JQPrkv/eJy+2eJbA3cVYo9suyqEMLxA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BY+jsQVa2SvER+Ho7MC2Y/eJDjf0TTQgMotkz48zmjMQKNJMWYSyyNlQ1MQRr3ZPberPwEJ
 Qzq1Gcu2zWLKsRpJqPqHgQOmIDcfnLvTNs/Hj4cNUthkR4qciBRI426zD7wuwbJ5MQUyFvwcL
 zYqZns9zN2HeBoTmrbIo3Prx73sP5763nCu4ekMU2fbbYb+yijVL5rLfhZ8cyjrVryahAfOaP
 g0z4p93z00ZAUUFnrZb12WL/m1RekmHe12KfU9zUd6iuLn3s/NO9TYvFjLstI9bf4zNST++7X
 lkpkP2+9KcFVmZwdc1QaN4HhYoEG3JH/3r04SaBV7ZEcnJthaCrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybKp-1pe7sw3CW5-00yuRF; Wed, 02
 Aug 2023 12:37:27 +0200
Message-ID: <63593ee7-fbf4-9105-6719-03d512e65fa3@gmx.de>
Date: Wed, 2 Aug 2023 12:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Joel Stanley <joel@jms.id.au>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
 <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
 <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
 <57d9980d-b881-b16e-844a-e651d6d09de7@gmx.de>
 <c3ed33f0-998d-5386-1880-22436af149b7@gmx.de>
 <def4abbf-ec8a-7986-1831-d9c839acff8c@gmx.de>
 <CACPK8XfXMU=YyvkPTHFV6n_THkDPKfRmjYt_Ps7KJrxV9Srjbg@mail.gmail.com>
 <915e346e-fc91-5098-0f72-520f63a7e99a@gmx.de>
 <6fcd0176-ce2a-342c-1baf-ba2820c17627@daynix.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <6fcd0176-ce2a-342c-1baf-ba2820c17627@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K/w7+p29QWyguhBs9o5eyNm5WcoWRym0pPSoPXG22Ip5w2Ozjsv
 y4U6j6QeMSnR7I8GvhyCXwprCXxUbF6SCyCvicFWEeK3Fd2ZDqxTVDZff2Z6P4JcGU9Hw84
 Hutku2hx1+qdVzVP/V1s2Q6Ro93fklKgSujp0H0UBHgKwIyzJr3qNNWH7I/zY43djzNUgiD
 qOzEyD9k14ZT/L97nJdnA==
UI-OutboundReport: notjunk:1;M01:P0:QvFyWy1v5N4=;e05qWZMxPmBxgfMn+K6CQQk7sZ1
 6uViyWEfA6SbmQUjE5V5tAcFhqU7ON4lORCONgfTV4tt5vf2M/TbO4nffkRqA0ajLAHcir33D
 BZfp+n+851qaP0o8veQhHi3tGKVONdw12XEK+LeU4V/orxwfUJA624P+nulvDNidT4HA/C0XX
 eUPiUSa3ivdqV3SFNnV+UBXnb3x3GotiKZKs5La0rumZD+ff/9Xv10Uop4/NAJjeNNI9ATrVz
 jYUUIKjvMv/3BgHpCqbd4LdqzDICdV53Vx2TVfRPFLWCRy69MyhxLmteuoVV50g+YHk9EHoeW
 olggBV+JLChAu2N/B7sqW7eIUP6spdFxTavW2FYdkV/BGfxEqibq1CpeGxtYfa3VOeMUD1XJ0
 x9JArNNjmx2r2n5zExumbJhUr+D2hR/MEtgSlWFE2ClzBBF74I6AJbBlq6Qf/YMJ73yqZQuAt
 oyiUKK3yx1mnvFhEOsvN7eB5R8IUZventM5xtN5qJ+EoegB0aakL9ryFaMsOPL2msaT912gtY
 fJiLRCaRFt56Bx/L1Hd8iodJ3tnN9z0wnoRxTjPUN/r8cxfyuBcONBrlP7tIKFaoAmDU4zmQp
 mKht5I5PjqfPCo9Z0Njnc8kX2/CRtBrlTD4k5dsaKyLoMflk793dBIZd/tNMhAP8SAXsajMf1
 GvUM/TjKmOJaKRzc8hHw15NEEzmLoC+AvXlv05QH/SUmWVrGjsyMY7srqT6P6POL1VrCz9+Ks
 FNGU6KoDvn0yfU3bzapSq8WF9A0d/3rkp0hMnonNgEkrWZFzkLS4YDVGNIier5h7QXd5QrM/X
 TPe913+tQhS/IbTyc4xjiRhYoKDMLKGgbUstxoCAh7YWMWvL9S8ew8W873rpdQeawbDyLEs6e
 FEs7ggpIl68GM8gtwhWwLK7xITrknT8eM94VhICSk8zhqsJb/llLs73Jt8WvptvZj4ndsIVu2
 QmfXTfUZSxgxzXFh1in71k+tDqU=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 8/2/23 09:26, Akihiko Odaki wrote:
> On 2023/08/01 19:43, Helge Deller wrote:
>> On 8/1/23 06:49, Joel Stanley wrote:
>>> On Mon, 31 Jul 2023 at 18:24, Helge Deller <deller@gmx.de> wrote:
>>>> As suggested, I've based my patches on top of yours and the tree can =
be
>>>> pulled from:
>>>> git pull https://github.com/hdeller/qemu-hppa/=C2=A0=C2=A0 brk-fixes-=
akihiko-2
>>>>
>>>> My patches are neccessary to fix an arm-static testcase:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/bin/qemu-arm-st=
atic ./fstype
>>>>
>>>> Let's try this patch series...
>>>
>>> The armhf static binary works with expected output.
>>
>> Good!
>>
>>> The arm static binary causes qemu to segfault:
>>
>> I can't reproduce here.
>> I tried it in an arm64 chroot which provided the cross-compiler and wor=
ked for me:
>>
>> (arm64-chroot)root@p100:/# uname -a
>> Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:5=
1:12 UTC 2023 aarch64 GNU/Linux
>> (arm64-chroot)root@p100:/# arm-linux-gnueabi-gcc-13 -o hello hello.c -s=
tatic
>> (arm64-chroot)root@p100:/# file hello
>> hello: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statical=
ly linked, BuildID[sha1]=3Dfa0f7cd6e1779fa8cd76c6e5d3123900ceefa952, for G=
NU/Linux 3.2.0, not stripped
>> (arm64-chroot)root@p100:/# ./hello
>> Hello, World!
>>
>> Maybe you can send me your binary (and the needed klibc*so)?
>
> Binaries will certainly help. I also suggest adding -trace target_mmap s=
o that we can see what's passed to target_mmap().
>
> I also sent a new version so please rebase to it and try again.
> https://patchew.org/QEMU/20230802071754.14876-1-akihiko.odaki@daynix.com=
/
>
> Helge, please rebase your series to the series, include only your patche=
s in your series, and add the following to the cover letter:

Will do. I sent them out bundled for convinience.

Helge

> Based-on: <20230802071754.14876-1-akihiko.odaki@daynix.com>
> ("[PATCH v2 0/6] linux-user: brk/mmap fixes")


