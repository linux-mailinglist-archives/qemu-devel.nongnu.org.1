Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03379F053
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 19:21:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgTWc-0000ga-Vc; Wed, 13 Sep 2023 13:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qgTWb-0000gS-Nl
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 13:19:37 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qgTWZ-0002l2-9d
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 13:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694625568; x=1695230368; i=deller@gmx.de;
 bh=75xM+rWIQXyaTFSR7unvruDIFrwqn4c63/xxpgtuXBg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=M8cVMwRUTTtvadavTXbUgZtcZ4ei3VhvwBLNm3WjH+XsNea3M8nS/u9TtbYK9/fd+RiPvAV14Mx
 OJAqjXL16Lijs3m87JZNKN4l5k9Zc9wIYXKzMqMdGuOuAzuIHdvig3PMhNi2pdexOlPbv+/MqDK2x
 4nPftKslzd9a1LZqb6OkS6tmGAXypl5+Ngam2fedGWq/fEleF64Nma9nhlBfv7Rs9F4JjIxZxqzDa
 juaGi77gEXNTn4VETCGiGi61DzWUgKmz80I7QWogS2M+MRpTIeoqOVCKaggS6NZ6IRA+JABivA+8Y
 ANJBEEXdWRjrLivw64oR550AO/6jJacMY7iA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.157.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V4J-1rjOF52Xtf-013yvE; Wed, 13
 Sep 2023 19:19:28 +0200
Message-ID: <acc0b3f5-959c-ac8d-89e1-5c862b39a721@gmx.de>
Date: Wed, 13 Sep 2023 19:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/hppa: Optimize ldcw/ldcd instruction translation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <ZQHLcL6E5uNvjkaN@p100>
 <ba047867-db8b-8bb6-d2e7-563516c5afb6@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <ba047867-db8b-8bb6-d2e7-563516c5afb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9l/cuuHPSGtWGMvwOKp3vamSGV1C46XOprqviZOaDFTBp1vxS/h
 QHHJoBuCL67Lwh7pLsywp35RGHdOXaz/llci6K27ypMyBWHL4IKLDWXDEcA3VJOVGsZxnLD
 TrJ2aKNNJ5U80DaNefbKw1Fl9Sw6diGBxE7H+iKozxaMTYzWGNsSn584C+pwLJpj/KHspB3
 g2BX6UEojhXrjyIas8iQQ==
UI-OutboundReport: notjunk:1;M01:P0:MAjarZ+aOO0=;KhFd/iADJfTSMsKeB5Jfn1Sho5T
 BFHOG9nACdgQMaXgwvWcIxDlGCHIUFMGwU3BnKM/0PTcCMBRfVl6seuAzQ16fuf0o6GDp/rrG
 qHnmO0nIolCoP+6u7mAF4c+ecXi/4SMW0p7PgNSq4sXHA2Qr2++b0dSVm+PKDN8ySkjomJn2g
 o3tglQaxmumdS1HCBuGK8PWqYcYHSpkMc5tmS5YxPzxFV8cG5Jxf4TOS2kvJoDebHnTiJj3Gz
 kQq1+PS75NtaXDufC4igiVepVSAlaj78IiNVSdMuDHeYFf9cLCvEabDgrxxliUgVuwxOkqyku
 dvFG6o5RrJzkAGGHtOTzN2EDeJnsNyUtZcAuAg47eDs3i1tPIq+mJO8oL4kB4w6M3iIj3eXHa
 EIKQUBF+UMEn6k4FJbxIl9vTH/V2ooz1znd6VG9VSLK6puePE1+OWu6w7FGOfwaAT+3qJXv01
 glYYTNZrmzPHub4h/9fGgGWgv68Yk2PEqRxvPN7SD7fz4a2n0qlHn6lrYR9nDY42BFYP67mnG
 ZXA5t47v5uxUm7+VZckpfWHtLGNNaWONi3jrOjsXlS1HJVa4B4jzZDj/yI3LV/+ytWDJpUeBW
 ju7MdHM1Y2QNPcb+hKlgAvrI80dIHN48y1QbVbBq4QZgnop/T7BLAsYSPVpOGxldDIafvMlty
 2wiLeuD9B0YaXkQkIa0G9kON6cZP4pA4FZrG300K8ovQL0HnmzeaFtlRZ44Se29sAqWaI0F+t
 MoIYD4Yxs2HDSA0dlj1R9R6A3rELZXKVPGLroijY1weUcAuJUdj7ayHD+e+m5uqG/vvaKHeAL
 2Uk/ZjtGU6OwaW8k+29cICwwBr1w2G8nKIJ2d3pigLTxP2BpSO5ZXaWFd2QOXtBSDHNEzv3kL
 bLeTs1qpXldLNiFoa0cNNz9qcuWjpo0XRKKJnXRS/4/S0bRnkS/DxYbLI9wqSxineV1IdCxT9
 adNPdR2sR2LAIw/FXr8D/TV30Ik=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
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

On 9/13/23 18:55, Richard Henderson wrote:
> On 9/13/23 07:47, Helge Deller wrote:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 haddr =3D (uint32_t *)((uin=
tptr_t)vaddr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old =3D *haddr;
>
> This is horribly incorrect, both for user-only and system mode.

Richard, thank you for the review!
But would you mind explaining why this is incorrect?
I thought the "vaddr =3D probe_access()" calculates the host address, so
shouldn't it be the right address?

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if already zero, do not =
write 0 again to reduce memory presssure */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (old =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old =3D qatomic_xchg(haddr,=
 (uint32_t) 0);
>
> You're also dropping the required host memory barrier.

?

> Frankly, the current tcg_gen_atomic_xchg_reg is as optimized as you'll b=
e able to do.=C2=A0 I really doubt the "avoid write 0" is measurable at al=
l.

Helge

