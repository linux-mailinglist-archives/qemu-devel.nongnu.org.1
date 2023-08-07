Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06870772EA4
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 21:30:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT5u1-00026a-Qe; Mon, 07 Aug 2023 15:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qT5tz-00026N-NI
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:28:27 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qT5ty-0001XD-0s
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691436504; x=1692041304; i=deller@gmx.de;
 bh=OMZL+DM9GSBe+v6llrPvk9UXb0Fol/XRO1LM3vx85Rs=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=bvxFmumijKUY/YxQosY5s8Y01g3/SQL53vpszCEyoAI82OUiTnbMRWvbM750+3dUItwRNbB
 7fLvJD+k3T7+XQ+OZE+nRRA0bjQBaqnNdDN2GEO13MAiNA1kZKx5oodBoJ3KJbD+C7iQgkQlR
 1vXNZk9vSHWbjugMD4OQpMzo3PfuxLYvMzjsK0m+cq6//PNFT87v24QCPwnxXIZCf34fI6+pa
 L7UZ+qnw7yOmw8w8Tr4ksE0NCbKBR7yrrc34KUhtpDvV4Pek8vH9YWKVtlB3G/TZVG8Jrj1tS
 a+trWZh70dQdfqal/++7UYNt+iEoANZTSHBMKQflOUReinb8geDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.150.52]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1puJFM3UwN-00aGHR; Mon, 07
 Aug 2023 21:28:23 +0200
Message-ID: <2c138519-869c-d63b-8557-9e7e40338855@gmx.de>
Date: Mon, 7 Aug 2023 21:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tcg/i386: Check for shorter instruction sequence for
 ARITH_AND
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230807142807.60719-1-deller@gmx.de>
 <ce229125-2e60-a9f4-76db-2a682f3e8009@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <ce229125-2e60-a9f4-76db-2a682f3e8009@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WI3wssCUOlvl2gbSWdndzQSC0t+Vsm4WucJOaWtgaRQpJsW4FYr
 zlamVbN9gLqkEhvoggmNJKOIVFIoKkyFJvdGELlmYLYX9Ok3DFIal57GO+uX22I8Rn35Vdz
 t3sL/UYC6F73bcMTyy7C4Eed5jv6Wm6omNN6iEA9E5RS0v4hQCffpDzEy7lLYhvDhHOYYpW
 EbV5V4EnBnYBSa1d8NimQ==
UI-OutboundReport: notjunk:1;M01:P0:K8Noox3dmqE=;yNJqIG6Y+kmTvrs3bZVmxHYay1B
 AjJjzowKuHvJ4z9rzjgJLjT2k41fG8KLIUB64K5Gc/qbwWnVOXSttDDQjnpr+ajmYvLEd1nkz
 tfhQSq4nWa/G1PMAIKKrFoftGUJTcyAmMkJXvJ9LixV1QH+//5dX3+L6wV3rih+5j8i2AQs0R
 jcKFV1OUCZ8VIAU0oPNER9Wf1pa+zu+ayJ15t05wRa6ccVA//cB8GCZ2BjgOuI/dSxZTowrwp
 9lnbjCKnnaWTMkA6PxwFmdbj9mzmeTtLJrH6GP0WWAF7xg7BqF9ZsFw38MJu5YkK27+FuU9Gg
 imOUjgTDH+hQRW8ehZC+DEVfg1t9e5qSXQd4uzqw7ALn9fufFCI1mA35CAkoxFoS0sm8eYF8t
 OoxWxJw6ye6LY++mH0wNlBk93VaVR2eO9e7UgYNimAoOl71ELZSy3nipmUk0ccX152oNrttDr
 cKbtFpcMO+WigfM2j5u0duun1AgL2DYJrQeGxejmGHq7V8SX83vRLtEzfnsJaR3geETLvTz7n
 nXYZqbGcctkR2CCY1xbI/99zsenQ8Z6GfEajFIVjczh0dJX4gSCCgARWguVwdolPYi2j85YuW
 YYS4mecCjLAWmNgEmLOt2f4K8aSFl62s7NyiDnaSGeUEmsfC3tm8WFbZKqHmzHOoSxLvGtdhF
 VhzEvq1KFnaey1DxYltU3OpyLTnnTTlAFa7kNWG+KPnGJPD6LNleWapTNjAkDDDVBJZzv52ly
 3J6AU/uj8vwEb5q/DVFFKLCDaPMD9mbWoojRaN0g+osAVtb9CNbvJN8atN2oyj9OjA/jBkpTv
 3gEpHhZrW+Q2EAT1JfVmgRZE473Pl0kkNa1uHPLOXCDcB9UQsbSsRNS8je6+Y9Ge6rqk14sVF
 kwUsHGDfHQaDoJZDNAYacYCuZ88ni4kGry+gfBGbcwgGEr4d5xwgc8v1G7EWhztHJJJ524Fvn
 R9yaaiT9pb7HRVuXzkixR7SG6kQ=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/7/23 20:57, Richard Henderson wrote:
> On 8/7/23 07:28, Helge Deller wrote:
>> The tcg uses tgen_arithi(ARITH_AND) during fast CPU TLB lookups,
>> which e.g. translates to:
>>
>> 0x7ff5b011556a:=C2=A0 48 81 e6 00 f0 ff ff=C2=A0=C2=A0=C2=A0=C2=A0 andq=
=C2=A0=C2=A0=C2=A0=C2=A0 $0xfffffffffffff000, %rsi
>>
>> In case the upper 48 bits are all set, the shorter sequence to operate
>> on the lower 16 bits of the target reg (si) can be used, which will the=
n
>> be a 2 bytes shorter instruction sequence:
>>
>> 0x7f4488097b31:=C2=A0 66 81 e6 00 f0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 andw=C2=A0=C2=A0=C2=A0=C2=A0 $0xf000, %si
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
>
> Current Intel optimization guidelines
>
> https://www.intel.com/content/www/us/en/content-details/671488/intel-64-=
and-ia-32-architectures-optimization-reference-manual.html
>
> Section 3.4.2.3, Length Changing Prefixes, suggests that using 16-byte o=
perands slows decode from 1 cycle to 6 cycles.
>
> Section 3.5.2.3, Partial Register Stalls, says that Skylake has fixed th=
e major issues that older microarchitectures had with such stalls, but tha=
t these operations have two additional cycles of delay.
>
> So on balance I don't think this is a good tradeoff.

Ok. Thanks for the links!

Helge


