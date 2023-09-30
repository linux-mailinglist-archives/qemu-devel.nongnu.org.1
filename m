Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF87B3FF0
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 12:29:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmXD4-0006EX-J8; Sat, 30 Sep 2023 06:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmXCt-0006Du-Ez
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 06:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmXCr-00004t-3Y
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 06:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696069696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWozE4uYNnQQpW8KjWbiEsuyHRY2eCgqUoUlDdEiPjc=;
 b=DK8tOJ6J+bfzJPN5+rhjuHcPDX812IOwCrIg/VmC9R9xqkUJ7t2ubfTs4tKpa3TIiZRSTN
 zSG5U1KD9YDFE9jN7l81gn2XiVWeY0OBlve+OKfI0J7efVOHPhk+b4JtJscu1OYApQd3cK
 sHx4ehg5zESiMiLgoyW+2pAls3buoT8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Zxiaor3eNueuFbxTbGkWtg-1; Sat, 30 Sep 2023 06:28:13 -0400
X-MC-Unique: Zxiaor3eNueuFbxTbGkWtg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41810af14a4so188572021cf.0
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 03:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696069693; x=1696674493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sWozE4uYNnQQpW8KjWbiEsuyHRY2eCgqUoUlDdEiPjc=;
 b=AhUYw71pRmoNN9ySbXSIY5yUQD/Eyk9RXJXAn6DNN5S0ofDby5GBmwyFi+i9B4XXNq
 9mwLBWwfGP5FtUZMWbUWFxZj09xleI20OE4msx1da7SDmYtE8MpbV2Ur1Kg8OfDFmtRP
 Nbs2w2AGjThgoeR4+ZHc7xwdPq+vc4PfVkdEYBHbc//6u5Adb2C7/o3tYT/lejarJc1R
 dxdU/ZNCrVbLaBbveWjlIhszbGuYUgiUDqxhtSL41zfAFXnAGU2bCsPvX7cGmMMsZkFD
 B2BHx/eEUVJBB8XZuZcBK04xq2aVNfGkIOi36iLnsHb41uD+UlSnj1g8MW7PX22UZFZ/
 hekw==
X-Gm-Message-State: AOJu0Yw36IPyDk9z0aZyEvS7+tEiK47XUZzJJ9K7fWDRWp++uNMY4d6a
 pQhLjLln/QfIo/AeAtq7csirHdU+IeaCZzdquvbUNHaf2lRQn+B3Y4jwQvUSzwLEwXO9iqZrAs/
 N8LuFMpNQzKxInsQ=
X-Received: by 2002:a05:622a:20f:b0:417:d6c7:ea69 with SMTP id
 b15-20020a05622a020f00b00417d6c7ea69mr7351226qtx.7.1696069693236; 
 Sat, 30 Sep 2023 03:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+QNqKaxoyvRT+BpynqoEgsErURVX0xy3RN0P08BlUaJIipd1uFCrAs1ua26thLI0iK2mUHQ==
X-Received: by 2002:a05:622a:20f:b0:417:d6c7:ea69 with SMTP id
 b15-20020a05622a020f00b00417d6c7ea69mr7351201qtx.7.1696069692785; 
 Sat, 30 Sep 2023 03:28:12 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 g11-20020ac8124b000000b004181234dd1dsm1366748qtj.96.2023.09.30.03.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Sep 2023 03:28:12 -0700 (PDT)
