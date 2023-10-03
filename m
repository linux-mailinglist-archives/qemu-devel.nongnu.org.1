Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 001227B62A9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qna2n-00005z-FN; Tue, 03 Oct 2023 03:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qna2l-00005d-7U
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qna2j-0007So-EZ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696318928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYk6AFGUBj+W0/AUub8FFIBfO4b40e1vC17u7o53Vu0=;
 b=Fx2h+yuy/rhWu/x9nwLwym1AT5rNxzHMuIV+Chu1NMdWWTB6A7FpllzVhc6HmDN0jOHsfO
 QPZYXR2+GZCUba51azq1zoRpMjbESRvumZx6BqMR+rCeT61W6SCFyI9ElyH5gUr8c48hcn
 4YG+g4/OBelbRtqf5gdF04T5AE696ZI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-aBdUKAIMMeSQsDaTcwyLvA-1; Tue, 03 Oct 2023 03:42:01 -0400
X-MC-Unique: aBdUKAIMMeSQsDaTcwyLvA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77407e21d49so77882885a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696318921; x=1696923721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tYk6AFGUBj+W0/AUub8FFIBfO4b40e1vC17u7o53Vu0=;
 b=dkRatuCd5CaCFv7z3uYEc2PSPNjHNvcxJ14yM6e4+tgT3mPZkPRo2gJp9cpeJi2KJT
 cfsHg0e/HGPbRg4gmagG0jftYT5DEXRild6aazPsIP++alGCFHX1yyYikQBS0mIFLmE/
 GozGCm7acMGW9KXnnnVkreIc/qrcGANzBIjb8uV7WHMfalXLdAEfCxsEHE7Z8eWy+FdP
 Jlmmk3k5frMbb2uIwAmaDU/3WBGFdbZcGdhPm2eV93uhZDDZrmBFNKErUQr+gBx8psgc
 z4dGxpUnc3jcIsE83ke+xuO65aNdJpyrx/q0r4uqUOOm6XHXLBUFcW78rC0gwU8Zddtv
 aUoQ==
X-Gm-Message-State: AOJu0YwByjWtO6+Cp1AMj7fNg1Y/+/x3NlOeO69S1WPnWFGPQYHuz82P
 dlnVbzVhsZ+OHTVZBcyKuCcKUdfQE4/0+gVcnataX9w5kSnuZFMSkCT6bow+rY5Mt0vCXwS37e9
 irVJFbl2rsWeMkEE=
X-Received: by 2002:a05:620a:942:b0:773:a83f:4a66 with SMTP id
 w2-20020a05620a094200b00773a83f4a66mr11777617qkw.36.1696318920863; 
 Tue, 03 Oct 2023 00:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM+qoyyH/GFRg+O49kHfDQXY4z2s+JdNvWJk1jdIaqWYL35k543Ju+HF+45kPxW8JLUNNj1g==
X-Received: by 2002:a05:620a:942:b0:773:a83f:4a66 with SMTP id
 w2-20020a05620a094200b00773a83f4a66mr11777607qkw.36.1696318920563; 
 Tue, 03 Oct 2023 00:42:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a37e303000000b007757eb88172sm250208qki.21.2023.10.03.00.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:42:00 -0700 (PDT)
Message-ID: <68475685-f82d-3b4b-0632-f7cf324fe563@redhat.com>
Date: Tue, 3 Oct 2023 09:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] ramfb: make migration conditional
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-5-marcandre.lureau@redhat.com>
 <f0e4b89b-b88b-edfa-7855-fa41d5c72b69@redhat.com>
 <20231002084134.22fee251.alex.williamson@redhat.com>
 <05c80aca-8134-49b8-286b-853a02359ed6@redhat.com>
 <20231002132631.669de736.alex.williamson@redhat.com>
 <a8817c8e-8d8f-c713-b6f7-ba048aef3504@redhat.com>
 <20231002143844.122edadf.alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231002143844.122edadf.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 10/2/23 22:38, Alex Williamson wrote:
