Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A535C7469F0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 08:47:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGZot-00024s-Qt; Tue, 04 Jul 2023 02:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qGZor-00024i-OW
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 02:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qGZoq-0008OZ-6Z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 02:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688453242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6I5gxZpXZY/B6bK/Nw4NmPQXXA2Sa97CgqhcgGZpe3w=;
 b=C7w4GSlNjEgbrtxXe7voN1Tet8iA7bKlYnHwr3s2d++ZNyNY1hKMI5LQH+GF6Gm4rprqO2
 ztN/Dgo3st2FeU+2tdoc131wcXvTjySU4mymc5pnD4Ty4w2qWGH0SOc7a1UEcSyylZ+lMI
 sQjHU2yjFxhruh7ilp5iW8f7eXidgNE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-5FQBwPmMMNu86rv_I9fr0Q-1; Tue, 04 Jul 2023 02:47:21 -0400
X-MC-Unique: 5FQBwPmMMNu86rv_I9fr0Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62fe5abe808so33948856d6.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 23:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688453241; x=1691045241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6I5gxZpXZY/B6bK/Nw4NmPQXXA2Sa97CgqhcgGZpe3w=;
 b=kTGmRc1Mpcqjh1+EomJQMGnkhM20HI4vnciqPxtgi46r+GvK4Uj4cHHXQy4nF6Wpcf
 eSSG48O6Y6gSb0APm4Xp4625i8oW66+e9nYD8ma7eij2wIH/G9xSJSRDAzdfoXBk2pQb
 6tHkrcU1TKfnhqBqg4lG+Rw6/tTNS9LMjAd4MSKaCrAocWD3lV2luehWM2fo1HnRcZGp
 22TbHf3u3CE5dRBmKPnQn1YrWKr8fLaFt5vC3wsL8oPEE1YktocXUKfYnWFPnb1t/sUe
 wj+Gr2RSYMUh3wr2YbJklxXWKc1C8UIEuMV+otndu6tys4fBt9dfjEJamgEFK5dgfdGu
 PsXA==
X-Gm-Message-State: ABy/qLbYZrR5qK/T+GYlA/+Zzqi5vSfdGQJz3cu2wKoaL1olKIHvdAUI
 hZCwWnrG0vaweeBLUN6ioK2IVfhZ1decDdmG3k3LBY5EKyTRKdBbgtTNo1nYKuy7TNGx0pSF/EH
 Zd6RQl1zYyaG11FQ=
X-Received: by 2002:ad4:5b84:0:b0:636:6646:2e08 with SMTP id
 4-20020ad45b84000000b0063666462e08mr14140976qvp.19.1688453240977; 
 Mon, 03 Jul 2023 23:47:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+IrYBJECkCsImBrzPoRgEHWPGOa73ids3scmuUiQBmuUZnW0/rSGta2zb5IMVoReWTGt+Sg==
X-Received: by 2002:ad4:5b84:0:b0:636:6646:2e08 with SMTP id
 4-20020ad45b84000000b0063666462e08mr14140965qvp.19.1688453240755; 
 Mon, 03 Jul 2023 23:47:20 -0700 (PDT)
Received: from [192.168.100.28] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05620a068800b0076729e726cbsm6216671qkh.22.2023.07.03.23.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 23:47:20 -0700 (PDT)
Message-ID: <3b60a84b-88ab-0d5e-54d3-f47961b1a85d@redhat.com>
Date: Tue, 4 Jul 2023 08:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>, mst@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, eric.auger@redhat.com,
 Peter Xu <peterx@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
 <CAFEAcA_r31PU1LRka36dSJ6vZ2boP33MB=Ns5hDMRrSTN1Lmag@mail.gmail.com>
 <269b9686-f7df-72de-ae6b-242767feccaa@redhat.com>
 <CACGkMEs9L82XyMfnR6ngSio18n=_Baxh1xFtGkNp72eHVtrUeg@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <CACGkMEs9L82XyMfnR6ngSio18n=_Baxh1xFtGkNp72eHVtrUeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi,

as the region is already skipped by the test of the memory region alignment, I'm going to 
update my patches by only removing the error_report() as proposed by Peter.

I will replace it by a trace to help to debug.

Thanks,
Laurent

On 7/4/23 05:07, Jason Wang wrote:
> On Thu, Jun 22, 2023 at 9:39 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> On 6/22/23 15:12, Peter Maydell wrote:
>>> On Tue, 20 Jun 2023 at 20:51, Laurent Vivier <lvivier@redhat.com> wrote:
>>>>
>>>> This memory is not correctly aligned and cannot be registered
>>>> by vDPA and VFIO.
>>>
>>> Isn't this a vDPA/VFIO problem? There's no requirement
>>> for RAM MemoryRegions to be aligned in any way.
> 
> It's more about the limitation of the IOMMU which can't do subpage protection.
> 
>>> Code
>>> that doesn't want to work with small or weirdly aligned
>>> regions should skip them if that's the right behaviour
>>> for that particular code IMHO.
> 
> We had already had this:
> 
>      if ((!memory_region_is_ram(section->mr) &&
>           !memory_region_is_iommu(section->mr)) ||
>          memory_region_is_protected(section->mr) ||
>          /* vhost-vDPA doesn't allow MMIO to be mapped  */
>          memory_region_is_ram_device(section->mr)) {
>          return true;
>      }
> 
>>>
>>
>> Marc-André proposed to modify vDPA code to skip the region but Michal disagreed:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03670.html
>>
>> No one wants the modification, so the problem cannot be fixed.
>>
> 
> Yes, otherwise we end up with explicit check for TPM crb in vhost code...
> 
> Thanks
> 
>> Thanks,
>> Laurent
>>
> 


