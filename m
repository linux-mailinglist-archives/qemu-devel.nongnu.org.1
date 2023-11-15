Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC57EC3A0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:29:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3FwJ-0001fl-Ca; Wed, 15 Nov 2023 08:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3FwF-0001fP-F9
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:28:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3FwE-0005Xt-1f
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700054892;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+YHwUeco2/iCeeYoD3Z004kOu+tAlUIPnVt/EHtbnQ=;
 b=KP7Gr2mJTb9DBCwFrw1/3PA9keOxzkIFm89iTHP/FFCPeLa+o5gcWoQqCNZvZrDRYshkZy
 ffucqb94uRo+qDYOsrmdK5OCCgkCkz+pTON+uTxtDcGX8i5/wWGEx9uEd6pAr8PgdO5fty
 K2BCo2CmN3pnUVeT8AVcruqUE162hmA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-yB4BVUfXN2eXY5vquk4fqQ-1; Wed, 15 Nov 2023 08:28:06 -0500
X-MC-Unique: yB4BVUfXN2eXY5vquk4fqQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67445c67d5dso78783096d6.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 05:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054885; x=1700659685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+YHwUeco2/iCeeYoD3Z004kOu+tAlUIPnVt/EHtbnQ=;
 b=NG+rjhoV+ExsO+aoMSj8on8fRd40xCd123y92qg5mgHRIvYFuX7Wzs6XF4f6fFhys5
 Pk3ZvKkYLqwGP5qwe8n5B9rI0oTC54QaORk78Psj25c36LjHDNEIJ+TaTSjafqcN7cwn
 V0vWeusuapGPoLC7pjPVFieK/t8udpceR6iIn8rbj/NtyC9QozdM/8CcOaBm2M6kURJ+
 i4Gkq28vvMyzd7YuiNp3s4HqK2Q8lHCeqt4QW7aWNv0sSCa/FDJ/Hg59433fwLyjM1Ah
 TPY6hJ8dwvBCgrQhDMzXiKdoeOqjf1ywfQk7EIOhgPyeRogkPZZ/mxlPTPFFYV5vQB27
 dlHA==
X-Gm-Message-State: AOJu0YwxxjyBk56QULS0a7I82Lg/Aa5PJCA3rGX5maTqLKaIhDUBP3xy
 Whn55Itwt6b0nNi2n2Fsi1Y6V32lw2J1m0cwh1JDcSCKZaH3OaaHswNw1ZvyZiEWCRiVQbra3xP
 1BzMMc+HaPF/D50s=
X-Received: by 2002:a0c:cd88:0:b0:671:e02a:8bf6 with SMTP id
 v8-20020a0ccd88000000b00671e02a8bf6mr5788948qvm.34.1700054885732; 
 Wed, 15 Nov 2023 05:28:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb02zX4j68sAh2cO27n18g6mjx50EAEIih13/4+lXSIhLFUpkBkZHAvOtfMhsqtJHTqm6Z2w==
X-Received: by 2002:a0c:cd88:0:b0:671:e02a:8bf6 with SMTP id
 v8-20020a0ccd88000000b00671e02a8bf6mr5788931qvm.34.1700054885485; 
 Wed, 15 Nov 2023 05:28:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a0cd685000000b0065b0771f2edsm530406qvi.136.2023.11.15.05.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 05:28:04 -0800 (PST)
Message-ID: <94e860f6-b50e-4ef3-82f3-e2b3fd59a3d3@redhat.com>
Date: Wed, 15 Nov 2023 14:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/21] vfio/common: return early if space isn't empty
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 11/14/23 11:09, Zhenzhong Duan wrote:
> This is a trivial optimization. If there is active container in space,
> vfio_reset_handler will never be unregistered. So revert the check of
> space->containers and return early.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/vfio/common.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 572ae7c934..934f4f5446 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1462,10 +1462,13 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
>  
>  void vfio_put_address_space(VFIOAddressSpace *space)
>  {
> -    if (QLIST_EMPTY(&space->containers)) {
> -        QLIST_REMOVE(space, list);
> -        g_free(space);
> +    if (!QLIST_EMPTY(&space->containers)) {
> +        return;
>      }
> +
> +    QLIST_REMOVE(space, list);
> +    g_free(space);
> +
>      if (QLIST_EMPTY(&vfio_address_spaces)) {
>          qemu_unregister_reset(vfio_reset_handler, NULL);
>      }


