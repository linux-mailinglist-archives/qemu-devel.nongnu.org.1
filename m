Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF77A40DC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 08:09:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi7Q4-0008RN-4q; Mon, 18 Sep 2023 02:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qi7Pz-0008R3-St
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:07:35 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qi7Px-0003Cv-Gl
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:07:35 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3380785a12.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 23:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695017252; x=1695622052;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wTP6Zug257B7ooTQC5CAj7GOO7MTggg9HcFBRSUzaoc=;
 b=SHjkun13rnGzPDvB1FeyA3sJ2FjQBVsEOvg4jKhtxakbZsRvyOygdYsBGiOVHubXOJ
 kiRHozESgckUp9i2pz/WRiIRXtFlg7eQQl6pCG1qxJoJZikG5rynBTAYJrIio0zu5SRN
 x7RPdKBO0PypXSKfHI2JWwyz4KIUiKaMCSV2DrHWMd9rXPzeCOXYJ6mXQEtuLIJuAmXa
 9Oj2GXoFvPhus9Fqto5LwcVI5QPPCaopPRdFoOnffF+cDXxeHznfNRGXqG/wFEAOo7Ah
 nWskXftn674WYED04FbN9s91YNY6UA0vljZ8U+gMuqc3gXCLPScLTzzojbiftIwHYx/J
 Kgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695017252; x=1695622052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wTP6Zug257B7ooTQC5CAj7GOO7MTggg9HcFBRSUzaoc=;
 b=RE5dzixIbx3k+5UogeFQ+Z9Cwi94MJmic5pVdaEjrKwnQitDhPmIm2IJXrCNdvT3BJ
 h0AIoOUVjrlqiS616+gU19XCgA3Sku3tlUAFtSH1KrI3M0/Bj31Y9Jl196LuY5KgZqnA
 KkJFi2JsWXNRmxbFiYDcD4xFkrxPVQR1ysRkYaIAHGbpLZ3W3haBJT37yBEzNe1328lg
 oIGqXlsWtvCtQRIYiwwKRlbbsIqXMBB05D/A3r8r8WQE4pKJJ9N4CJUC32t870riNBjE
 7L9M7y0Ipsp847zcXRnAzvnN92Yh4vKIEFdPx6GJ8a7rm4ZQWqb12J6gehtUqSYwOMCE
 HrvQ==
X-Gm-Message-State: AOJu0YyO3VBFjCf7G8EVkCAacXmfWa1cO8AlnGF08l1UaCPSzN45Hufd
 50tEvDtBnMIN8w5a/nsgPFEgqw==
X-Google-Smtp-Source: AGHT+IEHOIOhreXYfLE6SJziVIWdwXdgdAC8dOaIF8C4wtve/e246JOxLw8znC365NulwWPD0HII/g==
X-Received: by 2002:a05:6a21:6da2:b0:153:b245:50ff with SMTP id
 wl34-20020a056a216da200b00153b24550ffmr11464818pzb.40.1695017251752; 
 Sun, 17 Sep 2023 23:07:31 -0700 (PDT)
Received: from [157.82.205.33] ([157.82.205.33])
 by smtp.gmail.com with ESMTPSA id
 k6-20020aa790c6000000b0069028bdd24dsm6446226pfk.34.2023.09.17.23.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 23:07:31 -0700 (PDT)
Message-ID: <6e4887e7-f850-43aa-b9c6-6eb80b37bbc2@daynix.com>
Date: Mon, 18 Sep 2023 15:07:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 06/13] virtio-gpu: Support context init feature
 with virglrenderer
To: Huang Rui <ray.huang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Albert Esteve <aesteve@redhat.com>, "ernunes@redhat.com"
 <ernunes@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-7-ray.huang@amd.com>
 <561abf48-d72c-467d-94fd-54ffa1dfb512@daynix.com> <ZQWEQ9ZHkokhKOSA@amd.com>
 <d671bfad-7d78-41cf-a6f4-e92bf6ce2bd5@daynix.com> <ZQaSbaCUQ6iiHI/Y@amd.com>
 <568e9a08-c09c-4695-8165-04d3817b09f3@daynix.com> <ZQfjd9DsMTwxlPKF@amd.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZQfjd9DsMTwxlPKF@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/18 14:43, Huang Rui wrote:
