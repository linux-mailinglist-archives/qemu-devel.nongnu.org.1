Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A877F35E6
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:29:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5VUf-0006jQ-UX; Tue, 21 Nov 2023 13:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r5VUX-0006fP-Of
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r5VUV-0003Pr-MS
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700591333;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJaVI7eFQSumVnEyWm3N6x8y85gR6jqngXrsofoKTB4=;
 b=hioSv4wtb4mSUvH3zPkACQ8+pM8RcOQqkYxNV30BmLXy2rLh0jWbtyYePA2H511l7q3Li2
 gk9rDqG6qqmWPe6jZB6DxneRwEd10pUCroj9QurdSzRVwK7+tEe59fe7tgsbRldw82QaQa
 plOvFnRNWksX2S++CjxOE3MJfweTTSA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-A4rw1RiuMoKzdOkstEPWXw-1; Tue, 21 Nov 2023 13:28:51 -0500
X-MC-Unique: A4rw1RiuMoKzdOkstEPWXw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778b25af933so735880285a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 10:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700591331; x=1701196131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJaVI7eFQSumVnEyWm3N6x8y85gR6jqngXrsofoKTB4=;
 b=o1Sg2DGkz6VQ0tJ7rbbFGYX9NFjYpzerg9yKrtslMo2/b7P+yWOx2AvNHth5AE0+7l
 R6oS58fB1RZu6e6rO3lnSyYlU+Tsmnjnc0JvkLBgkCRTCKwKRMdXkEYOZI/6shrB2/aX
 E0psPdeMvhls3bR9+98tQKGqUTpmAED7Avb+UL9jiQAAFmvoIB+M+C5uh2dNIz7HwMc1
 bpId22E1sLewpFVJKoYcx644detN/+/VYv2BmE57V6n1MCS6zsllvaNBhHPTcro6vJbW
 scW5OhSc8w1cu3GFjxTSLBxicKcWCP9IT9v3Z4351v0rp3WKnL2jkkOkgj2r4Qfy9kDx
 U47w==
X-Gm-Message-State: AOJu0YwYocdqZYNd3hYG8DebGJWqv1wwQ/V0PRfB14lV0JLwk6M80rgM
 9XCUIc3jDghiLf6YjAPSxyYw07yTdrQGLR1tUkuJzEaywvA4jltDagSro2oYkAKDScZI7qB51Vf
 5ooHJpvTKKOy7BOE=
X-Received: by 2002:a05:620a:8e03:b0:778:8da0:a6a2 with SMTP id
 re3-20020a05620a8e0300b007788da0a6a2mr10219334qkn.28.1700591331034; 
 Tue, 21 Nov 2023 10:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn3Xyk5pLsdn1HBN3Gf0Iulqwss53v+TJluPWqhRUxNS9k1eyQjOoaHom5+J8VBhAv2u8rRg==
X-Received: by 2002:a05:620a:8e03:b0:778:8da0:a6a2 with SMTP id
 re3-20020a05620a8e0300b007788da0a6a2mr10219322qkn.28.1700591330738; 
 Tue, 21 Nov 2023 10:28:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a05620a0d8b00b0076cbcf8ad3bsm3774009qkl.55.2023.11.21.10.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 10:28:50 -0800 (PST)
Message-ID: <4775da43-e188-4d37-b869-a4084cfeaa23@redhat.com>
Date: Tue, 21 Nov 2023 19:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? 2/6] hw/virtio: Free
 VirtIOIOMMUPCI::vdev.reserved_regions[] on finalize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org
References: <20231121174051.63038-1-philmd@linaro.org>
 <20231121174051.63038-3-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231121174051.63038-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Phil,

On 11/21/23 18:40, Philippe Mathieu-Daudé wrote:
> Commit 0be6bfac62 ("qdev: Implement variable length array properties")
> added the DEFINE_PROP_ARRAY() macro with the following comment:
>
>   * It is the responsibility of the device deinit code to free the
>   * @_arrayfield memory.
>
> Commit 8077b8e549 added:
>
>   DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
>                     vdev.nb_reserved_regions, vdev.reserved_regions,
>                     qdev_prop_reserved_region, ReservedRegion),
>
> but forgot to free the 'vdev.reserved_regions' array. Do it in the
> instance_finalize() handler.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 8077b8e549 ("virtio-iommu-pci: Add array of Interval properties") # v5.1.0+
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/virtio/virtio-iommu-pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> index 9459fbf6ed..cbdfe4c591 100644
> --- a/hw/virtio/virtio-iommu-pci.c
> +++ b/hw/virtio/virtio-iommu-pci.c
> @@ -95,10 +95,18 @@ static void virtio_iommu_pci_instance_init(Object *obj)
>                                  TYPE_VIRTIO_IOMMU);
>  }
>  
> +static void virtio_iommu_pci_instance_finalize(Object *obj)
> +{
> +    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(obj);
> +
> +    g_free(dev->vdev.prop_resv_regions);
> +}
> +
>  static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info = {
>      .generic_name  = TYPE_VIRTIO_IOMMU_PCI,
>      .instance_size = sizeof(VirtIOIOMMUPCI),
>      .instance_init = virtio_iommu_pci_instance_init,
> +    .instance_finalize = virtio_iommu_pci_instance_finalize,
>      .class_init    = virtio_iommu_pci_class_init,
>  };
>  


