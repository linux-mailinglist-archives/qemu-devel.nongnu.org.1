Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333C7F196B
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:10:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r57lS-0004Oq-Pz; Mon, 20 Nov 2023 12:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r57lQ-0004Of-5U
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r57lM-0001Ls-5e
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700500122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEskolRhNapQdSMGndwweZjQS1gVb/KkUsTbIX/ZrYE=;
 b=RfXwagwCz+r39KUKG46tgs9+4ORyt/GTRwWQEAICfo/9E85ui9jKU1/K/sLtEXU5i3uo7s
 IjIEB9NzHasFkm0YiUXiGuK/W5I1AwijOmw2DI0ZnPju1fnVgfFZzrXD1YMSaLGgSk1tjz
 6uuxsHHonPe/JEjSuHXw9lKsRRCWtxI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-WbHVmj_kM2KKKjI0o1iSiQ-1; Mon, 20 Nov 2023 12:08:41 -0500
X-MC-Unique: WbHVmj_kM2KKKjI0o1iSiQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-679ceb85c6cso27645636d6.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700500121; x=1701104921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lEskolRhNapQdSMGndwweZjQS1gVb/KkUsTbIX/ZrYE=;
 b=WeqyBcZYsJUcl2nTQ0SJApAQUeqQhd7L93K12g2Wck68c7YCGvCYgyeRyHqUjhxeh6
 geCjxyG9E/m9WPWyb5AYDILOiR/5HL4W2TaAU9dsgtJRtaeYiufxddYTxahMCPAbZVFO
 OdZzNXdHjK4LO8RUm8WjUsBwL+OV5KP/WMwKM2IcAWlOUX2gB7wiwvPPZPQgwtR7m+n+
 pUdNDwFznIpZRmNW+DpcAnEmOtysbnEouPhhh/+v3CmIqg4aeJHS4iWo6V43H+auTLLj
 8HZ+JNqcXc19oWbrSsPWg+zF+xAlSfFvOXFAwidUoY8AwN8SL2Vg+oR9SRAznf54YxbD
 uXfw==
X-Gm-Message-State: AOJu0YyXW4H3/qRpeLamqA4usaFVgw+EQVUAWQ953yI1pBspxYurAOG2
 yInziyvbmTcZtbiv+D6b1RFc/3DrGJ29XUkXbbTCN79di5F6nQvU4B8Io8XWYTdLs8PdvDpPApV
 IpoPKnxx30IJO7ik=
X-Received: by 2002:a05:6214:2122:b0:66d:2852:6f17 with SMTP id
 r2-20020a056214212200b0066d28526f17mr12518018qvc.14.1700500120796; 
 Mon, 20 Nov 2023 09:08:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBBTLtn9Or5xanqp5ISvPgzQ+pVQRVUjk1osqpzZnOT2kIjbBz0uGJZDAgUGNDbbKcVE0shg==
X-Received: by 2002:a05:6214:2122:b0:66d:2852:6f17 with SMTP id
 r2-20020a056214212200b0066d28526f17mr12517983qvc.14.1700500120491; 
 Mon, 20 Nov 2023 09:08:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q7-20020ad44027000000b00670a8921170sm3059465qvp.112.2023.11.20.09.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 09:08:40 -0800 (PST)
Message-ID: <395120c5-06d0-4421-a9b8-20bd79bf3f5c@redhat.com>
Date: Mon, 20 Nov 2023 18:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
 <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
 <SJ0PR11MB67444672699A62007207FB3492B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ebc65641-4597-4679-8214-0f4555f9bd21@redhat.com>
 <SJ0PR11MB674445FEAD689AF8B5A8A42B92B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674445FEAD689AF8B5A8A42B92B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hello Zhenzhong

On 11/20/23 11:07, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Monday, November 20, 2023 4:25 PM
>> Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
>>
>>>>>> A similar issue with a fix submitted below, ccing related people.
>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg02937.html
>>>>>> It looks the fix will not work for hotplug.
>>>>>>
>>>>>> Or below qemu cmdline may help:
>>>>>> "-cpu host,host-phys-bits-limit=39"
>>>>>
>>>>> don't you have the same issue with legacy VFIO code, you should?
>>>>
>>>> I tend to be lazy and use seabios for guests on the command line.
>>>> I do see the error with legacy VFIO and uefi.
>>>>
>>>> However, with the address space size work-around and iommufd, the
>>>> error is different, an EFAULT now. Some page pinning issue it seems.
>>>
>>> Yes, this reminds me of iommufd not supporting p2p mapping yet.
>>
>> OK. Should we transform this error in a warning ? The code needs
>> at least a comment.
> 
> Make sense, though I'm not clear if there is other corner case return EFAULT.

yep. That's the problem.

> I plan below change in v7:
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 53fdac4cc0..ba58a0eb0d 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -178,7 +178,13 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                                     vaddr, readonly, ret);
>       if (ret) {
>           ret = -errno;
> -        error_report("IOMMU_IOAS_MAP failed: %m");
> +
> +        /* TODO: Not support mapping hardware PCI BAR region for now. */
> +        if (errno == EFAULT) {
> +            warn_report("IOMMU_IOAS_MAP failed: %m, PCI BAR?");
> +        } else {
> +            error_report("IOMMU_IOAS_MAP failed: %m");
> +        }
>       }
>       return ret;
>   }
> 
> I failed to change vfio_container_dma_map print as warning because for legacy container, it's real errro.
> So print after fix:
> 
> qemu-system-x86_64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
> qemu-system-x86_64: vfio_container_dma_map(0x560cb6cb1620, 0xe000000021000, 0x3000, 0x7f32ed55c000) = -14 (Bad address)

I am OK with that. Let's see what the others have to say.

>>
>>> So EFAULT is expected. Maybe I should add a comment in docs/devel/vfio-
>> iommufd.rst
>>
>> Yes. It would be good to have a list of gaps and effects in the
>> documentation. See Jason's presentation at LPC.
>>
>>
>> https://lpc.events/event/17/contributions/1418/attachments/1297/2607/LPC202
>> 3_iommufd.pdf
> 
> I see, PCI Peer to Peer and POWER/SPAPR are related to qemu iommufd implementation.
> For POWER/SPAPR, we have "Supported platform" section.

yes.

> Below are other gaps I can think of for now:
> 
> Gaps:
> 1. dirty page sync, WIP (Joao)
> 2. p2p dma not supported yet.
> 3. fd passing with mdev not support ram discard(vfio-pci) as no way to know it's a mdev from a fd.

Call the section Caveats maybe?


Thanks,

C.