> On Sun, Sep 17, 2023 at 01:49:19PM +0800, Akihiko Odaki wrote:
>> On 2023/09/17 14:45, Huang Rui wrote:
>>> On Sat, Sep 16, 2023 at 06:42:04PM +0800, Akihiko Odaki wrote:
>>>> On 2023/09/16 19:32, Huang Rui wrote:
>>>>> On Fri, Sep 15, 2023 at 11:20:46PM +0800, Akihiko Odaki wrote:
>>>>>> On 2023/09/15 20:11, Huang Rui wrote:
>>>>>>> Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
>>>>>>> feature flags.
>>>>>>> We would like to enable the feature with virglrenderer, so add to create
>>>>>>> virgl renderer context with flags using context_id when valid.
>>>>>>>
>>>>>>> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>>>>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>>>>>> ---
>>>>>>>
>>>>>>> V4 -> V5:
>>>>>>>         - Inverted patch 5 and 6 because we should configure
>>>>>>>           HAVE_VIRGL_CONTEXT_INIT firstly. (Philippe)
>>>>>>>
>>>>>>>      hw/display/virtio-gpu-virgl.c | 13 +++++++++++--
>>>>>>>      hw/display/virtio-gpu.c       |  2 ++
>>>>>>>      2 files changed, 13 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>>>>>> index 8bb7a2c21f..312953ec16 100644
>>>>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>>>>> @@ -106,8 +106,17 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
>>>>>>>          trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>>>>>>>                                          cc.debug_name);
>>>>>>>      
>>>>>>> -    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
>>>>>>> -                                  cc.debug_name);
>>>>>>> +    if (cc.context_init) {
>>>>>>> +#ifdef HAVE_VIRGL_CONTEXT_INIT
>>>>>>> +        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
>>>>>>> +                                                 cc.context_init,
>>>>>>> +                                                 cc.nlen,
>>>>>>> +                                                 cc.debug_name);
>>>>>>> +        return;
>>>>>>> +#endif
>>>>>>
>>>>>> This should deal with the case when context_init is set while
>>>>>> HAVE_VIRGL_CONTEXT_INIT is not defined.
>>>>>
>>>>> Actually, I received the comment below before:
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/32588d0e-a1f2-30c4-5e9f-e6e7c4190b65@linaro.org/
>>>>>
>>>>> At original patch set, I have the case while HAVE_VIRGL_CONTEXT_INIT is set
>>>>> but HAVE_VIRGL_CONTEXT_INIT is not defined. But I think we may encounter
>>>>> the case that virgl_renderer_context_create_with_flags is not defined in
>>>>> virglrenderer early version. Should I bring the error message back?
>>>>>
>>>>> Thanks,
>>>>> Ray
>>>>
>>>> I suggest checking VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED instead of
>>>> reporting an error here. Perhaps it may be easier to add #ifdef around:
>>>>    > +    DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,
>>>>    > +                    VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED, false),
>>>
>>> How about below changes: >
>>> ---
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 8bb7a2c21f..54a3cfe136 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -106,8 +106,15 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
>>>        trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>>>                                        cc.debug_name);
>>>
>>> -    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
>>> -                                  cc.debug_name);
>>> +    if (cc.context_init && virtio_gpu_context_init_enabled(g->conf)) {
>>> +        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
>>> +                                                 cc.context_init,
>>> +                                                 cc.nlen,
>>> +                                                 cc.debug_name);
>>> +        return;
>>> +    }
>>> +
>>> +    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name);
>>>    }
>>>
>>>    static void virgl_cmd_context_destroy(VirtIOGPU *g,
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index be16efbd38..6ff2c8e92d 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -1508,6 +1508,10 @@ static Property virtio_gpu_properties[] = {
>>>        DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>>>                        VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>>>        DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
>>> +#ifdef HAVE_VIRGL_CONTEXT_INIT
>>> +    DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,
>>> +                    VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED, true),
>>> +#endif
>>>        DEFINE_PROP_END_OF_LIST(),
>>>    };
>>>
>>
>> It looks better, but not having #ifdef around
>> virgl_renderer_context_create_with_flags() will result in a link error
>> with old virglrenderer.
> 
> Hmm, right, it seems that we have to have a "#ifdef" around here. Or do you
> have any better idea?

Having #ifdef is the right direction.

