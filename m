Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C9D7A7264
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 07:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiqAM-0003ss-CW; Wed, 20 Sep 2023 01:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qiqAB-0003qS-75
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 01:54:16 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qiqA6-0000Bd-W3
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 01:54:13 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bd04558784so4073474a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695189249; x=1695794049;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xMWeF2HhGZEWc0W+5GSi6sL68pIB2U4XVLduYOYAG9A=;
 b=Y4EhR2ycjyBxxJ7o+BJB8PxU+CVmWttCG5/e2wkLXgVIUQ3YDhSNLmhFtASAlbiz1b
 U4fVmY3Iur4mON2o94jIf5/V10p/MgO3vrZfv19hgTMmIDliBMXV7/FRxo/UU5ZMKUjv
 Yo5GbY8wFLnM70KVQCjRbiE8nIZCPg69EYiMkUGaPVt/EuKoYgaU4+OdVw06k8qiujfb
 flkjdydG3/u8T3rRnRdKLblP+RtolgIqT2CRbVrdUzwsjsSZXzHJj9On7GZRDnwesVyv
 yebPUPxIYNGlKum9XQGknDI+Cv5DlaOdgdIlJZdM7gfw+CXN5enlN5fpMiIF8mxIPYIP
 e6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695189249; x=1695794049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xMWeF2HhGZEWc0W+5GSi6sL68pIB2U4XVLduYOYAG9A=;
 b=jT3C/vZmRdfoHPXqLG4XjFjjWq2FYN6UxrcLJP/Q17qBsx3Nz7QVEmlmJekhjmKZAl
 oHu0likcolxjk6SQppOCZ25W1u+YgVV1FwvFVaZA/i8huIMXeVnOoEye1UZdI/UQYipc
 BWDnOuO3Q4fc+Ar/rcLOQkyqX9xvgE454iwp541aPl6wjdI2B6lR4q1tMKX6yxBArXu/
 9h5fUIHQCK7h6JWlNYf0JiwUIixGYxAyirWDG0zy4ZvSzYGnE4ObKQDUCX4+DoPIkgXj
 N2enk5CEvOvH2gbOy13e5VX9qepAhW9fPv7skuWpHiARkmSSBMnWpVUeKzw9Jt2cQzYg
 SO/Q==
X-Gm-Message-State: AOJu0YzRBXgCmBdgI8Cv2+g0gEBaryzPejS/JxaPT8HTznDwZ81oC3d9
 C/uzoUT4imkOudNC1qAJXi+8LQ==
X-Google-Smtp-Source: AGHT+IHSnmwNDAcIECGG0e9lrMrXi65An+rcs2Anr48VT3xg5CLb1z5c35tqPfVv2JWWozOjj1lmWA==
X-Received: by 2002:a05:6358:2490:b0:135:57d0:d173 with SMTP id
 m16-20020a056358249000b0013557d0d173mr1915328rwc.20.1695189249348; 
 Tue, 19 Sep 2023 22:54:09 -0700 (PDT)
Received: from [157.82.207.45] ([157.82.207.45])
 by smtp.gmail.com with ESMTPSA id
 14-20020a17090a004e00b002609cadc56esm594933pjb.11.2023.09.19.22.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 22:54:09 -0700 (PDT)
Message-ID: <8d1f6b30-795e-418e-aeb5-3823680ea70a@daynix.com>
Date: Wed, 20 Sep 2023 14:54:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v5 09/13] virtio-gpu: Handle resource blob commands
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
 <20230915111130.24064-10-ray.huang@amd.com>
 <a14b26dc-c804-4be8-83d5-088e71d37a7b@daynix.com>
 <9700c2ed-93c5-4bf6-bc6b-d5d33359d9a7@daynix.com> <ZQqIFvasHD+Y8TSa@amd.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZQqIFvasHD+Y8TSa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x331.google.com
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

