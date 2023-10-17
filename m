Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D007CCA61
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsoV1-0008Me-5M; Tue, 17 Oct 2023 14:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qsoUy-0008HJ-GR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:08:56 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qsoUw-0005x2-Pf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697566132; x=1698170932; i=deller@gmx.de;
 bh=IPU9RU5nLvW/xrt30BLwIE1VUMfkeYPwoir/89hENQA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=S1NUPO4dF6b223ZkqO69NO9+NbtUrZ/sofPAeu93FDw4hrtKU258+Aqeu7YOGFNe4NTXUNFIwH6
 xUYSkeY2lerDIPAOpHgPGRumrGEAQZdo1HDHd02rr50HmDrIbk4Uh1jQO4LM+0Ibmd+0vDTRgTgxm
 Wzu5T0nNC41eK2cp0QlGnrrQ4wmw/QMtR6CLlvPIz/dEPvHHrnT3FYeehr4wDMKFkY7vvcHS41bWg
 08eqhXcSG/TMDtzAiIQ0DTVF5ko+JxFF/0dhWJhH4izNuGDd6VlZruUUK7I1x19R1G3Uj6yHFBKXx
 jsd9o0/KO01hV5vud6pMJvCVuT9nu9DZSThQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.254]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1r6U293qhi-00LXQv; Tue, 17
 Oct 2023 20:08:51 +0200
Message-ID: <83642a46-e782-492d-9d5a-577e439f7433@gmx.de>
Date: Tue, 17 Oct 2023 20:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] pci-host: Wire up new Astro/Elroy PCI bridge
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, deller@kernel.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-7-deller@kernel.org>
 <5ce55b97-b574-cf88-2103-f8b465a403a2@eik.bme.hu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <5ce55b97-b574-cf88-2103-f8b465a403a2@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9gSsgxjq5tEbL+7wuoqxk/11mavDu4hCovDwEJ/k3G1lrgi6AhC
 OyrgiiG7HqsJNU1ZaUuxvClQ3pNE1h2XASg6fwcUEUd/rhWTJQ5aUZJPUtLPn1UUKnC+ARA
 B80Z1clSzkU/q+d4E1ZQmrF4NQXglZEJnM8mRmwjXwgYQnM4HuxMdOBoDIzoUCTsgkZfeXm
 xbe3TJCzMUAKDiaS6mVTg==
UI-OutboundReport: notjunk:1;M01:P0:ypcMinxGfV8=;5HA7cEcbs+AL77rM6cFANNbTol/
 FcJo6/lSkC6+zWZrRras9xjHzrRJKoAYJ697bPEvz/A2K3klBZ+2I7eMzXtQq9h4MCFweg43e
 a2SOLWvpYlUjdbhcS9j96GV6sOSxi/FpC4MmtigkRnyNACLbD3AEUpi0GyvE/PAl5B0Qp037b
 qDnPqE+LKpbq9ElCLRNbwHCShmVbveIaSzQQq1HB7i+s7B7L/a5+ith9D2EYhJvaXI6ywsrw8
 qSoavNL7oF+cvPs4EYuXJB+4fFu+kS1DTf2P5+7JXc1xhZOhiYL49a66pSwLIoCO8tU9Vo6qA
 np55BJ/ppZ/lrm4kbAwWlK9MRpTqCbJFOlmVyu7yhLc66Xdiww2i4SXM/wE0YVB8NXoA4uikb
 0KGm8SGu8eu5yqYXFbCA3H66xN73kGXPlt102Ls/11C8JcwXoe+j5ftBPsUFyDQxUp/9nmlFT
 2e9kmQyyqwTjfNr/+mIDVD2PMQ98tKBhX/jQiJ2kAN6dghI6scopMX2JT0xQAeYeWGrhh7Bx6
 aKIwiZ60NYVIAV4RrpIv70cQsiCkyq+kbTRr2cP5nGoXlXKJ94VE2O+5TasKQdrZMtmyd5On4
 Kxkg27FFrTN0G9P1mkGN/d70g5JFInOC/28Rrw+4QAlcleefwO2tA6NXrh8CTUumXYnQ73ooF
 IRmVbgTfyPV7XbzASg8+LpIMq9WOmvUniG6mLt/ftz8xFgl5Bi6g4f5oezB/v3L9gmHKERKqA
 /GTdc8KxdP2SjL40pOL2u9V3YKZB3bzbWNyMJ5V7Zmhe0a5XBMmeAM8Hjga/hZqBhhtqVECKj
 gbP+NSaeUJZNM9PMoG9RQKXitXLltEcLXnvFzFc9TDb252u/TeW1DESET9zPIUzbNdCeQQ6UN
 I76VlWGLgXU78wHw28rZjhAYv9tnGQRv4H6mDSf9TfuWvlH2grGrs8Alqs6rU88/HnGnatYIj
 3MIZOyvc23oCtexNMgm3/VuEA04=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/17/23 18:29, BALATON Zoltan wrote:
> On Tue, 17 Oct 2023, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Allow the Astro source to be built.
>
> It was addded 3 patches earlier. Shuold this also be in that patch or at=
 least closer to it?

I will move it closer.

Helge

> If you think that patch is too big (which it maybe is) it could help to =
split up to simpler patches but not sure moving out build system and MAINT=
AINERS changes realy does simplify the patch for review. This are trivial =
even if in the same patch so I would not bother putting this in separate p=
atch unless there's some other reason I've missed.
>
> If you want to split that patch up to make it easier to review maybe try=
 having one patch adding skeleton or basic device first, then more patches=
 adding more functionality to it which may seem to be better than just hav=
ing these in separate patches later in the series.
>
> Regards,
> BALATON Zoltan
>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> hw/hppa/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>> hw/pci-host/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
>> hw/pci-host/meson.build | 1 +
>> 3 files changed, 6 insertions(+)
>>
>> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
>> index 5dd8b5b21e..ff8528aaa8 100644
>> --- a/hw/hppa/Kconfig
>> +++ b/hw/hppa/Kconfig
>> @@ -3,6 +3,7 @@ config HPPA_B160L
>> =C2=A0=C2=A0=C2=A0 imply PCI_DEVICES
>> =C2=A0=C2=A0=C2=A0 imply E1000_PCI
>> =C2=A0=C2=A0=C2=A0 imply VIRTIO_VGA
>> +=C2=A0=C2=A0=C2=A0 select ASTRO
>> =C2=A0=C2=A0=C2=A0 select DINO
>> =C2=A0=C2=A0=C2=A0 select LASI
>> =C2=A0=C2=A0=C2=A0 select SERIAL
>> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
>> index a07070eddf..54a609d2ca 100644
>> --- a/hw/pci-host/Kconfig
>> +++ b/hw/pci-host/Kconfig
>> @@ -82,6 +82,10 @@ config DINO
>> =C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0 select PCI
>>
>> +config ASTRO
>> +=C2=A0=C2=A0=C2=A0 bool
>> +=C2=A0=C2=A0=C2=A0 select PCI
>> +
>> config GT64120
>> =C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0 select PCI
>> diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
>> index 64eada76fe..f891f026cb 100644
>> --- a/hw/pci-host/meson.build
>> +++ b/hw/pci-host/meson.build
>> @@ -27,6 +27,7 @@ pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv=
64361.c'))
>> pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
>>
>> # HPPA devices
>> +pci_ss.add(when: 'CONFIG_ASTRO', if_true: files('astro.c'))
>> pci_ss.add(when: 'CONFIG_DINO', if_true: files('dino.c'))
>>
>> system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>>


