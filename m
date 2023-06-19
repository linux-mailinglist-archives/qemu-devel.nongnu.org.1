Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486E735BC6
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 18:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHHS-0005SY-89; Mon, 19 Jun 2023 11:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBHHP-00054w-HL
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBHHN-0005aZ-9N
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687190335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn0o68LDdHitH7qBqgwQhjoR1NmiYelqyFwa8P5+yG4=;
 b=bbd745CMqr7rJU1p+HGGSc7aihU0SYuZ2etfFKts2YgpfuC296G73EZ65Y1wqkKUjNtlog
 P7ppJNBdTCvKRqpMUNqGT+RFaEwoQdifdGw1U9RN4G8owt/pBKRIKjrIEY3qhY3g4PYov5
 TD16MwJ927Be6yfEZKRe0gRgFONtidw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-hpYOEB2dOky7IdFWZnjaig-1; Mon, 19 Jun 2023 11:58:53 -0400
X-MC-Unique: hpYOEB2dOky7IdFWZnjaig-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f9456dd899so8238545e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190333; x=1689782333;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wn0o68LDdHitH7qBqgwQhjoR1NmiYelqyFwa8P5+yG4=;
 b=evP59GZ8ivGZRu+p1Yb+Et43g+NNNGQrRQ3tKit6VQeqmD2qNyhDyLeVCZNwd5pQju
 WiNXrUgG/6RiCFK1348Owmt1w8Zw5uauAv3LoslrUSh1LGwqrdnD4aEqa8LOieRmgDzR
 RbZy7NymHI9BlDiBPSeK5IVhBdIoV+CnI3gUVCYdOhcFtV8tWumEeNwvVS5ewF5oJdPU
 7Ph1hKXdVad68fsyZ2SzeSWTo8nYnCOJW+S20/UPcZQta9oPnwaNGCX7FZa+5vwrwZUN
 xmQxhaIhwhCSd3fd/9UoX8n5PpD8YbrDFPxfferadUyjWlUFjAYRM6HPbgnro0c0Ot4q
 lO3g==
X-Gm-Message-State: AC+VfDwOTTWtIOGsmatlWr4zI8SLVMs/VFTXhurpM2LBrgKPPHDoyRNZ
 t6yV0R6SCpRM4KF0VelyfQBf1S7qHZ3cRR3ggYTJT2D36VI6TUS5MFuzQo8QRhMYJ84Hk9LduGo
 vxfldsv4z7eFz3pI=
X-Received: by 2002:a05:600c:2313:b0:3f7:f884:7be4 with SMTP id
 19-20020a05600c231300b003f7f8847be4mr11238413wmo.21.1687190332808; 
 Mon, 19 Jun 2023 08:58:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55WlrFfb/jLZG+iCHiLFTehtxR4QsRADqTOHPGC31VBLh2ukl2bz0n0Q/NhOiIWmR+ei42eg==
X-Received: by 2002:a05:600c:2313:b0:3f7:f884:7be4 with SMTP id
 19-20020a05600c231300b003f7f8847be4mr11238391wmo.21.1687190332434; 
 Mon, 19 Jun 2023 08:58:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:7100:cede:6433:a77b:41e9?
 (p200300cbc72f7100cede6433a77b41e9.dip0.t-ipconnect.de.
 [2003:cb:c72f:7100:cede:6433:a77b:41e9])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adfeb4a000000b003063772a55bsm9376896wrn.61.2023.06.19.08.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 08:58:51 -0700 (PDT)
Message-ID: <008fced2-1bcf-7a89-d642-bb724eb63ddf@redhat.com>
Date: Mon, 19 Jun 2023 17:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1686577753.git.maciej.szmigiero@oracle.com>
 <896327748bde906826e24ce7cc45301e325e14a7.1686577753.git.maciej.szmigiero@oracle.com>
 <f54e55d0-b8dd-a431-7634-02fdec0611bb@redhat.com>
 <1b107fba-38e0-cced-e19f-b62684072bfd@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH][RESEND v5 3/3] Add a Hyper-V Dynamic Memory Protocol
 driver (hv-balloon)
In-Reply-To: <1b107fba-38e0-cced-e19f-b62684072bfd@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

[...]

Sorry for the late reply!

Still trying to make up my mind what the right way forward with this is.

