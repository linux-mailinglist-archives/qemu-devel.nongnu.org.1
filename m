Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE0176D844
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 21:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRHyv-0006bI-6W; Wed, 02 Aug 2023 15:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRHys-0006an-I2
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:58:02 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRHyq-0004B6-G8
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691006275; x=1691611075; i=deller@gmx.de;
 bh=DkBNb61nKmTPGfDiHOKfbiR7RncggpmCcdk5g31156M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=THbI6uR4LAOfhefLe80TUGxqaJ1SxzKw5FpsNO5QpZqWrIM2TVW0res9sfvG5G1Qm5cHOsk
 BqmTuQbDOxOQmUpM+2sKKOFpLuLLEiVzyc3NbgY67SWg76foEi/FUtTPD03fQGeArpVw22wu2
 DybqAuCsTxzYng85AVQFMwykzwR1uqrvLl4q/LR9V7o6RpG52XX7XvgGUNt2eoyVOFvkaowOj
 CeX2VuKEJn0wJgRIjfbkivpY1HMpWswM1Clcnbd4XpTYdAdftaA44I1mRnvmDyYu0dRGZFsWW
 cbAZ6r/GCvue5UZhK/dPycIZDLG7uJxH9gB4YIiPYrKVTXy7Iq+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1ptK8k2hSX-00ao01; Wed, 02
 Aug 2023 21:57:55 +0200
Message-ID: <781b2348-4855-d356-edf9-558ebf0b58a3@gmx.de>
Date: Wed, 2 Aug 2023 21:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 8/8] linux-user: Load pie executables at upper memory
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-9-deller@gmx.de>
 <5b57cd92-149e-5f72-d946-082ebf0bfc9c@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <5b57cd92-149e-5f72-d946-082ebf0bfc9c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lch4Fl8QiuswTTysen4guA6PZQcpiAowchD+hFDBMnXyOfAyh7e
 bhSRdWHntQop78qDBAiwUbyy1kinhrj5F3a4DL0+rLaW0TY/hf81++GHssqSShFno9O9Ghl
 muWnnysycc7sI7xTQhagrwfBkom1EQgc5P1CxNdfJfKJ5bgIA0Gnyym2N/w7dAGvlQDO8mJ
 5yBazDkcNFwpxn9BqtZ2g==
UI-OutboundReport: notjunk:1;M01:P0:bjbWGFB1X/4=;IwwJ4AX3po1xQpsdf83rvwL5nWX
 5PVv7B+k0nUxPLVay3Cbr31srgOSf0vXEYjUkEyhZ2NRs3qULF640VlH7/CPjYZTX7vRSYBQu
 sJUCo+1lXkqnLsBQhr/UrWt8NW01UfoD6EM2LkZNdL/dAwL8Aaf+jC3hUmanJFNrEubfAgP/Q
 jRQ9FgE81hh6OytZFqN0eLzSRhwzV9q5P4nXAyj4Fe1seGM/EU7SFhFAITDnZk8n7CKvzYOfu
 A62iHWSzj7FNZrLRZQFp8OA+QfjXX5ChJHQ4Nvr54hNTFYSZZ6wxjVQkGpWMr8x8nv3frXRl8
 NVPYMpP44VKzn7Winmn1WDfiUWlS2nk8gnrhsOGeuAWn83k0GlOcA5pU8TtKerGja1Y44NUXV
 t3ID8fVosSIj4GPgtfC83hmtgU9IfSPJW6+5NsUOFfiXBsUkrPND8vKTaXzwIOEKINHlYAE0H
 ZXTgQn/2nV5TeiLxuglqFxSwWyxqabhRV+vBqaQdxbnPNfOy2TZsj8ReWgDgbJazXXLrdSnb3
 WRiaU6PmUANaKjoUsl36llZ5xTudF3Sww1oOhLp4I1nJA8w4XXbmdUtcN1pfQcYQGJAVl5gts
 gi0r9/8lSMNuPKgcxueYhIWeVEkPa1MpEAc+jgGDgfPzrJyVlwAEdMjJkCRdq+Jg/jv9kzjdJ
 PZ6+r6K5soC4kcxs1H39Bh8IoZU1M0PfTCtzRs8a5JOjE36bMDSEV9TPDiBA3YPhc87bMAlBB
 yrIP0YxMXetBJVvNlI8xzafxNNEagLjAVO9WqpQsj45dg6krqs5gGDRU0ulOuVKdZKuYViLVz
 r51BEcKEaInJbYcHK3M6mZ8FOWLz1O/VNJlIelpT+wzzjR5PWvwovQJbgxPBs0mmaEs43Mh0h
 Bp7RA4a0/DG8v5pR5MCT3IpEkLDFMBWLsHR+yhfscg0SHcEu+ujcKSRVUzxB1HrCUW/8QAzUf
 izoMvaBM2TGvVI4uh5iwpnCQCT4=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 8/2/23 20:36, Richard Henderson wrote:
> On 8/1/23 16:27, Helge Deller wrote:
>> +/* where to map binaries? */
>> +#if HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 64
>> +# define TASK_UNMAPPED_BASE_PIE 0x5500000000
>> +# define TASK_UNMAPPED_BASE=C2=A0=C2=A0=C2=A0 0x7000000000
>> +#elif HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 32
>> +# define TASK_UNMAPPED_BASE_PIE=C2=A0=C2=A0=C2=A0 0x00300000
>> +# define TASK_UNMAPPED_BASE=C2=A0=C2=A0=C2=A0 (GUEST_ADDR_MAX - 0x2000=
0000 + 1)
>> +#else /* HOST_LONG_BITS =3D=3D 32 && TARGET_ABI_BITS =3D=3D 32 */
>> +# define TASK_UNMAPPED_BASE_PIE=C2=A0=C2=A0=C2=A0 0x00000000
>> +# define TASK_UNMAPPED_BASE=C2=A0=C2=A0=C2=A0 0x40000000
>> +#endif
>
> It would probably be easier to follow if you use the kernel's name:
> ELF_ET_DYN_BASE.

Agreed.

> Should be in linux-user/$GUEST/target_mmap.h with
> TASK_UNMAPPED_BASE, per my comment vs patch 7.

Maybe, but see my comments/answers there...

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* do sanity checks on gues=
t memory layout */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mmap_next_start >=3D GU=
EST_ADDR_MAX) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mma=
p_next_start =3D GUEST_ADDR_MAX - 0x1000000000 + 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> What in the world is that random number?

It's random. Idea is to keep enough space for shared libs below GUEST_ADDR=
_MAX.

> It certainly won't compile
> on 32-bit host, and certainly isn't relevant to a 32-bit guest.

That code will never be compiled/executed on 32-bit guests & hosts.
The defines for TASK_UNMAPPED_BASE take already care of that.
But I agree it's not directly visible (and probably not nice that way).

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (TASK_UNMAPPED_BASE_PIE =
>=3D mmap_next_start) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr, "Memory too small for PIE executables.\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exi=
t(EXIT_FAILURE);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> Really bad timing for this diagnostic.=C2=A0 What if a PIE executable is=
n't even being used?
>
> Both TASK_UNMAPPED_BASE and ELF_ET_DYN_BASE could be computed in main (o=
r a subroutine), when reserved_va is assigned.

Helge


