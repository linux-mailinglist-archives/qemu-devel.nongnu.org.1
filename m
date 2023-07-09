Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F074C138
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 08:14:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qINfD-0000O8-3H; Sun, 09 Jul 2023 02:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qINfB-0000Ml-1D
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 02:12:53 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qINf9-0004v2-C7
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 02:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688883169; x=1689487969; i=deller@gmx.de;
 bh=Tj0XptSyUBg7oAa1qmjLkGpGO3n8ZdZ+e1mepCexfPI=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=Dkdsl7e9WZQG0IXqWtnvL6odwBbVmICVIYVYk5zn+vi8IwdY5Ij/3BipA7lDDE/tHH6ZJP/
 XpbwQo364u6Ybj7tLrz36XacFmkAnqcmGR9VzFWLJfVA8jWdNoTtFKOSaMc7xNYH1Usaa9o8N
 LE5UHDc0+E7HZPrr0uQv5Crl8YN9sElRYhMjYhi4IkBcAVX1jdvJlsrr/E+mfREI6VdpV9HGi
 3verVCnDzctJwEEfnXqAT+1beoW7wdVNcnKT+SRKOqWSN5XMhkNU2MHzavzKZyfMd7WzSAo3Z
 C3G9uq5+hse5EXWYGSfmLx+7ZOm5DrZVZlhGyvdprN01Nhyq6AuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.150.9]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1qc7RZ1oq0-00OCf8; Sun, 09
 Jul 2023 08:12:49 +0200
Message-ID: <ce6660a7-e878-0e36-3cc2-ba3de1dbdea6@gmx.de>
Date: Sun, 9 Jul 2023 08:12:48 +0200
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
X-Provags-ID: V03:K1:q/cRmDdH3JPOz/rqQ5Q+na6aZEW5LG/o13hQf8dPHCxN1IdS8pd
 H0o5xIYprBN6fS41wZgB8yuvJqcBbM5L6whGZm0PynwlW5huOvAP+WBIYRaDhWnrblC/shi
 lfuWBdcEcyaH3MruV+t1IKiokqNCTLh/xenanu4YEBYU8CKL1bMIvgYfYjrKJU8GSjv8Tp+
 MXhuk8g58dZtoArhvXG/Q==
UI-OutboundReport: notjunk:1;M01:P0:KTL+2hB8oS0=;sRJZZJzz04sqSYUROxyXnE8r6WV
 rDuKoy0yWnlQTPyPUXBfjBhy2xvDSwKXGht+G0IJCB8IYOcSfWrkDLRZRKexAnhs35ZypPwyl
 LMHkYgff9VzXSXlemOw1yFgw7W5Uicqb1eu5EsEmwEpLVsdPbu90uBEIpL3eyF+BiNDhYwhMe
 rdsIjcRm3JrNxV+mQU7ggCxFUst13vOwA8hNxRyg85scfTButKvLSzWnWBB8QYd/Cp5A1QBYN
 ujfoNIgWfphRJ48VG0rvhjeuJuobki2w4UfodIMSVtcrdRyG5DgbJU2Tg14MKYq99unZ1NfT6
 j4lABiDcyKOQHCRsN2maBetOwqnyM7NJi9xEBQ6YdWki5Sd45AFqtQdK+DVgYZt9hKWbiZMIs
 gFwX92kiNxtyPFjS9vpqPUXqJFNYHOvGGU7AsfPLnkZFEiXJSEbUZUrDw+0pypgezbPqxJHr3
 +ZzVXlCHrcqqrlkMtXLpWsd68d3V40VfQic4EMbiT+SzdPuPTUQS+TUN/yv0LmAS3nTiGgXgl
 6UtPZSW2+laA/fHiRuPtr8ED2GkSEeBM8ZPXbu6onLL7RloBn4N+RkZv9c7YtKCovT1QYDSWB
 aemMykAsK2YRJTAPTr5D413BMh38Zf1mDKF0T3Mj1HCrPhOZWF/ypCyzPrMF0StQAp1DM6jMr
 GhEbySe4yUPb0Q4wTPP/PqSWlefLOiMsKWkWFz1Gp7/nSL1LG1d6thTnh65RshfPZjuaUycLx
 Kg+ReJOmmiI9W7WvtAhNFrDuXNgS0EBtFKLlPzYc+/l3JZ8p01U746BI+NJ7aTAri6Wp3B7qC
 y6PYu0sBOPLjWYR9P6gmeyanG9AYUBMG8gmABD1wgL8/nYbmEYDFQ8tr+qcAQdmhAQ0c4GMMS
 8JC4l9RCMgEMTrkNar973QXZv2f6ThaRXyF4OiVTztD7E10qQk+r+g+fQE7NDVz3TKUSenOea
 tBRnwQ==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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
...
>> I'm curious why this error might have produced host memory clobbering, =
but I'm not going to debug that.
> I don't believe that this un-alignment triggers host memory clobbering e=
ither.

See my follow-up in the other mail threadd:
"Re: [RISC-V] ERROR:../accel/tcg/cpu-exec.c:1028:cpu_exec_setjmp: assertio=
n failed: (cpu =3D=3D current_cpu)"

Helge

