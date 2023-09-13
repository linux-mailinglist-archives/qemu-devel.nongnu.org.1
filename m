Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F779E9F4
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:45:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQ9l-00073x-Ro; Wed, 13 Sep 2023 09:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgQ9i-00073m-UC
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:43:47 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgQ9f-0004v3-18
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:43:46 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5733aa10291so4285384eaf.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694612622; x=1695217422;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jzquTyFTIWLKE8HIbexGNq7IS2ePO5uzHkINhBe2ZVw=;
 b=Hqt0FACyDI+oDIbbRsT2pwa6y1Dmt0YI9IKDqH8F8t8TeAfW/ekR/0ZQO/5kcX8g8w
 Edq3cK8x/Jycjr9ABB9d8OXQKBI0oEahr4qhRQqccuvlOxtFemKf2r4rqOhNkDCzWNUh
 7NIsuLqIBSO4nOeDLMLe1Bea9566IZU1Iz4CqSFUGYB6LPbwlwkRw5zqRI+QbNCuv0HI
 1t/bkd2Ci2+IVTr+Z8pffLycORlcimqSa0M4t0IqnFV63B0aesg2D4O6qEmVEfrJJbGr
 1lGfBTSXPjgXB41WjjVcc4uiYsYsvg5YyutLP8VfcmNsJc9FKQEk7FbK1WuCsKTOBpo8
 78OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694612622; x=1695217422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzquTyFTIWLKE8HIbexGNq7IS2ePO5uzHkINhBe2ZVw=;
 b=ZodnrzBnWOHJ5tDrME9qiKxR0uhfr+8g1QN3RYhjuCoNBPAdvU5vzjWvj6DMqr37sw
 GA2LK58sVahGQxgHuqVg2W5IxAPIDDLTQ8ps0GZAfT3GiRb17k39T1zwZd9uYKxqajPJ
 AGHPkFt54dTtj0KQ+ak1C5VclGQv6sVmm2hEITjxMf+XuY/oxcxmtTrli9XArwvFbQgX
 af2M5uyl+TDP8d+VudSPwe0oqad1lkTNVAG4U1Ss3z6ZQF++AnEoPQZgTUIlmMGVy91M
 QRfoa9TLZtR15hp2zmjz7IEDO/1J10BhIeOFZOhIlIfRzETAAJp/3r172El0uofmsTlE
 02WQ==
X-Gm-Message-State: AOJu0YyibeFv6dhOg7o/yDuUrn1gIVKKPLYU2jRWc4LUQ5U28Gy4ewil
 Jope13wi6AAtIiDGjmuO/5pfLg==
X-Google-Smtp-Source: AGHT+IEjkozRTXVlPn3DXYlS/zHkwLkZFxqYB9oImVmpvIGYOqRLulaJpbERB9hWp44RWG6Uk7Evlg==
X-Received: by 2002:a05:6358:278b:b0:139:5a46:ea7e with SMTP id
 l11-20020a056358278b00b001395a46ea7emr2890869rwb.28.1694612621726; 
 Wed, 13 Sep 2023 06:43:41 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a637e03000000b0057754ae4eb7sm6425543pgc.39.2023.09.13.06.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 06:43:41 -0700 (PDT)
Message-ID: <3918c96c-f106-494d-8e97-6d86cef8df27@daynix.com>
Date: Wed, 13 Sep 2023 22:43:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 10/13] virtio-gpu: Resource UUID
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>
Cc: Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
 <20230831093252.2461282-11-ray.huang@amd.com>
 <58a4e81f-b0ce-49db-8a6a-f6b5bdc3d2d6@daynix.com> <ZPw2UjxogIULU722@amd.com>
 <11c227e8-a464-41ce-a435-82c570746388@daynix.com>
 <CADSE00Kc1Jza7sbERRndWbXgoF1s2V-FNxEOWJ6WgvomzgvMPA@mail.gmail.com>
 <cf99ac00-6f48-4778-b319-6079a931ba5d@daynix.com>
 <CADSE00+6zcT7iKR0JW1Bk8es6HtBpzAKa9JW6u5yyjDoLPw2KQ@mail.gmail.com>
 <5e88f5d5-5aa2-4052-b250-69c2a443344f@daynix.com>
 <CADSE00+BUq-6jKH3v2PYNThn+9Z4UCFcr3Cv9Z48eUX0b=6ymA@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CADSE00+BUq-6jKH3v2PYNThn+9Z4UCFcr3Cv9Z48eUX0b=6ymA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2d.google.com
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

