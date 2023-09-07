Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE760797262
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEJg-0004Zp-8Q; Thu, 07 Sep 2023 08:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeEJd-0004Zh-V2
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeEJb-0003ps-Rq
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694090455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7DAaSeselIc75gQlIz3AQok6TfyUaK0nPzNSsHRma1k=;
 b=QTW8gj2mRBeCb4Vb+crytHyH0Z3wWjSjHjSIG/F7wzm9uWle+BnNRw7Bo6L+b8PnjY9p/L
 ErbeyiZFyFfQ+V5E65jHP1hnVRHLzsw2DZdVc3KDlU4RXTFEICn6UQ7QuPzvPpc05b3yY/
 W/HXIXuKxCfnT/ITxhAatUQBaDFITP4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-5H1tVxOFNKCmRDebQOPt0Q-1; Thu, 07 Sep 2023 08:40:53 -0400
X-MC-Unique: 5H1tVxOFNKCmRDebQOPt0Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402ccac9b1eso6445705e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694090452; x=1694695252;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7DAaSeselIc75gQlIz3AQok6TfyUaK0nPzNSsHRma1k=;
 b=jqLg82mlQyGq26B/ivmGbYtbiJ/51hZ9zL54MmasMjgs4r4EB6x6y3OXTNqNe7Cqdt
 jRHpAPOB7V9RBqyGfQFEBq9OEr2zkiIJKCmZQS17csR8g0+e/W6g3MEMoYZEUwUJdj+4
 Ml7w5GDvdZeJJ47L4jFf++i8xuz2vLJeilVoy8Su7mBPZCIDRMnv16RvYotGi4fqNzHl
 2Y4QO//eTSShiCPsadMzuDNVB0W/hrcO3vK/8+3miqIj1Ws2x0EwEzDsSyvYsleH4JZH
 wiRQ8jW2vQaIKVF4BaBGdibf53Q6+uh8eC8UT0z1RcSYTLagk3GyRdH+7/O3+DGiCUUA
 k+Tg==
X-Gm-Message-State: AOJu0YwD2QvnK7JMVHk2kE2Umjlhfm8LejYfTz0P7GOpgfpr/l3sTeV7
 RMmGIBUY679L1XYHrMW7Je8al4svDXLezkwPkd03dUJqgKbhLLwUClVz6SWokAua18vPN7ZnsEY
 2h8aqWyDtRbcszww=
X-Received: by 2002:a05:600c:24c:b0:3fe:fc0f:52e2 with SMTP id
 12-20020a05600c024c00b003fefc0f52e2mr4303313wmj.37.1694090452797; 
 Thu, 07 Sep 2023 05:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVMhxa96kw1zclLUxwTn95gSB5qSIMC25XGBmQ9D761oCI5ceD7h2y2Bng7Hg377zxAsMLsg==
X-Received: by 2002:a05:600c:24c:b0:3fe:fc0f:52e2 with SMTP id
 12-20020a05600c024c00b003fefc0f52e2mr4303289wmj.37.1694090452449; 
 Thu, 07 Sep 2023 05:40:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a7bcd99000000b0040210a27e29sm2406987wmj.32.2023.09.07.05.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 05:40:51 -0700 (PDT)
Message-ID: <d5d30f58-31f0-1103-6956-377de34a790c@redhat.com>
Date: Thu, 7 Sep 2023 14:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, qemu-devel@nongnu.org,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <48540cac-769f-c092-a98e-e6d8ff632559@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <48540cac-769f-c092-a98e-e6d8ff632559@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hello Joao,

> Cedric, you mentioned that you take a look at this after you come back, not sure
> if that's still the plan. But it's been a while since the last version, so would
> you have me repost/rebase on the latest (post your PR)?

Yes please. That's next on the TODO list (after some downstream work
regarding the postcopy crash). My rough plan for 8.2 is :

  * P2P
  * VIOMMU
  * dynamic MSI-X
  * fixes

I think it is a bit early for iommufd and I will probably lack time.
The recent migration addition is requiring some attention in many
areas.

> Additionally, I should say that I have an alternative (as a single small patch),
> where vIOMMU usage is allowed ... but behind a VFIO command line option, and as
> soon as attempt *any* vIOMMU mapping we fail-to-start/block the migration. I
> haven't posted that alternative as early in the dirty tracking work the idea was
> to avoid guest vIOMMU usage dependency to allow migration (which made this
> patchset the way it is). But thought it was OK to remind, if it was only be
> allowed if the admin explicitly states such its intent behind a x- command line
> option.

I don't remember seeing it. It is worth resending as an RFC so that
people can comment.

Thanks,

C.




