Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD9E7511F2
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 22:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJgdc-0005Ma-Dd; Wed, 12 Jul 2023 16:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qJgda-0005MS-UJ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:40:39 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qJgdZ-0006vV-6o
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689194432; x=1689799232; i=deller@gmx.de;
 bh=J+1SPUFhu/Eg8avmJq8i1mPg8shFWGe96a5PGKruMnk=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=YDEWX7S2LUyuF6tIUkoCFonYKVhcWdbjnA8iuuVZmLlJaKOdot9/NKEuOsprDTbSTHG2Wrk
 NiKgLhxe5MoGJjvUAqkrt5R5hyRfj4TtmALl2TnBhziB/v5DE1oX8T7xy4Sfr5BWJJWrt9ETj
 KwbG0bDQUKHLf6wn1o/Dx7+8wVH3mXAT1oIJHwJ0D3eEfSHZFbbJsda4uMc9vaOwKkdL1l7fC
 RJREMLfvclX0cYcJS+LA6t7CAVAiPPchfV0NfpxppFzNAe6XHOwtpi3x88i/dPoKwYE4GNWRf
 ALlVOGmTUN6wGqlaaoDiIgzsVwxrz2qh1PbP7q83Ky8QoNECBxMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1pjFI530dh-00anwt; Wed, 12
 Jul 2023 22:40:32 +0200
Message-ID: <a67a123e-aa75-2ee1-3109-9dc9d07e1430@gmx.de>
Date: Wed, 12 Jul 2023 22:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] linux-user: make sure brk(0) returns a page-aligned value
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <mvmpm55qnno.fsf@suse.de>
 <0110c2c4-e9de-a2d0-5c0a-6831415beb9f@linaro.org>
 <9bde924d-55c6-9254-e7c9-6cbf7b7c9b5a@gmx.de>
In-Reply-To: <9bde924d-55c6-9254-e7c9-6cbf7b7c9b5a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4WnXddfQ/TlOishqGehwk845WLIy2jyDJCtvOsSWPpoup3oxqr5
 mNBBaRviwhUmC50TYO4YZypS3CQlpc1bSifpx3WGYsdBYuhoS5H8HZvxMjnA5Xbhv/qMm9E
 bISs12a9NX5o06puvSAdyK3mZ/P1NCR5u3BTx/cEBGOd11ClClNOYwi/5nnIPcHrc7nQvSa
 5nKAXmn14v9G/JzLpEdJw==
UI-OutboundReport: notjunk:1;M01:P0:vjBWY4VVXMw=;o8EVgxAIuPNLwjsA6QPAClGxJAh
 bb2gXZQwR4W4dvPcV9ZX4vXO6+thNoIwRB0Oph7KBIdmzr/1dU6ko/i48yvFuWWl/bl4fKwYC
 XkdFO5+GT2HAWpXDm90jjL1qNLpou0M9VamobvEAUMUnCNMyHQWWxcjsECb40n1KKDXIMKBkR
 3W0YbThHD2jHEj3uz/fVJc0to3Q3p+NS5IE+7uhhc3FSRqjV/AUZQwRfA2fjLCuRUdWQQlhZN
 xP+IZhSxkwdqWJdiSmw0FZ4sDCnpqUQ6z7b1cOLutLBoMHP5Lfo79LtInFqLCdbIb/gY5tz5X
 554C/Dn44gE7RUzJLQpQ2pnGYtv/A86mtcpHAcOaINoq+kyuqIYL319xCYDC/nzgumQ6Xjj6i
 Yr1dsC8z8ykGhU7RPUl3ssMwxU74g03+kuoPxQLXZ3BqpHd9oFEnZIxbyM+FavaRr/HuSCCMq
 ZQRhBEXqdf6G8LsZ1kOY4PFKSfyjkvuIk5cZVAzgkBCOlJKxRhNhj3ykGdMwiAEHAbFoy/lPB
 DdGQBrn2UQMaLfgfoxzQsVUmlHjTrVR8J3z3Kh3PZr/s+ABlp+7aVMAVaMV0le1vGeqxvZrH8
 MyUFh7vxtr4mq69pmJrDeqAx3Ate5RzLAY3foVKdO32j1TmOtbXHTTYLDNg8otw0Eu9pJXntO
 1uxoFBo7rp3uwyPyiDzXgLUJKv+K5c63t08Z8czCkI/iv8YgATsUdcWfQkLL7Pgl//rD9ORQT
 IPwjMxV5kqX/C3a4aCWFG7PbOKyao0lo2uEGwlxh4Yhz5VOZw04DIImzAbb+gZ93BC1XUHcth
 vbmHSV1WkQfz+7wht70uBMfhP061o5o0rOzq40Wj4rbxXbwRickACHtOM5j/qSZnZBAFP9aB3
 jorsDH0ZnrqreIib4VEviQox2ldjaYX6jftOiZtomTFIaEZrpg4LvDG7vwz3eJN4sg1/djDaj
 nGdDjnn1+s9u7zLo0hof6ExzO3g=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/8/23 23:36, Helge Deller wrote:
> On 7/8/23 19:26, Richard Henderson wrote:
>> On 7/6/23 12:34, Andreas Schwab wrote:
>>> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
>>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>>> ---
>>> =C2=A0 linux-user/syscall.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 08162cc966..e8a17377f5 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -805,7 +805,7 @@ static abi_ulong brk_page;
>>> =C2=A0 void target_set_brk(abi_ulong new_brk)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 target_brk =3D new_brk;
>>> +=C2=A0=C2=A0=C2=A0 target_brk =3D TARGET_PAGE_ALIGN(new_brk);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brk_page =3D HOST_PAGE_ALIGN(target_brk=
);
>>> =C2=A0 }
>>
>> It make sense, since that's how do_brk aligns things.
>
> Yes, patch looks good.
> I haven't tested, but it seems it adjusts the initial brk(0) value
> only to make sure that it's target page aligned.
> Maybe the title should be: ?
> linux-user: make sure the initial brk(0) is page-aligned

Another bug report regarding the non-aligned brk()...

See:
https://github.com/upx/upx/issues/683
https://gitlab.com/qemu-project/qemu/-/issues/1756

Helge

