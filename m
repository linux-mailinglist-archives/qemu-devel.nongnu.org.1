Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC3A7E45E8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:21:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Oog-0004w7-U9; Tue, 07 Nov 2023 11:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Ooe-0004vj-Rm; Tue, 07 Nov 2023 11:20:36 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Ood-0006VX-5Q; Tue, 07 Nov 2023 11:20:36 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7b91faf40so69317047b3.1; 
 Tue, 07 Nov 2023 08:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699374032; x=1699978832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xLu0tUmETMeJaDlVt6Jo4W98Ahtoo7fhALzW49u2zoY=;
 b=d3I2A9lxZL3m5PiaM6rSR1KCLP+8WxlhAj5aR7c5PKV+d6e+G9ly61KzRKfnozvCpj
 IwNAhF4JWLSi6kOt5XiHZzd7yzpxJqAn+qcRnOKy1R32pgcKkegk0xYIgIkJD2ZAh1u5
 pej0K0tJ2PBo1BqQBJKIaS6UoeM14m7cixSfARlYZ71BSJ4CF45ARycO+5oS4JLeU32o
 CuB4B9oiSHunoAeSIyTs+W06vOqw5CSrYYh+1kcQr1xSjY6tGXEKMw8rc0TOy0Cb+hhq
 ih3m9Rot5c/dcyFXD6vfTZW2hjfXGJTZ49wLdctd8Ut5s8VEVqWvqk7tNMvxAALb07qy
 b28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699374032; x=1699978832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLu0tUmETMeJaDlVt6Jo4W98Ahtoo7fhALzW49u2zoY=;
 b=vl3CZerrUG/gJUFyBRikXVxzFxGCfPGUfYcMAY0IyO9WgJ8M9U50rpjPby17C63S+I
 M1+eWaHBFanVySGyfA+iDvGoTXW7NEK5Uvh4lFE0uUO8Fx/30Dk6li9s/atIXcylNl2n
 qH8Bhabu7chl2yt5MNASPtLWYx1OvHLwWYbva5IU2n3mxsrMNOq9oh+WNGk2DCwU6T+f
 KRx4e0ZbF6WuMxeeobypcX3c+z3ka4l0h01wCyKJ15MLsmowKRbKATzhy06/pMUil3nH
 s91L2CwVEwcOkakWetYNgQ76bcwX+Sats2XQ11mBkdXxa1L/L/GQanG++EpZIGMiGXes
 U84g==
X-Gm-Message-State: AOJu0Yxo7i/PywS/xkRzJH1IP2Mmkgulbpd8NoPH87XkiCk2zRtKdDyQ
 wqpub7/uA/JTAlACFIwq0MA=
X-Google-Smtp-Source: AGHT+IHBe5XRHYGHu55+xRVJTgHmLKAqwgog7YJWBM/Kv8iIBh7uvK9t1UdmVW3gNhZdYJqcAapZvw==
X-Received: by 2002:a81:83cc:0:b0:5ac:552c:3462 with SMTP id
 t195-20020a8183cc000000b005ac552c3462mr13891389ywf.41.1699374032380; 
 Tue, 07 Nov 2023 08:20:32 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a81b40d000000b0059b2be24f88sm5606307ywi.143.2023.11.07.08.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 08:20:32 -0800 (PST)
Message-ID: <aec69746-9cc6-4be4-bd06-2315886c2a1e@gmail.com>
Date: Tue, 7 Nov 2023 13:20:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <88d6fff6-b97e-7c55-bf29-6d3aa2ed690d@eik.bme.hu>
 <8cd19dfe-d4cb-ad71-c99e-51741ab71e44@eik.bme.hu>
 <360e5b93-3b80-04b1-2dbf-2fd95809859c@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <360e5b93-3b80-04b1-2dbf-2fd95809859c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=danielhb413@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 11/7/23 11:42, BALATON Zoltan wrote:
