Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF9A1BBFB
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 19:19:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbOGo-0005tR-0C; Fri, 24 Jan 2025 13:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tbOGf-0005qz-1G
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 13:18:57 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tbOGd-000843-6L
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 13:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737742725; x=1738347525; i=deller@gmx.de;
 bh=lSpB2598qvoa3T55lQG6Fd2ryhiYZs/AdRMWchmQX9M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=m3OXMQ7+Bpx7GYeXxbFcSbJbNvk8rPaANusKO1Lr4odY9mosE2Cn0MoiNsnfFiy5
 dUHNNowLbwHxQME2U4RSC7JDpNaDv8pFThXGkgz2TcEF1FTjUaHp7HFSvKMaoGJT/
 gfuFcat1+Cq8ZdS9IqOdb1eAISKmdUAcYFOTTAjcqmtpVpwK6hUUXASYNgftqcdCB
 HJWtxnAaEBKqTVxYV4IRcVvw0xmQwQsSxNTo2y0TtCV3Teabj07hODTk0AKzUiAWN
 1wYG0U++ZgiAFGlaMPXI7W7Ugeq3T+haGJHbJpUhjAZBTkKcNIgt3/TEHPZRI5Dg0
 KAYDZpJydbmr+HsojQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.6]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5GDv-1tTFNh3xjh-00sY9C; Fri, 24
 Jan 2025 19:18:45 +0100
Message-ID: <33756833-6110-499c-a90e-042f2d12b7c1@gmx.de>
Date: Fri, 24 Jan 2025 19:18:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/hppa: Support up to 256 GiB RAM on 64-bit machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250122180913.18667-1-deller@kernel.org>
 <20250122180913.18667-2-deller@kernel.org>
 <32a9172f-367d-4344-ae63-a9d98dfe8d9a@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <32a9172f-367d-4344-ae63-a9d98dfe8d9a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KBCgNesYIayOSZSM0YT03qxIspmGUujrBAXHeGlOzm8YTBeCJIU
 gHsH+P/QdMm0B8z8BvHFrtmnr+B0W2ZXP3OxR3pB32HS35qDqx1N6qH9MetQ5P8pRkjn30l
 F5ifX279HVN6QLCdgRxU8LdzkSmiIqqvyvmE0umh21I9uI/cwWhEPFC2ELiwTj0sBggSKm9
 2vwXJive8M8GjabOsX32Q==
UI-OutboundReport: notjunk:1;M01:P0:QFM3bQRcOwI=;foH9AlnhxDH5fA7YtQRfTLP1zz/
 pma97Xy4B97IRZpl+snUnaFphE/KSfnXbrij5X7X2iBfN4yPEJY4kERjPpcgyg3p6mJ4HmqP9
 8qypp1/mhI4sf8mhiWwufUe3Imr1wTXn/AQwqSPHWcHC2tBie1WK9jJxZb9siRjHrXUP6JGkH
 kHa73k27hhWMgzyuWL0cZXArsMrcBCIfkUr8lYSviP40DlTIrifUgWeYKwIh1Ckykma40DqJe
 23oJloyhY6z740wDWas2tN5tBzT5+Eqt80awF2JMSf0Esrahp+Zw5aXn16H1KUWzRwV3HGst3
 0fmL8Rsg3Omf8U1UDecmf9mCv26IRH8rWa3VcTZVS7ZOXMXUQobhqU4nRaTGV5lPnFCfHPzQg
 WyxJPdrhtHQ38vl5QyEuPKXpABqY+0onB1k7yfv6BNcqOO9zVb1qImI/lBbopZSMFl7/cbr9k
 +ygFb8W8cMOxfuJZ+1f0pBEE+8lB9QW3p1mzfs/yqwsnBYRzXF4L3r8iHT/P2SQd6QRS5rZGm
 iwAdHmIK8nQTd/keEjWFeskIEXkaYGbnunPWlcslsWc7InSijIFAlG9k4AZu+FzkMDVvskEZM
 zcOJg2fPJAUNyEVesrdsWuFZoy25gFLP1BmOFdK1aUExCkJxzXALq0epmGeJhEBKS18X8b/9n
 lqxyQKhewC0mHC/r5qQTBsXAGnMkKonddnH+KGtZjsX8BQ1gAAuhwfzOLxJIuINOrSSXbtv5O
 gg3/cxZ+VzYWlMlRwbrJqnLYOYbSvApwCicdQy6DIwVQYIcwIiLD+GGEdQ/PHPLySWN2R8pRV
 tAlAdk1Tn+q1xAtXEPGj7BlxZkLmJ6yZ0POsm+8v3rvcIL/Sfgw2sJQVPzYvTEk2AZwUuOeD0
 J5jkoQyRAD3ttRRvhg4u8fYv9jzbW5+8f4gl6f5w+wkYlbzjuexHh3Rg3JpLS2avZuir3z/H8
 6E3kLhjWyvvFDDZ1eXCekgQrJ+YM5lL3Yel/hO6cfKoptgJVrnAXfod4LR7a4DiejUk8VbaiA
 34DsyqrvJJJZoPbbssrrznYhW3c7V/wx3XarzT1XlcGqQGBjbSvfk+MVY8LusxZYiwpDq6fwq
 qkNr73v66GYEyi5XQwxBhIxZA68zlkkIQCHoUYAAkMOqyZ7LNVkjrLwayU+BkUgNKF+zl5z8y
 ACAD5MhUEb5INo7pkq/FKMwI7hetjl0E4SIGGrlWrczHFDZOuDA0oFF+rKP7tolS/JMR7fQwI
 DpBtc0V0LyeO+Z2NOUf9PAfjO97yRzl9zqltk+MydJwsThKpbkwHFkWUivM5ATogN/RIGbtCl
 KyOh5/Xmyzma4TZRXLJSpKiGS81Y5s+YoDqA0A6qW0JsHs=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/24/25 18:52, Philippe Mathieu-Daud=C3=A9 wrote:
> On 22/1/25 19:09, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Allow up to 256 GB RAM, which is the maximum a rp8440 machine (the very
>> last 64-bit PA-RISC machine) physically supports.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 hw/hppa/hppa_hardware.h |=C2=A0 2 ++
>> =C2=A0 hw/hppa/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26 +++++=
++++++++++++++-------
>> =C2=A0 2 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
>> index a9be7bb851..a276240967 100644
>> --- a/hw/hppa/hppa_hardware.h
>> +++ b/hw/hppa/hppa_hardware.h
>> @@ -49,4 +49,6 @@
>> =C2=A0 #define CPU_HPA_CR_REG=C2=A0 7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* store CPU HPA in cr7 (SeaBIOS internal) */
>> =C2=A0 #define PIM_STORAGE_SIZE 600=C2=A0=C2=A0=C2=A0 /* storage size o=
f pdc_pim_toc_struct (64bit) */
>> +#define RAM_MAP_HIGH=C2=A0 0x0100000000=C2=A0 /* memory above 3.75 GB =
is mapped here */
>
> Should we use ull suffix?

I prefer not to add this suffix, as this file is shared as-is with SeaBIOS=
-hppa
sources and included by the hppa assembler.

Helge

