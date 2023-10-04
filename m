Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AFD7B7C8C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyRp-00087L-Nd; Wed, 04 Oct 2023 05:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnyRj-00081m-1B
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnyRe-0007dt-34
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696412716;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1P9Rw6j8myufL84z9TViQ0y87k6NBofEvaPnlhzyteo=;
 b=dQrAb9wgfG/heiCt2Gc47WYnNKo10NQMVilHfdYk4ghSb1VgSkKsmDBylTmzBkTjJpNcor
 xIYmYotH/HPCtQwBbX0+tEOkGXpCf9hCj17/EzWIKJtB5QhWshwj+lkYyXGZBJ5KGlWRkj
 DaijFNPkVVinprT/J1mEonQioHmsxYo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-0BSZvFlyNtKDfYI1eAESVg-1; Wed, 04 Oct 2023 05:45:05 -0400
X-MC-Unique: 0BSZvFlyNtKDfYI1eAESVg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41957273209so21280031cf.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696412704; x=1697017504;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1P9Rw6j8myufL84z9TViQ0y87k6NBofEvaPnlhzyteo=;
 b=IUk9OCqUDdgvWX6BMpkhVsuPTazqL49rUKFrjL/AwTwmyF9yHKGsEq32dl51ttR9Pn
 I4ZhyRDh23bsdaImGk0/W2Q9iKr7Rhq59eFWaduIfjex9LLAKt+xCR+J9+VA1CYEIKrb
 JO46dGkR5DaZelcCEHHpXuj2df1lBDdr9olNbctGLVplhDSBMsgp3eDcoBZdWd7qFtCx
 fnnfr/Fmedv3+OGVAY1oM/yw4kYONiDmYp4CVZiFxiTxlnpcG9h66GAmnfGcTCaUTQNG
 YUgkkZNCNjYKaryTOSgUn1gZu7nkbJoh1TSkgXmGlGD+AHQ2lVJSwS/DmnUjNx7ItkTr
 yjFw==
X-Gm-Message-State: AOJu0YxKPRVbsiY43pr0hiB7rL5waRIyVhT0dw9eYUHnOIq4oT8mA7Am
 O7UnRgBBdjLEhDjxCbo/W07AGw6z+SW7HYr0Apkrbqvps/kQNZQWKLTJyTxPZ5jij1h4DdhnePz
 VcXW5VMqaPv1VSn4=
X-Received: by 2002:a05:622a:13ca:b0:418:152d:bf6 with SMTP id
 p10-20020a05622a13ca00b00418152d0bf6mr2033866qtk.26.1696412704635; 
 Wed, 04 Oct 2023 02:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcC+CH9/LXu77Qo+l2zaeeHrhjdJk89atQtyPyex/HhVLuAhICOlLnb25YfR0SJiqSt8jk8Q==
X-Received: by 2002:a05:622a:13ca:b0:418:152d:bf6 with SMTP id
 p10-20020a05622a13ca00b00418152d0bf6mr2033850qtk.26.1696412704347; 
 Wed, 04 Oct 2023 02:45:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 kq18-20020ac86192000000b00407906a4c6fsm1095462qtb.71.2023.10.04.02.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 02:45:03 -0700 (PDT)
Message-ID: <9a9533d1-87cf-810d-426a-3dc8f6648e2b@redhat.com>
Date: Wed, 4 Oct 2023 11:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/15] vfio/common: Propagate KVM_SET_DEVICE_ATTR error
 if any
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-5-eric.auger@redhat.com>
 <302f7b27-b367-d64c-a860-49e41192ac9f@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <302f7b27-b367-d64c-a860-49e41192ac9f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cédric,

On 10/3/23 16:53, Cédric Le Goater wrote:
> On 10/3/23 12:14, Eric Auger wrote:
>> In the VFIO_SPAPR_TCE_v2_IOMMU container case, when
>> KVM_SET_DEVICE_ATTR fails, we currently don't propagate the
>> error as we do on the vfio_spapr_create_window() failure
>> case. Let's align the code. Take the opportunity to
>> reword the error message and make it more explicit.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> I think thise should end up in the
>>      if (!container->initialized) {
>>          if (!container->error) {
>> path and call the error_propagate_prepend()
>
> We could have this case also
>
>     if (memory_region_is_ram_device(section->mr)) {
>         error_report("failed to vfio_dma_map. pci p2p may not work");
>         return;
>     }
>
> which was added by commit 567b5b309abe ("vfio/pci: Relax DMA map errors
> for MMIO regions"). There were a few changes in the failure path, like
> commit ac6dc3894fbb ("vfio: Generalize vfio_listener_region_add failure
> path") and it is unclear to me which one will be used. Anyhow, this needs
> some cleanup and this is what this patchset is proposing. Let's move on :
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

yep the original error_report() looks strange in that context,
especially without comment. Let's hope the lack of propagation was not
done on purpose. I will add the original committer to the cc list.

Eric
>
> Thanks,
>
> C.
>
>
>> ---
>>   hw/vfio/common.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 4e122fc4e4..c54a72ec80 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -878,11 +878,11 @@ static void
>> vfio_listener_region_add(MemoryListener *listener,
>>                   QLIST_FOREACH(group, &container->group_list,
>> container_next) {
>>                       param.groupfd = group->fd;
>>                       if (ioctl(vfio_kvm_device_fd,
>> KVM_SET_DEVICE_ATTR, &attr)) {
>> -                        error_report("vfio: failed to setup fd %d "
>> -                                     "for a group with fd %d: %s",
>> -                                     param.tablefd, param.groupfd,
>> -                                     strerror(errno));
>> -                        return;
>> +                        error_setg_errno(&err, errno,
>> +                                         "vfio: failed
>> GROUP_SET_SPAPR_TCE for "
>> +                                         "KVM VFIO device %d and
>> group fd %d",
>> +                                         param.tablefd, param.groupfd);
>> +                        goto fail;
>>                       }
>>                       trace_vfio_spapr_group_attach(param.groupfd,
>> param.tablefd);
>>                   }
>


