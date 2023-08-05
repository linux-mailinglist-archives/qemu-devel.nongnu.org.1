Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A63147711DB
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 21:40:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSN8G-0003me-Qz; Sat, 05 Aug 2023 15:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSN8E-0003di-Ua
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 15:40:10 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSN8C-0007ZE-OX
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 15:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691264405; x=1691869205; i=deller@gmx.de;
 bh=7vCEduohGv80XteMr1IroZoNwRe4emYkWtu6t4n5A/M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gJT8EdiSuhEvcg/8IQXKlPw1HWtDLl7OTJSrRybu54zUiF4DLOxfBrSjeDwi8ju8KZfKlrP
 bUhcSBpUSXQbRvfoMPwSiJvx4fZLwL+XTQdVydfPIGUAjtWLWL4FCnQD20fxC62W9VFxVWmpi
 vqodXgsBfitnhnDqa1dnR1b1Qiz0iw9Yn1MDgh7+36+CpTE+aNDkHzkpjVD2EUR1Vz6zbyYCB
 pJDObmrgiNIqyGde10V0zDckC7dtTWXsIh/Y6ImXI2p+qjKX8cJ7/vMeANtRCpv2F3U4Kdw1S
 WpWVoewDkykoJA8pwxKcclf/APNkDBO2qnv3o/0ueEG01KSdwWHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.145.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSt8W-1qFlRD30AQ-00UIit; Sat, 05
 Aug 2023 21:40:05 +0200
Message-ID: <a33687b2-066b-80e1-09b9-7ef108143147@gmx.de>
Date: Sat, 5 Aug 2023 21:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] Reduce generated code by 3% by increasing MMU indices
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <ZM59CkNZg5n4WXO3@p100>
 <53a2d13f-b508-0dba-5f0a-1b158372d1a4@linaro.org> <ZM6KOBfqFLumgpwm@p100>
 <e4c887b7-a055-3b30-8d41-0e8be0bc5d30@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <e4c887b7-a055-3b30-8d41-0e8be0bc5d30@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iAFQATHasnelsOSAS7JxuJMbeiZo8vVvkE/TAA13GsgFW8XS9lx
 L85tnHXAjgpgVnI6jtc5Ssj5czqqeHmcULg8rtCD6REyJG7gUL62JLMzdibe8X21TfdBK8U
 xZzdyrIcz4+N+7CuYLKXjKm+P5izFuuI/Sf/deS4p+RvvQ2d8jh1KSYYKiLj4G/nT0ZdwnX
 Z7zSztr+rkoaOqgSo7j5Q==
UI-OutboundReport: notjunk:1;M01:P0:xLAmmO0AtO0=;jTciHAbziNjGz1hB/vgmlpG1Xud
 kVLP8nLu6HFX7aYsvYLkY4nVZ3Bhx+CsW5Ux4/O09rwIU+gB1CUWDn3AZgSM2TGJogbJtAfcX
 IXFOUdNZBPwSjoP+tB5muSSCPFJrnRHG/3lsPs/2Z50RkhikmNeOHYqU/NjGT0/PXxd0Q1Ggo
 gpjTLdJyY1PZgJR2HKp9vGPtDObogRAOO8I4nUqLZDi8VemOvko104UyWIVdG+NqNnsHlCMhx
 ABh2ox1xAA82kr+rOZs0axq7v0c3jloml3QnR9HPAkAQlUP+tLdO3hT8BSZU7dEYSjv9iEqp0
 LA8Xm8v2Y5RhETA03gCMZCGeP5SyHYpBMw0kHQa+kHSEzK/CesTGRq+tcNRwsXbtBfG0/bGrm
 1pKV0RSF1jPZUmdEz56+0VRrO3NaPWGgKulrnxLF9PN+JO0PHQ6Km2CzpD6al43A646g77WXr
 2f6H9MI0dlAoveM3YwOa+tEH9bk0q3KkFovrEQWLgtiqZpVs8pq37l/T5ByO2rtQmD5YQoUk2
 JGKm92C/tgTdf85E7RM9n/pE/0vpRawHcxKFTXZViJpLdiihS7yvyQrzxWvg7PQpj6BqvzUKa
 kEnwNrzm/DK6Pd/EU4yi8TGwT+kSOz1MP1Cuf9ie8nBYFzzWeXKqJ97KifZe+3PbveQgCSazq
 TkTNY1UemQGTHdaOlZjTddBgo5chaPaepv2nH5L1Ud3lYnrDgMCofWJH0twXRz/T0FEImVD1t
 ZCZQKptA3+1jiBt/R7LV4CU2fkI5zyZ0e0fPQVM8uROHP4Kx1Upcgoqe5zOc0AalDR5iCrmJG
 I/vb4u3OUuWXwG6PUgnsj6ye4QlKjlPPxOLXte3MdP1KOoOcuH8IwPaI5wGKjGaImYmp9AqQU
 0li3NIE70yAwddxLykDbaAnN8fqE1R7lyH/q/I+W/ybH/z7nPuoi9wJZDsAT7Tn7dFXIkJq17
 vbWaZF/SkdsW8KDe9i71oGyQo70=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 8/5/23 19:58, Richard Henderson wrote:
