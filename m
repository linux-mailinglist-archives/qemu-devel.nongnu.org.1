Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0697A2F47
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 12:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhSkm-00006N-T5; Sat, 16 Sep 2023 06:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhSki-00004z-Pa
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 06:42:16 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhSkg-0005br-O6
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 06:42:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso2150905b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694860932; x=1695465732;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fMlMz/YYNDZAhuao03JJ46ovHxuLEAGPhfUj85JSgJk=;
 b=ryD87p8PwN5PqkyVMC0KO976+TwZIobkB81haN1IsyFzbJyM7Ceaudi/WgGuZ7mmsw
 3LaRxZ/D8CmKuDqTc6Jbjtgx6DjBswqP6dbRo08nZb5x3swNmJhDQPyQeGKPPXf8flgY
 aEJ15zTkNI9SJLzKv7C2DgMXP6kV6nU5hKLKp9+0D9btxBd4R22PIZD2MrSVZaiaqxAY
 AOEZkh4Q2jQ+r9JZ7mFvahNfwy0c2JkSnErDPQmbnVJdLaZuQeiNtcXhXl+gZXHpKb+O
 KGDdRnm3v6whiGObVxg8mk0CVCaIdH7tlCjMhdRkV3N5AO7OeWXxucL5rPT6aymjxbRR
 hEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694860932; x=1695465732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fMlMz/YYNDZAhuao03JJ46ovHxuLEAGPhfUj85JSgJk=;
 b=WhZemED/Bv4EQzpycVw2Jdd5PPsO/zJFDap9fhtAoLKhyMnXoyRiLOetF7XONxV///
 4fxSQ3OzdD/0lmxogKZ6foPCa1LGIQzOro/qTL5U8pfi7fbUEnV5o92NLoV9bi21UBRo
 0dx90EEgaBlVKTfOh7+0li6EYbs0N9kyXm1kRwUojGeqM4i2o+0PvJv8rtPtorkLUJ9w
 wOGlkb2XV/IfCnoY6/Ts0ywgtBU6Awmd02MLPreUBpdMBWWa3RX8fdnBwvhbTd+Iu0PA
 SMpy0wn3o+nNXW32oRiMjOe5u6y4iuBl9Lg56pgjMArshrWgzkK+BJrdfnAFA78CS0jq
 csvA==
X-Gm-Message-State: AOJu0YwEY76uGrycH/N4y+/S69GjLkum+cCJrcRQteTknCgeOfs+Az3x
 FF6Io04xvEtzeMM7Pcjafygibg==
X-Google-Smtp-Source: AGHT+IFfWi26tA9JRMHYNtmN9NsNcAFqAiwUz8BoV78jy4UsxqwdKDvn+41U5SbJAzRkO8+gt4iZgA==
X-Received: by 2002:a05:6a00:8086:b0:68e:16ce:f2e3 with SMTP id
 eh6-20020a056a00808600b0068e16cef2e3mr10213797pfb.0.1694860932313; 
 Sat, 16 Sep 2023 03:42:12 -0700 (PDT)
Received: from [192.168.159.125] ([157.82.206.1])
 by smtp.gmail.com with ESMTPSA id
 d24-20020aa78e58000000b0066a4e561beesm4429037pfr.173.2023.09.16.03.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Sep 2023 03:42:11 -0700 (PDT)
Message-ID: <d671bfad-7d78-41cf-a6f4-e92bf6ce2bd5@daynix.com>
Date: Sat, 16 Sep 2023 19:42:04 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZQWEQ9ZHkokhKOSA@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

On 2023/09/16 19:32, Huang Rui wrote:
> On Fri, Sep 15, 2023 at 11:20:46PM +0800, Akihiko Odaki wrote:
>> On 2023/09/15 20:11, Huang Rui wrote:
>>> Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
>>> feature flags.
>>> We would like to enable the feature with virglrenderer, so add to create
>>> virgl renderer context with flags using context_id when valid.
>>>
>>> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>
>>> V4 -> V5:
>>>       - Inverted patch 5 and 6 because we should configure
>>>         HAVE_VIRGL_CONTEXT_INIT firstly. (Philippe)
>>>
>>>    hw/display/virtio-gpu-virgl.c | 13 +++++++++++--
>>>    hw/display/virtio-gpu.c       |  2 ++
>>>    2 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 8bb7a2c21f..312953ec16 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -106,8 +106,17 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
>>>        trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
>>>                                        cc.debug_name);
>>>    
>>> -    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
>>> -                                  cc.debug_name);
>>> +    if (cc.context_init) {
>>> +#ifdef HAVE_VIRGL_CONTEXT_INIT
>>> +        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
>>> +                                                 cc.context_init,
>>> +                                                 cc.nlen,
>>> +                                                 cc.debug_name);
>>> +        return;
>>> +#endif
>>
>> This should deal with the case when context_init is set while
>> HAVE_VIRGL_CONTEXT_INIT is not defined.
> 
> Actually, I received the comment below before:
> 
> https://lore.kernel.org/qemu-devel/32588d0e-a1f2-30c4-5e9f-e6e7c4190b65@linaro.org/
> 
> At original patch set, I have the case while HAVE_VIRGL_CONTEXT_INIT is set
> but HAVE_VIRGL_CONTEXT_INIT is not defined. But I think we may encounter
> the case that virgl_renderer_context_create_with_flags is not defined in
> virglrenderer early version. Should I bring the error message back?
> 
> Thanks,
> Ray

I suggest checking VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED instead of 
reporting an error here. Perhaps it may be easier to add #ifdef around:
 > +    DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,
 > +                    VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED, false),

