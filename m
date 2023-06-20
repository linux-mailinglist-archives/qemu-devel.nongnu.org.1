Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F94736F01
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:44:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcal-0005kU-FS; Tue, 20 Jun 2023 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qBcak-0005kL-G4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qBcaj-0007nv-2S
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687272240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+I8eQVtNnvD6l8FH+J8RbxiC+CMHbELIWukFcKa/GQw=;
 b=EJRrb3GswI3qbtPskrYeXrWtHd15scI/h2NQ6Uth9NJwkJQ6PqES+TosVwPubf8daH7Wtm
 R3p3NkN4QSOJ07oyrMN/c+Gnhc2HknkwApe//NiijZfbLU9aAsMHLnkORJYadBRUt24ARh
 05KRve7mOzkF8BVzpMNmEcrgmA+ne0U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-VEBIW7RfO0OzwRNzBNDirg-1; Tue, 20 Jun 2023 10:43:53 -0400
X-MC-Unique: VEBIW7RfO0OzwRNzBNDirg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62ff6a6b4f4so53478196d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687272232; x=1689864232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+I8eQVtNnvD6l8FH+J8RbxiC+CMHbELIWukFcKa/GQw=;
 b=L56fMnjK0m8ipCC2uTsxFof47mVa9j53SVEhmTz9la8N+WZxxx49qTSvc9CJpwnQtL
 8WF2fd82MCCiYI9XVvla2j1Ysh3E3DU3xaNPwwdkCgkvZ7qxqnjYXbRWGs+2j6VjPL6P
 eQ73O9ze57WLfaxqJsTGtogZ5ZtNq+srViHo51EGobNLs0vrpPZT5iNN2YLp5vGB2v8i
 l6EWfv9S0S5RMLztVhDg9zwfSg33M96hOhpmtGcRUzaOx4WGMAVNTMr83qsOJDXWVASW
 nqV39dqJl6oa8MKrdYjk7IA6c9ZRiM5CkbGJM8DzQ0VSguHFmxo18/H2+KSbtE+iKRV9
 +uFQ==
X-Gm-Message-State: AC+VfDxKHHNBSPAsnlgRM1RRQI1mCzrbQxW0TqxPcnLZpUTc4aX9y5lt
 gDylzQEQYmdpKuZM05ln+Vwmnw/PCZL78Om1lSZEMBGS8t6dHHdCHsrPfrglhQn9KjZE6+lzFri
 nkMyal+FytVcWysE=
X-Received: by 2002:a05:6214:1d07:b0:62f:e138:eac6 with SMTP id
 e7-20020a0562141d0700b0062fe138eac6mr17451300qvd.62.1687272232745; 
 Tue, 20 Jun 2023 07:43:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4k3rNyLK7TuR7Z10AKeHUMUM6HLP/hZ/MA8+8zy3M2hUxBTJGHcHLgEHadYYAt4ARZhO19BA==
X-Received: by 2002:a05:6214:1d07:b0:62f:e138:eac6 with SMTP id
 e7-20020a0562141d0700b0062fe138eac6mr17451284qvd.62.1687272232497; 
 Tue, 20 Jun 2023 07:43:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a0cf00b000000b0062119a7a7a3sm1337947qvk.4.2023.06.20.07.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 07:43:51 -0700 (PDT)
Message-ID: <65bfc353-c348-6810-6e06-f7237c9ad621@redhat.com>
Date: Tue, 20 Jun 2023 16:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] vfio/pci: Call vfio_prepare_kvm_msi_virq_batch() in MSI
 retry path
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, chenxiang66@hisilicon.com, longpeng2@huawei.com,
 linuxarm@huawei.com
References: <20230613140943.1786-1-shameerali.kolothum.thodi@huawei.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230613140943.1786-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

Hello Shameer,

On 6/13/23 16:09, Shameer Kolothum wrote:
> When vfio_enable_vectors() returns with less than requested nr_vectors
> we retry with what kernel reported back. But the retry path doesn't
> call vfio_prepare_kvm_msi_virq_batch() and this results in,
> 
> qemu-system-aarch64: vfio: Error: Failed to enable 4 MSI vectors, retry with 1
> qemu-system-aarch64: ../hw/vfio/pci.c:602: vfio_commit_kvm_msi_virq_batch: Assertion `vdev->defer_kvm_irq_routing' failed
> 
> Fixes: dc580d51f7dd ("vfio: defer to commit kvm irq routing when enable msi/msix")
> Reviewed-by: Longpeng <longpeng2@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Looks correct to me,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de..8fb2c53a63 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -663,6 +663,8 @@ static void vfio_msi_enable(VFIOPCIDevice *vdev)
>   
>       vfio_disable_interrupts(vdev);
>   
> +    vdev->nr_vectors = msi_nr_vectors_allocated(&vdev->pdev);
> +retry:
>       /*
>        * Setting vector notifiers needs to enable route for each vector.
>        * Deferring to commit the KVM routes once rather than per vector
> @@ -670,8 +672,6 @@ static void vfio_msi_enable(VFIOPCIDevice *vdev)
>        */
>       vfio_prepare_kvm_msi_virq_batch(vdev);
>   
> -    vdev->nr_vectors = msi_nr_vectors_allocated(&vdev->pdev);
> -retry:
>       vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->nr_vectors);
>   
>       for (i = 0; i < vdev->nr_vectors; i++) {


