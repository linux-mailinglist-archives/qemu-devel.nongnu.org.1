Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7A27EDBED
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:26:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Wke-000421-KI; Thu, 16 Nov 2023 02:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3Wkc-000408-DR
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3Wka-0002Vx-R9
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700119519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+X4+Y7ven5wU/5EqEhEF95P7HvWK3AA2UzdDlEdo88=;
 b=GvqRt4TPVXB1IDfFT0s5yAhPfVBz1JL2fvOvGbR3JCFUPlG/5V+0MSY4rdWAGOnZgDTqta
 /LG50wvuy4XH5RtObmf813erz016ZH7LbTUqwPrXaJKGehGfcGdAc9vKOtfpbVnBGRUbTB
 UReb1eB5SpntvFYFwQJ6P/pXDq1pxg8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-uKKujd4hNum2axCIpeonPQ-1; Thu, 16 Nov 2023 02:25:16 -0500
X-MC-Unique: uKKujd4hNum2axCIpeonPQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-670b32845a7so5769406d6.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700119516; x=1700724316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C+X4+Y7ven5wU/5EqEhEF95P7HvWK3AA2UzdDlEdo88=;
 b=MAUnAaXlqNMNKZa0a8qut/MU42sP2jnpxtZenl+dJFTj6A3l9sLVvmzpQ5xxbTVjRm
 p0zRTMQI5X4tjQYyXxHBtmNTMOX6i9DrKWOjR2AJOYAegf2M8JV0nYJUC+J5Sm0Uog/o
 nsTuYD8FFCo5fQaOADo7hQKEDjMDKOxcd23PsMt+H9umOXUMeX2DgU6wGJnR2mkS1kZq
 s7HjCgSNtLPmv0NhGuyEvNXM9urJxGBEqXeJEGjLNIrBI0wWFuI+hhs7cS5q83lyNUjl
 RKEcKSE0gA0G3DQO+pAexFSIFdgMeJtZBH5/rjodtBjG7gY7zAdldiDV4O9N1VhVUV6D
 d18A==
X-Gm-Message-State: AOJu0YwEZIDF1EM5QGr6mTW9eH/YdaHSLkwR+UZH1IqMjwxMwAodxiyW
 bDEfW41GsLypp3MXaYChdncQ4SBqa3OxuSpa28ScFST1dNXULVRf2lHnb+m0LzutG/hg2+AGwq/
 wgz+rqc92S5gcFEY=
X-Received: by 2002:a05:6214:27ed:b0:66d:6544:8eae with SMTP id
 jt13-20020a05621427ed00b0066d65448eaemr8677365qvb.34.1700119515877; 
 Wed, 15 Nov 2023 23:25:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuXqArMsEwsweJm+X6UC/mXqAZGkduZPCUPSxzhVgiaARU9UE3let+XfjVN9UERepfd5WOCQ==
X-Received: by 2002:a05:6214:27ed:b0:66d:6544:8eae with SMTP id
 jt13-20020a05621427ed00b0066d65448eaemr8677345qvb.34.1700119515582; 
 Wed, 15 Nov 2023 23:25:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a056214070300b0065cfec43097sm1171413qvz.39.2023.11.15.23.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:25:15 -0800 (PST)
Message-ID: <8d2c39d1-3918-46a7-91bd-db6ec22c7384@redhat.com>
Date: Thu, 16 Nov 2023 08:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-12-zhenzhong.duan@intel.com>
 <b6c6f336-8f56-415a-b6a7-fce19dfd2241@linaro.org>
 <de1bb7bf-64ee-4378-b757-eca7f547b674@redhat.com>
 <SJ0PR11MB67444C431A56866888D1621A92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67444C431A56866888D1621A92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

>>> Please add bare documentation:
>>>
>>>     /* Returns 0 on success, or a negative errno. */
>>>
>>>> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> 
> Will do, I'd like to wait a few days to collect more suggested changes and RB,
> Then send all these updates to Cédric in once before he pushes this series to vfio-next.

Yep. Could you respin a v7 with all the comments on v6 ? I will
then apply directly on vfio-next.

Please wait for Eric to finish looking at the platform part.

Thanks,

C.