> On 8/5/23 10:43, Helge Deller wrote:
>>> If there were a way to change no more than two lines of code,
>>> that would be fine.  But otherwise I don't see this as being
>>> worth making the rest of the code base any more complex.
>>
>> Ok. What about that 6-line patch below for x86? It's trivial and
>> all what's needed for x86. Btw, any index which is >=3D 9 will use
>> the shorter code sequence.
>>
>> Helge
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h index
>> e0771a1043..3e71e666db 100644 --- a/target/i386/cpu.h +++
>> b/target/i386/cpu.h @@ -2251,11 +2251,11 @@ uint64_t
>> cpu_get_tsc(CPUX86State *env); #define cpu_list x86_cpu_list
>>
>> /* MMU modes definitions */ -#define MMU_KSMAP_IDX   0 -#define
>> MMU_USER_IDX    1 -#define MMU_KNOSMAP_IDX 2 -#define
>> MMU_NESTED_IDX  3 -#define MMU_PHYS_IDX    4 +#define MMU_KSMAP_IDX
>> 11 +#define MMU_USER_IDX    12 +#define MMU_KNOSMAP_IDX 13 +#define
>> MMU_NESTED_IDX  14 +#define MMU_PHYS_IDX    15
>
> No.  The small patch would need to apply to all guests.

Yes.

> Perhaps something to handle indexing of CPUTLBDescFast, e.g.
>
> static inline CPUTLBDescFast cputlb_fast(CPUTLB *tlb, unsigned idx)
> { return &tlb->f[NB_MMU_MODES - 1 - idx]; }
>
> There's already tlb_mask_table_ofs, which handles all tcg backends;
> you just need to adjust that and cputlb.c> Introduce cputlb_fast with
> normal indexing in one patch, and then the second patch to invert the
> indexing may well be exactly two lines.  :-)

You're cheating :-)
But ok, that's an easy one and I can come up with both patches.

One last idea which came into my mind and which may be worth
asking before I start to hack the patch above...:

include/exec/cpu-defs.h:
/* add some comment here why we use this transformation: */
#define MMU_INDEX(nr)	(NB_MMU_MODES - 1 - (x))

target/*/cpu.h:
/* MMU modes definitions */
#define MMU_KSMAP_IDX   MMU_INDEX(0)
#define MMU_USER_IDX    MMU_INDEX(1)
#define MMU_KNOSMAP_IDX MMU_INDEX(2)
#define MMU_NESTED_IDX  MMU_INDEX(3)
...

Downside:
- of course it's a lot more than the 2 lines you asked for
Upsides:
- no additional subtaction at tcg compile time/runtime
- clear indication that this is an MMU index, easy to grep.
- easy to use

?

Helge

