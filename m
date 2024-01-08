Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3637827636
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:21:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMtJL-0005oE-UG; Mon, 08 Jan 2024 12:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rMtJ6-0005nX-IZ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rMtJ4-0002Kq-Qg
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704734457;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kz86XglzKya1JrJrqtPyqKmPBmHQSsaTup+L8UNqoRU=;
 b=ENWJUiscBJYmZVgrRQBi8eExl32Be+h2FdDfXL7Td0w46ZyFNe9cAiw/kEeRmjauN1qPHM
 KwIvoo9ZHFXLT+I4f4yrSNsHkqefAUwodvirpuzyYABY1Lk3IuWIuide6pj81af3+ak9+a
 SsLU3pSkQZqFndH5TtqFQD4Qi30whU0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-kZSlziQDMV2CFNZMvLiFqg-1; Mon, 08 Jan 2024 12:20:56 -0500
X-MC-Unique: kZSlziQDMV2CFNZMvLiFqg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-427c1f943dbso39148981cf.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 09:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704734455; x=1705339255;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kz86XglzKya1JrJrqtPyqKmPBmHQSsaTup+L8UNqoRU=;
 b=iOS7s8XV6PDusdr4F02X4aNh+aVknMTMdZPBR6v3l78RvHPaHzhr32NvnfM25am4JF
 YA6+8r6NuzWH430box9DgHex3c6nr+YE7uc3++maWIvK3ytcuIhR5pJOfL1Ws2JzTi7s
 +hjuNAxSPJlgU0pk5CY3asPrHuqiAoQuHomBbxo01taNtbRYLPnFymuAu4NRYXCZG0kY
 JgzU6ZDfAevFu9P37XF31yLFBQxxJsSn7m/AwsYWgS43rf3aUFm4/Ym8uU1h3vcleiL5
 8zL9cq2sVDyRtKIyTQgTLgIQMlvhtFxCyNmk4RSDCn6PiUZ3jpSpO4DuTBOXa59AfYYP
 mNYA==
X-Gm-Message-State: AOJu0YxCUmo0dklnrKh1RYeAI2CfJMK6pDf7i55NBJGdSmE0ROf0JEWu
 ukWdg9IkW2R12oTA3hHWIfoeoNpfBQm2jmCFCuVhRMOIfDR2PqZodsShPzuUJlDhBSOBor0CYYG
 qGE3Hjwb/+dkdN7qmNGkVykI=
X-Received: by 2002:a05:622a:2d1:b0:429:8cbd:312 with SMTP id
 a17-20020a05622a02d100b004298cbd0312mr4303498qtx.1.1704734455703; 
 Mon, 08 Jan 2024 09:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgjViadEtNZdLn9y/WkHI8CflDuOnFjOEBDmll6Riop0ydFVR3whgq+QXBFq7g0oiGkiry6A==
X-Received: by 2002:a05:622a:2d1:b0:429:8cbd:312 with SMTP id
 a17-20020a05622a02d100b004298cbd0312mr4303491qtx.1.1704734455438; 
 Mon, 08 Jan 2024 09:20:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a05622a025200b00427ee66bec1sm59747qtx.48.2024.01.08.09.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 09:20:54 -0800 (PST)
Message-ID: <7771970b-569a-4123-b64f-d6ac3272aac8@redhat.com>
Date: Mon, 8 Jan 2024 18:20:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PULL 13/28] hw/arm/virt: Use 256MB ECAM region by
 default
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20180622125713.15303-1-peter.maydell@linaro.org>
 <20180622125713.15303-14-peter.maydell@linaro.org>
 <CAFEAcA9ZQ7FCS=eTCvPNy+knpeia6r4GrF2UN5W2bE6znvonSA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA9ZQ7FCS=eTCvPNy+knpeia6r4GrF2UN5W2bE6znvonSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 1/8/24 16:52, Peter Maydell wrote:
> On Fri, 22 Jun 2018 at 14:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> With this patch, virt-3.0 machine uses a new 256MB ECAM region
>> by default instead of the legacy 16MB one, if highmem is set
>> (LPAE supported by the guest) and (!firmware_loaded || aarch64).
>>
>> Indeed aarch32 mode FW may not support this high ECAM region.
> This is a rather old change by now, but I've been looking
> at it because it exposes an issue which was previously
> masked by a different bug...
>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index d8abf89e8c8..0f8bfa57d7e 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1318,6 +1318,7 @@ static void machvirt_init(MachineState *machine)
>>      int n, virt_max_cpus;
>>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>> +    bool aarch64 = true;
>>
>>      /* We can probe only here because during property set
>>       * KVM is not available yet
>> @@ -1433,6 +1434,8 @@ static void machvirt_init(MachineState *machine)
>>          numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
>>                            &error_fatal);
>>
>> +        aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
>> +
>>          if (!vms->secure) {
>>              object_property_set_bool(cpuobj, false, "has_el3", NULL);
>>          }
>> @@ -1491,6 +1494,8 @@ static void machvirt_init(MachineState *machine)
>>          create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
>>      }
>>
>> +    vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
> Do you remember why this conditional is the way it is?
It comes from Laszlo's suggestion at
http://patchwork.ozlabs.org/project/qemu-devel/cover/1527091418-11874-1-git-send-email-eric.auger@redhat.com/#1920422

"I'd rather restrict the large/high ECAM feature to 64-bit guests (with or without
firmware), and to 32-bit LPAE kernels that are launched without firmware
(which, I think, has been the case for most of their history)."


See the associated thread too.

Hope this helps

Eric
> As it stands, it will disable the high-memory ECAM for
> an AArch32 VM that's loaded firmware, but leaves it enabled
> if we're direct booting Linux. That's a problem because 32-bit
> Linux falls over if you pass it a highmem-ECAM, even if LPAE
> is enabled (somewhere along the line it discards the high 32
> bits of the address of the ECAM in the dtb, so it thinks the
> ECAM overlaps with another memory region, and won't recognize
> the pci controller; I have a feeling this is a regression in
> the kernel). Plus, we have no way to tell if the guest
> kernel has LPAE enabled at all.
>
> Maybe it would be safer to insist that the guest is aarch64
> before we enable highmem ECAM?
>
> thanks
> -- PMM
>


