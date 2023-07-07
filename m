Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B1474B84A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:47:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsLX-0005OY-V6; Fri, 07 Jul 2023 16:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHsLR-0005N8-G4
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:46:25 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHsLO-0007qD-Of
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688762780; x=1689367580; i=deller@gmx.de;
 bh=iEYRgCEV/9aXbenE8fiB+w5qNBikGBOdLpTJd+tjMrA=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=k5TE/K9rWDmgHEaR2CWAkBBLJdTq7mmSaeiu0ureUrnqFHf0i4Ad2D5ZWA0dS8tnJF12UTd
 TmON2oaC3CkFG6TV7G4zmla33uA51HFTRQbXPEa4BF9XRm4x8UPZLlI6G6QalBpMx37V7mH+C
 6StFQqcu8sIJIxsKa8ni1zzNQpyTpdYJPtWTFwc0q3Is6a1oHPSSBwRGo6IZPlixDVnJvR32y
 +HA9b5BUwW1gCZcOpeftceWH+zdK5C8nXKGw9EnZ4i4QjxgILxyfWt+uNRC2lkhz/tudWcVGf
 rcWeYFM6WtE7lZC/kkn75yEWDXrNS5kSlh2jB1Mt38TQBaeB/P/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.180]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1qBlfq1SWI-00FyKl; Fri, 07
 Jul 2023 22:46:20 +0200
Message-ID: <cbcd5f29-1b0b-5e96-8c8d-779140448f03@gmx.de>
Date: Fri, 7 Jul 2023 22:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] linux-user: Fix accept4(SOCK_NONBLOCK) syscall
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230707131928.89500-1-deller@gmx.de>
 <20230707131928.89500-3-deller@gmx.de>
 <d092563a-772c-773c-3909-48820b189bbc@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <d092563a-772c-773c-3909-48820b189bbc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8PJ8KfLNzvnBJpaz0D2TDV2M8/5Ib0RJ2pYp4NKRqFgijhrd4bf
 FFuwf/6FwKhqGeKo5guk+hM2wLECKt2D77FgGlrnhAOU0RcLK2fxrz97za2FKsXvIn1a0pI
 mvxrlgTUxnbMMUa0YS4pQ6MYroAzcMg5sguDXlFUU5Xy2vKaNmVWWG5wOuu4QmA2kPTvQqv
 PNEz1lhA0360UPQz2GEWg==
UI-OutboundReport: notjunk:1;M01:P0:ToMsXf3ioQ0=;IDtNDFJ3CPmCvafAXJt1LU2GQhO
 HkOsn9Nqbbluv2GgG4jIX/Itet/x+2OUjV6p5oySLyEGf9KmjrvChorXJu/hw0wLzNwK2ParI
 GF+pAIKDFDCDSm74JNOCvO7ERw0bbSqY5oNM/qR/Ihv74+H9OUOSXqxsFF0Ts8TBih3N9sGuE
 rhAEMBuMqVBuYT5uPfrcIYE5fG6xgKv6XWCFVZh0gKB8dFLRHdvzTRHyHkuyzRN/pw8oQxvX2
 meUSPWWc+ZA4UfrvnJySIyiaCMDCU2o95iWIikf2V8kTUCab8z4k2sDpEImIWoX7chctE+49q
 WEM+74nokjbmlYMS+eKzH0OBoO2uNHM93KlusJUnMW3sMwIlwUBFYdn8yJDd5sL1tMvDzlUty
 Cv1A5SwthZaiHZbXIfjM079zEgHW7ZBcqH5e1WDDxTbCXP+/yYZw9KOo/MQ3HFFA+j3BDodc1
 Cx089uSg98X3JvlpYFxGQd5hxWB6xIy8UsMYmg6r08xjrcrKYBnMdyRWm8uM9J5YljSxAX5sX
 JRAWfYeGKFzIQEj0moTcCSrFqqtcA62686hJQnHfdMR0iaG7BBZ69rIB3ZzQIbIEx+I+qEkcY
 P6W1ld4wNWp2y2HFHYxyAaC/Q53CAJARAIycp5Qd6ie/L3XJfLMECgn+kIXqFn90di7Rw/wHl
 2YB38swnIjujs1Byc7X6DPH/pvWJiCkMDC+L15wZabkA+AnYMtnzeV5+H3IWIdOKzz55+gBP8
 WWV0g+UYhTE7ngxfKmzeY5tpcrWDcV+/M1a4qCrBqy2xCnLkTsGfrJgJk8eWodjOhr2fgDvG6
 m8ZK1haCCL5xdvzvTX8O4MRSsfr8rLtFTtEpTRsecf+Mgj+9Cn2crqje2twjwAKcJCwkdtDwb
 WCb+YJpSd5h4xO2WQ6LEOKDYIe5+/jeoFn/A96jTlhXzsbCeI6c+Q02zXboUfTntp1Xb55EGE
 1bHynQ==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/7/23 22:15, Richard Henderson wrote:
> On 7/7/23 14:19, Helge Deller wrote:
>> The accept4() syscall takes two flags only: SOCK_NONBLOCK and
>> SOCK_CLOEXEC.
>> Even the real Linux kernel returns -EINVAL if any other bits
>> have been set.
>>
>> Change the implementation of accept4() to recognize those two values
>> only, instead of using the fcntl_flags_tbl[] bitmask translation.
>>
>> Beside this correction in behaviour, it actually fixes the accept4()
>> emulation for hppa, mips and alpha targets for which SOCK_NONBLOCK is
>> different than TARGET_SOCK_NONBLOCK.
>>
>> I noticed this wrong behaviour with the testcase of the debian lwt pack=
age
>> which failed (by timeout while hanging in the read() syscall) in qemu b=
ut
>> succeeded on real hardware.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 linux-user/syscall.c | 13 ++++++++++++-
>> =C2=A0 1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 3f1e8e7ad9..9e9317237d 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -3440,7 +3440,18 @@ static abi_long do_accept4(int fd, abi_ulong tar=
get_addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_long ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int host_flags;
>>
>> -=C2=A0=C2=A0=C2=A0 host_flags =3D target_to_host_bitmask(flags, fcntl_=
flags_tbl);
>> +=C2=A0=C2=A0=C2=A0 host_flags =3D 0;
>> +#if defined(SOCK_NONBLOCK)
>> +=C2=A0=C2=A0=C2=A0 if (flags & ~(TARGET_SOCK_CLOEXEC | TARGET_SOCK_NON=
BLOCK)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -TARGET_EINVAL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (flags & TARGET_SOCK_NONBLOCK) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_flags |=3D SOCK_NONBLO=
CK;
>> +=C2=A0=C2=A0=C2=A0 }
>> +#endif
>
> Can we avoid the ifdef?

I don't know. There are multiple such SOCK_NONBLOCK checks in the code.

> Anyway, surely the TARGET bit check should not be protected by the #ifde=
f.

Ok.

Helge


