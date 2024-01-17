Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEAE8303C4
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:41:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3Lj-0005mI-OB; Wed, 17 Jan 2024 05:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ3Lh-0005m5-Hd
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ3Lg-0004ez-1R
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705488042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1nQ1pgiQvK5t4G2S0mg9YKw0qMyY8i7cszZBYZD/vA=;
 b=HphN/TqEeoaxrmFJkLtBJPg174HNWLG7TxUNtV54caGbEwnjF/+X7vCp20Tkt205jkMN+F
 OJvE8bg10zkIyxHvI39wn6SMl+3sHACL6g1OV2kQ3MuZUCmOoVHB2CX62klUmmT2gI9KAh
 5/W3PTwtej2okH4TKG/8yJvZQ2Z+PT0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-IuIONtNJP4SfWFQ9USd0AQ-1; Wed, 17 Jan 2024 05:40:37 -0500
X-MC-Unique: IuIONtNJP4SfWFQ9USd0AQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc245c7b1daso111309276.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 02:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705488037; x=1706092837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1nQ1pgiQvK5t4G2S0mg9YKw0qMyY8i7cszZBYZD/vA=;
 b=iORzz4NhD3AnDl1n8EqQlFbFufMrmcrtXkIq8Yh7MTEmSZEx+KvFm8wYTWXqphcZ0d
 bhnWcLTGizIRNe3Ouv+DQ0x8WeWQFvJtHPFRNHo81xwBxxyAFT9ER2gAbkyn6H5oEG4D
 dXpeuSfaJe+/oCygbHfKWLNJrwG7LWZQ1ewE8SLE1RYCN9cWqyTvYXSw4uYbZ1uMMaXB
 eZ/tdJYl7TB/WRR6Yd3ah0LL7b0iPdCp6UBd9ktVUy7rtXmY5HObO/DD5rVO5kFYTIBX
 fLKjKi1xL1B50HSCHEplmT5HgWw5GnmFkmvv28z85VOyYMWAcwvbFcHBlshsEGPXFUQO
 BfVQ==
X-Gm-Message-State: AOJu0YxuD2xHEkZexYuHhOXNIfv2qwuBnaeBhotyDa2Mb2bkCQ44y9Ij
 UVDp0Fpbwobvxws+6kqLnHaWRVMpaIbJYBwVhOgpC82F7tCDPlKjCi8v3MEHBq4OgrjllDPSLhc
 Ju9aSLP641NzQuSwdT26ApCU=
X-Received: by 2002:a25:dccd:0:b0:dc2:2a9d:202f with SMTP id
 y196-20020a25dccd000000b00dc22a9d202fmr1845927ybe.74.1705488037240; 
 Wed, 17 Jan 2024 02:40:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNVzaRe62c54Ua+o1ixwepSgZvNIVIRH4Jq+2C8I33idVnSlnYf0TYXur7XEBjBs/nOMv7Ag==
X-Received: by 2002:a25:dccd:0:b0:dc2:2a9d:202f with SMTP id
 y196-20020a25dccd000000b00dc22a9d202fmr1845922ybe.74.1705488036974; 
 Wed, 17 Jan 2024 02:40:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 hj11-20020a05622a620b00b00428346b88bfsm5623902qtb.65.2024.01.17.02.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 02:40:36 -0800 (PST)
Message-ID: <2c8ce63b-f8b1-4b98-97e5-4416d4d622cf@redhat.com>
Date: Wed, 17 Jan 2024 11:40:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] s390x/pci: refresh fh before disabling aif
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-3-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240116223157.73752-3-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> Typically we refresh the host fh during CLP enable, however it's possible
> that the device goes through multiple reset events before the guest
> performs another CLP enable.  Let's handle this for now by refreshing the
> host handle from vfio before disabling aif.
> 
> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-kvm.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
> index f7e10cfa72..9eef4fc3ec 100644
> --- a/hw/s390x/s390-pci-kvm.c
> +++ b/hw/s390x/s390-pci-kvm.c
> @@ -18,6 +18,7 @@
>   #include "hw/s390x/s390-pci-bus.h"
>   #include "hw/s390x/s390-pci-kvm.h"
>   #include "hw/s390x/s390-pci-inst.h"
> +#include "hw/s390x/s390-pci-vfio.h"
>   #include "cpu_models.h"
>   
>   bool s390_pci_kvm_interp_allowed(void)
> @@ -64,9 +65,17 @@ int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
>           return -EINVAL;
>       }
>   
> +    /*
> +     * The device may have already been reset but we still want to relinquish
> +     * the guest ISC, so always be sure to use an up-to-date host fh.
> +     */
> +    if (!s390_pci_get_host_fh(pbdev, &args.fh)) {
> +        return -EPERM;
> +    }

The callers of s390_pci_kvm_aif_disable() all test the original host
function with :

    if (pbdev->interp && (pbdev->fh & FH_MASK_ENABLE))

This change possibly fetches a new one. Shouldn't we move the test
also in s390_pci_kvm_aif_disable() ?


Thanks,

C.



> +
>       rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
>       if (rc == 0) {
> -        pbev->aif = false;
> +        pbdev->aif = false;
>       }
>   
>       return rc;


