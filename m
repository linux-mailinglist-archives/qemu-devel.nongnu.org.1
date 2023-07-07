Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BEE74B302
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHmOs-0001zj-Dx; Fri, 07 Jul 2023 10:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHmOp-0001x3-IA
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHmOm-0000Ww-92
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688739927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7df5gWt8wP3f+IMDyn7FqcXDyerLufBI3/aBRTkYME=;
 b=ZYSdxARjk4sOQkdH4IOzAK6vjQLC/t9AMrsdaHDxCI9LQOXblfxfmsCg45AfFR3Q4r0Uif
 Im7apy0htY1mFn0QMhqR5CfNP9wknGHBUa7UxVd6r/tp9D+zRSSA2zuF4a1c+D+oXfPBfI
 95Z6/vptygI4olQU/c2fSYMntlQscvU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-fj13GsiBNDu_9qA8zWOzSA-1; Fri, 07 Jul 2023 10:25:25 -0400
X-MC-Unique: fj13GsiBNDu_9qA8zWOzSA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-97542592eb9so120575866b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688739925; x=1691331925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7df5gWt8wP3f+IMDyn7FqcXDyerLufBI3/aBRTkYME=;
 b=OfCYUtEUomslNmRy+B4zL1Jb+/tyf1jQwgul6Re3pS38yop6cCXx3q00tkp7L7asLW
 Vj1tZCCz1KBn4hG2kIqihC7qwhowfJHdEfdil4MRuqL/n6xhkkZVAR1I9rVZeHpaAcIX
 nphwQyunCf5xdh12LB0c7rBWct8viGP2a4Up+4BuvMhx00KX1wZdkXc4oT1pjGd4iebR
 KqmCuXCPX3b5peQH5LVxBw7DLd1oQGJdR/XytOLEcK1AbM9Wn6unaZcS7BHt/FiNJmzf
 77oK2pC0GBrRyJIpDh7rXQqUUC2Zekg/JHlyXwrywzXoIO5hHIl7nbLsmO68nAQxEg8S
 iIkw==
X-Gm-Message-State: ABy/qLZQVlweEMAB+3vMBGcZcIJSd9qojdHu0ygqh/1CLEl02tllQRUP
 k8NhLa18Q188gkd9CobPslXe3MY0Ub2JnJ/2hvbS8HwcRc3Ej8HlbGqCm90swpz+IrpqAj8K6P+
 9m7ALzc2yLgPFQ3I=
X-Received: by 2002:a17:906:15c:b0:978:8937:19ba with SMTP id
 28-20020a170906015c00b00978893719bamr5263243ejh.44.1688739924855; 
 Fri, 07 Jul 2023 07:25:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHrhqcmF7Y8QhqxA6hVnE7Q8bITF7QQqHadMVmRjTmT8TKDysiKUSL+IBcA43jz8ITp7ilsPQ==
X-Received: by 2002:a17:906:15c:b0:978:8937:19ba with SMTP id
 28-20020a170906015c00b00978893719bamr5263228ejh.44.1688739924568; 
 Fri, 07 Jul 2023 07:25:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 ja24-20020a170907989800b0098242730348sm2256364ejc.72.2023.07.07.07.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 07:25:23 -0700 (PDT)
Message-ID: <d4c1bb9b-8438-ed00-c79d-e8ad2a7e4eed@redhat.com>
Date: Fri, 7 Jul 2023 16:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] i386: Add support for SUCCOR feature
Content-Language: en-US
To: John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 william.roche@oracle.com, joao.m.martins@oracle.com
References: <20230706194022.2485195-1-john.allen@amd.com>
 <20230706194022.2485195-2-john.allen@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230706194022.2485195-2-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/6/23 21:40, John Allen wrote:
>       case 0x80000007:
>           *eax = 0;
> -        *ebx = 0;
> +        *ebx = env->features[FEAT_8000_0007_EBX] | CPUID_8000_0007_EBX_SUCCOR;
>           *ecx = 0;
>           *edx = env->features[FEAT_8000_0007_EDX];
>           break;

I agree that it needs no hypervisor support, but Babu is right that you 
cannot add it unconditionally (especially not on Intel processors).

You can special case CPUID_8000_0007_EBX_SUCCOR in 
kvm_arch_get_supported_cpuid() so that it is added even on old kernels. 
There are already several such cases.  Adding it to KVM is nice to have 
anyway, so please send a patch for that.

Also, the patch does not compile (probably you missed a prerequisite) as 
it lacks all the rigamarole that is needed to add FEAT_8000_0007_EBX.

Paolo


