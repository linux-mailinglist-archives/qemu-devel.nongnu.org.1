Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE674557D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 08:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGD3L-00016X-O5; Mon, 03 Jul 2023 02:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGD3J-00016P-H9
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGD3I-0001VI-0g
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688365727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjNhtglLSh0i7cAYJ19Chg3JUmXxeWzvK4bXcKQ0IKQ=;
 b=UJ9ZIr5Lt4Df0dD2qtD5dyUkp8M4YBJw7zTR2IheyZM1zTiIIVN55118r0iKu3ZsABpwnD
 pHkSxoMwk09BGnEisODOipzcBnr2Tg4xcew1jw5WwRMIBtqmS18lOFPcsGG4cMLW1FIEnU
 O9owaPzwGiSmY1V/4D9rC/MEN3wZAkk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Hag450s1NNGoZbDNjfDz9g-1; Mon, 03 Jul 2023 02:28:45 -0400
X-MC-Unique: Hag450s1NNGoZbDNjfDz9g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-401e40e4d48so37378181cf.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 23:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688365725; x=1690957725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjNhtglLSh0i7cAYJ19Chg3JUmXxeWzvK4bXcKQ0IKQ=;
 b=Psi8KjVGtle1U1GzPgAZXeqylfKrRwIK1DWtKY5atxGUF97jk+7HgTol6/+Vf/+9eW
 X6UwcBPuchvw523b4aC0noUEHJEEPmeFCwgzR4NzXSa8S/nQKbEI+9JZhylE5j7tNiFh
 4AomuH+FD43p+SZOi2hHMs+iABCvIysZesNohnk2AYO/gx0UXyNtyRPOAZW0kPAFvY7m
 11Ochz6XCVh8fgKXZtBxvcUfoo34Wf88sOSgQ7dQkFEcBP8se68qruAtPH5ZSYxwD/Ij
 BeB7p3/1E1/gNIgEBBNuGpL8T0zuHSX6zmAYlknt8Cq0hMP8bb5tmiCWyjGO5fpagwyV
 QYtg==
X-Gm-Message-State: AC+VfDycNYJa2ISkkyowvjj26LDSgdC7nfJ22yHkGmCnzLkrix0CpNb2
 KvXxlhsCWjhk5mG1v9XOPp9Mkbf6H+ywC7vH8tsqwD/1HeK7A1Oghqv7uEesNw3DgjREF5AxZu4
 GaJ/UkEBu1rwKqtM=
X-Received: by 2002:a05:622a:507:b0:3ff:4583:5f4f with SMTP id
 l7-20020a05622a050700b003ff45835f4fmr10293907qtx.37.1688365725003; 
 Sun, 02 Jul 2023 23:28:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mnJvSw1qbJryWyjXkVcX2l2jX4i31vTls89uXNrD8kotFaGMT0In1NgaI4DEXgIVTm42Tvg==
X-Received: by 2002:a05:622a:507:b0:3ff:4583:5f4f with SMTP id
 l7-20020a05622a050700b003ff45835f4fmr10293898qtx.37.1688365724806; 
 Sun, 02 Jul 2023 23:28:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 x10-20020ac87eca000000b0040223cef736sm7982944qtj.21.2023.07.02.23.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 23:28:44 -0700 (PDT)
Message-ID: <b27f9e74-98a1-aafe-9362-b1ab22ae73d9@redhat.com>
Date: Mon, 3 Jul 2023 08:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/7] vfio/pci: Disable INTx in vfio_realize error path
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
 <20230630073637.124234-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230630073637.124234-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/30/23 09:36, Zhenzhong Duan wrote:
> When vfio realize fails, INTx isn't disabled if it has been enabled.
> This may confuse host side with unhandled interrupt report.
> 
> Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab6645ba60af..31c4ab250fbe 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3220,6 +3220,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       return;
>   
>   out_deregister:
> +    if (vdev->interrupt == VFIO_INT_INTx) {
> +        vfio_intx_disable(vdev);
> +    }
>       pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>       if (vdev->irqchip_change_notifier.notify) {
>           kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);


