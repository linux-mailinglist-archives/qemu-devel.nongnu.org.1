Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E27D66DD
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:33:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaFr-0003gj-Hb; Wed, 25 Oct 2023 05:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qvaFY-00033h-UT
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qvaFP-0002KO-MB
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698226337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TJ63VXOqyBt7LmBcxMZmamsJNmDnngr20ijU0m4FNhE=;
 b=cXNS8Z0F20HjsNBfXmXinnf1XalRrSNgusCEd0FCWAI1TAqXw85mL+ojOQW37J4k1AsXDK
 tAOq6vZW8QNrUgQljnIADWOVQnt5QdmucJM2DJ+6zGygYdg2TnZ44l56otPVqClJ9N4KAC
 fyEdlNxCFqRVJlH7UjIgr0w6OsH3Xfc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-BpWu64iHPAyErt8W_ntDmw-1; Wed, 25 Oct 2023 05:31:59 -0400
X-MC-Unique: BpWu64iHPAyErt8W_ntDmw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c506abc320so46380701fa.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698226318; x=1698831118;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJ63VXOqyBt7LmBcxMZmamsJNmDnngr20ijU0m4FNhE=;
 b=evoxFVHau+/dLZ4HKJNT3HoC4K2g+McFBCtGUn59sfa5QvX3NIcVxCIQpImhESHor5
 fEokpmryW9Jt4oIw3EAHUA6vdGRHW3DhnME8mmVhMzzQo7hSJpsWe/WL73vpiwBaFHYO
 PLaLlbIsB9DpS83i1vl6pLb6fNJExnLBtukHbFIqmojelNPgTyDMJzZ94tlXsDk7Uybn
 zvfZE28ZW49f6OLUY9CXZ3ykfABZbilskSOEuTBzD/ScLCnt990qSsFqZeVVg1aVcIYS
 i4HtqgcoYuPyjd156QJzANNUuvprxVC71Nps2yLBuOXuaIzTk/3ZJR5wNCT0l2u3eh3a
 h5Ow==
X-Gm-Message-State: AOJu0YzGSsww/ki3kKPSDg2b1DOaOB5bL7W7BuL9elFEEQK5iCmE43sG
 gpgNFeA5Q3BbKejWj/1PXCYQFZSFimwV0F9fyy5S/biGJ9T14ZMs+Pby95w0fL0VJ1EKn8DhyI6
 Ipmjz3ucu5jN73k4=
X-Received: by 2002:a2e:b712:0:b0:2c5:47f:8ff7 with SMTP id
 j18-20020a2eb712000000b002c5047f8ff7mr11018898ljo.18.1698226318229; 
 Wed, 25 Oct 2023 02:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7R7BVqGyjrXebH0p4FO/FqXHADjLMPfCX+8V2rL5U537y+JQA0hL3IapIvjAWJORbeT3IAg==
X-Received: by 2002:a2e:b712:0:b0:2c5:47f:8ff7 with SMTP id
 j18-20020a2eb712000000b002c5047f8ff7mr11018879ljo.18.1698226317739; 
 Wed, 25 Oct 2023 02:31:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8100:1fcd:5169:391e:99af?
 (p200300cbc70881001fcd5169391e99af.dip0.t-ipconnect.de.
 [2003:cb:c708:8100:1fcd:5169:391e:99af])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c471300b00405959bbf4fsm14307792wmo.19.2023.10.25.02.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:31:57 -0700 (PDT)
Message-ID: <1055386d-2706-4ce2-b190-106510bee52c@redhat.com>
Date: Wed, 25 Oct 2023 11:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
To: Salil Mehta <salil.mehta@huawei.com>, Igor Mammedov
 <imammedo@redhat.com>, Salil Mehta <salil.mehta@opnsrc.net>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
 <87o7gw9btp.fsf@linaro.org> <cbbf59ba-b7ab-b536-12ab-91a0bfc7f1c6@opnsrc.net>
 <20231024100554.3ef76ebf@imammedo.users.ipa.redhat.com>
 <f8bad7bdf7ea42b08d52970c47ea101f@huawei.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f8bad7bdf7ea42b08d52970c47ea101f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25.10.23 11:16, Salil Mehta wrote:
