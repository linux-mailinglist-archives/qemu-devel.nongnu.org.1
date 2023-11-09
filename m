Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3467F7E6FC0
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:58:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18LP-0004Gs-2Q; Thu, 09 Nov 2023 11:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r18LM-0004A5-AX
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r18LJ-0003vs-MI
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699549038;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGNAd0CCAFbg+X0XBuhVmmvnEpWQQnixBKgVDcj1KZc=;
 b=KW//iH0GVlO9EpFy8UYglTyoQekeQ4ul1a/UeJl97HGzAhunHqoRHXjkz8vqCUkKfToUTK
 /0ElHfh6IDX1ndoOXYiyZGyVSvcJtArLEXYYiO4nDOAPFT08APdE4BzYDcY/iuelEDZfth
 tMR01DpK6pDAMhOLwx8+cbM1XfVF+go=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-FkbG05IlPNCa6dV89r-CLw-1; Thu, 09 Nov 2023 11:57:17 -0500
X-MC-Unique: FkbG05IlPNCa6dV89r-CLw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d120c28afso11995836d6.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699549036; x=1700153836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGNAd0CCAFbg+X0XBuhVmmvnEpWQQnixBKgVDcj1KZc=;
 b=GRuS0t4y4H7Qs3X4ToLUwAfiTa0OLvHzazJl3BU4VM4SEZ06xiW3hU0POlM7lVeABQ
 OefQsGxDvmN0X6Q6E2b58if7WOMKuLIsnCOkYQXB768RbQ833TNjJm+9ZiaYJj01QTL6
 XzHaZeQh1gssUC/Z73fjgISTg6rbXOZmOv8h9zLkvtNZkgQbvverIoQ/dgg90InQkRO6
 VF0bXeiNov834Bsf0SmDJDx2elpS9bsrgmLWxZPAX5GTQOE+8M+/LDH7pb7Vm2rsL4Yk
 PFMxJWOZtyr1sutEyJsNdLeRoouKoivz3YqBZ6Hfcq2WHqcSNyibkAA0fPlk8EsUj0py
 Bn7A==
X-Gm-Message-State: AOJu0YzlDG6GSiNr2m/QLKjKOr0uIOk4aVP/JrXGw+gnoZdVQnAmGO7G
 Ye+Xv6CGFM6bOK8Non10xphPmqHznOJVO+tscs4PlvswVzC7aOjpJIZ9BcmOc+B9ZrtN65zRgZp
 G7hN38fwbXdVpQDI=
X-Received: by 2002:ad4:4eea:0:b0:66d:544d:8e68 with SMTP id
 dv10-20020ad44eea000000b0066d544d8e68mr6676179qvb.3.1699549036561; 
 Thu, 09 Nov 2023 08:57:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2JVAYl5FZXc8Gjg9t4xwtev117gfm98O3ekFp411fbNxH/AWRs5LxOI0A26ElCkBSd4oXxQ==
X-Received: by 2002:ad4:4eea:0:b0:66d:544d:8e68 with SMTP id
 dv10-20020ad44eea000000b0066d544d8e68mr6676163qvb.3.1699549036335; 
 Thu, 09 Nov 2023 08:57:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 dm9-20020ad44e29000000b0066da90f0c19sm2210580qvb.24.2023.11.09.08.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 08:57:15 -0800 (PST)
Message-ID: <aff2b741-c69d-44be-b072-e21f6bf3f159@redhat.com>
Date: Thu, 9 Nov 2023 17:56:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/22] virtio-iommu: Record whether a probe request has
 been issued
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
 <20231106143653.302391-10-clg@redhat.com>
 <CAFEAcA_P+ewPD7PD_ZqfWJ_GX1szM_zxMr_G5cMYNWLApn_raw@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_P+ewPD7PD_ZqfWJ_GX1szM_zxMr_G5cMYNWLApn_raw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter,

On 11/9/23 16:08, Peter Maydell wrote:
> On Mon, 6 Nov 2023 at 14:48, Cédric Le Goater <clg@redhat.com> wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> Add an IOMMUDevice 'probe_done' flag to record that the driver
>> already issued a probe request on that device.
>>
>> This will be useful to double check host reserved regions aren't
>> notified after the probe and hence are not taken into account
>> by the driver.
> Hi; Coverity points out (CID 1523901) that this change introduced
> dead code (but improves on the previous bad code!):
>
>
>> -static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
>> +static ssize_t virtio_iommu_fill_resv_mem_prop(IOMMUDevice *sdev, uint32_t ep,
>>                                                 uint8_t *buf, size_t free)
>>  {
>>      struct virtio_iommu_probe_resv_mem prop = {};
>>      size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
>> -    IOMMUDevice *sdev;
>>      GList *l;
>>
>> -    sdev = container_of(virtio_iommu_mr(s, ep), IOMMUDevice, iommu_mr);
>> -    if (!sdev) {
>> -        return -EINVAL;
>> -    }
> In the old code this check on sdev was wrong -- because iommu_mr
> is not the first field in IOMMUDevice, if virtio_iommu_mr() returns
> NULL that doesn't mean that container_of(...) is going to be NULL.
indeed thank you for pointing this out
>
>> -
>>      total = size * g_list_length(sdev->resv_regions);
>>      if (total > free) {
>>          return -ENOSPC;
>> @@ -688,19 +682,27 @@ static int virtio_iommu_probe(VirtIOIOMMU *s,
>>                                uint8_t *buf)
>>  {
>>      uint32_t ep_id = le32_to_cpu(req->endpoint);
>> +    IOMMUMemoryRegion *iommu_mr = virtio_iommu_mr(s, ep_id);
>>      size_t free = VIOMMU_PROBE_SIZE;
>> +    IOMMUDevice *sdev;
>>      ssize_t count;
>>
>> -    if (!virtio_iommu_mr(s, ep_id)) {
>> +    if (!iommu_mr) {
>>          return VIRTIO_IOMMU_S_NOENT;
>>      }
>>
>> -    count = virtio_iommu_fill_resv_mem_prop(s, ep_id, buf, free);
>> +    sdev = container_of(iommu_mr, IOMMUDevice, iommu_mr);
>> +    if (!sdev) {
>> +        return -EINVAL;
>> +    }
> In the new code we already check directly whether virtio_iommu_mr()
> returned NULL. So the check on sdev being NULL is simply dead
> code -- it can never be true and we should just delete it.

OK. Sending a fix ...

Thanks!

Eric


>
>> +
>> +    count = virtio_iommu_fill_resv_mem_prop(sdev, ep_id, buf, free);
>>      if (count < 0) {
>>          return VIRTIO_IOMMU_S_INVAL;
>>      }
>>      buf += count;
>>      free -= count;
>> +    sdev->probe_done = true;
>>
>>      return VIRTIO_IOMMU_S_OK;
>>  }
> thanks
> -- PMM
>