On 2023/09/20 14:50, Huang Rui wrote:
> On Sat, Sep 16, 2023 at 12:37:29AM +0800, Akihiko Odaki wrote:
>> On 2023/09/16 1:04, Akihiko Odaki wrote:
>>> On 2023/09/15 20:11, Huang Rui wrote:
>>>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>>>
>>>> Support BLOB resources creation, mapping and unmapping by calling the
>>>> new stable virglrenderer 0.10 interface. Only enabled when available and
>>>> via the blob config. E.g. -device virtio-vga-gl,blob=true
>>>>
>>>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>>> ---
>>>>
>>>> V4 -> V5:
>>>>       - Use memory_region_init_ram_ptr() instead of
>>>>         memory_region_init_ram_device_ptr() (Akihiko)
>>>>
>>>>    hw/display/virtio-gpu-virgl.c  | 213 +++++++++++++++++++++++++++++++++
>>>>    hw/display/virtio-gpu.c        |   4 +-
>>>>    include/hw/virtio/virtio-gpu.h |   5 +
>>>>    meson.build                    |   4 +
>>>>    4 files changed, 225 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/display/virtio-gpu-virgl.c
>>>> b/hw/display/virtio-gpu-virgl.c
>>>> index 312953ec16..563a6f2f58 100644
>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>> @@ -17,6 +17,7 @@
>>>>    #include "trace.h"
>>>>    #include "hw/virtio/virtio.h"
>>>>    #include "hw/virtio/virtio-gpu.h"
>>>> +#include "hw/virtio/virtio-gpu-bswap.h"
>>>>    #include "ui/egl-helpers.h"
>>>> @@ -78,9 +79,24 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>>>>        virgl_renderer_resource_create(&args, NULL, 0);
>>>>    }
>>>> +static void virgl_resource_destroy(VirtIOGPU *g,
>>>> +                                   struct virtio_gpu_simple_resource
>>>> *res)
>>>> +{
>>>> +    if (!res)
>>>> +        return;
>>>> +
>>>> +    QTAILQ_REMOVE(&g->reslist, res, next);
>>>> +
>>>> +    virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
>>>> +    g_free(res->addrs);
>>>> +
>>>> +    g_free(res);
>>>> +}
>>>> +
>>>>    static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>>>                                         struct virtio_gpu_ctrl_command
>>>> *cmd)
>>>>    {
>>>> +    struct virtio_gpu_simple_resource *res;
>>>>        struct virtio_gpu_resource_unref unref;
>>>>        struct iovec *res_iovs = NULL;
>>>>        int num_iovs = 0;
>>>> @@ -88,13 +104,22 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>>>        VIRTIO_GPU_FILL_CMD(unref);
>>>>        trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>>>> +    res = virtio_gpu_find_resource(g, unref.resource_id);
>>>> +
>>>>        virgl_renderer_resource_detach_iov(unref.resource_id,
>>>>                                           &res_iovs,
>>>>                                           &num_iovs);
>>>>        if (res_iovs != NULL && num_iovs != 0) {
>>>>            virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
>>>> +        if (res) {
>>>> +            res->iov = NULL;
>>>> +            res->iov_cnt = 0;
>>>> +        }
>>>>        }
>>>> +
>>>>        virgl_renderer_resource_unref(unref.resource_id);
>>>> +
>>>> +    virgl_resource_destroy(g, res);
>>
>> This may leak memory region.
> 
> The memory region should be freed under virgl_cmd_resource_unmap_blob()
> which is calling memory_region_del_subregion(&b->hostmem, res->region).
> Because this region is created by map_blob(). Do we have the case to call
> virgl_cmd_resource_unref() without calling virgl_cmd_resource_unmap_blob()
> for blob memory?

Calling virgl_cmd_resource_unmap_blob() and virgl_cmd_resource_unref() 
in order is a guest's responsibility, and we are required to prepare for 
broken guests.