>>
>> This usage is still problematic I suspect (well, and a layer violation regarding the machine). The machine hotplug handler is supposed to call the pre_plug/plug/unplug hooks as response to pre_plug/plug/unplug notifications from the core. See how we handle virtio-mem/virtio-pmem/nvdimms as an example.
>>
>> We assume that when memory_device_pre_plug() gets called, that the device is not realized yet, but once it gets plugged, that it already is realized, and that the device will actually vanish (get unrealized) when unplugging the device.
>> Otherwise memory device logic like in get_plugged_memory_size() stops working.
> 
> get_plugged_memory_size() just calls get_plugged_size() method on every
> realized TYPE_MEMORY_DEVICE.
> 
> While this now always returns the whole backing memory size (once the
> backend gets plugged) I don't see a reason why this method could not be
> overridden in hv-balloon to return just the currently hot-added size.
> 
> By the way, this function seems to be used just for reporting stats via QMP.

memory_device_build_list() is another example, used for 
memory_device_get_free_addr(). You'd be blocking memory address ranges 
with an unplugged-but-realized memory device.

Memory device code expects that realized memory devices are plugged and 
vice versa.

> 
>>
>> As an example, see device_set_realized() on the pre_plug+realize+plug interaction.
>>
>> IIRC, you're reusing the already-realized hv-balloon device here, correct?
> 
> Yes - in this version of the driver.
> 
> The previous version used separate virtual DIMM devices instead but you have
> recommended against that approach.
> 

Yes. My recommendation was to make the hv-balloon device a memory device 
and use a single memory region, which you did (and I think it's much 
better).

It's now all about when we (un)plug the memory device itself -- and how.

>>
>> Why can't you call the pre_plug/plug/unplug functions from the machine pre_plug/plug/unplug hooks -- exactly once for the memory device when plugging the hv-balloon device?
>>
>> Is it to support the !memdev case or why is this this plugging/unplugging in our_range_plugged_new()/our_range_plugged_free() required?
> 
> At least for three (four) reasons:
> 1a) At the hv-balloon plug time the device doesn't yet know the guest
> alignement requirements - or whether the guest supports memory hot add at
> all - that's what the device will learn only once the guest connects
> to the protocol.

Understood, so you want to at least expose the memory dynamically to the 
VM (map the MR on demand).

That could be done using a memory region container like virtio-mem is 
planning [1] on using fairly easily.

[1] https://lkml.kernel.org/r/20230616092654.175518-14-david@redhat.com

> 1b) For the same reason the memory region has to be unplugged at the VM
> reset time - the new guest might have stricter alignement requirements

Alignment is certainly interesting, but is it a real problem?

As default (not other memory devices) you get an address that's aligned 
to 1 GiB. And, in fact, you can simply always request a 1 GiB alignment 
for the device, independent of the guest requirement.

Would the guest requirement be even stricter than that (e.g., 2 GiB)?

In theory, when using a memory region container (again [1]) into which 
you dynamically map the RAM region, you can do this alignment internally.

So it might be an option to use a memory region container and 
dynamically map into that one as you please (it just has to have a fixed 
size).

> 
> By the way, the memory region *can't* be unplugged yet at VMBus device
> reset time - Windows keeps on using it until the system is restarted,
> even after disconnecting from the VMBus.

Yes, similar to virtio-mem -- we can only e.g. do it at system reset time.

> 
> 2) The !memdev case, when the driver is just used for Windows-native
> ballooning and stats reporting.

So we'd want support for a memory device that doesn't expose any memory 
-- in the current configuration. Should be doable (NULL returned as 
device memory region -> skip pre_plug/plug/unplug and teach the other 
code to just ignore this device). It would be easier if we could decide 
at runtime that this device is not a memory device ...

But let's first figure out if that's the right approach.


> 
> 3) This will hopefully allow sharing the backing memory device between
> virtio-mem and hv-balloon in the future - Linux guests will connect to
> the former interface while Windows guests will connect to the later.
> 

I've been told that the virtio-mem driver for Windows will show up 
polished in the near future ... we'll see :)

Anyhow, I consider that a secondary requirement. (virtio-mem is not 
compatible with shared memdevs)


>>
>> Supporting the !memdev case is interesting: you essentially want to plug a memory device without a device region (or with an empty stub). I guess we should get that figured out somehow.
>>
> 
> That's why the previous version of this driver used a parent VMBus
> device (non-TYPE_MEMORY_DEVICE) which then had virtual DIMMs as its
> children carrying memory for hot add.

So we have the following two options I think

(1) Make the hv-balloon device a memory device, plug/unplug it from the 
machine code when plug/unplug'ing the hv-balloon device.

We'd use a memory region container as device memory region (like [1]) 
and would have to handle the !memdev case (I can help with that). Into 
that, you can map the RAM memory region on demand (and eventually even 
using multiple slots like [1]).

(2) Use a single virtual DIMM and (un)plug that on demand. Let the 
machine code handle (un)plugging of the device.


(1) feels cleanest to me, although it will require a bit more work.

-- 
Cheers,

David / dhildenb


