Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F27E79CE
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 08:41:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1M8J-00067w-AX; Fri, 10 Nov 2023 02:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1M8G-00064P-Gh
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1M8E-0000YW-Hk
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699602044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sXfm4rueFMNKFqpoFKpfY8pu+Y/4svbiOzl/odyLQQ=;
 b=PtCCm19mpYSSVtg4jFbWPoCO7B8S8ywk5mhc9ZcxcNJakdFB/6kOVmMLfLI+KeTz9GKUHT
 2u20sivA+IeutpfdMtHfyJ18YodN2Wy6SVTnmi5tBeToAC/+8jIPnVp5K6kWmreUaRotpC
 0OymKLoV93bLHMBovA/4n3+oQGVynrA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-3K0qDbFiPUqTbKNnPJEk-g-1; Fri, 10 Nov 2023 02:40:42 -0500
X-MC-Unique: 3K0qDbFiPUqTbKNnPJEk-g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d0b251a6aso19908176d6.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 23:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699602042; x=1700206842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1sXfm4rueFMNKFqpoFKpfY8pu+Y/4svbiOzl/odyLQQ=;
 b=J5eZfjvzGfoc5KVBTygj0q80zBQdECWuz4eAlSe+fYEZGuL4+tcb49zZwFz5sFTCIr
 6UfvHHKDN5r5n2HlFevLbsGHDhKvw5LP/S3VE6IpxpEYjqBswd6ugTltqr2mh0Hpxt4G
 JqCHfKFNFaOwcOhrC0ZUNY46ChBZVPVTz7j3qcJsPYZh3TFWd+UeEyy3Z33rHPmQ9IRH
 CSXoG0VTOcQE79o+CC0fXaDG0ei9en0ynr5sqPN75VFQDPTbgesIsm2hg91/avLZuApB
 iN4mL295tho8Hdwf3BZi+a1zp4c3a1K7aO3fgGuB+OLrS6vhzCDfiE+eRkBiIIGBsLdg
 iKbg==
X-Gm-Message-State: AOJu0YxMsL9RJjDQsOJKD6FgD9GWM8Btgq/fLVMVXWnzZrxqel6OqCJn
 vimJQBqaNT6A14o+jmUe9BYV4kQlLMqq29slRHHBQhkO0ELa11vO5pwdY6JtCpuQlCs81dMV3XH
 7N9YMozFqPcg1zaM=
X-Received: by 2002:a05:6214:5090:b0:66d:25cb:43ba with SMTP id
 kk16-20020a056214509000b0066d25cb43bamr7763250qvb.20.1699602042259; 
 Thu, 09 Nov 2023 23:40:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHILcFaeqouA667ZEamwXGgOKpu77IJpohK3aEJP8binMKl4J7HQxa8C0Ry9npK96771sHZbQ==
X-Received: by 2002:a05:6214:5090:b0:66d:25cb:43ba with SMTP id
 kk16-20020a056214509000b0066d25cb43bamr7763241qvb.20.1699602042019; 
 Thu, 09 Nov 2023 23:40:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 cj17-20020a05622a259100b004196a813639sm2655294qtb.17.2023.11.09.23.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 23:40:41 -0800 (PST)
Message-ID: <81e498b6-9e74-4bf8-8c7e-02ff9451ebe3@redhat.com>
Date: Fri, 10 Nov 2023 08:40:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390x/pci: small set of fixes
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, qemu-devel@nongnu.org
References: <20231109225302.401344-1-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231109225302.401344-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hello Matthew,

On 11/9/23 23:53, Matthew Rosato wrote:
> The following set of changes are associated with issues exposed by testing
> of the 'vfio: Adopt iommufd' series.
> 
> The first patch fixes an existing assumption that a vfio device will always
> have a group fd (which is no longer true if cdev is used, which can only
> happen once the iommufd backend is used).  This patch really only needs to
> go into 8.2 if the 'vfio: Adopt iommufd' series does (but would be fine to
> go into 8.2 without it too).

It is a bit late for the 8.2. So we have time to polish v5 of the 'vfio: Adopt
iommufd' series a bit more. I should include the v6 in an early PR for a 9.0.
  
> The second patch fixes an issue where we do not detect that a vfio DMA limit
> was never read from vfio.  This is actually an existing bug as it's possible
> for an older host kernel to be missing this support today; so ideally this one
> should be targeted for 8.2 regardless.

Nevertheless, I hope these two fixes can reached 8.2 since they are good
to have anyhow.

Thanks,

C.

  
> Matthew Rosato (2):
>    s390x/pci: bypass vfio DMA counting when using cdev
>    s390x/pci: only limit DMA aperture if vfio DMA limit reported
> 
>   hw/s390x/s390-pci-vfio.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 


