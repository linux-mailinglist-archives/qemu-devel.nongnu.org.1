Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA6F7B6410
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:29:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnalg-0005gs-Qx; Tue, 03 Oct 2023 04:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnalY-0005ZS-AS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnalR-0008A1-JS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcdE3vL2OHOgUB143jWQmQjXsF+/jAumG/A6Q/OKCQU=;
 b=PK9BtqX2YVNeHF9RlqoJAbSTr7lG2YvK0E2I8oc6o2at8aN3vK/gztQEckoasD4iBlphn1
 6cm8VylcliPYRr3/B6DY7bFRYW50sevy5FtEfs5soqQPZ4Afjrm3cbzHrWPVK1S6ulYg2i
 qrpIA+r3yX7J3NHwvGuocHFwHTl5SAc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-tuYPIz_uNGObPTPsHzrdcg-1; Tue, 03 Oct 2023 04:28:13 -0400
X-MC-Unique: tuYPIz_uNGObPTPsHzrdcg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65af3fd7a55so8238946d6.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321692; x=1696926492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mcdE3vL2OHOgUB143jWQmQjXsF+/jAumG/A6Q/OKCQU=;
 b=JGooT5jMD7sMBiSJBd7+7rFfwNuzilkY9i/LkdE7iCjSPdIWNqPBTJ9jj2acsufNAy
 +gGYGdtndCv8fyfUzKCz6218LRgRgBQezyczJyEWsVEaqMLiizS4DMtUTjf1jMC/kGKU
 5kLffH/QYTGUOi4O9vNrmjT21uUoaTHrK3awpqkiq5xoNeI1L6OR65/MLqElImOj/dtN
 6LvQpDa+nrqZMsYjVmvgpWdf1GlbhbE8ZQyXMaebPWh/xHWFHxzZ5QQwZN4Vcqxig/vS
 OLYVfAbFgkOAi0OV0j7x4s8L0mxhboMnsOwgX1aLqHL/2vxVbPllFMazkmspO8xr0pfq
 Uc4g==
X-Gm-Message-State: AOJu0YzO1HMfTN2oUb2wcLWyu9nAx/Exgq3R6Atnye1pj8MOCtYKMeze
 mts9EyNKnhIIxJz329AXZPAF/yG0Sm9YXHDRZOTgKx77GxIygV0t7Ibe/gufPvJTGr3B59EJjdK
 nxjEVtG82HwDD/iw=
X-Received: by 2002:ad4:5284:0:b0:658:1ca4:97f7 with SMTP id
 v4-20020ad45284000000b006581ca497f7mr13516500qvr.34.1696321692465; 
 Tue, 03 Oct 2023 01:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6jvZIrak6sr00LsBGHZK+gh1368PcgHQ/UkETLEnmHRKyBQTkUbKyweNBvXmUKerDkj9Wvw==
X-Received: by 2002:ad4:5284:0:b0:658:1ca4:97f7 with SMTP id
 v4-20020ad45284000000b006581ca497f7mr13516489qvr.34.1696321692107; 
 Tue, 03 Oct 2023 01:28:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a0ce48f000000b0065b10dbcd53sm292535qvl.120.2023.10.03.01.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 01:28:11 -0700 (PDT)
Message-ID: <8ad34925-f3a6-db7d-f336-5dd84037895b@redhat.com>
Date: Tue, 3 Oct 2023 10:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] ramfb: make migration conditional
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-5-marcandre.lureau@redhat.com>
 <f0e4b89b-b88b-edfa-7855-fa41d5c72b69@redhat.com>
 <20231002084134.22fee251.alex.williamson@redhat.com>
 <05c80aca-8134-49b8-286b-853a02359ed6@redhat.com>
 <20231002132631.669de736.alex.williamson@redhat.com>
 <a8817c8e-8d8f-c713-b6f7-ba048aef3504@redhat.com>
 <20231002143844.122edadf.alex.williamson@redhat.com>
 <68475685-f82d-3b4b-0632-f7cf324fe563@redhat.com>
 <CAJ+F1CJdVCg-20WOKYFGgQ-Ecvr3jYYk7Ss8KEcQzwuDsWAxQA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CAJ+F1CJdVCg-20WOKYFGgQ-Ecvr3jYYk7Ss8KEcQzwuDsWAxQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/3/23 10:23, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 3, 2023 at 11:43 AM Cédric Le Goater <clg@redhat.com> wrote:
>>
>> On 10/2/23 22:38, Alex Williamson wrote:
>>> On Mon, 2 Oct 2023 21:41:55 +0200
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>
>>>> On 10/2/23 21:26, Alex Williamson wrote:
>>>>> On Mon, 2 Oct 2023 20:24:11 +0200
>>>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>>>
>>>>>> On 10/2/23 16:41, Alex Williamson wrote:
>>>>>>> On Mon, 2 Oct 2023 15:38:10 +0200
>>>>>>> Cédric Le Goater <clg@redhat.com> wrote:
>>>>>>>
>>>>>>>> On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:
>>>>>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>>>>
>>>>>>>>> RAMFB migration was unsupported until now, let's make it conditional.
>>>>>>>>> The following patch will prevent machines <= 8.1 to migrate it.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>>> Maybe localize the new 'ramfb_migrate' attribute close to 'enable_ramfb'
>>>>>>>> in VFIOPCIDevice. Anyhow,
>>>>>>>
>>>>>>> Shouldn't this actually be tied to whether the device is migratable
>>>>>>> (which for GVT-g - the only ramfb user afaik - it's not)?  What does it
>>>>>>> mean to have a ramfb-migrate=true property on a device that doesn't
>>>>>>> support migration, or false on a device that does support migration.  I
>>>>>>> don't understand why this is a user controllable property.  Thanks,
>>>>>>
>>>>>> The comments in <https://bugzilla.redhat.com/show_bug.cgi?id=1859424>
>>>>>> (which are unfortunately not public :/ ) suggest that ramfb migration
>>>>>> was simply forgotten when vGPU migration was implemented. So, "now
>>>>>> that vGPU migration is done", this should be added.
>>>>>>
>>>>>> Comment 8 suggests that the following domain XML snippet
>>>>>>
>>>>>>       <hostdev mode='subsystem' type='mdev' managed='no'
>>>>>> model='vfio-pci' display='on' ramfb='on'> <source>
>>>>>>           <address uuid='b155147a-663a-4009-ae7f-e9a96805b3ce'/>
>>>>>>         </source>
>>>>>>         <alias name='ua-b155147a-663a-4009-ae7f-e9a96805b3ce'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x07' slot='0x00'
>>>>>> function='0x0'/> </hostdev>
>>>>>>
>>>>>> is migratable, but the ramfb device malfunctions on the destination
>>>>>> host.
>>>>>>
>>>>>> There's also a huge QEMU cmdline in comment#0 of the bug; I've not
>>>>>> tried to read that.
>>>>>>
>>>>>> AIUI BTW the property is not for the user to control, it's just a
>>>>>> compat knob for versioned machine types. AIUI those are usually
>>>>>> implemented with such (user-visible / -tweakable) device properties.
>>>>>
>>>>> If it's not for user control it's unfortunate that we expose it to the
>>>>> user at all, but should it at least use the "x-" prefix to indicate that
>>>>> it's not intended to be an API?
>>>>
>>>> I *think* it was your commit db32d0f43839 ("vfio/pci: Add option to
>>>> disable GeForce quirks", 2018-02-06) that hda introduced me to the "x-"
>>>> prefixed properties!
>>>>
>>>> For some reason though, machine type compat knobs are never named like
>>>> that, AFAIR.
>>>
>>> Maybe I'm misunderstanding your comment, but it appears quite common to
>>> use "x-" prefix things in the compat tables...
>>>
>>> GlobalProperty hw_compat_8_0[] = {
>>>       { "migration", "multifd-flush-after-each-section", "on"},
>>>       { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
>>>       { TYPE_VIRTIO_NET, "host_uso", "off"},
>>>       { TYPE_VIRTIO_NET, "guest_uso4", "off"},
>>>       { TYPE_VIRTIO_NET, "guest_uso6", "off"},
>>> };
>>> const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>>>
>>> GlobalProperty hw_compat_7_2[] = {
>>>       { "e1000e", "migrate-timadj", "off" },
>>>       { "virtio-mem", "x-early-migration", "false" },
>>>       { "migration", "x-preempt-pre-7-2", "true" },
>>>       { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
>>> };
>>> const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
>>> [etc]
>>>
>>>>> It's still odd to think that we can
>>>>> have scenarios of a non-migratable vfio device registering a migratable
>>>>> ramfb, and vice versa, but I suppose in the end it doesn't matter.
>>>>
>>>> I do think it matters! For one, if migration is not possible with
>>>> vfio-pci-nohotplug, then how can QE (or anyone else) *test* the patch
>>>> (i.e. that it makes a difference)? In that case, the ramfb_setup() call
>>>> from vfio-pci-nohotplug should just open-code "false" for the
>>>> "migratable" parameter.
>>>
>>> Some vfio devices support migration, most don't.  I was thinking
>>> ramfb_setup might be called with something like:
>>>
>>>        (vdev->ramfb_migrate && vdev->enable_migration)
>>>
>>> so that at least the ramfb migration state matches the device, but I
>>> think ultimately it only saves a little bit of overhead in registering
>>> the vmstate, either one not supporting migration should block migration.
>>>
>>> Hmm, since enable_migration is auto/on/off, it seems like device
>>> realize should fail if set to 'on' and ramfb_migrate is false.  I think
>>> that's the only way the device options don't become self contradictory.
>>
>> Why isn't VFIODisplay a QOM object ? vfio_display_probe() is more or
>> less a realize routine, and we have a reset and finalize handlers for it.
>>
>> (thinking aloud) the "ramfb-migrate" property could then be moved
>> down VFIODisplay, along with the other specific display properties.
>> Compatibility could be handled with property aliases. "enable_migration"
>> could set "ramfb-migrate".This looks like it would be nice model cleanup.
>>
>> May be not the right time ?
> 
> Yes, I thought about some similar changes (though I am not sure QOM is
> necessary).
> 
> Now I am trying to test my changes that add a VFIODisplay migration
> subsection, but I don't think I have a GVT-g GPU (TGL GT1). When I try
> with a random PCI device, I get "VFIO migration is not supported in
> kernel". I can try to comment out some code, but that seems hazardous.

I have recently setup a T480 with GVT-g and a windows guest. I can give
your changes a try.

C.