> On Tue, 7 Nov 2023, BALATON Zoltan wrote:
>> On Mon, 6 Nov 2023, BALATON Zoltan wrote:
>>> On Fri, 27 Oct 2023, BALATON Zoltan wrote:
>>>> Changes in v7:
>>>> - Increase default memory size to 512m to match pegasos2 and sam460ex
>>>> and it's a better default for AmigaOS
>>>>
>>>> Changes in v6:
>>>> - Dropped patch 1, now it's
>>>>
>>>> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
>>>>
>>>> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PCI IDE controllers)
>>>> - Added Tested-by from Rene
>>>>
>>>> Changes in v5:
>>>> - Fixed avocado test
>>>>
>>>> Changes in v4:
>>>> - Found typo in comment in patch 1 so ended up rewording it again
>>>> trying to make it more concise. Also take the idea of using
>>>> range_covers_byte from Mark's patch
>>>> - Added RFC patch for avocado test (untested, I don't have Avocado)
>>>>
>>>> Changes in v3:
>>>> - Update values, comment and commit message in patch 1 again
>>>>
>>>> Changes in v2:
>>>> - Update comment and commit message in patch 1 (Mark)
>>>> - Fix irq mapping in patch 2 (Volker)
>>>>
>>>> Regards,
>>>> BALATON Zoltan
>>>>
>>>> BALATON Zoltan (3):
>>>>  hw/pci-host: Add emulation of Mai Logic Articia S
>>>>  hw/ppc: Add emulation of AmigaOne XE board
>>>>  tests/avocado: Add test for amigaone board
>>>
>>> Nick,
>>>
>>> Will you please send a pull request with this now? It's independent of the IDE fix which as a bugfix so can wait a little more but this series should be merged before the freeze starts tomorrow. (As this adds a new machine and does not touch anything else it can't break anything either.)
>>
>> Is there a PPC pull request in the making with this series in it? It would be really sad to miss the release not being able to merge such a simple series for weeks. As I said this is independent of any other fixes so I'd like to get this in now please.
> 
> Nick seems to be away so please Cédric, Daniel, Phil or whoever can send a pull request step in and please take care of this. This was posted a month ago with this last version on the list for 1.5 week so I'd hate to miss the release and wait until Easter next year to get this out to users because none of the maintainers are available before and arounf the freeze.

Wait, do you think we would miss code freeze?

Code freeze in QEMU is a blast! People getting mad because stuff got left behind,
PRs getting remade over and over because gitlab is nagging about something, new
bugs introduced, sometimes master doesn't even build the following week. We might
miss any other boring date like release date or something, but code freeze? Nah,
we're right here man.

The reason why we didn't interfere is because it's rude to short-circuit the
maintainer on duty. Nick didn't send an email asking for help, so we were just
monitoring.

I'll consider Nick AWOL and take this PR. And don't worry, it's still sunny in
Brazil, we have plenty of time.


Thanks,

Daniel

> 
> Regards,
> BALATON Zoltan
> 
>>>> MAINTAINERS                             |   8 +
>>>> configs/devices/ppc-softmmu/default.mak |   1 +
>>>> hw/pci-host/Kconfig                     |   5 +
>>>> hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
>>>> hw/pci-host/meson.build                 |   2 +
>>>> hw/ppc/Kconfig                          |   7 +
>>>> hw/ppc/amigaone.c                       | 164 +++++++++++++
>>>> hw/ppc/meson.build                      |   2 +
>>>> include/hw/pci-host/articia.h           |  17 ++
>>>> tests/avocado/ppc_amiga.py              |  38 +++
>>>> 10 files changed, 537 insertions(+)
>>>> create mode 100644 hw/pci-host/articia.c
>>>> create mode 100644 hw/ppc/amigaone.c
>>>> create mode 100644 include/hw/pci-host/articia.h
>>>> create mode 100644 tests/avocado/ppc_amiga.py
>>>>
>>>>
>>>
>>>
>>