On 2023/09/13 21:58, Albert Esteve wrote:
> 
> 
> On Wed, Sep 13, 2023 at 2:22 PM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/09/13 20:34, Albert Esteve wrote:
>      >
>      >
>      > On Wed, Sep 13, 2023 at 12:34 PM Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2023/09/13 16:55, Albert Esteve wrote:
>      >      > Hi Antonio,
>      >      >
>      >      > If I'm not mistaken, this patch is related with:
>      >      >
>      >
>     https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html
>     <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html>
>      >   
>       <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html>>
>      >      >
>      >   
>       <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html>
>      >   
>       <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html>>>
>      >      > IMHO, ideally, virtio-gpu and vhost-user-gpu both, would
>     use the
>      >      > infrastructure from the patch I linked to store the
>      >      > virtio objects, so that they can be later shared with
>     other devices.
>      >
>      >     I don't think such sharing is possible because the resources are
>      >     identified by IDs that are local to the device. That also
>     complicates
>      >     migration.
>      >
>      >     Regards,
>      >     Akihiko Odaki
>      >
>      > Hi Akihiko,
>      >
>      > As far as I understand, the feature to export dma-bufs from the
>      > virtgpu was introduced as part of the virtio cross-device sharing
>      > proposal [1]. Thus, it shall be posible. When virtgpu ASSING_UUID,
>      > it exports and identifies the dmabuf resource, so that when the
>     dmabuf gets
>      > shared inside the guest (e.g., with virtio-video), we can use the
>     assigned
>      > UUID to find the dmabuf in the host (using the patch that I
>     linked above),
>      > and import it.
>      >
>      > [1] - https://lwn.net/Articles/828988/
>     <https://lwn.net/Articles/828988/> <https://lwn.net/Articles/828988/
>     <https://lwn.net/Articles/828988/>>
> 
>     The problem is that virtio-gpu can have other kind of resources like
>     pixman and OpenGL textures and manage them and DMA-BUFs with unified
>     resource ID.
> 
> 
> I see.
> 
> 
>     So you cannot change:
>     g_hash_table_insert(g->resource_uuids,
>     GUINT_TO_POINTER(assign.resource_id), uuid);
>     by:
>     virtio_add_dmabuf(uuid, assign.resource_id);
> 
>     assign.resource_id is not DMA-BUF file descriptor, and the underlying
>     resource my not be DMA-BUF at first place.
> 
> 
> I didn't really look into the patch in-depth, so the code was intended
> to give an idea of how the implementation would look like with
> the cross-device patch API. Indeed, it is not the resource_id,
> (I just took a brief look at the virtio specificacion 1.2), but the 
> underlying
> resource what we want to use here.
> 
> 
>     Also, since this lives in the common code that is not used only by
>     virtio-gpu-gl but also virtio-gpu, which supports migration, we also
>     need to take care of that. It is not a problem for DMA-BUF as
>     DMA-BUF is
>     not migratable anyway, but the situation is different in this case.
> 
>     Implementing cross-device sharing is certainly a possibility, but that
>     requires more than dealing with DMA-BUFs.
> 
> 
> So, if I understood correctly, dmabufs are just a subset of the resources
> that the gpu manages, or can assign UUIDs to. I am not sure why
> the virt gpu driver would want to send a ASSIGN_UUID for anything
> that is not a dmabuf (are we sure it does?), but I am not super familiarized
> with virtgpu to begin with.

In my understanding, an resource will be first created as OpenGL or 
Vulkan textures and then exported as a DMA-BUF file descriptor. For 
these resource types exporting/importing code is mandatory.

For pixman buffers (i.e., non-virgl device), I don't see a compelling 
reason to have cross-device sharing. It is possible to omit resource 
UUID feature from non-virgl device to avoid implementing complicated 
migration.

> But I see that internally, the GPU specs relate a UUID with a resource_id,
> so we still need both tables:
> - one to relate UUID with resource_id to be able to locate the 
> underlying resource
> - the table that holds the dmabuf with the UUID for cross-device sharing
> 
> With that in mind, sounds to me that the support for cross-device 
> sharing could
> be added on top of this patch, once 
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01850.html 
> <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01850.html>
> lands.

That is possible, but I think it's better to implement cross-device 
sharing at the same time introducing virtio-dmabuf.

The current design of virtio-dmabuf looks somewhat inconsistent; it's 
named "dmabuf", but internally the UUIDs are stored into something named 
"resource_uuids" and it has SharedObjectType so it's more like a generic 
resource sharing mechanism. If you actually have an implementation of 
cross-device sharing using virtio-dmabuf, it will be clear what kind of 
feature is truly necessary.

Regards,
Akihiko Odaki

