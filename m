Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C630D7A23AE
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:38:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBp8-0002iK-Lb; Fri, 15 Sep 2023 12:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhBp6-0002i9-Iw
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:37:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhBp3-00045W-Gz
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:37:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c35ee3b0d2so18697775ad.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694795856; x=1695400656;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QvbdwGc2q9ykrPdPA/5vXC1OmEEsdu9JN7M2jZpSlQY=;
 b=zz1HphnrwvJSZXF1+ur6g7UeVxPQ6qEYpxC/vrg09pyZQQAVWU4Wqvq+OaAGYqGhd+
 CEyOkNDky278RYV+byqilJggICxIkMqsbrMxJ/Tqd/uzKC7HQBaEKJ846e7tJQgcMk9s
 QOw3/WuigduPfBYzXNNtwmqA7VL7V/i39U4jPSnJS7ds/wFgaKfjo+M/rUfWNtUZJ6Sc
 b7KPa5yY/tz13T2w4ILCxfDXSKZTnZfatVPVYFCLdpdSOaHrN9CgVbU16jUBSnTY3+vo
 4UiEi7gAv9MtCHRNy7L12Kpgp2DYMTA+PoMV8JrBMb/TsQti1wFObGNuQIqQQ2s4re76
 RV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694795856; x=1695400656;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QvbdwGc2q9ykrPdPA/5vXC1OmEEsdu9JN7M2jZpSlQY=;
 b=PbtQy4+J+Y8XxBQ5DIZpNOcDomLUqwESWYiMlUCHMPS/l4ka6KkESN3vNGtoWnArwi
 fQUS8x4SnTtrdgxcxj+oZJtOFoZ4qnRd7nCN6mSaTTjlwJ0wE7CA//Jw++TpHl4KJVZB
 VnyjcPqlQzjXqxBtQ0X1Bwy9BG2QTvzefAIKUTGrCkt0xTmbsTVweYJKpRjHNhG0eQWd
 r5J0hGNjvHG2KUaqZ7Hujx/nJWmVWCrOwC8GjKVbj5Ua9wgf6O8vXpna32LDDyoQraQg
 Ea7RqYcyKmX74HYEk69GDg9EFa0Vp6xGub1CFD6GoP47gwERWZLiB6bgcJR93cF2H7WJ
 MKMg==
X-Gm-Message-State: AOJu0YztV+mT0V/ZmDtsSCX33PzQairS2fNJIM+1W6a1qOOMPS0Z++in
 wCwQyPeiH/vNd4q+V2Bm8LKvaQ==
X-Google-Smtp-Source: AGHT+IHbWHKGZmN4Ilxyi7utzfQU0/OWAKabcK7DzJPoXar13eQHnjOLF+Kj6/lxHHwJgWxPUH4Dfw==
X-Received: by 2002:a17:903:2291:b0:1b8:6cae:4400 with SMTP id
 b17-20020a170903229100b001b86cae4400mr2373071plh.37.1694795855923; 
 Fri, 15 Sep 2023 09:37:35 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902ee4d00b001aaecc0b6ffsm3708212plo.160.2023.09.15.09.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 09:37:35 -0700 (PDT)
Message-ID: <9700c2ed-93c5-4bf6-bc6b-d5d33359d9a7@daynix.com>
Date: Sat, 16 Sep 2023 01:37:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 09/13] virtio-gpu: Handle resource blob commands
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Albert Esteve <aesteve@redhat.com>, ernunes@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20230915111130.24064-1-ray.huang@amd.com>
 <20230915111130.24064-10-ray.huang@amd.com>
 <a14b26dc-c804-4be8-83d5-088e71d37a7b@daynix.com>
In-Reply-To: <a14b26dc-c804-4be8-83d5-088e71d37a7b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2023/09/16 1:04, Akihiko Odaki wrote:
> On 2023/09/15 20:11, Huang Rui wrote:
>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>
>> Support BLOB resources creation, mapping and unmapping by calling the
>> new stable virglrenderer 0.10 interface. Only enabled when available and
>> via the blob config. E.g. -device virtio-vga-gl,blob=true
>>
>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> ---
>>
>> V4 -> V5:
>>      - Use memory_region_init_ram_ptr() instead of
>>        memory_region_init_ram_device_ptr() (Akihiko)
>>
>>   hw/display/virtio-gpu-virgl.c  | 213 +++++++++++++++++++++++++++++++++
>>   hw/display/virtio-gpu.c        |   4 +-
>>   include/hw/virtio/virtio-gpu.h |   5 +
>>   meson.build                    |   4 +
>>   4 files changed, 225 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c 
>> b/hw/display/virtio-gpu-virgl.c
>> index 312953ec16..563a6f2f58 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -17,6 +17,7 @@
>>   #include "trace.h"
>>   #include "hw/virtio/virtio.h"
>>   #include "hw/virtio/virtio-gpu.h"
>> +#include "hw/virtio/virtio-gpu-bswap.h"
>>   #include "ui/egl-helpers.h"
>> @@ -78,9 +79,24 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>>       virgl_renderer_resource_create(&args, NULL, 0);
>>   }
>> +static void virgl_resource_destroy(VirtIOGPU *g,
>> +                                   struct virtio_gpu_simple_resource 
>> *res)
>> +{
>> +    if (!res)
>> +        return;
>> +
>> +    QTAILQ_REMOVE(&g->reslist, res, next);
>> +
>> +    virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
>> +    g_free(res->addrs);
>> +
>> +    g_free(res);
>> +}
>> +
>>   static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>                                        struct virtio_gpu_ctrl_command 
>> *cmd)
>>   {
>> +    struct virtio_gpu_simple_resource *res;
>>       struct virtio_gpu_resource_unref unref;
>>       struct iovec *res_iovs = NULL;
>>       int num_iovs = 0;
>> @@ -88,13 +104,22 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>       VIRTIO_GPU_FILL_CMD(unref);
>>       trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>> +    res = virtio_gpu_find_resource(g, unref.resource_id);
>> +
>>       virgl_renderer_resource_detach_iov(unref.resource_id,
>>                                          &res_iovs,
>>                                          &num_iovs);
>>       if (res_iovs != NULL && num_iovs != 0) {
>>           virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
>> +        if (res) {
>> +            res->iov = NULL;
>> +            res->iov_cnt = 0;
>> +        }
>>       }
>> +
>>       virgl_renderer_resource_unref(unref.resource_id);
>> +
>> +    virgl_resource_destroy(g, res);

This may leak memory region.

