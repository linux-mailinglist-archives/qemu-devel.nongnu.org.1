Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FE836AA7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:32:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxC8-0002Jt-Fx; Mon, 22 Jan 2024 11:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1rRxC6-0002Jg-OE; Mon, 22 Jan 2024 11:30:42 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1rRxC4-0000ZV-Mc; Mon, 22 Jan 2024 11:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1705941036; x=1706545836; i=jan.kiszka@web.de;
 bh=LG5d/F7Yb0IifmTVWUQGUWTBicUks8yyRvf5ftPVRLk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=YnI/DtBor69Sr1GWfz3X0g1lkErdjbcdxI9otx/pIenOCmeJLfldp5gD36NS+Zti
 rvmIX9IOowQ/duutxPLBQZNgpOeCl/ItRPXtDUpFa2CRkYB0n4uPq4/FtfUZ8kh8J
 v8HEs0SyVkS7IMsYj7/Lu68F71serF1He5W/3LOykuOFiqJ3LhsfrynmxJBgQTjoA
 L2RzmL10s+64U+4MtU33q2jlWkrKGsJ7vkIS7yH8IkjSjdebbXyokFgQ2iWZiHB4W
 YfGfEnQcwF9Uk35puZRtz8yejLbJ2r8xaPVw4DTgqFuK4EI2mbm+9dNP7k9B/bbur
 0SxI3v/R6fyO40MIzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.179.60] ([94.24.63.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1qmrwR19uB-00oSb8; Mon, 22
 Jan 2024 17:30:36 +0100
Message-ID: <3b4481cf-e1c4-4515-a7e4-80915cbe2bec@web.de>
Date: Mon, 22 Jan 2024 17:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231103182750.855577-1-peter.maydell@linaro.org>
 <871qadh8g8.fsf@draig.linaro.org>
 <9dff82f7-d997-4092-8b5a-cd21963826da@web.de>
 <87r0i9ofxi.fsf@draig.linaro.org>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYAQTEQIAIAUCSrSLxAIbIwYLCQgHAwIEFQIIAwQWAgMB
 Ah4BAheAAAoJEIrUrG965ecUhIMAnR6DDCW5cx+cVdYhydbhQXqeief6AJ4p+z4+nrmZLdfU
 7V6nKqKeHeTtj87BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepKvIfi
 M8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+bgvM
 OsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hnclsZ/IY
 hXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVORTOtz
 FK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5gz88
 SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI3KCT
 67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdIvttw
 zG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPxbRea
 9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zpq61t
 oNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+NK8JJ
 BBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wHAJ46
 S16yab+OxNkvOeoOEX0EnHVHaA==
In-Reply-To: <87r0i9ofxi.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z3ehDAgo+rYWOC9OKj3zOfJa1+zM3vQwg3A/kxKU9TK7VzLXFhg
 aNp+rF0fFyjH3yIZ4HesdhgjJ/a7frb6fWDas4a3lxBBGdSKyOwXRBX6U38CazjE/0B/5i9
 k3vPT8rebGkFeaMn/RcazCtsijjHsRucBLPte19Es3cWqufUOIbRKuh6f749/fTokqMbZjD
 pt80pAhhXHGRiAs6OUbwQ==
UI-OutboundReport: notjunk:1;M01:P0:qbvVMW9m++M=;mno9lEZ3io1x4iPB8NmOUAgGILm
 6g463LfNHQzKMShBjH/i7FTFlkmv+ZlVLjvB4MQ28gASC/DRqKroT+tq7zvKl43/1KbkPc2c/
 SUx3YJlyBE2+07aF+xp3ErBB0bBIGkJ+rmzNUxx1UI0ORvoeExsWl52FGCNg1b5GRu6RFADd7
 bBp9Eol9VUrILfE3WFsOgjZIbfsu1ILKtXOr6wtOmqdVLbALsD8f0lJ3uX0GMW7bcxlpD837o
 FiQDNdErSLSBIbhhLZ2m6M8Hqp5rR+7pChZfoXHgLLcTq+IpArEL4O/DoH+tGKTF2XGitAZoi
 zSFRi5qRD/oEgXcLKJ+F0i3A4QGgeaKW19S2oOdsKCsx88vtOf3EL4yeZJy1or9lrR+WszFVK
 agf3sAx8XPnoev8e02c9FfCnsXUsPpIC2gDCVYVFP5qRdoPb4/PLVQavpl3/YNjqNeJXkv+o3
 3Vp/ibO2Yvcm9auJINEeW1ms2rPXxsW8HqO16dJw4q2qMkYcd101UZn515F9iuFSaLYQwz3tl
 B/Iw09ISlOE2281/k+1O5iCn6NK//snmOE4Zrrwv4NE7I/oKPL63Og20Hb3rslBEA763EmZWu
 cKztCcEQ0fQk6a3MxRVsDqQDxwEG3WA42Js7bRBApfmdxRr7Nbs94J73AWu4dX4xy6GFSZ+Wa
 iEkYxsrUcc25KaOkbPVn2y9YX20J5HOefm71GJbcZyhl4miwPmnRLxZaXd4JsaLPlNzY2RU8a
 xi9mRD6o1Fii8hcZK7AL+BCYKZ3iL1wX0h4vY/8AP85KF4+SMZP/FPrgC9RTHbP9W2O4peHqU
 NbSn8H3+JItz5qN+HVWPeM0gfeAGMl4Z4z21BnBxMwTKgokbFM6Y2KNEgQfLeZHCGQvsrdb34
 iML707nB5O9F4woaXbFcS4psktA9nrT+dnffR7ryIf1LoHFtJoPUb28kwsQZ9uXMTTO+k5xgK
 jXlScw==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=jan.kiszka@web.de;
 helo=mout.web.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22.01.24 10:50, Alex Benn=C3=A9e wrote:
> Jan Kiszka <jan.kiszka@web.de> writes:
>
>> On 19.01.24 12:24, Alex Benn=C3=A9e wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> Convert the musicpal key input device to use
>>>> qemu_add_kbd_event_handler().  This lets us simplify it because we no
>>>> longer need to track whether we're in the middle of a PS/2 multibyte
>>>> key sequence.
> <snip>
>>>
>>> Well the key input all works as intended and looks good to me. I'm a
>>> little disappointed I couldn't get audio working on the musicpal machi=
ne
>>> but that is not a problem for this patch.
>>>
>>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>>
>> Looks good to me as well, all keys still work fine.
>>
>> No idea what's the issue with sound, though. I think I haven't run the
>> whole stuff in a decade or so, had to search for all the pieces first o=
f
>> all again. The webradio service original behind this stopped their
>> operations, at least for this device, but manually entered favorits
>> still work on the real device - I still have one, though that is
>> starting to get some issues as well.
>
> I navigated through the favourites and after pressing some keys it seems
> to indicate there was a stream of some sort (or at least a bitrate was
> reported ;-).
>
> The main issue I was having with sound was with pipewire - this would
> eventually generate a lot of warning messages because input devices are
> created but I guess the model wasn't draining the input buffers so
> eventually we get:
>
>   qemu: 0x7f1490259500: overrun write:5859188 filled:5842804 + size:940 =
> max:4194304
>   qemu: 0x7f14902680a0: overrun write:5860128 filled:5843744 + size:940 =
> max:4194304
>   qemu: 0x7f1490259500: overrun write:5861068 filled:5844684 + size:940 =
> max:4194304
>   qemu: 0x7f14902680a0: overrun write:5862008 filled:5845624 + size:940 =
> max:4194304
>

I'm getting these here:

pulseaudio: set_source_output_volume() failed
pulseaudio: Reason: Invalid argument
...

> Is your image just a hacked up version of the original firmware or
> something we have source for? I guess there was never a rockbox port for
> the device?
>

It's an original firmware, nothing hacked. I do have some sources here,
but just partial ones: U-Boot, kernel, not the complete userland and
even not all kernel drivers IIRC.

Jan


