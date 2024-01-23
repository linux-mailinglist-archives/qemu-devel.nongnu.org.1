Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD49F8388A2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:13:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBul-00067B-CH; Tue, 23 Jan 2024 03:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSBuj-00065I-KR
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:13:45 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSBuh-0007Qk-RO
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:13:45 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e76626170so45312555e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705997622; x=1706602422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0uBPB+s0yno4zlpBUiRr8m9f8mnWyHZ/d9uYmmrDdIo=;
 b=nezj05VVolJpLLWzI5IFA1w3VN0JHEQE2SniAnlbJI4VNdkMF+kIbC6B0OOeC6NA1f
 yw16VQjhqhbcfm/GqY39mz6+UBI/tYODwCN+QMZ625ykcTLSBqud+SsqLrujutclwPxS
 nykxAe+3hk6Vd1Bi9nUOplVaxVGI2tvZogMjZU+FJnYwo+Cpapm7ZGg6EacyVj8LGVT4
 iuCmx4r1qegjj5OypvCvGC+r7qTdEf+EJxyusErPg76f5GlNI9MJYcNP3PnnnM4gufZ8
 vVSziyDW1ZNieZ8UuVmruZIOE922csRthFDwGGMmDNRo5ut985aC7T4Bn2NYy8zm+V6s
 F76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705997622; x=1706602422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0uBPB+s0yno4zlpBUiRr8m9f8mnWyHZ/d9uYmmrDdIo=;
 b=iVZth6nemWH94ofnFiC0IEonO3zHlF+x8jxjtLaOU8Uz7xy/6QJ7oqaKDME4YTXiEs
 vpRMXLldQ5sBojgs1BCmb6VHFec/z6QacdPCOySOWaFWz1FKRzSflw4jrRuEmO5pc+PX
 fwEJ4ZA/uA71sbWVS3C06PBeGT0b3kJ9m1rcBxtGuiy6j97YnA1yz4oNjF9l2IWMHM0O
 q9quLHDOBpe3FUdnly4AUmyeFsgKz6OZtRZOcR79fzba0hb9vL7vWVk9BLWKDgSdbxO2
 9GNwc05i9pc0pewVRvV0BgEnVaxVceq02TAUdLDDJ1ED44FTGWA4oU4NE4+aD38tMKKv
 mW3g==
X-Gm-Message-State: AOJu0YwdiR0RuLHZdNc0GVWsuvlDV8B+XrrxfnVHPhHGknqPl90Nu/4s
 vIERE6kSJNhch+CyenqShxaTRREvPB3h7awzSqzxgyAjqU3M5P9zq+D0xWxQWxc=
X-Google-Smtp-Source: AGHT+IHENSWFDkoopsZu1K2QwOKh6PYbF0l7Q0ErTBtFj0vKesVcgWQ2/7w1mfcX4ZINdWdvfsfKuA==
X-Received: by 2002:a05:600c:1991:b0:40e:7b39:1842 with SMTP id
 t17-20020a05600c199100b0040e7b391842mr260093wmq.1.1705997622142; 
 Tue, 23 Jan 2024 00:13:42 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a05600c1c0500b0040e9f7dadc6sm13862021wms.25.2024.01.23.00.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 00:13:41 -0800 (PST)
Message-ID: <1c9c1750-d9c4-4743-afa4-7fafc1f82ed8@linaro.org>
Date: Tue, 23 Jan 2024 09:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/core/qdev.c: add qdev_get_human_name()
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1705938003.git.manos.pitsidianakis@linaro.org>
 <15b15d6d4f2a1706b5e2d85ab18e25bcb03e72c2.1705938003.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <15b15d6d4f2a1706b5e2d85ab18e25bcb03e72c2.1705938003.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Manos,

On 23/1/24 09:09, Manos Pitsidianakis wrote:
> Add a simple method to return some kind of human readable identifier for
> use in error messages.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/core/qdev.c         | 10 ++++++++++
>   include/hw/qdev-core.h | 15 +++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 43d863b0c5..499f191826 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -879,6 +879,16 @@ Object *qdev_get_machine(void)
>       return dev;
>   }
>   
> +char *qdev_get_human_name(DeviceState *dev)
> +{
> +    if (!dev) {
> +        return g_strdup("");
> +    }
> +
> +    return dev->id ?
> +           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
> +}
> +
>   static MachineInitPhase machine_phase;
>   
>   bool phase_check(MachineInitPhase phase)
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 151d968238..a8c742b4a3 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -993,6 +993,21 @@ const char *qdev_fw_name(DeviceState *dev);
>   void qdev_assert_realized_properly(void);
>   Object *qdev_get_machine(void);
>   
> +/**
> + * qdev_get_human_name() - Return a human-readable name for a device
> + * @dev: The device
> + *
> + * .. note::
> + *    This function is intended for user friendly error messages.
> + *
> + * Returns: A newly allocated string containing the device id if not null,
> + * else the object canonical path if not null. If @dev is NULL, it returns an
> + * allocated empty string.

In which case do we want to call this with NULL?

> + *
> + * Use g_free() to free it.
> + */
> +char *qdev_get_human_name(DeviceState *dev);
> +
>   /* FIXME: make this a link<> */
>   bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
>   


