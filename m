Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253387CF045
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 08:43:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtMk4-0002vz-NU; Thu, 19 Oct 2023 02:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtMk2-0002vb-Td
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtMk1-0005qI-8q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697697763;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1uZ7GStAXKdAAiMe3hD5uYNZ8TQT1tlG0DyY0edQMv0=;
 b=M50X/2J9g7kwedY/NvbKn5Xtus3ziYhCyrmizdSOVe7rjdm2s7N9zhDt/Id1Ve6UjA3bIn
 nQPxY7H2FNGp8wlqElqVYtDKrfY9aMZyIZRgu9Efx+1YMu1kos3s7Vz3H4CAztipJSd0A1
 QcldGQ2kkrzWt+h+7d2UewnuU2dyZHo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-EkmfSlaLMbaSR0RvaveGMA-1; Thu, 19 Oct 2023 02:42:41 -0400
X-MC-Unique: EkmfSlaLMbaSR0RvaveGMA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7789b7087f0so75258185a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 23:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697697457; x=1698302257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1uZ7GStAXKdAAiMe3hD5uYNZ8TQT1tlG0DyY0edQMv0=;
 b=eGRNxT6I3geM4umF0UWNjAC36NgLIynHBK9nhd6aYngB2NK0S2QyQdt7KEhXZJKyz0
 wkOsEqV0TTkEkG/abnAQbX7Z3GCpQfUTlVl3wnE6saoduJ1Dy+SzRVQvVWiyFjeNRk5n
 +GutBqEFVjMv7LEBvXmZmc8H81ugZji9lY7vQt/CiYhVy5DkuVqPu85GJYpAJ8dr3/9E
 CUteFtw5XGbBkTndm1sv0GEgV1qDs2rPzbqmpvkHQaxYedmAgvgf+0fbx4zT/EzRLYty
 87+SV3zE26BZ6nIZVcwOnnIHWFZR1p7pRJ42aYqvbSshd+Z3qIsazcri2OP+mAVcI+gD
 OdtA==
X-Gm-Message-State: AOJu0YxMx2U61E1s1zJPWVW0H7qwQNQQOlOOnMUj5xIUqWvnm5+uTBJh
 Qy6cwTzp+Ns3cjWqtnwv4FvCrYt5M9m1bYcbVRumgEQmv/bVRMan+IGhKoEsMyiKNwFxTY9dY/t
 SAfHh6BDKXrm7TJE=
X-Received: by 2002:a0c:aa5c:0:b0:66d:55da:191d with SMTP id
 e28-20020a0caa5c000000b0066d55da191dmr909384qvb.37.1697697457197; 
 Wed, 18 Oct 2023 23:37:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcH9Rhdj2Uyn+qH3/Rc5m9ib2AWv8J2wFB+CwVc0L/vwnuu04BNEauOofY36Gw4BPsGptycg==
X-Received: by 2002:a0c:aa5c:0:b0:66d:55da:191d with SMTP id
 e28-20020a0caa5c000000b0066d55da191dmr909368qvb.37.1697697456893; 
 Wed, 18 Oct 2023 23:37:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 qh30-20020a0562144c1e00b0066d05ed3778sm570773qvb.56.2023.10.18.23.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 23:37:35 -0700 (PDT)
Message-ID: <a5739942-1692-7249-038c-175ee5b8ea03@redhat.com>
Date: Thu, 19 Oct 2023 08:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 13/13] vfio: Remove 64-bit IOVA address space assumption
To: Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com
References: <20231011175516.541374-1-eric.auger@redhat.com>
 <20231011175516.541374-14-eric.auger@redhat.com>
 <20231018154234.4c47801d.alex.williamson@redhat.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231018154234.4c47801d.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Alex,