> Hi Igor,
> 
>> From: Igor Mammedov <imammedo@redhat.com>
>> Sent: Tuesday, October 24, 2023 9:06 AM
>> To: Salil Mehta <salil.mehta@opnsrc.net>
>>
>> On Wed, 18 Oct 2023 17:48:36 +0100
>> Salil Mehta <salil.mehta@opnsrc.net> wrote:
>>
>>> Hi Alex,
>>>
>>> On 18/10/2023 16:41, Alex Bennée wrote:
>>>>
>>>> Salil Mehta <salil.mehta@opnsrc.net> writes:
>>>>
>>>>> Hello,
>>>>>
>>>>> Came across below code excerpt in x86/microvm code and wanted to know
>>>>> why 'has_hotpluggable_cpus' flag has been set to 'false' while various
>>>>> hot(un)plug APIs have been defined?
>>>>>
>>>>> static void microvm_class_init(ObjectClass *oc, void *data)
>>>>> {
>>>>>       X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
>>>>>       MachineClass *mc = MACHINE_CLASS(oc);
>>>>>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>>>>
>>>>>       mc->init = microvm_machine_state_init;
>>>>>
>>>>>       mc->family = "microvm_i386";
>>>>>       [...]
>>>>>       mc->max_cpus = 288;
>>>>>       mc->has_hotpluggable_cpus = false;  --------> This one
>>>>>       [...]
>>>>
>>>>   From the original commit that added it:
>>>>
>>>>     It's a minimalist machine type without PCI nor ACPI support, designed
>>>>     for short-lived guests. microvm also establishes a baseline for
>>>>     benchmarking and optimizing both QEMU and guest operating systems,
>>>>     since it is optimized for both boot time and footprint.
>>>
>>>
>>> Agreed. It looks like ACPI is supported but neither CPU/Memory Hotplug
>>> is supported for this minimalist machine type.
>>>
>>>
>>> static void microvm_devices_init(MicrovmMachineState *mms)
>>> {
>>>       const char *default_firmware;
>>>       X86MachineState *x86ms = X86_MACHINE(mms);
>>>
>>>      [...]
>>>
>>>       /* Optional and legacy devices */
>>>       if (x86_machine_is_acpi_enabled(x86ms)) {
>>>           DeviceState *dev = qdev_new(TYPE_ACPI_GED_X86);
>>>           qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
>>>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
>>>        /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
>>>
>>>           [...]
>>>
>>>           sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
>>>           x86ms->acpi_dev = HOTPLUG_HANDLER(dev);
>>>       }
>>>      [...]
>>> }
>>>
>>>>
>>>> Generally hotplug requires a dance between the VMM and the firmware to
>>>> properly shutdown and restart hotplug devices. The principle
>>>> communication mechanism for this is ACPI.
>>
>> firmware part in cpu/mem hoptlug usually provided by QEMU by the way of
>> ACPI tables (which may contain AML code that handles dance with QEMU
>> while exposing standard interface to guest OS to handle hotplug)
>>
>>>
>>> Agreed.
>>>
>>>>>       /* hotplug (for cpu coldplug) */
>>>>>       mc->get_hotplug_handler = microvm_get_hotplug_handler;
>>>>>       hc->pre_plug = microvm_device_pre_plug_cb;
>>>>>       hc->plug = microvm_device_plug_cb;
>>>>>       hc->unplug_request = microvm_device_unplug_request_cb;
>>>>>       hc->unplug = microvm_device_unplug_cb;
>>>
>>> sorry, I also missed the definitions of the last 2 functions which says
>>> that unplug is not supported so perhaps these functions are only
>>> required to support cold plugging which corroborates with the comment as
>>> well.
>>
>> this function are usually used for both cold and hotplug of bus-less devices.
>> They provide an opt-in way for board to wire up such devices (incl. CPU).
> 
> 
> Sure. I understand but microvm does not support hotplug so presence of
> unplug{_request} versions brought a doubt in my mind but I realized later
> that their definitions were empty. Cold-plug does not require unplug
> versions.
> 
> Was there any plan to support hot-plug with microvm in future?

At least virtio-mem for memory hotplug should be fairly straight-forward 
to wire-up I guess. The relation to ACPI are minimal: we currently only 
use ACPI SRAT to expose the maximum GPA range that e.g., Linux requires 
early during boot to properly prepare for memory hotplug (size the 
virtual memory space for the kernel accordingly). One could use 
alternative (paravirtualized) interfaces for that.

The question is whether any form of hotplug is "in the spirit" of microvm.

-- 
Cheers,

David / dhildenb


