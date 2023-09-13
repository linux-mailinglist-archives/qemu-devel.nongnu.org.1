Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20579E7D3
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:23:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOtg-0001XX-GI; Wed, 13 Sep 2023 08:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgOtF-0001WT-MG
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:22:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgOt9-0000wu-Hg
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:22:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fba57030fso3154931b3a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694607753; x=1695212553;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bd7AjsFGHVU9ZgF8t64qnNi1wuPnAXka53rRg0j9Ps8=;
 b=MLLFtYMlLZloUxjY5dilAgVSioaR4Fl3wRwaWskxOKBxw57LpHP7XigW0psvRlomam
 UfYk+UDjI9ssL7C0kZI6dKn8E5DDJCAQ7PvmoP7gSKzzZEYmSZfnZWuEmKxHhQ5mvFqj
 KtmUfSShiemT/2ylH1pTh4WrZw2qGg0gTsp50PcYzVJDAi8ZIstQ7JrOGmCpaVpjRqkc
 eqhUgKPSj0g2+4Vg8BxTgXYNfY9McpwqRCQCnTxll5DSAmkYtza7l9WksNgkc0E86vGb
 iRaFuFxUH8Ze34baQ2ZcUMSBz7UrXt2WRHIQJ0ExBZp/URvlK2kxdMI0DY/eN08vH1wQ
 6SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694607753; x=1695212553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bd7AjsFGHVU9ZgF8t64qnNi1wuPnAXka53rRg0j9Ps8=;
 b=kaGSC4H+sky+huPtSbWEVfP/Dpv6QrmsoKDsZTtLoRCJnSisdC2w3pf6AsCssX4PPX
 Pe4STrmMSful75CBjrxtEYJnl7h7Sj5z+Gq+ymvLWnFogVTX9wnwltYZfaz/1cVIAF2J
 AIK5HhFuSHIUxi0ckKXMTgwJou4Bjw9cCnduYioW5+ZXi1MA9Uxu5JpoIq603jT2S9q8
 jOWIy8YA7i/R6DLgMuEGrbEwexpDuuzGR3IFDOcOfeH1FhdsG22jrViZpY6PYn772mPn
 o5l4y9PFUxijBn+xfElQV3dARlkLDWpbNUG2eMysDHC/LMGn1sjer4TQzBXGLj/jowZ7
 KyyA==
X-Gm-Message-State: AOJu0YxSDNZ+qvGmM4fMCBYn2XFpp+nJter6l12vDB/NupkwMT54J4e7
 79trNvn2M1so07CCVxEf/UZbnA==
X-Google-Smtp-Source: AGHT+IFUceWhWOwzr7PceZj0Aedx/pJWoToZ/n1XM68m4HSxGEeSRi2V9aKihvMef0Dz/aLMOl/mPA==
X-Received: by 2002:a05:6a20:e125:b0:137:3c67:85d7 with SMTP id
 kr37-20020a056a20e12500b001373c6785d7mr2865750pzb.16.1694607752788; 
 Wed, 13 Sep 2023 05:22:32 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a170902c38100b001c3267ae314sm10323061plg.156.2023.09.13.05.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 05:22:32 -0700 (PDT)
Message-ID: <5e88f5d5-5aa2-4052-b250-69c2a443344f@daynix.com>
Date: Wed, 13 Sep 2023 21:22:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v4 10/13] virtio-gpu: Resource UUID
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CADSE00+6zcT7iKR0JW1Bk8es6HtBpzAKa9JW6u5yyjDoLPw2KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

On 2023/09/13 20:34, Albert Esteve wrote:
> 
> 
> On Wed, Sep 13, 2023 at 12:34 PM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/09/13 16:55, Albert Esteve wrote:
>      > Hi Antonio,
>      >
>      > If I'm not mistaken, this patch is related with:
>      >
>     https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html
>     <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html>
>      >
>     <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html
>     <https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01853.html>>
>      > IMHO, ideally, virtio-gpu and vhost-user-gpu both, would use the
>      > infrastructure from the patch I linked to store the
>      > virtio objects, so that they can be later shared with other devices.
> 
>     I don't think such sharing is possible because the resources are
>     identified by IDs that are local to the device. That also complicates
>     migration.
> 
>     Regards,
>     Akihiko Odaki
> 
> Hi Akihiko,
> 
> As far as I understand, the feature to export dma-bufs from the
> virtgpu was introduced as part of the virtio cross-device sharing
> proposal [1]. Thus, it shall be posible. When virtgpu ASSING_UUID,
> it exports and identifies the dmabuf resource, so that when the dmabuf gets
> shared inside the guest (e.g., with virtio-video), we can use the assigned
> UUID to find the dmabuf in the host (using the patch that I linked above),
> and import it.
> 
> [1] - https://lwn.net/Articles/828988/ <https://lwn.net/Articles/828988/>

The problem is that virtio-gpu can have other kind of resources like 
pixman and OpenGL textures and manage them and DMA-BUFs with unified 
resource ID.

So you cannot change:
g_hash_table_insert(g->resource_uuids, 
GUINT_TO_POINTER(assign.resource_id), uuid);
by:
virtio_add_dmabuf(uuid, assign.resource_id);

assign.resource_id is not DMA-BUF file descriptor, and the underlying 
resource my not be DMA-BUF at first place.

Also, since this lives in the common code that is not used only by 
virtio-gpu-gl but also virtio-gpu, which supports migration, we also 
need to take care of that. It is not a problem for DMA-BUF as DMA-BUF is 
not migratable anyway, but the situation is different in this case.

Implementing cross-device sharing is certainly a possibility, but that 
requires more than dealing with DMA-BUFs.

