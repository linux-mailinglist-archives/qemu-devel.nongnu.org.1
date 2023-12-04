Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA7802DCB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 10:07:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA4tN-0005jn-Q4; Mon, 04 Dec 2023 04:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1rA4tJ-0005jW-4m; Mon, 04 Dec 2023 04:05:25 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1rA4tH-0006Bo-Gt; Mon, 04 Dec 2023 04:05:24 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-58d98188dc0so2587797eaf.3; 
 Mon, 04 Dec 2023 01:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701680721; x=1702285521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QYCtqNEEn4MNLo6m39wNgy13wLOicfFKufAAov37rDo=;
 b=c9YwUx3aE/6DxAb2FIp8rOnRrN4tJjKr18LYyI1wPDmb2VITT/VoPlSFpkMnjHC4j7
 vvAMUJ9rAXOGEyYGyXqctLGJBfbfhFXxuRK57Ih5AipddN9P2ynR2r9rqW9XIno/Ni7J
 xNNkRAOYxTkdgJ0Co0jWVb07ArgFqf2Ea7sOX1OTnXBpQCoG4/8FVR7R2bd1Bx4pQzo/
 E3tJLOqpC79w6OyGW4h/q1sk1Ruw3cUM4uOMpy7Um8g6mBIQNPzH5oXmH1u8UbUvVd7J
 n6ZuzYWyC6rPGaTDx4JxRmK1UZb/YCd12/Ie/JUXh61RCwMk0nIJSjmcybTbQ+Cmsb1I
 iPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701680721; x=1702285521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QYCtqNEEn4MNLo6m39wNgy13wLOicfFKufAAov37rDo=;
 b=W3Dllxq5CDcC9XMHdSyOmnZikRR68U40Jm1s8ABMwMaIBPzjwhVYa1u5SkE/Tl5XRl
 wOPEL5NRveHMqJuc/HCtNhf6Fjq3zMjoyNoUIlIFiWW9Vduhp4OdAXxoyA36g6JAJFOR
 paAan3P92aGHVZaYmUGEpBXw1uxeFKUDbcmzDGOc9GWz+yfjCAHvW5bejWctUU8Xu+R/
 JvRy5sDB0P7yIToQjCZH/j0iK+FN6ZXAO+nAJ2ga3pRg+JqTC66Or5S/dEaJOJyaHYVv
 f2+l0DDxZ58wvayaVKtXoz6MXIPt9v3HSazK5AbM/WK8sAsyaT14lKcjOjdZLGYLFZEc
 focQ==
X-Gm-Message-State: AOJu0YyLjXPr7NBlERUtt3sX3tBeomvvAP6G05ZVlO6u934s9+CriPiu
 LffsvoxvQshZdftHIr4iQb4=
X-Google-Smtp-Source: AGHT+IHc9QvOUAjzN4hZIUzgRdbzFyy1C6Y1KqwbRwYUg8bxpILaHmosWW47JLC67k7wPDR1L0WYOQ==
X-Received: by 2002:a05:6358:3a24:b0:170:17eb:7c54 with SMTP id
 g36-20020a0563583a2400b0017017eb7c54mr4167488rwe.39.1701680721250; 
 Mon, 04 Dec 2023 01:05:21 -0800 (PST)
Received: from [100.64.1.32] (M113150237005.v4.enabler.ne.jp. [113.150.237.5])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a62ce08000000b006ce57f2a254sm819850pfg.209.2023.12.04.01.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 01:05:20 -0800 (PST)
Message-ID: <66082b70-d898-461b-a59a-b7b6f49a1886@gmail.com>
Date: Mon, 4 Dec 2023 18:04:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] virtio-net: add support for SR-IOV emulation
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
 <f7527574-1c16-49cd-adcc-9a7ffcbe4826@daynix.com>
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <f7527574-1c16-49cd-adcc-9a7ffcbe4826@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=yui.washidu@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2023/12/02 17:08, Akihiko Odaki wrote:
> On 2023/12/02 17:00, Akihiko Odaki wrote:
>> Introduction
>> ------------
>>
>> This series is based on the RFC series submitted by Yui Washizu[1].
>> See also [2] for the context.
>>
>> This series enables SR-IOV emulation for virtio-net. It is useful
>> to test SR-IOV support on the guest, or to expose several vDPA 
>> devices in a
>> VM. vDPA devices can also provide L2 switching feature for offloading
>> though it is out of scope to allow the guest to configure such a 
>> feature.
>>
>> The new code of SR-IOV emulation for virtio-net actually resides in
>> virtio-pci since it's specific to PCI. Although it is written in a way
>> agnostic to the virtio device type, it is restricted for virtio-net 
>> because
>> of lack of validation.
>
> I forgot to prefix this as RFC. It is the first version of the series 
> and I'm open for design changes.


Thank you. I'll proceed with building and reviewing the patch content.