> On Mon, 2 Oct 2023 21:41:55 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 10/2/23 21:26, Alex Williamson wrote:
>>> On Mon, 2 Oct 2023 20:24:11 +0200
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>    
>>>> On 10/2/23 16:41, Alex Williamson wrote:
>>>>> On Mon, 2 Oct 2023 15:38:10 +0200
>>>>> Cédric Le Goater <clg@redhat.com> wrote:
>>>>>      
>>>>>> On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:
>>>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>>
>>>>>>> RAMFB migration was unsupported until now, let's make it conditional.
>>>>>>> The following patch will prevent machines <= 8.1 to migrate it.
>>>>>>>
>>>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>> Maybe localize the new 'ramfb_migrate' attribute close to 'enable_ramfb'
>>>>>> in VFIOPCIDevice. Anyhow,
>>>>>
>>>>> Shouldn't this actually be tied to whether the device is migratable
>>>>> (which for GVT-g - the only ramfb user afaik - it's not)?  What does it
>>>>> mean to have a ramfb-migrate=true property on a device that doesn't
>>>>> support migration, or false on a device that does support migration.  I
>>>>> don't understand why this is a user controllable property.  Thanks,
>>>>
>>>> The comments in <https://bugzilla.redhat.com/show_bug.cgi?id=1859424>
>>>> (which are unfortunately not public :/ ) suggest that ramfb migration
>>>> was simply forgotten when vGPU migration was implemented. So, "now
>>>> that vGPU migration is done", this should be added.
>>>>
>>>> Comment 8 suggests that the following domain XML snippet
>>>>
>>>>      <hostdev mode='subsystem' type='mdev' managed='no'
>>>> model='vfio-pci' display='on' ramfb='on'> <source>
>>>>          <address uuid='b155147a-663a-4009-ae7f-e9a96805b3ce'/>
>>>>        </source>
>>>>        <alias name='ua-b155147a-663a-4009-ae7f-e9a96805b3ce'/>
>>>>        <address type='pci' domain='0x0000' bus='0x07' slot='0x00'
>>>> function='0x0'/> </hostdev>
>>>>
>>>> is migratable, but the ramfb device malfunctions on the destination
>>>> host.
>>>>
>>>> There's also a huge QEMU cmdline in comment#0 of the bug; I've not
>>>> tried to read that.
>>>>
>>>> AIUI BTW the property is not for the user to control, it's just a
>>>> compat knob for versioned machine types. AIUI those are usually
>>>> implemented with such (user-visible / -tweakable) device properties.
>>>
>>> If it's not for user control it's unfortunate that we expose it to the
>>> user at all, but should it at least use the "x-" prefix to indicate that
>>> it's not intended to be an API?
>>
>> I *think* it was your commit db32d0f43839 ("vfio/pci: Add option to
>> disable GeForce quirks", 2018-02-06) that hda introduced me to the "x-"
>> prefixed properties!
>>
>> For some reason though, machine type compat knobs are never named like
>> that, AFAIR.
> 
> Maybe I'm misunderstanding your comment, but it appears quite common to
> use "x-" prefix things in the compat tables...
> 
> GlobalProperty hw_compat_8_0[] = {
>      { "migration", "multifd-flush-after-each-section", "on"},
>      { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
>      { TYPE_VIRTIO_NET, "host_uso", "off"},
>      { TYPE_VIRTIO_NET, "guest_uso4", "off"},
>      { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> };
> const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
> 
> GlobalProperty hw_compat_7_2[] = {
>      { "e1000e", "migrate-timadj", "off" },
>      { "virtio-mem", "x-early-migration", "false" },
>      { "migration", "x-preempt-pre-7-2", "true" },
>      { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
> };
> const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
> [etc]
> 
>>> It's still odd to think that we can
>>> have scenarios of a non-migratable vfio device registering a migratable
>>> ramfb, and vice versa, but I suppose in the end it doesn't matter.
>>
>> I do think it matters! For one, if migration is not possible with
>> vfio-pci-nohotplug, then how can QE (or anyone else) *test* the patch
>> (i.e. that it makes a difference)? In that case, the ramfb_setup() call
>> from vfio-pci-nohotplug should just open-code "false" for the
>> "migratable" parameter.
> 
> Some vfio devices support migration, most don't.  I was thinking
> ramfb_setup might be called with something like:
> 
> 	(vdev->ramfb_migrate && vdev->enable_migration)
> 
> so that at least the ramfb migration state matches the device, but I
> think ultimately it only saves a little bit of overhead in registering
> the vmstate, either one not supporting migration should block migration.
> 
> Hmm, since enable_migration is auto/on/off, it seems like device
> realize should fail if set to 'on' and ramfb_migrate is false.  I think
> that's the only way the device options don't become self contradictory.

Why isn't VFIODisplay a QOM object ? vfio_display_probe() is more or
less a realize routine, and we have a reset and finalize handlers for it.

(thinking aloud) the "ramfb-migrate" property could then be moved
down VFIODisplay, along with the other specific display properties.
Compatibility could be handled with property aliases. "enable_migration"
could set "ramfb-migrate".This looks like it would be nice model cleanup.

May be not the right time ?

Thanks,

C.


