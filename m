Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08F7A5BD0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVew-0003xN-GO; Tue, 19 Sep 2023 04:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qiVel-0003w4-Uv
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:00:32 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qiVej-0002vR-U4
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695110423; x=1695715223; i=deller@gmx.de;
 bh=ZB+PTqhsQosWq9KadPcI6RdlZ5YwsqM0zuHGvoV6RsA=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=XU1ZXDTAZNuubiTIzBQ1THOet+nlNBoQo7y+zSV2eyV61wRczfog9Piz4grc49cGEKG0H/V8qdh
 gShVOZr9wFv9H1IzaAB++gwWgtdjeowOjtzh7vZP/S/DzPvnM7FuEjL1k0PL+1Dn8srXx8ec62xYX
 ch5VLqwmazA22UfGxxHaRf2VPVpvSZOOx6yznMzHdUrn56JllkxFjeiIb5rgiTN6p3zdqpjRoxuE5
 wEMlE5QyVvgaTLDzBXFU6mkwwLJhXm6iuVURTojIfqz1r0MkfyVmVuoz7FlRH/6Bwq8XU5X0/4mNH
 5DIOsm9z65+elYAS9MY0e6EG0oAUhOkNTRTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.149.158]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1rUWC11Fpm-00qO5p; Tue, 19
 Sep 2023 10:00:23 +0200
Message-ID: <c3e39816-b16a-d3f2-135e-95796814ebf0@gmx.de>
Date: Tue, 19 Sep 2023 10:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
 <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
 <36562fcb-77f2-2a18-acec-47f155decf71@tls.msk.ru>
 <51b980aa-1a80-7565-44d6-8dcba3ead422@gmx.de>
 <7a2ccda6-4f23-961c-4d53-b6929af6bd6f@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <7a2ccda6-4f23-961c-4d53-b6929af6bd6f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MKdzLKbIcDSDAYFmZgVNJ1jIVWjatkempyylrO4ASIAIJ3PL4wo
 WmjebSmvD/Yq9WQgVkVICCpF2nYqPJDyog65OvIwk4pmObTTTejuI5ujYQ5+TdPhaFWX59W
 BnEhC76Pj1wzOmugyVf/UrCIQzuStnsLkrjE8p5H+0kj/JuNM2c6tPaxvBAzyAayobMskZE
 ZwTJzU6Q/tU0xgugnLQPA==
UI-OutboundReport: notjunk:1;M01:P0:hwSZO+GTsX4=;HIGWIsz6Rxm7Vybsd8iVgaAB2UF
 ZCOXMwBS1NSTkuUyt8eUWGZosHbh8ifSRCwoK/lTPqlYEokQprKDwzrf3/92bRzt0iI0JsTV3
 8j1ZI4nRxeUEGjumeLQDyeiXFmJakqodpkhBgTRf7OTC6Vkm2hGEPe9J7bz9l3m3cwz22baj0
 rPnwaOsmOzRlIfAs04CZvRu6dSpVvoIYd3KTQOHUclbaHcFpaOomPi2qfY3gWpB5rqqb1JXE3
 Gnl25iiKD0G10rGmcGQ1XHQaWtffwZ+ylH2YuicEstDdpS7h+hbufeDXt9skwbA8PiAwHN16J
 +JEhqM7p8ZND3lp//QA1S+xsQgrFXyw3V0T+6xUX/Ul4eSdScoOkRVeHmtfku6WmS7DJ+Vvql
 2ZKctpJom/8v8x2LTsbchrlS/AAOkghV1NH1LJG5NZboZrkZLzCOEdq19lGY5jgNM/e5diZay
 EipedYO7pFZxixvI+/ug8damNxJt5TAksqOaVlidbI1AYd5tZpDbRUC5cwS4cd+4lz8i44Yfg
 2qCoz7iffQwFUFPRm+9ImJx1gmvaTMnjLC7ywaikS1dj36F25JjhrX4z2YYZTrMkI9fR/CwWB
 5QuXJ7JGCv8onDjZ8VliH1/AS0xdqaD8Z5A2FvbYoN8FtxpwCy9iE+RUAaSYDGtN4hHdyhNuk
 K1xh0z+lz6vyjb6eXgjcpV8BNv/W2ZHGAyETi1bExVrd+Gf+axG2zFyw8hoHiZ8gXmrkwWXTR
 f/m+dYVm+ZUAVb/bUmhV2RrfImbyenRoGzkAR9tDfkoKGxlEYdwdowMfb5TKFdVN78QUe8N76
 gJ3zPMZwXZLrHb+nBbrcBvR/TlQt46/rReesZ0XKelF+G+roKQfU0/MXW1igyGH7uOUfONUss
 6PjkrkWuu4+re1DdsJrYQO8smzhPTx090TJOm+viV96AkrjFoKU73vPhiwRcaJzO07IoN8s5e
 SFzzwAgUF3/j7MS010krE5YiMHY=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/19/23 09:40, Michael Tokarev wrote:
> 18.09.2023 17:05, Helge Deller wrote:
>> On 9/12/23 12:34, Michael Tokarev wrote:
>>> 12.09.2023 12:45, Helge Deller:
>>>
>>>> /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/13/../../../../lib64/li=
bc.a(abort.o): in function `abort':
>>>> (.text.unlikely+0x0): multiple definition of `abort'; libqemu-aarch64=
-linux-user.fa.p/linux-user_signal.c.o:/srv/_build/../../home/cvs/qemu/qem=
u/linux-user/signal.c:723: first defined here
>>>
>>> [PATCH v4 03/10] linux-user: Use die_with_signal with abort
>>>
>>> Sigh.
>>>
>>> I'd be double-cautious when overriding system functions like this, - i=
t's
>>> almost always a bad idea.
>>
>> Richard, I'm not sure, but with that change:
>>
>> -void abort(void)
>> +void=C2=A0 __attribute__((weak)) abort(void)
>>
>> it will at least successfully link the binary. Not sure which effects i=
t has,
>> but probably not worse than before your patch series...
>
> With weak here, ld should peak abort() from glibc, basically reverting t=
his
> patch:
>
> linux-user: Use die_with_signal with abort
> +/*
> + * The system abort() will raise SIGABRT, which will get caught and def=
erred
> + * by host_signal_handler.=C2=A0 Returning into system abort will try h=
arder.
> + * Eventually, on x86, it will execute HLT, which raises SIGSEGV.=C2=A0=
 This goes
> + * back into host_signal_handler, through a different path which may lo=
ngjmp
> + * back to the main loop.=C2=A0 This often explodes.
> + */
> +void abort(void)
> +{
> +=C2=A0=C2=A0=C2=A0 die_with_signal(SIGABRT);
> +}
> +
>
> I think it's better to revert it now.

Maybe.
I only did static compile builds, and not even for all platforms.
Since I assume Richard did test it in his builds (which probably were
linux-user built as dynamic executable) seem to have worked for him,
the code probably works on those binaries.
If this function is left out on static builds (because libc.a already
provides this function), then there is no difference (aka same not-optimal
behaviour) as without this patch.
So, keeping this patch may help for dynamic linux-user executables at leas=
t.

> Probably the right solution is to use qemu_abort() (and qemu_assert() et=
c),
> and maybe #define abort(x) qemu_abort(x).=C2=A0 Even if some way to rede=
fine
> abort like the above will work on glibc, it does not mean it will work
> on *bsd and in other contexts.

True. That's probably the better solution.

> Yes, providing its own abort() is tempting due to its simplicity.
> But it is a grey area at best.

Helge


