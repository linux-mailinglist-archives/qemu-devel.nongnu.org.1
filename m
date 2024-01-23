Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908BC838A7F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 10:42:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDHx-0004oD-Nr; Tue, 23 Jan 2024 04:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSDHv-0004nX-0J
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSDHt-0005XT-6c
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706002904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OARF2tvTlQRMsVPKh4tXSVqlzBy26fvVr07E4S1wG6Y=;
 b=h4Hpi/v0uVLQ8xT6RJ6kCD3yu6I+XuKa3CBBDEIjgRw5/xoRALwQeyxc3sH5YlGsFcW42Y
 OBay18nfG/vbIMDe6qSRPgLYltreW0rWVtJ8sm2kBCDBbekOoKh74ZztCpvV30Ez2/Hz9F
 r1/WuKJWi/1f4pJDZoeGJXV+4uFx9o0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-b6IUua_1O8GtC4EQsDNZMw-1; Tue, 23 Jan 2024 04:41:42 -0500
X-MC-Unique: b6IUua_1O8GtC4EQsDNZMw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc2470bc0bdso5444056276.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 01:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706002902; x=1706607702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OARF2tvTlQRMsVPKh4tXSVqlzBy26fvVr07E4S1wG6Y=;
 b=BlMB7H2aeN4gt/sdWKONhltbmnkstMPdxTjjotrQs9BP1lC+jkQZki+ca1FxcpukP9
 aNF0Lm1Xjdkfi40TNInskYMJ/NlLT0JCRDCvKQ3I563dNVnyHskto2LsmRhAwhw/jM1r
 wScKoSOM9vVQMcJog/C7U7g/fRsmCVxatYG1AHvvbHP59wlLlhBRIWDPXWlXxQboSAUZ
 SNtJq+hEskevubCZvCs7s8AOt4rjCppKK4nq0LW/iCf5qOuD31Y97J4f5CCsS682Xxxk
 I+gFKKyG7jmPeMRCQFWQRLzn3oU2c5g4iE64scy2tKZA7pW7LXe/Pq8QBvRW3foPFB55
 h86w==
X-Gm-Message-State: AOJu0YwWvNBgFQ1R2qdCyK1Y6OzwuKH5rhn690AaKjsFLODMNj8pgHVu
 Qs/iEx1c3UrTr0xn/nr++ZJee4FuVt6QkKVOnqko65YuCnPT+YiVOVCEipaTUxO6kG67ADUTXng
 0UenlE+yFqGSLlDOCVYqQhFWROKlxp9fWXY0CSM4emes+hvu1EdAP
X-Received: by 2002:a25:8206:0:b0:db7:d569:1859 with SMTP id
 q6-20020a258206000000b00db7d5691859mr3333249ybk.60.1706002901978; 
 Tue, 23 Jan 2024 01:41:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVODspEf0QzP+cuKkX+zmGTyIqN4f8OIwxTZd/uMFRdjDPGCvkvR90dC8adPBdXCVj1+DTzA==
X-Received: by 2002:a25:8206:0:b0:db7:d569:1859 with SMTP id
 q6-20020a258206000000b00db7d5691859mr3333244ybk.60.1706002901740; 
 Tue, 23 Jan 2024 01:41:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a0cfcc8000000b006819aeb62d6sm3297015qvq.136.2024.01.23.01.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 01:41:41 -0800 (PST)
Message-ID: <c47b95f9-ca42-4f8e-85d1-8fc72404e441@redhat.com>
Date: Tue, 23 Jan 2024 10:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] virtio_iommu: Clear IOMMUPciBus pointer cache when
 system reset
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: eric.auger@redhat.com, jean-philippe@linaro.org,
 alex.williamson@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 mst@redhat.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240122064015.94630-1-zhenzhong.duan@intel.com>
 <20240122064015.94630-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240122064015.94630-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/22/24 07:40, Zhenzhong Duan wrote:
> IOMMUPciBus pointer cache is indexed by bus number, bus number
> may not always be a fixed value, i.e., guest reboot to different
> kernel which set bus number with different algorithm.
> 
> This could lead to endpoint binding to wrong iommu MR in
> virtio_iommu_get_endpoint(), then vfio device setup wrong
> mapping from other device.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/virtio/virtio-iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 8a4bd933c6..bfce3237f3 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1264,6 +1264,8 @@ static void virtio_iommu_system_reset(void *opaque)
>   
>       trace_virtio_iommu_system_reset();
>   
> +    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_num));
> +
>       /*
>        * config.bypass is sticky across device reset, but should be restored on
>        * system reset

you could remove the memset in virtio_iommu_device_realize() then ?


Thanks,

C.