On 10/18/23 23:42, Alex Williamson wrote:
> On Wed, 11 Oct 2023 19:52:29 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Now we retrieve the usable IOVA ranges from the host,
>> we now the physical IOMMU aperture and we can remove
> s/now/use/?
>
>> the assumption of 64b IOVA space when calling
>> vfio_host_win_add().
>>
>> This works fine in general but in case of an IOMMU memory
>> region this becomes more tricky. For instance the virtio-iommu
>> MR has a 64b aperture by default. If the physical IOMMU has a
>> smaller aperture (typically the case for VTD), this means we
>> would need to resize the IOMMU MR when this latter is linked
>> to a container. However this happens on vfio_listener_region_add()
>> when calling the IOMMU MR set_iova_ranges() callback and this
>> would mean we would have a recursive call the
>> vfio_listener_region_add(). This looks like a wrong usage of
>> he memory API causing duplicate IOMMU MR notifier registration
> s/he/the/
>
>> for instance.
>>
>> Until we find a better solution, make sure the vfio_find_hostwin()
>> is not called anymore for IOMMU region.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v2 -> v3:
>> - take into account the avail IOVA range may not be existing
>> - Create as many VFIOHostDMAWindow as valid IOVA ranges
>> - rebase on top of vfio-next
>>
>> I have not found any working solution to the IOMMU MR resizing.
>> So I can remove this patch or remove the check for IOMMU MR. Maybe
>> this is an issue which can be handled separately?
> Am I correct that the only thing we're solving here is the FIXME?
>
> Without this change we assume a 64-bit IOVA address space for the
> "hostwin" and the previous patch 03/ already sets the usable IOVA range
> for the IOMMU aperture.  Kernel code will error on mappings outside of
> the usable IOVA ranges regardless, so at best we're making the failure
> occur earlier in QEMU rather than at the time of the DMA mapping.
yes that's what the patch aims at
>
> I think the FIXME comment had assumed the hostwin support would be more
> universal, but perhaps we're just doubling down on a relic of SPAPR
> support that we can safely ignore, and at some point remove.  It really
> seems to serve the same purpose as the new iova_ranges and if it were
> worthwhile to fail the range in QEMU before trying to map it in the
> kernel, we could test it against iova_ranges directly.
>
> Unless this serves some purpose that I'm not spotting, maybe we should
> drop this patch, consider hostwin to be SPAPR specific, and avoid
> further entanglements with it here so that it can be more easily
> removed.  Thanks,
I am fine dropping the patch esp because I failed at resizing the IOMMU
MR on-the-fly and was forced to move vfio_find_hostwin().

Thank you for the review.

Eric
>
> Alex
>
>> ---
>>  hw/vfio/common.c    | 14 +++++++-------
>>  hw/vfio/container.c | 23 +++++++++++++++++------
>>  2 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 9d804152ba..1447b6fdc4 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -654,13 +654,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>          goto fail;
>>      }
>>  
>> -    hostwin = vfio_find_hostwin(container, iova, end);
>> -    if (!hostwin) {
>> -        error_setg(&err, "Container %p can't map guest IOVA region"
>> -                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
>> -        goto fail;
>> -    }
>> -
>>      memory_region_ref(section->mr);
>>  
>>      if (memory_region_is_iommu(section->mr)) {
>> @@ -720,6 +713,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>          return;
>>      }
>>  
>> +    hostwin = vfio_find_hostwin(container, iova, end);
>> +    if (!hostwin) {
>> +        error_setg(&err, "Container %p can't map guest IOVA region"
>> +                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
>> +        goto fail;
>> +    }
>> +
>>      /* Here we assume that memory_region_is_ram(section->mr)==true */
>>  
>>      /*
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 5122ff6d92..eb9d962881 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -693,12 +693,23 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>          vfio_get_iommu_info_migration(container, info);
>>          g_free(info);
>>  
>> -        /*
>> -         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
>> -         * information to get the actual window extent rather than assume
>> -         * a 64-bit IOVA address space.
>> -         */
>> -        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
>> +        if (container->nr_iovas == -1) {
>> +            /*
>> +             * no available info on usable IOVA ranges,
>> +             * assume 64b IOVA space
>> +             */
>> +            vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
>> +        } else {
>> +            GList *l;
>> +
>> +            g_assert(container->nr_iovas);
>> +            for (l = container->iova_ranges; l; l = l->next) {
>> +                Range *r = l->data;
>> +
>> +                vfio_host_win_add(container, range_lob(r), range_upb(r),
>> +                                  container->pgsizes);
>> +            }
>> +        }
>>  
>>          break;
>>      }


