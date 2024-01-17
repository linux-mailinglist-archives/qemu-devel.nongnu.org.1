Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEFC8303AC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:32:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3DM-0001uR-Sz; Wed, 17 Jan 2024 05:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ3DF-0001tx-Mp
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQ3DE-0002ze-9u
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705487519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiPydxdPUXiou6B1qykgeCw8QWraFntJKyqDvv7KJVE=;
 b=CFGogqeOxMqgzrVlhT5pQemn5+DpU5DwpmTagD85Fq30yaYaSxWMS3UmuNBjrxbr6rE9NM
 rvGTgIoRrrHhC6bFdeoDYs4AjHA5XKe+TF7u9Y/NDu2XJhhIpWbAXFEjVXdootaJrDBMDi
 idnTiUpzySqhQCtOlPJz05AWeiSnpY4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-mbl_ekPONxyKr4ks7QsWRQ-1; Wed, 17 Jan 2024 05:31:57 -0500
X-MC-Unique: mbl_ekPONxyKr4ks7QsWRQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67ef8bbfe89so232777016d6.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 02:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705487516; x=1706092316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iiPydxdPUXiou6B1qykgeCw8QWraFntJKyqDvv7KJVE=;
 b=qpt1pDfZ1wgv5EmrD1l/BwidWtsi4flmyVEuK0GN8NsikPEOdUpmWeRNKMHrN2/5EF
 W72a3BZyJazTeQYw1kLjsbUGe044dUgu6znGLxVVhB+qNqHPksCpiM7l8OhEJPqelEVT
 QbtFkcPiez3cI7EjyzHjklcrr30w5eTdQdIGsbAQ7HvSufO0Xj3wjTYoY+nU4ooTOrC5
 McPDc6xwPM+94EsGNt2s123PWJe1PDQTksk9r1jrKTfUYQfQJoJ/YHAZTCqpIIQO3uoo
 0zE/jjCl1QVgFkemG2+oapFwXvnN99Vnt7I35RLkIIEpOzLmrEeUTVl+7lhHMcJtcnH2
 +z9w==
X-Gm-Message-State: AOJu0YyHgTHa2bGwh4eItMPk98AOwyhFmuUluDiycrnjMX4vm+u4v43j
 3G3epf9gdY7wIAdWRhGUaea/Ed+/87kWEq7myIUNf9lE8qEJ6rCU424Ta+Eh6l7EM5tIkvx42n3
 7LZTq/AfHNZw4KKF+GSf2IGs=
X-Received: by 2002:a05:6214:19e6:b0:680:fe80:2f56 with SMTP id
 q6-20020a05621419e600b00680fe802f56mr10994468qvc.78.1705487516610; 
 Wed, 17 Jan 2024 02:31:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIHFvAXDYAdfqink0Qtw00fn5k/MZDa5amdMN9GSDutsHgN3E5pmIiZNvOStS164uZ4fKdCQ==
X-Received: by 2002:a05:6214:19e6:b0:680:fe80:2f56 with SMTP id
 q6-20020a05621419e600b00680fe802f56mr10994455qvc.78.1705487516341; 
 Wed, 17 Jan 2024 02:31:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ei16-20020ad45a10000000b006816fa492f3sm1208183qvb.61.2024.01.17.02.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 02:31:56 -0800 (PST)
Message-ID: <3016e7dd-197d-45a6-abb6-ce3f9ad31f42@redhat.com>
Date: Wed, 17 Jan 2024 11:31:53 +0100
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

Hello Matthew,

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
> +
>       rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
>       if (rc == 0) {
> -        pbev->aif = false;
> +        pbdev->aif = false;
>       }

This belongs to patch 1.


Thanks,

C.


>   
>       return rc;


