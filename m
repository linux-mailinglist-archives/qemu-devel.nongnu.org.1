Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 269068303F5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:54:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3Z7-0008Uz-T8; Wed, 17 Jan 2024 05:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ3Z5-0008U5-PE
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:54:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ3Z4-0006lF-6A
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705488873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBYFFVoZT/RglGeN0V4s3xbUjx9sGAtHaAaooCwUDlc=;
 b=NtA7AaVnVe9hSrurvAW9mEm9iECz6eYdi1m5BIHIrSM489F9PG7AsfQKArWJuAk4qte1x0
 tAGyeQrWW7kiicUEFCirNo5NAPbAoU0CoWy3iK9q14q88q2pXN7H2lfWfJOVDPzOX0qVHw
 Fia5lD5N+sc2W2uZpPBDwkueqn5hEIs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-KUScWwf_PXezY8clhA3_zg-1; Wed, 17 Jan 2024 05:54:32 -0500
X-MC-Unique: KUScWwf_PXezY8clhA3_zg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-429fe127372so43475231cf.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 02:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705488870; x=1706093670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kBYFFVoZT/RglGeN0V4s3xbUjx9sGAtHaAaooCwUDlc=;
 b=T6UJ+zFkvQu3vPPFVm2dqwBzbD65p2VvWuz4o+1dq4/v7TdCr237DMo2oVbENE595R
 fOPuWwp4jKKL8LtNsZYk9nLJuN764O9nGsoY3G0UXhQfKlcVcOoPhw3pUh42qHTfQtyM
 0zibD+V5SHd2046BQm5glhi1PmN0zRMnq2fPe4m2JtoReXvYtnP9BMLPg9QnbUCbX/kz
 shfhLgLH7BNT5mXftz6yAVG13Q+BtG02qQFU/BlVlaOsrhpadmtFGxltBoeviAVu/2P9
 XxomN1LvAoPfZ5Q5W5p7/rq/852NyAYhjYUNmo+u7YlRcKWscnqDl4VW7kI3D3H5CcyA
 3W2Q==
X-Gm-Message-State: AOJu0YwAkHnRIYRnaL7scFwBq7S19NhBFtEoIoq6JwzkSjWs+vusZA7+
 PsJUMMYN7zSsAwEtZC8y1mW55gF9IMEvLawzqQcJBh7ERiCuS6rJ1No0MLZjjCRoP3phW8d3Olh
 c4b+dw/SPOF45vyTaBnrHme8=
X-Received: by 2002:ac8:5dc8:0:b0:429:ffae:e342 with SMTP id
 e8-20020ac85dc8000000b00429ffaee342mr3080074qtx.23.1705488870643; 
 Wed, 17 Jan 2024 02:54:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8puD+4v1ql3E9EOeaxpd5nvsmC94DbfY53fL2FG4y11xFk6XL9x6RkTLPrl97h6UYwbRLVg==
X-Received: by 2002:ac8:5dc8:0:b0:429:ffae:e342 with SMTP id
 e8-20020ac85dc8000000b00429ffaee342mr3080055qtx.23.1705488870375; 
 Wed, 17 Jan 2024 02:54:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 da3-20020a05620a360300b007833dbbc07asm4401782qkb.0.2024.01.17.02.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 02:54:30 -0800 (PST)
Message-ID: <8a205b58-7efb-4d68-8f37-f7ac906d646a@redhat.com>
Date: Wed, 17 Jan 2024 11:54:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390x/pci: avoid double enable/disable of aif
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-2-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240116223157.73752-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On 1/16/24 23:31, Matthew Rosato wrote:
> Use a flag to keep track of whether AIF is currently enabled.  This can be
> used to avoid enabling/disabling AIF multiple times as well as to determine
> whether or not it should be disabled during reset processing.

Why don't we disable AIF always at reset ? Doesn't KVM handle multiple calls
to KVM_S390_ZPCIOP_DEREG_AEN cleanly ? Just asking, I am no expert there.

Thanks,

C.


> Fixes: d0bc7091c2 ("s390x/pci: enable adapter event notification for interpreted devices")
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-kvm.c         | 25 +++++++++++++++++++++++--
>   include/hw/s390x/s390-pci-bus.h |  1 +
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
> index ff41e4106d..f7e10cfa72 100644
> --- a/hw/s390x/s390-pci-kvm.c
> +++ b/hw/s390x/s390-pci-kvm.c
> @@ -27,6 +27,7 @@ bool s390_pci_kvm_interp_allowed(void)
>   
>   int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist)
>   {
> +    int rc;
>       struct kvm_s390_zpci_op args = {
>           .fh = pbdev->fh,
>           .op = KVM_S390_ZPCIOP_REG_AEN,
> @@ -38,15 +39,35 @@ int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist)
>           .u.reg_aen.flags = (assist) ? 0 : KVM_S390_ZPCIOP_REGAEN_HOST
>       };
>   
> -    return kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
> +    if (pbdev->aif) {
> +        return -EINVAL;
> +    }
> +
> +    rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
> +    if (rc == 0) {
> +        pbdev->aif = true;
> +    }
> +
> +    return rc;
>   }
>   
>   int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
>   {
> +    int rc;
> +
>       struct kvm_s390_zpci_op args = {
>           .fh = pbdev->fh,
>           .op = KVM_S390_ZPCIOP_DEREG_AEN
>       };
>   
> -    return kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
> +    if (!pbdev->aif) {
> +        return -EINVAL;
> +    }
> +
> +    rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
> +    if (rc == 0) {
> +        pbev->aif = false;
> +    }
> +
> +    return rc;
>   }
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index b1bdbeaeb5..435e788867 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -361,6 +361,7 @@ struct S390PCIBusDevice {
>       bool unplug_requested;
>       bool interp;
>       bool forwarding_assist;
> +    bool aif;
>       QTAILQ_ENTRY(S390PCIBusDevice) link;
>   };
>   


