Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F37277DBB2E
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:58:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSla-0006Kx-Gf; Mon, 30 Oct 2023 09:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxSlL-0006KK-2N
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxSlI-0001gy-RZ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698674219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7dK96yvJYM3Px077tQuoB/2lfJ1tcvDerMRPLXsHU8=;
 b=VkZXkiTJRaEwD8Ghw2BfHAaGPXPYRDWlFU+fPFGZ9ma+s9xvdlZDRCCqtkKt4beG2hrE5h
 PShGovXElS5MFS9ihxtBEbUYUqintLIjGak8hqAC6ekh/MZWeCIdjhVufTGpUqfU81bfcS
 nW3PzlZyd0MQqwKQqp35s4SNQvpi1M0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-JTxoCe43MTuwaBBOM5eFGQ-1; Mon, 30 Oct 2023 09:56:48 -0400
X-MC-Unique: JTxoCe43MTuwaBBOM5eFGQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5a9012ab0adso45990887b3.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 06:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698674207; x=1699279007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7dK96yvJYM3Px077tQuoB/2lfJ1tcvDerMRPLXsHU8=;
 b=P+AL71V6JfbVN6qM9DidYTkaRrnUDluE1rhL04FPl1pG3kbMMT1KrrcFqNSH086nPX
 fiR+T9Rs/iG/QzDf83oiuBHFyCwbm8zyvPouHCNG/uYOjFlVBJsUE9tE2Ycfc+ePq4qq
 voSgjicotc9ARH3EW9qFplAott0l5hoor6FFbgN7EXWVgIxVkgCwVLXYIkLP8O1MWAqZ
 7vYTnZQY3PmYon8NK5M2fcka12+w25TQqLSAPl0+DKbiMW7PRj90Rm8K42d3Va6sMaqe
 kJc2hmTxuFmkLuT2kKC43YBW6hG2+1sVNfhC6qXoQvUkqRSMpM2eRtjVNPVzqV8HstgU
 YGbg==
X-Gm-Message-State: AOJu0YwND/Mhrnd2upcZ9t+yS0VoxcUg4VEKbmgvfscib3DiDvgVfKqL
 CzQtcBjyrPdQ8qzbQIPzsmYDOM6fxKTBZugyUpAip4dQtcWvhSnoGJhCg4osTM6bJ3JnuJz9TJY
 S39jShLoKVrj9sUw=
X-Received: by 2002:a81:a906:0:b0:5a8:e303:1db2 with SMTP id
 g6-20020a81a906000000b005a8e3031db2mr9273437ywh.23.1698674207657; 
 Mon, 30 Oct 2023 06:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm9SAaWX+wgMBjiwjSe+0KPBduAPO7ugKXB+MacJG+mENf0X7rBTt5tWtjRrzW7ZGKwhs8MQ==
X-Received: by 2002:a81:a906:0:b0:5a8:e303:1db2 with SMTP id
 g6-20020a81a906000000b005a8e3031db2mr9273415ywh.23.1698674207437; 
 Mon, 30 Oct 2023 06:56:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 f30-20020ad4559e000000b0065b1f90ff8csm3450350qvx.40.2023.10.30.06.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 06:56:47 -0700 (PDT)
Message-ID: <9e5a2eaf-4703-4797-8305-05baee9d7de4@redhat.com>
Date: Mon, 30 Oct 2023 14:56:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/37] vfio/iommufd: Bypass EEH if iommufd backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-30-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-30-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/26/23 12:30, Zhenzhong Duan wrote:
> IBM EEH is only supported by legacy backend currently, bypass it
> for IOMMUFD backend.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/ppc/spapr_pci_vfio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index d1d07bec46..a2518838a1 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -93,10 +93,10 @@ static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
>   
>       bcontainer = QLIST_FIRST(&space->containers);
>   
> -    if (QLIST_NEXT(bcontainer, next)) {
> +    if (QLIST_NEXT(bcontainer, next) || bcontainer->ops != &vfio_legacy_ops) {

It's curious that a test on the VFIOIOMMUOps is needed so deep in
the software stack, and spapr should have its own VFIOIOMMUOps, which
de facto doesn't support iommufd.

Thanks,

C.


>           /*
>            * We don't yet have logic to synchronize EEH state across
> -         * multiple containers
> +         * multiple containers, iommufd isn't supported too.
>            */
>           bcontainer = NULL;
>           goto out;


