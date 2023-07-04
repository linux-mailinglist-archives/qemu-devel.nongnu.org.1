Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 610117471D7
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:56:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfZG-0005zg-HF; Tue, 04 Jul 2023 08:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfZ9-0005xh-K5
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfZ7-0000j5-12
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688475332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yt8OOmF/Qc2FhZfKBFaBIsbOKOzxd5G7Z5ZpCMV+xEY=;
 b=dKXTjrPM2ftoS0QZKeGlSTqZqOzJbd4G7a6iRi5TTnfBHKCgaJ81Amhvfkq0FY9DD+PgMG
 5TIEjQH8xRIElEvgGd1ofLyyczj/TBJHXvoyoQnr83phyjVVhJo1swRpI1dh2qz3odRaVV
 RN/2VBqoZx710Ko9VgeRJSBEl9K/cHo=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-EmJ1tftJPG2_fUix6CAnCQ-1; Tue, 04 Jul 2023 08:55:30 -0400
X-MC-Unique: EmJ1tftJPG2_fUix6CAnCQ-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-471876a847aso923558e0c.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688475330; x=1691067330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yt8OOmF/Qc2FhZfKBFaBIsbOKOzxd5G7Z5ZpCMV+xEY=;
 b=cgIPxU/uQ0hwE4vD+SCQ+hwowc2CM1Dml0MbZi30aG4NF+JqZzXn45Y40wF/Lhu26R
 erSvOhBba0cg+LhYoL8kxeuYYYYIR2X6X2f9yKhx2//R3Li9sBf4AAgdHgaD2PTTtiBs
 TEYOuusVvRFU2DRuesvo2uNfRCKSG5I4ieWJIo7vYatBNccuzXvSg125qB4xWWJ7xblU
 3KVNj4YrSW0+BlzPd/HaeKkvyZo03hw4rb60yaLF/ONgRZa3zwmaL5rZXTtztetFcC/Z
 77Sd2s4dN/dZP1MNQf4RTKP4R0/RPxGQyWftg8vCGegHN7TOPX25M52baNLz/WxAPCHr
 cLdw==
X-Gm-Message-State: ABy/qLZpC1BOW7Nq4u6YdPvWd3EL3/IDCCE7rBP3g+4/eN5OCL2+KQhQ
 yps8rHBFzx5Bm6YpdUeu014mvNHSdDFu1+FH2e05oQqaatj+yjikEXn9I03R7ZkjYEFJJ02iFQF
 dNXJ3QLIgEURV7y8=
X-Received: by 2002:a1f:4343:0:b0:47e:7c7:2ed1 with SMTP id
 q64-20020a1f4343000000b0047e07c72ed1mr6554968vka.5.1688475330415; 
 Tue, 04 Jul 2023 05:55:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNnhvbEPYarzUzZvU9N65kNkodvCxjJsUl6IJ9loWNtsx4o/6nApfANtVIund77GAsHLGHwQ==
X-Received: by 2002:a1f:4343:0:b0:47e:7c7:2ed1 with SMTP id
 q64-20020a1f4343000000b0047e07c72ed1mr6554946vka.5.1688475330149; 
 Tue, 04 Jul 2023 05:55:30 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 m6-20020a0c9d06000000b0063659410b04sm5027642qvf.107.2023.07.04.05.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:55:29 -0700 (PDT)
Message-ID: <747a5678-6140-a0ca-b08c-841b2ae00802@redhat.com>
Date: Tue, 4 Jul 2023 14:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 09/20] machine: adding s390 topology to query-cpu-fast
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-10-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-10-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/06/2023 11.17, Pierre Morel wrote:
> S390x provides two more topology attributes, entitlement and dedication.
> 
> Let's add these CPU attributes to the QAPI command query-cpu-fast.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   qapi/machine.json  | 9 ++++++++-
>   target/s390x/cpu.c | 4 ++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 08245beea1..a1920cb78d 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -56,10 +56,17 @@
>   # Additional information about a virtual S390 CPU
>   #
>   # @cpu-state: the virtual CPU's state
> +# @dedicated: the virtual CPU's dedication (since 8.1)
> +# @entitlement: the virtual CPU's entitlement (since 8.1)
>   #
>   # Since: 2.12
>   ##
> -{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
> +{ 'struct': 'CpuInfoS390',
> +  'data': { 'cpu-state': 'CpuS390State',
> +            'dedicated': 'bool',
> +            'entitlement': 'CpuS390Entitlement'

Would it make sense to make them optional and only report those if the 
topology feature is enabled?

  Thomas


> +  }
> +}
>   
>   ##
>   # @CpuInfoFast:
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 74405beb51..01938635eb 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -146,6 +146,10 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
>       S390CPU *s390_cpu = S390_CPU(cpu);
>   
>       value->u.s390x.cpu_state = s390_cpu->env.cpu_state;
> +#if !defined(CONFIG_USER_ONLY)
> +    value->u.s390x.dedicated = s390_cpu->env.dedicated;
> +    value->u.s390x.entitlement = s390_cpu->env.entitlement;
> +#endif
>   }
>   
>   /* S390CPUClass::reset() */


