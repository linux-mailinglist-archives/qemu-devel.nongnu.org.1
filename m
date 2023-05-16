Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C83704854
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqVF-0008OW-7h; Tue, 16 May 2023 04:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1pyqVC-0008OE-3e
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1pyqVA-0005Ca-Nd
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684227467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxVJvB6F3MhSuuLQRqpf70LLcJe82R3ef35k0ocTSQw=;
 b=UiEMVqO6YAYZwaoXjSLvES1u5iZDKaFIsAtx43nbfgfGdXkkOMrgR4BuvPWTHWLys5k8sD
 LB2eVJXerJKfUR94FJAyQb+PCxPqm0qSTZnXen/Srg7gPhZEYVMNf+wS0DSV5BnlrCdFo9
 paieBrwdws2slJ6eLHVr2CY3q5DiEvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-bh9mNcKLOyGmuOrjdpqWHQ-1; Tue, 16 May 2023 04:57:45 -0400
X-MC-Unique: bh9mNcKLOyGmuOrjdpqWHQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f420742d40so37330485e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 01:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684227464; x=1686819464;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxVJvB6F3MhSuuLQRqpf70LLcJe82R3ef35k0ocTSQw=;
 b=Y4TzKceFUmMdSkzq9k2IlfrVMUvM1mTWIxiszSpAXyTqhyIajMXU9rGGeQuLJBI+bx
 KseuNa3VUCkHN2sZtN1t1K6kBwb5yokz0VzYocBFysaBavmGq+0MCU5PzdUHQI4MlMGU
 TpU3/sFhXL05W6y7iR9E3kefcCmfiupj4zHYpXCFS6Qo7ZDjrae2O7RQCDj8tBcECLqv
 eTHFNsyxUYFA7r/L25GifA3LUoqd6o04nUKh4lkMFyLUz63g+zyVGx7sTp3xKTUjgPkb
 Rc1BFbMR4PUyYH9gHDku0bUGmRNAvbJ5XcoeZZza861eMnOdBCFjSQEHKmYkhvyYrnY+
 4FmQ==
X-Gm-Message-State: AC+VfDzxUDQ6unJWmWFj7lvw9dpjaWJppbU4V+ZMbieK6YcD3ET6n8ec
 QaV6kGU2Fh8I1OzdtzOrKS0os2WS+gZGfYK30TyFv3oAPPAh5Ze/01MI8YZre/6NpNuT8ONMeXo
 4xLPsq/5/mSzqcSA=
X-Received: by 2002:a1c:7205:0:b0:3f5:176:c398 with SMTP id
 n5-20020a1c7205000000b003f50176c398mr6406655wmc.31.1684227464592; 
 Tue, 16 May 2023 01:57:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54gUHC6b05JLOd3uxMtwA2TdaULivcRRpPWnhthdwGy08dwUtzTliKwydUEB/TqsK8HGMwyw==
X-Received: by 2002:a1c:7205:0:b0:3f5:176:c398 with SMTP id
 n5-20020a1c7205000000b003f50176c398mr6406640wmc.31.1684227464259; 
 Tue, 16 May 2023 01:57:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a7bc5d7000000b003f3e50eb606sm1578879wmk.13.2023.05.16.01.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 01:57:43 -0700 (PDT)
Message-ID: <a704c7bf-3e04-e919-03e2-149f82c04a2b@redhat.com>
Date: Tue, 16 May 2023 10:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] vfio/pci: Fix a use-after-free issue
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: minwoo.im@samsung.com, alex.williamson@redhat.com, chao.p.peng@intel.com
References: <20230516034357.61276-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230516034357.61276-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 5/16/23 05:43, Zhenzhong Duan wrote:
> We should free the duplicated variant of vbasedev->name plus uuid
> rather than vbasedev->name itself.
> 
> Fixes: 2dca1b37a7 ("vfio/pci: add support for VF toke")

"toke" -> "token"

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bf27a3990564..d2593681e000 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2998,7 +2998,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       }
>   
>       ret = vfio_get_device(group, name, vbasedev, errp);
> -    g_free(name);
> +    if (name != vbasedev->name) {


yes. I wonder if we shouldn't use the same test with which 'name' was
allocated instead :

     if (!qemu_uuid_is_null(&vdev->vf_token)) {

Thanks,

C.


> +        g_free(name);
> +    }
>       if (ret) {
>           vfio_put_group(group);
>           goto error;


