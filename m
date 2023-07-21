Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A1475D6AD
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 23:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxoc-0001x7-M7; Fri, 21 Jul 2023 17:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qMxoX-0001wU-NF; Fri, 21 Jul 2023 17:37:30 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qMxoU-00041w-9Z; Fri, 21 Jul 2023 17:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689975441; x=1690580241; i=deller@gmx.de;
 bh=WclFy8HixT5qwPb/+ZGEipurCntvNqy3VHMXzzJnnTc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=V0Yv7obVyKkHhvOqF9G3WXSxW4VSF/kgGdopcZoZQTRc48IgplZlSxzTRQyw/xD6/c1Qedk
 ixTkRpMZyBvKg96RH9nU7+W9HfDjMyzBZq6ueyCPFjwlYC5eLPWKG9yc9GFReN0qN9/DVWyGu
 4Yz4t+sUF97J0bo/aD52/V1YYkPMcFkMGruMFSwLgno+SMG0JM1MOHnHM8YDPZ1QuNos3RxnM
 rnoILjyORNQLYCNi9Efor6YkQ26p17S0g5G4l7WWLFVN9r5Ogq6MN5Eu6b8lk3GMmK45qP+c3
 fvcC7W6lcS0K70TXZgY89CeHNX4dITlp18EVis3B8f2RQWJ4HXoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.189]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1q9A2d0dda-00Dlwy; Fri, 21
 Jul 2023 23:37:21 +0200
Message-ID: <a881af49-c2f2-3065-4e6c-8e076cd75c71@gmx.de>
Date: Fri, 21 Jul 2023 23:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 5/5] linux-user: Fix qemu-arm to run static armhf binaries
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
References: <20230719155235.244478-1-deller@gmx.de>
 <20230719155235.244478-6-deller@gmx.de>
 <68821f3a-84ce-a44a-aecb-46ad27059205@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <68821f3a-84ce-a44a-aecb-46ad27059205@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aHVEkXrS7P+hKzcdQjP6LxH8fBgpfj56M0d6Qw2svP03ZjUnZFs
 AD14JEvzVr2wdGawpeQXS+UTl+px5PqVz7XU0omLV/pVz8XxwYCWkDDAfrrUOgNRN4xLEch
 NLzCr+4ogOPLJdR0zsCndYqFRgAL3mTaB+dqr//VkaIpMnAy9E6p1P+gfF8bbZY1ngStDak
 qWYZZl+VSdk2SE2PG5QuA==
UI-OutboundReport: notjunk:1;M01:P0:PiPaQ6gjdxo=;q3ty6OeU/qNa70nEbvrchn8agd3
 GMYRgDAFUZvmV0KwQJA6FfKwBwbP86jm4vIF41IT8MRk5p1P7wNR42d3AwI7HYb6T+xs/7I5a
 m40aWQ+B2rFYPVzfd9fJQY4HAmiKpkNwYksyiWifWQ7Ym44eCDEio7i+SMHu7+KxM9/ckll//
 biLcv+otk2FuZMUgQWeo1zjjxz61iN4US83uWz0hOU2oQ/5sUI7hxn6M/LZEFr8k45CLbvH4N
 8IhfwUmvaL669y0AKDpnsxLHjmyLjVfUNWZE2nCy1ENjTW5XARgCfzfDfJLLYFff7E/vCcQoG
 FanE6+57vi8KWQn/nH5nYwYf0X/8cmjENHHhteRkECGuuE5uiWNKxJ44hPCxDA90rpixECAm2
 MTO9ajkLVvjCEDQBHEDsxDm5J19YmAFD9KXwPhTc4xgG/q9p9i+i1nJ6tqzytQRZIgaCiKvLE
 mPYd+c18R1WmYOzQ0pKeLEhllvEjgCiXPgnmegZ0LHomLmWy89MeElf252d/Q5PTc3pGfaHYT
 7s7DA0AvcKM03yqiqZK3oWw1qVzMKEkgMHcDXTSFeTXCBikBygk0kmFmOE+LbiJCebF6cUOD3
 Gxf6SrdoieZ+WwWKQTiofoUODFF5iAP7M8prYee16XDv1RtPyGaUOBY4Lrf7tza2HkNj5CYMC
 ooF2gWwk2iRVwFXeOZJegQexMfIYJuVkq8SJzDeZKWkzuY3ORcKIVribH6WCAg0f9shRVtTi8
 N8XoCqHXyMqjzO8rXuaaAk4krTJptH3q+p5Z1cE0PED+9mc7/KJ75AFtKcCYbotV2no7HTzH+
 PElh53is6028Ri/k3cbxCe2pBaJvcHom7XPVsTKHz0YIYgu16kK1YiDhJ7xz2nKfZTYC9SA78
 cR0Rwk5Aa/v/9hNxY1zeCgCFHDAYpS7Mq8BlJsJBToRKR7jmoKAx5mcwfS1nMsyQCbREMeasD
 R2FRBA==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 7/21/23 17:14, Michael Tokarev wrote:
> 19.07.2023 18:52, Helge Deller wrote:
>> qemu-user crashes immediately when running static binaries on the armhf
>> architecture. The problem is the memory layout where the executable is
>> loaded before the interpreter library, in which case the reserved brk
>> region clashes with the interpreter code and is released before qemu
>> tries to start the program.
>>
>> At load time qemu calculates a brk value for interpreter and executable
>> each.=C2=A0 The fix is to choose the higher one of both.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: Andreas Schwab <schwab@suse.de>
>> Cc: qemu-stable@nongnu.org
>> Reported-by:=C2=A0 Venkata.Pyla@toshiba-tsip.com
>> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1040981
>> ---
>> =C2=A0 linux-user/elfload.c | 7 +++++++
>> =C2=A0 1 file changed, 7 insertions(+)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index a26200d9f3..94951630b1 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3615,6 +3615,13 @@ int load_elf_binary(struct linux_binprm *bprm, s=
truct image_info *info)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (elf_interpreter) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_elf_interp(=
elf_interpreter, &interp_info, bprm->buf);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * adjust brk address =
if the interpreter was loaded above the main
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * executable, e.g. ha=
ppens with static binaries on armhf
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (interp_info.brk > info-=
>brk) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inf=
o->brk =3D interp_info.brk;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> So, this is kinda amusing.
> This broke arm64, ppc64el and s390x:
>
> arm64$ ./qemu-aarch64 /bin/sh -c '/bin/ls -dCFl *[t]* >/dev/null'
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault
>
> (it was just a quick test from debian qemu-user package).
>
> Reverting this patch makes it work again..
>
> *Sigh*.

Argh, that's really unfortunate.
I just tested myself.
Running static busybox binary did work for me:
# ./qemu-aarch64 busybox
BusyBox v1.30.1 (Debian 1:1.30.1-6+b3) multi-call binary.
BusyBox is copyrighted by many authors between 1998-2015.
....

I'd like to test dynamic binary as well, but I'm currently failing
to set up an aarch64 chroot here.
Sadly I won't have time to do any further testing until sunday evening
(travelling over the weekend).
Maybe someone else can try? I leave it up to Peter if he wants to revert
that patch right now, or if it can wait a few days until I'm back?

Helge

