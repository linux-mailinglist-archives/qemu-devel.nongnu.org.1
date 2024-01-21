Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1374D8356A4
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 17:26:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRaci-0003tl-CJ; Sun, 21 Jan 2024 11:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1rRach-0003tW-0H; Sun, 21 Jan 2024 11:24:39 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@web.de>)
 id 1rRacf-0004Q6-2Y; Sun, 21 Jan 2024 11:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1705854272; x=1706459072; i=jan.kiszka@web.de;
 bh=ECl6xXsI289B9nONusLcZmYsxKtnfBVMIX2BDjFm/+Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=OKcchecspyeXPQxT40Oc6ikUuSH08t32jg6+kis5enttZ3vS3ltM6afrODKmeiFD
 /2wcVdbeJ3SvT0w7XDaQ6Htv21Ni2aX4xKXOpmHQl6fClVL/7H5ar5xeosV8GV2uB
 DNAifPeQ/3qlHVpq1QeA5UVcR5t1NuMSH3T8nfiI1PzjOafG4z6X3pFoRzE4he8M3
 LnRBoUBTyqNyDjEO8BUV15a4DNxg2A21x6g4xhO+n4U1cPx7eJZ9borIBpE2sOL/l
 nvWhkXF1oB1/5E0H9ZJlI14o9mrP7MAKwZuvrAriK6qgAH7X3fGa7ON9NStilCLJ5
 hzUUMOAEFikoogJInA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.12.10] ([46.128.89.130]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1rKUxi21cM-00H6XN; Sun, 21
 Jan 2024 17:24:32 +0100
Message-ID: <9dff82f7-d997-4092-8b5a-cd21963826da@web.de>
Date: Sun, 21 Jan 2024 17:24:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@web.de>
References: <20231103182750.855577-1-peter.maydell@linaro.org>
 <871qadh8g8.fsf@draig.linaro.org>
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
In-Reply-To: <871qadh8g8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mrluBn4fJJBQNWIHAydViwPjI2aVUIXBnqSFg4+vt9qXWXV5e7C
 KySUH76hb/y61J0P/vzLeRkzBuaWf6CpsIiQ3A6KsZAUshhBKQGD52/9ELgOhDXH3vgFCTj
 JjJLJYtdIwRcSmQmcf8hiXsCROnG5ju3nfTMBfbAVOv52rihrtE50Ff3geWnn0OArgduDe5
 0r4Da41ZbthwoPa6FkZhw==
UI-OutboundReport: notjunk:1;M01:P0:TFFsts8+Ris=;i5D/CK2UKWwQDwefS47uoSVYS0q
 cEBjTbOZq947TH89T86WUf/d4zgP3ejmsKVDGQdoE8PcB3AjqJUR3D7Q/4S42K1hganRWptFM
 jlFZdBrHihj57a5KcfWv2AyiouGAf+gfKYJEbheRzT44A9jIPp2fpNBbQfdLexcYVvyqseHXy
 DOq1HSDjKt5HWkMoz+hvQAVmFl8S0H0GMzCad7QTowK+1i/Jg/7wIraNbvPYG08RUJcl4XjUA
 PpJJffKBUsGrgf1bHSBQT4hQbzsO7Q/CdUOk31dIzdZb55K//fo2Q6LcVoGP7tylcKjHyafVB
 6NfPJvielEtxtJiWb97KKjg6zGnVMOFg6rcV8Ic/jQ5dcXLcbEGuMTRaSa6xNXCENH6cZWt75
 BfbOece6F11bPhdFNlJUbRq21CNbo9tmPKELd6mkPtEqgnFifHCQEeO/QOGJowkuptGbNQDTG
 sTGS10eUAVDO66Kwkw79PJnJKXWcYJzesRBgyJjU2Cvh1h49OOHqP+BUUPeHLR8nXZ6CKc7VA
 HCN83Fm5rVCkLRj84m1qDQd36taWzOeAw78rYknd9gzmwCZ36eB1ifOpzsFa2mmF54gPr0Z/v
 229svQbfV7oU2tBWGrUkNagjiC1c/+4W4r1Xmjq9ltMoU0PIkRlI0cB5OaqU0OgI1nuniZWRZ
 XlMzSwzU9B0A4C95HUK4YNQEdmH6rjkawdw0F4OPi2/Vecdz5s596HtxAYA4yH9Xlp643fjl8
 KaIXVKQZeS6lWfJnD8VCgLijBUGT27cWbIUUijIAcjH0wQQ1NUSU9BEAO/bYgDvBWywzQfYsL
 r9upVzk4eVzUDPz6i4hv3Ar1z7dWEHlSBNw5mN0XtfGeldS/u/hq8WBsi8z4LV4pi0kwMMG+n
 9gIGXoDcoaydPINIdcq3/zlx60j8D2DgKkbfb8vAzNoeguqNXyxVzenY4eypANjcayKX6ISNf
 sGWE9g==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=jan.kiszka@web.de;
 helo=mout.web.de
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 19.01.24 12:24, Alex Benn=C3=A9e wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Convert the musicpal key input device to use
>> qemu_add_kbd_event_handler().  This lets us simplify it because we no
>> longer need to track whether we're in the middle of a PS/2 multibyte
>> key sequence.
>>
>> In the conversion we move the keyboard handler registration from init
>> to realize, because devices shouldn't disturb the state of the
>> simulation by doing things like registering input handlers until
>> they're realized, so that device objects can be introspected
>> safely.
>>
>> The behaviour where key-repeat is permitted for the arrow-keys only
>> is intentional (added in commit 7c6ce4baedfcd0c), so we retain it,
>> and add a comment to that effect.
>
> Well the key input all works as intended and looks good to me. I'm a
> little disappointed I couldn't get audio working on the musicpal machine
> but that is not a problem for this patch.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>

Looks good to me as well, all keys still work fine.

No idea what's the issue with sound, though. I think I haven't run the
whole stuff in a decade or so, had to search for all the pieces first of
all again. The webradio service original behind this stopped their
operations, at least for this device, but manually entered favorits
still work on the real device - I still have one, though that is
starting to get some issues as well.

Thanks,
Jan


