Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6008388D3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:24:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSC4U-0002om-Dk; Tue, 23 Jan 2024 03:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSC4N-0002oP-1a
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:23:43 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSC4K-0000lE-Jp
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:23:42 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e490c2115so30427295e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705998217; x=1706603017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Cs5nWKYVBc+kpwNwGbUPObeH2Tdxuuvq0yhDBSfUME=;
 b=x14fg7pbEFN5PEFFAMIdpkRrrKWME0zsp9kyzwhOHT8DyPVYRLSA/Ar/1SWaV+IvbK
 lbUHT5DUCx+AXW1cWbdZpHxgLiwFH359Vd8pChL8Vr4k2aTR+cS4/eM78jmpi8zmdH3c
 FGX/BIAGwRQfFNVD7KgKiwB8RMjRR6nHqhKoQG+38RmeNNR+UDeERYUOlHLxmPZbvzmG
 27vH8+h0EN1/ZIPdXpTYpr3M1lZ/CrZET/lYpxDiY5D1RDTzACXBOUwjJNqUHcdvnWZS
 la5C0pxXFluxkh7XXP7NxnUlMlhjyNBhmjm7/uRXFid348IYKoI9f5pNReh71kQYDBol
 W3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705998217; x=1706603017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Cs5nWKYVBc+kpwNwGbUPObeH2Tdxuuvq0yhDBSfUME=;
 b=WBKuHgV0MoE3Rn3Q6h4QbUP6vjtdTikpn1E4O33RBbOK2gwsYeKAALHVa78hBT/L0D
 ALvHIcGWKENiH5OVDnXWQjUoxfml5yJM62laGzClpiX+3AVAnus6n7SGbzOq74TdFQTP
 5ypgPls+VzaDuL3ikAsq96RKkntqgGQSMF/z55EmA3mYDBC3eFbhCKvji3YX1/NAzbfx
 WYep5jumg5rWY6kT/xJ5IB0NfNvPjVReBzgBLchXdvgzuwsiNhazvpE/vlPEXgTYBfN4
 Q4obLueCtBzhEgWhPo/FylwOUBZfwFINw4m7CoouT3BoOnepqy4oniMxP1MR2mnST5xN
 TgWQ==
X-Gm-Message-State: AOJu0YxY+przsz4F1JerduJdhOFKLIZpnRWzJIOQXel5hHRmj8uoAaOM
 Xofyj8J88Pno0DVXfzFmmqk1x0nVqol5xLLLp58LKP1W/00juIi0YYPz6H4Jb40=
X-Google-Smtp-Source: AGHT+IHQDHo1He7uOJnON4TDNJxJfN0gNc6MhQPM3JP7K0y9oVYxzmpq8ZWPYBDkS6QP5i2VK5ZveQ==
X-Received: by 2002:a05:600c:4fc5:b0:40e:6ca9:98a0 with SMTP id
 o5-20020a05600c4fc500b0040e6ca998a0mr272930wmq.15.1705998217380; 
 Tue, 23 Jan 2024 00:23:37 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 w6-20020adfee46000000b00337cf4a20c6sm13077246wro.31.2024.01.23.00.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 00:23:37 -0800 (PST)
Message-ID: <625695f3-d739-4a46-8944-01447e4cdbf1@linaro.org>
Date: Tue, 23 Jan 2024 09:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/core/qdev.c: add qdev_get_human_name()
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1705938003.git.manos.pitsidianakis@linaro.org>
 <15b15d6d4f2a1706b5e2d85ab18e25bcb03e72c2.1705938003.git.manos.pitsidianakis@linaro.org>
 <1c9c1750-d9c4-4743-afa4-7fafc1f82ed8@linaro.org>
 <7pgcr.qacudqer98uf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7pgcr.qacudqer98uf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/1/24 09:15, Manos Pitsidianakis wrote:
> On Tue, 23 Jan 2024 10:13, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> Hi Manos,
>>
>> On 23/1/24 09:09, Manos Pitsidianakis wrote:
>>> Add a simple method to return some kind of human readable identifier for
>>> use in error messages.
>>>
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> ---
>>>   hw/core/qdev.c         | 10 ++++++++++
>>>   include/hw/qdev-core.h | 15 +++++++++++++++
>>>   2 files changed, 25 insertions(+)
>>>
>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>> index 43d863b0c5..499f191826 100644
>>> --- a/hw/core/qdev.c
>>> +++ b/hw/core/qdev.c
>>> @@ -879,6 +879,16 @@ Object *qdev_get_machine(void)
>>>       return dev;
>>>   }
>>> +char *qdev_get_human_name(DeviceState *dev)
>>> +{
>>> +    if (!dev) {
>>> +        return g_strdup("");
>>> +    }
>>> +
>>> +    return dev->id ?
>>> +           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
>>> +}
>>> +
>>>   static MachineInitPhase machine_phase;
>>>   bool phase_check(MachineInitPhase phase)
>>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>>> index 151d968238..a8c742b4a3 100644
>>> --- a/include/hw/qdev-core.h
>>> +++ b/include/hw/qdev-core.h
>>> @@ -993,6 +993,21 @@ const char *qdev_fw_name(DeviceState *dev);
>>>   void qdev_assert_realized_properly(void);
>>>   Object *qdev_get_machine(void);
>>> +/**
>>> + * qdev_get_human_name() - Return a human-readable name for a device
>>> + * @dev: The device
>>> + *
>>> + * .. note::
>>> + *    This function is intended for user friendly error messages.
>>> + *
>>> + * Returns: A newly allocated string containing the device id if not 
>>> null,
>>> + * else the object canonical path if not null. If @dev is NULL, it 
>>> returns an
>>> + * allocated empty string.
>>
>> In which case do we want to call this with NULL?
> 
> None I could think of, just future-proofing the NULL case.

I'd rather have a raw assert() as future-proof API, avoiding
dubious corner cases :)

> 
>>> + *
>>> + * Use g_free() to free it.
>>> + */
>>> +char *qdev_get_human_name(DeviceState *dev);
>>> +
>>>   /* FIXME: make this a link<> */
>>>   bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error 
>>> **errp);
>>


