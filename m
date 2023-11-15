Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638A7EC87F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:26:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ihi-0001AL-2Q; Wed, 15 Nov 2023 11:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3Ihg-00019q-0p
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3Ihe-0003OR-9f
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700065521;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAGPXkdcZ44WD5mb/hNotNFQBXrLqfNplgNPJ9c1E74=;
 b=bEQdYhrwpi4UnSM1i07bTuv5i2trYqR34Kg6RxWgjqqqaQ9bY8RTcx5vDuMguAfbSNk2vO
 VZXooVp//XtZazQMejejrdOHg0burljpB5QFbz560Hh//hr3NBvseDs46ZPFhjMFQTKqEv
 veOrWBqxDgMzrYB6kvbizjlmtTMdgbU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-PIlxOM8VPXCfal9lKNDyuA-1; Wed, 15 Nov 2023 11:25:20 -0500
X-MC-Unique: PIlxOM8VPXCfal9lKNDyuA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77c067efb88so67147585a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 08:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700065519; x=1700670319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OAGPXkdcZ44WD5mb/hNotNFQBXrLqfNplgNPJ9c1E74=;
 b=oXrRA9u5Ko0oVIS34uJtb+idm+PSGNw1t3ZBhNXjWdv9HS8AuL3pbxn21UEEkqpzw0
 +jyaZwjrnkbxCMED+SiQIH7F3AxBsCWm6KwvvwGSOet7wZFMUSYTN7/Wtu5JVDTnYOPB
 5RpHbEsd0yNKFyZBIWxGZrWffrITK462Yr4AoZ6waIqKikPpHdL2bbpGO8m8+TwBQvYZ
 ZOIAiRKGnuTWVLxD0bHU7qY2EjI60nl8nIJh83Q10nRsSOVmpcmHoJYkO9+XmeYtt3la
 feAY5soXGfJFgwnQ+6GcqRsJMUnJinY6lcfZB4vOGF7p4NWtk0/KtmYju9RCRA0otC6D
 SYyg==
X-Gm-Message-State: AOJu0YzQ/9QvGFaa6igV3aSUq2eq1wFZc5O9bbcmtCEv3DqHxFfSxfy8
 cAte9osZ5Cb+tPTXEBW1+1hwp/fYBbkMNr3ILrebho5TyRviNBdvUAzG7F0wfL1AygtELVIk1kh
 +QEhiKniWcYcqxi4=
X-Received: by 2002:a05:620a:17aa:b0:778:b158:9963 with SMTP id
 ay42-20020a05620a17aa00b00778b1589963mr9683802qkb.13.1700065519653; 
 Wed, 15 Nov 2023 08:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6Rp4kV/WPdUp/JbPVto5rm++pFJz62lUaYEJA9Bl2YWVp5mmZugw309iaB3qB1+p54T8TNA==
X-Received: by 2002:a05:620a:17aa:b0:778:b158:9963 with SMTP id
 ay42-20020a05620a17aa00b00778b1589963mr9683777qkb.13.1700065519400; 
 Wed, 15 Nov 2023 08:25:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ts5-20020a05620a3d8500b00767e98535b7sm3563411qkn.67.2023.11.15.08.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 08:25:18 -0800 (PST)
Message-ID: <98c8fa48-c9f8-4355-92f2-0ca2af3d5dc7@redhat.com>
Date: Wed, 15 Nov 2023 17:25:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/21] vfio/iommufd: Add support for iova_ranges and
 pgsizes
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, jasowang@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-7-zhenzhong.duan@intel.com>
 <fa72e44b-e865-47c3-855f-b947a4e5c1e5@redhat.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <fa72e44b-e865-47c3-855f-b947a4e5c1e5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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



On 11/14/23 14:46, Cédric Le Goater wrote:
> On 11/14/23 11:09, Zhenzhong Duan wrote:
>> Some vIOMMU such as virtio-iommu use IOVA ranges from host side to
>> setup reserved ranges for passthrough device, so that guest will not
>> use an IOVA range beyond host support.
>>
>> Use an uAPI of IOMMUFD to get IOVA ranges of host side and pass to
>> vIOMMU just like the legacy backend, if this fails, fallback to
>> 64bit IOVA range.
>>
>> Also use out_iova_alignment returned from uAPI as pgsizes instead of
>> qemu_real_host_page_size() as a fallback.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>> v6: propagate iommufd_cdev_get_info_iova_range err and print as warning
>>
>>   hw/vfio/iommufd.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 06282d885c..e5bf528e89 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -267,6 +267,53 @@ static int
>> iommufd_cdev_ram_block_discard_disable(bool state)
>>       return ram_block_uncoordinated_discard_disable(state);
>>   }
>>   +static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer
>> *container,
>> +                                            uint32_t ioas_id, Error
>> **errp)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +    struct iommu_ioas_iova_ranges *info;
>> +    struct iommu_iova_range *iova_ranges;
>> +    int ret, sz, fd = container->be->fd;
>> +
>> +    info = g_malloc0(sizeof(*info));
>> +    info->size = sizeof(*info);
>> +    info->ioas_id = ioas_id;
>> +
>> +    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
>> +    if (ret && errno != EMSGSIZE) {
>> +        goto error;
>> +    }
>> +
>> +    sz = info->num_iovas * sizeof(struct iommu_iova_range);
>> +    info = g_realloc(info, sizeof(*info) + sz);
>> +    info->allowed_iovas = (uintptr_t)(info + 1);
>> +
>> +    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
>> +    if (ret) {
>> +        goto error;
>> +    }
>> +
>> +    iova_ranges = (struct iommu_iova_range
>> *)(uintptr_t)info->allowed_iovas;
>> +
>> +    for (int i = 0; i < info->num_iovas; i++) {
>> +        Range *range = g_new(Range, 1);
>> +
>> +        range_set_bounds(range, iova_ranges[i].start,
>> iova_ranges[i].last);
>> +        bcontainer->iova_ranges =
>> +            range_list_insert(bcontainer->iova_ranges, range);
>> +    }
>> +    bcontainer->pgsizes = info->out_iova_alignment;
>> +
>> +    g_free(info);
>> +    return 0;
>> +
>> +error:
>> +    ret = -errno;
>> +    g_free(info);
>> +    error_setg_errno(errp, errno, "Cannot get IOVA ranges");
>> +    return ret;
>> +}
>> +
>>   static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>                                  AddressSpace *as, Error **errp)
>>   {
>> @@ -341,7 +388,13 @@ static int iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>           goto err_discard_disable;
>>       }
>>   -    bcontainer->pgsizes = qemu_real_host_page_size();
>> +    ret = iommufd_cdev_get_info_iova_range(container, ioas_id, &err);
>> +    if (ret) {
>> +        warn_report_err(err);
>> +        err = NULL;
>> +        error_printf("Fallback to default 64bit IOVA range and 4K
>> page size\n");
>
> This would be better :
>
>         error_append_hint(&err,
>                    "Fallback to default 64bit IOVA range and 4K page
> size\n");
>         warn_report_err(err);
>
> I will take care of it if you agree. With that,
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

With Cédric's suggestion,
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
>
> Thanks,
>
> C.
>
>
>> +        bcontainer->pgsizes = qemu_real_host_page_size();
>> +    }
>>         bcontainer->listener = vfio_memory_listener;
>>       memory_listener_register(&bcontainer->listener,
>> bcontainer->space->as);
>