Message-ID: <2c7d6973-befb-6db6-49a7-c08f195758b1@redhat.com>
Date: Sat, 30 Sep 2023 12:28:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v11 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
To: Bernhard Beschow <shentey@gmail.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, ray.huang@amd.com,
 alex.bennee@linaro.org, hi@alyssa.is, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 Markus Armbruster <armbru@redhat.com>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <20230823012541.485-7-gurchetansingh@chromium.org>
 <B1A4DF8C-3078-48AD-BC8B-F2FD7BA413CF@gmail.com>
 <CAAfnVBk6C7-Vn3buLOh453fz-dRB2vv-4BdkZWjuJDJoWLPAqA@mail.gmail.com>
 <D3C6E21B-E37E-41DA-8131-0C3D9EAF01FD@gmail.com>
 <CAAfnVBngeT8Ezt3osJW2NipFB3r9mJsLXzo1DEo4FtBaZpAO0w@mail.gmail.com>
 <ED6A24A1-42EC-47B2-A5D1-D57135A2D7D6@gmail.com>
 <83364d82-1a1e-4483-aad4-249ce30206a0@gmail.com>
 <CAAfnVBmAJL4TsRFcfwNyXKG7FESNDV_k1m1HW8_oaOio0WdWKA@mail.gmail.com>
 <EF2A76D3-EC1E-4065-8B1A-229E5E9E804F@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <EF2A76D3-EC1E-4065-8B1A-229E5E9E804F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.295, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 29/09/2023 17.06, Bernhard Beschow wrote:
