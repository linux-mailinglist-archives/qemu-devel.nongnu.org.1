Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE177E1ECC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:47:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzx8i-0000rp-TF; Mon, 06 Nov 2023 05:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzx8c-0000rI-23
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:47:23 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzx8a-0000gc-8v
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:47:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso33326335e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699267638; x=1699872438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5EO+xei+x63I3PifURIzHBwc9LdKsJbTgSbVovdZ4I8=;
 b=wtALa73/cDFXhUvp5R6w3JxJLYcTD4gUdrNSsjJrF9G4RMbJkcTWiT7rdVan7A+3Y6
 r+kqr4rm66sMpqn+6dyPdROFgj/B/mdpO2vY3fa8p4E+PtTWHaeTcECl0t3Dpv4xLGZJ
 KE5Zd0PLtGTsTUtDsfqCYLRfk+j+O5EoEytHDOoQ2dVOJ21hnAfaXhTuOUIxT4N0czz2
 A5YmNXM4ba1sAfUWj4zJBxwdhecbnSyqlnTxB84IVLVFqdRGjQZCdFvIxCEuL69XeeOu
 l9KL0zO+pgkeIWNPw4U2rV//6QD0uqtsK8OPYY/REfYmgN3Eh0pND6locJcsWmH1szG8
 pEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267638; x=1699872438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5EO+xei+x63I3PifURIzHBwc9LdKsJbTgSbVovdZ4I8=;
 b=vgdqViP5+vRDJzhltjthLPPQ6DJQ1mTx+2D++4x5SQsEwTeGFZausPUkCeCRf42fMw
 lnVNZkmB9cy+Kq6xL4jXmp9ocYxayDs7t44GkbshYVcAqTPaCkr3YQvnBJ+nUnCEJl9r
 lPEXfsTfJ8c54HoYobq5osNHVb5b7S0MBgbRexTEW/An2CT/H5hetVddLeruq68bUOvt
 O5+HTVGv9qIdFvcVE7rXsYV9LIyn/z2/cwiV1RjBH/XHEriX4sQwe16PJKucLYmuULP5
 4JESSq+O2vAKYsPwAEJv5X6wnJ7sg7/QZAlDHBZJx/kQNf6tHvdNKEoVi6eMLxuUcRhv
 XkMA==
X-Gm-Message-State: AOJu0YxgihdPAAJMQqFeLQPUkZUrokBduHDvArSn5/7YWCutml/OfjkZ
 gKeW2uUGLnTuI01+7rxwAel8pg==
X-Google-Smtp-Source: AGHT+IHrLf3nDZIzRc1qjaOHDm1PZ4ES/FVE/z8t1gKxI01JU3pmAmNXj/4j/mNbIoN+170j46aWIw==
X-Received: by 2002:a05:600c:458f:b0:408:3ac4:dc3f with SMTP id
 r15-20020a05600c458f00b004083ac4dc3fmr24222110wmo.29.1699267638555; 
 Mon, 06 Nov 2023 02:47:18 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 h21-20020a05600c499500b0040586360a36sm11522703wmp.17.2023.11.06.02.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 02:47:18 -0800 (PST)
Message-ID: <5f8901af-17e7-daec-4e02-ba1df3f5dbb6@linaro.org>
Date: Mon, 6 Nov 2023 11:47:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL v2 22/24] hw/display: make ATI_VGA depend on PIXMAN
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
 <20231106095542.1852973-23-marcandre.lureau@redhat.com>
 <4da573ce-756e-d31b-5c13-4e0f8245dd08@linaro.org>
 <CAJ+F1C+c73Aura=JEWyp7z4_3eiNzV1Z8BOeURjJ+2YUucatCA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1C+c73Aura=JEWyp7z4_3eiNzV1Z8BOeURjJ+2YUucatCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.137,
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

On 6/11/23 11:11, Marc-André Lureau wrote:
> Hi Philippe
> 
> On Mon, Nov 6, 2023 at 2:03 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Marc-André,
>>
>> Cc'ing Fuloong maintainers,
>>
>> On 6/11/23 10:55, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> To avoid a kconfig cycle, change "depends on PCI" to "select PCI".
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>    configs/devices/mips64el-softmmu/default.mak | 3 +--
>>>    hw/display/Kconfig                           | 3 ++-
>>>    hw/display/meson.build                       | 2 +-
>>>    hw/mips/Kconfig                              | 2 ++
>>>    4 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
>>> index d5188f7ea5..4d80d60511 100644
>>> --- a/configs/devices/mips64el-softmmu/default.mak
>>> +++ b/configs/devices/mips64el-softmmu/default.mak
>>> @@ -1,9 +1,8 @@
>>>    # Default configuration for mips64el-softmmu
>>>
>>>    include ../mips-softmmu/common.mak
>>> -CONFIG_FULOONG=y
>>> +#CONFIG_FULOONG=y
>>
>> Why is the justification to disable this board? From the
>> bare "avoid a kconfig cycle" commit message, it is not
>> obvious to me.
> 
> It's not actually disabled, it's enabled by default in kconfig.

OK, so let's remove the line entirely, not comment it, please.

With that,

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>>
>>>    CONFIG_LOONGSON3V=y
>>> -CONFIG_ATI_VGA=y
>>>    CONFIG_RTL8139_PCI=y
>>>    CONFIG_JAZZ=y
>>>    CONFIG_VT82C686=y
>>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
>>> index 1aafe1923d..8219225a1c 100644
>>> --- a/hw/display/Kconfig
>>> +++ b/hw/display/Kconfig
>>> @@ -125,7 +125,8 @@ config DPCD
>>>    config ATI_VGA
>>>        bool
>>>        default y if PCI_DEVICES
>>> -    depends on PCI
>>> +    depends on PIXMAN
>>> +    select PCI
>>>        select VGA
>>>        select BITBANG_I2C
>>>        select DDC
>>> diff --git a/hw/display/meson.build b/hw/display/meson.build
>>> index 9c06aaee20..344dfe3d8c 100644
>>> --- a/hw/display/meson.build
>>> +++ b/hw/display/meson.build
>>> @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
>>>
>>>    system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
>>>
>>> -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d.c', 'ati_dbg.c'))
>>> +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
>>>
>>>
>>>    if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>>> index ac1eb06a51..5d40795c0b 100644
>>> --- a/hw/mips/Kconfig
>>> +++ b/hw/mips/Kconfig
>>> @@ -32,7 +32,9 @@ config JAZZ
>>>
>>>    config FULOONG
>>>        bool
>>> +    default y if MIPS64
> 
> It's now enabled here by default for mips64
> 
>>>        select PCI_BONITO
>>> +    depends on ATI_VGA
>>>
>>>    config LOONGSON3V
>>>        bool
>>
>>
> 
> 


