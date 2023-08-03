Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D076EF21
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:10:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRatB-00063i-OK; Thu, 03 Aug 2023 12:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRat9-000632-1S
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:09:23 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRat7-000455-A7
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691078956; x=1691683756; i=deller@gmx.de;
 bh=DvKITK+xQfmhWvrHLI0Qpp0umrHZeLY2GuwdvPAvWVQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=PWSlQ7xdy1uYNZv4Wk0EEBPnOZSF1VvzfafNeQugUl+ofgOuTnrr2OW196dlHhQ9XlBc7u6
 od2Ju/wkODXIhVP48gNvVHw6nLWKlSfPEG/N8nCwlvbcwq0KhvrIKtDmnnmTUxGQTzDTz6rJB
 OUzoyzxDQsuQTk4sc9mH9vHISZNreTHCRaOtIt5NZfv2Am0698l48wxB8CCrVZfTBbkP8U3Sj
 Tesy0vFeYca963MTpCcnunrOntEHRBi6zxFrXDYeKBzOT4wAeUjV8JpNSjS6WhJmTgRRd8XTi
 /ckMm5FYURxqbfBqr8Dq875SAd3StERmhl0PsY5F6urMEdFQMdhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1pi3vt07Fl-013OW9; Thu, 03
 Aug 2023 18:09:16 +0200
Message-ID: <1be8df66-2896-de72-dbab-7e174aef79d9@gmx.de>
Date: Thu, 3 Aug 2023 18:09:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 00/14] linux-user: brk fixes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
References: <20230803015302.407219-1-richard.henderson@linaro.org>
 <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
 <cd9b0651-475d-1b11-d648-594b52d48bd1@gmx.de>
 <CACPK8XcdO4KpBfUZmxLNRLLcAOfM9D39be=m4O72kO0+_GiuQQ@mail.gmail.com>
 <ZMvBTMpi9jDVWDiP@p100> <3b08c3df-3237-284d-564f-5f14a515d59e@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <3b08c3df-3237-284d-564f-5f14a515d59e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o4uyB8ukkjgymqj9MnxkHvL74TjdZVHNEWuvNx1UMjzCR+gLEVo
 dRnepid58WMvx/bSdisUVI7XyoJERAODV0zpzOFHWuMItUHcWhochsNAr8LP6plK4CLAIsk
 +5SdAC2YdorARrIzcc/QaiImkbZtd8MPVIqNY/jT/z/6gxhIzl07v4HsIjiX5Dazk/IAwRm
 johIqmMy0n6nfZ+Id8IpA==
UI-OutboundReport: notjunk:1;M01:P0:d+fa17YSicU=;uyXTD0DqDSXMPWYl19iTtwAY2Mx
 BoYKh2gGmVs4270FwFqgYNgIe4U4xo0GcGtKS6gayAIHzvvYhNpVKteL+nthQ0ScnmY30+HlV
 SsRhQTKgDChoZSZMig8UDBlp48zwfwoXXkU2A2DHByF3LglDtrE6op64TgkXXgxjf814Jae84
 PfQtxgmGe23ub/RpyLzIzeOUDT0UNmiDdDvI5PoA1DMoGZYD3TBVa+lo9xlUnLZP+awGNoNok
 idePzc69CC0awP0W984ZWn+acaQyfjPq31rHv4QxqYdWcCOZwFhF63SUN/VV29JaGtucE+ihZ
 MxxkGuNRTl+thAacOFui3AX3bu0jmHnT3ce2tiLC8E3FqtzUqA0zkatKVIKgmghX69SvvX0U/
 o6bpjmBiXY76xF06RBh2WAfVD3Z2xChssolaRWNvziw2wY/59y+pF8bFFQoB8JlwFXVMuJUTG
 SMZozA4r456EKnI4KwKOG2HTMhV/Di4/QVqYrjwtc1y/wvvqFFjr3Kakp9FcJNmyJ55X/VFMe
 w49H3VY97K+noJ8FfqiIZd/yWN3dFzDaDGpboSphqrCeJgCtliHGdeTwdGomWtRaEiPzz/lO5
 kbZpUSduYB4diwzHHe62sWY8qLE/EIgX6svCEOrdHKN1HcOEytmIfFmAbIYvhC73SFRDJlLyM
 Fb4SdpCkS31gsS2AGgjFqjCg1rqfnihOZ+e7OteNIPeEEClUL2L00QRcNVFkGhEuEGhK7LCq9
 mXHH2ugn5JQ8V23sCDco9UunVXAe397NaC3Mu+aG3GEZqkbsi1Z3wiwmPlOLhxWF5Z3Yv0DbW
 M4MBgW05HkZSbfM5ZMgm3UIu/0/zGBD9sHhUU+8brLMxvy/NITompGw1JkxMFyd0T5tqAflPd
 qYNNSrJEANIIB45qtdv2ijwsc5CcvH3bNpIHI92jLvRKpp74LfG7h7Wm73TUAvOKfcf10MNn7
 ZXPXJkqHYYjwQRnsweSGLM4qqWo=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 8/3/23 17:11, Richard Henderson wrote:
