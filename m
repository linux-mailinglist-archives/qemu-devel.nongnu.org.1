Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F097B8E6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Sep 2024 09:59:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqpZl-0003M8-Ch; Wed, 18 Sep 2024 03:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqpZh-0003LZ-Sk
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqpZg-0003dU-DJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726646286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WtvuLo4xyAEF5BEoaO81cbiQ+lMAxcg/5SDCZ0qzAMY=;
 b=E3HqTBi3rdH98skEQyjMOCP07Vb0WWT5cHuBwAhyMqVDV3D+qPQ3nhsOr+H84xMc29IKHT
 UhA7RgEbp5lyya7kiHjpVwr9zSsGDooalptkv1e8pr29Qsaj5fo6EIt3MMMoy110X1tSoB
 1DAEyoPmVlgYdvFO2p2hPjPwOuGFNFQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-COqoan_MP3KmS5fDgbrfwA-1; Wed, 18 Sep 2024 03:58:02 -0400
X-MC-Unique: COqoan_MP3KmS5fDgbrfwA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374aef640a4so2405520f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 00:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726646281; x=1727251081;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WtvuLo4xyAEF5BEoaO81cbiQ+lMAxcg/5SDCZ0qzAMY=;
 b=e9Fxb3l/WkgtT+Gbslb5q2yOcRhrlggBg0BKw6RkxeGZa6O8QYSToT7rXptrQmc1LF
 G+dAonBHFXXrqjoENCfhUbZeHVitSYScVCVRap3IDVzpurXoXXT4+D+NA76CkfiO2R7o
 LjhI8jA9IQD37mb2oETU42sBozBFWMM3kwqR6Dy11kyQ+fsTa/YK60wXimmqtu9MiPwg
 /LZCkL4x3YvjOewP1urwGWViPqDrk6R4/JJQUWVp2ZJWC6btBeG+ptsaX/Azq9G9Oddr
 eexMsa/N+R7AqD4CPYnvV+dzv0j8yJBRknRr/WPbEO8NRbk+CX6ouBAvuXMUGV22wN4S
 hVeg==
X-Gm-Message-State: AOJu0YxUo8uzaMfrFAwS4DoQQmnSMWtKOQMcx/kIA3FjzD5ORigQukEG
 Tpf0WZbWVP1se59VrQwtTbHvBiURnCkqiqatWP8dZFpmMUZmWlaEhrvJD4bC4Odwxmkw+Op++NT
 xTGxMO9oelmMkc+dZcJRXfgPcyaUx/zHougtb0DnbBeqik1VPVbUn
X-Received: by 2002:adf:f9c2:0:b0:374:c8d3:5f2f with SMTP id
 ffacd0b85a97d-378c2d04cd9mr11580476f8f.31.1726646281123; 
 Wed, 18 Sep 2024 00:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeuq3eY2DvxCF7pQ4e1/aslyWHw993VWKE8iNcmGi/ita/WZQTJ/1oIpfP+whEU3eJl0TolQ==
X-Received: by 2002:adf:f9c2:0:b0:374:c8d3:5f2f with SMTP id
 ffacd0b85a97d-378c2d04cd9mr11580462f8f.31.1726646280603; 
 Wed, 18 Sep 2024 00:58:00 -0700 (PDT)
Received: from [10.131.4.59] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e81e2sm11580071f8f.37.2024.09.18.00.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 00:58:00 -0700 (PDT)
Message-ID: <b7f9dad2-29d9-42e6-97b0-32be6c077391@redhat.com>
Date: Wed, 18 Sep 2024 09:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
To: Gao Shiyuan <gaoshiyuan@baidu.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, zuoboqun@baidu.com
Cc: qemu-devel@nongnu.org
References: <20240903120304.97833-1-gaoshiyuan@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240903120304.97833-1-gaoshiyuan@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.09.24 14:03, Gao Shiyuan via wrote:
> Now virtio_address_space_lookup only lookup common/isr/device/notify
> MR and exclude their subregions.
> 
> When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER enable, the notify MR has
> host-notifier subregions and we need use host-notifier MR to
> notify the hardware accelerator directly instead of eventfd notify.
> 
> Further more, maybe common/isr/device MR also has subregions in
> the future, so need memory_region_find for each MR incluing
> their subregions.
> 
> Add lookup subregion of VirtIOPCIRegion MR instead of only lookup container MR.
> 
> Fixes: a93c8d8 ("virtio-pci: Replace modern_as with direct access to modern_bar")
> 
> Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> ---
>   hw/virtio/virtio-pci.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> ---
> v2 -> v3:
> * modify commit message
> * remove unused variable and move mrs to the inner block
> * replace error_report with assert
> 
> v1 -> v2:
> * modify commit message
> * replace direct iteration over subregions with memory_region_find.
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 524b63e5c7..4d832fe845 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -615,8 +615,12 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
>           reg = &proxy->regs[i];
>           if (*off >= reg->offset &&
>               *off + len <= reg->offset + reg->size) {
> -            *off -= reg->offset;
> -            return &reg->mr;
> +            MemoryRegionSection mrs = memory_region_find(&reg->mr,
> +                                        *off - reg->offset, len);
> +            assert(mrs.mr);

We are able to trigger that assert:

https://gitlab.com/qemu-project/qemu/-/issues/2576

Can you take a look and send a fix?

-- 
Cheers,

David / dhildenb


