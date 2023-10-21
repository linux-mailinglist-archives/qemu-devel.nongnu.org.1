Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7640A7D1BB5
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 10:05:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu6y5-0006Tu-Go; Sat, 21 Oct 2023 04:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qu6y3-0006TX-0O
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 04:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qu6y1-0001l7-Iy
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 04:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697875456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k48Qb80QktImhNqMCkZvGAlOIJx5ZsXvpTMhvMyjHXM=;
 b=XDL6gwqmbmRkQz41o6dmTFaS8U1YwIskevnMYw8Kp20cad6u87j7Jy8BFkjUVpTzK2mUBT
 m4DoeXhj5vbeWq2xoKnrhG00O3HYg0v5x/DyG/8ywW0uBbcXxHg7ZoRIbKQl95n1fbiqAI
 oGAFY1PPCvCWaae7GWGlopVZISIynLw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-LgXr2KHSOumwGeeyZjbLUA-1; Sat, 21 Oct 2023 04:04:09 -0400
X-MC-Unique: LgXr2KHSOumwGeeyZjbLUA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae7663e604so93350566b.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 01:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697875449; x=1698480249;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k48Qb80QktImhNqMCkZvGAlOIJx5ZsXvpTMhvMyjHXM=;
 b=hO32xzuikONS72Ep+PbKbV5yRicvs30iWZ1L43UQgZfdbR7bnr5NtOpWzrIXpbo6rs
 KgitO9hLzaMrAgGiStVBJXr6OYu6EJMBFMSBSj/+Yao4PpXhibfoRGA4glpHIopxNn4u
 kFQevFnpTqYwhFoa1Smd/21G9ITxkiCZYySlEstBpbVD8RLrToJYUnA2PTYovz4WtEGD
 GFk51aj3HorSG1favXYmCwXSK32s/O8r4ENxMhMhAFb05AlXuP3T42qmgOWb6So+0zf1
 rpqUCO/3fLfsxX4GU7rgZXaHVBm7oaMGdg+1gyT1QDS8yG87E2/pvSO3h5tloB9yO0ed
 4bbQ==
X-Gm-Message-State: AOJu0YxNlMxMK5uneitv7FapInUJfQZCVQCPNUxqvcwTeT4LqORubqQG
 gxYvw6HQRmjhf9Lzyo1udyPyi59kVQPAqboUIQYic58X92Ukw86Pz9YbVZxMKkY9R2EsDGwe217
 CqvKSGP9yV8/8fnc=
X-Received: by 2002:a17:906:fe46:b0:9b2:b7f2:bc7b with SMTP id
 wz6-20020a170906fe4600b009b2b7f2bc7bmr2698064ejb.37.1697875448916; 
 Sat, 21 Oct 2023 01:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsgdPMc6+Bk6J+DiUjfYwW8hHEq5phSt9kW+0BC1X4yNVliexarzZe0wEiytsYjxyN/lrNZQ==
X-Received: by 2002:a17:906:fe46:b0:9b2:b7f2:bc7b with SMTP id
 wz6-20020a170906fe4600b009b2b7f2bc7bmr2698054ejb.37.1697875448603; 
 Sat, 21 Oct 2023 01:04:08 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe?
 ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.googlemail.com with ESMTPSA id
 c11-20020a170906340b00b009be23a040cfsm3069197ejb.40.2023.10.21.01.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 01:04:08 -0700 (PDT)
Message-ID: <6560b73c-7765-47bc-a1e4-19935b5b32b0@redhat.com>
Date: Sat, 21 Oct 2023 10:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpu/cpuid: check CPUID_PAE to determine 36 bit processor
 address space
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, david@redhat.com
Cc: mst@redhat.com, richard.henderson@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org
References: <20230912120650.371781-1-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20230912120650.371781-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/12/23 14:06, Ani Sinha wrote:
> PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on the
> guest processor and set phys_bits to 36 if PAE feature is set. This is in
> addition to checking the presence of PSE36 CPUID feature for setting 36 bit
> phys_bits.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Note: Not sure what tests I should be running in order to make sure I am
> not breaking any guest OSes. Usual qtests pass.

Queued, thanks.

Paolo

> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 24ee67b42d..f3a5c99117 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7375,7 +7375,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>               return;
>           }
>   
> -        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
> +        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
>               cpu->phys_bits = 36;
>           } else {
>               cpu->phys_bits = 32;