> On 8/3/23 08:01, Helge Deller wrote:
>> * Joel Stanley <joel@jms.id.au>:
>>> On Thu, 3 Aug 2023 at 13:55, Helge Deller <deller@gmx.de> wrote:
>>>>> 143551 brk(NULL) =3D 0x0009b000
>>>>> 143551 brk(0x0009b8fc) =3D 0x0009b000
>>>>
>>>> I think the problem is the brk with 9b000 here.
>>>> It's not 64k aligned (=3Dpages size of your ppc64le).
>>>>
>>>> Please try with this patch on top of Richard's series:
>>>>
>>>>> @@ -3229,7 +3208,8 @@ static void load_elf_image(const char *image_n=
ame, int image_fd,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->end_code =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->start_data =3D -1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->end_data =3D 0;
>>>>> -=C2=A0=C2=A0=C2=A0 info->brk =3D .....
>>>> change that to become:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->brk =3D HOST_PAGE_ALIGN(hiaddr);
>>>
>>> That stopped the crashing, and the binaries seem to run fine. I tested
>>> on two hosts: ppc64le (64K) and arm64 (16K).
>>
>> Great!
>>
>> That made re-read Akihiko's patch:
>> ----
>> Author: Akihiko Odaki <akihiko.odaki@daynix.com>
>> =C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Do not align brk with host page si=
ze
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 do_brk() minimizes calls into target_mmap() by=
 aligning the address
>> =C2=A0=C2=A0=C2=A0=C2=A0 with host page size, which is potentially larg=
er than the target page
>> =C2=A0=C2=A0=C2=A0=C2=A0 size. However, the current implementation of t=
his optimization has two
>> =C2=A0=C2=A0=C2=A0=C2=A0 bugs:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 - The start of brk is rounded up with the host=
 page size while brk
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 advertises an address aligned with=
 the target page size as the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 beginning of brk. This makes the b=
eginning of brk unmapped.
>> ----
>> this patch has wrong assumptions.
>>
>> The start of brk always needs to be host page aligned.
>
>
> There is a bunch of code in target_mmap that attempts to manage
> adjacent guest pages that fall into the same host page.  Akihiko's
> patch assumes that code actually works.  Which I think is entirely
> reasonable.

Ok.

> You can't move brk up like this either (without other adjustments to
> the binary mapping), since that will leave a hole in the guest
> address space, which can get filled with something else later, which
> will definitely cause problems.

Ah, true. I have to admit that I didn't thought of that yet.
What is a possible solution to increase brk then (if you agree
that it should be increased here if necessary) ?
Call target_mmap() on the area from current brk to new brk?

Helge

