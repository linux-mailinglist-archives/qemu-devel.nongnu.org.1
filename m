Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8AF77BB7C
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 16:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVYVc-0006iB-Up; Mon, 14 Aug 2023 10:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVYVa-0006hR-Bz
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 10:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVYVY-0005ZQ-Ve
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 10:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692023123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65sG+RMRrrKL7SrB9VtlqIZH+N2RbM8vjvK/rJCvj70=;
 b=JAp17ixE9LItUI55ql1Qmwv2HOeBJnHNAZ6FrV831X38aKU67fQyDQkeEb2rAA6vibouZ5
 WoC1hXKVym/29tkt4ej2Xy3rRnyc3cQwHQomblV9jbUNzJLbalmchv6ADOALLiWoRieu/m
 8u+f3735XwULgwngrWh8CmycX9hJpe4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-eLGEIYEmPrSy30w0AmGArA-1; Mon, 14 Aug 2023 10:25:19 -0400
X-MC-Unique: eLGEIYEmPrSy30w0AmGArA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3176ace3f58so2568873f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 07:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692023118; x=1692627918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=65sG+RMRrrKL7SrB9VtlqIZH+N2RbM8vjvK/rJCvj70=;
 b=kKpaKY7eoGdyjEyibJ4SzCcmJcqAkM+StP3llNsevk4Z9jUK9/Fj7cnfKuLcgnPOOA
 quX3z1iGTUjS9GFnlLuEL8sDtBdUEeiDtxU3mWlmCI+MnlsiUplmga2rXuS+DvwtXqz8
 XQj8UAfalT/F6Joe3nkR93tmxBhSPUm36/z//TmTsiKluXznibnpK39iKpVQD7perfpE
 yMvkGkHwU21V66UMSPM5ldpLhpwopS4CsCjxG68pY6s7hXnd84AYDOIQPiqexW/8zgZc
 j0E41QozyhW39Hinar/nMEeRpnRquZlcXo4mBcYIimbGFyrj5AGzLyErnnqJgZ0rxssv
 D5hw==
X-Gm-Message-State: AOJu0YxOFScPmfKxaJKEIfLvrx19DrXAg2TYCK6FwMM0vI0qINFSIOOG
 BfnBkOnB3CWSi6ozEsRRP8q9MF/Oh7R4RcVlZN1QmpUOHLvan8NFdiaQ2xgPGstbXL9RNe3mlGh
 A+LiKg08TTjtVoK0=
X-Received: by 2002:adf:f80e:0:b0:314:1f1e:3a85 with SMTP id
 s14-20020adff80e000000b003141f1e3a85mr6338079wrp.61.1692023118406; 
 Mon, 14 Aug 2023 07:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+YlRhmT73Wvzm40XigqBmac5cKnZ2TBFVnpXoQzRv/CHHke2l22Qgr9RqGCLN8NWYo1kU3Q==
X-Received: by 2002:adf:f80e:0:b0:314:1f1e:3a85 with SMTP id
 s14-20020adff80e000000b003141f1e3a85mr6338057wrp.61.1692023117896; 
 Mon, 14 Aug 2023 07:25:17 -0700 (PDT)
Received: from [192.168.8.105]
 (dynamic-046-114-244-033.46.114.pool.telefonica.de. [46.114.244.33])
 by smtp.gmail.com with ESMTPSA id
 h9-20020adffd49000000b003176aa612b1sm14593878wrs.38.2023.08.14.07.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 07:25:17 -0700 (PDT)
Message-ID: <3b37bbdb-e43c-d317-3efd-2f0d19de5631@redhat.com>
Date: Mon, 14 Aug 2023 16:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] linux-headers: update asm-s390/kvm.h
Content-Language: en-US
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230810124719.2167260-1-seiden@linux.ibm.com>
 <20230810124719.2167260-2-seiden@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230810124719.2167260-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.265, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Sorry, I should have mentioned this for v1 already, but better late than 
never: We need to replace this patch with a proper header update later (via 
the scripts/update-linux-headers.sh script) - so in case you respin, please 
mark it with NOTFORMERGE or PLACEHOLDER or something similar in the subject, 
and mention the kernel version in the description that will likely contain 
the update.

  Thanks,
   Thomas


On 10/08/2023 14.47, Steffen Eiden wrote:
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   linux-headers/asm-s390/kvm.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
> index e2afd95420..023a2763a9 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -159,6 +159,22 @@ struct kvm_s390_vm_cpu_subfunc {
>   	__u8 reserved[1728];
>   };
>   
> +#define KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST	6
> +#define KVM_S390_VM_CPU_MACHINE_UV_FEAT_GUEST	7
> +
> +#define KVM_S390_VM_CPU_UV_FEAT_NR_BITS	64
> +struct kvm_s390_vm_cpu_uv_feat {
> +	union {
> +		struct {
> +			__u64 : 4;
> +			__u64 ap : 1;		/* bit 4 */
> +			__u64 ap_intr : 1;	/* bit 5 */
> +			__u64 : 58;
> +		};
> +		__u64 feat;
> +	};
> +};
> +
>   /* kvm attributes for crypto */
>   #define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
>   #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1


