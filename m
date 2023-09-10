Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2808799CA4
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 06:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfC7J-0000p9-UM; Sun, 10 Sep 2023 00:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfC7I-0000jw-2s
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 00:32:12 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfC7F-0001af-Bi
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 00:32:11 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-76f08e302a1so203351785a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 21:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694320328; x=1694925128;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6mLDKK0spS0SXw0nxD2bYbl1ukTpmkTjYoJfRa7X6Jc=;
 b=MAZwuWPZdZGly6cayHw0+Sz1EqNCdiBBTZvDwxD995nspURMJKEXzclYABXag3Wi42
 gJP0/0YdsotXuER+ZMMg2nX+QVB96nAIE55a+5bmnZ/7iFqia2tlgaX6q3VmmsX6MFs+
 sIa6x6Je7HQmnUxLv6C1K3TcFn415KMQERynBrC9Vb5SX74Fp5upyRCh/e1TQyCGvaze
 L90gNPlYEBvkLBK9net/yHhiVNUFwA0+rYJ8sjr2kGMf/dKsejKmgL6MbI6G5xOILfrB
 Ycs6S+PrslgrYXjnsnYbQJpZ35fRXamHqezgBMw8I8A7KLzNTI29J68DPGKgcGWHelI2
 Krbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694320328; x=1694925128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6mLDKK0spS0SXw0nxD2bYbl1ukTpmkTjYoJfRa7X6Jc=;
 b=eTl9BhdjpKETLV6OpxeHCMz4Rb9q3Ncxzre7jquoT9GVCOT1gJ0G7ZWOJQg+abNlHj
 ndUt9+J8pP04OxF7q0w0HNMIUd/e9qdUFlyYYm4/O72BDRLhOkPXiUzQ8DL7ZiaKMk8q
 HhrtkQajsYhORLDEhWU0ejs4EQJolPN+cfieFcwxkuahCri/oOQvay+LyRV5whWRWdXM
 RbVoHmnb3xT7NIk9wj5/WnVnY1wbry2/hVUzIUNHcZ3xFeHqpcj9MTbZszri7xBfszXz
 4a4kilJnhI/xvA35HgcT3ou5kiFdGk4L31++YgPWZSvXcDxtnxyT+94OyCeX+jOsl1q6
 6S3A==
X-Gm-Message-State: AOJu0YwkBBgar71eTsfE1DJQTEkStFiOGbZTDDB5m2Q9wRvMliULtYtj
 qWXnJ+ygLpCvkG/jzDpVIs78mA==
X-Google-Smtp-Source: AGHT+IH41CY1gp7ku8RIGtDEesEP1+sGE/g5r/DzrN13Mfai6YcjxHyadOjiT3yptF7xCb8j/jsORw==
X-Received: by 2002:a05:620a:2983:b0:76f:f0b:a1b8 with SMTP id
 r3-20020a05620a298300b0076f0f0ba1b8mr8942239qkp.25.1694320328329; 
 Sat, 09 Sep 2023 21:32:08 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 e19-20020aa78c53000000b00679a4b56e41sm3387194pfd.43.2023.09.09.21.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 21:32:07 -0700 (PDT)
Message-ID: <b82982aa-5b9e-481e-9491-b9313877bcaa@daynix.com>
Date: Sun, 10 Sep 2023 13:32:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 11/13] virtio-gpu: Support Venus capset
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
 <20230831093252.2461282-12-ray.huang@amd.com>
 <fe36e4e1-1198-4da4-b6ee-a6a00a44298a@daynix.com> <ZPw7FIMmykdYtVeM@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZPw7FIMmykdYtVeM@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::730;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qk1-x730.google.com
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

On 2023/09/09 18:29, Huang Rui wrote:
> On Thu, Aug 31, 2023 at 06:43:17PM +0800, Akihiko Odaki wrote:
>> On 2023/08/31 18:32, Huang Rui wrote:
>>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>>
>>> Add support for the Venus capset, which enables Vulkan support through
>>> the Venus Vulkan driver for virtio-gpu.
>>>
>>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>    hw/display/virtio-gpu-virgl.c               | 21 +++++++++++++++++----
>>>    include/standard-headers/linux/virtio_gpu.h |  2 ++
>>>    2 files changed, 19 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 1a996a08fc..83cd8c8fd0 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -437,6 +437,11 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>>>            virgl_renderer_get_cap_set(resp.capset_id,
>>>                                       &resp.capset_max_version,
>>>                                       &resp.capset_max_size);
>>> +    } else if (info.capset_index == 2) {
>>> +        resp.capset_id = VIRTIO_GPU_CAPSET_VENUS;
>>> +        virgl_renderer_get_cap_set(resp.capset_id,
>>> +                                   &resp.capset_max_version,
>>> +                                   &resp.capset_max_size);
>>>        } else {
>>>            resp.capset_max_version = 0;
>>>            resp.capset_max_size = 0;
>>> @@ -901,10 +906,18 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>>>    
>>>    int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>>>    {
>>> -    uint32_t capset2_max_ver, capset2_max_size;
>>> +    uint32_t capset2_max_ver, capset2_max_size, num_capsets;
>>> +    num_capsets = 1;
>>> +
>>>        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
>>> -                              &capset2_max_ver,
>>> -                              &capset2_max_size);
>>> +                               &capset2_max_ver,
>>> +                               &capset2_max_size);
>>> +    num_capsets += capset2_max_ver ? 1 : 0;
>>> +
>>> +    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
>>> +                               &capset2_max_ver,
>>> +                               &capset2_max_size);
>>> +    num_capsets += capset2_max_size ? 1 : 0;
>>>    
>>> -    return capset2_max_ver ? 2 : 1;
>>> +    return num_capsets;
>>>    }
>>> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
>>> index 2da48d3d4c..2db643ed8f 100644
>>> --- a/include/standard-headers/linux/virtio_gpu.h
>>> +++ b/include/standard-headers/linux/virtio_gpu.h
>>> @@ -309,6 +309,8 @@ struct virtio_gpu_cmd_submit {
>>>    
>>>    #define VIRTIO_GPU_CAPSET_VIRGL 1
>>>    #define VIRTIO_GPU_CAPSET_VIRGL2 2
>>> +/* 3 is reserved for gfxstream */
>>> +#define VIRTIO_GPU_CAPSET_VENUS 4
>>
>> This file is synced with scripts/update-linux-headers.sh and should not
>> be modified.
> 
> Should I add marco in kernel include/uapi/linux/virtio_gpu.h?

Yes, I think so.

Regards,
Akihiko Odaki