> 
> 
> Am 21. September 2023 23:44:42 UTC schrieb Gurchetan Singh <gurchetansingh@chromium.org>:
>> On Tue, Sep 19, 2023 at 3:07 PM Akihiko Odaki <akihiko.odaki@gmail.com>
>> wrote:
>>
>>> On 2023/09/20 3:36, Bernhard Beschow wrote:
>>>>
>>>>
>>>> Am 15. September 2023 02:38:02 UTC schrieb Gurchetan Singh <
>>> gurchetansingh@chromium.org>:
>>>>> On Thu, Sep 14, 2023 at 12:23 AM Bernhard Beschow <shentey@gmail.com>
>>> wrote:
...
>>>>>>>> First, sorry for responding after such a long time. I've been busy
>>> with
>>>>>>>> work and I'm doing QEMU in my free time.
>>>>>>>>
>>>>>>>> In iteration 1 I've raised the topic on capset_names [1] and I
>>> haven't
>>>>>>>> seen it answered properly. Perhaps I need to rephrase a bit so here
>>> we
>>>>>> go:
>>>>>>>> capset_names seems to be colon-separated list of bit options managed
>>> by
>>>>>>>> rutabaga. This introduces yet another way of options handling. There
>>>>>> have
>>>>>>>> been talks about harmonizing options handling in QEMU since
>>> apparently
>>>>>> it
>>>>>>>> is considered too complex [2,3].
>>>>>>>
>>>>>>>
>>>>>>>> Why not pass the "capset" as a bitfield like capset_mask and have
>>> QEMU
>>>>>>>> create "capset" from QOM properties?
>>>>>>>
>>>>>>> IIUC these flags could come from virtio_gpu.h which is already
>>> present in
>>>>>>>> the QEMU tree. This would not inly shortcut the dependency on
>>> rutabaga
>>>>>> here
>>>>>>>> but would also be more idiomatic QEMU (since it makes the options
>>> more
>>>>>>>> introspectable by internal machinery).
>>>>>>>
>>>>>>>
>>>>>>>> Of course the bitfield approach would require modifications in QEMU
>>>>>>>> whenever rutabaga gains new features. However, I figure that in the
>>> long
>>>>>>>> term rutabaga will be quite feature complete such that the benefits
>>> of
>>>>>>>> idiomatic QEMU handling will outweigh the decoupling of the projects.
>>>>>>>>
>>>>>>>> What do you think?
>>>>>>>>
>>>>>>>
>>>>>>> I think what you're suggesting is something like -device
>>>>>>> virtio-gpu-rutabaga,capset_mask=0x10100 [40, which would be
>>>>>>> gfxstream_vulkan + cross_domain]?
>>>>>>
>>>>>> I was thinking more along the lines of
>>>>>> `virtio-gpu-rutabaga,gfxstream_vulkan=on,cross_domain=on` where
>>>>>> gfxstream_vulkan and cross_domain are boolean QOM properties. This
>>> would
>>>>>> make for a human-readable format which follows QEMU style.
>>>>>>
>>>>>>>
>>>>>>> We actually did consider something like that when adding the
>>>>>>> --context-types flag [with crosvm], but there was a desire for a
>>>>>>> human-readable format rather than numbers [even if they are in the
>>>>>>> virtio-gpu spec].
>>>>>>>
>>>>>>> Additionally, there are quite a few context types that people are
>>> playing
>>>>>>> around with [gfxstream-gles, gfxstream-composer] that are launchable
>>> and
>>>>>>> aren't in the spec just yet.
>>>>>>
>>>>>> Right, QEMU had to be modified for this kind of experimentation. I
>>>>>> considered this in my last paragraph and figured that in the long run
>>> QEMU
>>>>>> *may* prefer more idiomatic option handling since it tries hard to not
>>>>>> break its command line interface. I'm just pointing this out -- the
>>>>>> decision is ultimately up to the community.
>>>>>>
>>>>>> Why not have dedicated QEMU development branches for experimentation?
>>>>>> Wouldn't upstreaming new features into QEMU be a good motivation to
>>> get the
>>>>>> missing pieces into the spec, once they are mature?
>>>>>
>>>>>
>>>>>>>
>>>>>>> Also, a key feature we want to explicitly **not** turn on all
>>> available
>>>>>>> context-types and let the user decide.
>>>>>>
>>>>>> How would you prevent that with the current colon-separated approach?
>>>>>> Splitting capset_mask in multiple parameters is just a different
>>>>>> syntactical representation of the same thing.
>>>>>>
>>>>>>> That'll allow guest Mesa in
>>>>>>> particular to do its magic in its loader.  So one may run Zink + ANV
>>> with
>>>>>>> ioctl forwarding, or Iris + ioctl forwarding and compare performance
>>> with
>>>>>>> the same guest image.
>>>>>>>
>>>>>>> And another thing is one needs some knowledge of the host system to
>>> choose
>>>>>>> the right context type.  You wouldn't do Zink + ANV ioctl forwarding
>>> on
>>>>>>> MacOS.  So I think the task of choosing the right context type will
>>> fall
>>>>>> to
>>>>>>> projects that depend on QEMU (such as Android Emulator) which have
>>> some
>>>>>>> knowledge of the host environment.
>>>>>>>
>>>>>>> We actually have a graphics detector somewhere that calls VK/OpenGL
>>> before
>>>>>>> launching the VM and sets the right options.  Plan is to port into
>>>>>>> gfxstream, maybe we could use that.
>>>>>>
>>>>>> You could bail out in QEMU if rutabaga_calculate_capset_mask() detects
>>>>>> conflicting combinations, no?
>>>>>>
>>>>>>>
>>>>>>> So given the desire for human readable formats, being portable across
>>> VMMs
>>>>>>> (crosvm, qemu, rust-vmm??) and experimentation, the string -> capset
>>> mask
>>>>>>> conversion was put in the rutabaga API.  So I wouldn't change it for
>>> those
>>>>>>> reasons.
>>>>>>
>>>>>> What do you mean by being portable across VMMs?
>>>>>
>>>>>
>>>>> Having the API inside rutabaga is (mildly) useful when multiple VMMs
>>> have
>>>>> the need to translate from a human-readable format to flags digestible
>>> by
>>>>> rutabaga.
>>>>>
>>>>>
>>> https://android.googlesource.com/device/google/cuttlefish/+/refs/heads/main/host/libs/vm_manager/qemu_manager.cpp#452
>>>>>
>>>>>
>>> https://android.googlesource.com/device/google/cuttlefish/+/refs/heads/main/host/libs/vm_manager/crosvm_manager.cpp#353
>>>>>
>>>>>
>>> https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/main/vm_tools/concierge/vm_builder.cc#505
>>>>>
>>>>> For these crosvm/qemu launchers, I imagine capset names will be plumbed
>>> all
>>>>> the way through eventually (launch_cvd
>>>>> --gpu_context=gfxstream-vulkan:cross-domain if you've played around with
>>>>> Cuttlefish, or vmc start --gpu_contexts=gfxstream-vulkan if you played
>>>>> around with Termina VMs).
>>>>>
>>>>> I think rust-vmm could also use the same API ("--capset_names") too.
>>>>>
>>>>>
>>>>>> Sure, QEMU had to be taught new flags before being able to use new
>>>>>> rutabaga features. I agree that this comes with a certain
>>> inconvenience.
>>>>>> But it may also be inconvenient for QEMU to deal with additional ad-hoc
>>>>>> options parsing when there are efforts for harmonization.
>>>>>>
>>>>>> Did my comments shed new light into the discussion?
>>>>>
>>>>>
>>>>> Yes, they do.  I agree with you that both crosvm/qemu have too many
>>> flags,
>>>>> and having a stable command line interface is important.  We are aiming
>>> for
>>>>> stability with the `--capset_names={colon string}` command line, and at
>>>>> least for crosvm looking to deprecate older options [since we've never
>>> had
>>>>> an official release of crosvm yet].
>>>>>
>>>>> I do think:
>>>>>
>>>>> 1) "capset_names=gfxstream-vulkan:cross-domain"
>>>>> 2) "cross-domain=on,gfxstream-vulkan=on"
>>>>>
>>>>> are similar enough.  I would choose (1) for since I think not
>>> duplicating
>>>>> the [name] -> flag logic and having a similar interface across VMMs +
>>> VMM
>>>>> launchers is ever-so slightly useful.
>>>>
>>>> I think we've now reached a good understanding of the issue. It's now up
>>> to the QEMU community to make a choice. So I'm cc'ing Markus and Thomas as
>>> the experts of the topic.
>>>
>>> As a virtio-gpu user, I'm slightly inclined to (2) since it would be
>>> easier to implement the same option for virtio-gpu-virgl when a need
>>> arises.
>>>
>>
>> The rutabaga/virgl implementations will likely be done via DEFINE_PROP_BIT,
>> no?  For virgl, it'll set the virgl flags, and for rutabaga, it'll set the
>> capset mask.  So it would be different.
>>
>> That said, the change isn't too bad to make.  Here's the key part:
>>
>> +++ b/hw/display/virtio-gpu-rutabaga.c
>> @@ -1084,6 +1084,14 @@ static Property virtio_gpu_rutabaga_properties[] = {
>>      DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
>>                         wayland_socket_path),
>>      DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
>> +    DEFINE_PROP_BIT("gfxstream-vulkan-experimental", VirtIOGPURutabaga,
>> +                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_VULKAN, false),
>> +    DEFINE_PROP_BIT("cross-domain-experimental", VirtIOGPURutabaga,
>> +                    capset_mask, RUTABAGA_CAPSET_CROSS_DOMAIN, false),
>> +    DEFINE_PROP_BIT("gfxstream-gles-experimental", VirtIOGPURutabaga,
>> +                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_GLES, false),
>> +    DEFINE_PROP_BIT("gfxstream-composer-experimental", VirtIOGPURutabaga,
>> +                    capset_mask, RUTABAGA_CAPSET_GFXSTREAM_COMPOSER,
>> false),
>>      DEFINE_PROP_END_OF_LIST(),
>> };
> 
> Nice!
> 
> I think the current approach for experimental and deprecated properties is to not pre- or postfix them but issue a warning at runtime when used, see e.g. here: https://lore.kernel.org/qemu-devel/20230710121543.197250-18-thuth@redhat.com/ That way, the command line interface won't change once the properties become stable. So if you omit the "-experimental" postfixes Android Studio wouldn't need to adapt.

That's for deprecated options only. For experimental new properties, please 
use the "x-" prefix instead of the "-experimental" suffix.

  Thanks,
   Thomas


