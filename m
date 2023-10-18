Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519D7CE328
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9iw-000889-Ad; Wed, 18 Oct 2023 12:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qt9is-00087m-Po
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:48:42 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qt9iq-0001DY-Rf
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:48:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32db8924201so2591451f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1697647719; x=1698252519; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ScXxLFvrycuHZuLcW8y1GOWkWqutsobUdVs5TCopLg=;
 b=NsGTJGKZZbssDZ7d0bSvHs+/ZvGaBmNX2F/hyWbX/QgGHG/UIhmXfS+PyfiImhKL3T
 lrPmYyc2glqO5tvSrhn1dVkZs+ZH33QcR8zCr+JPXkpXrZc5V+7JxUW6tWvyqTZMRJXS
 WPkEJcndLQmaUXxOIvadBNBzfZ6sWR0c+R6Cic3Oqk/Ry1auEAZsV/uohbeZUDP43o1R
 pUPjbRacHYXoEo88k+EtiWK2X45IHMMIbdNlJhOzgrjgYdgjvdV2ErWlW6CprQ/qP0QY
 9Y6OHQhU3MH6oy1j7mXKhZXPyYLbZP7bCmLmiwPpMBmZ0X8XIuyl/s8tmpeHqjW5nfaJ
 QhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647719; x=1698252519;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ScXxLFvrycuHZuLcW8y1GOWkWqutsobUdVs5TCopLg=;
 b=uj6PeUAcxBK3ukHjDR5eaxJtpVOcbuORcYVObn4dJ0wwaozHzEdN6XJ8e4V2rNnLmP
 1UutMWEeP24yDAco3khSQpHFr11MVSwrxLopdpJPXF/4q4KvRzc4TbpWri/fz289lwOp
 ensdY8Jtd0NUIruTjK61Nwgp/D7VZ6Ax9Q5NsFaAKzky7BRfDC7nmPr2M0rXA/rwfhiE
 9Jd3OIxG/v0rrV674AdQU0hQDkqIlSsSz+uiM7+KLwmSjNoUZtAXu9cRISIRW5Wb0AIV
 T3yg6cRW6MXwQqdbETFlTAShPeE/EsNIXotKr/VmKsBkwqeEkQm3mMehZWKHKGd5ZRvD
 kBXA==
X-Gm-Message-State: AOJu0Yyexa9zNAsgcZc4yU6fDr/eZ1vKnG8fAg5C4Ncpp6OLY2Anxjzc
 OVhsEqREre4ORJwKnv42wG6QOtB1w7D7PXUE558=
X-Google-Smtp-Source: AGHT+IH1PvVzOKF0KyYw+Jesa1AjXzt4lNCG+HX/pa7bG/6wUggzYLlwdoSPY8F7KEvSUzfcbVj4tA==
X-Received: by 2002:a5d:5612:0:b0:32d:8b1a:31a7 with SMTP id
 l18-20020a5d5612000000b0032d8b1a31a7mr4822560wrv.29.1697647718833; 
 Wed, 18 Oct 2023 09:48:38 -0700 (PDT)
Received: from [10.8.0.13] ([185.223.232.243])
 by smtp.gmail.com with ESMTPSA id
 b3-20020adff243000000b003258934a4bcsm2488165wrp.42.2023.10.18.09.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 09:48:38 -0700 (PDT)
Subject: Re: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com >> Igor Mammedov" <imammedo@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "david@redhat.com >> David Hildenbrand" <david@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org
References: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
 <87o7gw9btp.fsf@linaro.org>
From: Salil Mehta <salil.mehta@opnsrc.net>
Message-ID: <cbbf59ba-b7ab-b536-12ab-91a0bfc7f1c6@opnsrc.net>
Date: Wed, 18 Oct 2023 17:48:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87o7gw9btp.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Alex,

On 18/10/2023 16:41, Alex Bennée wrote:
> 
> Salil Mehta <salil.mehta@opnsrc.net> writes:
> 
>> Hello,
>>
>> Came across below code excerpt in x86/microvm code and wanted to know
>> why 'has_hotpluggable_cpus' flag has been set to 'false' while various
>> hot(un)plug APIs have been defined?
>>
>> static void microvm_class_init(ObjectClass *oc, void *data)
>> {
>>      X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
>>      MachineClass *mc = MACHINE_CLASS(oc);
>>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>
>>      mc->init = microvm_machine_state_init;
>>
>>      mc->family = "microvm_i386";
>>      [...]
>>      mc->max_cpus = 288;
>>      mc->has_hotpluggable_cpus = false;  --------> This one
>>      [...]
> 
>  From the original commit that added it:
> 
>    It's a minimalist machine type without PCI nor ACPI support, designed
>    for short-lived guests. microvm also establishes a baseline for
>    benchmarking and optimizing both QEMU and guest operating systems,
>    since it is optimized for both boot time and footprint.


Agreed. It looks like ACPI is supported but neither CPU/Memory Hotplug 
is supported for this minimalist machine type.


static void microvm_devices_init(MicrovmMachineState *mms)
{
     const char *default_firmware;
     X86MachineState *x86ms = X86_MACHINE(mms);

    [...]

     /* Optional and legacy devices */
     if (x86_machine_is_acpi_enabled(x86ms)) {
         DeviceState *dev = qdev_new(TYPE_ACPI_GED_X86);
         qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
      /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */

         [...]

         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         x86ms->acpi_dev = HOTPLUG_HANDLER(dev);
     }
    [...]
}



> 
> Generally hotplug requires a dance between the VMM and the firmware to
> properly shutdown and restart hotplug devices. The principle
> communication mechanism for this is ACPI.

Agreed.



> 
>>
>>      /* hotplug (for cpu coldplug) */
>>      mc->get_hotplug_handler = microvm_get_hotplug_handler;
>>      hc->pre_plug = microvm_device_pre_plug_cb;
>>      hc->plug = microvm_device_plug_cb;
>>      hc->unplug_request = microvm_device_unplug_request_cb;
>>      hc->unplug = microvm_device_unplug_cb;

sorry, I also missed the definitions of the last 2 functions which says 
that unplug is not supported so perhaps these functions are only 
required to support cold plugging which corroborates with the comment as 
well.

Thanks
Salil.


